From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/6] Simplifications of some 'rebase' tests
Date: Tue, 27 Jan 2009 18:45:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901271844340.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901271012550.14855@racer> <20090127085418.e113ad5a.stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephen Haberman <stephen@exigencecorp.com>,
	Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 27 18:46:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRs11-0007YL-Lo
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 18:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133AbZA0Ro5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 12:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754952AbZA0Ro5
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 12:44:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:41202 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754813AbZA0Ro4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 12:44:56 -0500
Received: (qmail invoked by alias); 27 Jan 2009 17:44:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 27 Jan 2009 18:44:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18y3WYGuIoyyeRawQ6hivTx9twdbYsa4Ugtq3DvT2
	FsITitG3S5/SW/
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090127085418.e113ad5a.stephen@exigencecorp.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107365>


While working on the rebase revamp, I had to fix a few tests (the design
bug I described earlier, and fallout from the new "goto" and "merge"
functions).

These are just the cleanups, they should not change any functionality,
but make everything more readable by providing simple test_commit() and
test_merge() wrappers.

Note: the test_commit() and test_merge() wrappers might be generic enough
to put them into test-lib.sh for a wider audience.

Johannes Schindelin (6):
  t3404 & t3411: undo copy&paste
  lib-rebase.sh: Document what set_fake_editor() does
  lib-rebase.sh: introduce test_commit() and test_merge() helpers
  Simplify t3410
  Simplify t3411
  Simplify t3412

 t/lib-rebase.sh                           |   74 +++++++++++++++++
 t/t3404-rebase-interactive.sh             |   37 +--------
 t/t3410-rebase-preserve-dropped-merges.sh |  126 +++++++++--------------------
 t/t3411-rebase-preserve-around-merges.sh  |  103 +++++-------------------
 t/t3412-rebase-root.sh                    |   30 ++-----
 5 files changed, 145 insertions(+), 225 deletions(-)
 create mode 100644 t/lib-rebase.sh
