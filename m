Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406C413B58C
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721855187; cv=none; b=kes5VWsq+cmnsxT4OjO8NtBSZyAe7NsLraGjRDZmtlFVE5fEDYdR1sifMvqXiHeUun0I5We/HtliR3kq6LC7OcuCtFbE3PEaEuAugg1iumlzzE8E5UPbIGjQshcjWl2QVmdqRg3/hGoj0i2zI1CQOnmxbPhvd6UtqjrqSbv0AT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721855187; c=relaxed/simple;
	bh=X04fEjNN/W/ZyDkTjwIE4A3HTYvwGbGbyzFhXmi3C1Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=sqGJ6QJIDOnBrUuGwpSBw+z7OLPNdaqGuezj9dD6caoOn0fK8xX1+KQUpmGiCVeK2zMC8qdmtqyyvzRMqatW5e5SV0Nkc1DGuTONi44BMzbIP3qXECgh43tAbO2SdInh9llBbzMjKhMapGCP2Q6qTdCRiWZBWJdhvtaQLRNnudE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wc3EFSt6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc3EFSt6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so1849065e9.2
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 14:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721855183; x=1722459983; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhyUs2ExxPK/4v314vdlOlE9WAtjc1QBp4qhny3BFn8=;
        b=Wc3EFSt6smeeRYK9sFyOfUJ34MEuGYvN7ji6WXJdpx81OFHDaE99DwEF1dAhxubwTl
         Guvd+Bav0y0B6MM4TRQois13j41Ofevx4qBIP1oW8IOfzfYv/mFi7R3rpFHT22wHF2La
         mXMTzfV+AO2IlWeaH2p/AgCfUudNXfpn4uEMgahB6A2MEXuw8SS/w9bYtIeBoZ+fG7jZ
         dj0ofgUvm0Q/tInYTgNayFu3O4TATT7o0SqTev5X1XfzTCMZC4MY60jt9f9DY0PwcDui
         u38RBxmBcy7nGEESFznu1B17tawiQQvpLLh1fT3/CP8xNhlLd6631xzGZ8Wa+58+NPOt
         dfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721855183; x=1722459983;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhyUs2ExxPK/4v314vdlOlE9WAtjc1QBp4qhny3BFn8=;
        b=qFLyeT1K8LCCqyNnzKqYJDIS8S353cb17nXSrOYYhLTZ2b5PwfG4w1V5/rwYnPGKGb
         cVcOPxJKVVcN8lBOt+S21UAb8s8A8LJGviqYvz4EhMdBF2+TXUd0xfCdwnw/DATFs0VZ
         nuTr9gF+XTz1uzajOFrSCLF0F3c4NBv65mH2TFddBsCkthCLBqPHz+MPPexoNYUbqXgu
         va3w+j44bvTFMHfkn4PEPsFQ5rxaYc8YDx4YExma5lX9PEWskXkYZ13nm7Fu94HR7Hrz
         uCa/7cgo7rt9qWnM056pRNH6eIxOiILD5vA2FcCk1Cbl1xlLXMPdkWibj41PgjLzVOn2
         xshA==
X-Gm-Message-State: AOJu0YwJNWZZk55X9ogDLxYATSqFHY1soAY8bYyIIrYMfxJB9vl7I09y
	51VcDgbMfZkwstnnUuXWz1SMzK7k4moGn5Yh0+RBPgrPHXDv3jhet7sQQQ==
X-Google-Smtp-Source: AGHT+IGAW2rwV1dPEdHkFN3SPKPwzE37YvanitOYuwH80lcGbtgd1WsziC6lFvzfD1mKuBtf7ZnJQw==
X-Received: by 2002:adf:9b19:0:b0:367:9c46:198 with SMTP id ffacd0b85a97d-36b319e83a8mr578708f8f.1.1721855183204;
        Wed, 24 Jul 2024 14:06:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-369f7f4e1desm2619794f8f.75.2024.07.24.14.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 14:06:22 -0700 (PDT)
Message-Id: <2a61e0945deb204547a930614eec431b50b1bd1d.1721855179.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
References: <pull.1766.git.1721774680.gitgitgadget@gmail.com>
	<pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Jul 2024 21:06:19 +0000
Subject: [PATCH v2 3/3] doc: apply synopsis simplification on git-clone and
 git-init
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

With the new synopsis formatting backend, no special asciidoc markup
is needed.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-clone.txt | 20 ++++++++++----------
 Documentation/git-init.txt  | 12 ++++++------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 8e925db7e9c6..53b1c3e23f75 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -8,16 +8,16 @@ git-clone - Clone a repository into a new directory
 
 SYNOPSIS
 --------
-[verse]
-`git clone` [++--template=++__<template-directory>__]
-	  [`-l`] [`-s`] [`--no-hardlinks`] [`-q`] [`-n`] [`--bare`] [`--mirror`]
-	  [`-o` _<name>_] [`-b` _<name>_] [`-u` _<upload-pack>_] [`--reference` _<repository>_]
-	  [`--dissociate`] [`--separate-git-dir` _<git-dir>_]
-	  [`--depth` _<depth>_] [`--`[`no-`]{empty}`single-branch`] [`--no-tags`]
-	  [++--recurse-submodules++[++=++__<pathspec>__]] [++--++[++no-++]{empty}++shallow-submodules++]
-	  [`--`[`no-`]{empty}`remote-submodules`] [`--jobs` _<n>_] [`--sparse`] [`--`[`no-`]{empty}`reject-shallow`]
-	  [++--filter=++__<filter-spec>__] [`--also-filter-submodules`]] [`--`] _<repository>_
-	  [_<directory>_]
+[synopsis]
+git clone [--template=<template-directory>]
+	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
+	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
+	  [--dissociate] [--separate-git-dir <git-dir>]
+	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
+	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
+	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
+	  [--filter=<filter-spec>] [--also-filter-submodules]] [--] <repository>
+	  [<directory>]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index daff93bd164b..eba67fdde83f 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -8,12 +8,12 @@ git-init - Create an empty Git repository or reinitialize an existing one
 
 SYNOPSIS
 --------
-[verse]
-`git init` [`-q` | `--quiet`] [`--bare`] [++--template=++__<template-directory>__]
-	  [`--separate-git-dir` _<git-dir>_] [++--object-format=++__<format>__]
-	  [++--ref-format=++__<format>__]
-	  [`-b` _<branch-name>_ | ++--initial-branch=++__<branch-name>__]
-	  [++--shared++[++=++__<permissions>__]] [_<directory>_]
+[synopsis]
+git init [-q | --quiet] [--bare] [--template=<template-directory>]
+	 [--separate-git-dir <git-dir>] [--object-format=<format>]
+	 [--ref-format=<format>]
+	 [-b <branch-name> | --initial-branch=<branch-name>]
+	 [--shared[=<permissions>]] [<directory>]
 
 
 DESCRIPTION
-- 
gitgitgadget
