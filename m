From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Makefile: set SHELL to value of SHELL_PATH
Date: Thu, 07 Aug 2008 14:03:42 -0500
Message-ID: <BUkcoxp99ASidQD8sGQ9PR7w1MT6DXx-6v_djYMHRBKTs_wNXEO3hw@cipher.nrlssc.navy.mil>
References: <alpine.DEB.1.00.0808060208450.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 07 21:06:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRAo5-0004QJ-4T
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 21:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbYHGTEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 15:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755580AbYHGTEF
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 15:04:05 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44625 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbYHGTED (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 15:04:03 -0400
Received: by mail.nrlssc.navy.mil id m77J3hWZ021180; Thu, 7 Aug 2008 14:03:43 -0500
In-Reply-To: <alpine.DEB.1.00.0808060208450.9611@pacific.mpi-cbg.de.mpi-cbg.de>
X-OriginalArrivalTime: 07 Aug 2008 19:03:43.0484 (UTC) FILETIME=[4FB6ABC0:01C8F8C0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91598>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 5 Aug 2008, Brandon Casey wrote:
> 
>> Otherwise, should we set the SHELL variable to the configured SHELL_PATH 
>> at some point in the Makefile?
> 
> I think that would make more sense, especially since it would catch 
> wrong SHELL_PATH early.

You're right, this makes more sense.

-brandon


 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 52c67c1..61fc86d 100644
--- a/Makefile
+++ b/Makefile
@@ -1060,6 +1060,8 @@ export TAR INSTALL DESTDIR SHELL_PATH
 
 ### Build rules
 
+SHELL = $(SHELL_PATH)
+
 all:: $(ALL_PROGRAMS) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
 ifneq (,$X)
 	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), $(RM) '$p';)
-- 
1.5.6.2
