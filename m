Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E3E36654D
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752705; cv=pass; b=ExbTUfLgpKP9LNMTbJW03NagCfXcJABlgIEf+Q+m5ZdkjVkq538KkJyvioQxRjtTObpgTin5xDJr1xzfnHAM5KcCoJcyIRzNT4rgNUzqTJfzaQhCAWakSzD0V7zH/WFDY6dPTzanMPR/uSSOL6boF4PvcPMR3xBymSs0radwew8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752705; c=relaxed/simple;
	bh=csVxpwtC/d4U7xVWcqeRVpt9eUu7/erqA8rmZdQV/K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diF72DUdQ1MNw5qKJ5koysulWXBYFT+vjGMpkhUF9sGwpbDnbhonc5ri9f7LxxHMqw5iiu3FQoLpwX2LoPBwBA+pQXFX5owlHe/Cbv9vQZX7AAhtdNtpQ1u4Z65TYmHjz25Fc1QnlIpneZrYVIBgWweLfPTd9S4oGvhCX4Zosww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L07GbKze; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L07GbKze"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45f015a3259so3488722b6e.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 15:18:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772752703; cv=none;
        d=google.com; s=arc-20240605;
        b=Y3Pqp3M9aWqC+C3lcJWLGoaTIsVTlJy+3asLLBI7II48ELDoH4f3VfqrTMO83tdPI5
         QzvadmK0sLifNiJhT7fVqVmLwfLpKmijv/TXhDQEQgJiNWGGliA/t+i0oXDpCdTK0iG8
         tCedFwgCwz+ZyU/5nJKPDsG2x1gdj/gsvLv1lBheodUv5mpind0zgcTVdTnAcl/o6ZZQ
         v9t0NpWlLgVwoXDBOrOCbXqr7IlZOHYl6PrwDs5/nwOrJPi3n8l/a4K5QZFpb7JxZ10D
         hCV8EsfpIuS0jYjbhMO4OUxegPVO6515jaLDls7dDN1NdYo6tfPJBtbr/1ySKxCqf9Gl
         0UQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D09eyc1pAL/fhBTdZtv9AcnhIfchv+j+R0FpA2YUvjU=;
        fh=g5BSHSkfG2U7m/p2p8OgcJkygM7fmNPSpQr5IWGN6k0=;
        b=P2ZlcalNXGes1XKZZ4eQ9tsa93fwnZCZgN3kNxRbltmjMC5f+Ralgl97+e0HUnk9A4
         as3UBM9BVACL7R1Px4njwxPiHsOptdWLLrHCkZgpNcU53Gt+QvbU/l8a0AJXZnx5+SdC
         SKddN9CzkcY/n6lJ2ycVP0QBh/RfLlep6HRpkDiBJA6CWhKATZutKF0DLuceGRy3zluL
         NQROJt0F2FU2WTlC2qVIVOSXUcth0bvVEYBX8FM0ueovAoOmtyphQ2vwmwawefpIh/f+
         dv7oY0onzkguLDZTz8r3KI7GYhjK6Xs/Eh63fnkB9hIIArAsduEwpVoHL75X8hgZl3O0
         Yinw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772752703; x=1773357503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D09eyc1pAL/fhBTdZtv9AcnhIfchv+j+R0FpA2YUvjU=;
        b=L07GbKzeGTa5Egq0WFpjzvrv8Zrz3rY06OTI9+Jzf9mb36LSx/xMWGe+JIudfuQiAP
         qA0iEZqlFIAKSl0sv+dya8qAeLmDvzQivYrfKHH6zuwwdqjemTqfRHBvl7ClUGEk9Z+m
         xlT0/f/TyC0oMVs8seY1hDsNZzCoBy7mSThwCorduGsEhKCWsL5XrvUbYBIkboKFvRrz
         MV+ZdvGMGvzUxqMh39aRlH3Fn0k758ux6x4EAOUGH53n4m/+aha9ySa3Vd0cURBnyMeg
         SybzJSX7hhhamvCKbyO4E7vlztD8Qon/RjqfonqACJ4/qaUDw7o6ORQauxPapNHuu954
         V/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772752703; x=1773357503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D09eyc1pAL/fhBTdZtv9AcnhIfchv+j+R0FpA2YUvjU=;
        b=IoS+TpIbvWxUNxFnTMYgS6RU0EM77bdwZEc2TekYNtnwgBenXVCDoK4mKBZ9DSYW3+
         BMA94aaOztLqs4vG7whedmcu06KLlp7W20BfaTxAQtUvA68EtoJwv1w8FeNDAz+o/Ku+
         OxHJwXodylNsMhXvUCZ7RfxID3pub+eWOV4R5lF5ZS1EbhrcXsC8JMwQ4tUqevA9Byni
         E/92mG2v5LMfo31mlLVzsbRjJySkFa3NnYmsjAAOwq9MHdSm82N1rHv1j4ggxJr07o/D
         Di+Y++3lvl/HAFaRw5h4Fy+wW9UpYOjaY4VHQVklOVkgIousRs9+A/eJp6zw9NxYTCmA
         X5dw==
