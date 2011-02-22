From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 41/73] gettextize: git-merge "Updating %s..%s" message
Date: Tue, 22 Feb 2011 23:42:00 +0000
Message-ID: <1298418152-27789-42-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:46:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1w3-0000rs-9X
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493Ab1BVXoR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:17 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39209 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443Ab1BVXoO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:14 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866615bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=s4yB5u4Pc4nAjOeeDgEGHlAmb/V6n1FS4X3ob9kI9rY=;
        b=fMtpinZDeGR37ApgrQEE+mCXKV7Qe127skclQuniV3BLzIhDznrkw5XbS4y0pK5JM1
         bVV0d156FZM3U2+lgYQwUhMOSkY6+P4Q7zJ2Mqbac8wfyqm+BC5zqeGVz6KZ3Z8bVR+t
         EUMulSMM4o5QQhJBLJwkczW15WCM9cmVC1RIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ZOVowhycJUmEXwy7UmzFotdvT/4RaQuScMCzHnQDeNNMqvs6qK0E19qrGFGz6YlYIq
         DdsFlBG0H1FbPWeval4po3hC/ZRpxEz8my6kq4tB9OiU2fHEorrbWRRCB2UopsWx0fUM
         OUxETJRvvc+5NtssnLDVP3jBoMa/cIqSXBlt8=
Received: by 10.204.70.134 with SMTP id d6mr3064299bkj.21.1298418253224;
        Tue, 22 Feb 2011 15:44:13 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.12
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:12 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167627>

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
index bfa2c21..3264fef 100755
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
+test_expect_success C_LOCALE_OUTPUT 'git resolve output' '
 	test_cmp resolve.expect resolve.output
 '
=20
--=20
1.7.2.3
