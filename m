From: Marcin =?iso-8859-2?q?Wi=B6nicki?= <mwisnicki@gmail.com>
Subject: cvsimport does not work with passwords ?
Date: Thu, 28 Apr 2011 20:59:57 +0000 (UTC)
Message-ID: <ipckgd$krd$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 23:00:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFYJw-0006fJ-SQ
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 23:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933543Ab1D1VAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 17:00:14 -0400
Received: from lo.gmane.org ([80.91.229.12]:35495 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932595Ab1D1VAN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 17:00:13 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QFYJk-0006YT-RX
	for git@vger.kernel.org; Thu, 28 Apr 2011 23:00:08 +0200
Received: from static-78-8-147-77.ssp.dialog.net.pl ([78.8.147.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 23:00:08 +0200
Received: from mwisnicki by static-78-8-147-77.ssp.dialog.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 23:00:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: static-78-8-147-77.ssp.dialog.net.pl
User-Agent: Pan/0.134 (Wait for Me; Unknown)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172406>

I have to import part of public cvs repository that is protected by 
password (which is "anoncvs"):

> export CVSROOT=:pserver:anoncvs@anoncvs.fr.FreeBSD.org:/home/ncvs
> cvs login

And now I can use cvs and cvsps, when I try git however:

> git cvsimport -vk projects/pkgtools
AuthReply: I HATE YOU

It seems that it does not send the password. From captured network 
conversation:

-> BEGIN AUTH REQUEST
-> /home/ncvs
-> anoncvs
-> A
-> END AUTH REQUEST
<- I HATE YOU

But `cat ~/.cvspass`:
/1 :pserver:anoncvs@anoncvs.fr.freebsd.org:2401/home/ncvs Ay=0=h<Z


So why is git not sending the password ?
