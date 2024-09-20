Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620C6145345
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726841980; cv=none; b=pqqtOGxLWoA6WNgtP0wiiY5T2DHLGXhlEiq6cncNYMmJnZ9Sd6zuiOFOFQg8kCiL36GGAC1bEf9cv+QOVt3Y+WnYp+tAXGNrfKqdoy3JKeJgVmrhgXQAESReeHDByD/eEMoyrLQqDy0nxvIkNN4C8Ms4pBKN9ydfqziw0P6EfSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726841980; c=relaxed/simple;
	bh=zLVkaKXHM/h6CLHOxf/OWwbfsOdBxgGHLyBlIdfUz3g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtM0iIMVKQlZTU1Op9sQaWXadBTP0z48EEkawnbfnMXlVoaYUqdJdOxAoCu9gqU0UgPppUQAP+/y0jyuQmrEAAtClCjAtjkth6YCBi/3Ln9vDRP81H087syzsHoXs4bYC39+p0rtXUTWVgjXz0H5LhpUpagdWU8tlKd/uvsja2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Jw+02X92; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Jw+02X92"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82ce603d8daso80216939f.0
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 07:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726841977; x=1727446777; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ml/OmuqUxbCptDX35gx0sgF/3ZJDA5Lh157xu5iTSD0=;
        b=Jw+02X9254UIInMeX0gozZJMBCs+dKRlN903327mQmnksjiREGXkMzjlxdYGJkRgqE
         ZuObNL9E5YLLhAqAfr/qXvXbsujouz9ZGD/RW18ZwDWexAvmV+iOxd5ftzf+2ftUJBrW
         nAFpTmVnlUR/HfarOVnwx4kicQuuKJ8dWrwQ2+hBNZ4ipkJ/o+g1+3FKfMIxgs5CYaOQ
         5v9zMD8SHcyMw/J1DyIotBLqeJ1+SO4Dqx6OpEYqwrQJu+0FSiE4z1xchZjPGq58HpUg
         8pye/s251EvLx6OZKg5ANSQMS7KvDDLUc0Oz2Xa8dm2afiyjoejQJtN6eSWajXj17icw
         4xYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726841977; x=1727446777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ml/OmuqUxbCptDX35gx0sgF/3ZJDA5Lh157xu5iTSD0=;
        b=O7TbY9Rm0FqJyLhRFII9CxUOF/5uv/hkI5yCNtvMNBeyYiP0n+SyHrmoQvzqEIPWVQ
         h1dKlsfEn4PoGnW78Xt9D0bQx/bMMFD+zYIq9a6iTIlTJtV3WsjOwI7gvxjO8qS+2I+H
         nyeLYu/AT4I4fyLNO6gpPCoLk4ig0fLPCQkaAp2Egfald9HcnxLrqyryNWfWZgUnpqJI
         GTBXPKGDFpb1lm3hLPnlF1qoZaJoDwspaOKKLVRqjyN5nWBI/8TcAcSz7zTpowKNfmyj
         4ETXbqVkXxLmTlA/oYrZPn6CwNq3zLxMGChm50pz5uKztNY9B0bmj62BwnrUr6EOTsUz
         yCnQ==
X-Gm-Message-State: AOJu0YwIWoc22lpZHJ9qD/+KXxAH1FwPZj13yz74Ajk1hQoA65ETUgkg
	TDMVnvk4Iu0HJbvAn3wNoQmOdQnV1SnYUdRxoECScQjzNuyDYPidEvYznn8eNFYFCvbFEYWw6mW
	1VqEaTg==
X-Google-Smtp-Source: AGHT+IG3HMr1Z3o9onURsfkchDK05kz/bS7doJGwC1dY8q2t7ByoEW8vC2qLYpymX7L8gySIs4EspQ==
X-Received: by 2002:a05:6602:148c:b0:82b:e61e:5630 with SMTP id ca18e2360f4ac-83209cefd62mr316804939f.3.1726841976975;
        Fri, 20 Sep 2024 07:19:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ec3d15esm3557660173.77.2024.09.20.07.19.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:19:36 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:19:33 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [TOPIC 05/11]: SHA 256 / Git 3.0
Message-ID: <Zu2EdQs6xf2FRkpa@nand.local>
References: <Zu2DmS30E0kKug2a@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zu2DmS30E0kKug2a@nand.local>

SHA-256 / Git 3.0
=================

(moderator: Patrick, notetaker: Taylor)

* Patrick: some of you may have seen some patches from a few months ago
  to start thinking about this, and we now have a "deprecations" doc of
  things that we plan to get rid of.
   * One thing going away is grafts
   * Another thing is git pack-redundant
* Patrick: SHA-256 will become the default object hash, but is
  contingent on major platforms supporting SHA-256.
* Emily: this helps us too, because it provides some motivation that
  this is going to happen.
* Patrick: having it in the 3.0 document makes it easier to push at
  large organizations.
* Jonathan: with partial clones if I understand correctly users were
  already trying it and complained to GitHub about it not being turned
  on.
   * Taylor: not really…
   * Peff: I was embarrassed, so I wrote the bitmap support for
     filtering objects
   * Taylor: yeah, and turning it on was easier, but didn't require
     updating database columns, etc. so the transition period here would
     be much more expensive.
   * brian: "can you put it in the customer feedback repo" is something
     customers can ask for
