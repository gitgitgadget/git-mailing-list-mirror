Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A82EDD40
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781810736; cv=none; b=kQFai210kvGl44oodTXQ6xMyQRpF0QKUiMPQR2cILRmcTRx/A8OZqDXiHfe/fPbBjdAt70sCNMFlJpFlJVBtR2ryo6oiLLvZtq4Sbu3YedPtEWjhCUdlqAHn4cYcc0MzM2aaAVzYC6xGm6z68RWFrGkwuXClea4i+5haTh7A/Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781810736; c=relaxed/simple;
	bh=KjiGtruBVnrVqEUprHuzjMyaiiabZgh7TFUkoeQ4xis=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZdnQ8vEjlFHnlYQYm3XUwajgYvY/4phz4nRZEf7olUvHo5wNowdpW4SgbU4K66GuuVtVxttW9x9EIQ6AlIN0akG/qw+0mtfh/RPxOtysjoLgQdX1heMiAvWLKKNUHIbj9Prr9Ty3RUEtmbE1xPiVBIPbs+AVuoTGmm+8DQ8LilU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVz6UruS; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVz6UruS"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8dc09919aa2so22640826d6.3
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781810734; x=1782415534; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DYXqJ/vWxGvHLI/4V1ysuQNcz2lurY64W8PBoiiMeM=;
        b=aVz6UruSCbqcwhW2C0lGGx9U1o0HTEFLoOJizToTbx510URPHMXUrSlHaeVVfnP3ev
         r3aP5rS0fIxoyewr6m4ObkjKUrKmR6tobXJwe6tvtqdzVl+cBPq/NVVw6YvdH+rK0W4e
         A+ejlKK4hTGOd9DBJ1xXESB4IJeWKpxXcUpS9puRjBdU8eScqs8mN2pVFnmN9W2I5JSz
         N98hOgM0wrtbVLhvDxxJaw7VxMFeDP0Gt8M3iTf0ap0IhaAMk+UkxdW4FqcR+sDQhwKf
         D0kMjxuaDMF3/+SCf1mQ8nZqM3XDI79pAY84M7w/JhHiehxu4srZm7nQeaUT00GZOVAq
         B0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781810734; x=1782415534;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0DYXqJ/vWxGvHLI/4V1ysuQNcz2lurY64W8PBoiiMeM=;
        b=hs+IQpHMxnAUTJLUSrcGI4HM988ZNUZ4J8p35i2EwfQumAFKd8hrGP2+YIWeLDRp2E
         DCUtGlSUDaaOo3YtpPOMIx/BN6vJj0EwhcMa0N6sYn6n6Yq7xEx46OLU/T5VrS3k4h5j
         USu5Bk+E7lo0mHL7l+PMSAROSYmalBYj78vFaB5LxN2OP09duM3slewPnBfONiv+/R1j
         38yEL50cmy6pjTU8wm4MSM5qrcG6JTR9/kMCm3lfreQjpFs6nvWqhu09/WvQj0wDR5i4
         5f9yNvn92hmty+pZeMTPmuepY5DTKjeB3xO+eJCH1uHSxb+LdLG2LJbc+pXS9+4JiL3r
         P3NQ==
X-Gm-Message-State: AOJu0YxP3t1arBuq+9PiWQEXPnDo7g2xq/0T5VUSwB6E/p7SyArV33fx
	ku/jgg0joN0tlnT6SCfa5rJIZdxbdXGDCoUnmtNWIthlU5vnUu2mx5Wlwk/LJg==
X-Gm-Gg: AfdE7cnTu09LMyxTkl0M8UK5mX2Hzjfb0PXR2l9C/var6LHOxE4oAzjgB2nxX0uKY1M
	ykVgbzdU3e+qfqP6BRdM5oEo2vt1WkT4cKhn80rsD3tGRhVPUO7Jbpf5SgKV5OvXsHqSjs8Wssa
	psGle3ysX+Gu3SLFs1YMbXl3Kg2zPpfby+8/G6DO+4abxVAORDuQO0oiSQ6Rsz/prjYqsrfbMnu
	DIT6ZZg9BYYVysHeVKtWhjaWSFrfZwcCoTtMGQQXkHgybxT4KbcDRxVgQlFTN5828+tS3nBwkke
	ZgjT2ane5g/5JJvtoOZXp67qsPDggg6FXPAby7fSKgVdvWwn0OK8Hbr4/BHdgNMuW6lC4HSlRoY
	gDXL9f/31t7MwW56jWcisArkXjLsUiNPwWreRO0RymwExJY+izeSbCqKsYNHgJQNeWVHZewFkuD
	7+KB8GPxIP+iYRqiE=
