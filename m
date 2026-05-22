Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F67C3E00A2
	for <git@vger.kernel.org>; Fri, 22 May 2026 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449514; cv=none; b=Mkw5mRekfaAGlWmvO2YAy7uYxoGhSXKcNoC2AwplWvxy4JiMUpbWnFtj90Rz9OyrseIAN05eolpPRP9oIw3jd7w9aGUh224dGWXfwJFD/e7rif4JIbbpiTmeYf6mVCF/qJaGo27VlwDINb42On6ZjjnD7/5wd0QWfm6tPO8nCdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449514; c=relaxed/simple;
	bh=2ipJrS6K/+/hr8xCZJz4wnGuVVC9terCjK1693ZNRyA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QlAXiDMiJEMvmFJC8ZLfw1oqIBHr7rq201EWrvHf2muagF2gAQRhsZeE91eASh80Nc4Ys4FsU+++Pav8h/lWMuEIFd7eCBZyPfw/sp1ZILXMFjLX4of4NGMZXZZ+q8XHN0SwJD4d7YQjOdGA7QY17oK0cK8aPWhhcXS5faZucbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMKrtd4G; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMKrtd4G"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94e2ad66abcso2235090241.1
        for <git@vger.kernel.org>; Fri, 22 May 2026 04:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779449503; x=1780054303; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xgbpo+CUHngB5yVUTnNYliAhgsPgHh/J0Q80CIsyQ1A=;
        b=QMKrtd4GkFZkWEnuGQfR6Ld2NTC6teR5R7IXY2AoJjieVpyPQ+3/7+ZPbfDXGw/uZf
         F0wWkXmIMzIKlgotoNpDXJtVwwNp6J5ATGOcs97sL3no6hjwxThWwLSD3bblc0lMpHoS
         0SzHO50yWBBWh6uF2seumCP+jG0m8Om+jfLvoywyCsXxSMVvWDYROg4hYYSzBkiCbtL7
         lcBUxNVq6a6E8cQo1+I99GnJefv4eeYuta0+073yFRH6TTj67ly5Z6oUn0AUycqbJOXj
         P05qccq121JEA2lhfZoPVaI61aX4+lFa8c26jzuuOJhirUT5HmRw0gSzk0ruQu8jTGt1
         8IVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779449503; x=1780054303;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xgbpo+CUHngB5yVUTnNYliAhgsPgHh/J0Q80CIsyQ1A=;
        b=RdidYjXueyFBuP7q+B18HSfpozEK5LcdyaEkvw4nT/SUICaoVDGODia3WF01srh0hW
         FUHTUJIFDBs5EVuz2Fczajjmhr8EI8xChU+R8L/A9hot2Pmeb6VwOIBjvCTdmNBQEys6
         R7qbFQgubc/lknFqeLnE4ssYbLnW64gYHkdqlXoQOW7qBFZMS7NEeEIpHF4gN/5nurKw
         4I/8kyjt+LlIaXQMG4hPOJGdWfkVhStvMexpBRfpVLE6crYXwjHhN43HTeDyx2W9iav7
         +ZCiuh6xA00aALg9XJZKpFrPOkZ2hEjBV4sZge9Oqi1S9s9GLZUhwdNkSLdpAVVBSLAW
         xKSQ==
X-Gm-Message-State: AOJu0YyK1b1GRg8jRApxNZorJONgq/Tk1MPA7SapMNwwNYaNFQCSjIvq
	VKJ4Z9p34m1+q0biJmixgg+x3AQF8N3hHYUy44L/Ued/w2jdWgMG+QupNzlPLakE
X-Gm-Gg: Acq92OE13iAxqcy6gpGwEGhaEa3zis4HWKkEOcsKcXqnzupx08nwncnB9SGKu64LEzi
	aaa6hHMdt7Gmk/NH8FVKK5Wqsy72xnRw3n0J3qmdCPKEkh5ytEzNtEuQANc5uyp2eF2HmFP6O6o
	2E4/DGJDculoGT2VJXcJ8s5gxOEWu2ffHhaJgjUby3hU07E5BbeXa5sEEF5ux6ZWLhp7Znh1e06
	FO98Q7YanIc19LIpW8G4yR+fhObykEmtdmHj8X7YIEHk9gt5nRfJI5Sddq755ETJGX+i4AMoXcq
	PxOrdMmvfEy4L8cYzEBredUWDavB16QWic3Wh5RcIHsYgmH3CyhSrLEXEABZ3HtvBLBSBRguk57
	F8h5riVp6Z2wQ+NrK9FkbmhVbwTBAk/deJ3T1IqHrYYQBADhwTaLZ+m1Gt7QPt0B7pFLkhUpu60
	dyTe09ny1MwI21EnMeoLqbmIWTvvhsMhmvny74nEOnUYZsMaE=
X-Received: by 2002:a05:6102:c89:b0:608:94e4:1c00 with SMTP id ada2fe7eead31-67c7490526cmr1290183137.2.1779449503187;
        Fri, 22 May 2026 04:31:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.47.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8e8d91sm96472585a.11.2026.05.22.04.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 04:31:42 -0700 (PDT)
Message-Id: <b666d09bf52a00f678c51bad0171074b5629bf98.1779449498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
References: <pull.2285.v10.git.git.1779403204.gitgitgadget@gmail.com>
	<pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 11:31:34 +0000
Subject: [PATCH v11 2/6] branch: let delete_branches warn instead of error on
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

Add a warn_only flag to delete_branches() and check_branch_commit()
so a bulk caller can report not-fully-merged branches as one-line
warnings and continue, instead of erroring with the four-line "use
'git branch -D'" advice that the standalone "git branch -d" path
emits.  Default callers pass 0 and are unaffected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2d34ad34dc..96f6ae6dec 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -193,7 +193,7 @@ static int branch_merged(int kind, const char *name,
 
 static int check_branch_commit(const char *branchname, const char *refname,
 			       const struct object_id *oid, struct commit *head_rev,
-			       int kinds, int force)
+			       int kinds, int force, int warn_only)
 {
 	struct commit *rev = lookup_commit_reference(the_repository, oid);
 	if (!force && !rev) {
@@ -201,10 +201,16 @@ static int check_branch_commit(const char *branchname, const char *refname,
 		return -1;
 	}
 	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("the branch '%s' is not fully merged"), branchname);
-		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
-				  _("If you are sure you want to delete it, "
-				  "run 'git branch -D %s'"), branchname);
+		if (warn_only) {
+			warning(_("the branch '%s' is not fully merged"),
+				branchname);
+		} else {
+			error(_("the branch '%s' is not fully merged"),
+			      branchname);
+			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
+					  _("If you are sure you want to delete it, "
+					  "run 'git branch -D %s'"), branchname);
+		}
 		return -1;
 	}
 	return 0;
@@ -220,7 +226,7 @@ static void delete_branch_config(const char *branchname)
 }
 
 static int delete_branches(int argc, const char **argv, int force, int kinds,
-			   int quiet)
+			   int quiet, int warn_only)
 {
 	struct commit *head_rev = NULL;
 	struct object_id oid;
@@ -310,8 +316,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 
 		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
-					force)) {
-			ret = 1;
+					force, warn_only)) {
+			if (!warn_only)
+				ret = 1;
 			goto next;
 		}
 
@@ -1019,7 +1026,8 @@ int cmd_branch(int argc,
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
-		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
+		ret = delete_branches(argc, argv, delete > 1, filter.kind,
+				      quiet, 0);
 		goto out;
 	} else if (forked) {
 		ret = list_forked_branches(argc, argv);
-- 
gitgitgadget

