Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544E4286A6
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxY+fPSD"
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA609B
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 07:10:14 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9ac9573274so4888180276.0
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 07:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697465413; x=1698070213; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BzRchau7+wV04S0J5hARCD8K2c5Ex7V4S/ds6/Jmaho=;
        b=cxY+fPSDIScYMyZso+7Wp59zxe8kJk9YKVbqEO8dSNv9VQVLkXgwkfSNYf7q62fSGT
         hXNoaXov+BLWbcCjsx5xkJi5D3t61HCLql+AVN58DIzn26FGXQllRnsAs/fYgZfFqu2Y
         nPmb4qtZZ+PgqDWcIlLg7QSd+BH91d2Csm76LfP3juNplje5aeQys7k+dBJkqqJ5H/nq
         bAA4UBvBSX6vXTlG4AOKSbvL1HP0dQrhalOLILvFob1N3XgefxCbiZ2o+8SFplR43YAO
         hIXO8o20aMUzgMBNH9T+l9Aivt3gx3ttD8oxg00aS1y8aWxBqd12e/9ditVe7MbqlNaE
         QN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697465413; x=1698070213;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BzRchau7+wV04S0J5hARCD8K2c5Ex7V4S/ds6/Jmaho=;
        b=cmKYHsnUfgAv8qKijJ5filqZ+SC8RnhRCadQVkQS2pNs6fkJqIYa42+gx9GxzsyiDd
         c7Tj/7qk9y3reWqPfN5RdEphdRVHKtmBVe99GaNpkM4ZZLWX02k3kSgj4Vw4VJQulzH1
         DcqyVsPu60LU4gvUuPrI4YaNECu4B/uc0o1KIGqSpOcWelwsQuCE939BRbPqUtAUIsOr
         u3Mut8wXe9JXRYFmZFLkEJnEA5BQldwbafTuE1vc9ybUkwujBAzSUmAt+gDmMwwLIqeI
         VfXL5Xsy87uCVy4qBrVAz2LTUBUYQaJBVMAcw7NNV8EyaSGzZw9bTLQ85UV9kiaZYS7h
         PxKQ==
X-Gm-Message-State: AOJu0YwyDc5Rd9pL23o1I7jkh4yhp1F/RR6vRqSvPQi0iXEDc4j//XN9
	1tD0bIH7KOAq1j05kbgEEfZVJ+9gWpBfuBWv1vikjtXKIvaccA==
X-Google-Smtp-Source: AGHT+IHCrwFpvE/uLY85jw31ml8DBDfg9eY+Cvjw2hhwy1aodNUCsnQOASqSqZq5K3HnL7hC+x/WpeNRYI8h/YaU0tw=
X-Received: by 2002:a25:f823:0:b0:d9a:ed4d:b396 with SMTP id
 u35-20020a25f823000000b00d9aed4db396mr10616565ybd.6.1697465413019; Mon, 16
 Oct 2023 07:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hongyi Zhao <hongyi.zhao@gmail.com>
Date: Mon, 16 Oct 2023 22:10:01 +0800
Message-ID: <CAGP6POKg4mSFv-Z+dD1aXDFDbxH9Xu1WCdCA5TGfCAM3NUUQLw@mail.gmail.com>
Subject: Method for Calculating Statistics of Developer Contribution to a
 Specified Branch.
To: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dear Git Mailing List,

I am a developer currently working on a project and I wanted to
establish statistics for each team member's contribution to a specific
branch.

Say, for a user "JianboLin", I am currently using the following method:

$ git clone https://github.com/OrderN/CONQUEST-release.git
$ cd CONQUEST-release
$ git log --author="JianboLin" --stat --summary origin/f-mlff | awk
'NF ==4 && $2 =="|" && $3 ~/[0-9]+/ && $4 ~/[+-]+|[+]+|[-]+/ {s+=$3}
END {print s}'

Using the above command, I am able to calculate the number of lines
contributed by a specific author on a specific branch, which allows me
to quantify the contribution to a branch by each team member.

However, I would like to know if a more efficient or accurate method
exists to carry out this task. Are there any other parameters,
commands, or aspects I need to consider to get a more comprehensive
measure of contribution?

I greatly appreciate your expertise and look forward to your valuable input.

Best Regards,

Zhao
-- 
Assoc. Prof. Hongsheng Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Vocational University of Technology and Engineering
No. 473, Quannan West Street, Xindu District, Xingtai, Hebei province
