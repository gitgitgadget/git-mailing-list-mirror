Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD092C21C3
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703515; cv=none; b=u00o4cE/FKTVo+nA6VQZqkoqH9QV3bzkMrZKuc1DGypy3KDWMRCPjq/5VEoRted5yi8DoU/0erc+M4ZtJBE/wyYgwREbRLL3Hpa5J9jwWd97o5AjtrC3qpQMHDgoy1rGP/17jm5fpH1m6AIPD1IYyhXFkBYd/FS8XPY9pBbhdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703515; c=relaxed/simple;
	bh=KHbD69Wmnb5FbCUiepbUVB4gpkV2/gqmmAPo+lkiq8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pl05QVzihX7gZUnVeEs84fQFH0tX7iVTsMxhK7hDOBvcTG4Ds4qD1wSNr5T7N7xIt4Pzs+MvuMTsJp+UsAUC6HSkF6KvCOmGLGNsNM6wAfAJu6EzqWuZL0ExD7GsgGRADEbs+bFXwXaRcqNshnxiOjqEa3/Ptt6FTJ9JprgidXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J37elK34; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J37elK34"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e87031f560so920385085a.0
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 08:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755703512; x=1756308312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PrSI+whi/taJoVw9hlFdDg0QVWshFM5XMPW/nyoHIGs=;
        b=J37elK34Yjuz5EtV4Y/uh9oPuat/mfVzGVjcX4iLDuLbjR5IlBxr5N36XalvQW+Ybh
         YrpZ8LBjhcPw1PePtUpGtKRJW7KAJHTuoUQr+MUKwh7GkfWXgnvTGTOtd4qQx7U0e9m0
         gajWCf5yOgvElCS5ICzuTIXTZCZEzf5qrgDbIzwlAr+KVEqvvIKT+808sS++lDpod6A3
         8IBi2m6s1LT+ThnBREjWNPB01LrX7N1tQGHn+k6tMg5HvZkmfKv2bC3IyHCSjN0iJILN
         jsAIjSfu0oTupEJ0rArx1zpvmqH/+priEJxj9ROqTctGSjVUkQvlThqSnQlLyPDhC5qk
         HT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755703512; x=1756308312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PrSI+whi/taJoVw9hlFdDg0QVWshFM5XMPW/nyoHIGs=;
        b=I547NFbWjHoUvTHUlb9vbOx3kgSGczMVGxW221O1j3TI6YtWAVcMGxdrSh+R0uMRPs
         rAtIdDBJHywHoppuCgO6K9ZtVgMvAWTRKqOve1kHD36xo26W6XzLOgHOmoQ3A1MswWN2
         XdQEDB6mCEUzuk0XNgwWt5RhhcrKLGTosUfipDxtKHsLTt4UrufMss8Kh5v29+0eOn21
         0GJtdiuf1cKo9vj6XGmbwtXd7Sc6SOpI9hPm1/CXNv0OPQ9U5aivaBIM1tRx1n7/xxkQ
         PMhRsTAp8TcBu7HTsO8le46WSXnmVT7XBcy24CHZB76MI9v/Sk/EmP2yXjd5YDOQQq5c
         OvkA==
X-Gm-Message-State: AOJu0YwLBCAlgQuSDipojbSnzAyvYAFfXdDYmdixUgF8H8izkeR3sFk3
	iJ+7cuW1IuZaQU7+O/Y5dvT3GcEZNbC8yMyhRsFFVZH0EXCjPaW2f19+jxSkKN0vjt4=
X-Gm-Gg: ASbGncsTBfCin+AMHRBOG8HtcS6/WKzDkdt2HVJcR5bfwloQanEYmWRhaviPwMavkPg
	BvSgAY6QnxhPhYE2xXolZSJKLen2PSpVANexbB0iXDRPaoYvV+gKkdiK7k6dJZbh1C0JEK+uU8a
	zTMdrh3ZilV1MrUTLqWPAh8EFTI3rffnSLxZmAIi4nu7GKInQ15vJNBkA7d/3ROPTuEh9eeTGMG
	fw/ErmZxxe0VFae/Ga8xIF4B27KvXwuaA3i5BScyAw77Otwn57iAZNNrbT4VXsdiu+rZ10MEyvE
	hZ3pabtqk+qnj/SftlDxmEvXWbA9xsFeXDdNxuhSLfoLaSt0KFT3JcH0V09GyMO2poTAuL51DPZ
	4sMZArtW8XwX9K6oxhHyMFZ6rk7I8d5dBKmfp0kr20bSm/BsKEXwUzzYbuI53Ox7Yj3qyhIk81j
	AfdSQ=
X-Google-Smtp-Source: AGHT+IH3iDjcJsK9u/r226K9il5P6sAghHENZsSs0Bpr+cawe9Q/z0SlYU2g/beGxQ6KcHPXj15TWw==
X-Received: by 2002:a05:620a:7084:b0:7e2:9c28:c308 with SMTP id af79cd13be357-7e9fcadbf8emr405384585a.18.1755703512062;
        Wed, 20 Aug 2025 08:25:12 -0700 (PDT)
Received: from markl5i.lan (pool-173-73-185-17.washdc.fios.verizon.net. [173.73.185.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e0757c7sm948732385a.32.2025.08.20.08.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:25:11 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-gui: simplify using nice
Date: Wed, 20 Aug 2025 11:24:51 -0400
Message-ID: <20250820152451.20872-1-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.51.0.99.15
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui invokes some long running commands using "nice git $cmd" if nice
is found and works, otherwise just "git $cmd".  The current code is more
complex than needed, lets simplify it.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 4528b22..5ee08d5 100755
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
+set _nice [_which nice]
+if {[catch {safe_exec [list $_nice git version]}]} {
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

