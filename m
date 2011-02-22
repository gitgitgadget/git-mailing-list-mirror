From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 06/73] gettextize: git-init "Initialized [...] repository" message
Date: Tue, 22 Feb 2011 23:41:25 +0000
Message-ID: <1298418152-27789-7-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:44:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1tj-0007ye-Pr
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852Ab1BVXnq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:43:46 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab1BVXng (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:36 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=P69iVpib3eoOM9GCT5+SJPGTtZts6zHNwYjAvPGKtSc=;
        b=ejF5ndbrgBM0nSTfWha7h3BZi/8dE3lzPrQpPqpJgzNPp/F2KtfdpcVtmsC7YelAqd
         Ee2pBrqXWSNh/XJ5KfEXkCkvj+4GPHGQf6BXOZQ0FkMHJc/PHucB2uuUA6QQFWjBWg+P
         dqPAPtRxS1nMZKmCrgHMv57g3+9r7LtImPL3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Vd73iQbnGM8cLEog8/tw0k16m4c3G16gwVY8kETKr66pwf3E8gUXwJH1B5jy9YbybM
         3QA87B152hihbvXYwz1w03JrGBfDypHLGbGXSSJ2b3Io+ysptntSYxsdNI1f3KrkywXz
         IkA3x2C5dJdr8kFTlRb8I8QAAmlnQBf1rtnXI=
Received: by 10.204.71.141 with SMTP id h13mr3047503bkj.180.1298418215794;
        Tue, 22 Feb 2011 15:43:35 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.35
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:35 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167596>

These messages could benefit from splitting up.  An earlier version of
this patch began like this:

    const char *reinit_shared   =3D _("Reinitialized existing shared Gi=
t repository in %s\n");
    const char *init_shared     =3D _("Initialized empty shared Git rep=
ository in %s\n");
    const char *reinit_noshared =3D _("Reinitialized existing Git repos=
itory in %s\n");
    const char *init_noshared   =3D _("Initialized empty Git repository=
 in %s\n");

But in the first round of gettextization I'm aiming to keep code
changes to a minimum for ease of review.  So just add a comment
explaining to translators how the sprintf format gets used so they
can cope for now if the language's grammar allows.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/init-db.c |   12 +++++++++---
 t/t0001-init.sh   |    2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index f7ddf5b..e0e5ce3 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -354,9 +354,15 @@ int init_db(const char *template_dir, unsigned int=
 flags)
 	if (!(flags & INIT_DB_QUIET)) {
 		const char *git_dir =3D get_git_dir();
 		int len =3D strlen(git_dir);
-		printf("%s%s Git repository in %s%s\n",
-		       reinit ? "Reinitialized existing" : "Initialized empty",
-		       shared_repository ? " shared" : "",
+
+		/*
+		 * TRANSLATORS: The first '%s' is either "Reinitialized
+		 * existing" or "Initialized empty", the second " shared" or
+		 * "", and the last '%s%s' is the verbatim directory name.
+		 */
+		printf(_("%s%s Git repository in %s%s\n"),
+		       reinit ? _("Reinitialized existing") : _("Initialized empty")=
,
+		       shared_repository ? _(" shared") : "",
 		       git_dir, len && git_dir[len-1] !=3D '/' ? "/" : "");
 	}
=20
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f684993..dd4c00d 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -180,7 +180,7 @@ test_expect_success 'GIT_DIR & GIT_WORK_TREE (2)' '
 	fi
 '
=20
-test_expect_success 'reinit' '
+test_expect_success C_LOCALE_OUTPUT 'reinit' '
=20
 	(
 		sane_unset GIT_CONFIG GIT_WORK_TREE GIT_CONFIG &&
--=20
1.7.2.3
