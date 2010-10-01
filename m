From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/2] Testcase for a rebase-autosquash bug
Date: Fri,  1 Oct 2010 23:19:18 +0200
Message-ID: <1285967960-17691-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 01 23:10:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1mry-0003dV-85
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 23:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475Ab0JAVJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 17:09:50 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:47262 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767Ab0JAVJt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 17:09:49 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id B8AC6D48002;
	Fri,  1 Oct 2010 23:09:43 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P1n0n-0004cR-O6; Fri, 01 Oct 2010 23:19:25 +0200
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157784>

While using --autosquash with a "fixup" commit intended to fixup one
of its descendants, I noticed it just did not work, so here is a
testcase for the failure.

While I was at it, it looked to me like a couple of "&&" were missing.
We surely want commit failures to fail at those places - although
failures there would probably induce failures later on which would be
detected, it is always better to fail early.

Yann Dirson (2):
  t/t3415: use && where applicable.
  rebase-autosquash: add testcase for fixup occuring before its fixed
    commit.

 t/t3415-rebase-autosquash.sh |   31 ++++++++++++++++++++++++++++---
 1 files changed, 28 insertions(+), 3 deletions(-)

-- 
1.7.2.3
