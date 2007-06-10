From: Johan Herland <johan@herland.net>
Subject: [PATCH 0/4] Restructure the tag object
Date: Sun, 10 Jun 2007 13:47:56 +0200
Message-ID: <200706101347.57023.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <Pine.LNX.4.64.0706100741310.4059@racer.site>
 <7vwsyc8bt3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 13:48:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxLts-0003on-Dx
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 13:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbXFJLsD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 07:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbXFJLsB
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 07:48:01 -0400
Received: from smtp.getmail.no ([84.208.20.33]:51769 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162AbXFJLsA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 07:48:00 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJF008014RZJZ00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 13:47:59 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF009WF4RX1490@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 13:47:57 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJF001AN4RX0R90@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 13:47:57 +0200 (CEST)
In-reply-to: <7vwsyc8bt3.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49712>

Ok, I'm pulling the 21-part patch series from hell. It's just not worth all
the flak. Here's a 4-part patch series that tries to do the changes needed
without all the crap^Wrefactoring.

Obviously this patch series does none of the much needed cleanup in this
part of the code (e.g. better error messages, specifying encodings of header
fields, possibly unifying the common parts between the parser and the
verifier). I'll leave that cleanup to someone who writes less crappy code.

Here's the shortlog for the series:

Johan Herland (4):
      Make tag names (i.e. the tag object's "tag" line) optional
      Introduce optional "keywords" on tag objects
      Documentation/git-mktag: Document the changes in tag object structure
      git-mktag tests: Expand on mktag selftests according to the new tag object structure

 Documentation/git-mktag.txt |   38 +++++++---
 mktag.c                     |   65 +++++++++++-----
 t/t3800-mktag.sh            |  172 ++++++++++++++++++++++++++++++++++++++++---
 tag.c                       |   44 +++++++++--
 tag.h                       |    3 +-
 5 files changed, 270 insertions(+), 52 deletions(-)


...Johan
