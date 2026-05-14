Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455340F8DD
	for <git@vger.kernel.org>; Thu, 14 May 2026 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769250; cv=none; b=g60Ypmr0VVeYfNWL+6tYai8/6dLpGjeAOuU6IEeAdgZcD42It1PtW94bFhxAiPmv697f0w0j0sDBH/idVr7/aY6dMeWn1QAVRtUJ7eY18fhYHfaYL49lEXExQnB12OwjPg7325oqt42Rov/eaknK9u42zkMJsWaMzJDAG8APFdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769250; c=relaxed/simple;
	bh=9oDAOyvjuENVsGCzt/sNGbedVKzsgUEsUaQZRRtt33g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4qaf9NruEFofhlY1D2C43v3Br9lRLh4y2BipF65IzofUfy5mv7ObYtob80J+JcpoQOLrKj+AXSUbFyoTsw5FrvSdkW63wJOXjrZVcpjM2s68jPg/uiH5ztDu1paNPQBf3P8YCR9jDCvLYNRAjysx8+iHR+Np5uCK0y/7YuU/Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpFONASk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpFONASk"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-911501a99feso49158085a.2
        for <git@vger.kernel.org>; Thu, 14 May 2026 07:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769248; x=1779374048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n92jilsIdTBTm1xiRWVJ+mHBPtHu0YM21fPETtQLHfQ=;
        b=KpFONASkVJwvYsvs1LQMJbSbuHu0kQY/7PbQe6IcV7dfl4/0SpASMa3Vy+qyvkcfLd
         qs9RS9+fmEwTJOUcRvjZJE2oMouIAPnEBHNFH8T016Tfzw4IdFPbKLmeyxvMEEczfyu5
         6qQv2GVdz1W+b7Pc8E7c1jsVnGUSIsLV+Kmdxpi33ETSTm7mZcx4pFE1ziFIdOZlZCU7
         pfvRFTRgg7C//6tO+XwQnk1MHP6ZSBISnH7jUSjuvPovN7ZTCaUpnc62E292dxVkhFZJ
         R/yq45yFsd2tBhvq/vikO6UU/LRh5YoxqzDRW3ou+QKBgNmVVCzVm3Tq36SlhnCi0qls
         9BwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769248; x=1779374048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n92jilsIdTBTm1xiRWVJ+mHBPtHu0YM21fPETtQLHfQ=;
        b=BfafqR3rOOvcPolFtMVxXnsLxe044acQeIODU0LEKVYP+dLNTvaPhFKjUl+iY5SmuQ
         4NdtHE3+Irc4wHuzw30uH9AVkT0YBYCiLZCznWJezQTDWCQ2UBjKRRR9NRuQ7Bd5+klw
         NciCxxkr6VWdEX1OymGziAD7X+v1fF96douI3IFsKflHnLyoPyzsHBAXGGsKFlxfilqI
         81WgjE6Hp7twHdCbkzabB0I+OytaZN9HC4XD2JzYJyJK6yr3Jq7TGz4tPPsio5pC9aL3
         S99vgg+FHJWgebv/UbbXpOjhEEp50TetW/X9Boy0772iUS4njWvVWS5PLeBbWngTbSWo
         2Nzg==
X-Gm-Message-State: AOJu0YzYNftooH42jO/Ghm0I0bcfIdObIkyfGbGzXcFUjNOOORbi2mu7
	VxE7jEWq3WP0paGECp4bHLfLUa4YjlfM/PdZQpKSZKTmdCnNdtJ7Z9ihzaZCD1id
X-Gm-Gg: Acq92OHHOaSDHSwJnYcdu3iD+bouAct2q++i1KdyPSzX25IGnB0XRNmadXRWC1UW50O
	CEoSjhDUyucK76MsT8L9o1pv30shn3MzRG9jGGZvEaKTAYNuyE/GAeUPIigRNq0O+BIgW3MtZXO
	IgLTx1fBgAsSlY8GLHWp5kLo8kaxaxw02hNiy7OXXmbtuKKyVhRfHoS1BQrTEefAyFjgYmekzMu
	7ey+kPFtAsJLD12s2iT1zl8DiHpZulnOlipiwS4l8fm/pukZ8fdAK5D1hma3lfqtbFnX3TwlO9W
	tgcDUVU+luzTyIv7N46hVgnC0ScQBSvA2sgYHkqjQ0vK4VySxhSH0cBkbF5HZsjEQeTKLn9jdoL
	OHPs3EOadO2RbW9yP2z7bgm8hlZwCYt3lTlRwwom4YjD1HVTDhozoamnEVLGgf4q4Cc3GVch21R
	jwqPCcBGg=
