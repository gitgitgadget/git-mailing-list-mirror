Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343C22114
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743354969; cv=none; b=lhTpkNPDtc5Cf7ksfBnmlAVf+Xm+u0KC8PI1WEWoh+JvcxWLamwzRBk5ObkupzbFH0VXm5vkE/RPI6WvPpqLnWzOFZRkaeLgPJ4iwQ7D52o1sQevY0wTEm+exTPfzU1eeqpC3z8lb8dxn34h9dd8Y8YKPj3ozHmirdeA9NjyI88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743354969; c=relaxed/simple;
	bh=BAHW7x3/Q10y6GJ7JAL6ptAJoWApkLGJrDaKGB2/Y14=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=k6jmZFFIN/2grlDCifjNFiTliVvxW+jqHfLi6hxvXt6KcZlsR3LK2OjA7zQe+FV2yej/LtrIuk86kximJneVZRansmBmpiLJ4DG51gIuWhqqKm6XYmbiVaZl0wWyhqcsgibq/REHsYmxFGBwZgKkZZEHV33Eq9K6g6O6rPe8fGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnuF/r+8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnuF/r+8"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43690d4605dso24769105e9.0
        for <git@vger.kernel.org>; Sun, 30 Mar 2025 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743354966; x=1743959766; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SgOTftPJN3NOXUFQN7V+sN8CzGrRsteHXEtC9IxXmxo=;
        b=jnuF/r+8hVykTVY0uH6HjrAIOwyTcjeBFRtksfZXDAqiTu96i1tSIjqrKCOikeuzYK
         6G4SXQp2PWYKKy9BDoOqXkHv6tqZOfQb8AuWrpzT61TGyp4uEVbXPBOuvgLc+qvFweRB
         0xhYuFDuIFujwNzyWHofG8cVgLtEnc7FwgKPTpsSKII5bXT9gOXvtfNazfBUpWH/x0Kv
         al+RXLRM3wsOfsDRGQ5LRJKMBJvDi5ud3cI6eHXatIM5qs9MSyrsrTtDFESgCnqF+hmK
         U1fljvfG34Arr9tVLpe16fuc+rWoZBtTEeqVw7CZ+TcyeMMPamm+4Vb1jhN7mWkZmBLf
         2v6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743354966; x=1743959766;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgOTftPJN3NOXUFQN7V+sN8CzGrRsteHXEtC9IxXmxo=;
        b=Tt9of8viMiwOV4rq7SEu5w34dBfbcaccf7qD+D2V4pM/K8h+Gwby4WX2MgjAxeaD4Q
         YN1lU3ejaHztecKqLMYKcBbw7KuiYRBstPmds+1IHxzsGHPp4XDIoPxH5Ab/POG6i7nw
         Ysuq49bfTA9Vdi8CehfZhOMl5DbAmddofpubPxUvvtyGVzBmPsezTo+7OIuloUJdlvSW
         gAq/KwL23BoJbTuIz5MwVbfIwNXbKoHA1CyHRr94F//ybo3Af3UDq5KDTZohE5FZDmqh
         Xn7nbCffmVSRFx0QSRppSssAsKU8f3NJpVUBkYAtNViw7gc2IEDFsUv/rrUrKSVEg4e8
         XYlg==
X-Gm-Message-State: AOJu0YxtSDWovZtCIr6MfvwfHuY2fg5Ei5BWLS99fRaNBQ8JJ9M5tJP1
	79gPeKLdOOCD/VhK0g2iBC4z8NxRngbG7FTXh0Cl0Ef/stn+gyen0ADYhA==
X-Gm-Gg: ASbGncs0VA5U6rd1NuQkj9npq9F4ExTRaJuehgFy5r3P0G+8WNBnfvPE4Wemujw5IHH
	SjL0zUdWvg7TGpZNWoRTgw4YsDbGhteKjCXwghH0FXZqLnxshM1+3XZtj20MPi3aOo64DH2dP1c
	qmJJsShE5+OVer5OQRqCm3JGYd3Nl3CfgJotigi3E+qeGtRPURcZS4VPeoxU16ZzAddnwH4V7mQ
	bmIv/boEp3RzdbaN2IRN2we9QXfN40KFmTgG1QuBfs6EBxWog3AlYIT63X2lCNdlNEJZEdvADIW
	BMsoT7IDkWnoRUorjNFUDwE9L5lwdQLfRLab0zmybPKZbrCDviJASpH0
X-Google-Smtp-Source: AGHT+IEeuuLKgqxAsvMtA0TkNAWIvxkYqN16dIzedUpFmPJ0PHykLs2guGDTeHXHRgNo+h1hiAjJHw==
X-Received: by 2002:a5d:6c69:0:b0:391:3bdb:af5d with SMTP id ffacd0b85a97d-39c120e09d8mr5055810f8f.28.1743354965548;
        Sun, 30 Mar 2025 10:16:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b6630a3sm9036599f8f.30.2025.03.30.10.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 10:16:05 -0700 (PDT)
Message-Id: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 30 Mar 2025 17:15:59 +0000
Subject: [PATCH 0/5] doc: convert git-reset, git-rm and git-mv to new documentation format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

 * Switch the synopsis to a synopsis block which will automatically format
   placeholders in italics and keywords in monospace
 * Use instead of in the description
 * Use backticks for keywords and more complex option descriptions. The new
   rendering engine will apply synopsis rules to these spans.

Jean-Noël Avila (5):
  doc: convert git-reset to new documentation format
  doc: fix synopsis analysis logic
  doc: convert git-rm to new documentation format
  doc: move synopsis git-mv commands in the synopsis section
  doc: convert git-mv to new documentation format

 Documentation/asciidoc.conf.in             |   8 +-
 Documentation/asciidoctor-extensions.rb.in |   6 +-
 Documentation/git-mv.adoc                  |  33 ++++---
 Documentation/git-reset.adoc               | 100 ++++++++++-----------
 Documentation/git-rm.adoc                  |  56 ++++++------
 builtin/mv.c                               |   3 +-
 6 files changed, 103 insertions(+), 103 deletions(-)


base-commit: 66b90d9bad8476f6f3d71f5add5cf78809a998ed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1896%2Fjnavila%2Fdoc_git_reset-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1896/jnavila/doc_git_reset-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1896
-- 
gitgitgadget
