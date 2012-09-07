From: Yann Dirson <dirson@bertin.fr>
Subject: [BUG?] git rebase not accepting :/ syntax
Date: Fri, 07 Sep 2012 15:08:03 +0200
Organization: Bertin Technologies
Message-ID: <20120907150803.0ae2b186@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 15:37:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9yku-00017r-32
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 15:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758579Ab2IGNhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 09:37:47 -0400
Received: from cabourg.bertin.fr ([195.68.26.10]:63336 "EHLO cabourg.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754152Ab2IGNhq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 09:37:46 -0400
X-Greylist: delayed 1781 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Sep 2012 09:37:45 EDT
Received: from cabourg.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 42408A0FD2
	for <git@vger.kernel.org>; Fri,  7 Sep 2012 15:08:02 +0200 (CEST)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by cabourg.bertin.fr (Postfix) with ESMTP id 1C400A0FCC
	for <git@vger.kernel.org>; Fri,  7 Sep 2012 15:08:02 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0M9Z00E33DTD5190@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Fri, 07 Sep 2012 15:08:02 +0200 (CEST)
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.8.0.1017-19168.007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204967>

In 1.7.10.3, "git rebase -i :/Merge" will complain with:

fatal: Needed a single revision
invalid upstream :/Merge

... whereas "git rev-parse :/Merge" has no problem resolving
to a single revision.  OTOH, "git rebase -i HEAD^{/Merge}" does
work, and rev-parse resolves it to the same commit.

Is that due in some way to the semantic differences between the two
revspecs, or is that just a bug ?
-- 
Yann Dirson - Bertin Technologies
