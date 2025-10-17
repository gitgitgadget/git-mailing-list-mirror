Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD09631D73F
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698436; cv=none; b=ldwZatKCcuWHrAaWXnhvZIxZirRspUw0vd1ckk/zqPyUq2G055NbecyzpUOOskaJ0iu5Dy8fH8zPlKoMZSgsx3kjRioU1TFzJ3a+S784usxgGu3zxs5H60rrPfAPJeecZxHPTwxC5ApieU4QzSovk94Yh4QgT2LFZIOZD2Wjtrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698436; c=relaxed/simple;
	bh=VM14ITbS/XgmZ4qfCNOizWTTcNW/bqMCyhJPEOsPNKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIkxbtGnyscJkjp3fRcbHVdn2VrOaT8N9wYubFjg2DT19gE+zPfLTPObB7M+XJ/h0Kzng9x5I9ErNawpaSuHZS3UxgmxUn6qR5aAu9t92/LJ1ZxeJmaZ3nu97tPzwAOKYxpWdHuZr86c2IeXWEQavOn5QFY4rFja6ewQuU4hPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRAZFcPg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRAZFcPg"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-292322d10feso1051865ad.0
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 03:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760698434; x=1761303234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eJRaMNvxj9VHpMjsRd2zQjkumeR6qYYhVfJxcUMNLZw=;
        b=BRAZFcPg6FTkbpENvn+HmGMjRFB/2kuR+CnuO87b3yIajHF94ckGS/l9S1evnoUvSr
         VWLL3lkeWJ34JZLZAFdpM8zr0yWSSsr5E69mfO1gdFX7BsXYhdj7rAqKw4mj9PnO6nfq
         JQNkoIyg4s0Zj+brnGPQqJVepyglRuYrqgKHWbzrwcWDXwKBg778EvEXz/js+gh3YaB6
         rOkDiM49RdbL0BthLECJ5O0D14TbVpXPGAIz5MBm9RcDx9u0AmYwa4mMo0a0Jp6dhrLO
         i93jVdWooqNka/EBVT9OqRtrROYt/d5mMml6WJk49v4UsNaL1cYXAeKxQtnNlGFY3upX
         2eFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760698434; x=1761303234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJRaMNvxj9VHpMjsRd2zQjkumeR6qYYhVfJxcUMNLZw=;
        b=vd6Wl8oq0T2yzGvzH5pBCCMyoHWWiQ37UFL/T3DbeXQcONmqC1xOP34hT7/t8wTo3v
         oe1HoqCOTwv4Z3gJHMnBtZbmqeNrdGH9JVPPORUsxNQSNyRSrTDHy69EZSLiPQFoyEK2
         2vPrboVmpJxUlgvMQX2JBu7FvlMU7aCRmnJ/sWh3dVxNeIXRJ+AfQN5OMnE74w7N3gOK
         WUNAPxJP+dxG7hncRuf2fww/jKi0Qkr1iHTb3ElFVJY4A0okxXI6SQrQ29b0JjzoDVB6
         AzukxsgpEPjGPbgnFY8RZd8/kGIbradFMhHyYwkceD2q1SRHOemq/bCp5TiW121Nry93
         Akhg==
X-Gm-Message-State: AOJu0YxPLWthALJ7b2+3RMR6kbqqH/568Vwdg988i4SjSZdtQGI/vBB4
	xmGdSVhAi8H7rsmwVs3bbl5Cle5rYDjvjqCmxVX15q6maCVl9u5xMYVpVikUqCMO1tx0vwrZXQc
	56QpCRjmW8wvNHnL4PAygQkYes9/iH5w=
X-Gm-Gg: ASbGnctCeKSRcj66LqCDzkctKkCdmyCydP8T0aLPoPG9s1YqOQALxz98FhQssC+d6QC
	A58QE0MuLb/+jQqjWENzFonuRN9STTaU240e/AWMcrs6c3Rdh3yNi8fJY8MX8e3Xzd/axoU44bT
	H25u/1PuFySSkEc+StFlRyv+SPBHmIuLfZMilkjtm5FbSlcdjpKHm/C/3izm8Fuqvfob2uf5jFM
	AfJM84j2Sqa5T7azX65lTHREJKyeMnnkRC3xS/e4t76UDxuqTlvX0KP6guOZULaog==
