Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQZy/c8S"
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FA5B2
	for <git@vger.kernel.org>; Mon,  4 Dec 2023 11:04:33 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9f62fca3bso26281871fa.0
        for <git@vger.kernel.org>; Mon, 04 Dec 2023 11:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701716671; x=1702321471; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Ng3p5YzVdz4ZPEhunZ01zgUUQYvQ7YaY/glModjZM4=;
        b=UQZy/c8ScthE0oBNphqpVUgOwOTcYXDswbcHdh0K+ehf5glbR7OFoMrkEUZW8PJZsn
         fRWgRSg8dxdbiAk0QWp8zPvSj7T3mbFqAP4/29l7hkmW1IyNMMwA1x/pMa0ZyekTqjYw
         GFuYEKYMkt773dIv4z97CeUomG+Nzd32Eli67yInSVbNsBFbJ+K597OvAIYtJSZbnGDC
         UkJiteGq12NLgIp+5cCAT+x0lhlqaQYYa3yI1sfpcR5DhtGze01+FAk/Ast/Op79XLZe
         HKHsUbNdrr/m9tPqLQ8w0M0ib3LSjitc1OMhOm0gKfaTOWtFw/B1crdUhlw1EE/+3VAF
         K7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716671; x=1702321471;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Ng3p5YzVdz4ZPEhunZ01zgUUQYvQ7YaY/glModjZM4=;
        b=AcLS/PtZLUY2P4r2FedJd4gc2QCp5Cbqa66WjrUP2CcQUI1yt2Xn37yH/D1G2vm0Jb
         h4smmc3gxkU53PxKtF2w1TbcO7ZKC7uhZKzmHJ9t2qdH18Fiu3ISHzP8SunxAPIKCYPi
         mu4NHGe2U4jli2TB2gaAnpzem3qqqiV6SFVDtSNEeHcyHBlwV6Ihn0jt27ceecxjctHm
         BMy2ooDQlfvQE1r9Ns3Ay83gm03qgyru/bU4hM+SwkvVvYiXfc1bqFxs2Xk9C2N0XICZ
         HijnJtNlWFyWDl7rfYtdb/QSBnpY9HipicLb7T/ctbExSWeZ4jTqC7/KEF2woUu8cZXj
         8Izg==
X-Gm-Message-State: AOJu0Yw0yRcWS6jtVVYSJPB7i5K0NTUiuPIFlXCzNzMddxxZ4wLMo0Ij
	mOXwinlqYzf2acpT/yqfQ0CXpXfeIZCrD89HFAiy5wkuIqY=
X-Google-Smtp-Source: AGHT+IHDiDIFsttueFyQnIfY8OJ8Kt+kLzqfVGJWYUVbE+7ioYB36AvULcc69jthfXB962m1lefLIRoyHXv3RKUhq+o=
X-Received: by 2002:a2e:864b:0:b0:2c9:fc0b:7ed5 with SMTP id
 i11-20020a2e864b000000b002c9fc0b7ed5mr1410620ljj.0.1701716671251; Mon, 04 Dec
 2023 11:04:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondra Medek <xmedeko@gmail.com>
Date: Mon, 4 Dec 2023 20:04:19 +0100
Message-ID: <CAJsoDaHbJvBkZR5V3rs5042ZrC1D32i_d6Lv1uS1ncWmWFkCMw@mail.gmail.com>
Subject: git status --porcelain=v2 -z returns paths relative to root
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

git status Porcelain Format Version 1 ignores config
"status.relativePaths" and returns paths relative to the working tree
root always.

On the other hand, git status Porcelain Format Version 2 respects
config "status.relativePaths". But, if the "-z" option is provided,
i.e. "git status --porcelain=v2 -z" it also ignores
"status.relativePaths" and returns paths relative to the working tree
root. Is this a bug or undocumented behaviour? See
https://git-scm.com/docs/git-status#_porcelain_format_version_2

Note: I would welcome some option to force git status to return
relative paths to the current working directory always.

Best regards
Ondra Medek
