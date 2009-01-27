From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/6] rebase simplifications
Date: Tue, 27 Jan 2009 23:34:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901272323530.3586@pacific.mpi-cbg.de>
References: <7v7i4g31lj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 27 23:35:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRwWz-0002dI-0C
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 23:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbZA0Wd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 17:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752122AbZA0Wd6
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 17:33:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:58322 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751885AbZA0Wd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 17:33:58 -0500
Received: (qmail invoked by alias); 27 Jan 2009 22:33:56 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 27 Jan 2009 23:33:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lxx0ew7Rlj5uLi7ZtKnOa8CYo8SBpmXW2MNYq5E
	/saS5JUP2vOFkn
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v7i4g31lj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107399>

Changes vs  v1:

removed the "rnyn" blurt (which probably marsk me as Alpine user...)

removed the SHELL_PATH handling; it is a miracle to me why it works, but 
I'd rather not meddle with the magic now that you pointed it out

Moved test_commit and test_merge into test-lib.sh

Fixed the quoting in test_commit and test_merge

AFAIR that's all...

Johannes Schindelin (6):
  t3404 & t3411: undo copy&paste
  lib-rebase.sh: Document what set_fake_editor() does
  test-lib.sh: introduce test_commit() and test_merge() helpers
  Simplify t3410
  Simplify t3411
  Simplify t3412

 t/README                                  |   18 ++++
 t/lib-rebase.sh                           |   48 +++++++++++
 t/t3404-rebase-interactive.sh             |   37 +--------
 t/t3410-rebase-preserve-dropped-merges.sh |  124 ++++++++---------------------
 t/t3411-rebase-preserve-around-merges.sh  |  103 +++++-------------------
 t/t3412-rebase-root.sh                    |   28 ++-----
 t/test-lib.sh                             |   26 ++++++
 7 files changed, 159 insertions(+), 225 deletions(-)
 create mode 100644 t/lib-rebase.sh
