Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD64F1CA9C
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459138; cv=none; b=f9cDwJ1j7g8D01Ti1JYt2zemN1mOzAgLZQw3OfPSg1pf9hki6T2ituD0rp/EjMbQ9Ize5R875whfkYeRaTbj66dvJvrZ1My/YznHlCa0xnA+Lznk0PIMrvAbI6Z+ulPLLbMQKTZzGDZDmiID+zBj+pnupiw54mC6Wgf3BIW7Awo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459138; c=relaxed/simple;
	bh=cjrNcDybg+eotxIuIDwjKtIzIcasPSG0L/pSBxlJA9U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mSjBXonHjJVKiIsK8ac9Ob57mlWHcM1vviaicvDi/JIr2qcs4py9T8MRAXt3jAkiYyJguIfxlcGON0j1406P9ms/mpLJIVQ/oZ42MiLkAuDjtWv07A1NP2pwrVMS0zgYnqFcTbZ3PNbIFohNcQTbmgOSqHNmH2sFlgfQuztadq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqvDeu9z; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqvDeu9z"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so55716875e9.0
        for <git@vger.kernel.org>; Tue, 12 Nov 2024 16:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731459135; x=1732063935; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFDhg1t7IvcLQqH4U2PxGRD4pEqla4b+K0WdwT4ZPyU=;
        b=SqvDeu9zOjYbGDfd/mr8sHf50Hs7XYb1L0LMOGYKUx5LAQ8Hm5Q+0aGP2Hmx0v47kJ
         huRkgn5M0Lo1LJDyEZ5baV015ZEFa62oFBqsaeKgNp5ZwV7Pdk9YmakEngJI08Uy6lum
         Olen9rMdrZjcDe4yWia0XmxG8h5l66Ip3kDEKHlraWhEWG8g/qrVX6HRcih+AUFshj6B
         XvK8tHRobjAuJATousMbJU38+FRriyUvO9S76K1vSnJt2B9eizKZA/G4GTxjlkoT8YMB
         m06CnhBUoQsI5sxffQspMJXAND6XAGNlHYp7WhWr5ZY+0+DRddFCCq34YqUYQmBynMyR
         RcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731459135; x=1732063935;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFDhg1t7IvcLQqH4U2PxGRD4pEqla4b+K0WdwT4ZPyU=;
        b=HdGjk/BtNII1oVhQHJztt5TnnrDCh/MvZCsaj2HFrcggHZV5TZnQFic0MQCpIKxi5d
         b8Vyq2djzsCr4k4XnWOh/IHLY7wZ//wQ3t+VbpILUVCskUUyr0Z0GjNZCVP1m/m9QGTK
         Z/c5XMjI6Xqa3Fcy8yd2NhBk4dqtVPlJciiPuwfVr5pa+aXW9ilqTpV1NN55cSDNY2MU
         vZAnwRbHEGwqF0wlx5VsXNd44T0rGqlEUnOsArWjfVpvCfCKejTk/QfI7n9d68ECZB74
         2oSfFghV1G0FEu8uNLZDiUY6k9NU/6TDHu/WI3zOtXJKkoU7oq9TA+iOLQxffDO/56KF
         osJg==
X-Gm-Message-State: AOJu0Yyenh+3x6hbLOPWVQcPnkpx16C/HBaYTtwCTxTPBqnY7KoXcHh1
	/JYsyed93s9aQ2BrdPblkGNCc+K0sWVobv7F1aQFaC81yExTexyrKdfk7w==
X-Google-Smtp-Source: AGHT+IEmu22dxwbmo0JbWHJf7kfYwjE3eakiTSplU1aE6BNWxDp2uunVJ41dQIfDS9FnqX/lT9lYzw==
X-Received: by 2002:a05:600c:1da7:b0:42c:a574:6360 with SMTP id 5b1f17b1804b1-432d4ad6625mr8498575e9.29.1731459134455;
        Tue, 12 Nov 2024 16:52:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d554183dsm4639935e9.29.2024.11.12.16.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 16:52:14 -0800 (PST)
Message-Id: <be0b86f08901046878f1b1406f811166d56c7c6d.1731459128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 Nov 2024 00:52:08 +0000
Subject: [PATCH 5/5] git-difftool--helper.sh: exit upon initialize_merge_tool
 errors
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
Cc: Seth House <seth@eseth.com>,
    David Aguilar <davvid@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Since the introduction of 'initialize_merge_tool' in de8dafbada
(mergetool: break setup_tool out into separate initialization function,
2021-02-09), any errors from this function are ignored in
git-difftool--helper.sh::launch_merge_tool, which is not the case for
its call in git-mergetool.sh::merge_file.

Despite the in-code comment, initialize_merge_tool (via its call to
setup_tool) does different checks than run_merge_tool, so it makes sense
to abort early if it encounters errors. Add exit calls if
initialize_merge_tool fails.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 git-difftool--helper.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index dd0c9a5b7f2..d32e47cc09e 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -61,9 +61,7 @@ launch_merge_tool () {
 		export BASE
 		eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
 	else
-		initialize_merge_tool "$merge_tool"
-		# ignore the error from the above --- run_merge_tool
-		# will diagnose unusable tool by itself
+		initialize_merge_tool "$merge_tool" || exit 1
 		run_merge_tool "$merge_tool"
 	fi
 }
@@ -87,9 +85,7 @@ if test -n "$GIT_DIFFTOOL_DIRDIFF"
 then
 	LOCAL="$1"
 	REMOTE="$2"
-	initialize_merge_tool "$merge_tool"
-	# ignore the error from the above --- run_merge_tool
-	# will diagnose unusable tool by itself
+	initialize_merge_tool "$merge_tool" || exit 1
 	run_merge_tool "$merge_tool" false
 
 	status=$?
-- 
gitgitgadget
