Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AAF20D4FF
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775237069; cv=none; b=BbX7SL/LhgJXH+iB98GSL/1m/YxhurGVAOWmOOEVwKQfBtgXwVWrt3RmdU4O/xTsqBvAek6uR2QPcK/SKESD/bepdH8YGyqT6bLeWf0VQSHcTWGBJg5GXrdNDJAir1hp+IB+Wa3g2BIV+lD+vrqL0s9oUSN2/y1mV0gm4YyIlL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775237069; c=relaxed/simple;
	bh=MZ2mjP++k5cWE3V+Yp2ZPKqeJppTylnzAZfsk7SnePs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGBkXxkeRJwpvmWmTHWt3RZ+ogqcFhqX3QxJ8xuPLJCUfkLfTesLJS+4T/TOlwFgWFRZ3KGZvjfp+A3MlRyE/5rghgICYKmIXn0AdIOwxwH5ZLEooJRQ43kAIv0fWobNi8sXUlKM80clb1m6KMlXKEqcBrjTArRrkk5BilCziSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncSJxP9J; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncSJxP9J"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so1358391a91.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2026 10:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775237067; x=1775841867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/LQRzDTMU7TD3BZ2+bARU3lUDVzD4y54eu1OxCu7XPg=;
        b=ncSJxP9JFWA7uuiLB8ozjw72U77wTDhaJBPT1mmsHiNbr0LDhjSTJ8oSuVspV9PGhv
         svHb1AezBFHQDCp32zCr8LfboPJaV8VZUKk3vaavcLc/8Xrs2XL6ix7YpVJ2FSE+y1lq
         L3i7Wt6DqZIa2ncpQD53NICbFzvMX8r7GY4Z8EPMsqgTcUcQ51UYeuu3DRqeTHZjTwBC
         MdrCoVUFfWVpjIRWDkFG2HVl16X2kyKrGPE10z6bA1B2ImkC26yMzA8OlLTYg4fPQ/O/
         3raiZ5XV/jLe1M5IaZDlhM9w8lKjEsZmi1j+myt7PeHRg4FO+P8t5c4vZmvtWd2V23z9
         K+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775237067; x=1775841867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LQRzDTMU7TD3BZ2+bARU3lUDVzD4y54eu1OxCu7XPg=;
        b=KsPWjny1tN+OHO0sqehMzRCk3eijUGod8WllTpM6Pw0g5vCwCJ2fuNqVqTRsmySfqc
         6rmNQXxifZedlUKZ59iqD3AV4pLyhyi08HQLHnQoTDY8qXu2nreYbgQnvfGwM2THk6N6
         Azm7JVzw41Z1v8gLCFefZMANX9w4iGixgpybabcsFRgjH9zdF61LS2Hf6/u1775uEmeU
         UTn1+noIu36KMk7XZ3M9eSqmBtQVdCCS/joz72Uegc6cojHhT57SliRBu/OlF29IANfT
         yR1dNEH7+uVNpdz6se5NL2NramKftp81Tl/Ga+dOQCkJifZ77mT7/Uj8yqJ4nK0lj/3A
         wUKw==
X-Gm-Message-State: AOJu0YybIcYaCZGn6FgE0FiAYEpgB6sCsBdM1Y8qju00M7bl09Oly6cS
	Nj1mkyd7urOaJyojYGtIvCKOqrQ91RVN8aiUY3ViFYoTfL1N1x2qf4TpO6V4BZqpv/I=
X-Gm-Gg: AeBDievA9Rx9QvLaKpPHd14ls4YG9CZQVimtjRlJLqTEsiUX6lGcbMbuWwagOvuKmep
	2iGFYDIe+HK4szr2yH+DYkyaiOG51nQ3dX9Tr8yelAVtxcZ6aFDYtx+DDN9mPyHJdcFgKhZpWgN
	03RMiX6sES1FmOGxWnvZyqdKBhvkibjZoW4JZ5CfllhUsd0OCb6QuzR/DsNVqPOIWtuJ6pXST6T
	k4RM1yRNaNtEuYsmoVmCd2RiHMShXjhe8a8AljvmXyVMa9N5tHhZCieVTEbmqRFbazTZCriC18v
	mqvRSfKM7IT597GPOunGid3YUHanhxGD6PLU9OxOrnCBsnZnjlE13AQk3/GLelglzFL8M7KuTQ3
	VukTZ4kVrfVNTvFUauUHIc1j6sFgv2WaLe3ijGn8kjPH/BaUz/s11OmaNSjMt61L4mc5YVx/D1x
	KMcBAjwvqK5HA1sDU+at7kLX2oQ0kC14NUx6R4RDDEnQ==
