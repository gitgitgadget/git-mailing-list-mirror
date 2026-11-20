Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199752;
	b=2lU47dtSMgc1f4olOAbnBD1r43IG6ggIjaGkvAC0sbaDX004kIVybJaGm8Y6RPfqCzUP
	 v9bA9GYR46oogbh5n0k7I6WJXquxnmenfClX9peDpns2aWcRQC+KjDfrWvhQj4ixsNd2s
	 Pl2V1UztYTlp4v4r6GKmiiMN+ry70aG10G3K0XbZAskAd6JQyUw8l/+nLjvQilL3Wikym
	 wHASTPQJhk+MyBf/Kwb7gXt3XZ4zxTXECSzYycvGjvTmV/4Pt78Md9GBK50G1yn4mYjNw
	 D93ehYwOIymqbybvaemOBCAsDQ9rsKAKv6H12ecKA4NWElfl6PD9/2mzHn7wANh6T8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=LnHD+MMxFE+2Rd4+MdCeRDoTVZizVPRNbhMrTPezNok=;
	b=JyvXGIVLeh/OJpnzN8/xVujBNSg9PX6UuKAHd7dHOJ3Cm78/yA3AJVsIvGe2jj1bvbwq
	 KRgkTF6OepK7ScRkB4RiV7MOqKyf+onBB1RTI3einL8xGXEBtjjuMexpzY7+otMORxQRP
	 6X4IVZlhlh5kGFvlbQJnfSOMXMAzPFJmmgmYkFy/biktz0owrvOP9Qgm77E4eOpCk9F5M
	 3RBW8CU6zAU3acxW1hQRhfL8JhkC6sY1/DJnGgLoa0AYZnCbbX64Njm2QFQgM12/5Lz1u
	 rQKApt6iUUwR7EY6SXB0NeSC8GeZE/jWvBJrM6SzIV1pnOJbKpHFUkNZiWKqHTbSw4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=htVrnUmn;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EEB60A260C
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 18:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70EEB60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=htVrnUmn
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-862b3938d98so622881a34.3
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 10:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795199748; x=1795804548; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LnHD+MMxFE+2Rd4+MdCeRDoTVZizVPRNbhMrTPezNok=;
        b=htVrnUmnMR7RCE5DLgwYB6T+Ucy+K4BUjaOYeku2vnJcEzYue7MKw6+wP9Wa5Z69fu
         LjMsj9B7RSYztNBSFCRY/S0ePOQI/XmqyPoaC0v45qlxWRJl9SA/rTEx1w7q6n67mFVO
         9ioh3dfewYowJlT7PobPg/htK79wmvCiUgSeVgbbJwulF6sbo7x7/zTjzl0f6lKFwsYU
         w92PL6IiiB7mA8HLIPvN35g4lrOWwIoCsFVbBrWThybje7Or7mfnI+pvXE7UWuupJU/h
         eyL/jrTbZPKvhlAgGLrrVcsthg3dwJTfdQqmeBKGD4ISUvJK0a4SYae2wizFaboT+DC+
         /FSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795199748; x=1795804548;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnHD+MMxFE+2Rd4+MdCeRDoTVZizVPRNbhMrTPezNok=;
        b=szXpuMARr7jQ7E94F1QECwc7EjThDKLZXiDys/M7EUO9hddQm4QsY9Y712zVKoc0p2
         5lvX24YCHMujLxJ0s4jPNt5R6NTvGkEN7tH8hwxG3q/2HEG0VXXTV3jopbMEU8jQ+l39
         fDnyZ2zpX4j213BnmKT2H9t4CqY4CH2vZyTv7vQN2GR9JIdsU1fHqBfzYpE6cZSkUmoW
         5viVMEqNa2D/R5Rpx5AMckm/IM1PrCCP5vqwCH2jdRBkxlgDEOeoke0R0DTci5bkaGqV
         kFpEUW7ypnMcc7EhYtrEF+pLXfqDS/wB5DZ8VV6ivcPJOcumNWZZdLfqu2aLqeCNnPy6
         C8NA==
X-Gm-Message-State: APuU4Z+/JqolXUmoe9OdVTfrbxKZ3nCm7dDs2QYOm5CXodzExZd0q0lQ
	Lzz0IWJd1AXv8OxkJP2+ucWL3N+M7gj60bgd+2A3YQBqhuaoVJgRLyEM89UB7w==
