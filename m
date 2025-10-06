Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE631DF254
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 19:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778306; cv=none; b=EXMD13p4rO2wKUFYIq2ZF40k+ECdCmCzomUSQdi6BoHq+9OweHDp0AP2vPALAViuhdvOCoFOxIAtN0VEfBFVhu5XraRuRTqWjd1w+b3Uy9363obsQz2N3FMgZkJcje6TPCIq4F3y4OzPtgJUTm1glFP+tBFbbN8SkjSAKxCzfzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778306; c=relaxed/simple;
	bh=/PaOrD7iqA70VLyy6j/NwFzXKD29e/Ag02WRuQ74tFA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxcuIk0x2fuqABnilBZjhp0Lea9swI4oy2H04e745QrutI7nCJSV1p2duI2wxwoXsfXcFwG3bjiYr4mwWObdqfj7AkQi92xOdp1PUv8/QJsnMvTD1oYYFSeYKvk1kJCbJy9ZH9LI+yMx1B9WOkSUxcgqaYQWOLWDnXXZ9AYnYZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=hIka+27b; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="hIka+27b"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-92aee734585so208554239f.3
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 12:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759778304; x=1760383104; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvcoRZ3Jtz2fmLfCr4g3pCozSdYYLLDcGOerOsFozVo=;
        b=hIka+27bm8kKfehuZOHKzOzPbMlJ1YO8RCbAyseGNSZyLrc2slgFlR5uEtUIPIHEZU
         cPjGsNSsmIiMqOeqMUkU/9yoradzF/HYOsvcegNj2oLlD+cN4hBd1HGZpxB+oq/LOp+K
         4hEMWNc9t5cjpy6aTLGvUNawo+PlsRUr3qXDkIgtptJ3ixfkPoZdK6VGrGCAKRLGFNnu
         Ibx1G5Z+XbMIOXBxhCDuInhNZ8B5KIB0AFBJXU9mHlCKjKjdWYLa35ckwHKExH1Vdkg+
         Pqdv55Eq23UL1OAe7bVm3tS3KP+Tj76yiv3PKwCFUn9IdjF1/gzoVVIFLCy6wOD3dnK9
         DS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778304; x=1760383104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvcoRZ3Jtz2fmLfCr4g3pCozSdYYLLDcGOerOsFozVo=;
        b=ulxBvgWyiLjvn7Ve7Fyj1YDIKKVM7ENS6Kobe5B3Be5PBnOT9bb69OBQ9dcs2Ul85Y
         hHjTzXtpJKZkV3zOhP9aty7HacakTCH/pYEVVD4+oJULghZwJVDJfzH03lbcUvd9F/yo
         aNrcns2K8wDw6cZKIn9sYaUxvMIshIExHkHOAY4SnwybYT0S/x2L37B2F7+PSSFriqFH
         ar0cXXUBxUBsm2QKZrRFS6hJw/IHjCWx+KXljXDiOhAaz5ezzickh+MBrRn0lFKjZcmO
         UNe1ZHAmS7FCN69JK6gIAkrJlVwTkstMt7vL1xct3dC3EGrBebwD41GdWvI1vqRrbb2S
         sSWA==
X-Gm-Message-State: AOJu0Yy4D88eUGNapVGM2Sau41Hne4hpC7srOKtGLnsJQYWaP0FaspHL
	rrpsV4Z5Yz9UeDWwLEyNDH9hGVy1yX8Uw55zJr3ZC4BuhHsTNwbcjYa/qyTaE4mY7v0vA7QfWYp
	5UFA5NZdZkQ==
X-Gm-Gg: ASbGnctoAxs7zVPXxaQ5y3KE7KNBot4m373Zo4TNcANlI9+4dmoIWpHR/h/9XyuI8fU
	rvU3ujEYB9A4hpMMrFpfe7h6vvP1Dpp6zOCrs27zJiSzhLHRi5Kw+LSoIykkRJsuP1L4YUyD+hP
	G6L2c5QiWL51aMsEMkZYR3ZntNQFRfIg9tiZm4mcaRhJ2kotDCZCQ7+4Cgdq7Efkkb2ZObsFxlR
	5mO7NLsufOJcND+/f1jTfgW9BZ7K4B8zjUhSGvT+XByhMWEkq7sMOEchDK+vHDujXfEMy80ZxJt
	7c/7XWA1XnWq7NV15OdWhcZM7FONT5ci0S7ukL//q+xqLHBWRcA2DgrMKkqzflbKH1aCnrRZ6sh
	5t7l/yALFkPqKfQjx05xfcPeqQsZExQxa9HnEnKhZOSr6vHuKIZOSexs5KHq2QI+9JBNDwWIAKe
	xFU/SSFBaWTWtfcK5WY+uL3R+eIYWBRmZlNQhr9OcQDIzTSo0MnA3xjjg4bYrr
X-Google-Smtp-Source: AGHT+IEXVhpQI0jYP0xNYgM/wU8xEYTkFeK0S2BPApwYU900+6ahQEibiMGVyljEdTq13kLl22B1rA==
X-Received: by 2002:a05:6602:6425:b0:8d4:2004:ce3 with SMTP id ca18e2360f4ac-93b96937ad8mr2146641539f.4.1759778303731;
        Mon, 06 Oct 2025 12:18:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-57b5ebc8169sm5313547173.40.2025.10.06.12.18.23
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:18:23 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:18:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [NOTES 02/11] First-class conflicts in Git?
Message-ID: <aOQV/ja9Ltw/bTP3@nand.local>
References: <aOQVeVYY6zadPjln@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOQVeVYY6zadPjln@nand.local>

