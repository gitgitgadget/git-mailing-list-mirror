Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7762AE93
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509271; cv=none; b=J5BWC21v/KpSRSM9difah/7jqYpYkqkeb5sYhHx3uBOptU8oLfI6E2ZrLsRdHt1+0vd+e/qOXH8kv7ztl1PtE2v9wf71IsPuGckz4INN6gbD1959ZCYeHrlSwGiUVDTR3q86ks6QO34zGjk38weAFoZyH/upYHiCWZYS7sgGs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509271; c=relaxed/simple;
	bh=HWejrfZtavJaxcnXWA9l7jeP6SF+sZ2g6XTeWbUqnz8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YDl+/QSXzOr1tm93oXIDJokcGIwtQvIAglZxWcTsK5/De+NMoyjjG6WtB5jeffoocJZ1EYnw11Ow46LDXr+O5OMLZLCBfxD2WcVv4lh89kOJXMHrkkOOUe8ikhoTWAymz8UGfcg9qe4JW7ux2gGIpV8f1tWu/2X/KyHbj1wjCoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTaCWQz2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTaCWQz2"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d8901cb98so569202f8f.0
        for <git@vger.kernel.org>; Wed, 13 Nov 2024 06:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731509268; x=1732114068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qgQG26mFZccL1UNwacO5KiyKfmxNaWMvjERmMNRVz4Y=;
        b=JTaCWQz21YWvlA5qeVfNSjorWHrSK9zgHWohJA6P9F0eS+uSWXAgclweDJWZBg5o8Y
         baCnEDP8et5gVnFx2aBJBcB6XiY0xkgyn02jCEfzRnzMTgbRVCbBNHJVLUrtAiJlaS1g
         33c7PlwWzm7Zh3FZEm57C10ISlkYXPYhNcbfCrs0UlO+PDUDgqzT6NfH4zwsw8rpI6Ij
         FfzOvvpc2X/9HI/VIH8P7JA3QC0fGjUcPz50729owRc+ctM5XXo58IpFs5OPlueJyivQ
         fK2dzvwRByMwK+knJFYkp9YLHnXGjJQ+mJpiq0Ay3SiQeT+/E3jLwfQI5qvsvNpG6NY6
         LO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731509268; x=1732114068;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgQG26mFZccL1UNwacO5KiyKfmxNaWMvjERmMNRVz4Y=;
        b=wfI8eK7oFvUPKIyfIQ/zj6MX8KeAVYD6xFVg+CJwm9SbXTRWCt0gv/oYScgPvqAyyN
         0GMtm00Zr7f5zoiqmhvhbH4AoM7w5w0WASGyBetHPZxp8HGbd6kVAjIYBk+shJRvsu/3
         oi0KGdHV56uPMViQeCLIUWmGNCYe7UhFP4gYM5b39MsmcVSZVoUOwGkWzZDobPLVTDGV
         NnNzUoNpUtsp5DTqklOpVmzTkn48zNNSfgAD1QryBV6yZjtDPp5TngcA8y9b0R1pS1lV
         it0R5Q3B8kh1xDQLUrnEsQbWcQz13aV1+u3/BACMoSXKhkkjHdAOqnXNnNwKMqlIknty
         9mtA==
X-Gm-Message-State: AOJu0YwA8zNU54y7Ku8oXoe3LonFy9CDz0BzR5ggAsryu/FrYvIJI5HJ
	eaEVDhsXd5ZnrIys5X/OPds1kKlXXc3ZVcsGt0q2UPFygUbXR33a
X-Google-Smtp-Source: AGHT+IHxz5SohUR3qJKwTMHUMfuD47mJNjvX7MGyLFZZ6rETYepG8/V5zFY51c+jK8V9KgNfByNNiA==
X-Received: by 2002:a5d:59c2:0:b0:382:756:96d6 with SMTP id ffacd0b85a97d-38207569767mr6782702f8f.1.1731509267976;
        Wed, 13 Nov 2024 06:47:47 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54f812bsm27548285e9.12.2024.11.13.06.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 06:47:47 -0800 (PST)
Message-ID: <5ed77fab-678d-4a06-bbd0-ea25462a7562@gmail.com>
Date: Wed, 13 Nov 2024 14:47:47 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Subject: Re: [PATCH v2 1/3] sequencer: comment checked-out branch properly
Reply-To: phillip.wood@dunelm.org.uk
To: Junio C Hamano <gitster@pobox.com>, kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
 stolee@gmail.com, me@ttaylorr.com
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
 <cover.1731406513.git.code@khaugsbakk.name>
 <fc3b4438845e9fafd03fb608128099ce37ecd1b9.1731406513.git.code@khaugsbakk.name>
 <xmqqikss2b7l.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqikss2b7l.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/2024 01:07, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
> 
>> +test_expect_success 'git rebase --update-ref with core.commentChar and branch on worktree' '
>> +	test_when_finished git branch -D base topic2 &&
>> +	test_when_finished git checkout main &&
>> +	test_when_finished git branch -D wt-topic &&
>> +	test_when_finished git worktree remove wt-topic &&
>> +	git checkout main &&
>> +	git checkout -b base &&
>> +	git checkout -b topic2 &&
>> +	test_commit msg2 &&
>> +	git worktree add wt-topic &&
>> +	git checkout base &&
>> +	test_commit msg3 &&
>> +	git checkout topic2 &&
>> +	git -c core.commentChar=% rebase --update-refs base
>> +'
> 
> Can we improve this test a bit to give it more visibility into the
> breakage?
> 
> I am sure that the internal machinery gets confused because it wants
> to skip commented out lines assuming '%' is used for comments, and
> fails to skip lines that are commented with '#', but it is a bit too
> opaque how this would break without the fix.  Perhaps add a line or
> two of a comment to the test to describe what the expected mode of
> failure is?

Or check the todo list shown to the user with

	GIT_SEQUENCE_EDITOR="cat >actual" git -c core.commentChar=% \
		rebase -i --update-refs base &&
	test_grep "% Ref refs/heads/wt-topic checked out at " actual

so that we are sure that line exists - I had a quick look and I can't 
see any existing coverage checking that the todo list contains this comment.

Best Wishes

Phillip


