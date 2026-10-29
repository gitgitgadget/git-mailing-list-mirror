Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249201;
	b=HgkA34ljORH1hcdwvT30ahnXCiARSlhRsFw6/7bY7Fh3bwGpN3DZk97fHTDQRKPo6EE0
	 zeaucqsfarPN51U/CHFPzkuCiedK20u3d9VZlEoaumLg2x2x6BUZ9gjNDDpbMKAVqZALY
	 r1VOL8Y4BDXZxLGP+uMWaxsBqUjNoFaoWvhvNf5C0FX558H6GyGdJc5xjlNDhBPHv9r1g
	 npVBzIGCDIWtsGtRGjJcMFDWV3Bo7z1plBYe/n5vJpFykj3pnBm7Wpefev7x2R+7q2O64
	 YlFLGRaaOkk9X3hT2LDlokNeIihOcoTRQi//EqlWWvR4XqFVzgOmAcwnbXWBkm0jd8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9i2qpB3PuiHKhDfqnIEV3mUVOxIAyV51jMBlkICs6js=;
	b=3DD+2fVeQ4FwTw0/XUW2rM3lx/iK4gQCJyLAwVtgoL1i+9Fi+F7HWcIJ9/uB4cOtghAR
	 0yRM5SY3jTmd6HMno7fn9ykQ/cfj3gcWLgv86FtNC/+LuHeLqd+IiQ/YpXmA9hr757OZ4
	 KUWM1FAJbiu/e4E1v/0nAKW1/8lOtQqrff5OzNDWWb1FpyLEk6Ql5yskfjFmHyEPbEPbi
	 cffig61ebB3xtykwvMLfVjHk9mriD6K+sknP6p6ipMH4ckBNvkMZR18bkptiGg8Vfdhnw
	 kyYJSxFLjoPlMPup/yHzSbjtPOqqMBrSBn8TzsV/TkmPL/9qUiu7GU6Ye4aJceSkMag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=FwjRZMGI;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E9D606A31F
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 04:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43E9D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=FwjRZMGI
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53665358476so18700171cf.2
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 21:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1793249200; x=1793854000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9i2qpB3PuiHKhDfqnIEV3mUVOxIAyV51jMBlkICs6js=;
        b=FwjRZMGIvuPm9OX1P7mgjsrTqOlzWlEoRrQ4MeQVRJ3tGpAeLBzmSdyDpq8sgctTdc
         lQuevWcAZ7rYVOBchfD0HIZx6zElaz4nXm2MX/FyRG48MMn+RuGFgs3zmZuJHeD1BfmS
         bh2kDHr5K2ttUYAWygUYg6L6N7L6ZchvPeyrNFejv0iYEuadUkA8K99vJJy27ahfNp6L
         fOZ4AIQp6DZl8CdAnUHZzUZfESH2UH4Zy6GjiLQYDUhYz1YkntLf+KKDDIt6sI443Z4S
         6WIbtGnq4jO6DZ4JXgmShalBcYLK3D3o4SZ+vTrfyuoQ8zOdbzftf0ClcfVqw7cA60j2
         gpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793249200; x=1793854000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9i2qpB3PuiHKhDfqnIEV3mUVOxIAyV51jMBlkICs6js=;
        b=2McfhG5Rqw92SwFqIY1kOT9ebkO9D6TMu8LJ8cLN0SpJQWr5kGDeeSSCfNrXQlwZ5m
         IdSTvddGwGdyTb6/gRkDUZR1WHUgPSy74fgGkc0zvhWQZ47IFQl0oGN0aW7OdWTOgCUb
         pLRpMWq3b0901TNBNeIXnSU6CKIM/EHyc6oY0DQp8lr2XYpXAOsLOvJUHVPZL4g/hdpo
         8IE4G+21DPUEtZlh+P/Cmt2+iRCp10je4kQp76QnQ83Lg598SuV3eYSahD8dNgdJp8Lu
         tyWFt06Ipo1I02Co8nvZlXxcSoU3+wkPgiWcFMQ+u5Wzdf5EBNR1E+YCGc+BuywfRTKc
         hxEA==
X-Gm-Message-State: AFq9FYKg+tcIFgPwboAFUivP5DZCxVXs1j90m3cErB2hT6RCH64TJdXp
	hox3m13hZpiJCtxHS4yXJ9ple/5cyyoUP3kbGWhzxlU3Y43uABukq2UtzrnVzPQy0n01CpBsrpX
	d7EBEaPUSX7fQMCXw2CweALBlSR2oms2Sonb8GLr6RPTOm+V2pP6AN8N8PXUm+3MMMKj7Acm4GR
	5PAWt6R7jjj4KvhSGRjNb35ZE70BN9UE8=
