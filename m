Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5581E2581
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074980; cv=none; b=BQHy2Q1CIpqGlXZC5tNu/v0fknNMm0oy/BOdsROErdz8Cs6bVH/lvG2euFsPzLJ73VxdPCCNG8LaVTIH8eCO9+ucjcu9MXKylwhPWj2yz4XIayyZ3C+XdvziNtMc8aMlF7qrKnguJrzP7fAJhECrfSxR/k/MaRwv0cGIqWpdEhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074980; c=relaxed/simple;
	bh=DrYhFuqjER1SnvbwMlUOklZPta+k3gZ1lquBTdaiqrg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rkbvrh+LK+tb+1YcfxduWKbXmTfTN8xLxFasezS5ywSN75HaLym60m9KjkhOTGYm6NHxdOFHYx90EXlTeRqoKghh55XC408B7cTb+GqlUuE0zfszRoxdzjdoikZ25liPcVy2/VsSWswG+YvZaFZtzzEhFf3Sa3x3ocVZ4iq30n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nbm7eBIf; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nbm7eBIf"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ae29ddaed9so1949452eec.0
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 11:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768074978; x=1768679778; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlaZNC99wQw/O+yLcvTSKMiy30LkStk5EXmzdCjwxv8=;
        b=Nbm7eBIfbdk00KcY35V8h8l/mIDQh0Lj4EPt2L+69PbNc7Bri8RoGI/vL4070B5SRf
         CBpRfgtzQx2zS/fa8W5dU3FkbhO7XT3SHbZ+k70WHeEqJ6ZDW2YcH3HuEneRUd8pzGNe
         dQwLY4CpFCrdF7RCn6IfRhKeCBCpBQPGyuKKZDNI6L2OcTPDonH3bpqifX/yfSverXA/
         2iyEGE8SgTRMm/jiRHnZaEVqXFE4T4Mh9P9IhIOmA+vp/2l4l4fxSaND7ymhZYcVonzb
         B2SVVI7WEOJJkLG4OafrzdwI0fhYf5ppaJvxo1TGN8MVe/4fIjJjm9uNpysr741qnquN
         3Nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768074978; x=1768679778;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZlaZNC99wQw/O+yLcvTSKMiy30LkStk5EXmzdCjwxv8=;
        b=Ozdk3CCiM2HgIGZ7F1NB04BCeZ+YQA8k1VscJ5Fkqp+XueM+hUHWFfrE0m7ouYSD6S
         qHHiKj06fjxr+d3RhJd2ha7TNN1cp9eCDRROcSdwRGa1c6ftalB9uw6mbFs6Jq3iMUMU
         hiEkJA55HuezXYmyScTpCBd8CyZTHQ693iuiKwJ7G+QYLgJh0ldRyswqUnkbzPL0Kga6
         WSS9ncAubIsbbBvjalnda3cf4zlkGtdHvjY/y/646bNFk/zO7EZcIa7TAo3Fkp26Dtd6
         +/rxerAYdXH3bLRLc2HS1VblnpHgkM12D9n5LWVvX/E1LylwNAiDRaM2Q/tw33MXQfnI
         hmtg==
X-Gm-Message-State: AOJu0Ywc0G0XVzj0HLO5hQzBqeIw1hFNXpM3NpKGDT/HX8txBn6ANIq2
	4WVXpFmmOm0sLZKdXpFU5aO0ghChpkryVDibj0rNvk1LAl7YprYcqP9C3k+JwQ==