X-Google-Smtp-Source: AGHT+IEj5RK4n7l5loaUSamTwkV+oyn2Jf750NxMWkjCBf2hok2m7f1cgrKSMFUtmY+KKZQDCTKeK6U2FSqJxlKg4iw=
X-Received: by 2002:a17:902:f70e:b0:267:912b:2b36 with SMTP id
 d9443c01a7336-290c740004bmr35564245ad.23.1760698433911; Fri, 17 Oct 2025
 03:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760571220.git.belkid98@gmail.com> <818ca6b104cf25ebe4c60145d046029f057f4db1.1760571220.git.belkid98@gmail.com>
 <xmqqms5q4v0r.fsf@gitster.g>
In-Reply-To: <xmqqms5q4v0r.fsf@gitster.g>
From: Bello Olamide <belkid98@gmail.com>
Date: Fri, 17 Oct 2025 11:53:52 +0100
X-Gm-Features: AS18NWDXy6YqR8tb1dMhCO8gFw821GX-JH8c9E4CUStSAy8ZyGeesxyeHiid2rw
Message-ID: <CAD=f0L8-+Ut4eTbd4Mh-vPJV7KwNxcVUY1-xCrB+m8mT0xkkow@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2 1/2] gpg-interface: replace
 strbuf_split_max() with string_list_split()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Oct 2025 at 18:27, Junio C Hamano <gitster@pobox.com> wrote:
>
> Olamide Caleb Bello <belkid98@gmail.com> writes:
>
> > @@ -821,7 +822,7 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
> >       struct child_process ssh_keygen = CHILD_PROCESS_INIT;
> >       int ret = -1;
> >       struct strbuf fingerprint_stdout = STRBUF_INIT;
> > -     struct strbuf **fingerprint;
> > +     struct string_list split = STRING_LIST_INIT_DUP;
> >       char *fingerprint_ret;
> >       const char *literal_key = NULL;
> >
> > @@ -845,13 +846,12 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
> >               die_errno(_("failed to get the ssh fingerprint for key '%s'"),
> >                         signing_key);
> >
> > -     fingerprint = strbuf_split_max(&fingerprint_stdout, ' ', 3);
> > -     if (!fingerprint[1])
> > +     if (string_list_split(&split, fingerprint_stdout.buf, " ", 2) != 3)
>
> The original splits the thing into upto 3 pieces, but only complains
> if the second piece is NULL (i.e. we said "up to 3", but there was
> not even one place to split, and the request to split_max gave the
> one thing as one piece).  IOW, the original code will happily accept
> if the finterprint_stdout is split only into two, not three.
>
> The updated code asks to split at at most two places (yes, it is a
> confusing API, but if you split at two places, you will end up with
> three pieces), and insists that the split results in three pieces.
>
> So the rewrite tightens the error condition.
>
> Was the original code too loose in detecting an error, and does this
> patch tightens the condition "while at it"?  Or was the original
> code correct to expect that there are legitimate cases where the
> payload in finterprint_stdout only contains two pieces, and it was
> the right thing to do to accept when fingerprint[1] is not NULL but
> fingerprint[2] is NULL?
>
> This is a genuine question.  I haven't studied the code path to
> reach this point in the code flow, I don't know what the data in
> fingerprint_stdout is supposed to look like, so I do not know the
> answer to the question (in other words, it cannot be an oblique way
> to point out that the updated code is wrong or anything like that).
>
> >               die_errno(_("failed to get the ssh fingerprint for key '%s'"),
> >                         signing_key);
> >
> > -     fingerprint_ret = strbuf_detach(fingerprint[1], NULL);
> > -     strbuf_list_free(fingerprint);
> > +     fingerprint_ret = xstrdup(split.items[1].string);
> > +     string_list_clear(&split, 0);
> >       strbuf_release(&fingerprint_stdout);
>
> Since this code releases fingerprint_stdout before leaving, and
> returns a fresh copy of a split piece, it may make more sense to use
> string_list_split_in_place(), which does not have to allocate extra
> strings while it does its work, unlike string_list_split().

Thank you Junio for the review.

I will take a look at string_list_split_in_place().

Bello
