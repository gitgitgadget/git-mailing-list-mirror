From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RCF] autoconf: Check if <libintl.h> exists and set NO_GETTEXT
Date: Tue,  1 Jun 2010 18:11:48 +0000
Message-ID: <1275415908-24838-1-git-send-email-avarab@gmail.com>
References: <m3eigqr8hf.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 01 20:12:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJVwq-0006HZ-GV
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 20:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756086Ab0FASMP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 14:12:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43787 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647Ab0FASMO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 14:12:14 -0400
Received: by fxm8 with SMTP id 8so1221321fxm.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=5hYzxzpEGinbTqwPQkd5cTYexKYq3XMNE1VSxRryQXc=;
        b=ePxUrZr9eNi2swBLXmadWJPamPDhgu3clCJNrk6HTSYTwgzOfxC/jRCGStA9TP/cCF
         4BN8lL0fO+6u1Y0eCjlIBUhYpTMSvaiWNqSfYSuXIYmAzG5t62jz8QrG2oEeKXSkxP5C
         jAmGVUVIjWRwjvSSY0iSfjyFBz3r3j2GN9DYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=thDS61+kLpYCamAexE1Z8cG0AZKMsKG5Y+5XelLHM3AiBfRilvT6rP6r+FWkQI/Ox5
         xDZFon84wbKFTzi35it9IKeWWLu3svmwxFtZ2AI4aBuu0GHjRDKAwA+QV9vpV/QX1jVb
         /X8Bm/QcFkgd1srdPsy1ZYSrpWhBEkCLz/4Qk=
Received: by 10.223.56.27 with SMTP id w27mr7471861fag.37.1275415932332;
        Tue, 01 Jun 2010 11:12:12 -0700 (PDT)
Received: from localhost.localdomain (dslb-188-098-088-194.pools.arcor-ip.net [188.98.88.194])
        by mx.google.com with ESMTPS id r12sm48191671fah.8.2010.06.01.11.12.09
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 11:12:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.243.g01eae
In-Reply-To: <m3eigqr8hf.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148152>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Tue, Jun 1, 2010 at 17:01, Jakub Narebski <jnareb@gmail.com> wrote:
> [...]
> Could you also provide change to configure.ac, so that ./configure
> would detect if we have gettext installed or not?  Thanks in advance.

Here's a check that just checks if we have libintl.h similar to the
existing checks for libgen.h and other headers.

Do you think this be adequate?

 config.mak.in |    1 +
 configure.ac  |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 0d4b64d..a15f3c1 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -32,6 +32,7 @@ NO_CURL=3D@NO_CURL@
 NO_EXPAT=3D@NO_EXPAT@
 NO_LIBGEN_H=3D@NO_LIBGEN_H@
 HAVE_PATHS_H=3D@HAVE_PATHS_H@
+NO_GETTEXT=3D@NO_GETTEXT@
 NEEDS_LIBICONV=3D@NEEDS_LIBICONV@
 NEEDS_SOCKET=3D@NEEDS_SOCKET@
 NEEDS_RESOLV=3D@NEEDS_RESOLV@
diff --git a/configure.ac b/configure.ac
index 71038fc..7bebfd8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -730,6 +730,12 @@ AC_CHECK_HEADER([paths.h],
 [HAVE_PATHS_H=3D])
 AC_SUBST(HAVE_PATHS_H)
 #
+# Define NO_GETTEXT if you don't have libintl.h
+AC_CHECK_HEADER([libintl.h],
+[NO_GETTEXT=3D],
+[NO_GETTEXT=3DYesPlease])
+AC_SUBST(NO_GETTEXT)
+#
 # Define NO_STRCASESTR if you don't have strcasestr.
 GIT_CHECK_FUNC(strcasestr,
 [NO_STRCASESTR=3D],
--=20
1.7.1.243.g01eae