X-Gm-Gg: AY/fxX6uUauODMi/52WM6Du6dD/2fT1865HIKBETVIgdS3m9JGMHKGvbxjWTGxFlql4
	dRsqgl4Huag1yOSb9TBbOWNIaI4Ze6Ups2BVTw3bEtX7mZ3qTFdqj02pHbkXk8pjagrucbd2zp/
	88jqWWIwEN6xrohJHZ0tlA00zNzKbec+mVU5LK9AnmKvSUf6RXhnjuQWRQouZqutecA/CiasWQK
	HBNP6yIlRLQ4wd/Jp8OrR5mpi5cgZ01nPUPEB7Bied4l24/ZZkBK2I5PtDPmCl43sGA780s2XzB
	7i7rJ4UpmfrHWi0QwKK+qsgbkL0uSi3UGhjo2UfofFZ/Nk5TLTbsInC903PsreuETRFLp/LBGqf
	0dX1PmUAcBj8na1M3rHGxMGy585uWHKpB5lkctqGiW7iBJOXF5kucWX+lUmhQ4J1uKBb7AlRMUi
	XefBGNlecQSjvac6c=
X-Google-Smtp-Source: AGHT+IFHSkDVMuwng9UiLeOO632/w+xqdBZnKF2OIk5o27lcIFPyu1HnCIUa+XlmnZijVPLQhVLD0w==
X-Received: by 2002:a05:7301:38a3:b0:2af:f2c2:3bdb with SMTP id 5a478bee46e88-2b16fd7d2a2mr16279447eec.2.1768074977829;
        Sat, 10 Jan 2026 11:56:17 -0800 (PST)
Received: from [127.0.0.1] ([172.215.216.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707da231sm14547392eec.34.2026.01.10.11.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 11:56:17 -0800 (PST)
Message-Id: <pull.2138.v22.git.git.1768074976.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v21.git.git.1768058653.gitgitgadget@gmail.com>
References: <pull.2138.v21.git.git.1768058653.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Jan 2026 19:56:14 +0000
Subject: [PATCH v22 0/2] status: show comparison with push remote tracking branch
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net
cc: Ben Knoble ben.knoble@gmail.com cc: "Kristoffer Haugsbakk"
kristofferhaugsbakk@fastmail.com cc: Phillip Wood phillip.wood123@gmail.com
cc: Nico Williams nico@cryptonector.com cc: Patrick Steinhardt ps@pks.im

Harald Nordgren (2):
  refactor format_branch_comparison in preparation
  status: show comparison with push remote tracking branch

 remote.c                 | 174 ++++++++++++++++++++------
 t/t6040-tracking-info.sh | 262 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 401 insertions(+), 35 deletions(-)


base-commit: d529f3a197364881746f558e5652f0236131eb86
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v22
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v22
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v21:

 1:  ce1f1eebb5 ! 1:  4aa4f1abc8 refactor format_branch_comparison in preparation
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       		if (advice_enabled(ADVICE_STATUS_HINTS))
       			strbuf_addstr(sb,
       				_("  (use \"git pull\" to update your local branch)\n"));
     - 	} else {
     - 		strbuf_addf(sb,
     --			Q_("Your branch and '%s' have diverged,\n"
     --			       "and have %d and %d different commit each, "
     --			       "respectively.\n",
     --			   "Your branch and '%s' have diverged,\n"
     --			       "and have %d and %d different commits each, "
     --			       "respectively.\n",
     --			   ours + theirs),
     +@@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
     + 			       "and have %d and %d different commits each, "
     + 			       "respectively.\n",
     + 			   ours + theirs),
      -			base, ours, theirs);
     -+			"Your branch and '%s' have diverged,\n"
     -+			       "and have %d and %d different commits each, respectively.\n",
      +			branch_name, ours, theirs);
       		if (show_divergence_advice &&
       		    advice_enabled(ADVICE_STATUS_HINTS))
 2:  51d8486fe0 ! 2:  b7e29887d9 status: show comparison with push remote tracking branch
     @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
       				_("  (use \"git pull\" to update your local branch)\n"));
       	} else {
      @@ remote.c: static void format_branch_comparison(struct strbuf *sb,
     - 			"Your branch and '%s' have diverged,\n"
     - 			       "and have %d and %d different commits each, respectively.\n",
     + 			       "respectively.\n",
     + 			   ours + theirs),
       			branch_name, ours, theirs);
      -		if (show_divergence_advice &&
      -		    advice_enabled(ADVICE_STATUS_HINTS))

-- 
gitgitgadget
