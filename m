Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D25B482CD
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842048; cv=none; b=KKl0aF9OOeBW7VIVTfo8he7ty0BaFKbA8SvH1U/WxBqI8AKddmW7DNM/+Iw79b64YPaJaCuNqC+m0b3r4rVfpIKZ86ITcLnY6htl9cfdj9o1BnhrYXnxyQdvAA05d02tmtF5bEgSCIxkr900DokqPSvEornxiR3skDDFNoc2uz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842048; c=relaxed/simple;
	bh=BgYU7A14QuYXh+40JOPyBIL7TrrVrfHgvBIsbin+cc8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCFz6EbOT2t3T0pqNh7cWnYXmPLntwTdXkAS8lPS2GvXbYOGIVfWvpReBY2dbjs46nX+B/LDzk+knK64Ra7JxESsxYPjN5Md9RTLqxTRfRXWyGxp3/BtXvxlARsWHxE+mfkj2VzkT4YzpPK+0WtUVyYToHOdOUWSXlRQQ3m8ciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=0DYkr8eK; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="0DYkr8eK"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a0cce338fcso1745675ab.0
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 07:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726842046; x=1727446846; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+s2gn78v2UowXGwPHj0XuwamzwXnbhffed3GU4ysPaw=;
        b=0DYkr8eKgHlSPcoSWLWxEVM7E2pjPVV2M7pqBdsNJLzu2fyZj8OFsSGmLkuJ1jRzU/
         R7ltdCc5oU1FfeOrjzebykmbSpajGyFbq0ctPdrohm57qqrvjtXHydVb0hyNjaqujIAf
         oYm/N3Eh7KQ1ELpoBTa79meCgJd+z8W2ujMvfIQxwjG9xV3gQbn3IO0dt+bvTW8nYlzd
         u8xp1u/Is7/gOwlR0o72dzvuKT/HF4T8thTrror99YTr4pSr7gsBYSJ4xE6DDUAMIPvW
         DRpa21S7RHPUon4Af2Q/NGoEeJyveharmh1gTtBS5PPujndBSsWG5h+c/G9la6TDWXEq
         2pyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726842046; x=1727446846;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+s2gn78v2UowXGwPHj0XuwamzwXnbhffed3GU4ysPaw=;
        b=ZwnsUMEQtf+5XZZyxZLVyzs1Su+CLUlZOL6DO9wWbevGjV8rkJUc54GNVECi5fBkIk
         p9dhT3GZW/G3grXzUyvIYEr2DEZJQHEk2MlYtznV6VV33+mkAiGX80Wg0xi+ktvm061O
         4ozQJzwsZH+ZjaKWV6Vs2wIHotMzP3ZG0qAD9khpkaxvz6qZS9t5K6hwMzxSfzSpmlvb
         0+ooFKDLBUUh9vrbvIjmWgJzytF4bsQIbXx8X9vuWkBibmpiuJsx8Y2fST7ehEOBA82+
         oYw0qPi5tIFAawK9E8ifWuFupTCTE8cQ2rBD49h5eIQ3UokVDHb0z0JdO+UShdQzufO8
         EFew==
X-Gm-Message-State: AOJu0YxYG0BoFCxe3nfLbxR27qFBpRvX0h6nzOQxEtp1WRD9fQ8LjzYG
	pOX/VmmBx8JnrxsUh6ZnJnEc/JGF0/0ZRqUpyj3Yh46LuLdOGKlIGFb2XgyXijMT1N2fNEcoquD
	qvBK+eg==
X-Google-Smtp-Source: AGHT+IGGOy/7DPfAD2S53oxoNxAFPIA9YvV2rKfel7TZRF569ME2jo0FFwucpqaV4G4mJ/rNOyXjMQ==
X-Received: by 2002:a05:6e02:1fed:b0:3a0:9d2c:b079 with SMTP id e9e14a558f8ab-3a0c8d0c147mr31050585ab.19.1726842045596;
        Fri, 20 Sep 2024 07:20:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a0c022f1a3sm12813565ab.88.2024.09.20.07.20.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:20:45 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:20:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [TOPIC 07/11] New Contributors and Discord
Message-ID: <Zu2Eup+vjI3dALYu@nand.local>
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

How to attract new contributors? + Community Discord
=====================================================

