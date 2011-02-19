From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 40/72] gettextize: git-merge "Updating %s..%s" message
Date: Sat, 19 Feb 2011 19:24:23 +0000
Message-ID: <1298143495-3681-41-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:30:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsVL-00042j-IU
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756385Ab1BST36 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:29:58 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56673 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756056Ab1BST2B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:01 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1970368ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=HcRfVaQnw4Qnn/s/tHXXhcaN5Sdt07JHWIqso7Nuscs=;
        b=i3hWgkMjdxCbGuJYnmxN3MQ2szqsFSTr8fa8v6OAFVSMGHhNnNqxiOjU8RRbTrmOBY
         dQNl5CJw8QWBjQCXfWbGBsMZhPAGN74kPLbKPpCvZlXh+Lni9NEb+Ahj2KPDtrNZv16Q
         et79iLXmQIbohb0agy405qb/I3AsNiJDP7PHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DB+s9HVIC01br5vYqb2efQdljtuSBTIrDbMwyHfOUnm13F3Q0gxsK6YUc+HWK6x/QE
         KXf4r6hbWJ2lc9QkXOwiZzBLwhPqSRzetFwtuM4A5LuPnsPTc7Mj9vH3f5+dr/kKDGgF
         pleoBAP2PTYlvL1Kc3JpJqgoErJOHSz1HOozU=
Received: by 10.14.17.225 with SMTP id j73mr2432628eej.26.1298143680312;
        Sat, 19 Feb 2011 11:28:00 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.59
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:59 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167365>

Gettextize the "Updating %s..%s\n" message. A test in
t1200-tutorial.sh explicitly checked for this message. Split it into
two tests to skip the test_cmp test under GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/merge.c     |    2 +-
 t/t1200-tutorial.sh |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 0be4dfa..4f6b34f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1124,7 +1124,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		strcpy(hex, find_unique_abbrev(head, DEFAULT_ABBREV));
=20
 		if (verbosity >=3D 0)
-			printf("Updating %s..%s\n",
+			printf(_("Updating %s..%s\n"),
 				hex,
 				find_unique_abbrev(remoteheads->item->object.sha1,
 				DEFAULT_ABBREV));
diff --git a/t/t1200-tutorial.sh b/t/t1200-tutorial.sh
index bfa2c21..fb02cac 100755
--- a/t/t1200-tutorial.sh
+++ b/t/t1200-tutorial.sh
@@ -163,7 +163,10 @@ test_expect_success 'git resolve' '
 	git checkout mybranch &&
 	git merge -m "Merge upstream changes." master |
 		sed -e "1s/[0-9a-f]\{7\}/VARIABLE/g" \
-		-e "s/^Fast[- ]forward /FASTFORWARD /" >resolve.output &&
+		-e "s/^Fast[- ]forward /FASTFORWARD /" >resolve.output
+'
+
+test_expect_success NO_GETTEXT_POISON 'git resolve output' '
 	test_cmp resolve.expect resolve.output
 '
=20
--=20
1.7.2.3