X-Received: by 2002:a17:90b:4a46:b0:35b:e4d4:8a81 with SMTP id 98e67ed59e1d1-35de6a41d9bmr3390155a91.31.1775237067090;
        Fri, 03 Apr 2026 10:24:27 -0700 (PDT)
Received: from localhost ([42.118.191.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe959886sm11508418a91.14.2026.04.03.10.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 10:24:26 -0700 (PDT)
Date: Sat, 4 Apr 2026 00:24:22 +0700
From: Trieu Huynh <vikingtc4@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH v2] backfill: error out when HEAD cannot be parsed
Message-ID: <ktge5fdo52fvf6ajz5i7nggxwomelel2g5oo522r5wz6ky5tkj@ijoeff5ykxxr>
References: <20260402191359.11304-1-viking4@gmail.com>
 <xmqqcy0hp25j.fsf@gitster.g>
 <xmqq8qb5p1jq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qb5p1jq.fsf@gitster.g>

On Thu, Apr 02, 2026 at 01:09:13PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Trieu Huynh <vikingtc4@gmail.com> writes:
> >
> >> From: Trieu Huynh <vikingtc4@gmail.com>
> >>
> >> handle_revision_arg() returns non-zero on failure, but do_backfill()
> >> ignores the return value. On an empty repo with no commits, HEAD is
> >> unborn and handle_revision_arg() fails, but backfill silently
> >> continues with an empty revision walk and exists with a zero return
> >> code.
> >
> > "exists" -> "exits", I think.
> >
> > But more importantly (with Devil's advocate hat on), what's the
> > downside of the current behaviour?
> >
> > You tell the command to backfill, the machinery does not find
> > anything necessary to fetch to backfill, and successfully, quickly,
> > and quietly exits.  That sounds like a graceful exit to me.
> >
> > Is there anything wrong with that?
> >
> >> +test_expect_success 'backfill on empty repo fails gracefully' '
> >> +	git init empty-repo &&
> >> +	test_must_fail git -C empty-repo backfill 2>err &&
> >> +	test_grep "unable to parse HEAD" err
> >> +'
> 
> By the way, a more relevant thing to mention is that this change
> will probably become totally unnecessary in the presence of the
> ds/backfill-revs topic that is already in 'next'.
> 
Ack, it'll be dropped by Derrick's patch:
https://lore.kernel.org/git/610a162973a7ad59eba4ef4d5a9288f1fea1d2e8.1774538094.git.gitgitgadget@gmail.com
> It does the usual "if you do not get revision range, fall back to
> HEAD", so
> 
>     git backfill<RET>
> 
> in an empty repository gracefully does nothing, while giving
> revision ranges explicitly, like,
> 
>     git backfill master..next
>     git backfill HEAD
> 
> in such a repository will be greeted with a more explicit "bad
> revision" error.
> 
> Another lesson to pay closer attention to what others are doing in
> the same project.  This would have been easily discoverable if you
> attempted trial merges to 'next' and to 'seen' after you tested your
> change standalone (well, that is how I recalled the other topic
> anyway).
> 
TBH, my initial approach (when preparing for GSoC) is just researching
the codebase (related to the topic I choose), read the logic and
found some codes likely are not correct, IIUC. Then, I check to see if
anyone else already report/or on-going work on this in the mailing list.
If not, I just wanna give a try to reproduce/re-check the code myself
first and later fix the wrong codes.
And, that's how I dropped Derrick's patch series that refactor/enhance
on this kind of work.
Anw, I'll follow your suggestions to make sure TAL against 'next' and
'seen' before submiiting future contributions.

Thank you for your guidance. Drop this patch here.
> Thanks.
> 
