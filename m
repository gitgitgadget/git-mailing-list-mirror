Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6826DD09
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQK6elhv"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e7af5f618so7520503e87.1
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 07:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705071836; x=1705676636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/x0pFhFEMLa3jJlGDb5J68DpHUW4thQ2GQCOstu0V3k=;
        b=CQK6elhvV4xHVakuvi8Ai1dnovQyEHLPl921zNoFPDvUaVyhZpv8TcFSIADAIOldJC
         HxtMM5u5z9XrZLIvNGoGR/Yg1ZpvuhmxEjkRPqU2/AZp95Lw7FGootLtfqtCjJlTISb7
         9Vw/xR0BpnjpPesnQxGs8lB4rqnfbvOSFF1uStpnfWHze5pusJdnllhL4MTZld8IjnsR
         3k4H6q3v6biaeYqSQNxMetLjFvBjzYm04pHtiybvhVjQffijozjsLGGYxWV180NgtrRe
         xf/5FXsd0D7+zu1ileU4nQZ5dSuxNRkiIhRgeaHzqd7GHbo2z5EaRE+orVfZPH+yprwp
         zocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705071836; x=1705676636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/x0pFhFEMLa3jJlGDb5J68DpHUW4thQ2GQCOstu0V3k=;
        b=b5ngzjX2RZJ0uwfl4xfPzMSwrTLY1mBCP2P+TJzARbVHVGf2ZpN7LHX+UMiCHZBZHE
         UjrGBZUOmPg8uEIcNkFe09A4Mio29L+F2V8IsKTtjuPUDuCctxBHtT4GOmv2lMApAQAZ
         5G1ghLJmoCErN9WwxDa7dwW44maZZkIjZ52UGxAkJ//hCpAOVEC/nevk6h99J9xYHwnO
         gAPu/8ysJm8qfzgPDd0xdc8Zx/PBKbNGffaqI4yFouGLloC2m5+Joj4LYBIcf/Jaai9B
         /OUbSdN1uHBpmc6ipS6KW3A5I8XfuDB2ihInwv8SPgyL9YbS4TP+jpcDrtMNawV4Avqa
         6tRA==
X-Gm-Message-State: AOJu0YzemknSq6T3YDuO+wHem9xObCsJC1skhpakiFmx0qbcjb4ULOYj
	g3xrIJW6pFYKxTIbs2BU67c=
X-Google-Smtp-Source: AGHT+IHfcWQkuloDY2IMFuyuZEYZp8z+fysvjIxbhZkxS0gYrB9o2HBfKSPD0MzqoolbblBy3EbVWA==
X-Received: by 2002:a05:6512:3f0a:b0:50e:a6f8:aac0 with SMTP id y10-20020a0565123f0a00b0050ea6f8aac0mr945899lfa.20.1705071835605;
        Fri, 12 Jan 2024 07:03:55 -0800 (PST)
Received: from Michaels-MBP.fritz.box (2001-4dd4-c452-0-6835-a146-250e-421c.ipv6dyn.netcologne.de. [2001:4dd4:c452:0:6835:a146:250e:421c])
        by smtp.gmail.com with ESMTPSA id x18-20020adfffd2000000b003377680c55bsm4135173wrs.16.2024.01.12.07.03.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jan 2024 07:03:55 -0800 (PST)
Sender: Michael L <mial.lohmann@gmail.com>
From: Michael Lohmann <mi.al.lohmann@gmail.com>
To: phillip.wood123@gmail.com
Cc: git@vger.kernel.org,
	mi.al.lohmann@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH] `log --merge` also for rebase/cherry pick/revert
Date: Fri, 12 Jan 2024 16:03:46 +0100
Message-Id: <20240112150346.73735-1-mi.al.lohmann@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <47a4418b-68bf-4850-ba8b-1a5264f923e4@gmail.com>
References: <47a4418b-68bf-4850-ba8b-1a5264f923e4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Phillip,

On 12. Jan 2024, at 12:01, phillip.wood123@gmail.com wrote:
> I should start by saying that I didn't know "git log --merge" existed before
> I saw this message
I also just found it and it looked very useful...

> so please correct me if I've misunderstood what this patch is doing. If I
> understand correctly it shows the commits from each side of the merge and is
> equivalent to
> 
>    git log HEAD MERGE_HEAD ^$(git merge-base HEAD MERGE_HEAD)
> 
> When a commit is cherry-picked the merge base used is CHERRY_PICK_HEAD^ [*]
> so I'm not sure what
> 
>    git log HEAD CHERRY_PICK_HEAD ^$(git merge-base HEAD CHERRY_PICK_HEAD)

Almost, but not quite: "git log —merge" only shows the commits touching the
conflict, so it would be equivalent to (I think):

   git log HEAD CHERRY_PICK_HEAD ^$(git merge-base HEAD CHERRY_PICK_HEAD) -- $(git diff --name-only --diff-filter=U --relative)

(or replace CHERRY_PICK with one of the other actions)

> Indeed there HEAD and CHERRY_PICK_HEAD may not share a common ancestor.

True - but same for MERGE_HEAD ("git merge --allow-unrelated-histories"). I
have to confess I did not check how it would behave under those circumstances.
It could either error, or (more helpful) show the log touching the file until
the root commit.

Best wishes
Michael
