From: Ralf Baechle <ralf@linux-mips.org>
Subject: Slow fetches of tags
Date: Wed, 24 May 2006 14:10:22 +0100
Message-ID: <20060524131022.GA11449@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 24 15:11:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fit95-0004rn-GG
	for gcvg-git@gmane.org; Wed, 24 May 2006 15:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbWEXNKp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 09:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932737AbWEXNKp
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 09:10:45 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:16282 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S932736AbWEXNKp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 09:10:45 -0400
Received: from localhost.localdomain ([127.0.0.1]:2177 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133534AbWEXNKm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 15:10:42 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4ODAM33011608
	for <git@vger.kernel.org>; Wed, 24 May 2006 14:10:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4ODAMHu011607
	for git@vger.kernel.org; Wed, 24 May 2006 14:10:22 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20682>

I have a fairly large git tree (with a 320MB pack file containing some
700,000 objects).  A small fetch like

  git fetch git://www.kernel.org/pub/scm/linux/kernel/git/stable/\
       linux-2.6.16.y.git master:v2.6.16-stable

which only fetches a handful of objects (v2.6.16.17 -> v2.6.16.18) will
take on the order of 4-5 minutes.  Adding the "-n" option is will bring
the operation down to under a second, so it really is just the tags
that are slowing things down so much..

  Ralf
