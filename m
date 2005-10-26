From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git 565ebbf79f61873042c22a7126d002c104e056f4 broken on OpenBSD
Date: Wed, 26 Oct 2005 17:26:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510261725150.8507@wbgn013.biozentrum.uni-wuerzburg.de>
References: <86y84gfjv4.fsf@blue.stonehenge.com> <86u0f4fjah.fsf@blue.stonehenge.com>
 <Pine.LNX.4.63.0510261708280.2803@wbgn013.biozentrum.uni-wuerzburg.de>
 <86mzkwfh54.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 17:29:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUnAY-0003VZ-2J
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 17:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVJZP0X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 11:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVJZP0X
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 11:26:23 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:9354 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964787AbVJZP0W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 11:26:22 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 64B8413EFF3; Wed, 26 Oct 2005 17:26:21 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 427E7B353E; Wed, 26 Oct 2005 17:26:21 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 280EEB351B; Wed, 26 Oct 2005 17:26:21 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 94FA513EFF3; Wed, 26 Oct 2005 17:26:20 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86mzkwfh54.fsf@blue.stonehenge.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10673>

Hi,

On Wed, 26 Oct 2005, Randal L. Schwartz wrote:

> >>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> Johannes> What does your man page for link() say? If it is not 
> Johannes> supported, what value will be in errno?
> 
> EOPNOTSUPP

How about this, then:

---

Subject: [PATCH] Support EOPNOTSUPP of OpenBSD

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

applies-to: 01ba9ea9d9dfba5ae94c32691ac8d9fdd859fccf
eaebda7362215aa0c7349e9971848c0535782a40
diff --git a/Makefile b/Makefile
index 4877abb..5cb7194 100644
--- a/Makefile
+++ b/Makefile
@@ -211,6 +211,7 @@ ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	PLATFORM_DEFINES += -I/usr/local/include -L/usr/local/lib
+	PLATFORM_DEFINES += -DENOTSUP=EOPNOTSUPP
 endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
---
0.99.8.GIT
