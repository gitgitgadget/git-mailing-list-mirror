From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 0/5] add "--keep" option to "git reset"
Date: Tue, 19 Jan 2010 05:25:56 +0100
Message-ID: <20100119042404.4510.48855.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Daniel Convissor <danielc@analysisandsolutions.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 05:24:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX5dl-0006y9-NK
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 05:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862Ab0ASEYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 23:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822Ab0ASEYT
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 23:24:19 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53615 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752238Ab0ASEYP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 23:24:15 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 7B653818034;
	Tue, 19 Jan 2010 05:23:57 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DF56381801B;
	Tue, 19 Jan 2010 05:23:53 +0100 (CET)
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137418>

Changes since the previous series are the following:

- removed parts of the commit message that contrasted "--keep" with "--merge"
- improved wording in the documentation
- added a new patch to disallow "--keep" when there are unmerged entries
- added some tests for --keep in t7111-reset-table.sh

Christian Couder (5):
  reset: add option "--keep" to "git reset"
  reset: add test cases for "--keep" option
  Documentation: reset: describe new "--keep" option
  reset: disallow "reset --keep" outside a work tree
  reset: disallow using --keep when there are unmerged entries

 Documentation/git-reset.txt |   48 +++++++++++++++++-
 builtin-reset.c             |   46 ++++++++++++++---
 t/t7103-reset-bare.sh       |   25 ++++++---
 t/t7110-reset-merge.sh      |  116 ++++++++++++++++++++++++++++++++++++++++++-
 t/t7111-reset-table.sh      |    8 +++
 5 files changed, 223 insertions(+), 20 deletions(-)