X-Received: by 2002:a05:620a:1a1a:b0:908:c3fe:8438 with SMTP id af79cd13be357-90fab81c0ecmr1144233385a.21.1778769246112;
        Thu, 14 May 2026 07:34:06 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100::59a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bad2dd8esm262768585a.19.2026.05.14.07.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:34:05 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: egg_mushroomcow@foxmail.com,
	j6t@kdbg.org,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v1 03/11] git-gui: guard set/unset of GIT_DIR and GIT_WORK_TREE
Date: Thu, 14 May 2026 10:33:14 -0400
Message-ID: <20260514143322.865587-4-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260514143322.865587-1-mlevedahl@gmail.com>
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui unconditionally exports GIT_DIR and GIT_WORK_TREE to the
environment, and furthmore unconditionally unsets these in many places.
But, GIT_WORK_TREE should be set only if it is not {} as the empty
value, really meaning no work-tree is found, causes git to throw fatal
errors (git-gui gets the error from branch --show-current).  Fixing this
is required to allow blame and browser to operate from a repository
without a worktree.

Establish a pair of functions to remove GIT_DIR and GIT_WORK_TREE from
the environment, avoiding any error if they do not exist. Also, add a
function to export these, but export GIT_WORK_TREE only if not empty.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index a951fcd..387cad6 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1122,6 +1122,22 @@ unset argv0dir
 ##
 ## repository setup
 
+proc set_gitdir_vars {} {
+	global _gitdir _gitworktree env
+	if {$_gitdir ne {}} {
+		set env(GIT_DIR) $_gitdir
+	}
+	if {$_gitworktree ne {}} {
+		set env(GIT_WORK_TREE) $_gitworktree
+	}
+}
+
+proc unset_gitdir_vars {} {
+	global env
+	catch {unset env(GIT_DIR)}
+	catch {unset env(GIT_WORK_TREE)}
+}
+
 set picked 0
 if {[catch {
 		set _gitdir $env(GIT_DIR)
@@ -1207,8 +1223,8 @@ if {[lindex $_reponame end] eq {.git}} {
 	set _reponame [lindex $_reponame end]
 }
 
-set env(GIT_DIR) $_gitdir
-set env(GIT_WORK_TREE) $_gitworktree
+# Export the final paths
+set_gitdir_vars
 
 ######################################################################
 ##
@@ -2050,13 +2066,11 @@ proc do_gitk {revs {is_submodule false}} {
 			# TODO we could make life easier (start up faster?) for gitk
 			# by setting these to the appropriate values to allow gitk
 			# to skip the heuristics to find their proper value
-			unset env(GIT_DIR)
-			unset env(GIT_WORK_TREE)
+			unset_gitdir_vars
 		}
 		safe_exec_bg [concat $cmd $revs "--" "--"]
 
-		set env(GIT_DIR) $_gitdir
-		set env(GIT_WORK_TREE) $_gitworktree
+		set_gitdir_vars
 		cd $pwd
 
 		if {[info exists main_status]} {
@@ -2084,16 +2098,14 @@ proc do_git_gui {} {
 
 		# see note in do_gitk about unsetting these vars when
 		# running tools in a submodule
-		unset env(GIT_DIR)
-		unset env(GIT_WORK_TREE)
+		unset_gitdir_vars
 
 		set pwd [pwd]
 		cd $current_diff_path
 
 		safe_exec_bg [concat $exe gui]
 
-		set env(GIT_DIR) $_gitdir
-		set env(GIT_WORK_TREE) $_gitworktree
+		set_gitdir_vars
 		cd $pwd
 
 		set status_operation [$::main_status \
-- 
2.54.0.99.14

