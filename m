From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH 0/2] Argument order shouldn't matter
Date: Wed, 11 Jan 2006 20:42:58 +0000 (UTC)
Message-ID: <20060111204236.0D7E15BEBD@nox.op5.se>
X-From: git-owner@vger.kernel.org Wed Jan 11 21:42:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewmnp-0007qA-4E
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 21:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWAKUmh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 15:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWAKUmh
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 15:42:37 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:48288 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964839AbWAKUmh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 15:42:37 -0500
Received: from nox.op5.se (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 36E636BD03
	for <git@vger.kernel.org>; Wed, 11 Jan 2006 21:42:36 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 0D7E15BEBD; Wed, 11 Jan 2006 21:42:36 +0100 (CET)
Date: 1137012155 +0100
To: undisclosed-recipients:;
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14515>

Many of the C-programs in the git suite are sensitive to argument
ordering. That's a bit backwards for a modern tool-kit.

The first of these two patches provides some simple library code
to handle arbitrary pointers in a stack-like manner, although in
addition to stack_push() and stack_pop(), with their obvious meanings,
there's also stack_pull() which fetches from the bottom of the stack.
Err... that is, it fetches the least recently pushed item first.

The second patch is just an example of its implementation so we can
get the discussions going.

--
 Makefile   |    4 ++--
 describe.c |   15 ++++++++++-----
 stack.c    |   42 ++++++++++++++++++++++++++++++++++++++++++
 stack.h    |    9 +++++++++
 4 files changed, 63 insertions(+), 7 deletions(-)
--
git version 1.1.0
