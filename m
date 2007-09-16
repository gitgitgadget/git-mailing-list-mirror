From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: whitespace-stripping
Date: Sun, 16 Sep 2007 18:48:59 -0400
Message-ID: <11899829424040-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 00:49:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX2vP-00059K-H3
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 00:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbXIPWtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 18:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753534AbXIPWtG
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 18:49:06 -0400
Received: from mail.fieldses.org ([66.93.2.214]:48526 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432AbXIPWtF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 18:49:05 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IX2vG-00038l-EN; Sun, 16 Sep 2007 18:49:02 -0400
X-Mailer: git-send-email 1.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58359>

The following patches fix one (probably rare) bug in

        git apply --whitespace=strip

and then teach it to also complain about initial consecutive spaces that
could be tabs.

The latter is the standard for the kernel, but may not be appropriate
for other projects.  I'd like to make the whitespace code handle the
kernel style completely first, then consider configuration to handle
other styles if people complain.  But maybe the change of behavior would
be an unpleasant surprise for someone with apply.whitespace=strip and a
project that always uses spaces for indents.

--b.