(moderator: Jonathan N + Calvin Wan, notetaker: Emily)

* jonathan: we talk about this a lot 🙂 let's avoid the common pitfall
  of catering to the tiktokkers and the youths (hypothesizing about
  "current generation"):
* but, our contributor base isn't representative of our user base
* and our current contributor base doesn't reflect exactly the skills
  needed to improve git - like interface design is not our strong suit.
  how to attract people who are better at our weak spots?
   * taylor: this weakness is an existential problem for Git. jj,
     gitbutler, gitkraken, etc
   * mark: +1
   * peff: one size doesn't fit all, us deciding not to include a GUI is
     understandable, but workflow improvements like jj's are pretty
     interesting
   * jonathan: ex. in hg there's someone very involved in UX review. we
     don't have someone like that
* missing other disciplines - tech writing, product management, UX
  research, etc.
   * common problem in open source but would be cool if we could get
     good at attracting/retaining these people - and cool for the
     not-eng-discipline people
   * patrick: we could adopt a style guide or guideline but we still
     wouldn't be good at enforcement
   * john: people need to know what they can contribute to - cf. project
     tracking discussion later on
* jonathan: instead of trying to guess - can we think generally, how do
  we make work easier to approach? how can we lower the barrier to
  entry?
* patrick: someone is writing third-party rewrite of gitglossary. huge
  improvement over what we have, well made, but the person didn't want
  to come back to contribute. was afraid of the community giving
  pushback
   * patrick was willing to handhold this potential contributor, but it
     didn't seem like enough to make this person comfortable
* jonathan: related to community discord server - what does it mean to
  function better as a community?
* calvin: the entry point doesn't need to be discord, but we should pick
  some entry point that lets users contribute other than mailing list
  participation
   * and need to be able to navigate new contributions comfortably
* brian: how to write text that's accessible to non-native english
  speakers, for example? the mailing list isn't great for these kinds of
  changes.
* discord is proprietary, that is sometimes an issue
* moderation on discord is an issue - having an unmoderated discord will
  actually drive away contributors. that means actual dedicated
  moderation
   * balancing between sufficient moderation (list) and ease of use
     (discord)
* patrick: new contributors sending changes but the changes being
  ignored
* brian: git-send-email is a barrier, but so are PRs/MRs in some cases
* jonathan: the localization example is a good one - the translation
  layer is in github, uses a very typical dev workflow, and that's
  working well. there's a strong community there. are there other places
  we can do something similar?
* peff: can we do that with documentation?
   * jonathan: can we have a documentation maintainer? hypothetically:
     we hire a tech writer, and that tech writer acts as the
     documentation maintainer only. curating existing docs, making sure
     docs changes get good reviews, how to attract new tech writer
     contributors, etc
   * peff: can we manage documentation as a subproject that doesn't use
     the mailing list, and make tech writers' lives easier?
      * how to negotiate that with code changes that require doc changes
        is trickier, we'd have to figure out how to do it, but doable
      * jonathan: readthedocs
* jonathan: we don't advertise well that we can accept contributions in
  a different way if people are committed to the improvement
   * peff: sometimes a mentor can "translate" a contribution. Individual
     contributors are already interested in mentoring, do we need
     more/different mentoring?
   * mentoring list isn't working well yet - maybe it's too faceless?
     should we get a list of individuals who want to mentor?
   * taylor: should we literally put photos of the people on the
     mentoring list up somewhere? "here are real humans, they will reply
     to you on git-mentoring@"?
   * jonathan: in-person meetups help with this. emailing is
     transactional, but e.g. python meetups are interactive
* patrick: we had the git berlin meetup a few months ago, lot of people
  came, we did lightning talks and user conversations. it worked well -
  let's use that model more
   * taylor: hey, we can help spend money on that
   * brian: those are cool but for example, houston linux users group is
     quite small. meetups like this can be helpful, but it's not the
     only source.
   * peff: it doesn't really scale up. python users group are
     user-to-user, doesn't necessarily draw python project contributors.
   * nasamuffin: Gerrit has a community meeting once/month, should we
     use discord for f2f video meetups?
   * peff: if people want to do big group meetups great. we could also
     use it for 1:1 meetups that way, and advertise that it's an option
