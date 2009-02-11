From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH 0/4] completion: Fixes and better non-work-tree support
Date: Wed, 11 Feb 2009 13:03:22 -0500
Message-ID: <1234375406-27099-1-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ted Pavlic <ted@tedpavlic.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Feb 11 19:06:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJSo-0007U8-NH
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757574AbZBKSDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757584AbZBKSDj
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:03:39 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:52775 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750945AbZBKSDi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 13:03:38 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id B81B180D808C;
	Wed, 11 Feb 2009 12:57:06 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LrKROvZR+uRp; Wed, 11 Feb 2009 12:57:06 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 97B8680D8088;
	Wed, 11 Feb 2009 12:57:06 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.390.gba743
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109462>

The first patch has already been Acked by spearce.

The second patch uses a consistent "if..." convention throughout the
completion script.

The third patch improves how the __git_ps1 works when (a) the CWD is a
git dir and (b) when the CWD has a .git but no .git/HEAD.

The fourth patch fixes unbound variable errors by replacing $__vars with
${__var-}s.

Ted Pavlic (4):
  completion: For consistency, changed "git rev-parse" to __gitdir
    calls.
  completion: Use consistent if [...] convention. No test.
  completion: Better __git_ps1 support when not in working directory
  completion: More fixes to prevent unbound variable errors.

 contrib/completion/git-completion.bash |   75 ++++++++++++++++----------------
 1 files changed, 37 insertions(+), 38 deletions(-)
