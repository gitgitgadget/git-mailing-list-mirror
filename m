From: Wincent Colaiuta <win@wincent.com>
Subject: Updates: teaching git-add--interactive to accept a file param
Date: Thu, 22 Nov 2007 01:02:49 +0100
Message-ID: <1195689773-28601-1-git-send-email-win@wincent.com>
References: <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com>
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 22 01:03:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuzXx-0004Wi-PG
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 01:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbXKVADY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 19:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753919AbXKVADY
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 19:03:24 -0500
Received: from wincent.com ([72.3.236.74]:56120 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753566AbXKVADX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 19:03:23 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAM02s0T030459;
	Wed, 21 Nov 2007 18:02:55 -0600
X-Mailer: git-send-email 1.5.3.6.862.g369c8
In-Reply-To: <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65717>

Here are some incremental updates incorporating the feedback received on the
patch series that I sent earlier today. These apply on top of the previous
patches; when this series matures I'll rebase and squash this down to a
smaller number of commits, but for the timebeing I think it's clearer if I
post these modifications separately so they can be reviewed in themselves.

The modifications are:

      Suppress spurious linefeeds in git-add--interactive
      Teach git-add--interactive to accept multiple file params
      Teach builtin-add to pass multiple paths to git-add--interactive
      Update git-add documentation for multiple interactive paths

Next step will be to follow-up on Junio's suggestion that we should support
directory paths, not just file paths, and replicate the semantics of
non-interactive git-add.

 Documentation/git-add.txt |    4 ++--
 builtin-add.c             |   23 +++++++++++++----------
 commit.h                  |    2 +-
 git-add--interactive.perl |    5 ++---
 4 files changed, 18 insertions(+), 16 deletions(-)
