Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2EB37F72C
	for <git@vger.kernel.org>; Wed,  6 May 2026 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778099350; cv=none; b=ErH4miR3farKGz99EUhOgyeuA1X3lT1AaBuQXuH4GzlmJhINt6zyAWDhcnunKBDM7nFq2hV6tydVOIuYywDqAz1uLnG+AtlxgqdK1SA7BHHN/LUj1tu614iAh8RuN7IvFR6h+bzQ5B77jQca1oSO/jxp/xNuqA4gZ9HaHPBbCkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778099350; c=relaxed/simple;
	bh=HfQZc+qztTTfljHdafmCzBtgUr/OJM+o5Dqx3cpY5QA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=UTg86nPdeNzu+GeIQwcC66u7POPWKWSXumH3BBDyrox1MOlCdrBZF6Hukb/rxtT+75sYiWlt1DSsPsA671vRYn4f6NntiWo0kWVE5CgS3yDZuIs9fO0k0FGm+mrZwwR9ZpSmqf71b6+IBWFqFlxhl8oBXr1i19Zs+5idTmk60gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=r2eb29ep; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="r2eb29ep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1778099341;
	bh=E75gdJDUBwY1/gpq9yCclONUNL2tURgGZgBsmk082fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=r2eb29epJysDs6l49Jo3X7ihDqrtesLoEsR2nXyoqXRjXrX1A0AnDADZMapGFwUwQ
	 shTU1woVsS6Z6L00YyTpYsUMY5zvxdYj9Fe3Hdd3nKbMx7wLdiGrJHXOZUYNTGVYsf
	 BF5HQkU1+qveH3DI8dFwIfiqW+MWW4Tou0SfnDsw=
Received: from DESKTOP-31CF0TC ([58.209.116.75])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 72BB2671; Thu, 07 May 2026 04:28:43 +0800
X-QQ-mid: xmsmtpt1778099338t80o4vjrn
Message-ID: <tencent_02420881568A85BB718B6E7949E18FDE7D0A@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5FDQP1XxIWwlvwcg/GJVouWQvZX4cbpUpIa/fI4Jx5GZ5sCXCla
	 xLy/WXoBiRUJtzOvsgEK/8HZ5hjnhPteHeS8bhYDcl0HnVDph8D9FDtdrWwLMA9tvK7AW2obU92o
	 hx0iDdyTdXCV85AH7XznzZCadc7Y2MwNgxxfhxqfl9TUcBk8rWdYXyu+x0AkrVSGlbXM9N0qZ9qX
	 adKf8XrpiLvRnSaywjtPQpTuVDqrPGKl+UM3JUViIgDJJJYAzYO8yCoiufWSXNVuU+wLBR75v0VK
	 O+EP5bEWKfe2E8IS3s44f9OC/e/UoTfhUKdQJ9jwMvudnYbApXWayxYC+1XBOnEvAUK7DFJFeM24
	 1KExzUYHSl7AQ9GFI06saNz+OpD8sFvLwMB2bDgEnuyKBvmYw7yihIf1EQDnxmgiXspmHN3FIapm
	 MuwCJ0INTUUYFG78Rn6paiTKPnwdsCneKbl/OditxS0vF1hVdNUKh4Oq6daPFdYS88PyGHO/YNcl
	 9EZGnW5u4mZRBXi+iGyTxJUw6fPwjw0DkMuWK/gYtT99cKEPlR7tZbxuPC8DG1uoXcCIeZRI0pMt
	 +9OiUaO1bHfBwMA+IyZRWXxj5aJPy3lgNML0bnaE0r6Leokz83b2bEf2RunDidAuabhVBttjzSIJ
	 jkfzr7DZt+dTe32IG5uyFWTSQj343MX+adFcjfCLZi4IKQeITNuyGyPczNKk8owQvXwxdY6x989g
	 WE12Si5LKxlu9iQYsg7omRxFODfZSQu78MN6TOQO4JQsbHh0Bu6441TAvBm9Z9lUrXBOrWbOOYbm
	 0RWnZZFsAaAwv5QEJAeBw6pC0jNAl4tXiqGkVYNHJJEc+fUC0Avp6/LkVh0yJWG+IR0Acrt/nX/6
	 q6FCkD8rzre63QqHzGzuszK0wTppB+8cFYFsgyAZs52YrUoeUR5zOx3gLCEXjuudTI8jKCYxCXb/
	 FLWQnyUbpnTh8QizjO1B089pMuHIGI+Sds7t323YkHTmzRttGbu+ozVTNcxqQFXx9YGbv8pvgC4k
	 4uVLv+V98084KempGqhFd2U5ChQwH6ouamhAFNOn8fNptUOs7JuNvMRnqVX/s=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Shroom Moo <egg_mushroomcow@foxmail.com>
