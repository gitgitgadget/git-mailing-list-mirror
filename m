Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A8049B1FC
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150008; cv=pass; b=a7HEa5jQtZLVwC6M6KC8VHTNKlM54jc/gtcN42oc+u0l8DCRcFfoKLfeAVc9XrNTCgBi+HNLMYuxIzdoy6db90Y8K8XMF/KLgpxm4tkSHXzv66X3Os6kyt4LvAfebj/Qq12RQ7IFsLFGSBPO6vrbJQukPv6Rm+EAESHaLzu9fQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150008; c=relaxed/simple;
	bh=FI7kk/FqoTBH4MMejNNECalm8uvuL/90bGtaMOz7ki4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sq7qH7gYlJdKP/1+tFdMxqAaQDAiDcO9lSoggkD2k6TIH/+UtxOm6g4lvKq57Rvb7jAWQQmawJBZVvSW+cPQojRfxRhGIEM5eeNiZGtNVdS0fBh0/UUfwKlCK/05CSIg6dYH0+5J1vrj87XoUvzfiKAV3a7hJZ2YpsvbDXP4Csk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpgJ2q5a; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpgJ2q5a"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc9ab650so177160fac.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 11:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789150005; cv=none;
        d=google.com; s=arc-20260327;
        b=hmkeL899pBiZZqrLZs0Fi2eVaST2xbZ4p8RYTk0pSnpj9Al31W1RmsSguna5lgqVRs
         IeLbuwGBNg/Xp9qKj7NGgnVUX7OVi27XlHsk4byxQl2AfDEOuwv9i+Q9JR+1Sv7SMVdf
         O1+Szz0fEqiXjVfPT90LBEEDHComq6apkrEyWM37h4QSDCKMlmUdsHxYCsMjUnY+rO3j
         h5oMbYMSMAaP+rXMAA7SdbVH2XyWtJdxlSD/+WTdxpFzLeig5KVitM6ZklOUTCFZ16Uf
         J1ftXvwrzjQZWGDOcB5NIg1yiVNdLznuImV/JLPpHWd0DQFc++XTKtXXVWKy5G0f11eK
         3ABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d+6K/jk+gX273yF7kKVV7gf63M6eDEfrENxzOdIXKa0=;
        fh=iVZ9atAsjbnannISrByOvuVsVNjnlACtbr6yARnVfN0=;
        b=CBAPCaHdqCvoM8a+kTd8nT9w6zx4U3DIrT27ZFx/JrNHwsVsEEm/dOj1EznejWaUVW
         ZskYnTHc5MYCWmIhBg+rByBsyHe6JisFSyCIHI36ZQL4kTopiLlEwAaQJK7rvhaK4fvT
         wQWZbUjqq9zeDfSsOF9Rltoa7/0by4Or6dnx4ha0Wn6CQjRPz6CyHDD8cb9XMLX9q9U5
         //EaybLGHib7Jc0ZIEjNA8fFju0efVFILlkEJLQQO3ts90TCejfwJPMreYkxfPjoEOK5
         R8gwEw807/fKXSH5HXJUd/DulqlgHQWC/4bzACdDiDJbPunQ5OnYNAOhVy7PrBTiOTLV
         OW2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789150005; x=1789754805; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d+6K/jk+gX273yF7kKVV7gf63M6eDEfrENxzOdIXKa0=;
        b=JpgJ2q5aRJdcrjDa4GYYywYriixrz5QKFgDpTOHPtaM44KtPzMPcrO32j3BZXS4T5T
         wrvcqAO+vpfJq5MlbHNZAoQ3J5cJcPpshZuL9X/3o9ZOM7Q12qvSD9mo0/7FwK3xQIkX
         WT1iBHIM1J3pTqew8uhDyqOmifsUBBN6KRZpIJgjdko8N3Ac8mc31J3CgER7vyXvPNhS
         hnrgKQ9soTpuaJ2Ceo2LTrphexXIy9cROnaZoH8ILZb2PTnMb/HfkGyHgxAHlGa3IkHP
         yHuXLs/HlUghvhBd3kiMlcW2lIvx/+m71UxyaD6fSH2AvitpbUKkQ3VdXWDt9XkJy+WI
         mljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150005; x=1789754805;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d+6K/jk+gX273yF7kKVV7gf63M6eDEfrENxzOdIXKa0=;
        b=EBZMn2aIPwUVXkMLBA+1oUS1E9dSsd1t3eZK/0jNBX8aJE/+huuTQTptvPVOeot7B3
         CGgevaXrPADizs0J2iku/m1z4uRGUxlxUxZcOx7jzgByn7jly2c3/iMvNnNyvJqrIAFv
         FkuTHDiN2xQISSwVNIDoGZBU8mt/o2eXoOVs5GjAPvvmeRULSyyHnlbswDeMqnbi+5Fc
         XNMfthBs5qoOWO5g3RbacJlhYBgat6a/Vn2dTEtDFKISkFHrghM/eZ3ne6Dv4t80eFkl
         ueecsQlLET3WPnGKynC3vgv+rOWwZS6BpMFDi1ONn0Sbzxe9VgXTWEVg5UyjELNzdRa2
         6yGw==
X-Forwarded-Encrypted: i=1; AKwUvBw/dxuGQzDhDD/xbc2O93Aox7F9LShoskId0rWJo6Ep/+mllaGRTi5yYjOA5XP2FGarcic=@vger.kernel.org
X-Gm-Message-State: AFuF++lg1Og16wgtsWybITtND+u8zTnt3RTgDczZ5LYaE5/Gd0ORirNa
	LZEbd3sOet/qNKqRMu+QmIOITn0Jy2ba+eRqPYPWweaJSslmyoB9RjMgx+9jVg/1eSavkdj7wtN
	zVA+RAfyOcJCctqI7qZ5+hptxI85+ygE=
