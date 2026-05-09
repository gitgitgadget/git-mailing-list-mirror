Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C0A223DFB
	for <git@vger.kernel.org>; Sat,  9 May 2026 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778334715; cv=none; b=ZyZwHSaUQ5LJEqV1VwKcr5Tc4GUk+92qliDFvRFAfTaM/1o0a8MWb9l9fPQuaBTz8uHVDKTS8gsipu5J/Ice7ficLzXwPUZJmyYTgDbRHY7x4W28CZHvWpRfKyx55+RdkvOpAYzo9GeYi+hU7c+GTuT89eIgs2ZyVMuonGQhVxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778334715; c=relaxed/simple;
	bh=oiLQTc1UVq38tpiVCRvH+EXzGNz8w0fUqevB578ayyI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=sQYumXc98fqrn9IKM2CCGkorEmWe61Ook7XxK8IrzYF0VxwdgG3LXwBakVznfBG4RsXnAj5E1ah6Dsz7aeZ122xY1Q19ToE1BvCc14pEgkDnixVv3QP4lq9K91a9Bdgm7sw30rWMUWo/i7q86h6HHlx56mRNyMidqYF29UvI97s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=VVBYtHkJ; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="VVBYtHkJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1778334703;
	bh=gsabsll5KMcILsUEYaSj+skBqcLWvoJ23AL4ml/2Vr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VVBYtHkJIqYC2YHA7xBVUAS+8OOSiFTpfEAW/9oa7Ez1/Q5t8laGI8vdltBD3sDfq
	 g5WWoaKGz8HQ3oZfwTNXgbgg3xv4qZyoXkitpaTj7RJ95Cirz6OT5kJaH77gPoRMj8
	 W/8FTEQTHjyUrkJ7U5N6JN7rG5ZjVHBR2EeJycGQ=
Received: from localhost.localdomain ([58.209.116.75])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id B052222E; Sat, 09 May 2026 21:44:05 +0800
X-QQ-mid: xmsmtpt1778334251t1dy8smgx
Message-ID: <tencent_A6BA86DF71476C6948398C167C0E0919550A@qq.com>
X-QQ-XMAILINFO: N4f2pSPHWwtb5Y01embLGjmRjqkATicYSLfVUvCtHhXqqT8b5kiwucVJA6MtlE
	 gUMXASZ9xDWdq9AkPlRhMWoLPMo1NPWrXFVJ9mwnyTe5Kgyksjvp7J+qKGUinvAphe11Vrb4HlJf
	 OOsVdtta4PqjZPB+c5ACY3FeM+k4p5LO6aPI6um4NqPp/JTDmKeyCylFZfp7OYmwHPUYV5bLZFpg
	 To/au18JuMz34Brp9voAltu4/ktkXqzx06daK5XzDOycCEoGURny2hHp/5oXItT9pJLajnME7WF9
	 RMzvh+otbTw1ivZyBDX3VybJQy28I9NghfhJqGyrkCnEemd3b0y3I10nIiIOnYkyJ3m8Jkw9y9Qs
	 NpgOcrU68qG33b561fYIWG8x6eZdnFMZHOJEHdQ7zlsmM7uPhkfxZpdOrwuMFnecXCFeiXnb3fZh
	 OoXngEuzcYXaPwB6SJXkXEf6JRfSaRaPO25wM671cCMKCrh4GTFSI4w78w8FkoneuDgbKWXuvsOn
	 ZjWT7URwlnCCvc54lCHYsH9obX5fb47/OrZ5DSokpgk1C+7VSqfoKuDqL4HBRqvLIw+F2tiUHkLR
	 FNHvBulJNya6MiP7Zh0EVqz5wXo+hn9IjLjrkZCN1KMb42XbSlTpCn5aecHHmFYIXDuXtNxA0luI
	 qUjOhBNoqSErtUCTiDXFkz9ImTu8ZDbLDJr0ScLcAocHnWQ2Ot2SY6XAgNq/FJ/G+egF77FFoBwT
	 vTMg+U7+Pu1ab71b/GUS1PFYbeALR/b6u/7UgjKavP7Lt5rSeMTmijFDJj4EXkxqql8uR7cH+UGJ
	 WRvzbX0p1SL1OLJEb5ADPfEp049FtuY9FwC8lTZTSu7wkuTdn7WuZUfmuvNgaXYwvmI5LvgHkUw3
	 WaD696ntKg26Eie+ET2YrPlDyrtBUAeSwr7m1lSoW/avMcZzbZmE4hkGe8J12vW/8Pxuil7RjiN7
	 U2oGtGaIDgKume6GiMzyQd3Cgq6WoQpUmmdBkU1j+8xq+EauPNuYdC+1hBxxVA1sb/4b06onZiE0
	 h1NcZ1YUNSAOLnqjLy6kgXsgR8QY7Q+IbHRqwkUFitKODtfTlt
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Aina Boot <bootaina702@gmail.com>,
	Shroom Moo <egg_mushroomcow@foxmail.com>
Subject: [PATCH v7 2/3] git-gui: disable gitk visualization when no worktree available
Date: Sat,  9 May 2026 21:37:54 +0800
X-OQ-MSGID: <20260509133756.1367-3-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20260509133756.1367-1-egg_mushroomcow@foxmail.com>
References: <tencent_DDD6467B3F6184562B51C23BB9DBB79EA409@qq.com>
 <20260509133756.1367-1-egg_mushroomcow@foxmail.com>
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
index 9eb93a76b5..ff022c5bbb 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2036,6 +2036,10 @@ proc do_gitk {revs {is_submodule false}} {
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
@@ -2659,6 +2663,13 @@ set ui_visualize_current [.mbar.repository index last]
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
@@ -2667,6 +2678,13 @@ proc current_branch_write {args} {
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


