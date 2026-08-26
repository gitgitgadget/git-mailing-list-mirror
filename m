Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA2286D70
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787760432; cv=pass; b=G/cc55GUpmPjbJkeeZnQJ5dOm462jOfTt65r/nipAB0QxzQ1TMb/BbwnXJbuiakLu3q+SPXBK9Is+dx+iGSUWUDzwV9IOpDi9PYCQ5CSbloiG4VP0XMkZLFP7YQsNBtqClqTz9psZ+JaHbGHS4IYpFFcxOzsxkz4Vw3MVdlSo9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787760432; c=relaxed/simple;
	bh=G10nyjXVPW7lagzkUXqJtc1FDTln//D10IrP9BkOYQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LA90uXpBTmyVNeCG5b55WnVbXBwj/BKd5EwSvHHTgDJHUkk6OzaGHe1J347nUtlUvWZoqpq7G/mvVsI03N8i5XgwGQhX90svLbk8YeZ9KRXFyLdSSbXE7iOz1BgYRhs0Mj3UFANd1h0jkkTqa1uHgUqU+5ssZ9L1Xo+9SdH7fLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjNuMN9e; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjNuMN9e"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7f3ece23165so1296640a34.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 09:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787760429; cv=none;
        d=google.com; s=arc-20260327;
        b=MiubEKB6nPFrLH7kMk61FB9pAp8Olxx2OvJL+GuAN+RbvlZrf/VbnncQvX8RA19ON0
         ggc4X9ozsGd4kwLlvV3bO3/u+RMSevYYjCxoZ2+SAhUBu+30RQJ3MLt3OId3dLlUe4fr
         iPpb29EOwP/P3UV8XHJm2miPcpdOqbDMABJ4zmQwFX7/XoQMg2dXYbOKgl0YKEb9XCcY
         bzfD6vUQD8n7uH7S93PNG/0CqZWKoBHYW/rFC0ccZN/4Q7TQ3glJbeI752IbJixdeGYQ
         Zxfwza0//IFBIc2iEl68gixdox4sWScsCNUiNpt1qd77UD97xLJsOT//WCP4rITuWDYo
         pLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6oAbEWjSVsXJOoDvTezpTv7G71YivUTT9egICamyF18=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=AHjjwS1GsfF8acdoW4rPB/GAwIOmJnKp+SV3SiAn/mQxAMv8f1B9WqnuG5hQ9Ibt5x
         5E9IvSui/dOuH54Vjy+DyYQ8UCLZFbyT9vOU34Aa0ymd+odSUkWQ0ZYS+qCv7V06iU5x
         Uxt+xlJ1J76Z1mbxEKHSXCxcBUOydyIi93SW8WmYOmtb5XH9HQcMI3q3bRHIwTKWbcsF
         JmvjZm1aNH5L5N0QvWk+vzQ8Vsj3bk2WVDnwFxnE0i8f/DuIdKM+ZJGTVPZCsirYrmqb
         bOKblUtMI+5s0WuKPFqro1hBI4QWS5d8Z4+gny8qvlWglW7VzIXnCO+wFjYHQbDj13tI
         qPDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787760429; x=1788365229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6oAbEWjSVsXJOoDvTezpTv7G71YivUTT9egICamyF18=;
        b=CjNuMN9e87+aLuY7TA/DrCujkYrIsywhuCC179jQQzkwXOqhbZMGuTgLja4Eu/oQO9
         +HTqAnodyZYbUV19ynm1P/K6TpX1E/e3CATL3YGgKO1wBAhtqPBnQWN6zJc1GpujGAb0
         d9kDlT8Uh1jJPJORNjB12Tr6IEHdI9iiesDrr9CryD5iV3u8emAXBcNg/RFLwa/H9HBp
         4svgxwE8T3ntGCQK6UEV6W2SIBi2k/VYNeZfDfH1R8fqT+gcV8vfU7msg+SE1FJcNody
         PSdvNpyx4M8kPsbYe0ZN0NZFW72oK1hg4WcS3En/nKfzaFf+/4Me67mDrPyz6G4HBChs
         zp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787760429; x=1788365229;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6oAbEWjSVsXJOoDvTezpTv7G71YivUTT9egICamyF18=;
        b=UH4yZK0FsDHsDimEC6jgI2lYen4hNyd9Ikkh0FqrbeMlbTsn3SYNA+dGPhOoXoSxFR
         GwSDD41LQ1fVCxaZKvyWnHgLKBuJwZWY4H0HKinKa0EM25vKyPOzKOV/WX1mgFdYmk44
         1XJZJSflCKiRKDl6GheFh/IRggyb8kgACRnsTuASpAvqqIYuhikpCBZrBlK5uh9yOse1
         cNLxLb5W1cnvfEhPHOS0XUnU0tBz2Sp8CJtBKNEc6z0YE+YkZuiA0jvwg2XZXg9cx+pw
         bAlx9iw/ONRSS/f+bsTpej76UkWCBBwlDKm0CSSVdEcH8UnQNz2+t7Oxux7EMQnfhFlg
         cIAw==
