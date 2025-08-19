Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA875267B92
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 19:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755630887; cv=none; b=RmQXQ+kRzvnzr8Kg3RNkwSvps05Hxt0pMStzL8G7N2V/KGGGoIBf9iPD0I1DR7Gq3twxgsXBOb45wx7rod3GIqlgN0K8gISWACdIuLo0iJoAlG2Q353u3rIPiGeqDt974S7OZzOOdoChyQQuilw5E/23Za6waByIKhbeIrfPUEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755630887; c=relaxed/simple;
	bh=FBDDOfeDYzXmoq9AksPeGn0wcepRyD9R/1Ir/w3QTaM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=VJ6QxtFhLSjZwkTfc+qh+lx/q33uo7CAjcOWXw/yvqG6OpXTVe5KeUxNDKgY7DyepKonlgKtPBolM+ynoaOvWyVtQKN+yI2bHGd2yjgTpwbmEPnYb4MWy1N90stV8ivvQcLss28b/Nfj8CSPadGsc17WHxYEjHVPweJpMF/4wWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ais8EkH1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ais8EkH1"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9e4148134so2865940f8f.2
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755630884; x=1756235684; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vZTbV6CSY+xL7e34BJZHoQD5BZegTr9r8ntWZabdngY=;
        b=ais8EkH1FmBHonbysd4dMXs++RzE0QcZNX7PbJbyFieDb/4CLYlqOQOgjdIPbeM4W2
         G7dd0s6kzVD/gFcsMYyn0yDZxcT8WvzhOfYmDULsvCETLdRXagllRCM9+kGHYNdQFxne
         UdG6DDFpiL8c+RDTmJXFPJ9EDIjAtwyPqeD6xepABZqJtCmzDN69mjsLpHdZFTLi/KqH
         LFKdlUua+Eb9Mgdj06Y6H/Cl3arjNQqp7MYjAVRF5Eit3UK0V/GVceGD9XZdUk06rn3/
         VZ/pJLHAF2z2j6LwajKQugxTJLhRbPL9BsAl01rNaAjJXAV8P3ABt5o/E+z58rerGfWI
         8XKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755630884; x=1756235684;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZTbV6CSY+xL7e34BJZHoQD5BZegTr9r8ntWZabdngY=;
        b=u/uw6Wh2v9WHPX+wK11/jRMLauEqIMRVeuJ8Avr8/BjPDTGgu/NMkrctkqdn8m5Ja8
         KC69rA+iiaLxBbHT7oibqjpcNt67HUZ8iVg6bZO7taq7XjYPl+j+IOGw9KfbQOOOuEAC
         c7vqTL+l40ZgJNrOLGxouRGiiVSBZtHBMc11AolPLY0NXbSXcYzyv58kBEFYzcVL901J
         Y/P/s9dUKp2onYUnmRwWRbENrf9a1j/5bH2MlZAZIkY2DgrHxo/5MxxG8gsZItw47DF3
         f3dqRsH6/QagSsnQ5I87wC6v4V9w3uJytrmgpi7iFanH5DAMkRuVzY6fBPzfecJobybB
         y4xA==
X-Gm-Message-State: AOJu0Yw4N2m3OWfss8D3ed7VnIONDl8ozbiK43bJ4G2/SOx5p3ZoH1A6
	KZVYu049hctr4YoP4dcbE0A5oNE9RQ4/PJVblJnkDaGpuQSiwC4Y6yIRNdtVL0+d
X-Gm-Gg: ASbGncsO5VO5zuN3pJLTNynxkzxvaw1Y3sUFvjlrC1Z5DzL6BwoNFie2PeCqwSa1Et0
	2u2WwrigTcKf71CtInBNuFVUf+GjcHe1n8BFKFJCPboGq1s0C+nyhQAjuH5meB/X/nRcY+kiRbA
	xKCawzxkt218/lkW3UHZEiPeD3v+eMeMo5kHhq8gxRvbr1QhpXS+GAGTJfNOc9dSG/WDCK/UWH+
	7IzFG3e1AR31vZVmnb773wmthdyOJyDYbPs4bml7fsrx7yZgHobhoPl4+uj+6lDp5Uk76ytvRzW
	/OFNOrItr4w6hyHQE7dF+e9Ly267wJJL8HEt7pF30wCqkumHExkLVdmcKic1OokXmXdPS+JSP2h
	6gPqAfEY8BITUwdRImCm/G/Ee0mNyayHbVQ==
X-Google-Smtp-Source: AGHT+IE81rIevHRNkCoUR/g/AmrCghU1C86kNYL3HgG6j/5adyafr2S+253nkmPffDryEPPBikBW6w==
X-Received: by 2002:a05:6000:2482:b0:3c0:77a6:9c96 with SMTP id ffacd0b85a97d-3c32fe1a23fmr90004f8f.50.1755630883471;
        Tue, 19 Aug 2025 12:14:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d43956sm4853960f8f.19.2025.08.19.12.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 12:14:43 -0700 (PDT)
Message-Id: <pull.2034.git.git.1755630882418.gitgitgadget@gmail.com>
From: "Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 19 Aug 2025 19:14:42 +0000
Subject: [PATCH] doc:clarify which remotes can be used when contributing
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

The docs mostly point to using git/git as one's remote, however, when it
comes to Sending a PR to GitGitGadget section, the reader is told to use
gitgitgadget/git, with no mention of git/git, potentially leading to
some confusion.

Clarify that both gitgitgadget/git and git/git can be used, albeit with
some differences.

Signed-off-by: Daniele Sassoli <danielesassoli@gmail.com>
---
    doc:clarify which remotes can be used when contributing

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2034%2FDanieleSassoli%2Fclarify-remote-to-use-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2034/DanieleSassoli/clarify-remote-to-use-v1
Pull-Request: https://github.com/git/git/pull/2034

 Documentation/MyFirstContribution.adoc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index aca7212cfe2..d014c5c36e1 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -908,10 +908,16 @@ Now you should be able to go and check out your newly created branch on GitHub.
 === Sending a PR to GitGitGadget
 
 In order to have your code tested and formatted for review, you need to start by
-opening a Pull Request against `gitgitgadget/git`. Head to
+opening a Pull Request against either `gitgitgadget/git` or `git/git`, depending
+on which mirror you initially cloned from. Head to
 https://github.com/gitgitgadget/git and open a PR either with the "New pull
 request" button or the convenient "Compare & pull request" button that may
 appear with the name of your newly pushed branch.
+If you're using https://github.com/git/git as your remote, you will need to
+open the pull-request from your fork, selecting `git/git` as base.
+
+The differences between using `gitgitgadget/git` and `git/git` as your base can
+be found [here](https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)
 
 Review the PR's title and description, as they're used by GitGitGadget
 respectively as the subject and body of the cover letter for your change. Refer

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
gitgitgadget