Subject: [PATCH v6 2/3] git-gui: disable gitk visualization when no worktree available
Date: Thu,  7 May 2026 04:27:50 +0800
X-OQ-MSGID: <20260506202751.3294-3-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260506202751.3294-1-egg_mushroomcow@foxmail.com>
References: <tencent_78B80FB7A0A42E464B3EF1841E2AF3C39509@qq.com>
 <20260506202751.3294-1-egg_mushroomcow@foxmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git-gui is started in a bare repository with the 'bare' option
enabled (e.g., for blame/browser), there is no working tree.  The
"Visualize Current Branch's History" and "Visualize All Branch
History" menu items remain enabled, but clicking them triggers a Tcl
error because do_gitk tries to change directory to an empty
_gitworktree.

Fix this by disabling the two visualization menu items when the
repository is bare and the 'bare' option is active.  Also update
current_branch_write to keep the state consistent when the branch
changes, and add a defensive check in do_gitk to avoid the error
should the menu state somehow become out of sync.

This complements the startup sequence improvements in the previous
commit, which already correctly identifies bare repositories and
leaves _gitworktree empty in such cases.

Helped-by: Mark Levedahl <mlevedahl@gmail.com>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Shroom Moo <egg_mushroomcow@foxmail.com>
---
 git-gui/git-gui.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index fbdc0b2a41..1191e6654c 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2034,6 +2034,10 @@ proc do_gitk {revs {is_submodule false}} {
 	#
 	set exe [_which gitk -script]
 	set cmd [list [info nameofexecutable] $exe]
+	if {$_gitworktree eq {}} {
+		error_popup [mc "Cannot visualize history: no working tree"]
+		return
+	}
 	if {$exe eq {}} {
 		error_popup [mc "Couldn't find gitk in PATH"]
 	} else {
@@ -2657,6 +2661,13 @@ set ui_visualize_current [.mbar.repository index last]
 .mbar.repository add command \
 	-label [mc "Visualize All Branch History"] \
 	-command {do_gitk --all}
+set ui_visualize_all [.mbar.repository index last]
+
+# Cannot work without a working tree
+if {[is_bare] && [is_enabled bare]} {
+	.mbar.repository entryconf $ui_visualize_current -state disabled
+	.mbar.repository entryconf $ui_visualize_all   -state disabled
+}
 .mbar.repository add separator
 
 proc current_branch_write {args} {
@@ -2665,6 +2676,13 @@ proc current_branch_write {args} {
 		-label [mc "Browse %s's Files" $current_branch]
 	.mbar.repository entryconf $::ui_visualize_current \
 		-label [mc "Visualize %s's History" $current_branch]
+	if {[is_bare] && [is_enabled bare]} {
+		.mbar.repository entryconf $::ui_visualize_current -state disabled
+		.mbar.repository entryconf $::ui_visualize_all   -state disabled
+	} else {
+		.mbar.repository entryconf $::ui_visualize_current -state normal
+		.mbar.repository entryconf $::ui_visualize_all   -state normal
+	}
 }
 trace add variable current_branch write current_branch_write
 
-- 
2.52.0.windows.1


