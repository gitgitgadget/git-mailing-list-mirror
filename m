From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/3] filter-branch --subdirectory-filter improvements
Date: Tue, 12 Aug 2008 10:45:56 +0200
Message-ID: <cover.1218529494.git.trast@student.ethz.ch>
References: <7vsktara5n.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jan Wielemaker <J.Wielemaker@uva.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 10:47:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSpWr-0002ix-O1
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 10:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbYHLIpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 04:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbYHLIpz
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 04:45:55 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:33951 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921AbYHLIpy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 04:45:54 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 10:45:53 +0200
Received: from localhost.localdomain ([129.132.149.43]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 10:45:53 +0200
X-Mailer: git-send-email 1.6.0.rc2.30.gb6bda
In-Reply-To: <7vsktara5n.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 12 Aug 2008 08:45:53.0458 (UTC) FILETIME=[D4525920:01C8FC57]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92079>

Junio C Hamano wrote:
> Anything parked in 'pu' is a fair game for replacement later, so please
> send a replacement series and tell me to drop the previous ones from 'pu'.

So let's try this one.  The first two do not depend on
--simplify-merges.

1/3 is new, and extends the --subdirectory-filter test to prove the
existence of the bug in current filter-branch.  I hope it helps
explain the issue.

2/3 is the same as before[*] modulo changing the test to expect
success again.

The third one does depend on --simplify-merges.

3/3 introduces --simplify-merges, which improves the history that
results from --subdirectory-filter.  It has absolutely nothing to do
with 2/3, except that it touches the same area of code.  (You could
s/rev-list/rev-list --simplify-merges/ in master:git-filter-branch.sh,
and get the improved history without the bugfix.)

Sorry that I dispersed the patches and v2s randomly across the thread.

- Thomas

[*] http://kerneltrap.org/mailarchive/git/2008/8/8/2867244
"[PATCH v2] filter-branch: fix ref rewriting with --subdirectory-filter"


Thomas Rast (3):
  filter-branch: Extend test to show rewriting bug
  filter-branch: fix ref rewriting with --subdirectory-filter
  filter-branch: use --simplify-merges
