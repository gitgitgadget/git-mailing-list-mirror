Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282DA1D5146
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 03:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330932; cv=none; b=CUlqzw0b26TZQxS98CpUUKn2fRcCbN+lc3zxSuRSndTbTpuFPDQo3Q5bDfj9DXRj5ShPVzvf6ZJlAN8GpeTawoJCCihsdFwc0paT9dLw7iK687OWI7fSVL54D9K1v3hh2Cz9ZuN/cqKGQW+3qaqR2SnJw1QpDTbdaghfLEtZglw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330932; c=relaxed/simple;
	bh=mbE8kgwt87kAL0mfKGzHEVj62NeGW3+yq+RFVzYRU9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLO1InxRutpin4zFTn5JzoNfPA9f+zFo2B8WgahowZHMRZfJzUSIywf6ClIDsQpEHeO+tGtYBlxg3E0UJiF/X0aKdr/TIyvb5fej6htwspWfkeTC/ph1JIAnJ38wyVxoKndUcGazJCx2rPprXPPkz4uwwJpzsfRPbpfaLEm3HLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eW1FcGRE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW1FcGRE"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f44353649aso9320432a91.0
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 19:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739330930; x=1739935730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7yq4YyDFrHgVmuyHBC1Ev8aoYJmPWAoMxlbYwvIsqI=;
        b=eW1FcGREk9UnTXF2MXlusayIo+rSVF0aBxIfGPWFLlgcBsszZGM/3X25Q07GaJxgoX
         IqWShPSydDK02+3hoCo1NGWjNTZHBSMbtrLOIvPCkB1FD5RD4IVAiOsywcMPwwUi7Ppy
         0VHz3w6UMQ1IeWv2v9TTNBtVeA0IcrDVaFJ6O8nA6YJ1D2LSgz+MSPgb3I8aLrQG9+nY
         qeR+UwO9YRILyfiV00+QUXhKrr7tcl93CC9xm5qaoMoCHsyCUEdpmpVkbDqLTr3CUCUI
         4eebBX/DV4ahRbrxANjqXOhi4VPA3gsQ7lrsQJ32cjY9UWTmWNoMYsxAKmg+7rDjhHh4
         cbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330930; x=1739935730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7yq4YyDFrHgVmuyHBC1Ev8aoYJmPWAoMxlbYwvIsqI=;
        b=T+e9y9ZqN7WoVdjBQrdR2jgKyvpj8AztuHG1zlT01Jl9T+Gl3BPA3UB9BY3DLeiXy1
         Xtk1BZdEi59YD3+HHPA+u12C2y3q+dTkL3rpt628r89OXWCgrqwlVgi0QUc+x+IYY4OQ
         oGmrFc6BIbegIV9QLkLDXRe1ykHRc5k536tmMUia+NU+uIxS6C9ZjiFMaNa4GNUtDdUD
         tL9eGEdIygUYBZQB4gkmg8yH3sXPUu34iNsVKPl6KYdQ5p6dMbHTBtmhvd95zXrJ7NTv
         BBQNa6tRMfjNzXR5Coq8qsNtk0X71b692ApVlMcnTiJgfFfvWKF/5K2ibdInNKJwJNMK
         JFFQ==
X-Gm-Message-State: AOJu0Yyzjbj8IXq+DEY18bR26rgv+rMkT8LRHBC9kltpDKAtjy5JxFcA
	32oB5nzzml+8mCG1CLKNCdrDtgN9u9q+e1qs7+8GEN8jJfQuLNAwf2gAZRcu
X-Gm-Gg: ASbGncsWq/DfenGBdJblN1KopT5fZ6c/Ik/kf90CJG7LBzsD8S1meW6CRAE+cyUKiFg
	VeDR0rL/4k2rJPL6gExeDJrn8KobquSxbGsYgILqazpIVZaLZBDbqY9jAmuHuvpeox75BUo7Yna
	oPeJd7WvQYDQWpTU+VZjTSUOJ+IOxE4kRShpebE/sgNUcnVjoteD1mjFru4aI/oEK04Gpk0ZF8u
	kJTrb9yLvuVxHksz+Ks0dt32XcB0H5QL2qOGvqDWsUYfQeunOkW+jcO5OnfoMDkq878lQbmSX+t
	RRLx6wUIvexiBQf4ttpBV+Jvv9SxMEnbvD2C80T2CRbQXLYflalXCC14WjD82KfJRw==
