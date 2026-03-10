Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117443D16F8
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166190; cv=none; b=phRE2vQXei5uTCx0AmCVPB+CjXuVskk0Vlv7Rge5Z8yPDYCaiMWp2Ftev/pL+3vOB8Uye82WvSOubPrMM9MdmEZ0I4dYw6GgIuFrA6v+Q6OFFexI6AK3w+6hT9/Sd50flartMRlZUNpWmsAn1FtATikQF9EfuhTSYE0Wf9P9V98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166190; c=relaxed/simple;
	bh=tdSQDk/G+Ff5VYmw4wcnlIS7UyjdZCsvUt9O1owmtKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/pmVAMtMwWwtU+dCPXjatHyXnfOSuJZKwQrSJe0m3P54LEcuonyMdaM3rASAYQxcGm45cIEP58CGxJNrFSCeTN6BwIfQvia+acaGEaSbn80HuN4dv5OInZUkukVz9s4mhoAmGuAtf1p90GrOIOiakYyWrhzEhmrvA1tVnhUimA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrExW9a4; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrExW9a4"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d74aa6bcdbso1340694a34.2
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773166188; x=1773770988; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2DBJ3EgTKnTmDCRXa6iGCa8P9vYX2X3QBLee3K/Wlx8=;
        b=OrExW9a4OjiE7SeMkIxrj0VDxCO5+CVp2mUolkIsKND4VmKaqrayBt2ZtuLXEPoiJd
         KTl0iaevX6UJmIHcA/xTm3KZNiMXtZtWJR079HOUwDWhFfsLk96yAPzlj2xTFXvNyPhP
         Q8lM9i3wdVC3bu3Z2i7SDiK4stzJs+OvpUCXVFdGgDu6kwfoj2nv/43DyWva7OmsgM1s
         yeLW7h72rkQ908cdwpcszKjl9TigmjGlxuEx2QhCABccqS77ijatMF8zWlFbznvLyaxj
         RQB0CVUSTizCZC32KgOVEfV2K+bo6FU7HualC49gkAHwRTVwMNVmTa0qkOoouyaz978M
         +dPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773166188; x=1773770988;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DBJ3EgTKnTmDCRXa6iGCa8P9vYX2X3QBLee3K/Wlx8=;
        b=fufMvLQujqlI2i+B54iicj3lcWujgxdfzihfbtQWXIgVrkdEbOAIRJT3sVn00U6Ent
         fH5hnOGdm+mTKhWVuCvQj60HwKkwuf5TSGMEd13/jsTbr024JYclic8jW+Tw+f8rxJyy
         rGGbiyYGZnSpW/Sq5bK01VPrVqwFnuiR/wjW6HzYx8NUKd7HrStlbHJWeVjdIdxn3XXS
         J7NqS11eUnJW1gRTTaxOEMTxu3MRV9EpiKMOlVURi75ii/4TcTdr2Ykv1JDzcSAJw2Zg
         UDYvOHoMwCnuwqs0hLUNC/ILdqM+YkS2SmDeTHrdYCb6K0TCBFhRJTAcGXp1KHFTZDxw
         UysQ==
X-Gm-Message-State: AOJu0YyZi393RIFbWXNAMiUMZuuyMxlNaCoJ2dWzO19DyVijwngZBC6e
	jOgxIxHYCQHlxObwcjVHN/f7Ufxzh3p/h5gNyAelzq11C38gKNQrSk6PZLmm5A==
X-Gm-Gg: ATEYQzzEQ/J7VPzykP3w+0O0hqhX7vmVOv+aNsH1N8LqgvWzeaC2LYCl/FLrZHPKmG7
	4wGkNwQZAZhvptNAELkYRndEkFxS7ka9fS71nOe9cBz4S+gSlJn4/m+D4mo6bcvptIb3n/ezbsa
	5mUNGu9j8F9HN7KkL6l5vUQCqmIyEpz3S/WbtQ0L4wEvRvKJRxmuwfmOEPBiHZhDSeoCzDrrepr
	beCIyc8DxnrvUQ7kruPJcd8q0K30s10xGw3nsw7Pk7txN7SgQg/H3FIRN1O6zVKqJhyZDuBSrUY
	KxWP3D5iDH4lr6u5ZZC2Z3iKxHFfhNB6ZXuMO9F7DL9apkNHhrbXOXNyQa+ItRDGFsNB3Dq/JUB
	dIIAUcEWTSyaECp4wznPZZM83r3Win5/ZI18JWQqk4zlx6TlgEO/4p8Yh8i9NY8R0cOoRLF4Elw
	q1qwGTHnyLZCi8v5wR6ewJscpfmF8=
