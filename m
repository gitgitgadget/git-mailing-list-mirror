From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 00/11] Various msysgit patches
Date: Sun, 31 May 2009 18:15:14 +0200
Message-ID: <1243786525-4493-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 18:16:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAnhm-0001VR-RW
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 18:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757043AbZEaQQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 12:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756616AbZEaQQF
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 12:16:05 -0400
Received: from mailer.zib.de ([130.73.108.11]:58615 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853AbZEaQQE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 12:16:04 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n4VGFV5W006793;
	Sun, 31 May 2009 18:15:52 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n4VGFPV7021220;
	Sun, 31 May 2009 18:15:25 +0200 (MEST)
X-Mailer: git-send-email 1.5.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120409>

Hello,
Here are more patches that are in msysgit but not yet in official
git.git.  The patches have been discussed in the following two
threads:

    http://thread.gmane.org/gmane.comp.version-control.msysgit/5373
    http://thread.gmane.org/gmane.comp.version-control.msysgit/4876

The first couple of patches are small an obvious.  The patches with
larger numbers are more complex and might need discussion.

Best,
Steffen

Edward Z. Yang (1):
  connect.c: Support PuTTY plink and TortoisePlink as SSH on Windows

Johannes Schindelin (6):
  MinGW: GCC >= 4 does not need SNPRINTF_SIZE_CORR anymore
  Quiet make: do not leave Windows behind
  Work around a regression in Windows 7, causing erase_in_line() to
    crash sometimes
  test-chmtime: work around Windows limitation
  winansi: fix compile warnings
  Fix warnings in nedmalloc when compiling with GCC 4.4.0

Marius Storm-Olsen (2):
  MinGW readdir reimplementation to support d_type
  Add custom memory allocator to MinGW and MacOS builds

Pat Thoyts (1):
  git: browsing paths with spaces when using the start command

Steffen Prohaska (1):
  MinGW: Teach Makefile to detect msysgit and apply specific settings

 Makefile                     |   26 +-
 compat/mingw.c               |   59 +
 compat/mingw.h               |   29 +
 compat/nedmalloc/License.txt |   23 +
 compat/nedmalloc/Readme.txt  |  136 +
 compat/nedmalloc/malloc.c.h  | 5752 ++++++++++++++++++++++++++++++++++++++++++
 compat/nedmalloc/nedmalloc.c |  966 +++++++
 compat/nedmalloc/nedmalloc.h |  180 ++
 compat/snprintf.c            |    4 +
 compat/win32.h               |    1 +
 compat/winansi.c             |    3 +-
 connect.c                    |    8 +-
 git-web--browse.sh           |    5 +-
 test-chmtime.c               |    9 +
 14 files changed, 7193 insertions(+), 8 deletions(-)
 create mode 100644 compat/nedmalloc/License.txt
 create mode 100644 compat/nedmalloc/Readme.txt
 create mode 100644 compat/nedmalloc/malloc.c.h
 create mode 100644 compat/nedmalloc/nedmalloc.c
 create mode 100644 compat/nedmalloc/nedmalloc.h
