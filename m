From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] commit --dry-run
Date: Sat,  8 Aug 2009 00:14:50 -0700
Message-ID: <1249715693-9715-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 08 09:15:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZg8z-0003jh-F8
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 09:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbZHHHO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 03:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753880AbZHHHO6
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 03:14:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43668 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753757AbZHHHO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 03:14:58 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2736A2292
	for <git@vger.kernel.org>; Sat,  8 Aug 2009 03:14:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C0962291 for
 <git@vger.kernel.org>; Sat,  8 Aug 2009 03:14:54 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.159.gd0d612
X-Pobox-Relay-ID: 2E132770-83EB-11DE-80E3-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125247>

This is a re-roll of the commit in the jc/shortstatus series that has been
kept out of 'pu'.

First, we introduce "git commit --dry-run", which does exactly the same
thing as the current "git status".  A longer term goal of this change is
so that we could make "git status" behave completely differently after an
ample warning period.

The second commit introduces a new "git status" under a tentative name
"git stat".  In this step, it does not do anything interesting, other than
that it ignores the path parameters.

The third commit adds "-s" option to the new command, to give the "short"
output format.

Probably the next round should insert a commit between the second one and
the third one to take pathspec parameters that are used as path limiters,
but I am too tired for doing that myself tonight.

Junio C Hamano (3):
  commit: --dry-run
  git stat: the beginning
  git stat -s: short status output

 Documentation/git-commit.txt |    7 ++-
 Makefile                     |    1 +
 builtin-commit.c             |  163 ++++++++++++++++++++++++++++++++++++------
 builtin.h                    |    1 +
 git.c                        |    1 +
 wt-status.c                  |   24 ++++---
 wt-status.h                  |    1 +
 7 files changed, 165 insertions(+), 33 deletions(-)
