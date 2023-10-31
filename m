Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70816D22
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 05:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnfyqULV"
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222F6D8
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 22:09:18 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40838915cecso41094215e9.2
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 22:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698728956; x=1699333756; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CtfuBGSiqPMc0kbC+tReJdYb9e6zL7/auX4v0KL7q0=;
        b=SnfyqULVNUC2xHfzhDRfw28kM6cB9VRjZCHY8ZQiyJ5eqRcxG7S0lT3gro8K4O3NRW
         PKeSfwBPXadr+S7lnIwHCTk5YpegCYk4FICxBMDKjDvX6pwUS8zg5JwuSzsZ16FFCnyz
         0fW7FOgu4f8rVc3o9xn+nWx3p1vHawm6kSOa54STLJVlI/PW+PxPbUez+btzS/aQIv07
         11y+VGoL6zQsUHu0HjY+Oi8rCY6iyN3kNJ2W4b1uZfmXs143ysBuoqleEmxpf1zd5vAv
         kFrwq49XVEZ8WAgk4ml1NW/3c3i+RL2b3aK0oRywwFWV4KZrocwsaicfrz/zwh8cgSFG
         hlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698728956; x=1699333756;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CtfuBGSiqPMc0kbC+tReJdYb9e6zL7/auX4v0KL7q0=;
        b=vI8YbPARASejDIspaEJtzvzt/iX0kmk1U377i5hikU5QwGkSgzoJGjpMMzuEYj+jiH
         kZKEHxxr0aFroDtuIKYawmxYQkIJi5z/HCM/a0PXfzZmnZAC2AyYS4Yj/Jz+KhTF2xGn
         ENXtVyG3SwqYMIvGHRpgI5yx+NkvF2DUH/QX7e+o5TNnGHKAK08higp4zv8Dma+qba7N
         MZxszY7cQYvVP0ipNRFUbHP2wObkIOIg2l2j44lOAE0O0QWW+PuAlCXZD2cfQi2haLdq
         d+0EGxuaBgIC+lZgv4Bv2LQHEVDse0epCogtFrKv93VE6wVSSpKDV3Tfiru0OXftzzl5
         hrEw==
X-Gm-Message-State: AOJu0YzXQRX6SWaJh8kdxd2c0hlby5aHK60grlF9jaWGmWy2RGURRbv0
	a8CKx4MqOplDiRgIN0VcC5QWZE9DofA=
X-Google-Smtp-Source: AGHT+IFVh++xvZiseF2tmuMAgnDP/1i6l/ne6VvcEpE4WrW6VvAYSpSobZdMh5Z8YnV+aTDEDAGBGg==
X-Received: by 2002:a05:600c:4ba1:b0:405:a30:151e with SMTP id e33-20020a05600c4ba100b004050a30151emr10270694wmp.12.1698728956158;
        Mon, 30 Oct 2023 22:09:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600c350c00b00405718cbeadsm211379wmq.1.2023.10.30.22.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 22:09:14 -0700 (PDT)
Message-ID: <pull.1603.v2.git.1698728952.gitgitgadget@gmail.com>
In-Reply-To: <pull.1603.git.1698635292629.gitgitgadget@gmail.com>
References: <pull.1603.git.1698635292629.gitgitgadget@gmail.com>
From: "Tony Tung via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Oct 2023 05:09:10 +0000
Subject: [PATCH v2 0/2] sequencer: remove use of hardcoded comment char
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Tony Tung <tonytung@merly.org>,
    Tony Tung <tonytung@merly.org>

Instead of using the hardcoded # , use the user-defined comment_line_char.
Adds a test to prevent regressions.

Tony Tung (2):
  sequencer: remove use of comment character
  sequencer: fix remaining hardcoded comment char

 sequencer.c                   | 21 +++++++++++++------
 t/t3404-rebase-interactive.sh | 39 +++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 6 deletions(-)


base-commit: 2e8e77cbac8ac17f94eee2087187fa1718e38b14
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1603%2Fttung%2Fttung%2Fcommentchar-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1603/ttung/ttung/commentchar-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1603

Range-diff vs v1:

 1:  10598a56d64 = 1:  10598a56d64 sequencer: remove use of comment character
 -:  ----------- > 2:  c9f4ff34dbd sequencer: fix remaining hardcoded comment char

-- 
gitgitgadget
