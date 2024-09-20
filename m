Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F93917B4FE
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842015; cv=none; b=UrmqnoDShEWr/13i0MdwYKcvI24LIBmI+nYmSMtFfFGkA7elB6A3mKgHKcgsns//ntssaNHFe/YtRvjOkaJGUs2sMEy9kNfRpgw6PIMTrt1io8lwL94YXTYr6KtY0aUO9AcoYbDzyNyix+yex/vdE5kqovbuCnhnmRbt77Y2K4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842015; c=relaxed/simple;
	bh=M61uZPLeTymspfnS7huicCkRyUHLcnUC5AzaUVBUQVY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr49w0FPXw18gemSMYVdcGfMvTlzPwscEZo1UAgCe9nMLApoBRU3fnxBE572JAGSHlsAIKxPHTRAavQojxjuq04R2ZfsMoX3BgNXA0mfMYMFDnXl9eZ4MZtx/y/Vo/V3S58w+MA6TETUuiqyd9xLVipgA1jFIHaFHrSRquspl+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=2PMGpmrN; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="2PMGpmrN"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82aa3f65864so78556939f.2
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726842012; x=1727446812; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQvserIrdmtaQlumS51cYpRoI/2PofSHJEs/TT9Ah6c=;
        b=2PMGpmrNO6byFqqYZd7IH+D6r6XelKL8GEzwpAuzzagVqL1TOd4RViLhJFHG/1pbL2
         gnvUTAib8HJLN6u6J7moXKWOI4X4uqTrqEwxZGagpcAT+avSL6GgLSGLPUqgdKYpFtfW
         iEc/s3NV4gd6UGyooxT0zySIPV+hAbw6+Z+P6ySq4x8dfknpZrydvEqz/adNXH8qvArU
         iDVKnPX6VV2TIsiOtGSeRYtNd0F/M0GpyGOPUq24rizSkwKAzC2UzrJUH6BXA3qqezyj
         PgZDWj977vtLMISXRiy3mWOp/GyWFiQ2tEvYJCbYkI9zG7wGp9R6GK9hzgCcZcfdSwap
         5qHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726842012; x=1727446812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQvserIrdmtaQlumS51cYpRoI/2PofSHJEs/TT9Ah6c=;
        b=qN5T0T7k0B/lZwwnOkPeo7j3VR8QaNAthLkHUBMmRSMOPvn0ejCPH9JbkWrf7QWVxd
         p8TdXG7otzaP7QNFibymf0RV8NmQ4ccRC+kLmJIW1uPNJZR1P+1SPia3E796lVEwES7W
         omrdF3JEIpXNNwXf/GTGG9r1vVpfkvCEKr8Axy0GrEOjYYvPTcwzjwcFmDckZiw4gj2r
         hl3B8tV8IFDlNkORC2XP3ILioz73l8BIqGfsga0AvqokULnYqOOI2/Sls2J4kNbEQ0Il
         kPtK9TQH8YcD6Z0apjRaK+FkN5P2k8JwDzNKmqG3LCJtr6pTTZccXOefy7wDhwpCvXt5
         zo8g==
X-Gm-Message-State: AOJu0YwbB11dlQ9zyI5ZeYDsorfRmx2bb/7NYoGcHeRTmeYq0e1o75NY
	aKR7W9dgCjqqRncPppmZKL8VPdf5OKbgQv6e30IGbFKLqR4mPwoCFK/CrBJLOI/yrjPz3Ecq/NJ
	b++kdGA==
X-Google-Smtp-Source: AGHT+IGbWkByfrhrluezQtB4mYwK8zv46m7gQU5Y4pB6ySABZo5PK4agV3eZSGp7b1Plrrlo9jf0PA==
X-Received: by 2002:a05:6602:6c17:b0:831:fe52:c602 with SMTP id ca18e2360f4ac-83209eabdb1mr388739139f.15.1726842012122;
        Fri, 20 Sep 2024 07:20:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed13d3dsm3580078173.118.2024.09.20.07.20.11
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:20:11 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:20:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [TOPIC 06/11] Git and Software Freedom Conservancy
Message-ID: <Zu2EmO+DkoH83S0Y@nand.local>
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

Git and Software Freedom Conservancy
====================================

(moderator: Taylor; notetaker: Patrick)

* Taylor: Sent out new mail to the list with SFC activities.
   * https://lore.kernel.org/git/Zusxcweod1O88h7j@nand.local/T/#t
      * LOTS_OF_MONEY spam alert
   * Generally have more money in our account than we know what to do
     with.
   * SFC consists of 4 persons: Junio, Taylor, Ævar, Christian
* Taylor: Trademark discussion
   * Enforcing the trademark is untenable because there are so many
     projects out there using "Git". We cannot go after those to defend
     our trademark, and would also not be in the spirit of the Git
     project.
* Taylor: Money
   * We've got a large amount of money for an OSS project with few
     expenses, $90k USD.
   * Heroku is our biggest expense at $60 USD/mo.
   * What can we do with this money?
* Chris: Mentor Outreachy this year, we'll likely have to sponsor them.
   * $8,000 USD/student. GitHub can probably cover one or two such
     students.
   * GitLab sponsored last year, but getting funding was taking a very
     long time on their side. John probably doesn't want to repeat the
     process again due to the hassle.
