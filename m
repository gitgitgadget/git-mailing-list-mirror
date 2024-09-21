Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A344717332C
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726938138; cv=none; b=L+OqOxANTb7saEHR5QJ48F6tDRZ1uztzgGav6yuZvEgqHcaSj1LB82NNnmaSkDOSKDWonzSBfPz2Y+bqhgI269Vsm9Z3ubMRzDhO5rGRIyZvEDc8aMlwl2QJf+uj5S4WXDQe5HNbAasODZV3JSY6owm99q7s2nE+r5G3oFFMuXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726938138; c=relaxed/simple;
	bh=dmx+597TDTxSRCwleaDtH2cHgD27YRK4X3eVsXzTlNw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cTuWxFoGdCDl5qhDmStOj+mcKnJPzqpG2ohEJCPq3izZcT4VawM8fW4cIW0gewi2xu1h4hV+vyWJH6Pf3VrcgLATtrST0sX09NO+oJVYyD0I3SOM3DrwK9NM0496mGpEfLVg6dMGxVQhM2PzFSuiAOni1RwiIAytDx78n+fDtg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVCYL99k; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVCYL99k"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20536dcc6e9so20984785ad.2
        for <git@vger.kernel.org>; Sat, 21 Sep 2024 10:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726938136; x=1727542936; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5s0EAoRFLqnr2KMldLT1I6OxN2cuoX4XimtYJ3VgMh0=;
        b=LVCYL99ksKNMcdjgJiRoNFOgV+xFLK7GjxqODKJRaGCDUrW1kltMOtVIu/MNT92myo
         6+0ksrEWanALnkpBX/Cni2k+Bk2JLWcRiAjeLkKek2gzpI6q0rLiF/wekN2x20I35j5T
         AjhjkpaFUi7vPAhaamJVqP8XS2tomefVQZAtNlTIXrzCUPND8Dgrr6M4QOAwEEbLRbxu
         nhGX0Bp1gpSSqpVu/HDHjYWXdhC1v+3cjPGs6pajMRT9nYizgZrdTX7xuLWAFOl9XEK3
         /+B+QlBM4zHn2JKbcsThM39ipepLnhqQ7Hh84lEz27ihQWUe+45xyLq6VwHpGd9xjfwR
         emeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726938136; x=1727542936;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5s0EAoRFLqnr2KMldLT1I6OxN2cuoX4XimtYJ3VgMh0=;
        b=oEiexnU126ZfMwyKVtiRD/iZeZNMUUyFDiyRkcDYZnUGLI0xuM/yN0EIGzGJbA9CTy
         w5PO35e0O9i+edjzQSFl2GZO+WmDc2doMpTU85aY6MIgXdxtkawrr6L03ATc8myhRsS4
         W6rzmmin9IvuVOSiSSp7VTeNR0f+Hmcpl+7oEJ17xD/jfi4hThRs4g/tTbUld30XI9hd
         FftF1aSiMuELmPYoofKtOupi2o9i2cgYfedDCe3IT5d6hlh9i7npuRe2iCatfnhT8l96
         UWFZT/+Wny94Xn6LM04/bc826cCGPjFRKXpioHEqjoUSiZILT6ti+HRandGX9i96PeCx
         2JRw==
X-Gm-Message-State: AOJu0YzWFJSnCUHunenVhPEtzO0ceq1oBoFFSs4+lRfIBkCEv2B3uTUa
	9g2Qqe16HZ3VZJrwibaGG1bv6yuLPAZSs7kAdTia6LagHqrgh1qzqgCRgA==
X-Google-Smtp-Source: AGHT+IGDbicgv99bbKAAADx1fr5LAcq4eGeSrIFgIhm8JIeVuslNdSGnyWRbqPlbS7WblYdwgN9k/A==
X-Received: by 2002:a17:902:f707:b0:206:9399:5dd7 with SMTP id d9443c01a7336-208d842a7c4mr98572945ad.56.1726938135684;
        Sat, 21 Sep 2024 10:02:15 -0700 (PDT)
