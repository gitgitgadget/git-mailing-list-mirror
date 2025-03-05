Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E91F416D
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741174903; cv=none; b=g6j2SUafsZ93sUt5qu9+hBqZhJzrWeUEQ/1C4Aly1xaZQh/H+tYWlaWZj1hO4pg3SQhAi0RRBvLgtheSsX/RFKuAPTjNh88gscwglA9G2QtH+hgycF9wF0F207HFLxjoYxG32OcsEtDahMXdTQlb7lNkA7nKyWYpiNFIcEqllJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741174903; c=relaxed/simple;
	bh=NUAEhmaUE4MTMgfMPtQ5SvQpqO+zWpB2kr8lIEgmF7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f27RO+s9pOZFrCsj/pPzXsDnDmheJev92a2fTlLoXt7gguSEuBFbEo1ohtw10b3jlLk54EUBYsWpm6gciyZPsI55iQa8UrNA7FtXEwHz1ShtrCb/JttnlBP4kT44FefcIqKJrmiNE3D8ig6Ur3RtFkOXu0a28Xhp5TDTlf94ZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4mLqo0W; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4mLqo0W"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22337bc9ac3so126147475ad.1
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 03:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741174901; x=1741779701; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FyBkg6778fm84jkFGa6TQu096AVkKd+Y11vrR19nkgk=;
        b=a4mLqo0W5R++PLR4WjtBBTdKkXdUY765/ea9cYlh7ysEc1gw874xwfFBMdiHtFUHaE
         YkUmus9MMSio3wJlmd5GfLZ/ZlaO5y/gVZpS6BX9e2ERAb7g06cvysHu6RHJv5Yc9mx8
         uCFPdazgNy6Z20tERU5djxb+qDbpRYUFYT1Kh4ogKCse81yEJYKrYkqrkjRsv0k7IY8S
         EaD2C7sipjcjae3CzX8B6mmx9z5n848XLXVvKcrMmId3Mp7CDbtQngdn2lh3DRI8Mnc6
         Vzi02j7QGGz31AGmWlze++2wUw0PaVRLYrw9rwPg/Eqz6wHXB/qErbf7q7ABw3OtAnSZ
         ESxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741174901; x=1741779701;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FyBkg6778fm84jkFGa6TQu096AVkKd+Y11vrR19nkgk=;
        b=MjUu1RVzetjkvDguOoy9MOMw+JEoyxFIHhzz2QrqFP5uCZcZXwmH4fipfGVjzxoBZP
         78N3k/3f+kObNVUh7q1hlx/CiuoRSu++8fqQXr7w37B7nCs9ntRHv9BRWR2GWWWqBBKk
         1ziuVOE7a7PVB1iKenp5DlWdZdkpOjUtuK+OlixGpK2e4oE8XSMH8F+CBplpVgFU4Fk+
         Ga4c6k4oE427xq25CKKSVQ6IIqcDsLwXuJ/KpD/lIMOub9qOnS56wH9kLXR3S7zevF+y
         BorpIelluk4q3WE5fmUxM7M+wYyw5mbz2Ng0ljVRz0NOTAgasev49az0bzRfGDc0MHnD
         QfYA==
X-Gm-Message-State: AOJu0YwoR9uzDiazZwZd9K2VqKd4YcijuDMPk0EmtCUPnam45jrgPN/I
	W6XgOjUay0TGrunVtOmV0DExSdC/FhkSopXIBjlHP5+LZz5lnu//
X-Gm-Gg: ASbGncu8w+lIwV1mWRS1KICAy2SgnpW1CfMFcYuDGWa1bKov6atGPmtVuGqI/b2ZSXe
	834QwhFLHwGsVs+6bM2oCsNdlEb9zVmrh6i1chcsuF8Z3RePvRHy9AV5ZDZdAMurIdNOFWoOpuB
	bTK+KXo5K2QEeAknQlgPg4tvFPRgrwvGq71FBKJMBMEehPk/UsMSXU50DTzuyqv9fOz3t5AFbZu
	zr7cLEiOTKTaiuDIUtzwkV/1uiX7trACQNElqyRqbzc9lXtCJ/Dy7TBVK+ep2eQPWZFw1sYVfGD
	HQkmx5/fw4h2xQxmAONOWvGiagBFeVefn2CtnmLd
X-Google-Smtp-Source: AGHT+IEFalrDnaGGSacuDHxoCHvCZyJu9kGL+Dz2pyNLYgGEhanUByNrkgsl3jbKkd9HX6twK34vEw==
X-Received: by 2002:a05:6a00:2e9f:b0:736:34ff:be7 with SMTP id d2e1a72fcca58-73682c86af1mr3994105b3a.15.1741174900883;
        Wed, 05 Mar 2025 03:41:40 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73648f97953sm6756555b3a.166.2025.03.05.03.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 03:41:40 -0800 (PST)
Date: Wed, 5 Mar 2025 19:41:41 +0800
From: shejialuo <shejialuo@gmail.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: Discuss GSOC: Refactoring =?utf-8?Q?in?=
 =?utf-8?Q?_order_to_reduce_Git=E2=80=99s?= global state
Message-ID: <Z8g4dTSFQDTi9ueU@ArchLinux>
References: <20250305104650.238392-1-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250305104650.238392-1-ayu.chandekar@gmail.com>

On Wed, Mar 05, 2025 at 04:16:49PM +0530, Ayush Chandekar wrote:
> Hi,
> I have been studying Git's environment as I'm interested in working
> on the "Refactoring in order to reduce Git’s global state" project
> for GSOC 2025.

Glad to hear that.

> Some basic changes at the top of my mind are removing the
> 'have_git_dir()' and similar functions or shifting the
> 'local_repo_env[]' to the repository struct.

Although there are few callers calling `have_git_dir`, I don't think
it's a good idea to remove the `have_git_dir`. This is because we need
to reomove the dependency on `startup_info`. It's not an easy thing.

For `local_repo_env`, I don't dive into. So, maype Patrick could help
you here.

> I also read through the patches [1] and [2] submitted by Patrick.
> I can see that we also have to shift core.* into repo settings.

I somehow understand what you mean here. But "shift" may be not
accurate. When user sets the "core.*" in the command line or config
file, we will parse the setting and sets the _global_ state defined in
"environment.[ch]". We don't want to use these global variables, but
want to put these states into repo settings.

So, we do not shift core.* into repo settings, but shift the global
variables which are related to the "core.*" or other settings to repo
settings.

> I was planning to submit a small patch moving access to
> core.attributesfile into repo settings. However, before
> proceeding, I wanted to confirm if I am on the right track
> in understanding the project goals. Could you please suggest some
> more files I should look into??
> 

I think you could work on this but I don't think this would be a small
patch. You need some efforts to figure out the solution. You are on the
right direction.

However, it's hard to suggest which files you need to read. This is
because that for each global state, there are many files which may use
this global state. So, you'd better follow the call stack to know which
functions you need to change.

In conclusion, I somehow think that you could first think which states
you want to change. Try to figure out the most simplest global states.
Classify them by the complexity or difficulty thus you could write a
good proposal.

> Also are these patches ([1] and [2]) an example of how the project
> should be carried throughout the GSOC timeline?
> 

Exactly.

> Thanks,
> Ayush
> 
> [1] : https://lore.kernel.org/git/20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im/
> [2] : https://lore.kernel.org/git/20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im/

Thanks,
Jialuo
