Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE3E45BD7B
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399741; cv=none; b=QGJCPYllMLFJExkdNUADCf/9ps6LKj4VnHpwICsFTE+wewHZuDIvvvaFtaNrO1Yg53aZa23C54+ohmzI0ZSL4waFabs0f27umVqSMR6TjKEZaXbgwRQ8oTBu6FDDFDbbFoO2x1YDGc0z8tV1s1CzL6hAdylYloCXcXU767MxGIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399741; c=relaxed/simple;
	bh=ZFNvb5p66akMlJWcR06/mJeJXNJc/8th/VLMwIFZbIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8VQW2MZAMRUjEYDpy7BvHFVzSglArcY6doGwU3LNyVTknJefVNjOHaqO75HjEinQySvU2q54YgV06yg6bPCK18RLHze6h/n3fDbWvE8DR4Rl4R4lmkMVYAKDOfgVMLrFrweKuZ0OyhNSK5/7xXwtEgjcTfKfCRcntI2U1xVxDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQpLaeT9; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQpLaeT9"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a40d02b58bso10118213e87.3
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 11:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777399738; x=1778004538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQabpgM6vQiO6q5Gxf8XwyIfb1pF7AkuHQNc0OjuObs=;
        b=OQpLaeT9l4gCDivwi4238IRCaWqQ73BWXzEg9HqZHlxUk8J+xtfhMOpsnAZGKqQyRz
         znP63OjRTzPOS+XVY4Xo4naY4yeSdZB6OTq184xno+bfvnSUpgDWBpL/ufGDl+4Fv1xO
         2fAtjdFNORCi+ZCo0y8mhB3i6Idz9Uu1HwGLockx28fAFoNeKOxkWjj7N7mSebXeUjkO
         3tebyrrsr/6caO+FV6yMvpjJqIjziIVzkslpmEt/nPfdCSgcfGSKzaxgcRpPUgH+Ovr1
         oonGOhiVz0ExE+mXD17001mKTIM4yCgKtEhNRSBtkzEq/GIN/75OCizoxvDSebYhSJkc
         +wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777399738; x=1778004538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQabpgM6vQiO6q5Gxf8XwyIfb1pF7AkuHQNc0OjuObs=;
        b=TjkmziC+M2aFrJSDjpSMt2LmiacC/JDde75dfZk1wr90dGyU9c6rmqvWLEvbNCt5v5
         QULbdDb8AucMswaWc7zSeQTejePILYYUik7VljO3WROGYaK0ypInkyhbK7qbY86Eb4HS
         M8av/QkIgr4P7j4MIbapHJ0iNrJarUv9WfZ15cFabSCrg+arE5sjEhiHPyfx/bO7Q+MF
         0wTnADjgtUIdknKrCogDSTQGT6b12zqxtgslcnWinBCVrOv9v0f9cVephDGXz7B80e8c
         7gt7DkczqeVKM/Yxfyi1TRaQfDd870F4TWth/W+cruLeVr6xSaIVAZsEDZ84m9moi/3Z
         +6aA==
X-Forwarded-Encrypted: i=1; AFNElJ/7f0w+bS2RbQH8grjZ3YpciW+k7n+ydHD7KHlWb+hDj7zEaRK4jSjV7qW+4NkVb3SlOUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh6foEx3eV3XMzdseLxt7bokG/4ww+SyLIcoT4VXz6kLOCIrdr
	3WDb7qnWBy5PNHP/5risjKZKL2vCTTwzMBp3703aRfAd2qB9VJ0MvFkn