X-Google-Smtp-Source: AGHT+IG0wjJfVc9NpEDAc9bP21aYmx9BkogA2x/EXrmH2xUvyAIQCh6qT0yPPUlvXU6ZIPgah51azg==
X-Received: by 2002:a17:90a:d404:b0:2ea:3f34:f190 with SMTP id 98e67ed59e1d1-2fbf91067abmr1761116a91.25.1739330930193;
        Tue, 11 Feb 2025 19:28:50 -0800 (PST)
Received: from ?IPV6:2601:647:5580:5760:508a:741e:539b:1c5c? ([2601:647:5580:5760:508a:741e:539b:1c5c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98986d7sm327769a91.6.2025.02.11.19.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 19:28:49 -0800 (PST)
Message-ID: <ceab16cd-1b26-453c-a326-d76f16b35814@gmail.com>
Date: Tue, 11 Feb 2025 19:28:49 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 0/10] Long names for `git log -S` and `git log -G`
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
 <20250211085028.3923875-1-illia.bobyr@gmail.com> <xmqqwmdwxsmz.fsf@gitster.g>
From: Illia Bobyr <illia.bobyr@gmail.com>
In-Reply-To: <xmqqwmdwxsmz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/11/25 10:07, Junio C Hamano wrote:
 > Illia Bobyr <illia.bobyr@gmail.com> writes:
 >
 >> I've split the big change from v3 [1] into multiple, mostly 
independent patches
 >> to make it easier to review and merge each one separately.
 >>
 >> [1] 
https://lore.kernel.org/git/20250206014324.1839232-1-illia.bobyr@gmail.com/
 >>
 >> Patches 1 through 4 are fixing minor bugs and inconsistencies.
 >>
 >> Patch 5 contains updates gitdiffcore to use same placeholder names 
as the rest
 >> of the code.
 >>
 >> Patch 6 contains a minimum change to add long versions of -S and -G.
 >>
 >> Patch 7 adds bash completion support.
 >>
 >> Patches 8 through 10 increase usage of the long argument versions in 
tests, CLI
 >> help and docs respectively.
 >>
 >> Please, let me know if you prefer it split in a different way, or 
reorder the
 >> changes.
 >
 > When you base your patch on a different base than 'master' (or if
 > the previous iteration of the topic has already been queued in my
 > tree, then the commit used as the base to queue the topic), please
 > make sure you state it clearly.
 >
 > This iteration seems to apply on none of bc204b74 (The seventh
 > batch, 2025-02-03), on top of which the previous round dcc02caba2
 > (ib/diff-S-G-with-longhand) has been queued, or any of the recent
 > tips of 'master', like 388218fa (The ninth batch, 2025-02-10) or
 > 9520f7d9 (The eighth batch, 2025-02-06), so I cannot look at it.

Sorry for the confusion.  I randomly decided to check if my changes have any
conflicts with `next` and rebased on top of it.
Did not realize it would affect the patches.
I've rebased back on top of `master` and published as v5.

 >> I was not sure if I should include a reference to the previous 
version of the
 >> patch into the next reroll.  It seems that
 >> `Documentation/MyFirstContribution.adoc` suggests so. But it creates 
very long
 >> threads.  And I've noticed that not everyone is doing it.
 >
 > Almost everybody does so, actually.
 >
 > Taking a topic that has 5 iterations, each about ~20 patches, as an
 > example:
 >
 > 
https://lore.kernel.org/git/20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im/
 >
 > it is perfectly clear and easy to nagivate from the list of messages
 > what discussions we had in previous iterations.

Thank you for the explanation and for sharing an example link. I'll use v3
cover letter as a reference point for v5, as I have already interrupted the
reference chain in v3.

 >> Reply to review notes ...
 >
 > It is more customary to Reply-all directly to review messages,
 > instead of sending new round of patches.  When the cover letter of a
 > new iteration is sent as a response to the cover letter of the
 > previous iteration, readers can find the previous discussion
 > messages.

Got it.  Thank you.  I have replied to your review email, so that we can
continue the conversation there.
