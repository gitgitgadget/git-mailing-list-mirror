Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8AA3FC2
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 03:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712202846; cv=none; b=pVJdBFO0E4kKj6Fxcg7YRVE/dIx2Dn3gC9DJQhlBb0DMjkWUd1ZFkaAC6iEg2YlMOepaZlNCBm9YuoJVYXOnVhvmkKjz4LXPwL/T2BPAzDQx0EHYlL/C40d9Pj51zagndLz0S2LD460IqlaH2r4Fc/hAiq97GOaY3XK9RY859bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712202846; c=relaxed/simple;
	bh=UjTUN9SGOy+80nJRjt5TWBumAHmeTJPflSJOtFgqWVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJSylSxuKHQRan60BxF5AeU9c8zzC8wBH18xiHV/oP9pFrbsHIaUaHk7PjiVWMjnqqWZCLND2mqZvpe4e57Z6It+IJmgOfwT+8Jzfe3gZ5MZ+ocE7zbzHDSZiL5m/o11O8083WBVUUtleYVqfHN/hZWPl2JXA6G41AvDM1KqZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6+rlS3s; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6+rlS3s"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-479c39b78dbso250965137.2
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 20:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712202843; x=1712807643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOtXoa2s+bxYbPTYWtKmxNs3u/lK1AhzoUWtJw17Yq8=;
        b=h6+rlS3skahGd4niNcgFZv1C8erSAnfJUDKmhcjFZNvAskjfRgcxqxPTKx18ZJI/G+
         mzp/7NNhjN5FwwcpG0JWYEdU0GBQmWMgQ5y6tjjZnNzsZDL/OAR8tWUiZ4TzALUvlgIS
         iPd6Yqcp2DSJijWNIIeoRbfcntECoywSgS00y6RhrhkAMhYGL6XA7mJsxtn6uAy59tri
         eN1Th7zeGpT/JoKJjZxUw95x7r8FiAA77q9hkKlnCbnrRYFcj3oByT1Iw7USm3kfeUo6
         uZWZW+S09paYH3ZwFI3MEvp/l83HnfOgM5szPad8Hressm+yZuv+KUm3tOLLIWsGUh7C
         LtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712202843; x=1712807643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOtXoa2s+bxYbPTYWtKmxNs3u/lK1AhzoUWtJw17Yq8=;
        b=wFTqt8/VCBmw9soeeLtQ+MPqB4e1Fx7lQSlmXPUvm6FUSX+1RiwGeClwlc0FVSeMwl
         QG8TQnpdApY2au5SB2/WddSQuTCYGJSz4i9FX6Z9H917TtP0JqBhLE91xBzep1rgKoTk
         kY91GW4goRPI0AbTAbV2wJVCJanLIZ4d36cKpVYn6SS/r3aNpwWOVo0tFNS7EVvpw7T3
         Vi0f0Isp92pDevjjQAb2wank29E5BTz96bETdpdJ+wDWEzOB1hizGb+2+M5DefO1Qjab
         hYMG4Yu1V93BIOJENmt+q5snBA46ozRjEvriBxp/KW9TTeTQEtXT2V7VCvtqsbLJvklK
         6VmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhlD1awv0spNMtlTm8rR7FOiWE70PIMoozZTECX0jkNAwZWbBmfHCgmn1n3uynx3OgzX1w4CeLD5xcD1nnVHg+SZD5
X-Gm-Message-State: AOJu0YzLc+6SYtJePguwdJ88ijuPx4nXuF3Li7IsZSP4+QRhx4EWP+zc
	WuTyCiNMvYWwNguvGXO3KVeuJNaIT/scUIREcV2c/22b1f2zfkL1j+m7eHILb2HjXHrGyTQXu1z
	kpOK51y8L0KISrRclZKZFO9wZrNM=
X-Google-Smtp-Source: AGHT+IHlFp5Wd4Zocv+ZWQPMjWe/whd1J2mVmIkBF77H4fzVAeZxuk783iBXjrojMqNEnuNz5eYuO8atj0FeeB6txkY=
X-Received: by 2002:a05:6102:3557:b0:472:58d6:af54 with SMTP id
 e23-20020a056102355700b0047258d6af54mr1359481vss.12.1712202843569; Wed, 03
 Apr 2024 20:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1677.git.git.1708317938.gitgitgadget@gmail.com>
 <2c60c4406d4eb1307a32f23604f3ef8e34ad56d6.1708317938.git.gitgitgadget@gmail.com>
 <xmqqil2k5e8u.fsf@gitster.g>
