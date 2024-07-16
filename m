Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B691CD2C
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158433; cv=none; b=Z3rH7RkZVpXIaH6mjxbgyXYB+caK9dTd0dM9FUWqM4H5CVTrJ2o+OqF9ZHagceQBK/O2RxCkKfbWPpVxFabP2OyAgoYtMEyKzOoGKsA/mIKPT8HF1uHnMW+cMiXRJweyxSFZUT0KD83iousQR91QO8Dv3knsmsebM6/myw+A39I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158433; c=relaxed/simple;
	bh=RvxKTGgKVS6tfw41DswlPu0LfFFoXvjxheBUdU3MSdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXLtPBxgE235tXTmEzAWL0qb7tP5fKnDQ1y66V1yr2oPpvqGnQXbvfI4fH9YwnU+u1BpiS37E+nPVWr25J1jEGWyAqMBeov5Hp2o90068MKMSdqN12oYhvMBXJp1MlX9kMS6L0OfUNhMZ0q+vfmjsZMzgXS7JuhMr98MTxJD2qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSmTrkwC; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSmTrkwC"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-75e7e110e89so3541508a12.3
        for <git@vger.kernel.org>; Tue, 16 Jul 2024 12:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721158431; x=1721763231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EWdLeVnNZEHR4xkE9/SiGBt2n1ZrcxnwOLDx7iDwsqY=;
        b=cSmTrkwC3OmbCphcStZligkOuwEI7D8mfJ/lCur1CC2naeAdJQl5qLsDeeg+dkMRX7
         aOUYKry5gLBDUOkqquxpwjcfMsoEcXbgZW0OChPYHsBoXs9h5owGSFz3NeDwWfM4E//I
         iQlcRCujWeXd2bQw5P/bgEBvupDtB7IpEpmM+gl3MjH78yVDIIEhN53uEJh7sdD8Nc1B
         6RRLk8v6GiNqWe3RZxyaanX6oDB5PlHkWjubdS2ZbYVuaP5b4r0m2N9nHolcDS/QnNQ1
         IauFRjjZYaWCoWdAiKt0lhXHB9DzC6baeUKsjJEV41nxDbbiugiRCK4eL/eCQ/FiJis5
         wkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721158431; x=1721763231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWdLeVnNZEHR4xkE9/SiGBt2n1ZrcxnwOLDx7iDwsqY=;
        b=NR14EMGrSSJnV2hTaQCjA2DduBV+xhwo92EkCpR8VbcX28TainbAKdVr9Xbz7wdu5t
         f5mYMYTU8eZH+ZG4Kq60gCDwD4zXhJzYs4VveX9sKYhJ2agBNX2MR5oUV+9mm/+WX6Qx
         RAebEbQX1IPo3Djx/7q1oXA3hbeRKv7xbNCkoLSBak9wzqCSkdJVWHp9Fy6vT3eQBZcm
         Vr02eJwdJUN8XvkGWtRa0pra+s2MlGkSiwEeedDZccglOhy+zxK4n3XvP9KAUl00UojC
         umUZUdi25ovzBupCdlQuH5hNnhtYCtAo7zH24DDwR1nUsHIyMgt6Km7oPyG4IiEuqVYg
         cALQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC3M5/mWJMvrXnchEuAj6VB4ZqVzGulfw5FhzyIAX0C1UhpRfCPqJzremo1xTkHMFhjjzBhV9Ry+bBN5vYFmvG9aAF
X-Gm-Message-State: AOJu0YymaRICn+WovCSnmYoarJV1w50wxnTDlTomPiR6ntpJQZqeBTI1
	IDe3VXSZHCA4rkSfWiZN0H8LgylkhjnC+2nbKtoH9QS3vnjgBDvI
X-Google-Smtp-Source: AGHT+IGNvi6x3A8dXrsR4eA1Jm4Sj+6Z5oBABbyHbGcr83cCjghp1FKv/vPOhIFGI3ezfmpBWAXIJA==
X-Received: by 2002:a05:6a21:118e:b0:1c2:8d0a:8e9a with SMTP id adf61e73a8af0-1c3f1256da4mr3672075637.31.1721158431153;
        Tue, 16 Jul 2024 12:33:51 -0700 (PDT)
Received: from archP14s ([193.32.126.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb7007csm62247725ad.14.2024.07.16.12.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 12:33:50 -0700 (PDT)
Date: Tue, 16 Jul 2024 20:33:44 +0100
From: Matthew Hughes <matthewhughes934@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Matthew Hughes via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] userdiff: add builtin diff driver for TypeScript language
Message-ID: <20240716193344.bjb62zsfnrfw3ngf@archP14s>
References: <pull.1746.git.git.1721061218993.gitgitgadget@gmail.com>
 <20240716122112.zqauqgxmng2tk2j6@archP14s>
 <xmqq5xt5bat7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xt5bat7.fsf@gitster.g>

Oe Tue, Jul 16, 2024 at 08:45:08AM -0700, Junio C Hamano wrote:
> What does it mean?
> 
> The patterns that were posted were so broken that they are unusable
> and harm the users by giving misleading information?

I think this would be a good summary. It's sufficient for some simpler cases
considered, and does even give some benefits e.g. for function headers for
nested functions. However, the cases where it fails can be significant, e.g.
hundreds of lines away from the correct function header for files with multiple
consecutive multi-line arrow functions.

> In the latter case, how far from the ideal are the decisions done by
> the current patterns, and what's the rough percentage of usual code
> we see in the real world, for which the current patterns do not work
> well?

I think just the missing `export` keyword handling would be equivalent to
missing all public functions in other programming languages, so that alone
would be a decent percentage.

> What I am trying to gauge is if it is so broken that it should not
> exist (in other words, you regret sending the patch to the list
> before doing these updates), or is "already serviceable, but not
> perfect yet".  Waiting for perfection takes forever.  If the latter,
> letting the general public to use it to gather feedbacks by waiting
> for the dust to settle before making such updates is often better.

I'm leaning towards the former case: that this patch was premature. I think
it's far enough from perfect that it would greatly benefit from me more
actively reaching out to the TypeScript language team and asking some devs
there try out the changes and gather some more input (and identify some more
missing cases, of which I now expect that are many) before getting
something out to general users.
