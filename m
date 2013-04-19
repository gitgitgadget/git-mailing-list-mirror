From: Yann Dirson <dirson@bertin.fr>
Subject: [BUG] git reflog on a tag tries to do something unexpected
Date: Fri, 19 Apr 2013 09:08:19 +0200
Organization: Bertin Technologies
Message-ID: <20130419090819.40f7c071@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 19 09:16:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT5Yx-0006DQ-3x
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 09:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756818Ab3DSHQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 03:16:47 -0400
Received: from blois.bertin.fr ([195.68.26.9]:60986 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756575Ab3DSHQq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 03:16:46 -0400
X-Greylist: delayed 507 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Apr 2013 03:16:46 EDT
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 1B9F36AB08
	for <git@vger.kernel.org>; Fri, 19 Apr 2013 09:08:18 +0200 (CEST)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id ED4736AAD9
	for <git@vger.kernel.org>; Fri, 19 Apr 2013 09:08:17 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MLH00A8ZQHTU6C0@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Fri, 19 Apr 2013 09:08:17 +0200 (CEST)
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8250-7.0.0.1014-19808.004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221748>

git reflog, when applied to a tag, should surely bail out saying there is reflog
for the requested reference.  However, instead it spits out a single line of
abbreviated sha1's of an ancestry walk:

$ git reflog --decorate v1.8.2.1
5bda18c (tag: v1.8.2.1) 6466fbb 2137ce0 (tag: v1.8.1.6) 4bbb830 0e9b327 ...


-- 
Yann Dirson - Bertin Technologies
