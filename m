From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 0/2] [RFT] git-svn: more efficient revision -> commit mapping
Date: Sat,  8 Dec 2007 23:27:40 -0800
Message-ID: <1197185262-16765-1-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 08:28:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1GaD-0002l7-Go
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 08:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbXLIH1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 02:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbXLIH1p
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 02:27:45 -0500
Received: from hand.yhbt.net ([66.150.188.102]:50847 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbXLIH1o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 02:27:44 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id B3CB37DC025;
	Sat,  8 Dec 2007 23:27:42 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 08 Dec 2007 23:27:42 -0800
X-Mailer: git-send-email 1.5.3.7.1114.g6df1d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67600>

This is very lightly tested, but describes the format I described in:

  http://article.gmane.org/gmane.comp.version-control.git/67126

  (more in the commit messages)

I'll be out of town the next few days and I'm not sure how much I'll be
able to follow up on it while I'm gone.  Please test, especially if
you're dealing with a repository where large .rev_db files are a
problem.

Junio: not intended for master just yet, but if you hear nothing but
good things about it, feel free :)

---
 git-svn.perl               |  323 ++++++++++++++++++++++++++++++--------------
 t/lib-git-svn.sh           |   26 ++++
 t/t9107-git-svn-migrate.sh |   16 ++-
 3 files changed, 258 insertions(+), 107 deletions(-)

-- 
Eric Wong
