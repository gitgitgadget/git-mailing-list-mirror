Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AAB17A93E
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722090796; cv=none; b=BSNpY1J7JCFiQMCXIt+nRFcNO6n3kjRCn/DIPbup+3vqaZQpoyczu9Ic4XmryduXC7unXUlOKd3iPACkan+1DhrYQl4w84cW1j8mQygoq95BhzkjHmJBi9JUsVV9czGLlrbJSllhVyt30m2gMNafDxNCqmMr5/n6TAzvof5DQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722090796; c=relaxed/simple;
	bh=M38ihttuESFoXWAh7YzLJ+yY8wKSZ0VjRTEGiGLJBn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeajiuqbMZtSsJB2sAxOTKGMT2xaxOMbajrduJQphoFbn0wb09LLX1WcqlW6/Pup3fzXmTmTgzQbhTGcxsE1+Ecb/XEG8UDfAIQkx5TWBCgSymtFWk3bahtKDHcSbWy0IG6/cDJLf7lWTYiy+dLg9U1zGTaoNoP1EZtayhN86Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4GaMiHd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4GaMiHd"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3683329f787so399981f8f.1
        for <git@vger.kernel.org>; Sat, 27 Jul 2024 07:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722090794; x=1722695594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ayKRMObcEt4ckZ6rB+bwxxEglZX0tPjDV/STP/uNqI=;
        b=g4GaMiHdsTUVZQnl1wwGiekSzXQd95zRRdgJ6AWvifWN7yU1aGH74ImYrtDDkJqYLV
         74JiM37/HsJIKT7NePgDhGIHt+cvLTYLGaspymi5Icne6gG2dodo4H0+I2NWZwWglojW
         50LRhx9N0CcU0V8dm59gcMilveCg5/usqln4ckb3AD63sfWJjztuqlwqQsnRTCOE/7ib
         sUJ5TtDTByaLNeiC4K6PQ7+j22Js6zR1CTLRiJpivReOzd/Tqa8ytC9jkiYKujklEstr
         C5N8pcNeAxdw/cgYidNoWTlJcwN9A2Z9xJGXFFyNEcggH/KQTJ0/CVP/odFQ4fIXks6o
         BiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722090794; x=1722695594;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ayKRMObcEt4ckZ6rB+bwxxEglZX0tPjDV/STP/uNqI=;
        b=lPLulNXbYMT3ridXD5V/cUM/WAQLseReLOfIqT7/Ma9Uo8d8eX/tFyF0ebBd0KxbNg
         +od0ILPhbLv4vxPsZ9waBFCB9dTzDDHNJzCMmVj7TJ75pH32395cvk9FOwyeCyDuzq69
         d9INW+9cSajwjGKllsL9sR2GK28CE8jBQSE2o7wscqzxXO+XdxXPexJmLi6ulvWka+Km
         p9LKf0egutUkr9qjVdy3IcO74W4gbal2mg/bKyauhzjXwR+QkU9oI0AtiQ6yDY50ENpW
         Ond1ZjIsPr5r8ddZS1q7n2Jh1hwDy0Vnuh12O4CLbvU1b28ZPFIADy2gqG3fcMlB2YY1
         gIYg==
X-Forwarded-Encrypted: i=1; AJvYcCXsL1G1yk939xZVSIdJpSKahnIlPKhXuw3HQrfYOoOclNmJhU94lyKJo5sBWYtaLnRtoer02P1Yn5NZ6wU+WJZV1mTH
X-Gm-Message-State: AOJu0YxfkJrzmK4UpiWYsq6X4O+eI8cXW+rSci14PDgjr7y/WPSnT4wc
	sc8aJJyUP+0J5tY4v2RSX1DcV3ygwi+akvmNHDYBxN66j7dyPA12
X-Google-Smtp-Source: AGHT+IHzmAOCs+85naVFRlq3x+oJ0kR9A3KnG2jRUtgY9mYNK4nyVg4ZwrbPZyXDPaCHXEIiaSfyow==
X-Received: by 2002:adf:efc4:0:b0:368:7edd:b141 with SMTP id ffacd0b85a97d-36b5cf24635mr1781810f8f.34.1722090793282;
        Sat, 27 Jul 2024 07:33:13 -0700 (PDT)
Received: from gmail.com (144.red-88-14-42.dynamicip.rima-tde.net. [88.14.42.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fce64sm7756584f8f.61.2024.07.27.07.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 07:33:12 -0700 (PDT)
Message-ID: <82560916-c539-4ae3-a378-391a1da7d80a@gmail.com>
Date: Sat, 27 Jul 2024 16:33:11 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] add-patch: render hunks through the pager
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
 <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
 <2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
 <5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
 <a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
 <97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com> <xmqqcyn1lcjo.fsf@gitster.g>
 <24e83a0f-b0c8-4cd5-b321-1d7702b844ce@gmail.com>
 <38e190de-cbe4-4f75-acdb-fe566e541179@gmail.com> <xmqq8qxouhjv.fsf@gitster.g>
 <xmqq1q3ftxwe.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq1q3ftxwe.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, Jul 26, 2024 at 06:40:49PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > In any case, that is an appropriate thing to say in a commit that
> > fixes use of such a construct, but not a commit that uses the right
> > constuct from the get-go.
> >
> > I have to say that the [4/4] in the previous round, i.e., fc87b2f7
> > (add-patch: render hunks through the pager, 2024-07-25) in my tree,
> > is better than this version.
> 
> I do recall that you once had a version where the code violates the
> guidelines (and breaks dash) in one patch, and gets fixed in another
> patch in the same series.  The above material would be a perfect fit
> in the proposed log message of the latter step.  If we spent so much
> effort and digging to figure out exactly how it breaks with which
> shell, a separate patch to fix, primarily to document the fix, would
> have made sense.
> 
> But the latest squashes the two and avoids making the mistake in the
> first place, eliminating the need for a documented fix.  We generally
> prefer to do so to avoid breaking bisection (and the recommendation
> to keep the fix separate so that we can document it better was made
> as an exception), so squashing them into one is fine.  But if we
> commit to that approach to pretend that there was no silly mistake,
> we should be consistent in pretending that is the case.
> 

Fixing a problematic change with a new commit isn't the best idea if
we have the opportunity to prevent the problem in the first place, as
Phillip pointed out.  Since rj/add-p-pager is still open, it's
worthwhile to amend the problematic commit.

Of course, we've now updated the documentation [*1*] and reinforced
[*2*] the mechanisms to prevent this from happening again.

However, I think adding a comment about the issue to the amended
commit, which I think it has been suggested at some point, seems to me
like a good addition.  I do not believe that a future reading of the
change will lead to confusion for this reason.  The added comment does
not document a fix, I think, but rather it is an explanation of what
we're doing in the commit.

Furthermore, we capture in the history, IMHO, notes of how things have
happened, which is also why I intend to apply this series on
506f457e489b2097e2d4fc5ceffd6e242502b2bd, to only amend the last two
commits.

   1.- jc/doc-one-shot-export-with-shell-func

   2.- es/shell-check-updates
