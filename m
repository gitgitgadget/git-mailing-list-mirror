From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Makefile: enable THREADED_DELTA_SEARCH on IRIX and IRIX64
Date: Thu,  8 Oct 2009 18:07:41 -0500
Message-ID: <Zyq66vleW7YI5l2liyEIAK1O_rnknZ4_xci4KmS3Proua7JfnWyaAyyk1ww9sknBMukmwGErv7slPEl71tr1Lg@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 09 01:12:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw29f-0001wZ-Ma
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 01:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932975AbZJHXIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 19:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbZJHXIq
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 19:08:46 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41002 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932326AbZJHXIq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 19:08:46 -0400
Received: by mail.nrlssc.navy.mil id n98N7tFV023295; Thu, 8 Oct 2009 18:07:55 -0500
X-OriginalArrivalTime: 08 Oct 2009 23:07:55.0331 (UTC) FILETIME=[2B485930:01CA486C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129721>

From: Brandon Casey <drafnel@gmail.com>

Since commit dcda3614 removed the use of a variable length array from
builtin-pack-objects.c, it is now safe to compile with the threaded delta
search feature enabled.  Formerly, the MIPSpro 7.4.4m compiler warned that
variable length arrays should not be used with pthreads.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index dd3d520..c956ce9 100644
--- a/Makefile
+++ b/Makefile
@@ -846,6 +846,7 @@ ifeq ($(uname_S),IRIX)
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	SHELL_PATH = /usr/gnu/bin/bash
 	NEEDS_LIBGEN = YesPlease
+	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),IRIX64)
 	NO_SETENV=YesPlease
@@ -859,6 +860,7 @@ ifeq ($(uname_S),IRIX64)
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	SHELL_PATH=/usr/gnu/bin/bash
 	NEEDS_LIBGEN = YesPlease
+	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),HP-UX)
 	NO_IPV6=YesPlease
-- 
1.6.5.rc2.17.gdbc1b
