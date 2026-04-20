Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729E51E5724
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776686628; cv=none; b=jy3WYx43nJAba6cnvf0hh0osvRSVFfmORhD46HqMlpyXwQK6Zds8EzDJwTo2g9H89eHg4l1Xf48rrzicCoczKYK5HPbSraAu4yuPPJqlFxoyriCdMLgiQz1vTxx8It1A8WWDJUJ9bPlhrANHW0RyUimUUKh3c9jjyi2c5qBbJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776686628; c=relaxed/simple;
	bh=ktPzv8bfxDo61EbcAsgFPHIfz3QRhiqNlvS/n/QWZjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IGumhnMhSw2kBQwnv/5E3KwT3A8XfBirI4wdKGhLVs9rQS/A4co40uWILVEHH9ccU8td+DJxphYDMKxV8Zv7b3QNe0xGVMcDCyVrixjcwGIIDogE+GvSXcbmDgikKZlhz7+qIX0Pvn00IKliVyNRxpMd1RBJQAYows2rchPclvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVxJfTPi; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVxJfTPi"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cfd122d78fso469003585a.3
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 05:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776686626; x=1777291426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wLkTroODAwrs8rnhF0VIWN5Pbbr1/oWLErRMzc2Bwiw=;
        b=qVxJfTPi5OMXn55PCFKcBfmzXqTdHFIWbcPjrbNxmmGT5XDLnblYW/C0cP0JKFYW+y
         xSuJNpvGqRaNPmO4MivNLaFzIGPUPBr3uEZZZ8LyyLOnmKLQdsmMwzb1hfWO+ZFiVz/P
         czBlyztEXrnS/9lIzcFKpgeMkaPd1Vf9jh7eBpLcoqJczBg2RxYJElatbF+pHHm0tnUV
         LAd7RUS0YS4yYx0ZX2tfznErHLBqDNeavmsXzzMXcVgy3hhC4XijiitpdqFLJDFhXdca
         6Iwmp3FFeVvYjZw64iVk7QbYEq4zLHV9gCJfwN4qdSsKeb7JubW+HWZNNvxoFRpQyEun
         eDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776686626; x=1777291426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLkTroODAwrs8rnhF0VIWN5Pbbr1/oWLErRMzc2Bwiw=;
        b=pStxCP3XJbYTX6deV+Ty/lI0tLGjD1D0PqkNpOahQG8NOZoj8I7rtCnsL3FAKdj7so
         E/V5TQ2rkfRnoX6WdA+o0QarRAA/AqK9sPUTBhLNGLbZ7R53OKJlcc+lsuFvZyahghfn
         l4uED56HuX8B4qP6aslc4g1PcG6OrIGd3AM72RpZTm9UStSKpLm0hcwHb3uK24SE4Qpg
         6lenjAH+6SAZnGHRICe0J2w7khghb5NClgVCPT8aYV0phuCaIw/SNXlSIevP5zH/AQuj
         QV+B/3vXVIWs+GPLwNUH0blglafeJ9W6JiN2oUdD+lgRuwY0K5Bk/TNNL13AnmLEFUGG
         BxSw==
X-Forwarded-Encrypted: i=1; AFNElJ9LsWLZNTUK1H1ep/WIfDMmmjkdB9EzD7cu9R+KSrhjsaUD2RDkWVHj4nS2I+SUCr4hJBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRFXAUROn2Miev0iIXqecxYZgPxekhzuU7ihX/AH0K7pvd+w03
	KCtXDdwLKIG3csf6J6Hl3yrgF0tPijj2fJpzsZMdBqmAsO6STYfUw7DrIHMOVj6Q
