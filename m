From: Yann Dirson <dirson@bertin.fr>
Subject: [BUG] rebase should desambiguate abbreviated hashes before starting
Date: Thu, 27 Jun 2013 10:55:13 +0200
Organization: Bertin Technologies
Message-ID: <20130627105513.6bf84060@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 27 11:06:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us89O-0004SC-Jr
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 11:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687Ab3F0JFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 05:05:53 -0400
Received: from blois.bertin.fr ([195.68.26.9]:57628 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753568Ab3F0JDI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 05:03:08 -0400
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jun 2013 05:03:08 EDT
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id B618F446C
	for <git@vger.kernel.org>; Thu, 27 Jun 2013 10:54:29 +0200 (CEST)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 944114469
	for <git@vger.kernel.org>; Thu, 27 Jun 2013 10:54:29 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MP100MKKNETN6A0@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Thu, 27 Jun 2013 10:54:29 +0200 (CEST)
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.18; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8250-7.0.0.1014-19978.003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229091>

I just ran into a funny edge-case when doing a long rebase: one of
the rewritten commits got a sha1 starting with one of the abbreviated
sha1's of a commit still to be applied.

As a result, the rebase stopped with a funny-looking "short SHA1 ... was
ambiguous", which would not have occured if the shortened sha1's presented
to the user were expanded to full sha1's before starting the rebase.

-- 
Yann Dirson - Bertin Technologies