X-Forwarded-Encrypted: i=1; AJvYcCXLTNF5BHgs15kBo5R9mjEfnqA644NtrbufZjpsxhkJFuHgPEzQWD+6jpuqcp7Yi4DBrek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzHVaG9twsF/EBAFxZKylnDmCic+Lx2lPFYlhXnsE54xGF770q
	vHhZH3TIRPB6AYBy/9IXisNvl27xeMQ563cqKAmePwnabFEm0LVyBTKpLVADuZpcVONuLtRJrns
	yPsz112Uldwfv/B5aVZi7vja/zhPXlto=
X-Gm-Gg: ATEYQzxyy5wfsxaTiBBtNq1rnHCCqVHCuOXBKBHi3atau+rP4rRZi6E4yN8Qt/zu57+
	0G/LOLdKmQFqp+K71sWJuZ8LC8A0YfEcUphuvMoi/p1IatJ0KPrgVFWFgHcmiM3fSkpy8Z0jMNP
	P3O7RU1oSYHPJXDkI/zIe6iuk2B9rx6l94riOt4seblMtGluNj5v2p/OkKyRPO2uB47sQQAlr0O
	WQ3TBYqDOKHQF+vfBfk2TY6v4Y2OUl+NgZubKf4mG+sC+S/2QvAJ45JGsuCtARhGnDXdUVnFWPd
	PJ4Zkw==
X-Received: by 2002:a05:6820:4987:b0:67a:2305:5e4f with SMTP id
 006d021491bc7-67b9bc6c990mr162105eaf.13.1772752703131; Thu, 05 Mar 2026
 15:18:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305230315.GA2354983@coredump.intra.peff.net> <20260305230854.GA2901305@coredump.intra.peff.net>