X-Gm-Gg: AYBFou0pj6nmi6iuonva3IgU7JihOZ4msEIyKUiS2iB32MKgjbQzU/TuXUNwjtaGG9S
	xzaTApMJMicNKNjzDKEQTyaEePv9joKV4XhiHmqdnYocq3YtAdZy5ijrY497JxhImWRsqSgir5A
	KZvQCt6lYerUDIcnnY8FdBeKdb+aNLeMWyU1m0bU8QdwRPWiXp9mmYpP94CywcttBJhH+SW/fAD
	hz5htjj27nzp1dmaCV1xL53/RS8lpqJSJGcdqDdm7ERQuvxarIu3fb6s3EDKVsOlOCjeluBBBkH
	QNLZjgZ3CfREl2SteYd9C/nJHo486jCjfBfFRc+NmWi5V0a9uumU/4U59PB2wl0t20TZJCZcVe9
	enF+T7n8FkrcmV2YmgbvCqx18s6CZmRzWw6URsFQG9bdlijnBbgp7FearFIvUODPrUl1h4aHc
X-Received: by 2002:a05:6820:c3d7:b0:6b7:46fa:16ae with SMTP id
 006d021491bc7-6c0bde62839mr2782323eaf.67.1789150005477; Fri, 11 Sep 2026
 11:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911171044.GA1609692@coredump.intra.peff.net> <20260911171124.GA1610200@coredump.intra.peff.net>
In-Reply-To: <20260911171124.GA1610200@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 11 Sep 2026 11:06:33 -0700
X-Gm-Features: AcwNN1WI0Fxa2p8au_Ihqc-b8SR24eD9zNdwOcKVavRs5dacxB7m8HXDyJBPep0
Message-ID: <CABPp-BG9Hkc7i_JxAbYfyzu+b4Mc_pZUr0jJF=vY0jHSARpHzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] merge-ll: use strbuf to read back external merge result
To: Jeff King <peff@peff.net>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, git@vger.kernel.org, 
	Jean Delvare <jdelvare@suse.de>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 10:11=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> After the external merge runs, we read the file back into a heap buffer.
> This ancient code does it by hand, but these days we can make the code
> shorter and less error prone by using strbuf_read_file().
>
> It's not quite a one-liner replacement, because we have to copy the
> pointer and size into an mmbuffer_t. Two things to note there:
>
>   1. We can't just pass result->size to strbuf_detach(), since the
>      former uses long instead of size_t (something that we'd ideally fix
>      in the long run, but is way out of scope here).
>
>   2. We can leave result untouched on error; we zero it at the top of
>      the function (confusingly we may still return LL_MERGE_OK and a
>      NULL result if we hit an I/O error, but that is how the function
>      has always behaved, and callers know to check for NULL).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Not strictly needed for the rest of the series, but it felt like a
> cleanup worth doing, and it conflicts textually.
>
>  merge-ll.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/merge-ll.c b/merge-ll.c
> index ef5287dee8..5b6af15e23 100644
> --- a/merge-ll.c
> +++ b/merge-ll.c
> @@ -201,8 +201,8 @@ static enum ll_merge_result ll_ext_merge(const struct=
 ll_merge_driver *fn,
>         struct strbuf cmd =3D STRBUF_INIT;
>         const char *format =3D fn->cmdline;
>         struct child_process child =3D CHILD_PROCESS_INIT;
> -       int status, fd, i;
> -       struct stat st;
> +       int status, i;
> +       struct strbuf result_buf =3D STRBUF_INIT;
>         enum ll_merge_result ret;
>         assert(opts);
>
> @@ -241,20 +241,12 @@ static enum ll_merge_result ll_ext_merge(const stru=
ct ll_merge_driver *fn,
>         child.use_shell =3D 1;
>         strvec_push(&child.args, cmd.buf);
>         status =3D run_command(&child);
> -       fd =3D open(temp[1], O_RDONLY);
> -       if (fd < 0)
> -               goto bad;
> -       if (fstat(fd, &st))
> -               goto close_bad;
> -       result->size =3D st.st_size;
> -       result->ptr =3D xmallocz(result->size);
> -       if (read_in_full(fd, result->ptr, result->size) !=3D result->size=
) {
> -               FREE_AND_NULL(result->ptr);
> -               result->size =3D 0;
> +
> +       if (strbuf_read_file(&result_buf, temp[1], 0) >=3D 0) {
> +               result->size =3D result_buf.len;
> +               result->ptr =3D strbuf_detach(&result_buf, NULL);

I know the type mismatch is pre-existing, but the order makes the new
behavior different. On LLP64, assuming the usual wraparound, a result
of LONG_MAX + 101  narrows to the negative value  LONG_MIN + 100 .

The old code narrows before  xmallocz() , so it requests an impossibly
large allocation and dies. The new code allocates the actual buffer
first, then records a negative size; callers converting that size back
to size_t could read past the allocation.

Would a simple fail-fast make sense?

if (result_buf.len > LONG_MAX)
        die(_("external merge result is too large"));

>         }
> - close_bad:
> -       close(fd);
> - bad:
> +
>         for (i =3D 0; i < 3; i++)
>                 unlink_or_warn(temp[i]);
>         strbuf_release(&cmd);
> --
> 2.56.0.rc0.314.g7a874b6915

Otherwise, looks nice.
