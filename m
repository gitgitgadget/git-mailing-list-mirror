Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04892BEC22
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755679024; cv=none; b=TQp1kPfMQkpN2GDdHHyQD+8fnEVovxh5eyE9w1XSXz0+cwHXT8K3G/ZHwVsVUhzYy2VdSFq9sJ7/hclYGPFisSOxJ9dX2Y+LD2rLcrsjM0b9MFxS8/skOivU+x3vDy6Jy7XV4QX12ALfCAQ5zTV3/IJnZLpIMOtQopUbuFxzuV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755679024; c=relaxed/simple;
	bh=0sMMfh/dZDXzDZDQ0IYoYGFah2hyUX4Ekc+c7CKSNPw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lG+xWzJ3X9GBE2DYjBs5l5He8gGroIvDfkg1QnDP0BY7rtWg0TkiybLnkU8BMfYsVz4/3nMiMSH2XP8Jm7itSXq8oJHA+YSDqgB6PqVyx/miBBE8MuHwZ1RnSNPQcYJtBG2463Ze/0ajfQU/Cgv3HaMzClaF20iR5OeYF2faUiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moi0PBfY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moi0PBfY"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so31957245e9.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 01:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755679021; x=1756283821; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9udx5pBwJSYae1mEXXr1IhPlWMKUkSuzZQMnchsi30=;
        b=moi0PBfYLg9mhaxNGTBGkjMK15NPiOCYYIyImINGkoQG5tMRYcSu2IthVRBpegrsMd
         y90s+ns1HsXXGPEg0vLl5EEqX+ZkioWUc6BUMvRpSJ+C8bwAWoEkylsKlhELoVFdf2g7
         ulPA1pnTkEdnLppUWYvJp/6IHk4yyJ53Mxqnxv611dqd/ixISaVwjg2DwWz3R2CYjBoq
         FaGPpKOWFH/hHGdWvEo+9ySQ4bwE3bkigzc9xV3E1SgDXQXHzlDIah4Dbd7y8tWpBTW5
         1bVjQ62HYWNnxVYMOPcTrbnZVKOHwMWCcMtVZYR4MnA31f+WRfuVz1erzmqgfM8lF6pv
         sOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755679021; x=1756283821;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9udx5pBwJSYae1mEXXr1IhPlWMKUkSuzZQMnchsi30=;
        b=SIV1FCQKhBcGAxBYJrMp+5E8Amkod+4dV8cVhfXpGEKPUnGJTKv08/9PzvOOo9bkFp
         rHncj5Ixzrm7bHqQqCMPveckQDh/KAdoQg3Rhcja/ve9LMojTWcoJHOSr72fKa6xFEF1
         UQHKr54z+59tVIvvEsnkxfYEFbGXT8T/NtpeLMCc6Y6JvK7wuSKgBDh8Fpoo9irB0DVU
         AO/pcIv8Kl7iW53VT1Kq8+DiuR1Dv101rX/YR1rFsEF+JWoOTN8MflYL8xDk/GjCETdj
         jwQJlSJFrHe1jl1JBJKE769mRRyPrbsEICpgTTM7ssVt6VarVPkbqyzdQ7kmz2a5TRTo
         YAOQ==
X-Gm-Message-State: AOJu0YxhJUTml5cG07IJxQFaBtfL026gKdoD8QGvJP6e7IAha/BLXf47
	q5/tIbbOuobGPQCFI2j4hRHpJqWKVhCbCnW6TFv3ZajUOgY9YkzcyQ+oHaLfV8PW
X-Gm-Gg: ASbGnct0hdhzpROkeq8MnmUFlCMsdG7naH7DCZF3y1bHAinsoHOiVEgkf4peTyyFl8c
	VBNiWCEsdGc0nzGw2kAUpIywCC40kzGK/CptL4GQxo+zIFInQf3ix3h1WyCn3B+Ey3JuQWnIUKj
	Q2OOqGXHChjtzoqiAt7Beae89RlEsYBgtuHSZ/yBOOcuJvlZIA2kAJ4EPg9VoQDohpMChB5PtFg
	oB5tjvUoejbbJC9bcAC0+NRxfsJ+mXIZSHfr82QVF327tHTv11UfhuKTlp4XkYz4+LGh5W4q9HG
	9Uq8RR9PAs0T6jJMrIiqEKmGq3cgq0rSxd1UTwUac+7eP+dQ97hXQLDy66FPULCBzowakubZHYJ
	DlsQEj6qEQYLjD03lfiygJ/Ktdlp/add+KQ==
X-Google-Smtp-Source: AGHT+IFk8IWWyGfcb/owBKMP5ssb0/KUyfXJFJ3xtp+qZvYEFryxnTK4fsKviDE57tzB7A5ikfu2Mw==
X-Received: by 2002:a05:600c:3b9e:b0:459:d709:e5cf with SMTP id 5b1f17b1804b1-45b479a6664mr14594045e9.3.1755679020274;
        Wed, 20 Aug 2025 01:37:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47bb2431sm22532955e9.0.2025.08.20.01.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:36:59 -0700 (PDT)
Message-Id: <pull.2033.v3.git.git.1755679018997.gitgitgadget@gmail.com>
In-Reply-To: <pull.2033.v2.git.git.1755641032154.gitgitgadget@gmail.com>
References: <pull.2033.v2.git.git.1755641032154.gitgitgadget@gmail.com>
From: "Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 20 Aug 2025 08:36:58 +0000
Subject: [PATCH v3] doc: add discord to ways of getting help
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
Cc: Daniele Sassoli <danielesassoli@gmail.com>,
    Daniele Sassoli <danielesassoli@gmail.com>

From: Daniele Sassoli <danielesassoli@gmail.com>

Discord is a great way of receiving help for members of the community
that are not on the mailing list or not familiar with Libera.

Adding it to the official documentation will aid discoverability of it.

The link is the same as the one at https://git-scm.com/community.

Signed-off-by: Daniele Sassoli <danielesassoli@gmail.com>
---
    doc: add discord to ways of getting help
    
    cc: Collin Funk collin.funk1@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2033%2FDanieleSassoli%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2033/DanieleSassoli/master-v3
Pull-Request: https://github.com/git/git/pull/2033

Range-diff vs v2:

 1:  ed4fef87be7 ! 1:  499a5b0c48d doc: add discord to ways of getting help
     @@ Documentation/MyFirstContribution.adoc: respond to you. It's better to ask your
       can be answered if you disconnect and so that others can learn from the
       conversation.
       
     -+==== https://discord.gg/dxGanGcBSP[#discord] on Discord
     ++==== https://discord.gg/GRFVkzgxRd[#discord] on Discord
      +This is an unofficial Git Discord server for everyone, from people just
      +starting out with Git to those who develop it. It's a great place to ask
      +questions, share tips, and connect with the broader Git community in real time.


 Documentation/MyFirstContribution.adoc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index aca7212cfe2..d786176bba2 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -52,6 +52,15 @@ respond to you. It's better to ask your questions in the channel so that you
 can be answered if you disconnect and so that others can learn from the
 conversation.
 
+==== https://discord.gg/GRFVkzgxRd[#discord] on Discord
+This is an unofficial Git Discord server for everyone, from people just
+starting out with Git to those who develop it. It's a great place to ask
+questions, share tips, and connect with the broader Git community in real time.
+
+The server has channels for general discussions and specific channels for those
+who use Git and those who develop it. The server's search functionality also
+allows you to find previous conversations and answers to common questions.
+
 [[getting-started]]
 == Getting Started
 

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
gitgitgadget