X-Gm-Gg: AeBDietHc06WoM7kTH6sxSpEWkV7Ut8f/Q/0l1PcFaVwHOE1D99oCVLRRZ1pXEwrdcc
	cg4ZDPRxVsqTPg/gKcHE1/qY6ARo6aKrfl9LIEJOIzqMWtX0mA3A089yhgbkOwam1C/vYJZwbPk
	3nlk99mT+1Dw7HXV/ghxmQVAX55o0CaSCHYXyU1IIQkVxjNVg7GyX4qiq7K24swe1z4QVbZYHFB
	DtdCbJ4ln4gLgfSTLCFriv0P+6zsohqmUSP3jASo40Xau/vihzrwBoHj2ruNuFKv1QgEtSA1w1+
	Sfk/Pp0Txnu9QV3c5CQV1AefyT2MDFHXw5BRWqLCHaGmVgdWiuaivIZ4tekDtI2cRt5E0sqNF1P
	W507Ivv0cYSetNJDG1Ddv4gHbCO+7QoS1JWRATGn/sYyri63lTPcCB6lnYPPV0Y4GjJHBxKDhyi
	nM80dvpCFcN57ce8fmhjCdvPVzpXfY/m/0bMyvM+A++ApBUaiHVasturjSdpTotN2RXRDrE2TzJ
	cuQXO4z
X-Received: by 2002:a05:620a:2901:b0:8cd:900c:cfde with SMTP id af79cd13be357-8e7916b1f5amr1805524485a.39.1776686625982;
        Mon, 20 Apr 2026 05:03:45 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d92ce037sm759288785a.32.2026.04.20.05.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 05:03:45 -0700 (PDT)
Message-ID: <55bde257-ee25-4a7c-a17d-c902aa4f0324@gmail.com>
Date: Mon, 20 Apr 2026 08:03:44 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] Move libgit.a sources into separate "lib/"
 directory
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/2026 9:24 AM, Patrick Steinhardt wrote:
> Hi,
> 
> this small patch series follows up on a discussion we had two years ago
> during the Git Contributor's Summit in Berlin.

Yes. "small". ;)
 
> I'm fully aware that this will likely result in some discussion, which
> is why I have labelled this as RFC. I'd be fine with a result of "let's
> not do it" if we cannot agree on this step, but I think that the current
> layout hurts discoverability quite a bit. Not only for newcomers, but
> I'm also struggling with it quite frequently.

I agree that the flat layout can be hard to navigate. While we are not
at a scale that needs something like sparse-checkout, but this wide root
directory cannot be reduced by cone-mode patterns. This is meaningful
only for niche cases like "I only care about Documentation/" or someone
testing sparse-checkout performance on a copy of this repo. It's something
that I do think worth mentioning whenever such a large refactor will be
undertaken.
 
> I also intentionally decided to send this close to the upcoming release
> so that the series can be merged early in the next release cycle if we
> were to agree on it.

There are two really big disruptions that this will introduce. I bring
them up only so that we can discuss them and make sure we handle the
communication to the community and appropriately time the merge of this
series:

1. It will conflict with most patch series in flight. How can we
   communicate which topics will be caught up in the rename before it
   merges, which will be modified at merge time by Junio, and which
   will need to be sent anew on top of this rename?

2. It will conflict with forks that have long-lived history that is
   merged with or replayed on the core project. The examples I know
   well are github/git, git-for-windows/git, and microsoft/git as
   discussed in [1].

   Something that I think would help for these cases is for the rename
   to be done as a solo topic merged into 'master' on top of a major
   release, such as immediately after v2.54.0 (or similar). This would
   allow a merge or rebase from the previous checkpoint to update to
   the rename without any other upstream edits causing further conflicts.

   Fork maintainers could then decide if they want to update their forks
   onto the rename early in the release cycle or as part of the next
   release cycle. My preference would be to update as part of the current
   release cycle so any changes during the release cycle automatically
   incorporate the change similar to working with the core project. (I
   am not a maintainer of any of these, so it's not actually my decision.)

[1] https://github.blog/developer-skills/github/friend-zone-strategies-friendly-fork-management/

Finally, I looked at what's left after your renames and I see that the
root directory has these categories of files remaining at root:

* Dotfiles that must be at root.
* Documentation that must be at root (README, code of conduct, etc.)
* Root build logic.
* .c and .sh files for root-level commands (git, git-*, scalar, etc.)

Of these, I'd be interested to see if there was value in moving this
final category of file into another directory, say 'cmd', 'commands',
or similar. It's the only remaining knob that I think is technically
possible to further trim this list of files.

Did you consider moving these files, too?

_If_ we were considering moving these files, then I'd rather make
one big rename change instead of repeating this exercise multiple
times.

Thanks,
-Stolee