X-Gm-Message-State: AFuF++lgKWDqd6+eaPOEmtdVjOuatkxZSCf8s3Iou8K9+0NfBnf5CbAr
	Rn1E9xdhXzRAqMqJjY3AqK6ymoKUSEgGrBfkvoArAyqEKVXsjKnd9bU4Lrt39B8q+/eKL4GdLr6
	ooqRAkZHTYkDNa/snathrU7lQXEhxg6w=
X-Gm-Gg: AR+sD10CoFHpW48+ccyCrqDHCwMvv+6fkilloehu9P0/08KHwHaRWP4Bl05Fvth7TI3
	mKpsdElj5qsjbcpj1uNbQPBu3P6NEIuAZYuRP6cQ/esig/oQljkWkaEAFiHuX5IRIgE/wPn75xM
	sIw7fdmhDFGEwfFgc7LbaeJfOGKqmYzYokShulF2tdk7LWy1k8J0lftOX8kckRnP/37Oe+rp1Gr
	ci0n6lxlbbohzx9wL80SkWzfdUS20MmcD3/OIco7YPdNzDg9l1/Eob3Mgg+KenX04q9GHKummkU
	DIPAYitzZj+kOwDJykOXdPwklmLbCp5/lsemUOivEHSuFjQaApnd0EDDqbBwQnTW41Mot5+yjMb
	jucJdMh2Xa7QFzhVSAQYTooGibspi1xhuyWWSbgJp206LkdGndCfi4emwXWpDabIhRK+hC/w1mQ
	==
X-Received: by 2002:a05:6830:e13:b0:7f4:d1aa:2f32 with SMTP id
 46e09a7af769-7f4d1aa2fd3mr2098903a34.11.1787760429512; Wed, 26 Aug 2026
 09:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqo6epj6is.fsf@gitster.g>
In-Reply-To: <xmqqo6epj6is.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Wed, 26 Aug 2026 09:06:56 -0700
X-Gm-Features: AcwNN1ULANUAVQyyOranzxjmhC2mAhYBmDSXeRI6LTFHpfe30Ij3gRtU2M7wDbc
Message-ID: <CAC2Qwm+Gg3nhxtwhQjrvrk6Pm_R=XEpAwYxVKqT0Ps9UZ-DAyg@mail.gmail.com>
Subject: Re: [PATCH] you_still_use_that(): reword the instructions
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 7:33=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> diff --git c/usage.c w/usage.c
> index 3f0118ab2a..9933b9911c 100644
> --- c/usage.c
> +++ w/usage.c
> @@ -392,15 +392,13 @@ NORETURN void you_still_use_that(const char *comman=
d_name, const char *hint)
>                 fputs(hint, stderr);
>
>         fprintf(stderr,
> -               _("If you still use this command, here's what you can do:=
\n"
> +               _("If you need a replacement:\n"
>                   "\n"
> -                 "- read https://git-scm.com/docs/BreakingChanges.html\n=
"
> -                 "- check if anyone has discussed this on the mailing\n"
> -                 "  list and if they came up with something that can\n"
> -                 "  help you: https://lore.kernel.org/git/?q=3D%s\n"
> -                 "- send an email to <git@vger.kernel.org> to let us\n"
> -                 "  know that you still use this command and were unable=
\n"
> -                 "  to determine a suitable replacement\n"
> +                 "- Read https://git-scm.com/docs/BreakingChanges.html.\=
n\n"

I noticed there are now two newlines at the end instead of one like before.=
 Same
for the lore link below. Is that intentional?

> +                 "- Check what others on the mailing suggest as a replac=
ement:\n"
> +                 "  https://lore.kernel.org/git/?q=3D%s\n\n"
> +                 "- Send an email to <git@vger.kernel.org> asking for he=
lp, only if\n"
> +                 "  suggestions by others do not work for you.\n"
>                   "\n"),
>                 percent_encoded.buf);
>         strbuf_release(&percent_encoded);
>
