X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 1/2] Generate shorter patch names
Date: Tue, 07 Nov 2006 07:59:26 +0100
Message-ID: <20061107065925.10728.85759.stgit@localhost>
References: <20061107065710.10728.85618.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=fixed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 7 Nov 2006 06:59:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061107065710.10728.85618.stgit@localhost>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31046>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhKvl-00061P-VY for gcvg-git@gmane.org; Tue, 07 Nov
 2006 07:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753200AbWKGG7a convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006 01:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753237AbWKGG7a
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 01:59:30 -0500
Received: from mxfep03.bredband.com ([195.54.107.76]:21995 "EHLO
 mxfep03.bredband.com") by vger.kernel.org with ESMTP id S1753200AbWKGG7a
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 01:59:30 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82]) by
 mxfep03.bredband.com with ESMTP id
 <20061107065928.MWUF25623.mxfep03.bredband.com@ironport.bredband.com> for
 <git@vger.kernel.org>; Tue, 7 Nov 2006 07:59:28 +0100
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO
 yoghurt.hemma.treskal.com) ([83.227.180.148]) by ironport.bredband.com with
 ESMTP; 07 Nov 2006 07:59:28 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
 yoghurt.hemma.treskal.com (Postfix) with ESMTP id 07A254C04D; Tue,  7 Nov
 2006 07:59:26 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

Not all commits are blessed with a really short first-line summary in
their commit messages. This means that we shouldn't blindly take the
entire first line of the comment, since that sometimes results in
truly spectacular patch names.

I chose 30 characters as a reasonable value, considering that we don't
yet have any tab-completion on patch names. There's probably not much
point in making it configurable.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/commands/common.py |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 88b1b94..0e1bb44 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -286,10 +286,10 @@ def name_email_date(address):
=20
 def make_patch_name(msg):
     """Return a string to be used as a patch name. This is generated
-    from the top line of the string passed as argument.
-    """
+    from the first 30 characters of the top line of the string passed
+    as argument."""
     if not msg:
         return None
=20
-    subject_line =3D msg.lstrip().split('\n', 1)[0].lower()
+    subject_line =3D msg[:30].lstrip().split('\n', 1)[0].lower()