X-Gm-Gg: AYBFou0KGpOfeeBGDZWTHXCWfoeyfZ2UYPxe5CBt2X2xe8YsdVMpH8a8tPhU0LIwIxw
	nwHPygWqvc/N2spkKzVMnhNO0LimlRhHnpMfWi7AwsDz5NgZ2cBFRivIcHFylu1FnUhQf6XUbT3
	2GZrkHB8TFE1cuXv3HFaH1zNioFsOq6nQKCzRSqHaJcri5jDQruh0Ly9mwgF1VLOAGYs0jmy55d
	bzaV58l31Ts539pNnCaAxFcwKFiepUBj9m38L8C2Ws0RbOYFF1qlzAVh/4maYFC45Lt9xbmhFjg
	GYjDH/+yeLVL5PEjT3E/Mh68mLNp23zpjl/eo+rFPrrsSm3sIikp0c/ploOpH9hBubmhvfQjt6g
	U+jSGICeDJ843N66XxNdkfQo/gOXMtVfx9k9tArpU1tmZ7H3JrQ4lFVXIjVpdDthScPgxtLioPo
	7QD2yunLbDtbFT14wADBsP3XmgL/ufokLCDqDx+PfFA53ynALcmYkmnN8VzgX7C2yyjAIuB83Y8
	Uh9I9OvLAXO6qVdIGFugfxQP80yC1fOBw8aZ6qacLNbFsbLeGyteREAQqpbZvUl81kWxKDsf6wU
	6xGZe5fBsFE/SpgmKzwEb92ntxckOjAC49Q3SvhkKQtqb06NNyPrmzATOnwhUmFNFLtEglXRr1x
	WMFip98JOFSnyherbqs19N3GWrRPgz1OPV9lLENOvgyMrCwPxrFOemSG2TBCQWelheiKSP1AtSv
	WPns71bIVHQ5CahK0Pl1dvYPopje57b+wmz2d/aqeuvMqNK4WbB0h6h79uUIFw+PFq5ZDl/exyw
	+9BfNHF0QhYQXvWiQZxqhDhR699JbY=
X-Received: by 2002:a05:622a:4d4:b0:535:753:4b08 with SMTP id d75a77b69052e-53fcbaef9f2mr69792501cf.17.1793249199869;
        Wed, 28 Oct 2026 21:46:39 -0700 (PDT)
Received: from remus.wit.private ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394f7cdfsm122287521cf.10.2026.10.28.21.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 21:46:38 -0700 (PDT)
From: Jasper Mayone <me@jaspermayone.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	phillip.wood123@gmail.com,
	haraldnordgren@gmail.com,
	ben.knoble@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: Re: [PATCH v2] worktree list: add --branch to select worktrees by branch
Date: Thu, 29 Oct 2026 00:46:33 -0400
Message-ID: <20261029044633.12429-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <ad504925-cdda-4de6-8791-97a51a9d90a3@app.fastmail.com>
References: <ad504925-cdda-4de6-8791-97a51a9d90a3@app.fastmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> git-for-each-ref(1) (and git-branch(1) etc.) have `worktreepath`.
>
>     git worktree add ../test-branch
>     git worktree remove $(git for-each-ref \
>         --format='%(worktreepath)' refs/heads/test-branch)
>     git branch -d test-branch
>
> It will not list the worktree path if that branch is being rebased.

Thanks, I had missed %(worktreepath). With it, what I wanted from the
start is already one command:

    git for-each-ref --merged origin/main \
        --format='%(worktreepath)' refs/heads/

So --branch adds little on top of that. The one real gap is the one
you name. While a branch is being rebased or bisected,
%(worktreepath) is empty, "git branch" does not mark it with "+", and
"git worktree list" shows that worktree as "(detached HEAD)". Yet
"git worktree add" and "git branch -d" already treat that branch as
checked out.

As Phillip pointed out, branch.c already has this information:
branch_checked_out() covers a plain checkout, a rebase, a bisect and
"rebase --update-refs".

So I would like to drop --branch and instead make %(worktreepath) use
the same information, so that it names the worktree of a branch that
is being rebased or bisected. That is a smaller change with no new
option, so the naming question Eric raised and the --filter-command
idea Junio floated do not come up.

Is that change in behavior acceptable? A script that reads
%(worktreepath) would now get a path for a branch that is being
rebased. I think that is a fix, since the rest of Git already
considers that branch checked out, but I would like to hear if anyone
relies on the empty value.

Phillip, thank you for the review. Your point that "git worktree
list" output does not say which entry is the main worktree still
stands, and I can send that as a separate patch if it is wanted.

Thanks,
Jasper
