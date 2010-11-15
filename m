From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/10] git-checkout.txt: mention of sparse checkout
Date: Mon, 15 Nov 2010 17:36:49 +0700
Message-ID: <1289817410-32470-10-git-send-email-pclouds@gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 15 11:40:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHwUM-0002eO-8E
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 11:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134Ab0KOKkd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 05:40:33 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64902 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093Ab0KOKkc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 05:40:32 -0500
Received: by pzk28 with SMTP id 28so922167pzk.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 02:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=r3kiBds4nihSj0vescQVVGIIZ0dx89ThHd/V/ST/FfQ=;
        b=SQZXvvyoJmhPVaOuEBOPKxfa+tvdKwE9mpqKp9QvqRbxQCthcVWzEHgw6iGxTTI99q
         /wSJSDxUH8GMPE0qqWwazjAPUCgHE1Hg19Hm2R3waqRMZJNy7uXxnIVTUhizZ+GGKQIX
         MBKE1Bj4Jc9439iUy1wMNOQud2EdyCt7GAJdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=opo0RzLcv1yyMBmQ5HS6rNthMTtSrM6PVIMgsUXEaVQjV6PHBsDUXrpUGhYY2m8lQz
         5CBQJO64QdLXhXcDlDzI54KsK6oPjb8t4MCYCBN/4itd/SiTo7AneKT5cVZXcXjPes3S
         h7R8ekH22/qz6zl6MmvZs/dtsYScGzfwG2uB8=
Received: by 10.142.188.19 with SMTP id l19mr4644845wff.290.1289817632252;
        Mon, 15 Nov 2010 02:40:32 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id w42sm8577334wfh.3.2010.11.15.02.40.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 02:40:31 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Nov 2010 17:39:15 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161486>

All the boring technical stuff still resides in git-read-tree.txt. The
introduction here targets end users.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-checkout.txt  |   29 +++++++++++++++++++++++++++++
 Documentation/git-read-tree.txt |   11 +----------
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkou=
t.txt
index 1d82063..b9a97c9 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -253,6 +253,35 @@ $ git log -g -2 HEAD
 ------------
=20
=20
+Sparse checkout
+---------------
+
+"Sparse checkout" allows to sparsely populate working directory
+according to patterns defined in `$GIT_DIR/info/sparse-checkout`. The
+syntax of this file is similar to linkgit:gitignore[5].  This feature
+requires core.sparseCheckout to be turned on. `git checkout -S` should
+be used when editing this file. It will update working directory
+properly after editing. See linkgit:git-read-tree[1] for more
+information.
+
+Normally sparse-checkout file contains only one rule, which indicates
+that all files are checked out:
+
+----------------
+*
+----------------
+
+You can update the file to only contain files you want to be checked
+out, or files _not_ to be checked out, using negate patterns. For
+example, to remove file "unwanted":
+
+----------------
+*
+!unwanted
+----------------
+
+To fully populate working directory again, use "git checkout --full".
+
 EXAMPLES
 --------
=20
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-t=
ree.txt
index 634423a..4b72c96 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -390,16 +390,7 @@ Then it compares the new skip-worktree value with =
the previous one. If
 skip-worktree turns from unset to set, it will add the corresponding
 file back. If it turns from set to unset, that file will be removed.
=20
-While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
-files are in. You can also specify what files are _not_ in, using
-negate patterns. For example, to remove file "unwanted":
-
-----------------
-*
-!unwanted
-----------------
-
-Another tricky thing is fully repopulating working directory when you
+A tricky thing is fully repopulating working directory when you
 no longer want sparse checkout. You cannot just disable "sparse
 checkout" because skip-worktree are still in the index and you working
 directory is still sparsely populated. You should re-populate working
--=20
1.7.3.2.210.g045198
