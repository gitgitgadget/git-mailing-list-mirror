From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 17/72] gettextize: git-branch "git branch -v" messages
Date: Sat, 19 Feb 2011 19:24:00 +0000
Message-ID: <1298143495-3681-18-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:27:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsT7-0002tu-NV
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755902Ab1BST1h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:27:37 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56673 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873Ab1BST1d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:33 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1970368ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=jdwhWFRENRxKuDPCUZ+ruJtm1I9AKDYMrv6uqPWDuhk=;
        b=PZYUSEawxPK3VCr9zppDoqdAfi7ELzzOVjVhtizFZbuHjLjZ6eDqt1g7T/HhXAil1c
         wtOMxHFYlAgWGFJKZRFvsiq+wrYlmwK/7FmApdnxXi/HkDDAxUjQVfyOaOz4sNGtBm48
         nUJQh8iJWQAA1AgEd0b9Sy1Bwnr7cDSIRVj1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=CLHo0wNi0KjyWi/UsEZgA2yNeHeTt4Ax6qpq3Vx7QQCQI8bAjJ9hTHaE4SdzhKM1sp
         TxtmKMtRLeLV4F5S6QevUs3/EOvuETcSslZm3C3dRY4nfy4Ypy3LdxJ7rXKDb/C6QCCd
         KiDW18hWw1zokpJBlvIXr43NqNTPS3a7xQG3U=
Received: by 10.14.0.133 with SMTP id 5mr2437474eeb.10.1298143652469;
        Sat, 19 Feb 2011 11:27:32 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.31
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:31 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167323>

Make the "git branch -v" messages translatable, e.g.:

    5054b57 [ahead 8] branch error fixup

This is possibly a plumbing message.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/branch.c         |    6 +++---
 t/t6040-tracking-info.sh |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index d276681..4c1a256 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -373,11 +373,11 @@ static void fill_tracking_info(struct strbuf *sta=
t, const char *branch_name,
 		strbuf_addf(stat, "%s: ",
 			shorten_unambiguous_ref(branch->merge[0]->dst, 0));
 	if (!ours)
-		strbuf_addf(stat, "behind %d] ", theirs);
+		strbuf_addf(stat, _("behind %d] "), theirs);
 	else if (!theirs)
-		strbuf_addf(stat, "ahead %d] ", ours);
+		strbuf_addf(stat, _("ahead %d] "), ours);
 	else
-		strbuf_addf(stat, "ahead %d, behind %d] ", ours, theirs);
+		strbuf_addf(stat, _("ahead %d, behind %d] "), ours, theirs);
 }
=20
 static int matches_merge_filter(struct commit *commit)
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 1e0447f..d508a19 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -42,7 +42,7 @@ b3 behind 1
 b4 ahead 2
 EOF
=20
-test_expect_success 'branch -v' '
+test_expect_success NO_GETTEXT_POISON 'branch -v' '
 	(
 		cd test &&
 		git branch -v
--=20
1.7.2.3