* Jonathan: Git gets money due to GSoC, too. These kinds of mentoring
  projects are things where it's easy for donors to justify giving.
* Chris: We do get money indeed due to the GSoC mentoring.
* Chris: We have tried to sponsor travels for GSoC students in the past
  to come to Git Merge. Was quite easy to do that with our funds. Covid
  restricted that somewhat.
   * Students used to have problems acquiring a visa, creating a catch
     22 because we had to book the flight up front, but it wasn't yet
     clear whether they'd get the visa. BUt without the flight, they
     wouldn't get the visa, either.
* Peff: THe wasted money on that is probably small enough compared to
  how much funds we have, so the risk is comparatively small.
* Jonathan: Do we have a rough estimate around how big yearly influx
  minus expenses is?
* Taylor: The exact year is $93k USD. It's hard to tell exactly due to
  changes in reporting by SFC. Last year it was roughly $89k USD, so
  only up ~$4k.  Typically we have a yearly income of around $10k-$20k
  USD/yr.
* Peff: if you want something, would be relatively easy to run a
  fundraising campaign for Git
* brian: I'm sure that we can easily raise additional money via
  individual contributors, too.
* Jonathan: If we have the money for it, I think it might be relatively
  easy to justify hiring a full-time community manager for the Git
  project, for example.
* Peff: 90k is a high amount of money to do small things, but it's not
  really enough to actually sponsor full positions for an extended
  period of time.
* brian: True. Nobody is going to work for you without insurance, so it
  indeed isn't all that much money indeed.
* Jonathan: Edward Thomson also mentioned that libgit2 passed on some
  money to other projects that can use it better
* Emily: also wanting to spend money on contracting on particular
  projects
* Brian: there are people who do contractor work like this. I just don't
  know whether we can find somebody who is willing to accept taht little
  money.
* Emily: Developers are expensive, tech writers are a lot cheaper. Would
  that be a viable option? They could for example rewrite lots of our
  documentation.
* Johannes: We could delete obsolete documentation!
* Patrick: I tried to do this on the GitLab side, but it never really
  worked out. They didn't want to join the Git mailing list.
* Emily: Same.
* Mark: There would be some concern about having tech writers interact
  with the mailing list flow.
* Peff: Ævar is not active on the PLC anymore for a long time. Should he
  be removed?
* Taylor: We've been talking about that in the PLC. There are two
  options:
   * EIther remove him without replacement, such that we have three
     people on it. That would also make it less awkward when it comes to
     voting ties.
   * If we replace him, it would almost happen to have to come from
     someone who isn't affiliated with a large forge / company. We
     already have representation from GitHub, Git Lab, and Google, so
     would want an OSS contributor not affiliated with a major company.
   * Ideally I would like him to come back, but haven't been able to
     hear from him whether or not he is interested in doing so.
* Michael: The trademark was originally owned by GitHub?
* Peff: The git-scm.com web site was originally owned by Scott, was then
  moved over to SFC. The SFC applied for the Git trademark, came to an
  agreement with GitHub about details of how it would relate to the
  GitHub trademark.
* Michael: Is there any obligation of Conservancy to GitHub that the
  trademark is enforced?
* Peff: No.
* Michael: Background is that the proposal was to stop enforcing it. SO
  the question is whether we have to due to an agreement.
* Johannes: You lose the trademark if you don't enforce it in many
  different countries, so we either have to or don't and may thus lose
  it.
* Chris: We mostly enforce it by privately emailing e.g. website owners
  that use Git in a way we don't agree with. So we do enforce it as
  necessary, even if it only happens very infrequently. Some companies
  do not register a trademark that's conflicting, but they still try to
    use it.
* Jonathan: I think it would not be a good choice to not be assertive
  about the trademark at all. On the other hand, filing lawsuits against
  low-harm cases doesn't seem like a great use of time and money. So I
  feel like the current balance is sensible.
* Peff: SFC's lawyers might disagree with that assessment.
* Taylor: They want to see some new version of the trademark where we
  e.g. only enforce our trademark on the logo.
* Chris: We raised the question a couple years ago of what to do about
  the trademark, and folks basically agreed with the current way of how
  we handle it.
* Brian: Debian has a trademark policy that might be sensible to have a
  look at for inspiration. It e.g. says that you have to communicate
  truthfully.
* Peff: We have similar stuff like that in our policy. The problem is
  that back when writing it we had another company that was trying to
  use the trademark for a "shitty" reimplementation of GIt, and we
  didn't want that. We don't really care for "git-foo". Dashed commands
  are explicitly allowed. GitOxide is e.g. technically against the
  trademark policy due to being CamelCased, but we are fine with it.
* Taylor: We cannot do that, we have to consistently enforce the
  trademark. It needs to be very strictly defined what is and is not
  okay.
* brian: it needs to be definitive whether you're doing the "good" or
  "bad" thing.
* Jonathan: It might be interesting to tie this to compatibility with
  the Git test suite. SO if you pass it you are allowed to use it,
  otherwise not.
* Jonathan: So IIUC, we have questions for the SFC lawyers because we
  canot really answer a lot of the questions?
* Chris/Taylor: We can do that.
   * Taylor: We will talk offline to figure out who does what.
