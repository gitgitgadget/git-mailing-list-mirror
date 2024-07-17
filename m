Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799F3183067
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246271; cv=none; b=uPg1xMlbdgEC81sdRyRbC8qwERdsOl2ZKY7hxR5htKOeaMTk/i+/YdEDlAL+v6BP/FG8nanYlNqnNQdWdqPCYSeufI1GTyoH8r323dZ13HyQQpD5MDWuKtgE4w74Ixmebx+FFSuCDFUmvnfwGtrV5Pse4iaDNwcvjLzxDnP5f78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246271; c=relaxed/simple;
	bh=roE4c2K4hl6Ef/SgDwGo8uHjk4L0Uf2bGzpvE/LkcRQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Xrg0Z3UYBlD8oiw10zmSBVfFWVta3z7D939W2Pqa7HkrKMopUvqaevkqO8DdrdDWEj9v+v7UF+a7ynM2/CEPHUOj4euVq79hBjI4OGEiQc5cd4yGi+pUVnyf44sVvyccJIp7z1PJoCSPVQ2JhuAJeecpvyQ2fXxureLzddenviY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SG8NLwHk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG8NLwHk"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-427b4c621b9so402615e9.1
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 12:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721246267; x=1721851067; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CAQyy26zgh4+3STBvToYHacjPRqs5ZJ4xivdhkr5Zwg=;
        b=SG8NLwHkdoU+myQPaIBJoi5Ms3XOxhkEDLeSy+PuMsfDbFwHffJBT6ZDDOP7YP+D8U
         3X4rnwRY44MqPjM3+GLzlJ8WZXqnZP6PTz8fZ+ObVD/LsMkIWVq3BP5bax2lc6zigeHn
         Z6HPizb9HnT0st4+m3dROq3JFepmI7s6kqcAM7nxADNwa1pqXMu3csg/n718hKlcaIc9
         +GF9yLVSPK9v/JOry16y9yIGT+v2gTBtVahjsEW0TgsWCRqRxAdRRIOAT4MMoHC9WzFJ
         6wikUqH9mUHtj16Es93QJDIqObZwxid38rNxguwmO+g+swq0rmHUWs+gCYEMTDEaQRkj
         2cLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721246267; x=1721851067;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAQyy26zgh4+3STBvToYHacjPRqs5ZJ4xivdhkr5Zwg=;
        b=t1ve6/vPDVh2rzCe2sDFOc0NVUJWSqQ0Hm1dep85Qfo+ETuuaLdqLKoWs9U0pz63t9
         Ti0eUr/vX7u6D+QC0fyVdJM77q/ohn4bqyZI8GEgreVal1XA46z10mRhp28KiY5dCejM
         vQPQ7trLwj95V9R4ba5oYf2MQIt3YG5wjH12CvVxzFcqsnV5u6cqGbqFM/FcEFS0z1/E
         rjlz38TwbSpcXsjhDma3i5onjKmMR2lO39rCtmjVa80hgH5fO76BVpBkN9bbwu3LNyZ3
         IFuI+su3nl4T4hUc+mw+/EQ8T+qQlYb82FEWDfDHRHsg/1IUOfDyEj57/iDpvkckqR+d
         L5gA==
X-Gm-Message-State: AOJu0YxBk6eL6cdwLZRNx62irkE13qy6DL2ZAIh1EwMbRFt3Mmb/v376
	CsZ6ni80tbj6EYEMM5QHpYT55uc9dA5N0TmC6M8rVAisCz3pwZtDmu6oYw==
X-Google-Smtp-Source: AGHT+IEJllvq2LPuLv398i5xQDxLSKPkugN03C8IJq3Egvd6LgNBesWLkAjSrV3gReRw2hKrv7XfjQ==
X-Received: by 2002:a05:600c:470b:b0:426:5dd0:a1fc with SMTP id 5b1f17b1804b1-427c2d05ccemr20453955e9.34.1721246267107;
        Wed, 17 Jul 2024 12:57:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77f21bdsm9230475e9.29.2024.07.17.12.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 12:57:46 -0700 (PDT)
Message-Id: <pull.1747.git.git.1721246266.gitgitgadget@gmail.com>
From: "Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jul 2024 19:57:43 +0000
Subject: [PATCH 0/2] git-svn: use svn:global-ignores when creating .gitignores
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
Cc: Alex Galvin <agalvin@comqi.com>

Git-SVN does not currently use the svn:global-ignores property added in
Subversion 1.8 when showing or creating .gitignore files. This causes
Git-SVN to track files that are ignored by this directive in Subversion.

The following patches add svn:global-ignores to the list of public svn
properties, and update git svn show-ignore and git svn create-ignore to use
this attribute (as well as svn:ignore).

Alex Galvin (2):
  git-svn: add public property `svn:global-ignores`
  git-svn: use `svn:global-ignores` to create .gitignore

 git-svn.perl    | 45 +++++++++++++++++++++++++++++++--------------
 perl/Git/SVN.pm |  2 +-
 2 files changed, 32 insertions(+), 15 deletions(-)


base-commit: c2b3f2b3cdbf5ad9feb978dd367d77561a1271f7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1747%2Fav-gal%2Fgit-svn-global-ignores-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1747/av-gal/git-svn-global-ignores-v1
Pull-Request: https://github.com/git/git/pull/1747
-- 
gitgitgadget
