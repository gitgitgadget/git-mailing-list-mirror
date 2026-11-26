Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723886;
	b=kbfBwHqIY7vgna71o94Qq9xiRDbTrxIg1UcjjbTrt1/b/qCGwut5yK5TT0WHlUztodui
	 /hQ06AplxpNhPhelSskHO44pzvntvUqLkbfgLNKvTnSf/ycz95h9seShSKfps5gx8fncB
	 ac9YXqq35tpGOqJB9cvS4INrP5GsRLWomX5JQIeeOREwX5iN5ztU8LuQy52HW9ECgs/jY
	 oVERJ+N66+7l8WsKtHqQ1zkoDI1iX7YRfdenfVoWnxavZQ04vU8JOSErimNHvp+epiEsX
	 bXSwuXqAv62+jeQ5wK9BrzBTWBgcvKNya2u/D4J0kA7l2Xj2ZblFBJbBCS/a/MNA+QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723886;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=l19WTAwpU80nnI3t56F/bOd2JTfrdr+vEB6kJUm2TKU=;
	b=Ss7/DsUz4kqH4hGqiXOXi9Be/QpM8+4Ct3qKT77NtWb04Salwfo45SY/r87YcA5UYZtR
	 lD6S7UtS8ZSuvVUwuT87yoWhhM9yoQAp0ARv1A58TWYPwY8UJIO1r0tA+GobiV1hvuTW8
	 UM0I13xi5ufGmK2DTbA27emjY80JCSL8i0+r+2yBCVitgDoHJupFDDBcKjpurQSdE1ZPp
	 orUOOHnPo1mrNPvpfRkBJZPnEPpa5OVfkgbZnoYv+zGXHjzPoX5g1ekR6/R7m8BtHKE8U
	 DAxhyAzwtsDBpbLvstlmua/biDRKQyM2Pm9rYRkL/2C8ZYziM11zE7fTWMn6pXjv+6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=dNf+hQXg;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25641606A335
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 20:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25641606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=dNf+hQXg
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6AQKBBsO024205-6AQKBBsQ024205
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 26 Nov 2026 22:11:11 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xWfoF-00CmMt-Dj;
	Thu, 26 Nov 2026 22:11:11 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 22:11:11 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 34572c5c;
	Thu, 26 Nov 2026 20:11:10 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>, Julia Evans <julia@jvns.ca>, Tuomas
 Ahola <taahol@utu.fi>
Subject: [PATCH v4 2/2] lint-docs: ensure command-list.txt lists all guides
Date: Thu, 26 Nov 2026 22:11:10 +0200
Message-ID: <20261126201110.9046-3-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20261126201110.9046-1-taahol@utu.fi>
References: <20260909052501.8448-1-taahol@utu.fi>
 <20261126201110.9046-1-taahol@utu.fi>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-09.utu.fi (130.232.247.49) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZW0gCHQQBCSgCHgYbRgsJSFhI
 WkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhbSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFlbSAIdBAEJKAIeBhtG
 CwlIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=l19WTAwpU80nnI3t56F/bOd2JTfrdr+vEB6kJUm2TKU=;
 b=dNf+hQXgkX8PXzcJp15WlhIJW371g+8Xwwo9pF446nPPyyit+6H9hS3RcXvh1wua3A2rCzmeyV7v
	Gm/ccjDZrUj3+86b4FJm7xCPph8qUxO5+dwLz3GMUzZQS12Hx49fqeioCYR1GH81FP+HnMGdYzpk
	nz3I4WIDglMbXb5FcyfKb7dmYVfxA4rTejZmtzBQe94f/AzGf9uP1d01sZsEYGbBbdIxVsImdnFx
	CJgP5+him0Ss4Nbl8X7TKrSyIq7ASWB4JlwxCCmUnQK/R7Huq72nSsMbo3gwTn6WlN8fLvpCSeBW
	OsFVbiDGly1Ky2ZbbC9auwXgBQIxAhq1ZznG7w==

Since 2135e1ad70 (command-list.txt: add missing 'gitcredentials' and
'gitremote-helpers', 2020-08-05) there has been a comment in
Documentation/Makefile reminding developers to add new guides also to
command-list.txt.  However, there is no linter script to enforce that.

Adapt Documentation/lint-manpages.sh to fill that role.  Extract
MAN5_TXT and MAN7_TXT from the docs Makefile and check command-list.txt
against them.  Exempt gitweb.conf(5) and gittutorial-2(7) from the
new linter routine as deliberate omissions.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 Documentation/lint-manpages.sh | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/Documentation/lint-manpages.sh b/Documentation/lint-manpages.sh
index a0ea572382..87a652bd22 100755
--- a/Documentation/lint-manpages.sh
+++ b/Documentation/lint-manpages.sh
@@ -1,21 +1,27 @@
 #!/bin/sh
 
 extract_variable () {
-	(
-		cat ../Makefile
-		cat <<EOF
+	file="$1"
+	directory="$(dirname "$file")"
+	shift
+	for i in "$@"
+	do
+		(
+			cat "$file"
+			cat <<EOF
 print_variable:
 	@\$(foreach b,\$($1),echo XXX \$(b:\$X=) YYY;)
 EOF
-	) |
-	make -C .. -f - print_variable 2>/dev/null |
-	sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
+		) |
+		make -C "$directory" -f - print_variable 2>/dev/null |
+		sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
+	done
 }
 
 check_missing_docs () (
 	ret=0
 
-	for v in $ALL_COMMANDS
+	for v in $ALL_COMMANDS $MAN_GUIDES
 	do
 		case "$v" in
 		git-merge-octopus) continue;;
@@ -29,6 +35,8 @@ check_missing_docs () (
 		git-stage) continue;;
 		git-legacy-*) continue;;
 		git-?*--?* ) continue ;;
+		gittutorial-2) continue ;;
+		gitweb.conf) continue ;;
 		esac
 
 		if ! test -f "$v.adoc"
@@ -84,9 +92,10 @@ check_extraneous_docs () {
 	)
 }
 
-BUILT_INS="$(extract_variable BUILT_INS)"
-ALL_COMMANDS="$(extract_variable ALL_COMMANDS)"
-EXCLUDED_PROGRAMS="$(extract_variable EXCLUDED_PROGRAMS)"
+BUILT_INS="$(extract_variable ../Makefile BUILT_INS)"
+ALL_COMMANDS="$(extract_variable ../Makefile ALL_COMMANDS)"
+EXCLUDED_PROGRAMS="$(extract_variable ../Makefile EXCLUDED_PROGRAMS)"
+MAN_GUIDES="$(extract_variable Makefile MAN5_TXT MAN7_TXT | sed -e 's/\.adoc//')"
 
 findings=$(
 	if ! check_missing_docs
-- 
ta/command-list-guides-sync-lint