Received: from five231003 ([2405:201:c006:3236:afed:f558:cb10:4e5d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079473d0b2sm110564345ad.279.2024.09.21.10.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 10:02:15 -0700 (PDT)
Date: Sat, 21 Sep 2024 22:32:11 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [TOPIC 07/11] New Contributors and Discord
Message-ID: <Zu78E+0Uk5fMSeQv@five231003>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zu2Eup+vjI3dALYu@nand.local>

Taylor Blau <me@ttaylorr.com> writes:

> How to attract new contributors? + Community Discord
> =====================================================
> 
> (moderator: Jonathan N + Calvin Wan, notetaker: Emily)
> 
> * jonathan: we talk about this a lot 🙂 let's avoid the common pitfall
>   of catering to the tiktokkers and the youths (hypothesizing about
>   "current generation"):

I guess I would fall into the "youths" category ;)

I started contributing about a year ago although most of my activity was
during the GSoC'23 period.

> * jonathan: related to community discord server - what does it mean to
>   function better as a community?
> * calvin: the entry point doesn't need to be discord, but we should pick
>   some entry point that lets users contribute other than mailing list
>   participation
>    * and need to be able to navigate new contributions comfortably
> * brian: how to write text that's accessible to non-native english
>   speakers, for example? the mailing list isn't great for these kinds of
>   changes.
> * discord is proprietary, that is sometimes an issue
> * moderation on discord is an issue - having an unmoderated discord will
>   actually drive away contributors. that means actual dedicated
>   moderation
>    * balancing between sufficient moderation (list) and ease of use
>      (discord)

I don't know if we get new contributors complaining about our workflow
being centered on the mailing list but I personally find the list really
intuitive to work with.

Even if we do eventually move towards a more "user-friendly" interface
_for_ new contributors, they may still need to read through history for
certain changes they maybe working on, ON the list.

> * patrick: new contributors sending changes but the changes being
>   ignored

I do remember the time when I first contributed and was anxious about
the reply but I guess even if someone else doesn't review a particular
patch, Junio gets around to it eventually (which is not ideal, we want
more reviewers...) so they are not completely lost... everytime.

Although it would be great if there was some kind of an interface to say
that this patch is a new contribution to anyone going through the
messages similar to what Calvin said above.  So that if the patch were
simple enough then maybe some of the newer contributors may also have a
go at reviewing the patch.

> * brian: git-send-email is a barrier, but so are PRs/MRs in some cases

I think the main barrier is the configuration of git-send-email rather
sending the patches themselves.  Since most people have gmail accounts,
the setup becomes a pain because of the two-factor-auth and creating app
passwords and for someone who is mailing a minor change, this indeed
feels like a lot of effort not worth the time or energy.

> * jonathan: we don't advertise well that we can accept contributions in
>   a different way if people are committed to the improvement
>    * peff: sometimes a mentor can "translate" a contribution. Individual
>      contributors are already interested in mentoring, do we need
>      more/different mentoring?

I think having mentors would be great thing.  Even if it is not 1:1.

Another thing that would be great is having a list of things on which a
new contributor could work on.  GitGitGadget's issues used to do this by
tagging the appropriate issues "good-first-issue" but I guess it is not
properly maintained anymore.

I know there is also searching for "#leftoverbits" or "low hanging fruit"
on the list but the "good-first-issue" tagged issues on GitGitGadget are
probably more new-contributor-friendly than whole email threads.

>    * nasamuffin: Gerrit has a community meeting once/month, should we
>      use discord for f2f video meetups?
>    * peff: if people want to do big group meetups great. we could also
>      use it for 1:1 meetups that way, and advertise that it's an option

I think we hit on this topic last year too in the virtual contributor's
summit and I agree that having a regular meetup would be great and
something I personally would very much look forward to.  This would also
help put faces to names.

Not exactly a regular community meeting but Review Club was kind of a
large step towards this I guess.  I was exactly in one review club
meeting and it sadly got shutdown right after that :').
