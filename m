Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296583277A7
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755708641; cv=none; b=hxKXxK9PpDeAcjVwVrQKlXpAyLHf63mVYIEQBIIPk3LKLIQDwRPN+wCuHdSOoENsP0PBtBhzDwZ6jCx16OVltJntZTNOLoC6b4HLfCAjWtYeeXAzzgssZIE6DF/bsCPshAVn86rEYmvs+O596VkRU0x9uh8vaoNPdxdMpxU5wrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755708641; c=relaxed/simple;
	bh=MYhWxmE6kAtjzNAoj1xGmxgOZUSCKxa+sse0DEWAbEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0LTMLmVnoffXmsrvGDxBzdCgVW8EbwFOUJgfXsrs2K5hnjOJOZoePJ14U3ZLUPpdqV/BX0CoCo5TMWJTE8QdRpI0TXxqLZREG7sT/UyIPH7YXhLwProgfEfHlkqXHnL9LJ99BkoPc+/Mc4Td5CcIDZCLB1rGZKXmencRHhEHRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aP0wBfnV; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aP0wBfnV"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70a88ddb1a2so1252476d6.0
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 09:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755708638; x=1756313438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9/DPypxONK/Xvr47qBYqaWfAzp4he5hUvAYsfLmAvc=;
        b=aP0wBfnVKjNVy7sUj83YbMS/dPBPPkJOz3aH0dsu9Ye0gsuAj4ZJB5a1liRRm5WYXV
         w4kV5rnSbIpiRBaykInibgmm8Bpn6aJOr0c3SuNUEclHCzv+FhLwezZZB6AC6BWZDj7D
         aWJZ+Rpeo71/paQfzjPL0F9/59oVU/MLKCyZUcCq4EjA3fv+l9n0RM1OPyjwym9H/a4q
         4DFkLIp53EfCLrbYXFVYmSlLPv8FY+OUTBAxMCAtbIZe5Py1JUNNzL8Bkrf36Ps2wn6K
         AcW5qAvNfOd5s7X/E8GFxSAAa7IDa18CZaMSeWmK+C3xPFHLYOQkAvPLPQSZDc75R04x
         5A+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755708638; x=1756313438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9/DPypxONK/Xvr47qBYqaWfAzp4he5hUvAYsfLmAvc=;
        b=EZReJgDS/109zCSP3tyc/Aaiq6hUNLbrcDf8givA4xO4hSNeOR4QjLgJTXC4qexj3/
         hZJjvpXq9Suf7sKcsKbCOATO6Jg3t1WKZvHJ8sk42PAnvEUVx5fsz4/2wXZrUDfRA0ks
         eFvovzjPfXhE6EjUaIjQia+PaaLz68u6pP59gVrR5NaVc5RMc04pqBlx406H894t/sJb
         x+dinUFhthSrc412bhRPHWzyiFHTbkqnqu8wW2LouB60rl2fD5SJ5zXbWj27AgaJoI7q
         rm5rSWFCjXUMWwp9hI/TBp6WgoSzyUXq1zoGiskDxMWIY0h/D/ECIwsxRpLJKaNxOq7m
         oM5g==
X-Gm-Message-State: AOJu0YzL4VbiDvGIEqezsHmew6SwrgdrbNgWvIPBysVXxpQTQ2TRhCxs
	Xkw3Ik+mT3K7HYNzXRMLTZmb/jaet1TjNmpabfpy5hrxucWgQBGAkwgTIU1Zrp68cnc8KQ==
X-Gm-Gg: ASbGncupu1nBCChulBb8b4iIvoa3VdnORBxyhGgNozDpseKOKmL4s6gbloflVzSUonP
	tjMHbi/CvwbMRTI1j6pEfJcFB/U3+hcnzSDetKoIfEYWKN/HksPxKRJu9SWUWmECWbANSF4HORV
	FbhVH4KyB4SyZdIaUU/TuOWaIp1+Qd3mxuPxB/XPll6c9xXL30VqOqGBMWcdrRfa96OH1jojX9c
	ChN5J0Vf5srnEIMPvbyVmKVCK7eXbJ+7F+pWDAnkL7ncRRghsWX1BQotHA6/lLKS3MT28tqxDTj
	FU2JnLyAewBvs0xluK+bsVgWSLApQoSbFsIs80q64tbTSR952/lZ2WVFAYimhrt1wN65jmlAbuw
	FEw6zeItDzYAM3XM4c2GNLxj3s1CEBP1J2h9vqmjDK3V0ANge7iQH5hkVaajp4UPUsq+v2ZxKgr
	owuTA=
X-Google-Smtp-Source: AGHT+IGoVJbv+hlsXQzvkjQakx5koDrpbDVgIptQTrjUVKP5j2OApFMaPkhskiNVLNiOMTDvB8LotA==
X-Received: by 2002:a05:6214:194b:b0:709:e097:2531 with SMTP id 6a1803df08f44-70d85f40305mr3287846d6.23.1755708637614;
        Wed, 20 Aug 2025 09:50:37 -0700 (PDT)
Received: from markl5i.lan (pool-173-73-185-17.washdc.fios.verizon.net. [173.73.185.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70bab835736sm88252046d6.1.2025.08.20.09.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 09:50:37 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	kristofferhaugsbakk@fastmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v2] git-gui: simplify using nice(1)
Date: Wed, 20 Aug 2025 12:50:21 -0400
Message-ID: <20250820165021.24604-1-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.51.0.99.15
In-Reply-To: <20250820152451.20872-1-mlevedahl@gmail.com>
References: <20250820152451.20872-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui invokes some long running commands using "nice git $cmd" if nice
is found and works, otherwise just "git $cmd".  The current code is more
complex than needed; lets simplify it.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
updates from v1:
- _which does not return a list, _nice must be a list to handle path
  with spaces  (should have been in v1, was in another patch - oops)
- Address Kristoffer Haugsbakk's comments

 git-gui.sh | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 4528b22..be0b8d9 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -578,21 +578,6 @@ proc open_cmd_pipe {cmd path} {
 	return [open |$run r]
 }
 
-proc _lappend_nice {cmd_var} {
-	global _nice
-	upvar $cmd_var cmd
-
-	if {![info exists _nice]} {
-		set _nice [_which nice]
-		if {[catch {safe_exec [list $_nice git version]}]} {
-			set _nice {}
-		}
-	}
-	if {$_nice ne {}} {
-		lappend cmd $_nice
-	}
-}
-
 proc git {args} {
 	git_redir $args {}
 }
@@ -626,15 +611,14 @@ proc git_read {cmd {redir {}}} {
 	return [safe_open_command $cmdp $redir]
 }
 
-proc git_read_nice {cmd} {
-	global _git
-	set opt [list]
-
-	_lappend_nice opt
-
-	set cmdp [concat [list $_git] $cmd]
+set _nice [list [_which nice]]
+if {[catch {safe_exec [list {*}$_nice git version]}]} {
+	set _nice {}
+}
 
-	return [safe_open_command [concat $opt $cmdp]]
+proc git_read_nice {cmd} {
+	set cmdp [list {*}$::_nice $::_git {*}$cmd]
+	return [safe_open_command $cmdp]
 }
 
 proc git_write {cmd} {
-- 
2.51.0.99.15

