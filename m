Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28D482CD
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841949; cv=none; b=K9P93E95/1yY6xOXV4LxTcqOJJ7iUvNq/Cu+jKAPL7aHeADlJAUAkdDMhYXWIcESSjaM2c2GK6WhD5dvMF1CHXlwiVI63Rc08fNb5ty75w5vS28wkSaiXi3+GnS8GnsGiSOarL1YS3isqEwJKPDH2HDwKPff4pCZ3P1qgMPIZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841949; c=relaxed/simple;
	bh=bJCt5KuhXXx9qXJHCfPlXwGPWP070+n5IzPuti4SFT0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJm+Mi1RmysMVU7MvfvmNxsKzJIWQ3Rle2Fvx7PdM/WbPSfk/5oxe5vkvsLDKbVpFVaqDYYVC+r6YRe7C+EIiBEA0k/njabAW12vKl/pZHFuCaF0LZRYfVojtmojm5244yuQOdqnnNFEZiaMMiSFYrG9pKTUQ7tS6QAw4+B42BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=K6VyOZ8a; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="K6VyOZ8a"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-82521c46feaso98769739f.2
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 07:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726841946; x=1727446746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sEnZYSrjrTp2qAIcBmwfstkDmQAyyf3A1dw2u06mSu0=;
        b=K6VyOZ8abBsqleQHz7h7sxvWTpVD6ZTTHPyjfQY9s2bZxb9BA5fgLzyYRvr8MO5taN
         V1vdAf9V4N16+KnyiCnj3Rq4aarWlizYGULQcDbXMZ5r0iUkAOVZ0Mizg+0IJVhkzZgU
         rZHBes70gIcnXMZJa18iAltEHVC8SiWSS36rEr5//6ToxojlkBpIEgJZEL5RnnUjmY0n
         Jda1zVgtBLhEcgMuFjZiAzfTNTVs9Bo1Y2VWRmdVnxtECLUd++QabRLIERkhrDUNoKSS
         u5t8gLwOI6xF6rCm9vTIDBGJGgFx6dnEGr8ITTxf2qWVvmQOmQEP3rQepUtRQanMHS8i
         mQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726841946; x=1727446746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEnZYSrjrTp2qAIcBmwfstkDmQAyyf3A1dw2u06mSu0=;
        b=jsgBHoPPcZOiY/wPw/XcEgFenWAKrtESBFVPAIHepEG2v2FMTNJzwhmT9sgz7wsceR
         nE2Ms+wzy/vA328Q5uWK4/1RUDNsQ199AYIfoLVFSzXL2DX0/Sf7Rc+ZGpfrnbJdcxrk
         eluzb7ACRJLmYMAdDEPj4OdCJFpV+RRd7GB47au7JW2904Nl53Wem4EE036DPaBv+vKt
         +rKuz7Yu959q0bIaltzRa2oFbTs0VuTvcmNTmUCGTrk1BsVpJV8k3WhN9TETHJB25r3d
         DylY0r+qVBziXrFnaMXecNB+pztcQjSG4RFfLzIhGIbTrZ0BQbUF78o09I9sTQF7Wk56
         pmWQ==
X-Gm-Message-State: AOJu0YznzRVDNMSzkp+GJSkTx3EXkjVxLrYaWVqYwOywFVvKKIvqX1r8
	LdQT0mGzL/Os7mBS4dwEUGIT+yp0vT6z7JPk79wOHLgpvpjdgeBETJQM3YYJm2sTXzU31TdCGVC
	FRTY94g==
X-Google-Smtp-Source: AGHT+IGi5SN0+IOP5ALx1Ih/hwccM0bRRzv2C654LaBRrfqAruZBLm3RiWYgI2195B13l7xOwbY7dQ==
X-Received: by 2002:a05:6602:6001:b0:82a:a76a:1779 with SMTP id ca18e2360f4ac-83209d2cdb8mr360235939f.8.1726841946288;
        Fri, 20 Sep 2024 07:19:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed19ed6sm3602879173.111.2024.09.20.07.19.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:19:06 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:19:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [TOPIC 04/11] Platform Support Policy
Message-ID: <Zu2EVvSajL/pUzL7@nand.local>
References: <Zu2DmS30E0kKug2a@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zu2DmS30E0kKug2a@nand.local>

Platform Support Policy
=======================

(moderator: Emily; notetaker: Calvin)

* Emily: if you want Git to support your platform, you have to provide
  your tests (e.g. provide your own CI test runner)
   * Should we be more explicit about, for example, the version of C
     that one must support.
* Brian: less-common architectures (e.g. MIPS) sometimes can catch
  problems (e.g. unaligned access) that are not a good practice anyway
   * qemu based CI is so slow
   * netbsd, openbsd, freebsd, probably solaris are up to date with
     modern standards, probably supportable
   * I'm more comfortable with "you have to have threading and POSIX
     2008" than with "you have to provide a CI runner"
* Peff: I'm not sure what people have been counting on
   * Do we have a way to find out what people are using?
   * "Take a little risk, see who screams" has worked okay in the past
     but takes a while
   * Rust is probably a big change
* Patrick: keep in mind that we're at the core of the whole operating
  system, part of the bootstrapping path
   * Emily: yes and no - Git is not just the client, but Git is a
     standard. You can use older versions of Git and clone things from
     GitHub. If we still support the same protocols, I don't think
     needing native git.git CLI support to run on your platform is as
     compelling as new Git being able to support these older standards.
   * brian: OpenBSD doesn't like the GPL, has a project for getting
     trees called "got", it's in C and supportable. It can be a valid
     bootstrapping tool.
   * Patrick: The user experience there is a little closer to CVS. But
     it's still an option.
* Jrnieder: looking from user perspective, Git is the tool people are
  used to for day to day development
   * Emily: There's a difference between using "a git" vs using the
     latest version.
   * Jnieder: telling users to use an older version might result in
     users asking questions on the mailing list about those older
     versions, it's also not free.
   * Peff: to be fair, HP Nonstop support hasn't been a matter of
     "please support me for free" - the maintainer there has been active
     in helping test and debug things. The question here is not about
     whether to continue that but rather about whether we're willing to
     increase the platform dependencies when it breaks such a use case.
   * Peff: Are we okay with dropping NO_PTHREADS support?
   * Brian: POSIX 2008 shouldn't be that controversial. Neither C11
     should be.  We shouldn't take it too far like POSIX 2024, but we
     have to set "some" standards.
   * Emily: So next week when we come home we update the "minimum
     requirements" on the mailing list, and everybody upvotes?
   * Jonathan: we live in the real world - the spirit of "let's require
     POSIX 2008" sounds right, but real-world considerations should
     matter more than the exact text of the standard
   * Peff: example: Android is missing pthread_setcanceltype, which
     leads to Git on Android using NO_PTHREADS
   * brian: it can be enough to pretend to support (compatibility shim)
* Calvin: is there a threshold % of users for "unimportant enough to
  break"?
* Jrnieder: it depends on the platform. Do the requirements that a given
  platform imposes push us in a good direction in general as a project?
   * For example, Windows is a very non-POSIXy platform, but it has
     nudged us toward thinking about subprocesses in a different way,
     and I think that's been really healthy
   * brian: As another example, Plan 9 is really difficult to support,
     it won't pass the test suite
   * z/OS patches originally came in and were gross. I saw a patch come
     in recently that was more acceptable.
