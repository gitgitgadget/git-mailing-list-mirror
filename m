Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4923E2AE6D
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 05:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749707463; cv=none; b=PAhqEiH3Ze4NiEKeCUvolo5Ylp15Nrqnt9rnLOXQ0x7jE9uMTZAJtfkv/aUwu1L8fkyzCZnM7fo1For3k5/8T2c8HzjKn/CDKabv3lC+jxCb9a6zyXT6sOaG2I5jYu97jk/I37GaE7rSGwSD66qfBLcbKkck2SWYS3RVtwI1VWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749707463; c=relaxed/simple;
	bh=VLbc4r9fH35M6rZOcYvwmtzCa3YgJ/TuZbVXwPZWQNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYDbVFUWlgg0f9eoC6LfrGdoioc3i9m1j3E3oTadorv96KmP/4r/2Upl8KUG9Unq0RaqVddmlOXFlo4LQvzXJiqotV5CDl7R3NxlvWrWNbyckOLO4esQFdZB2nwa+WM5YveMKHbEQeL/ozgM8sG9cTQOEEP1QzUV2Sz8MEWIs1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d38dff7056so11911985a.3
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 22:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749707460; x=1750312260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKCby96E1UXNP7kVd8jy17H1sax4Z3R+vquxjASvuLU=;
        b=JQ8b7RM8Th3uv1maXa0joBZEBfev3+hD8vOZqZW6Hn392lPpNeUfBEZem5eS3r7LZz
         lcPDE0HlvNXGWcAqLKBEh42HoLgO3dnLiaKxD3fWIidRcABp4q0JPsbeheM2GdCynqIG
         EE961AycMpz6IIImdNGTTDpwPoZtdfv8yqEeR7hcuVK5e3g/BEGpYHjjBqrzVxoHQ0hH
         pOQgUwkNHnN9V/7zqMrzB/JFbfnf7YpUPLNF26JVn4UblNjwPDQQe15iCPdT8T37r69n
         ETJoFtV3JUz2MCRzIq81M1ASLCAIVZ/0F4RKD/ObslqnWn/VXXkMgHnl7khLghZsF8OX
         Tg+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUH9NWpmeXjgjQLvYagJgAyy/ldMknts/iahOhBDdvu/c2d02o2ackaXjkKTo7+gMzlUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQyVqNY7UN2rpiM4YQK0p2je8g5gu30mEokryUs1KTr63nan3
	+CXrjLVxuSnv7sSz8L46NdTWPrSBPjdg3V3ivFv7aZkK+cCi8XIjRfnmYhsdtyvFdqxVe4acDXN
	g9dNA/HI4KuzzHQN4HTf1D5rUa3tDrds=
X-Gm-Gg: ASbGncs6agLbwBXJBrPW9c9lQB9qVKvbK/eGxa3g7Zus9O4T29bbKexgZiFg1YPDzn5
	t8wV1ofULOBeXZRQvVWxuDE3Qu/OM8+3kCtJ3Bq+3Sj0cYemyp3IT0YQNtjISasnqZqzGJspBqM
	c89E22J9buPzR4+xlIx1KRBMWrYsHAmK3HqaIzvFGrRw==
X-Google-Smtp-Source: AGHT+IFQjWh+U2yOSgirSRSJK+nMCcBV7nnoBrdRQi+/TfLRE1ba4pbdCTXcH6Cjy3A+1Ndh+dxS5YPE8gftJ18M2og=
X-Received: by 2002:a05:6214:1c45:b0:6f7:d0b9:793b with SMTP id
 6a1803df08f44-6fb2c37c8aamr34201646d6.8.1749707459932; Wed, 11 Jun 2025
 22:50:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <09f954b8-d9c3-418f-ad4b-9cb9b063f4ae@comstyle.com> <xmqqo6utfvxu.fsf@gitster.g>
In-Reply-To: <xmqqo6utfvxu.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 12 Jun 2025 01:50:48 -0400
X-Gm-Features: AX0GCFu8bV994t4_rrM5WaEkpjfbXjU_OFB7HP3CLfVd7WZr2weJ5qbpSZ_3XM8
Message-ID: <CAPig+cROcMt1crKjvqcetFNGdE4ywmD1+NO+q+MnDzctx8ewag@mail.gmail.com>
Subject: Re: Solaris sed
To: Junio C Hamano <gitster@pobox.com>
Cc: Brad Smith <brad@comstyle.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 12:05=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Brad Smith <brad@comstyle.com> writes:
> > Building on Solaris I noticed the following two issues with Solaris sed=
.
> >     GEN version-def.h
> > sed: Missing newline at end of file standard input.
>
> Perhaps it is this input line it is complaining about.  sed works on
> text files, and a file that ends in incomplete line was not quite
> text.
>
> -REPLACED=3D$(printf "%s" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VERSION=
|" \
> +REPLACED=3D$(printf "%s\n" "$INPUT" | sed -e "s|@GIT_VERSION@|$GIT_VERSI=
ON|" \
>         -e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
>         -e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
>         -e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \

It's curious that this is using:

    printf "%s" "$foo"`

in the first place. Had it used the simpler:

    echo "$foo"

this sort of problem (forgetting the "\n") would never have occurred.

In fact, it seems that f6a2efdc9b (GIT-VERSION-GEN: allow running
without input and output files, 2025-01-22), which introduced this
problem, also introduced a few similar cases in which the `printf
"%s\n"` idiom was employed when a simple `echo` would have sufficed.
