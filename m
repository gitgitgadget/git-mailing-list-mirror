Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D582D7DD9
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134848; cv=pass; b=M+LxGzvGi7RX5gJCK3rgEri3WRXPJexICYnzb0lDhxauWwuqPiP+E0gOjX8DPemc+5DZovzTPy/NV/5TYDQB8ial5RlZIIHMN9Rr2jHkF5mTPrQeYU6z1TH68ashPmZ71TDhnrQq9DrWBo/XT3rY/LM/n5hakOs9Y2LA5WTZU6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134848; c=relaxed/simple;
	bh=K/9UBJDFMSxYAAJc8UmL/w6+29GF56jHP/fOp+f5kXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doHK1G8wVeH5iBwZLhdYpm8U31uptcyyrs3usqbUbphPK4az5riVcEWUU8ET520ShdOf0S6d0cbSFawyE2gjYRtC8eTdG5fmu/X7VFt9VCxMqRt9dwYxpHCkMvWO9pi9K8nGB3WkbR/mBXykBHUNBfPLBYOrq9WlhO8YNCQ9ios=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnJK4ObZ; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnJK4ObZ"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-128cba36eceso1381924c88.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 02:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773134847; cv=none;
        d=google.com; s=arc-20240605;
        b=EdoCqDehXB1faYTwZ7WWUw28kwHgGgqsaAnng6Bwuo88XKGj7uVG/ESFizL5fQzUDx
         SAMStnrsh+1qf6JZgbLr+ACKoQFygN6DBCdVr9sOXMeRJMQ0KtyRQKpqhnvjEofm9QQR
         xjXNU6ESURnK95dtg8ql41JfHt7ZUtSeyDgi8qvDORydqnRQD+tI4ST0uBnpEhzCp5Nr
         LKPbXzb3AE9Puq4Ib9kjMrD3GrRaqAqc1umwgyy+6BqBDFgQ0Lly0Z9JSZ4o5Nev82y5
         cR95E4beNCjtJZ8+b4nhzDI7toV9KLrIQvTNOkKL2ekZnvuyrX98wxpn4RQMv8hWKw3f
         7m+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NXTMKYdFHgl9VaJxERcR4PEf9CgXZ7BYWMS6NshsPco=;
        fh=nVu3zMpebDzg1Ff15F5ywHRoIXsUIo/ckc17zpZE/+M=;
        b=VP85Rr6SOt9wraQ/4DuCcqmRVsk0mJbq1ZITfT9c3Q+PRaYmnNzc5NuEdXaPcfK5+4
         VkD/XLt5Ti+nMnbxjEPphaFdSj8i+KcuUC6+LkLVxESckWV+CNgwkjg+9PozfPDKc+fV
         5YQ5Fnggi8gggWMBy1rKJGvJJOiSwuzEaZkwp1/xKI+eJ9CB12iUxYwGc1eoyz/aeNVc
         by9iIQoIFIh7sCOvps8Nt0BwXHtA6/zPBJI5ECVaTJ90IzDIBSs9i/N8MJdUMYuK/e7a
         uElkoFNWBmceAkClj0/OzPtxTt7t4v7/8wpdSFSWjw8CtBh7lh3Ac1Nux67kXtuWF3bb
         aXxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773134847; x=1773739647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXTMKYdFHgl9VaJxERcR4PEf9CgXZ7BYWMS6NshsPco=;
        b=YnJK4ObZZA5tSRlHEdkxxUDsjbOaQSVjCHrAWG7sq+8KX+p54PhcdhNtOIp1FgWvVA
         9TFtLzcSnfVW7ylegOJwZZFrYihEtViaKZtU+CIycF6MpkpmsnXmPJZM94whelnwb+bc
         PrH23fVGveOEbfw4VGAISq4L3JABsTSzdIXaIMUpmFn/pdEXWM9L/0/ju5WiTP3XsSs3
         lSzRFfzuvu0WKHjCyDXP/xkBxdgWBb1K/oQxqu8WSAH/5S9ZcVcWk/iZp1Ll2Mff0ZS1
         HqDJiFFdkFayvaIQ8BCEVQdqUmO5qHba7NNBkW7k8mDga8uXPSL0LPAGVT6/bxLVWKox
         Ckmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134847; x=1773739647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NXTMKYdFHgl9VaJxERcR4PEf9CgXZ7BYWMS6NshsPco=;
        b=vevJo4G9qJaWumM9ynUDHEehM0a/NZbsvNZZ3Lw1CtpGLbXqFUWY5NSft/HDXV5RJk
         aIsC/wW7HVobwA9whH1MsHzw+2HdWFfCgwVtSNzglnNyh5VqPyfL+dAeOBdw2Qfco2Q5
         8KVPl5bwoS3eTHAI8J4ET++4hLYYH9A8gqHIy9NjEjj4fDCTbHYEQSABDXINmStcHoTV
         txDeAKB99gmEtzJKSbi1r0IQGFDjdbf2HqUKre+ZbjbHUQFUCdbAFD3dQH5Tgten+k4i
         Wf8QhavUtTZ1C3rx3jvvsxouzeVKvgDXWVG82bo6uOUBdce+AySDP5WPc7M84kdoy93E
         JV5Q==