* Jonathan: could use interop as a way for Git to default to sha256 with
  the only harm to end users being that clones and fetches get slower
  until servers support it
* brian: not planning on working on it unless their employer pays for
  them to do it.
* Mark: customers wanting to start with SHA256 so they don't have to
  migrate later
* Patrick: GitLab never really wanted SHA-256 until it was done on the
  Gitaly side.
* brian: has definitely seen it on StackOverflow as something that
  customers want. Not a huge selling point right now, but will become a
  humongous selling point at some point (beyond >2030).
* Peff: if the proposal is to make SHA-256 the default, then we need to
  be developing with it now, and we're not because there is no interop.
* Taylor: we should do it via interop, (a) because GitHub could not host
  it, but (b) because we would introduce the same lack of testing just
  with the interop code, not the SHA-256 code. So it must be done via
  interop.
* Patrick: OK, but why do we care about SHA-256 locally if they're using
  SHA-1 on the remote? The remote could be compromised
* Jonathan: You can verify things locally. This is the core idea of
  distributed version control.
* Patrick: Oh, I see.
* brian: Signatures work with both hash functions, you can sign with
  both.
* Peff: It does not feel right to me to set the user default until we
  the project are using it, and that the interop code is a part of that
  story.  (back to Git 3.0, we combined the SHA-256 and Git 3.0
  discussions into one)
* Peff: I have a proposal for Git 3.0, maybe this has been discussed?
  Can we get rid of some of the older protocols (dumb HTTP)?
* Patrick: Lots of esoteric things, like show-branch, which apparently
  nobody uses.
* Elijah: not just removals, but changing defaults, etc.
* Emily: are we interested in non-backwards compatible changes, like
  adding multi-Author fields to commits?
* Peff: I think that's a bad example, it can be done without breaking
  compatibility, but it was decided to not to do it. You're welcome to
  resurrect the discussion.
* Patrick: … but it's a different question of whether or not that would
  end up in the document.
* brian: multi-signatures
* Jonathan: Two questions I'm hearing:
   * Should we include things that haven't been implemented yet?
     Probably not.
   * What do we think about this major version as a way to break
     interoperability with older versions of Git?
* Patrick: I would not be in favor of breaking something, at least in
  cases where we can add a protocol extension and/or new capabilities.
  Intentionally breaking interoperability with an older version does not
  seem like the right way to go.
* brian: I agree, but for the dumb HTTP protocol, C git uses it, Eric
  Wong is really into it (lore.kernel.org supports it), etc.
* Emily: Bundle URIs and resumable clones, could in theoretically work
  for resumable clones, but we don't have client-side support.
* Peff: Pretty sure that this isn't the case.
* Mark: can I ask a "dumb" question? What would it take to get a
  schedule for 3.0?
   * Patrick: Junio says not too often, maybe only breaking releases
     every 5-10 years, which means 3.0 would come in 1-2 years.
   * Peff: 1-2 years is what is in my mind.
   * Taylor: I think that whatever answer we come to agreement here will
     not be satisfying for you.
   * Taylor: the items on that document aren't a checkbox list of things
     to do before Git 3.0, but isn't a "let's get all of these things
     done and then we'll release Git 3.0".
      * More that we'll all wake up one day, realize that we've done all
        or enough of what would go into Git 3.0, then remove a bunch of
        code, and ship it.
* Jonathan: collecting breaking changes and aggregating them so users
  can prepare for them together is helpful, but it's not the only way
  that breaking changes will happen, especially if there is something
  that needs to go away.
* Patrick: I want three things from this document:
   * Reminder / documented intent.
   * User feedback to hear things like "this is important to me, what is
     (if any) the replacement?"
   * ???
* brian: changing the default branch name?
   * Taylor: I would be in favor of doing it sooner
   * (some discussion)
   * Taylor: We should consider doing it for git.git as well.
* Peff: we might write a bunch of those patches, move them into 'next'.
  Could we have a Git 3.0 pseudo-maintainer.
* Jonathan: I have a naive question: why wouldn't it look like turning
  on a single Makefile variable?
* Emily: and then we go and delete the code inside of the #ifdefs
* Taylor: whoever is the maintainer at that point in time could consider
  a double-wide release cycle, where we delete that code, implement new
  things, and then at the end of that cycle the artifact is called Git
  3.0.
* Peff: very few people run "next"
   * Jonathan: True. Could imagine some % of GitHub Actions runners
     automatically running "next", that's the kind of thing that gets a
     more representative workload.
* Toon: do we want to have maintenance releases?
* Emily: if we're dropping support for earlier versions, we should just
  do it.
* Taylor: we should probably have a few supported release tracks that we
  designate as LTS releases.
* Patrick: For security issues only, probably for a period of 1-2 years.
* Peff: Should we write this up as a plan for the person who actually
  does release engineering?
   * Taylor: I can write up that plan, and be the point person for the
     LTS releases.
   * Jonathan: the Linux kernel has dedicated maintainers for LTS
     releases, which seems to work well.
* brian: we can certainly tell that to Junio, but it's also ultimately
  their decision.