X-Received: by 2002:a05:620a:4386:b0:915:89d4:df17 with SMTP id af79cd13be357-92091497ad2mr48275885a.33.1781810733642;
        Thu, 18 Jun 2026 12:25:33 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-920a1720ba7sm3094685a.16.2026.06.18.12.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:25:33 -0700 (PDT)
Message-Id: <4f8af602ba67a31949fdf8eda31ca221138ae585.1781810729.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
References: <pull.2285.v15.git.git.1781542042.gitgitgadget@gmail.com>
	<pull.2285.v16.git.git.1781810729.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 19:25:24 +0000
Subject: [PATCH v16 2/7] branch: convert delete_branches() to a flags argument
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

delete_branches() and check_branch_commit() take a pair of int
booleans (force and quiet) that the next commits would grow further.
Replace them with a single "unsigned int flags" argument and an
enum, splitting the bits back into named bool locals so the body
keeps reading the same named values.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c159f45b4c..a9be980aef 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -189,10 +189,16 @@ static int branch_merged(int kind, const char *name,
 	return merged;
 }
 
+enum delete_branch_flags {
+	DELETE_BRANCH_FORCE = (1 << 0),
+	DELETE_BRANCH_QUIET = (1 << 1),
+};
+
 static int check_branch_commit(const char *branchname, const char *refname,
 			       const struct object_id *oid, struct commit *head_rev,
-			       int kinds, int force)
+			       int kinds, unsigned int flags)
 {
+	bool force = flags & DELETE_BRANCH_FORCE;
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
 	if (!force && !rev) {
 		error(_("couldn't look up commit object for '%s'"), refname);
@@ -217,8 +223,8 @@ static void delete_branch_config(const char *branchname)
 	strbuf_release(&buf);
 }
 
-static int delete_branches(int argc, const char **argv, int force, int kinds,
-			   int quiet)
+static int delete_branches(int argc, const char **argv, int kinds,
+			   unsigned int flags)
 {
 	struct commit *head_rev = NULL;
 	struct object_id oid;
@@ -227,6 +233,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	int i;
 	int ret = 0;
 	int remote_branch = 0;
+	bool force;
+	bool quiet = flags & DELETE_BRANCH_QUIET;
 	struct strbuf bname = STRBUF_INIT;
 	enum interpret_branch_kind allowed_interpret;
 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
@@ -241,7 +249,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		remote_branch = 1;
 		allowed_interpret = INTERPRET_BRANCH_REMOTE;
 
-		force = 1;
+		flags |= DELETE_BRANCH_FORCE;
 		break;
 	case FILTER_REFS_BRANCHES:
 		fmt = "refs/heads/%s";
@@ -252,12 +260,14 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 	branch_name_pos = strcspn(fmt, "%");
 
+	force = flags & DELETE_BRANCH_FORCE;
+
 	if (!force)
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
 
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
-		int flags = 0;
+		int ref_flags = 0;
 
 		copy_branchname(&bname, argv[i], allowed_interpret);
 		free(name);
@@ -279,7 +289,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 					     RESOLVE_REF_READING
 					     | RESOLVE_REF_NO_RECURSE
 					     | RESOLVE_REF_ALLOW_BAD_NAME,
-					     &oid, &flags);
+					     &oid, &ref_flags);
 		if (!target) {
 			if (remote_branch) {
 				error(_("remote-tracking branch '%s' not found"), bname.buf);
@@ -291,7 +301,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 									   | RESOLVE_REF_NO_RECURSE
 									   | RESOLVE_REF_ALLOW_BAD_NAME,
 									   &oid,
-									   &flags);
+									   &ref_flags);
 				FREE_AND_NULL(virtual_name);
 
 				if (virtual_target)
@@ -306,16 +316,16 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
-		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
+		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
-					force)) {
+					flags)) {
 			ret = 1;
 			goto next;
 		}
 
 		item = string_list_append(&refs_to_delete, name);
-		item->util = xstrdup((flags & REF_ISBROKEN) ? "broken"
-				    : (flags & REF_ISSYMREF) ? target
+		item->util = xstrdup((ref_flags & REF_ISBROKEN) ? "broken"
+				    : (ref_flags & REF_ISSYMREF) ? target
 				    : repo_find_unique_abbrev(the_repository, &oid, DEFAULT_ABBREV));
 
 	next:
@@ -872,7 +882,9 @@ int cmd_branch(int argc,
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
+		ret = delete_branches(argc, argv, filter.kind,
+				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
+				      (quiet ? DELETE_BRANCH_QUIET : 0));
 		goto out;
 	} else if (show_current) {
 		print_current_branch_name();
-- 
gitgitgadget

