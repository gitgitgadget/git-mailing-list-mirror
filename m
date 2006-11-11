X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 2/3] Don't mention deprecated template variables
Date: Sun, 12 Nov 2006 00:31:06 +0100
Message-ID: <20061111233106.17760.23118.stgit@localhost>
References: <20061111232322.17760.26214.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 11 Nov 2006 23:31:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061111232322.17760.26214.stgit@localhost>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31250>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gj2Jo-0006qf-5X for gcvg-git@gmane.org; Sun, 12 Nov
 2006 00:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947325AbWKKXbT convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006 18:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947327AbWKKXbT
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 18:31:19 -0500
Received: from mxfep04.bredband.com ([195.54.107.79]:2284 "EHLO
 mxfep04.bredband.com") by vger.kernel.org with ESMTP id S1947325AbWKKXbS
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 18:31:18 -0500
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84]) by
 mxfep04.bredband.com with ESMTP id
 <20061111233116.CMZV15709.mxfep04.bredband.com@ironport2.bredband.com> for
 <git@vger.kernel.org>; Sun, 12 Nov 2006 00:31:16 +0100
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO
 yoghurt.hemma.treskal.com) ([83.227.180.148]) by ironport2.bredband.com with
 ESMTP; 12 Nov 2006 00:31:16 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
 yoghurt.hemma.treskal.com (Postfix) with ESMTP id 8275A4C04D; Sun, 12 Nov
 2006 00:31:16 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

%(endofheaders)s and %(date)s are deprecated and expand to the empty
string, so don't mention them in the help text.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/commands/mail.py |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 78abfa4..d4fc293 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -52,19 +52,14 @@ SMTP authentication is also possible wit
 '--smtp-password' options, also available as configuration settings:
 'smtpuser' and 'smtppassword'.
=20
-The template e-mail headers and body must be separated by
-'%(endofheaders)s' variable, which is replaced by StGIT with
-additional headers and a blank line. The patch e-mail template accepts
-the following variables:
+The patch e-mail template accepts the following variables:
=20
   %(patch)s        - patch name
   %(maintainer)s   - 'authname <authemail>' as read from the config fi=
le
   %(shortdescr)s   - the first line of the patch description
   %(longdescr)s    - the rest of the patch description, after the firs=
t line
-  %(endofheaders)s - delimiter between e-mail headers and body
   %(diff)s         - unified diff of the patch
   %(diffstat)s     - diff statistics
-  %(date)s         - current date/time
   %(version)s      - ' version' string passed on the command line (or =
empty)
   %(prefix)s       - 'prefix ' string passed on the command line
   %(patchnr)s      - patch number
@@ -76,9 +71,9 @@ the following variables:
   %(commname)s     - committer's name
   %(commemail)s    - committer's e-mail
=20
-For the preamble e-mail template, only the %(maintainer)s, %(date)s,
-%(endofheaders)s, %(version)s, %(patchnr)s, %(totalnr)s and %(number)s
-variables are supported."""
+For the preamble e-mail template, only the %(maintainer)s,
+%(version)s, %(patchnr)s, %(totalnr)s and %(number)s variables are
+supported."""
=20
 options =3D [make_option('-a', '--all',