Topic: First class conflicts
Leader: Martin Z
10:50am-11:15am PT


* how interested is Git in adopting first-class conflicts?
* can rebase descendants easily
* maybe we can use it only internally during rebasing merge commits?
* could mean you don't have to do rebase --continue etc if we expose it to users
	in the future. is it appealing?
* taylor: what's the goal of having first-class conflicts in git? do we want to
	enable certain jj-like workflows or is there another reason?
* elijah: would like first-class conflicts so i can save context while editing
	changes in a stack, to handle later or hand off conflict resolution to
	collaborators.
	 * really helpful to be able to divide and conquer when dealing with a massive
		 merge conflict
	 * so we want to be able to publish conflicts to the server for exchange? ->
		 eventually, yes
* first-class conflict means - it's a separately stored commit header that is
	understood more deeply by git (e.g. fsck). jj uses a special header on trees +
	OS-hidden dirs, it's a convention to store conflicts into .left/ .right/ etc.
	has some human-readable warnings in the commit that stores the conflicts.
	 * then the client refuses to push the special header
	 * jj puts it into this special tree because the conflict needs to not get
		 GC'd, if Git learned how to not GC those conflict objects on its own jj/but
		 would have less magic to do
* should the conflict objects really live forever?
	 * They should live as long as the commit referencing them lives
* what about adding a non-tree object for the conflict markers? e.g. add it to
	the commit header as a confict object instead
	 * having the conflicts in the commit header is nice because you don't have to
		 walk the whole commit tree to find whether there are conflicts
	 * the commit object just then starts having 3+ trees instead of 1 tree
* brian: what about a special tree object with file mode that indicates it's a
	weird special thing, then treat that specially in clients that are aware of
	what it's for?
	 * does this fit into the way we might extend the tree for storing weird
		 gitlink sha256 things also?
* what does it look like for merge commits? "i meant to merge commits aaa and
	bbb and it didn't work, try me again"
	 * then just hang onto that conflicted state, other tools could resolve it, or
		 a rebase later could resolve it
	 * partial resolution - apply as much as possible, then only write down the
		 still-unresolved parts
* how to keep people from submitting conflicts? conflicts as a first-class
	object makes it easier to prevent (or to render correctly on the client if it
	was submitted)
* would including this in git make so many git commands obsolete?
	 * elijah already working on dropping rebase and starting over with replay
	 * new commands means we can also make the UX not suck this time around
	 * patrick: same thing for git history
	 * junio: clapping emoji 🙂
* any concerns with first-class conflicts?
* is it possible to commit those in history and work on top of them
	incrementally, so subsequent commits fix only part of the original first-class
	conflicts?
	 * that's how jj works already
	 * with binary files it's hard to do conflict markers, that's not an issue
		 inherent to the conflict marker storage method though
			* in jj we stick conflict markers inside the binary. it's…. not great….
	 * for many-sided conflicts we use more types of conflict markers, even on
		 binaries
			* iteratively removing one side of the multi-side conflict until there's
				only a simple conflict or no conflict at all
			* this requires you to have an appropriate merge tool to resolve binary
				conflicts 🙂
* sounds like no broad opposition
	 * should we aim for 3.0?
	 * is it possible for people using git without the first-class conflicts to
		 keep using it the same way, if the git binary supports it?
			* not having these conflict objects be pushable makes this much easier
			* could mean that initially we can't mail those conflicts around and we
				use a major release to make it possible to ship them
	 * patrick: please be careful putting too many things onto 3.0 gating, so we
		 can actually finish 3.0 🙂 should we stick to things that are already ready
		 or at least underway?
			* taylor: i think it depends on if we think it can land in the next <10
				months
			* local-only means it probably doesn't need to be behind a major/breaking
				release
	 * people can share conflicts via continuous sync (not through git protocol)
		 in the meantime, with other tooling
	 * would be nice to get branch-level acceptance of conflict objects from the
		 server side
* helps to understand what the target format should be. if we did it, what would
	it look like? then we can start working on it
	 * on the list let's figure out what it should look like, and then we can
		 start working on it but not in a breaking way. then we could start to
		 notice places where it breaks old commands
	 * but how do we know the format is right before we start developing tooling
		 against it?
	 * is the object format a reversible decision?
			* maybe we can depend on jj / git butler having forged the path already a
				bit
	 * interesting to think about how tools like jj and git butler would ideally
		 want to store conflicts if they didn't have to worry about wedging it into
		 git's current formats
			* is the path to getting first-class to start by wedging it into git? that
				seems to be what jj and git butler have been doing already; are we ready
				to move into git first class?
			* "first-class" is in the eye of the client, so we're talking about the
				way to make them first class to git, not first class to wrappers (who
				already know how to do their own first class thing)
	 * needs to store the tree and not gc it, any other reqs?
* how does the plan work?
	 * lock in data format, then only git replay can work with it, everybody else
		 ignores it?
	 * would be very difficult to teach rebase/cherrypick to understand these
		 without breaking for people who use git the way they do now
	 * or could put a flag to fork rebase into a different handler if it sees a
		 conflict object
	 * cherry-pick already has(?) a replay mode (or maybe just in elijah's tree)
	 * scripting support becomes weird if you're using config flags to change
		 behavior of porcelain that already exists
