From: Brad King <brad.king@kitware.com>
Subject: [PATCH 0/2] submodule add + autocrlf + safecrlf
Date: Wed, 20 Jun 2012 10:43:31 -0400
Message-ID: <cover.1340202515.git.brad.king@kitware.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 16:58:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShMMw-00016u-13
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 16:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756696Ab2FTO6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 10:58:49 -0400
Received: from 66-194-253-20.static.twtelecom.net ([66.194.253.20]:57644 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756603Ab2FTO6t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 10:58:49 -0400
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 82BE014C2; Wed, 20 Jun 2012 10:43:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200300>

Hi Folks,

When 'git submodule add' uses 'git config' to create a
'.gitmodules' file it gets LF newlines that the subsequent
'git add --force .gitmodules' rejects if autocrlf and
safecrlf are both enabled.  This series adds a test and
proposes a fix that simply uses '-c core.safecrlf=false'
to disable safecrlf when adding '.gitmodules'.

I'm not excited by allowing a LF file in work tree that
has clearly been configured to prefer CRLF, but avoiding
that for .gitmodules is probably a separate issue.

-Brad

Brad King (2):
  submodule: Demonstrate failure to add with auto/safecrlf
  submodule: Tolerate auto/safecrlf when adding .gitmodules

 git-submodule.sh           |    2 +-
 t/t7400-submodule-basic.sh |   13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
1.7.10