X-Received: by 2002:a05:6820:602:b0:679:a650:cc11 with SMTP id 006d021491bc7-67b9bd1168dmr9670972eaf.48.1773166187965;
        Tue, 10 Mar 2026 11:09:47 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bb1eb3591sm4745894eaf.14.2026.03.10.11.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:09:47 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:09:47 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, ps@pks.im
Subject: Re: [PATCH v2 3/3] fast-import: add mode to re-sign invalid commit
 signatures
Message-ID: <abBdNO2Izp7vrOdM@denethor>
References: <20260223194146.3476768-1-jltobler@gmail.com>
 <20260306205359.1723254-1-jltobler@gmail.com>
 <20260306205359.1723254-4-jltobler@gmail.com>
 <CAP8UFD3p84U0FhjGXNqagtDi=Cd3+QBHqGb3_ceWy-tdeLc43g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD3p84U0FhjGXNqagtDi=Cd3+QBHqGb3_ceWy-tdeLc43g@mail.gmail.com>

On 26/03/10 10:27AM, Christian Couder wrote:
> On Fri, Mar 6, 2026 at 9:54 PM Justin Tobler <jltobler@gmail.com> wrote:
> 
> > @@ -825,6 +825,9 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
> >                 case SIGN_STRIP_IF_INVALID:
> >                         die(_("'strip-if-invalid' is not a valid mode for "
> >                               "git fast-export with --signed-commits=<mode>"));
> > +               case SIGN_RESIGN_IF_INVALID:
> 
> Everywhere in this patch, I think "RE_SIGN" might be more consistent
> than "RESIGN" for this name.

That's fair, will change.

> > +                       die(_("'re-sign-if-invalid' is not a valid mode for "
> > +                             "git fast-export with --signed-commits=<mode>"));
> 
> [...]
> 
> > @@ -2856,15 +2858,52 @@ static void handle_strip_if_invalid(struct strbuf *new_data,
> >                 const char *subject;
> >                 int subject_len = find_commit_subject(msg->buf, &subject);
> >
> > -               if (subject_len > 100)
> > -                       warning(_("stripping invalid signature for commit '%.100s...'\n"
> > -                                 "  allegedly by %s"), subject, signer);
> > -               else if (subject_len > 0)
> > -                       warning(_("stripping invalid signature for commit '%.*s'\n"
> > -                                 "  allegedly by %s"), subject_len, subject, signer);
> > -               else
> > -                       warning(_("stripping invalid signature for commit\n"
> > -                                 "  allegedly by %s"), signer);
> > +               if (mode == SIGN_STRIP_IF_INVALID) {
> > +                       if (subject_len > 100)
> > +                               warning(_("stripping invalid signature for commit '%.100s...'\n"
> > +                                         "  allegedly by %s"), subject, signer);
> > +                       else if (subject_len > 0)
> > +                               warning(_("stripping invalid signature for commit '%.*s'\n"
> > +                                         "  allegedly by %s"), subject_len, subject, signer);
> > +                       else
> > +                               warning(_("stripping invalid signature for commit\n"
> > +                                         "  allegedly by %s"), signer);
> > +               } else if (mode == SIGN_RESIGN_IF_INVALID) {
> > +                       struct strbuf signature = STRBUF_INIT;
> > +                       struct strbuf payload = STRBUF_INIT;
> > +
> > +                       if (subject_len > 100)
> > +                               warning(_("re-signing invalid signature for commit '%.100s...'\n"
> > +                                         "  allegedly by %s"), subject, signer);
> > +                       else if (subject_len > 0)
> > +                               warning(_("re-signing invalid signature for commit '%.*s'\n"
> > +                                         "  allegedly by %s"), subject_len, subject, signer);
> > +                       else
> > +                               warning(_("re-signing invalid signature for commit\n"
> > +                                         "  allegedly by %s"), signer);
> 
> Maybe a helper function could be used to avoid duplicating the warning logic.

Ya, I could extract this out to a helper that prints the appropriate
warning. Due to being translated, I'm not quite sure if there would be a
good way to make the message strings more generic though. Will update in
the next version.

-Justin
