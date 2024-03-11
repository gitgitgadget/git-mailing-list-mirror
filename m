Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DCD4D5AB
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710190758; cv=none; b=iZXNjbt+brdt5mTEuMPX/+tjNtAfMEvq+YGC17pC8yzYYbk4/1lq9bGiNAuuCw4uqseDvpxIUu7WxMe7DBD9CESAC/HMAhLiIYsqC2F79ZshYM3Y/XH6/oHCKaTr6HnPI/0J7LwArcnlzG5U/KutgjxRcNGG7ncd6Mwejwt/SM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710190758; c=relaxed/simple;
	bh=ly8jOo4GKlUZz8+Z+43BGniNhUkO07aVp10lSkdFfco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TshTl+nD2B6KaALTozzjaiZdVhS8KNR7cUeooSlAdJyK4S1z4cGbjbE4SpfsW0ZHo9DWSSN+xRsj6lB9oCivEFqBgm6LhRGsrrgQ1x7BDIrEeZSp6I/XGxtm+i1qGaoNZmHGNuUgHk6lP7OcqXnhp6gYRMDXjv2pbWOtiNQa/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Na+rDyJr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Na+rDyJr"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e162b1b71so4562748f8f.1
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710190755; x=1710795555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Whgx+7mYyyVfZs7lsq6Ttfl4qRDvJwIoVEoDq+sZ84=;
        b=Na+rDyJrX3Wgk98+NT27twJ+3GClpjriu980TfIDUG1tAI/Fa0Z99V3MLQDYqaUYOX
         qDbzviFzY0hlsSGvxyQ6Cw6NjjO7odguYSr+A2yu+hmjkzxLYSm0AyCj9bPkvupGJKmC
         wDPvXYHYZRkGmQd6Q/41C8mM7+75CArkGeqWa+QQwVZAGAMQXzRez6nfUi52B+u/2h+3
         kFWQC4x55OhVWKB5ho4LF3ANaeSHTUWW/va6fUpj70fpUK0EBDXCmd86JeEDN7SPa8TD
         i6avpH63ShJpvHocSaFV2KHR0AslU3xDJKjhx+EEhrf/42PUb/BEmLfLhDGeIIYhCbiw
         Gikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710190755; x=1710795555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Whgx+7mYyyVfZs7lsq6Ttfl4qRDvJwIoVEoDq+sZ84=;
        b=sGfrpIbZaogaxGFxMngAhwVPGHIv6DzylxYEh3DnjCaSPm2r3cxawt79piHOnKvMJR
         egvHFVaB+l7oqPDci4hU49NBHTcO4zbCSPancWeM7uZS+qv/9/tgehwxNcsykrUpSanR
         S8W93AcJ1X8LMGsIFN/JAg6w5rE889ePndKGMD6ChOI2gFbOgU9RW77r9fx1tvBe4J4Z
         LESzB6IdGAf/QlDN7kW4NdAZWyaF/f9eu3Wno1MH6BPN1h5+y0GsyLFF7HMRZ2RuPhb0
         Fy+2fCLLMrfQv38xuvJcWqIjgeR5k6iLAdOP39YPbVTVWC8TTkoGkKogujENMM3KMlIp
         Ngvw==
X-Forwarded-Encrypted: i=1; AJvYcCXJLNQPGUjZfzkRrjIwC/S3HnqPUM0GFwc4AlbEhlkbJsxCi4Y1Ld57fbN9q+iERi2/QwIAzWxCxeu8F12s+SN4zzXX
X-Gm-Message-State: AOJu0YzPSwrAz+6vXn0MIfLuTZSAMFdF66sZ9kQXnwlyePPzRcliiH/E
	/xVeLU7KAQgMGyNIFlPc3GWhr7i/jqlVSe+0VMr+leywaTt8GYzT
