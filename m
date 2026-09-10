Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F59E59E351
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069459; cv=none; b=AFj3DLEpCfDPvn7PV2em2ErOyoTHV661Z1Oft6xnHrENhQcYU/1kjeshml4rxSi9Ab4qU8JTBI5DyJvVx9/7iAIVD8Ktv5z7xMgE5e8kk72wf8l2v4rQRmLemiQAJ0mXzshj2L291gy50RQlxBkFT9vWHzwEjlRtNLXdIz8BrHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069459; c=relaxed/simple;
	bh=OyCK90TiW748cO7JC0rZpXnQs+XAhYBZm3vNSCyHRdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+DLFDjH7oZB2Prb1vzyKXF5kMrx3Jg/Ia5UIHP+mD7BYqrr6ZVxljOrS8O1wDpLHAC8YvcLqnT7xq3WrMy1M6nLLYlediqKMmRXHReVeikYX8zI8UIcMDO/Pt62zUJ0KOEDYhedj+/RgOw5idbRHt3W1zoAs0VZZ1Acv1giMxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=X4kYzSv1; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="X4kYzSv1"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 68AJiBAu016540-68AJiBAw016540
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 10 Sep 2026 22:44:11 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1x4kgt-001ybK-0R;
	Thu, 10 Sep 2026 22:44:11 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 22:44:10 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 9d6f5e4f;
	Thu, 10 Sep 2026 19:44:10 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH v2 2/2] lint-docs: check the guide list in command-list.txt
Date: Thu, 10 Sep 2026 22:43:51 +0300
Message-ID: <20260910194351.20809-3-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260910194351.20809-1-taahol@utu.fi>
References: <20260909052501.8448-1-taahol@utu.fi>
 <20260910194351.20809-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-05.utu.fi (130.232.247.45) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhaSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=dBf5gaK2MRNWR9RHGLHn8hfL41sC/NPnIboXqoyDpeU=;
 b=X4kYzSv1l1sgpK/FDF6bxiDu1VIE6bv9hOMsg9c3Ca7/BWlxRuX6mCY64dqHaOhYV1S1q0O+BT9i
	m37O2qXXDUAemXfn9T46Cr0LiKJh9Yw0Gf4lcIUFoO1cOinCnkbJcEZbukiC+dHOy+ZB6j5fuoq7
	lNtWvzVwIBnMqotBMtTKyZeZFVhZNlW7mlJAaNw0irCWWfyr3txOLiRPdaDWSGFLSp1X3qmpd4I2
	XNz+KlJ1ry/GOmzcJl5IDG8z9J5Ne0S+N+PfAxyi1Z0euX8z+8juCpVrCbDElNQQEePlBtY5fV9Z
	8VBZz7lRwqyJWyoYGJuJwZ+Zby84Ct1x9pEAcA==

Since 2135e1ad70 (command-list.txt: add missing 'gitcredentials' and
'gitremote-helpers', 2020-08-05) there has been a comment in
Documentation/Makefile reminding developers to add new guides also to
command-list.txt.  However, there is no linter script to enforce that.

Adapt Documentation/lint-manpages.sh to fill that role.  Extract
MAN5_TXT and MAN7_TXT from the Makefile and check command-list.txt
against them.  Exempt gitweb.conf(5) from the new linter routine.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---

Notes:
    c655855559 (doc: git: list gitdatamodel(7) as a concept guide, 2026-09-05)
    should be merged in to make the new test pass.

 Documentation/Makefile         |  2 ++
 Documentation/lint-manpages.sh | 10 +++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index f8dea4b395..8e28ac784b 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -67,6 +67,8 @@ MAN7_TXT += gittutorial-2.adoc
 MAN7_TXT += gittutorial.adoc
 MAN7_TXT += gitworkflows.adoc
 
+MAN_GUIDES = $(patsubst %.adoc,%,$(MAN5_TXT) $(MAN7_TXT))
+
 HOWTO_TXT += $(wildcard howto/*.adoc)
 
 DOC_DEP_TXT += $(wildcard *.adoc)
diff --git a/Documentation/lint-manpages.sh b/Documentation/lint-manpages.sh
index a0ea572382..d4a1977ba6 100755
--- a/Documentation/lint-manpages.sh
+++ b/Documentation/lint-manpages.sh
@@ -1,21 +1,23 @@
 #!/bin/sh
 
 extract_variable () {
+	file=${2:-../Makefile}
+	directory=$(dirname "$file")
 	(
-		cat ../Makefile
+		cat "$file"
 		cat <<EOF
 print_variable:
 	@\$(foreach b,\$($1),echo XXX \$(b:\$X=) YYY;)
 EOF
 	) |
-	make -C .. -f - print_variable 2>/dev/null |
+	make -C "$directory" -f - print_variable 2>/dev/null |
 	sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
 }
 
 check_missing_docs () (
 	ret=0
 
-	for v in $ALL_COMMANDS
+	for v in $ALL_COMMANDS $MAN_GUIDES
 	do
 		case "$v" in
 		git-merge-octopus) continue;;
@@ -29,6 +31,7 @@ check_missing_docs () (
 		git-stage) continue;;
 		git-legacy-*) continue;;
 		git-?*--?* ) continue ;;
+		gitweb.conf) continue ;;
 		esac
 
 		if ! test -f "$v.adoc"
@@ -87,6 +90,7 @@ check_extraneous_docs () {
 BUILT_INS="$(extract_variable BUILT_INS)"
 ALL_COMMANDS="$(extract_variable ALL_COMMANDS)"
 EXCLUDED_PROGRAMS="$(extract_variable EXCLUDED_PROGRAMS)"
+MAN_GUIDES="$(extract_variable MAN_GUIDES ./Makefile)"
 
 findings=$(
 	if ! check_missing_docs
-- 
ta/command-list-guides-sync-lint

