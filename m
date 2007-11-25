From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH 0/3] Updates to git-add--interactive
Date: Sun, 25 Nov 2007 14:15:39 +0100
Message-ID: <1195996542-86074-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 25 14:16:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwHLK-0004BD-Fd
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 14:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbXKYNPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 08:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752859AbXKYNPw
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 08:15:52 -0500
Received: from wincent.com ([72.3.236.74]:36246 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110AbXKYNPv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 08:15:51 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAPDFhQS012499;
	Sun, 25 Nov 2007 07:15:45 -0600
X-Mailer: git-send-email 1.5.3.6.1994.g0a56
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65971>

Here's an updated series, this time hopefully with the braindead
parts removed.

[PATCH 1/3] Add "--patch" option to git-add--interactive

    Unchanged.

[PATCH 2/3] Move pathspec validation into interactive_add

    Braindeadness removed.

[PATCH 3/3] Rename patch_update_file function to patch_update_pathspec

    Only modified insofar as to make it apply on top of PATCH 2.

The one remaining issue is that pathspecs like "\*.h" don't work.
But from comments earlier on in this thread I had the impression
that they should.

They don't work because such pathspecs don't work for the underlying
git-diff-files implementation that's used by git-add--interactive:

git diff-files --numstat --summary -- \*.h

Is some alternative being proposed that would allow them to work?
