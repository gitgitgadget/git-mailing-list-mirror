Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7354223323
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873490; cv=none; b=X2Mdn8T/pH9OtS03aGDHfv90l2V/jlvubkUwGriin9dr/rPyZ+lAlM8ax/n8wpR6ebQaVyI84U5mSreTKLYtN+UEzHljZdip51qSlGojnwKsB1aaROetlrjQKxvOMtIpZkfG8Czce2p5JTMwOmic8lpiIg0qjsmGCnt8JPK/UDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873490; c=relaxed/simple;
	bh=0Ltwxrik6mSFLL4yqTe1AJpy2phBNlfe+HE6SvnGdIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ld3HdadR9RU+kPSHCRqlkmm1YOc5HcLF6zkFlmDVcNsiT55DtYhqsCm5qIIKODQr+F4PIISDLZmNTgK750oGUVUNvjSzyGwd+BzuW06jBx7n0agM8jWdRzfPi8sWfUXBqAJhImB4AzFv/dXX6x4m2AyPLul2z7hbhaI25Xl0Dzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwQ3ru0C; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwQ3ru0C"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23228b9d684so47155745ad.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 07:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748873487; x=1749478287; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YNMQHKpxLtgZwfn24ymfaTrFCLo/KBx+iNPYyQ4eYGs=;
        b=PwQ3ru0CukNQn4iX+1jrZ4p/B7ww2X85jw2WoSF9PTVQo8W7mjZ0kSN+A3t4+4YUdS
         Kg/NCcsLwfmlbWCRaMdtK3sdKUFA2kbONMfzYAXPQLACvKWRjBxrqTzMg9hNlSYgZLQV
         g9pZOir653jCowZCi+mG+mEfE2TbJrpcInuxRrTCG3RpfaODd0i/LFtwwJKOzbsrgjvZ
         6MM6ACx0OziloggUjbyRE3jCrnIKuoRmM8JwWyoUNIcP3/jTz/sXLaQVcek2+O5lMQOy
         3OOKxpM+5ElZh9JjvRQb9FdH3Kj7SetvkYdrFp2U/j8hIS+r1DNdpR/4RMn0KcTaHOYF
         qbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748873487; x=1749478287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNMQHKpxLtgZwfn24ymfaTrFCLo/KBx+iNPYyQ4eYGs=;
        b=uXJUKgTe4cVA/YiWHwK01jpDW/uU5XRiNyNRLSwcH+YHeG6aRlDtmWstIydEi4LX4J
         0hpi6uhwSg1GhOxAkp0BCbbuRu5K1zDDlDH35/I09Nkr2sZ+9MpJmdNxYB7DciNb3qVh
         H6G7Od1ugtHvF8vjaMjTXkMyQ2ShxnDIwt2H/Frj638PJcK+RobO6c4hxzAOb+ZZ6F42
         YtjS9EcFM+xYOgByjv3Wogc51C5XbZgG3JgA4EX3zecOi9kTWKZW0po0nd/1mFN5IyeL
         Cl9z8NEJ4mCnn83ju/T+1BWbi08jORtrgKlZJzeJemO4DAvn0iD5PQyOB4yw4MfeJiFK
         Nocw==
X-Gm-Message-State: AOJu0YyblXA6qnscX6kg8q7IT6rfJ5AW3EtzIgzazj2bEvxG1HHABcWl
	50i2MMwn77amAcI9o+kKe0jekCYj4lHPCMy2kwX4L5G94tF36A3sRacB
X-Gm-Gg: ASbGnctMNsXCRvwltg1m4HN31Hv3MnKG2qwAGrcHT6JxhD3SyrVt3oci7x7UCHTIRbK
	mYzEupRtwtMJCNzbIGdq8LOI4uJ6In6A60XDt/ZtLUElY4qF5WFX+Wry/Rkh+3olvWO3unBiGTJ
	emuJ2VopM3Wqv9dsNAnj+vTMe3f65ZW/u8VG/P4fMVVyvuq8cSsEMDp2WlVNNAkv5Y0my1uFqte
	VSwxGQCOy7ONy4GByjIjmeSywzKByXDwyEmSrxd2qCv5om/Saq7qL+r57K/JOnIOwcCR+8rwl7b
	AA8D7v0zU/CoESTsmU9sQAJc/X1UuhggVV5gFmJWiHrfpcA=
X-Google-Smtp-Source: AGHT+IFHQy9LgWZn2x3uUdMDjOWXNN++4DlUx0qLcc3NLQIbW3LNsz798wtHgqfszDfitvowrIN1iw==
X-Received: by 2002:a17:902:f70e:b0:235:be0:db53 with SMTP id d9443c01a7336-2353965b008mr147741325ad.51.1748873486809;
        Mon, 02 Jun 2025 07:11:26 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23506cd342dsm71086135ad.148.2025.06.02.07.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 07:11:25 -0700 (PDT)
Date: Mon, 2 Jun 2025 22:11:23 +0800
From: shejialuo <shejialuo@gmail.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/1] fsck: ignore missing "refs" directory for linked
 worktrees
Message-ID: <aD2xC0YBDm4TASHG@ArchLinux>
References: <aD2mhOlwl1LSYnpe@ArchLinux>
 <aD2nPXIXugVXfIpg@ArchLinux>
 <21461585-273f-46a9-a750-6ae7b414fcdc@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21461585-273f-46a9-a750-6ae7b414fcdc@app.fastmail.com>

On Mon, Jun 02, 2025 at 03:59:01PM +0200, Kristoffer Haugsbakk wrote:
> > +test_expect_success 'no refs directory of worktree should not cause problems' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit initial &&
> > +		git worktree add --detach ./worktree &&
> > +
> > +		cd worktree &&
> 
> Now in this version you change-directory into `worktree`.  You would
> need a new subshell for that (test style).  But I don’t see the need to
> chdir in the first place?
> 

We should change directory into the `worktree`. This is because now in
the test, we use "git rev-parse --git-dir" to get the git directory. We
need to find `gitdir` of the linked worktree but not the `gitdir` of the
main worktree. If we do not cd into the directory, we would get the
`gitdir` of the main worktree.

And I agree with you that we need to spawn a subshell. Let me update the
code. Thanks for reminding me, I forgot about that.

> > +		worktree_refdir="$(git rev-parse --git-dir)/refs" &&
> > +		# Simulate old directory layout
> > +		rmdir "$worktree_refdir" &&
> > +		git refs verify 2>err &&
> > +		test_must_be_empty err
> > +	)
> > +'
> > +
> >  test_expect_success 'ref name check should work for multiple worktrees' '
> >  	test_when_finished "rm -rf repo" &&
> >  	git init repo &&
> > --
> > 2.49.0
> 
> The test passes for me.  Also when applying only the test (and not the
> fix) the test fails as expected.  Good.

Thanks for the feedback.

Jialuo
