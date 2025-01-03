Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E09145B3F
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735912051; cv=none; b=UsdbovTzKYwAZuigtwAfH7GZhzQ0BADqhkPgSKs4wp+ImP9BTbQ7auWLDC7nU74xRSiqhGkaNdwSXtg7be9x0PJMiyw9y50u52vXES/EkJ4+m7FRUix3214bCNMkVDKNxIGm4HDqOuIGdZ3TbOxbgqT5ZX4lfQ3pQRIy5HKXuOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735912051; c=relaxed/simple;
	bh=61Cwgaf24P7hgKU0BqdrFga4WYbd0peH2vo5wRkfiBI=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=AAqaWbvDfmAs5kPF61o5FUltATe+JQIOd6LNJlEegUCHeg13FlxV3Zda00hXdpO+4Dbh31WE8MKUeNFPAOAd4NZK7ROCDILCTuiGf8le2jWTve1l6oq3w1lWokliF0FosP3/ZdJRHrDf+Xap08a8q1MEni51W0TCzT728Nv4uRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdSwx36I; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdSwx36I"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38a34e8410bso3939779f8f.2
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 05:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735912047; x=1736516847; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9bfzIMs1z1K/4I+TB0nala+1LunYCpr/6DEFlmTWEb4=;
        b=SdSwx36I1XKpdsN4rOOrX/La4/3ugecrPUojYEQ2PmWxcXZ/pfx4X9rDlJiYYtn+NZ
         jSfYxxr/dODNeNNxBM76jm+r/Kvh5sd3X8011XgWAnkf+56Xc8BExlRKLiqMxwgTpkVx
         INUbbvoEZ6iH7LE72r/YUaO5NRD7NpT/4bjxR79Q8k59ShiUddYvTk0QtP2Ygbn6bF8I
         4kP8L76XigoXYMDJTTxYVGrSnBc083DzhMSqeZ9aXLgof81zJk1E9BFI7bIdWiZYQfxD
         Vescr7ltHyTVm9EWgwjqpU+35p3jFj8QpHKYDLqAWiKtd/MxDLNdDoHhvyMMoRbzPSsJ
         136g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735912047; x=1736516847;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bfzIMs1z1K/4I+TB0nala+1LunYCpr/6DEFlmTWEb4=;
        b=gtMj4WGX2Fm9ZWo+YaFXHR4gI5BzOv1bk1bTYMp6Zwke4uVwj4/I+7YnHUPlEdfHlg
         moMHOHtE3u9gGXh7/t9H0pSoGmsobhuT/LihZgsIs5gxEenruAqNwFkwNwyKZ60T2GW3
         MK0wHG0w7Ef9vJHqcSpByEK0+PfR0TH/LuCASppIzckWICi8/2f0gdSA/99yexxZDl+x
         PzJAH4vr3V9QmcKkbsL4/t6eDKRf8UaCE8ee8LHQCwmIiEXgxXX+3zpo/fkj+d136VP1
         rmme/pF/kpW/S4Md0Y+ovDgzWeiqMoIyHzm6gKI1OPieDq45QUe5iVBLmdaUvP/nTHUJ
         xKtQ==
X-Gm-Message-State: AOJu0YyZRh4YtmK20vcFNY5Un8hxsRJwpn6MisBfoCpyAEi2WFH1wVf1
	hHNNsRsu17zsRsjaRf2ALEnImXyoewzo/mlpqS5B3I7WZBdlPDjLALfizQ==
X-Gm-Gg: ASbGncvJrtOCKExmd0ZMGxI+fdksOx1fPnNTdJrsM7PJFEcPo26Cj3zWYLLG+E8K+Dn
	bD5lw1jKZdmVZnh5/VNEy4JYBL0UDWRGx6s5f1kqZQ3G3N7m2CYe/wTxn9GU3mZpObXdKd4zq/A
	QeQJsFZei8GXJnapNRiGoXQOOdkOshFLTQFiC5bXHmU+QCpvjy3YOvlk5XR3ZTzWeXyLxJVcjvw
	M1mIMej8cNLBbTBPwOcZcBt4v1CFGEbbPg3EujHyv3wAAkAajavNHMpJQ==
X-Google-Smtp-Source: AGHT+IFpGPejb5wx22twDVN/YuUIkJusO2Lc9q3b1TnmVLkWJnrEqubwujdQVnzxrsC+TV9Zm2Dbew==
X-Received: by 2002:a05:6000:2ae:b0:382:450c:2607 with SMTP id ffacd0b85a97d-38a221f3392mr36579111f8f.4.1735912047342;
        Fri, 03 Jan 2025 05:47:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c846ca4sm41470196f8f.43.2025.01.03.05.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 05:47:26 -0800 (PST)
Message-Id: <pull.1845.git.1735912046.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 03 Jan 2025 13:47:23 +0000
Subject: [PATCH 0/3] Doc git commit
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

This series continues the effort of rewriting the documentation with
uniformization and better formatting of the man pages. This time, git-commit
is processed, taking advantage of previous experiences.

Jean-Noël Avila (3):
  doc: git-commit: apply new documentation guidelines
  doc: git-commit.txt: convert git commit config to new format
  doc: git-commit: migrate secondary files to new format

 Documentation/config/commit.txt  |  25 +--
 Documentation/git-commit.txt     | 276 +++++++++++++++----------------
 Documentation/i18n.txt           |   4 +-
 Documentation/signoff-option.txt |   8 +-
 builtin/commit.c                 |   2 +-
 5 files changed, 159 insertions(+), 156 deletions(-)


base-commit: 1b4e9a5f8b5f048972c21fe8acafe0404096f694
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1845%2Fjnavila%2Fdoc_git-commit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1845/jnavila/doc_git-commit-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1845
-- 
gitgitgadget