X-Gm-Message-State: AOJu0YxyrfhlQGkS50GZRvTvN4EGKN0fW+0jHP9Ml+SBEMRubQ/zMQ+M
	ShZVQFZcAZYJ5jyluAC3IQFeWzDbswgdMMVpfodgzMhkXpVAjQ06WgWwnEUQ13MJ0gga08LZONr
	x8GXoD6bjHap4a3kwkcte09esv8YwnnI=
X-Gm-Gg: ATEYQzwBYwLgOH3CLbvTbtpOWzgfEE+GT10L+qSJgK207N5tJ6KHidVcGnTBiYftcS1
	UoO0YLhpPz+67ovJmkPtbrPzzOs7/UcceAhZPljbJE7NyP71Av2ifnLLOWiEClV4oCO8cfkq2HD
	+iWxm4jvjf08yKcYbPxgDUC9bL0QBB6hwdfAVghUFyUE85iIsVmm56S8YinSpF7meIwbkwi51jX
	6bijTf1Q0/uojZeN8d10Pe0aRMYHyQVmGoXK4mwjlvyNUKN/9ObJOMBuaqBw6k9oXTCFbbnGEsb
	CXo4XBgqk6o046K7tH+gk35DWolM9/3IYegL95TUdpUDaeiBZEtnDSvoAcrD9hIxwNc5
X-Received: by 2002:a05:7022:5f01:b0:128:cc34:3617 with SMTP id
 a92af1059eb24-128cc343a6cmr2242699c88.21.1773134846518; Tue, 10 Mar 2026
 02:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223194146.3476768-1-jltobler@gmail.com> <20260306205359.1723254-1-jltobler@gmail.com>
 <20260306205359.1723254-4-jltobler@gmail.com>
In-Reply-To: <20260306205359.1723254-4-jltobler@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 10 Mar 2026 10:27:14 +0100
X-Gm-Features: AaiRm52bludTsdAGl6kPRrJ0CSlbJ5zKzVey5bKpiicx2BdU8c9cj9ExQfU03Sg
Message-ID: <CAP8UFD3p84U0FhjGXNqagtDi=Cd3+QBHqGb3_ceWy-tdeLc43g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fast-import: add mode to re-sign invalid commit signatures
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, ps@pks.im, 
	gister@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 9:54=E2=80=AFPM Justin Tobler <jltobler@gmail.com> w=
rote:

> @@ -825,6 +825,9 @@ static void handle_commit(struct commit *commit, stru=
ct rev_info *rev,
>                 case SIGN_STRIP_IF_INVALID:
>                         die(_("'strip-if-invalid' is not a valid mode for=
 "
>                               "git fast-export with --signed-commits=3D<m=
ode>"));
> +               case SIGN_RESIGN_IF_INVALID:

Everywhere in this patch, I think "RE_SIGN" might be more consistent
than "RESIGN" for this name.

> +                       die(_("'re-sign-if-invalid' is not a valid mode f=
or "
> +                             "git fast-export with --signed-commits=3D<m=
ode>"));

[...]

> @@ -2856,15 +2858,52 @@ static void handle_strip_if_invalid(struct strbuf=
 *new_data,
>                 const char *subject;
>                 int subject_len =3D find_commit_subject(msg->buf, &subjec=
t);
>
> -               if (subject_len > 100)
> -                       warning(_("stripping invalid signature for commit=
 '%.100s...'\n"
> -                                 "  allegedly by %s"), subject, signer);
> -               else if (subject_len > 0)
> -                       warning(_("stripping invalid signature for commit=
 '%.*s'\n"
> -                                 "  allegedly by %s"), subject_len, subj=
ect, signer);
> -               else
> -                       warning(_("stripping invalid signature for commit=
\n"
> -                                 "  allegedly by %s"), signer);
> +               if (mode =3D=3D SIGN_STRIP_IF_INVALID) {
> +                       if (subject_len > 100)
> +                               warning(_("stripping invalid signature fo=
r commit '%.100s...'\n"
> +                                         "  allegedly by %s"), subject, =
signer);
> +                       else if (subject_len > 0)
> +                               warning(_("stripping invalid signature fo=
r commit '%.*s'\n"
> +                                         "  allegedly by %s"), subject_l=
en, subject, signer);
> +                       else
> +                               warning(_("stripping invalid signature fo=
r commit\n"
> +                                         "  allegedly by %s"), signer);
> +               } else if (mode =3D=3D SIGN_RESIGN_IF_INVALID) {
> +                       struct strbuf signature =3D STRBUF_INIT;
> +                       struct strbuf payload =3D STRBUF_INIT;
> +
> +                       if (subject_len > 100)
> +                               warning(_("re-signing invalid signature f=
or commit '%.100s...'\n"
> +                                         "  allegedly by %s"), subject, =
signer);
> +                       else if (subject_len > 0)
> +                               warning(_("re-signing invalid signature f=
or commit '%.*s'\n"
> +                                         "  allegedly by %s"), subject_l=
en, subject, signer);
> +                       else
> +                               warning(_("re-signing invalid signature f=
or commit\n"
> +                                         "  allegedly by %s"), signer);

Maybe a helper function could be used to avoid duplicating the warning logi=
c.

> +                       /*
> +                        * NEEDSWORK: To properly support interoperabilit=
y mode
> +                        * when re-signing commit signatures, the commit =
buffer
> +                        * must be provided in both the repository and
> +                        * compatability object formats. As currently

s/compatability/compatibility/

> +                        * implemented, only the repository object format=
 is
> +                        * considered meaning compatability signatures ca=
nnot be

s/compatability/compatibility/

> +                        * generated. Thus, attempting to re-sign commit
> +                        * signatures in interoperability mode is current=
ly
> +                        * unsupported.
> +                        */
> +                       if (the_repository->compat_hash_algo)
> +                               die(_("re-signing signatures in interoper=
ability mode is unsupported"));
> +
> +                       strbuf_addstr(&payload, signature_check.payload);
> +                       if (sign_buffer_with_key(&payload, &signature, si=
gned_commit_keyid))
> +                               die(_("failed to sign commit object"));
> +                       add_header_signature(new_data, &signature, the_ha=
sh_algo);
> +
> +                       strbuf_release(&signature);
> +                       strbuf_release(&payload);
> +               }

Except for these small issues and the few nits in the previous patch,
this looks good to me. Thanks for working on it.
