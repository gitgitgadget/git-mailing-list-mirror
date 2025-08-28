Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5692EA163
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756371537; cv=none; b=XEc+LkLiELxtuCRpZijD29EuVRYubP2a6Rm1HLnD6wGhh1LDlRB5yyqELq22KuiFp8R2hpzou87BV6Yh2SQhn0SG8yrCkYTOCw/93CCRC1zgOfHKfxJU2EutvQpVsGVjaoYNo/24eJX3qDeJae8Qb3pNqXOwl7KckS3Ua9M/5d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756371537; c=relaxed/simple;
	bh=nXN7tK8TMyp+oN18jii/eX3L6R1L4DIIpd0UxcMZBuM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cQGyo5F9ACiYJKwuIn2PXDdNrCR2N9og3kUqdchS30V1C5oSKYLdxpd0k8QVM/HeHJaH5brrnvpN0QWH/FdAkLULj6JGF8xeGCHEOxZ2EKjbSs44Vtxr2y44dbUJqRMiLjtAE92NiPpx2ypbe4KDKIkegzyf4Jm8ojo0Qh4CRd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CY1DNVYS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY1DNVYS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so4240445e9.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 01:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756371534; x=1756976334; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbDB6kn4SYHkxIUwm+VqpupXI2g7ZelSD8/vSRQRB2w=;
        b=CY1DNVYSQeSrfUjSxQJw7/p487wNStyFhMHj4rT2k7Rnl4y59p4SJo+lrAXPbEIWgm
         Vbh7bqS2oDnlZBNQ3n7GbxzNElr2IqLyehZS9ogRVZSk1jcHD6MTm/n7lcsZoHK9EwtY
         CJLAo+JbofFZRlbFmf46rF7inGCxZcC7gCAyFry5luMzlx/ZmRkrp8Utm7MABAQZAkur
         jMyQM/ubAXUSfmgmz60Aes289r/awk5Y31H7HIjcUtwI0xQ5/f5TnMLI8uesFQNBix7K
         r/e8aAwFp+hwb0mLoqxz/AI2K7Q5zyKKsYP4zr8bThDX+GeiwTSoRdaxG6lHaNwC4Er4
         PTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756371534; x=1756976334;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbDB6kn4SYHkxIUwm+VqpupXI2g7ZelSD8/vSRQRB2w=;
        b=e/qFYbNb89GfZY0ui2cSBSYZkvWDDWIoiFdk0E2QDkgciJUetKezi+YGbRCN/464z2
         yoCIASnn/a8JZrt8KCJCTlcQJ6NVaFhPuBWx5LYdlOCbhIC2pbuE9BkQ7u/4NucrbPKc
         W5ZMHMlMIFQ9my0zgVnvh5W/UiKJ6CQV7WgKszgrzFMSDyL1EJooqWM+9BGFdkSlTS8k
         uMbMVlWq0wd+YVY3tiKz3xKwhAaPzKlgCPUErlJ1dMm05Cl7vspyp4cRki0/ZmS7I5lZ
         z9Hm71LTlrMjekw1G5gggW6qDsk3D3dPKHy0G+6l+4Cdd1qXR5XCn0oALFpf/GoNsKqn
         V3+A==
X-Gm-Message-State: AOJu0YyZaMjuwsLom8cWsEHQTRxrnn6KJjF1cKc/VB1pcRbsLDds7iyg
	3Pszgk5MvO6iGC/REpu0/hrzrPy8+m+fUDC+wZLiUNv3dVwMgE+pUPWTKskAdA==
X-Gm-Gg: ASbGncs7HdhlvKzTWrqnflfJjAKw5k+xAVmXBbiqUgRaD5JQ0fgAMaK8GbhvBgEeA9M
	DMlCgKve4WkCsvgbpDQ9Bj6KzkFibJij52wOf5Ve6lFMCeJ5FbpIw3HHtAst4Fq65EyRd5SN6nr
	fCUlI/2C6UVBR8dImiP2WLnB4JlMp4pq7o5MYIKHlGk2GMNN5ehhe4tzm7g7qgZOFOfADwhTUXi
	jv4JhhovhfE8AvD5NOdvzMXW05mqb1p6mbmWsGF6sk285pYfW8BSYbproCZR1NmmN7PaH8/pZdh
	5iqmTnIVPcfC2dQN3sQDiLP0fC4lVj37n8tY/JhACaCWdHiEqmNQZ5mv4i5Y1aFhSx+JOtDngiw
	S1y9Wa429+lWdrZurn0xZf9+MvKU=
X-Google-Smtp-Source: AGHT+IFyGHrxUQu7Yx4gKvT+TR65Ct0udCa2ZKjFwKI2VYBIU4I6cCJezhVapBmBjq8sFq55zqPsZw==
X-Received: by 2002:a05:600c:1caa:b0:458:bbed:a806 with SMTP id 5b1f17b1804b1-45b6503919emr76640345e9.22.1756371534012;
        Thu, 28 Aug 2025 01:58:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66c383b1sm53095255e9.3.2025.08.28.01.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:58:53 -0700 (PDT)
Message-Id: <e1aef533bfe89bfb87b1a83bf7c7375e6238b06f.1756371530.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.358.v2.git.1756371530.gitgitgadget@gmail.com>
References: <pull.358.git.gitgitgadget@gmail.com>
	<pull.358.v2.git.1756371530.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 08:58:48 +0000
Subject: [PATCH v2 2/4] git gui: set GIT_ASKPASS=git-gui--askpass if not set
 yet
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Pratyush Yadav <me@yadavpratyush.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index 1a4b73a3373a..63a6b7408639 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1130,6 +1130,9 @@ set argv0dir [file dirname [file normalize $::argv0]]
 if {![info exists env(SSH_ASKPASS)]} {
 	set env(SSH_ASKPASS) [file join $argv0dir git-gui--askpass]
 }
+if {![info exists env(GIT_ASKPASS)]} {
+	set env(GIT_ASKPASS) [gitexec git-gui--askpass]
+}
 if {![info exists env(GIT_ASK_YESNO)]} {
 	set env(GIT_ASK_YESNO) [file join $argv0dir git-gui--askyesno]
 }
-- 
gitgitgadget