In-Reply-To: <xmqqil2k5e8u.fsf@gitster.g>
From: Philip <philip.c.peterson@gmail.com>
Date: Wed, 3 Apr 2024 23:53:27 -0400
Message-ID: <CAJ6X7_Uc0OdzYToJSs15+vbydraKAB8x4DPj7UsL1PKLzyY0dQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] apply: add unit tests for parse_range and rename to parse_fragment_range
To: Junio C Hamano <gitster@pobox.com>
Cc: Philip Peterson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the tips. I am confused about the change request though:

> Alternatively we could do something like this to make the blast
> radius of this patch smaller.
>
> -static int parse_range(const char *line, int len, int offset, const char=
 *expect,
> +#define apply_parse_fragment_range parse_range
> +int parse_range(const char *line, int len, int offset, const char *expec=
t,
>                         unsigned long *p1, unsigned long *p2)

From what I understand, this still creates a new extern symbol
called parse_range. The hope was to avoid creating a new symbol
with a generic name that someone might start to consume, because
if they did start consuming that symbol, it would be a burden on
them when we eventually have to rename it due to the conflict with
the other symbol currently called parse_range in add-patch.c, which
we might also want to add unit tests for later.  Is it not
preferable to just rename it now, before it becomes extern?

Cheers,
Phil

On Mon, Feb 19, 2024 at 4:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Philip Peterson via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Philip Peterson <philip.c.peterson@gmail.com>
> >
> > This patchset makes the parse_range function in apply be non-internal
> > linkage in order to expose to the unit testing framework. In so doing,
> > because there is another function called parse_range, I gave this one a=
 more
> > specific name, parse_fragment_range. Other than that, this commit adds
> > several test cases (positive and negative) for the function.
>
> We do not write "I did this, I did that" in our proposed log
> message.  In addition, guidance on the proposed commit log in a
> handful of sections in Documentation/SubmittingPatches would be
> helpful.
>
> It may probably be a good idea to split this into a preliminary
> patch that makes a symbol extern (and doing nothing else), and
> the main patch that adds external caller(s) to the function from
> a new unit test.
>
> It certainly is better than doing nothing and just make it extern,
> but I am not sure "fragment" is specific enough to make the symbol
> clearly belong to "apply" API.
>
> > diff --git a/apply.c b/apply.c
> > index 7608e3301ca..199a1150df6 100644
> > --- a/apply.c
> > +++ b/apply.c
> > @@ -1430,8 +1430,8 @@ static int parse_num(const char *line, unsigned l=
ong *p)
> >       return ptr - line;
> >  }
> >
> > -static int parse_range(const char *line, int len, int offset, const ch=
ar *expect,
> > -                    unsigned long *p1, unsigned long *p2)
> > +int parse_fragment_range(const char *line, int len, int offset, const =
char *expect,
> > +                      unsigned long *p1, unsigned long *p2)
> >  {
> >       int digits, ex;
>
> Alternatively we could do something like this to make the blast
> radius of this patch smaller.
>
>     -static int parse_range(const char *line, int len, int offset, const =
char *expect,
>     +#define apply_parse_fragment_range parse_range
>     +int parse_range(const char *line, int len, int offset, const char *e=
xpect,
>                            unsigned long *p1, unsigned long *p2)
>
> If not for unit-test, this function has no reason to be extern with
> such a long name, so it is better to allow internal callers to refer
> to it with the name that has been good enough for them for the past
> 19 years since it was introduced in fab2c257 (git-apply: make the
> diffstat output happen for "--stat" only., 2005-05-26).
>
> > diff --git a/apply.h b/apply.h
> > index 7cd38b1443c..bbc5e3caeb5 100644
> > --- a/apply.h
> > +++ b/apply.h
> > @@ -187,3 +187,7 @@ int apply_all_patches(struct apply_state *state,
> >                     int options);
> >
> >  #endif
> > +
> > +
> > +int parse_fragment_range(const char *line, int len, int offset, const =
char *expect,
> > +                    unsigned long *p1, unsigned long *p2);
>
> This is wrong.  The #endif is about avoiding double inclusion of
> this header file and any new declaration must go before it.
>
> > diff --git a/t/unit-tests/t-apply.c b/t/unit-tests/t-apply.c
> > new file mode 100644
>
> This should go to the next patch.
