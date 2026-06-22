Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BA136729D
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113398; cv=none; b=KM+AOEa2BAHXnwoUajf9D1r4ZByt4iuSdYhByL2XI3Pb/8Iyd631kmBanUNYHifZbA3Po+NLBDGDQpDEkTPfZivr/zQ2XpzAJpFeABEzagp/1qnGMYwnpsnTrUwCvTxj5wCu4MpantG9gFJPfffFYE4jqaNXOuQ51PMNbxUgRgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113398; c=relaxed/simple;
	bh=NutoYXBg1C7XgbflVuG0jW+euBPKTNQMr3lJ1a/7C7Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ghJrQYO0vpLAgIhWygl9b4lcjo5FYZTdWAIfIaVgOUGjGqOPjUMh76SqwBl3fzARFCYjIKfWfepKbCj7nUc0ubTdgYfSSo89BYc79VGRiNo3NNtMYL6XFONV4SNs6q0IXwS5ALyCZtV/VK02Pnrurh9ZJFTajB8cp2jcK/YlltI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRlQKctb; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRlQKctb"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30bd47b9f0fso4252462eec.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 00:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782113395; x=1782718195; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPdWLSYQGc4P/AtgxUlWCtkQOHlQaMHX/ERzqQFwwoM=;
        b=NRlQKctbCbUYTMs8s9kYokcmxaYXsVfRscSH+NABccUOo2sYya8dtIhsuX65gkWvNP
         FY4s1r25KrJcm7wDDFX86zgWnUxHjwYlCOi7d34XtluVaWsoNR7r6GeGO1bWIo+thyTd
         2FwsgULFv48ZEs8ext4I11S3YSlLWtybbx7M8EZZcS4WyEQlVSkDBAMUeX1MbXrdLwdz
         bxAzrYMn8DxHwfZ0ix5wMWVgS4MQWKJ9nOnyBA584QkjSZFWwTDrQW6Z3Zm3aeQh8Sb1
         ilfdXUVPZr7UiYURbKIG+u8lkizuGhnUR0S+1eeGvvH2i0AnZyh6NAiM2LBWMqCY13WI
         t0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782113395; x=1782718195;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JPdWLSYQGc4P/AtgxUlWCtkQOHlQaMHX/ERzqQFwwoM=;
        b=Bi4AWjlqLIlf+w/Dnvq5LUwxh3M8QEYP/3pWgO+gX8bTPvP/n+U3u5hQLwEVvsQLED
         Foa0o2smYzIy25OiuwK0Maq9Xn0QkXN2aTpJxUU8ITLF3/XxBsDunPOHvPVqs9/AJA9D
         uIpZ4/MpTUTPrub8nVOryopds8ATJ9262MLvlI7Ms3YyX6IQ+k07lT7sOS1wZh7t+fnK
         6JJPWdLtma22En7IyztcMT/b9pgjPAhiGNoFCeeF694Av4X1LQdPJdoodZ1Vv/wXwMFy
         yf6i0Z+JGp6X18i28q+jdeWcH+zROBEOZTvLBTZ+15gFP08AtV1wAB/9jDWLaEL/v3Fj
         mZbw==
X-Gm-Message-State: AOJu0YyREuQYFK2poRcH1yA8Qhe+sVC7rvH/qr6a4N9hpYj7gxUoQuYt
	9yeu30RN+FiAsi73Y78CiLBG2w9YG+LQ6gr+Y7Ox5uVFhxCICvXIwfvaCGWCng==
X-Gm-Gg: AfdE7cnJxIQUisbqvPQOqBd4rXHM03hyfHn+L54WQVdf7FPqBv0Ohlk9Jq8jaWLsq4f
	ymXAuIZPWCZlyeX3XbdUYIChP2NOqRq87X7YrDog/2RnBYc9QzA3E9VzOI8fMFdeJuMOIRwsH1Z
	VZR0moai87lDDWM9x2RB35A3oIyRtf8P/URbSlnwQDwk9tpbV7cVYf+qN4IVVWaj0HdUIRLAfpc
	9OnmUfzBD4KH1uhTFOT/JY0JI7bc60zp1DGN56YtK3XRVbTxiq2i1C6FG50Nm50RpnEA25HTQk2
	h8u9wKi2Jzrg810KE7AoXGP+ukfSyzSvmEJexhnlCP3PFHA2zNH9FhAL8dZ3wDLyON7ijJ8HnUa
	49+pCuTzFAmOW54o4DQjUtJTU4LETus4qt+5v0IUAIqO0d6MdYeoB/T2Ex3uKocna+nSTV0KshH
	CSOFw0e8ST+BUdifO/2Q==
X-Received: by 2002:a05:7300:3c15:b0:304:ccdd:594a with SMTP id 5a478bee46e88-30c06d4bd52mr11354750eec.5.1782113394579;
        Mon, 22 Jun 2026 00:29:54 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1c376sm10204835eec.3.2026.06.22.00.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 00:29:54 -0700 (PDT)
Message-Id: <ef2719dac304ad7d722ef8d007447ce8c5a3a3c6.1782113388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
References: <pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
	<pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 22 Jun 2026 07:29:44 +0000
Subject: [PATCH v17 3/7] branch: let delete_branches skip unmerged branches on
 bulk refusal
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a skip-unmerged mode to delete_branches() and check_branch_commit()
so a bulk caller can silently skip branches that are not fully merged
and carry on, rather than erroring with the "use 'git branch -D'"
advice that the plain "git branch -d" path emits. Existing callers are
unaffected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a9be980aef..4c569d056a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -192,6 +192,7 @@ static int branch_merged(int kind, const char *name,
 enum delete_branch_flags {
 	DELETE_BRANCH_FORCE = (1 << 0),
 	DELETE_BRANCH_QUIET = (1 << 1),
+	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -199,16 +200,20 @@ static int check_branch_commit(const char *branchname, const char *refname,
 			       int kinds, unsigned int flags)
 {
 	bool force = flags & DELETE_BRANCH_FORCE;
+	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
 	if (!force && !rev) {
 		error(_("couldn't look up commit object for '%s'"), refname);
 		return -1;
 	}
 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("the branch '%s' is not fully merged"), branchname);
-		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
-				  _("If you are sure you want to delete it, "
-				  "run 'git branch -D %s'"), branchname);
+		if (!skip_unmerged) {
+			error(_("the branch '%s' is not fully merged"),
+			      branchname);
+			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
+					  _("If you are sure you want to delete it, "
+					  "run 'git branch -D %s'"), branchname);
+		}
 		return -1;
 	}
 	return 0;
@@ -235,6 +240,7 @@ static int delete_branches(int argc, const char **argv, int kinds,
 	int remote_branch = 0;
 	bool force;
 	bool quiet = flags & DELETE_BRANCH_QUIET;
+	bool skip_unmerged = flags & DELETE_BRANCH_SKIP_UNMERGED;
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
@@ -319,7 +325,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
 					flags)) {
-			ret = 1;
+			if (!skip_unmerged)
+				ret = 1;
 			goto next;
 		}
 
-- 
gitgitgadget

