From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] use "git init-db" in tests
Date: Thu, 8 Dec 2005 22:02:51 +0100
Message-ID: <20051208210251.GB19423@steel.home>
References: <20051208202555.GA3046@steel.home> <7vu0dje2oi.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 22:05:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkSvA-0001AS-SZ
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 22:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbVLHVDS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 16:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVLHVDS
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 16:03:18 -0500
Received: from devrace.com ([198.63.210.113]:55053 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751229AbVLHVDR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2005 16:03:17 -0500
Received: from tigra.home (p54A0D4D7.dip.t-dialin.net [84.160.212.215])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jB8L2qOH006239;
	Thu, 8 Dec 2005 15:02:53 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EkSuh-0001H7-00; Thu, 08 Dec 2005 22:02:51 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EkSuh-0005xk-6y; Thu, 08 Dec 2005 22:02:51 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0dje2oi.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13376>

Junio C Hamano, Thu, Dec 08, 2005 21:47:41 +0100:
> 
> > Unless there was a special reason to use git-init-db from $PATH, could
> > the patch below be accepted? It makes the test suite use git-init-db
> > from the "the binaries we have just built".
> 
> A few lines above what you patched we do make sure the PATH
> starts with the top of the build directory where you would find
> git-init-db we have just built, so unless I am missing something...
> 

You do miss something. glibc will happily continue lookup if
git-init-db in the top of the build directory is not executable, and
it will take the next one it finds (and people _will_ have git-init-db
in PATH).
