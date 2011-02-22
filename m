From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 28/73] gettextize: git-commit print_summary messages
Date: Tue, 22 Feb 2011 23:41:47 +0000
Message-ID: <1298418152-27789-29-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:44:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1uG-0008HI-S1
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266Ab1BVXoD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:03 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228Ab1BVXoA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:00 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=2QuicjKrSirmUfo4nJNgKDSyHfKY/+fhbiBWqid8E3o=;
        b=GhYZvWO41J0mHQjwZWA2dAfNJmdImBifyTTWXN17VWg0THY44+Ip8zpVaqZOvPmrcO
         mu5c+9s2vUQuEh554Ko4ibJiYH/obXhacRL4OIGpv2JpFRwGA+BE6GY+bvyFJD8XqDDO
         NSDJtM+h6aU4urpSkhn3I1XRoXQ/u3sBTS0QY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vTDWdexqDRqEwyRcyPYDGbg5mUy9uKGBMFGb2OEvWtpUxavYrHhyVCkxVUSBFtk2Ey
         0ibsdhgmqmQhfGnG1afo6bDwjUT3rfe51BkV0t+WDjRKLF9HIFF7FjSldmNA3ez2bSFX
         7rIoBtxPV1Vf7DLBZ3SCUclD/vxc2KqvfrOEs=
Received: by 10.204.100.70 with SMTP id x6mr2987958bkn.0.1298418239367;
        Tue, 22 Feb 2011 15:43:59 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.58
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:58 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167599>

Gettextize the "(root-commit)" and "detached HEAD" fragments that
appear when you commit either the root commit, or a commit in a
detached head translatable.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/commit.c  |    4 ++--
 t/t7502-commit.sh |   10 ++++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c7c6c59..c90a8cf 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1223,9 +1223,9 @@ static void print_summary(const char *prefix, con=
st unsigned char *sha1)
 		!prefixcmp(head, "refs/heads/") ?
 			head + 11 :
 			!strcmp(head, "HEAD") ?
-				"detached HEAD" :
+				_("detached HEAD") :
 				head,
-		initial_commit ? " (root-commit)" : "");
+		initial_commit ? _(" (root-commit)") : "");
=20
 	if (!log_tree_commit(&rev, commit)) {
 		rev.always_show_header =3D 1;
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 034b9c3..dad1b2b 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -22,7 +22,10 @@ check_summary_oneline() {
 	SUMMARY_POSTFIX=3D"$(git log -1 --pretty=3D'format:%h')"
 	echo "[$SUMMARY_PREFIX $SUMMARY_POSTFIX] $2" >exp &&
=20
-	test_cmp exp act
+	if test_have_prereq C_LOCALE_OUTPUT
+	then
+		test_cmp exp act
+	fi
 }
=20
 test_expect_success 'output summary format' '
@@ -32,7 +35,10 @@ test_expect_success 'output summary format' '
 	check_summary_oneline "root-commit" "initial" &&
=20
 	echo change >>file1 &&
-	git add file1 &&
+	git add file1
+'
+
+test_expect_success 'output summary format: root-commit' '
 	check_summary_oneline "" "a change"
 '
=20
--=20
1.7.2.3