X-Google-Smtp-Source: AGHT+IHvi4sGFb5+pYaPzRY29S/G29JxzKOIc9l+p9/xXRvOq0uMJQA5f0CQ58mNQh7oBe7xwN8aqQ==
X-Received: by 2002:a5d:4ac3:0:b0:33d:7e9e:4eb with SMTP id y3-20020a5d4ac3000000b0033d7e9e04ebmr63268wrs.12.1710190755010;
        Mon, 11 Mar 2024 13:59:15 -0700 (PDT)
Received: from gmail.com (205.red-88-14-55.dynamicip.rima-tde.net. [88.14.55.205])
        by smtp.gmail.com with ESMTPSA id fm10-20020a05600c0c0a00b0041330de9587sm1011885wmb.40.2024.03.11.13.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 13:59:14 -0700 (PDT)
Message-ID: <4e1abd12-d73f-41b2-a334-036be9093485@gmail.com>
Date: Mon, 11 Mar 2024 21:58:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Allow disabling advice shown after merge conflicts
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 ZheNing Hu <adlternative@gmail.com>,
 Philippe Blain <levraiphilippeblain@gmail.com>
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
 <pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, Mar 10, 2024 at 07:50:59PM +0000, Philippe Blain via GitGitGadget wrote:

> Range-diff vs v1:
> 
>  1:  e929d3381cf ! 1:  a2ce6fd24c2 sequencer: allow disabling conflict advice

[...]

>        ## advice.c ##
>       @@ advice.c: static struct {
>      - 	[ADVICE_RESET_NO_REFRESH_WARNING]		= { "resetNoRefresh" },
>      - 	[ADVICE_RESOLVE_CONFLICT]			= { "resolveConflict" },
>      - 	[ADVICE_RM_HINTS]				= { "rmHints" },
>      -+	[ADVICE_SEQUENCER_CONFLICT]                     = { "sequencerConflict" },
>      - 	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse" },
>      - 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
>      - 	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
>      + 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated" },
>      + 	[ADVICE_IGNORED_HOOK]				= { "ignoredHook" },
>      + 	[ADVICE_IMPLICIT_IDENTITY]			= { "implicitIdentity" },
>      ++	[ADVICE_MERGE_CONFLICT]				= { "mergeConflict" },
>      + 	[ADVICE_NESTED_TAG]				= { "nestedTag" },
>      + 	[ADVICE_OBJECT_NAME_WARNING]			= { "objectNameWarning" },
>      + 	[ADVICE_PUSH_ALREADY_EXISTS]			= { "pushAlreadyExists" },

You rename ADVICE_SEQUENCER_CONFLICT to ADVICE_MERGE_CONFLICT and place
the new name in the correct position, alphabetically.  Nice.

>        ## advice.h ##
>       @@ advice.h: enum advice_type {
>      - 	ADVICE_RESOLVE_CONFLICT,
>      - 	ADVICE_RM_HINTS,
>      - 	ADVICE_SEQUENCER_IN_USE,
>      -+	ADVICE_SEQUENCER_CONFLICT,
>      - 	ADVICE_SET_UPSTREAM_FAILURE,
>      - 	ADVICE_SKIPPED_CHERRY_PICKS,
>      - 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
>      + 	ADVICE_IGNORED_HOOK,
>      + 	ADVICE_IMPLICIT_IDENTITY,
>      + 	ADVICE_NESTED_TAG,
>      ++	ADVICE_MERGE_CONFLICT,
>      + 	ADVICE_OBJECT_NAME_WARNING,
>      + 	ADVICE_PUSH_ALREADY_EXISTS,
>      + 	ADVICE_PUSH_FETCH_FIRST,

Here, I assume you're trying to place the new name correctly too.
However, I see that it's in the wrong place.  It initially caught my
attention, but then I realize that the list is not sorted.  So it's
understandable.

Maybe you want to sort the list as a preparatory patch in this series
and so we'll avoid this kind of mistakes.

Of course, this does not deserve a reroll.  We can do it in a future
series when the dust settles.
