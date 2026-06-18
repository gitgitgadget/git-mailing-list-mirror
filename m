Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023BF347538
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810737; cv=none; b=Dvn8idlNntGCipkg+VLTVCHw576i1j7hLOMOmSD562zxyxSYEjmQEpaOyZp2zWvHeKgQUqy+mvtapkjtmMn34cFc4CKn31WrNpwqcaDJA2TQbFbJAKXYJJCI7siD3Wgwm4L7xfxWWph4UAMLyXqIpXt4LseLUKRqnqycQ+DpjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810737; c=relaxed/simple;
	bh=NutoYXBg1C7XgbflVuG0jW+euBPKTNQMr3lJ1a/7C7Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rzKATZ+3kiCalLFQt/VFKn6lPXx3EGx2T6dAVwmxpAHxD+ZqgPIdm9eGoOold3mYoty9bH5l4dg9qh5eUFhBvBuhcSlGF4ooOEARryYeJkBSjHk8rU8I/IdJgt2qqRTQO1g86Zxs5qMZLtDWJpWwsi+GEnvHq0H5kqwbaxt9yBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn06/o5h; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn06/o5h"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-516d0db9372so11059981cf.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781810735; x=1782415535; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPdWLSYQGc4P/AtgxUlWCtkQOHlQaMHX/ERzqQFwwoM=;
        b=Fn06/o5hFGL0L/Ab+YRD8xsEB1FLj74fUNwrxF5S1Q1WVd62wc/bUzCRsb0vnWyYuq
         92gWCZLFa1bYQnm5quOAc+K9E3OqCaUzmOg77toPT4l7n+YYtzuWptDbTC7+taK9CsRC
         3I17s9u1PEvpy4i3lMYCTmnvE/b0VBoWZ1FHOHblFcFp1BvXisj9ZbiwTfjpP9gaOxog
         QaWB7fnIxbniXKypDOHSim0la6A7cf+wUrI9GP+8jWhrhM65xli9yVnBKso4hjQPyX28
         AkyhoZCNBuCoi7BhKn+3xydcfsiio0NsXP/XJ2F11t6kCzBvoOU8i2UskDLW8Cz7fj8p
         QeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781810735; x=1782415535;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JPdWLSYQGc4P/AtgxUlWCtkQOHlQaMHX/ERzqQFwwoM=;
        b=blp/pUWLxG+S5keOqjiYFXdNpIpw6YSDLrhrST8uL9XX9D+ADh91OS2Sq2U9jyV+Lx
         n4ScNwQARfBL63gd7yXUSkfS6SOpxucH0eKNsi+8VfmGO+TKx96qdavlAreB9sMUwsIA
         NquxJOJ7PBzKQLR49v4ucmMURdaSmmwRv3SgjnqW6FXuGxa8jyXxGvmETfDQmufEns4y
         jysj4dAv7hC/wvxFOFEpQTnQd7+IAHYpZBjf5pr9+IU3ErpWS6A0EjsoHZ1zzqpvz35P
         va/X1S8/DKFnY3vY/m5toE26IhJ4Xw+1t4H0prdiu9ZC7DNgP94Y++ihtOj6yzybpLbm
         rOxQ==
X-Gm-Message-State: AOJu0YxfgHwssngef1qegRgcTH4zkU6JYF9D9/81uTBM/d2g25NQ2jjL
	Utl/y6Jx6RhpuN9sd1EsVDswAh9IV/SYUQIdbQHcPksq0sdQ9S+9lbZrj7mzEQ==
X-Gm-Gg: AfdE7cnQShyOliHvXsU7DnE58AZmBGtK38gAZEPbvoB2TJsWaPck2jCPGMkdeS4SMFK
	ujxhVLtDtiyui+lDFAKhzkCqR8PxHCtSdRwZqn5JnUHqNzllWJ4oln4s+ML2eaFVPR2aT3uywaT
	i9NGQr2KGrjICqm8jEclNS5eowvmOvMjIALfvhXwaB/RVfsc9G/ElwVDPi5U7yGk/zTViIYZ2TK
	Gs7azBlfZgyVwddHkYGLEmiRemD6MnD+NwlM05LUtXdJ2Nt31lfqWk88TKTHGQ44MJ57FLWu4pJ
	m8ya5tpCaj+ab/CzVw+J2QNryj7VI3U6Ho7dR05hA0eMbBjs61sx58l2g4HtoBkmOShdHW4zQJz
	XmpzvPBQadvHK5wXRyhfFV5wA6+yi0s0RomCHXAedBbR5d94qtJZIIWYL+S10qw0x3yppe7Ktt4
	uGqoxJoXpMgUbz0YY=
X-Received: by 2002:a05:622a:1195:b0:517:96f0:5663 with SMTP id d75a77b69052e-519e4c31365mr7261051cf.36.1781810734909;
        Thu, 18 Jun 2026 12:25:34 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.36])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-519e60ed6dasm2373461cf.22.2026.06.18.12.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:25:34 -0700 (PDT)
Message-Id: <efc891c25556aafef340f1d626db0a50f3acdba5.1781810729.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
References: <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
	<pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 19:25:25 +0000
Subject: [PATCH v16 3/7] branch: let delete_branches skip unmerged branches on
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