X-Gm-Gg: AYBFou3lMY7ySHGgsbivGh5RLCfgUukG4AR2ysSG/+zPVR1Gt4YhxEME8P/2+oZFepw
	oTaIMUCSELYmJyydccEtQ01vrR0wihq61HF0NpQMpswqp7ePwEK15yqCnYzVC+v/Gvc0VpsUHZM
	xiPluOfT9dsfdU8YaGPcgxdYCKueigtBTxfBaTE9/Wqbkv9Ineldq7jP9K+ls8+yIsP5zIOu+vr
	ebXoKYwi5hx1pbCOWwBygeuOLvRkGkuqa8ZFM7wCf44KFQu19G4p4ord6w3UcLGJ0W4HUS696RE
	dXbDxpAGNsx1rwceigFLWDW9u4oyHe2mI9wzHuATwRMnCgm2R7XEyIVoDFy8isP4i6DsYfp2kyJ
	uQqSeqnM56BBWgzt0cQ9X1Tc0NBnYYCh7k/wmEJ5iIYhRUmiBIjGfYEleQ/dHVKGBGfXJ2E0sN9
	WIVweUx8e1Pasb5eLHLT/ouXWcBG9k6byif4bMCxOim6wolL/MoXeoADDdz50sk5Zm0iYty3BJU
	vA99FMP5Rz/Bivm+ra8C5NuRHlEOBJ87ucvCS53hmpscjV7W13nT7Z8R4DuHjFDM/xen7h9FSCB
	JdsV3JqcuEarCMRqRXz7l1oG9t4yh14L
X-Received: by 2002:a05:6808:1a0c:b0:539:e1c7:c05d with SMTP id 5614622812f47-57a0c3958bemr4694647b6e.49.1795199748159;
        Fri, 20 Nov 2026 10:35:48 -0800 (PST)
Received: from [127.0.0.1] ([52.176.67.192])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a35655a5bsm2758759b6e.13.2026.11.20.10.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:35:46 -0800 (PST)
Message-Id: <pull.2496.v2.git.git.1795199746309.gitgitgadget@gmail.com>
In-Reply-To: <pull.2496.git.git.1795194752259.gitgitgadget@gmail.com>
References: <pull.2496.git.git.1795194752259.gitgitgadget@gmail.com>
From: "Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 18:35:46 +0000
Subject: [PATCH v2] doc: fix AsciiDoc syntax
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ophir Bleicher <ophirble@gmail.com>,
    Ophir Bleicher <ophirble@gmail.com>

From: Ophir Bleicher <ophirble@gmail.com>

The Documentation/MyFirstContribution.adoc file accidentally used
Markdown syntax for a link:

[here](https://gitgitgadget.github.io/#...)

Fixed it to use AsciiDoc:

https://gitgitgadget.github.io/#...[here]

Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
---
    doc: fix AsciiDoc syntax
    
    Difference from v1:
    
     * Change link text

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2496%2FOphirBleicher%2Fpatch-3-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2496/OphirBleicher/patch-3-v2
Pull-Request: https://github.com/git/git/pull/2496

Range-diff vs v1:

 1:  748ac69283 ! 1:  cf26060e59 doc: fix AsciiDoc syntax
     @@ Documentation/MyFirstContribution.adoc: either with the "New pull request" butto
       
       The differences between using `gitgitgadget/git` and `git/git` as your base can
      -be found [here](https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)
     -+be found https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror[here]
     ++be found https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror[on GitGitGadget's official documentation.]
       
       Review the PR's title and description, as they're used by GitGitGadget
       respectively as the subject and body of the cover letter for your change. Refer


 Documentation/MyFirstContribution.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index c58253fd54..73dab5f7c9 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -931,7 +931,7 @@ either with the "New pull request" button or the convenient "Compare & pull
 request" button that may appear with the name of your newly pushed branch.
 
 The differences between using `gitgitgadget/git` and `git/git` as your base can
-be found [here](https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)
+be found https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror[on GitGitGadget's official documentation.]
 
 Review the PR's title and description, as they're used by GitGitGadget
 respectively as the subject and body of the cover letter for your change. Refer

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