In-Reply-To: <20260305230854.GA2901305@coredump.intra.peff.net>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Thu, 5 Mar 2026 15:18:12 -0800
X-Gm-Features: AaiRm52PopAySBEy623wWVlGbynUx2qzHfZkRyRgYjL1YdE8pXrMR8--7l0oHQo
Message-ID: <CA+P7+xqaCtqTwa3FTCkXyAVt0wX=EW_T1fr_u84w9Dm8XhJBow@mail.gmail.com>
Subject: Re: [PATCH 1/4] check_connected(): delay opening new_pack
To: Jeff King <peff@peff.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 3:08=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> In check_connected(), if the transport tells us we got a single packfile
> that has already been verified as self-contained and connected, then we
> can skip checking connectivity for any tips that are mentioned in that
> pack. This goes back to c6807a40dc (clone: open a shortcut for
> connectivity check, 2013-05-26).
>
> We don't need to open that pack until we are about to start sending oids
> to our child rev-list process, since that's when we check whether they
> are in the self-contained pack. Let's push the opening of that pack
> further down in the function. That saves us from having to clean it up
> when we leave the function early (and by the time have opened the
> rev-list process, we never leave the function early, since we have to
> clean up the child process).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> One thing I noticed here is that for a clone with a single
> self-contained pack, we could probably skip running rev-list entirely. I
> don't know if it matters much, though, as a noop rev-list process is not
> that expensive compared to the cost of a clone. And in the worst case,
> it would involve calling find_pack_entry() on each proposed ref tip an
> extra time only to find that at least one does need to be sent. Though
> that is also not very expensive.
>
> I left it out of this series, though it would involve moving the
> new_pack opening up above the start_command() invocation again.
>
> I also wondered if this whole thing out to be written to avoid a one-off
> packed_git in the first place, like:
>
>   - call reprepare_packed_git() to re-scan objects/pack
>
>   - find the pack by name in the packed_git list
>
>   - don't clean it up; it's owned by the repository struct now
>
> But that's a somewhat bigger change, and I'm not sure it really buys us
> that much.

I agree, this seems like the best low hanging fruit improvement to
avoid the unnecessary cleanup.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>
>  connected.c | 33 +++++++++++++++------------------
>  1 file changed, 15 insertions(+), 18 deletions(-)
>
> diff --git a/connected.c b/connected.c
> index 79403108dd..530357de54 100644
> --- a/connected.c
> +++ b/connected.c
> @@ -45,20 +45,6 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>                 return err;
>         }
>
> -       if (transport && transport->smart_options &&
> -           transport->smart_options->self_contained_and_connected &&
> -           transport->pack_lockfiles.nr =3D=3D 1 &&
> -           strip_suffix(transport->pack_lockfiles.items[0].string,
> -                        ".keep", &base_len)) {
> -               struct strbuf idx_file =3D STRBUF_INIT;
> -               strbuf_add(&idx_file, transport->pack_lockfiles.items[0].=
string,
> -                          base_len);
> -               strbuf_addstr(&idx_file, ".idx");
> -               new_pack =3D add_packed_git(the_repository, idx_file.buf,
> -                                         idx_file.len, 1);
> -               strbuf_release(&idx_file);
> -       }
> -
>         if (repo_has_promisor_remote(the_repository)) {
>                 /*
>                  * For partial clones, we don't want to have to do a regu=
lar
> @@ -90,7 +76,6 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
>  promisor_pack_found:
>                         ;
>                 } while ((oid =3D fn(cb_data)) !=3D NULL);
> -               free(new_pack);
>                 return 0;
>         }
>
> @@ -127,15 +112,27 @@ int check_connected(oid_iterate_fn fn, void *cb_dat=
a,
>         else
>                 rev_list.no_stderr =3D opt->quiet;
>
> -       if (start_command(&rev_list)) {
> -               free(new_pack);
> +       if (start_command(&rev_list))
>                 return error(_("Could not run 'git rev-list'"));
> -       }
>
>         sigchain_push(SIGPIPE, SIG_IGN);
>
>         rev_list_in =3D xfdopen(rev_list.in, "w");
>
> +       if (transport && transport->smart_options &&
> +           transport->smart_options->self_contained_and_connected &&
> +           transport->pack_lockfiles.nr =3D=3D 1 &&
> +           strip_suffix(transport->pack_lockfiles.items[0].string,
> +                        ".keep", &base_len)) {
> +               struct strbuf idx_file =3D STRBUF_INIT;
> +               strbuf_add(&idx_file, transport->pack_lockfiles.items[0].=
string,
> +                          base_len);
> +               strbuf_addstr(&idx_file, ".idx");
> +               new_pack =3D add_packed_git(the_repository, idx_file.buf,
> +                                         idx_file.len, 1);
> +               strbuf_release(&idx_file);
> +       }
> +
>         do {
>                 /*
>                  * If index-pack already checked that:
> --
> 2.53.0.786.g466665faa3
>
>
