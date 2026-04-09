Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0505925C6EE
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 12:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775736397; cv=none; b=BCLvE2laG6Nulst08l/Lf38FIU1SDqp6Qzo4K8TJv4qygb+CLhCNt1GUuvwwC+FvNuXzYZVv/8qQPYdfuP4B9pmVssSh+rBMQmj6Eoa/bhdKY7g0dwPPRL4GkuWXUANdqPa31PicG08lkwiPDM4l9qHB110nAd44hiPYlxsT3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775736397; c=relaxed/simple;
	bh=e18KNpDEK6jeXvnNJG4c4Q7ZnufrBBMtwwbAyrbibsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DinswQwwbKgnO4piDdRLpbDMRcMGjoiOAEPAoDHdwqMER0qJ5/8dcWeLR6yufnFVLNFX1LTycFMB+FsrgoCM/xJdDPTyPwh17/3ftnc71Vo5m0hdnbxGgeg6khFUKXui+Mr5j7ard4cF3lsJ7tGN71vxpGGV8zVqc5HCdG177iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJq00Z+x; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJq00Z+x"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59dcdf60427so723643e87.3
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 05:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775736394; x=1776341194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t90CIrH8G5jvih5kmDfB+hCF6Xyv10GJErPsAtynqbE=;
        b=KJq00Z+x8MhbA06i2Hw4kDHb95K4eyklcgiVeq3FAqYZFC63RrA4QpXHAl9pu1JT3x
         QzpjdKaCliV7kwCowJJ1eXIWWyzZZYssPJHK9Odf2lyS+QciveMsQsN+PuzB0CQ7NWWP
         lZsUwNsxyGX5Rn1prz12Y9AYmw2cyQfzSnq7nTKp7A7TitzRh1kusgrDpQOVFxIOjTuV
         86N2eJ02BlcJ2Y5OBkmF10siID2oGkY3x596/aJcwFjLxn8GIj+WlfAJ7wD0TFIgX3Qk
         cAGL6CyCE2KpCwiVqFtkAv4yY5XgIonsXgDgP3hKstGqsCnfUVND1gGMG+KIghmeKr1k
         eXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775736394; x=1776341194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t90CIrH8G5jvih5kmDfB+hCF6Xyv10GJErPsAtynqbE=;
        b=UUHdpc9e1kUmInfxX1ig91uGroyVusbibzp5U8F9GtYj9i/ogCrlq149ZnI/xuMLKE
         FEbYh/DN4zRo1snGGfpxdtlV4o/xnXrOz60NFQM7xCXELskq+okQOtN+B858OsyuLeCC
         /VM9dGRrKhIn3BPeHPyCeF9amStmJ02ztJBFUflTVs8UXZR6sNvOYTHI+j+3WjB199fi
         i0/CtkzvcYbVFw8q095cv8+ERzVyHpHi/HTpmtqIFhjgjtmuwo0twoOeiQnZq37T5f0p
         X92IWXqh/nMTigxVsMHz2yYA6AFXk5DUMaJkkstzfz+PdjBlxud3NynAVB4KdpF1/4nX
         DaPg==
X-Gm-Message-State: AOJu0YysUPbJ97vNeC50tMn0F0PojEsMIswkP6Tc/BBq2OmsLY0F9A97
	KaTY5EwHaesjsEKSIBe40DIZUM6PC29r841A7n0OFla1g5lkSoyY0xS9
X-Gm-Gg: AeBDieum6hoPJyEyDOCk8CTzdB346wKOixRVvwIdJIQItVsqMayI3es85ah9g2tDa8C
	gJCK0K/t+gqGAnXY9xYUOfYHxxOuZUCA9M15BupvPpRoIw1q8AWEaR/EXsTWl5rfuIETrBNiT0G
	8crB2AMzUq/isybX4KTJb5bthtFB5m53KIvNG75J8s8eeuzfRBXyyy1+1o2Yt5DitQGZIu+6Yg+
	N5+nrXDeZ8PdWT5+s3ZfzlxMo0uL0iKW/HtvX9iUbrutfi5bQl3rbHtwKEAXDRJJ03krjENyzUY
	qyblem8ShrAky7wyV1DPfabmPymZNYblW7vIEJL0f+0IcKj2tKK7Dld2XZl/hS4clgvDtcaOL6c
	n4bd6UFBEZEik++XHNe6E869KOuuIWGP8PAJ7M03TN3AFYQH2/hclJXoIikWhPn7OfIGLNqeWGh
	iOke/dZkxv5sfvC+dx7xbP5R3HF6wfLJ1f2vv2AKBg+VVu7cZScQg/RqAmXLdSTT4mgI95yk9yW
	Ouj54uKSmtrUcEW
X-Received: by 2002:a05:6512:1385:b0:5a2:a97a:4b5d with SMTP id 2adb3069b0e04-5a337585a90mr9563739e87.35.1775736392302;
        Thu, 09 Apr 2026 05:06:32 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6cc6094sm5548947e87.47.2026.04.09.05.06.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Apr 2026 05:06:31 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: haraldnordgren@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Thu,  9 Apr 2026 14:06:31 +0200
Message-ID: <20260409120631.12207-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260331121633.14907-1-haraldnordgren@gmail.com>
References: <20260331121633.14907-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> FWIW, I very much like what I see in 
>> 
>>    $ git checkout hn/git-checkout-m-with-stash && git diff @{1}
>> 
>> output.  It is great that we do not have to do any dry-run, because
>> the "real" run safely aborts, we can do the "stash && merge && unstash"
>> dance as a fallback instead.  All the credit goes to Phillip and you
>> for the idea and the execution of this.
>> 
>> I do use "checkout -m" a few times a week, but I do not do anything
>> complex with submodules or run the command with unrelated local
>> modifications, so there may be changes in behaviour I haven't seen
>> in corner cases that I do not exercise.
>
> I wonder if my implementation is not really up to par. I have ran into a
> few "conflicts", were 'git stash pop' simply worked afterwards.
> 
> So not quite production ready.

Update on this: I realized that the issues I ran into was happening
because of a sub-shell, so it's resolved by running like this:

    export GIT_EXEC_PATH=/Users/Harald/git-repos/github.com/git/git && \
      /Users/Harald/git-repos/github.com/git/git/git checkout -m -

So thus, it's not a real problem.

I think this is ready to be reviewed, does anyone have time to take a look?


Harald
