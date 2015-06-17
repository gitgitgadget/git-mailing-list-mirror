From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 0/2] redo fix for test-lib.sh color support
Date: Wed, 17 Jun 2015 15:06:24 -0400
Message-ID: <1434567986-23552-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 17 21:25:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Ixh-0004Rn-HG
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757572AbbFQTZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 15:25:16 -0400
Received: from smtp.bbn.com ([128.33.1.81]:54438 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757309AbbFQTZO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:25:14 -0400
X-Greylist: delayed 1121 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2015 15:25:14 EDT
Received: from socket.bbn.com ([192.1.120.102]:38868)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Z5IfQ-000PXA-3h; Wed, 17 Jun 2015 15:06:32 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id C6B7B401D5
X-Mailer: git-send-email 2.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271889>

Commit 102fc80d fixed a bug where tput was failing because it needed
to read ~/.terminfo after HOME was changed.  However, that commit is
buggy, and it unnecessarily disables color support when tput needs to
read from ~/.terminfo.

This series does two things:

  * revert the buggy fix
  * fix it properly, I hope :)

Richard Hansen (2):
  Revert "test-lib.sh: do tests for color support after changing HOME"
  test-lib.sh: fix color support when tput needs ~/.terminfo

 t/test-lib.sh | 103 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 51 insertions(+), 52 deletions(-)

-- 
2.4.3
