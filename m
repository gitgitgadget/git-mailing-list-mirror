Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67ED2EAD1C
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777484030; cv=none; b=SdG/kRkObPjsQc4IhOlKfhCRtH974ql8M7Re0ukFhoiv7LL3La/vxUb7RjsqAv6FTiJom2P3wXq0nmX1SqtUQJTfbW8Zjz0GZFvVXJMHkd1PjNIbJZgIi8O9IqwbeuMGKUfi7qLuek+hR712qkgbMcjL7Mv3YQusW8xqkQdu7sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777484030; c=relaxed/simple;
	bh=MzrmSk/U/gEWalxjLTkBuedzB8jvrLwHoFCnkp3UPdU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=E6jFyNP2LJPhqZXz0P178zL1cxOwZ1LOHSF6TI0E5E1oGnmzhHJwLqsZHnaQKo+KNX96/ALrkEO0CjLNZ2xCqgfoMAUPxqBGGlvDuxIwGtvE+i3ch1S64iU6X8bwr/FQeDfzzoblvXyVoV/NObQxja3di+QGEXpBlrYYjLEst74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=u8dpNc56; arc=none smtp.client-ip=43.163.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="u8dpNc56"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1777484024;
	bh=4IHkl1cKLOSEfYK6w3pqJf95dJdL3/Zs9dbRy0NCns4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=u8dpNc560sBxKeZSn/la8NTpGkNzYREigz6i6/Bvh/hOW3mdbbTgEiOAhFOpkjchA
	 OQglwQ8gKTP9XScfZmbsnIpHGrcM5rl+8xyQLzZOKTrVpu631OBx+fp1fyRu5YBY8R
	 mn7fK055Gf4jRP5eqU01dXBxCE0T7J/PkpzaJsCA=
Received: from DESKTOP-31CF0TC ([1.48.204.83])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 81BADA85; Thu, 30 Apr 2026 01:32:27 +0800
X-QQ-mid: xmsmtpt1777483947tz4n7xy1a
Message-ID: <tencent_AEE968E8E785907BA55A383977C8968ED406@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3Ju3d03P74Wq+SK3SL4OrGcgn2hTijXhpQozaJ75Q0wgVodcYOhXR
	 a2YkXiaMvlAOZzVSfEiEOLI8MAnwmNoFEknXHh08BgH1chyxps77x4c71neboBt/zKa5lco/kcpN
	 IQ4I273AOME3IuwvPo1VuIHouTYqd4KTs0lp8IEKWFMh5Cd/ePgBXE8HyiPZybSn9O4N3hq5jJ2Z
	 L6GdnlYe2Yjb1rkV/PgF0QcUyvFTDnsrpeOdssoX0l/MAiVlBzZSGDLdBC8wvf0eHc6h640kzMe6
	 jHXWXilLOgXm+f2PSbbDh8+LkVl08zvWxjXj6hGuwelhHBczMOoXgTm4p9r/TMBgul336Fj+TyE0
	 2mo/QHl+zugkHxqcro+hvBSfgOJe4uYdzFI1c2iqRRNjG1N2Z9t3hKz/Bw1OPmr+o6fE3eBQcbHw
	 wvjfDvodJ/kthlXdQgCGXTvpZCpskHykd3tXg97JSYLTOG4XkEr2iX4cNjJUVA7Rj4DUk6THOPIl
	 hkHmJGbcWx7YFXU5gAFpal6sQ28WMbXkbs48cyvclZ98VIsIOiPXoDDQ6gee9n2sjofaByD9s10s
	 ZiVv/BTy1YURe9XYxQXdvQTmusfGvo2sbqFr9zxqY/VOuWc09qUTU/YNGj4/LPXPNC7Z3pqnJMoT
	 K6HZHkqpA/sTlx9hY2deEnrxHAFUuTExfwrnZflz7xpo1yETqnBQToIPTtf5YWcT44857jaEgcBU
	 N3AzMzob/xRpZ2ialyFiDt63R3NTsg9arXQOUxLAoLUGFzjrjU6JtL1pqyrBl2qSH1TQ3zssu0Ll
	 tBUXADVjF7YsC9N0naZhvLbg/yDQRiWdQkbCCFGrN/lgykv8lG5+W5xSdX0MugYq3qOE0JUz5mLy
	 ssF/SvXBmV4VgUs1ydo4Js/ZSSEzJOOxdDUu7X6TDIcpk2H41QkwzmHLsLjLkmqY8zojpdtmLlbO
	 opZsNVy3fnK+6SmKZRePY7TbqrFUOUtSDI4+Xl8EVZal/ZDEq/W8s987KWcaoJVVqd5F7eWPtEY+
	 ZiZHzZbmK1az/VF7tWQxke+kZZq90=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	Shroom Moo <egg_mushroomcow@foxmail.com>
Subject: [PATCH v2 1/1] git-gui: protect rev-parse --show-toplevel call
Date: Thu, 30 Apr 2026 01:32:20 +0800
X-OQ-MSGID: <20260429173220.999-1-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <308229f2-0d20-4f3b-8e6a-c962bd9c3a6e@kdbg.org>
References: <308229f2-0d20-4f3b-8e6a-c962bd9c3a6e@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When starting git-gui from a directory that is a bare repository or
where the working tree is missing, git-gui previously executed
'rev-parse --show-toplevel' without error handling. This caused a
fatal Tcl error ("this operation must be run in a work tree").

Wrap the call in a catch to prevent the fatal error. The existing
error paths after this call already handle bare repos and missing
worktrees appropriately.

Signed-off-by: Shroom Moo <egg_mushroomcow@foxmail.com>
---
 git-gui/git-gui.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 23fe76e498..aee37685e1 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1169,7 +1169,9 @@ if {![file isdirectory $_gitdir]} {
 load_config 0
 apply_config
 
-set _gitworktree [git rev-parse --show-toplevel]
+if {[catch {set _gitworktree [git rev-parse --show-toplevel]}]} {
+    set _gitworktree {}
+}
 
 if {$_prefix ne {}} {
 	if {$_gitworktree eq {}} {
-- 
2.52.0.windows.1

