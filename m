From: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
Subject: [StGIT PATCH] diffcol.sh: Use /bin/bash explicitly
Date: Thu, 04 Sep 2008 00:47:17 +0900
Message-ID: <48BEB185.2080505@ruby.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com, kha@treskal.com
X-From: git-owner@vger.kernel.org Wed Sep 03 17:51:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kauay-0007A3-EP
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 17:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbYICPra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 11:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbYICPra
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 11:47:30 -0400
Received: from smtp14.dti.ne.jp ([202.216.231.189]:46126 "EHLO
	smtp14.dti.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbYICPr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 11:47:29 -0400
Received: from [192.168.1.3] (PPPa881.tokyo-ip.dti.ne.jp [210.159.215.131]) by smtp14.dti.ne.jp (3.11s) with ESMTP AUTH id m83FlHHn021537;Thu, 4 Sep 2008 00:47:20 +0900 (JST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94806>

Recent Ubuntu uses dash (Debian Almquist Shell; a lightweight POSIX-
compliant shell derived from ash) as /bin/sh by default.  In this case
pager=diffcol.sh doesn't work like this:

> skuribay@ubuntu:~/kernel/linux.git$ stg show
> /home/skuribay/share/stgit/contrib/diffcol.sh: 22: Bad substitution

this is caused by non-bash-compliant /bin/sh.

diffcol.sh is based on Quilt, and Quilt is dependent on bash; Actually
all Quilt scripts use /bin/bash without exceptions.  Then it's good for
diffcol.sh to use /bin/bash.

Signed-off-by: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
---
 contrib/diffcol.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/diffcol.sh b/contrib/diffcol.sh
index ea9109d..eecc87a 100755
--- a/contrib/diffcol.sh
+++ b/contrib/diffcol.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 
 # Code copied from Quilt (http://savannah.nongnu.org/projects/quilt)
 #
