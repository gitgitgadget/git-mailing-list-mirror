Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9FA1D959E
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972638; cv=none; b=EVU2upmlGDR/+RAdKrF8t9esWh73QopIq7BCK/EbrtEVUosjeD5XKacUgDccrrqPr+WA6XVGHwA0/hDhv5x1zw/EZ8uhpMeMBra6apLYMxpF7EG1qgAPNaGpQlwSwpVnGkGjP2aiJMEkUdIV0yHLveFxu/KWUb8cmxsRYYZqwfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972638; c=relaxed/simple;
	bh=efnIpStd5jHGO1ve/52THf/x12gFpGmXfsj3McIpR+Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=sQaGB3PF+Rg/BMEFA7rdKPzERy+BzjvOEmBxQnL+D/62RRHQwUkY8xLgVLsNA9oz1+rdLrhO0Xa3c3mAeKKL80YRSVAxUogE1Kuj/E1E58nZKByfc81PdMKZt6ZYsCXrhuZ4vWHFW/WRKip9kVja8GyV7F1KaiF+xn4wj5oi0V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEv1sv0O; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEv1sv0O"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43635796b48so1489465e9.0
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 12:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736972635; x=1737577435; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VV3Tnhd4Lkpqe31w4AFtjUiY/lPcnfC0zvcd0UAd0u0=;
        b=eEv1sv0OxnIHHKhvWG5cZ6iQy2lQlOcjt3bBOSpOvFO+lCrxzdQLIltAA80u1sYs8Y
         F8FtV+tyaYIzO0C/ucVVyMsNwcNBLFt3248uMkJTNqDO3Goo2kFuhGAPb8BjWkFqtq8I
         99X10nGJggM4KWcTugYW221tnz9vRqBXr59/d59379fnv7WRjX6HoV7fi2CjdziZB1ob
         dM8bBFO+aPQIHEc+6ZZ6PVrDrpLL6v44eDB57rMJZNdMA2WRxRVjm+5uQFdmRQeARoh6
         X8xcANJvuRGS3m+MQkC5I9xpd8thBnAiLzp2osLIQUDM0AnqQPD9QNQcH9bspc+Khf+f
         gGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736972635; x=1737577435;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VV3Tnhd4Lkpqe31w4AFtjUiY/lPcnfC0zvcd0UAd0u0=;
        b=wVUTGVZvoq9uDaj2Ofdzg0vA+S5LKfIrH4XSDvaZFxNxe7lcZU//rG5vG4L4SHKWfp
         HhuTlL4fhFdcvhJ+uk35255qbPEmTUBrcq4kA/rlA1d6NSFCTWb+DkU2jANQbn8eRIjC
         i8zaMNo1VxlqBAjh3g3WMydsxVQQ9aE1qLRihPULavsoa8aWfcET9VOJRS/9ko0h7VGG
         0BMHeVnyJaI9/EjcrSLprtv7rSX0UUS9neYLwOLHDzQQ/XQQHsnMIWpORwIkK8KJjA1c
         mXjI4tf8Z9fJQHlub9nf1rB3jCw5Vlerfb+oybsjbqjdy6bsKrwllgC1lsF/p0pDI+Wt
         NfBA==
X-Gm-Message-State: AOJu0YxgnMlw4mo+wGtkwI5w5cQMuHwenIFoGZA4JAT+8J6iLFfHiVDD
	0rj6jQitob1J57D6ZroC0QtjeMXKrtYq+2KP7qauxTwqqVLJu0N7RCjQLg==
X-Gm-Gg: ASbGncsh0ptT5QqO1NjnZmoizqvqou3B3u9Pxm1dewHaCIm+87EFWcxRBqUbmKVJMQf
	3lM8HJ9zMNgz0iFZE7AuGh1c5WiBVVcilb2RsR1sShrGxNXldFFZdcBSTbv5kYX2r7x9Qg97vjj
	3/nXvUt5J6Dp20fyCN1L82hezH1vmNR7n38ai2LgLq6lTiMXwbtwvKDFyexu8KJl4W7jO0XgBaA
	B1hBNISvagYjdwoJ3TwFEwUhTRQr9JqXtLaKvyD+vLXx9IPqqoCw5osfA==
X-Google-Smtp-Source: AGHT+IG5IOT7FHQ/F0rymUmJUVHETU/cRUeGJ8FPpExW2fri3cJy6orxhgV7+Fhbx4RPIM3WNz3hcg==
X-Received: by 2002:a05:600c:218e:b0:434:e65e:457b with SMTP id 5b1f17b1804b1-437c6ae9bdcmr38623305e9.3.1736972634544;
        Wed, 15 Jan 2025 12:23:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c753cc1fsm35200615e9.39.2025.01.15.12.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 12:23:53 -0800 (PST)
Message-Id: <9216554bd7096f2543e987fc7fd20f5e64630187.1736972628.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1845.v2.git.1736972628.gitgitgadget@gmail.com>
References: <pull.1845.git.1735912046.gitgitgadget@gmail.com>
	<pull.1845.v2.git.1736972628.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jan 2025 20:23:47 +0000
Subject: [PATCH v2 4/5] doc: convert git commit config to new format
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
Cc: Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Also prevent git-commit manpage to refer to itself in the config
description by using a variable.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/commit.txt | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/commit.txt b/Documentation/config/commit.txt
index 62f0d92fda5..d3f4624fd27 100644
--- a/Documentation/config/commit.txt
+++ b/Documentation/config/commit.txt
@@ -1,29 +1,34 @@
-commit.cleanup::
+ifdef::git-commit[]
+:see-git-commit:
+endif::git-commit[]
+ifndef::git-commit[]
+:see-git-commit: See linkgit:git-commit[1] for details.
+endif::git-commit[]
+`commit.cleanup`::
 	This setting overrides the default of the `--cleanup` option in
-	`git commit`. See linkgit:git-commit[1] for details. Changing the
-	default can be useful when you always want to keep lines that begin
+	`git commit`. {see-git-commit} Changing the default can be useful
+	when you always want to keep lines that begin
 	with the comment character `#` in your log message, in which case you
 	would do `git config commit.cleanup whitespace` (note that you will
 	have to remove the help lines that begin with `#` in the commit log
 	template yourself, if you do this).
 
-commit.gpgSign::
-
+`commit.gpgSign`::
 	A boolean to specify whether all commits should be GPG signed.
 	Use of this option when doing operations such as rebase can
 	result in a large number of commits being signed. It may be
 	convenient to use an agent to avoid typing your GPG passphrase
 	several times.
 
-commit.status::
+`commit.status`::
 	A boolean to enable/disable inclusion of status information in the
 	commit message template when using an editor to prepare the commit
-	message.  Defaults to true.
+	message.  Defaults to `true`.
 
-commit.template::
+`commit.template`::
 	Specify the pathname of a file to use as the template for
 	new commit messages.
 
-commit.verbose::
+`commit.verbose`::
 	A boolean or int to specify the level of verbosity with `git commit`.
-	See linkgit:git-commit[1].
+	{see-git-commit}
-- 
gitgitgadget

