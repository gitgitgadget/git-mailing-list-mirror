From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] teaching git-add--interactive to accept a file param
Date: Wed, 21 Nov 2007 13:36:37 +0100
Message-ID: <1195648601-21736-1-git-send-email-win@wincent.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 21 13:38:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuoqB-0002zt-3G
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 13:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756541AbXKUMhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 07:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756594AbXKUMhp
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 07:37:45 -0500
Received: from wincent.com ([72.3.236.74]:54662 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756452AbXKUMho (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 07:37:44 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lALCagcj013817;
	Wed, 21 Nov 2007 06:36:43 -0600
X-Mailer: git-send-email 1.5.3.6.862.g369c8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65639>

Back in October a thread came up, "Proposed git mv behavioral change",
and I inadvertently suggested a new feature for git-add--interactive;
the ability to supply an optional file path parameter and jump straight
to the "patch" subcommand for that file:

<http://kerneltrap.org/mailarchive/git/2007/10/19/348229>

This small patch series implements that suggestion:

      Refactor patch_update_cmd
      Teach git-add--interactive to accept a file path to patch
      Teach builtin-add to pass a path argument to git-add--interactive
      Document optional file parameter to git-add--interactive

It applies against the current master. I've not yet submitted many
patches to Git, so please be gentle!
                        
Documentation/git-add.txt |    5 ++++-
builtin-add.c             |   16 ++++++++++------
commit.h                  |    2 +-
git-add--interactive.perl |   11 +++++++++--
4 files changed, 24 insertions(+), 10 deletions(-)
