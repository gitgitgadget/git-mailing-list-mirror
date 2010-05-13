From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/4] All is too much
Date: Thu, 13 May 2010 16:24:34 +0200
Message-ID: <cover.1273760226.git.git@drmicha.warpmail.net>
References: <20100505033536.GB8779@coredump.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 16:24:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCZL8-0006Gl-9s
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 16:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757591Ab0EMOYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 10:24:37 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40028 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756814Ab0EMOYg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 May 2010 10:24:36 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 052FAF64A1;
	Thu, 13 May 2010 10:24:35 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 13 May 2010 10:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=VTiu42zD885WPXwaBDJOnTkJHu8=; b=WqKq+W4jifpPujXWjE1u/eeY5wdDmqUXcoMmXKBX2gi0hTnbVLOXcAVfAK6u3wyfytEBJfGLojRyWoi535wWN9bs9kCs8K3X7TEMY13p/eRGJ7Ndrqk1HStznK0TrOFjB5Tgjwe09z2fg+KCysIdJ1O6LReGS5d1alb/SFYDIDk=
X-Sasl-enc: RZdMwgz7BU34DXJm9o+A2k4JtTfsss0U6DX2Mf3kWYVS 1273760674
Received: from localhost (p54859DBB.dip0.t-ipconnect.de [84.133.157.187])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2F4DD21862;
	Thu, 13 May 2010 10:24:34 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.240.geeaa4d
In-Reply-To: <20100505033536.GB8779@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147010>

This series introduces --lrbranches and --locals as abbreviations
for "HEAD --branches --remotes" (local and remote branches) resp.
"HEAD --branches --tags" (local refs).
They are becoming increasingly necessary as refs/ is growing
with auxiliary refs such as notes and replacements, so that "--all"
is too much :)

While at it, or rather: in preparation, we note rev-parse
as being deprectated as an option sifter (as discussed on list)
and clean up and complete t6018.

Michael J Gruber (4):
  rev-parse: deprecate use as an option sifter
  t6018: add tests for rev-list's --branches and --tags
  t6018: make sure all tested symbolic names are different revs
  revlist: Introduce --lrbranches and --locals revision specifiers

 Documentation/git-rev-list.txt     |    2 ++
 Documentation/git-rev-parse.txt    |   14 ++++++++++----
 Documentation/rev-list-options.txt |    8 ++++++++
 builtin/rev-list.c                 |    2 ++
 revision.c                         |   12 ++++++++++++
 t/t6018-rev-list-glob.sh           |   33 ++++++++++++++++++++++++++++++++-
 6 files changed, 66 insertions(+), 5 deletions(-)