X-Gm-Gg: AeBDietwvIIKV0KODgshcbmsIPjYZquq2Im/Cn+c9RKNQjd50mmSvTgXm09NRNtiRt+
	J1OyAX1IXAV3+hm8yChsmiK4tyBbO7h19TJKPLFGHETwjqU5md8OfTxmZuN1Ya8QQknH4zlJa3J
	xrLL62pAn8h0KCwyfOMKbc0ss/b1FAb0j36f/p7HhWn7Qeicg1rwA2UdLmP+IBVNwm/ExXvpz0L
	+qAQlpkJeYiZSDLY1oN1BqSlLl2qOmPFq4/WBddfr1dtCbcECT/h7Xeg3Ry6IZ7e1W8hwMwVqS7
	iQs2ysI8AP0ifgNm/KVU/seIfMeTO20MjdPUjgbIBwoJq8sGqu6BQIe3/ldrQkUixuKutmBpgz1
	xc2nysfr3X9PcGhS3SIECSRJab02O0PHzKWg5ntZVmXuknY6p6pVfvPJWESj7cWivrFkSoEwBjI
	8qTt+a1MpnIitEbcJI89nWWlomz3qmdbSB/PnjaovWJu+v0nCpdGqhthMtkrtgIY6Jbq5sDtOCx
	TF4ValOQqe5Edvcwqc3GCdc4YE=
X-Received: by 2002:a05:6512:158b:b0:5a3:fcb6:cf93 with SMTP id 2adb3069b0e04-5a74660ee37mr1884168e87.28.1777399737921;
        Tue, 28 Apr 2026 11:08:57 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a7476b5c8esm638467e87.7.2026.04.28.11.08.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Apr 2026 11:08:57 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: [PATCH] checkout: add --autostash option for branch switching
Date: Tue, 28 Apr 2026 20:08:56 +0200
Message-ID: <20260428180856.92736-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <88a89e06-5223-4a6f-8f9e-66e72b632ee2@gmail.com>
References: <88a89e06-5223-4a6f-8f9e-66e72b632ee2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> This is looking good, there are just a few small issues. Hopefully the
> next iteration will be the last.

Thanks for the encouragement! 💪🏻

> s/would/will/

👍

> It is the changes in the files overlapping that causes the merge
> conflict, not the files overlapping
> 
>         When the `--merge` (`-m`) option is given and the local changes
>         overlap with the changes in the branch we're switching to,

👍

> I'd drop this line and say instead "a message is printed"

👍

> This needs updating to match the new conflict advice.

👍

> If you've not done so already it would be well worth checking the
> generated git-checkout.html and the man page

Good catch, I generated it now and yes it didn't look correct. I dropped
that last section now.

> Don't we show the modified files as well now?

Good catch, very good idea to actually generate the man html file and
check.

> As this function only sets up the flags for unpack_trees() I think we
> could call this "quiet" or "show_errors"

Good point!

> We've added a function parameter for this option but then we ignore it
> unless "merge" and "old_commit" are true which is confusing. The reason
> we used to check those was to set "quiet" automatically but we can't do
> that now, so why not just use the value the call requested?

Good point! I attempted to change this, hopefully it doesn't break anything!

> This is an "out" parameter, so it would make sense to keep it at the end
> of the parameter list.

👍

> To create a multi-line file it is clearer to use
> 
>         cat >expect.messages <<-\EOF &&
>         The following paths have local changes:
>         M       one
>         EOF

👍

> I've realized since I suggested this that we should be checking the
> reflog message as well since that's what's shown by "git stash list" so
> we need to run
> 
>    git log -p -1 --format="%gs%n%B" -g --diff-merges=1 refs/stash >actual
> 
> > +     sed /^index/d actual >actual.trimmed &&
> > +     cat >expect <<-EOF &&
> 
> and add
> 
> 
>    autostash while switching to ${SQ}side${SQ}

Make sense!

> Why the two calls to test_grep, rather than one? Anyway I've realized
> since I suggested this test that we also need to check the message only
> appears once to prevent a regression where merge_working_tree() calls
> unpack_trees() without setting "quiet" the first time it is called. We
> can do that by writing an expect file and calling test_cmp(), or by
> using "test_line_count = 1 err"

Excellent point. I went with test_cmp since it's multi-line output and
"test_line_count = 1" seemed to not work then.


Harald
