From: Steffen Prohaska <prohaska@zib.de>
Subject: [REPLACEMENT PATCH 0/6] improve refspec handling in push, refactor matching in fetch
Date: Sun, 11 Nov 2007 15:01:42 +0100
Message-ID: <1194789708646-git-send-email-prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrDRd-0003eX-Ec
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 15:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbXKKOEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 09:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752349AbXKKOEt
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 09:04:49 -0500
Received: from mailer.zib.de ([130.73.108.11]:57960 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652AbXKKOEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 09:04:45 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lABE1mwM021594
	for <git@vger.kernel.org>; Sun, 11 Nov 2007 15:04:43 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lABE1mlU027967;
	Sun, 11 Nov 2007 15:01:48 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64458>

This is a replacement for sp/push-refspec. It is rebased to the current master.

 Documentation/git-push.txt      |    4 ++--
 Documentation/git-send-pack.txt |    4 +++-
 builtin-push.c                  |   11 +++++++++++
 cache.h                         |    4 ++++
 refs.c                          |   31 +++++++++++++++++++++++++++++++
 remote.c                        |   28 +++-------------------------
 sha1_name.c                     |   14 ++------------
 t/t5510-fetch.sh                |   25 +++++++++++++++++++++++++
 t/t5516-fetch-push.sh           |   29 ++++++++++++++++++++++++++++-
 transport.c                     |    8 ++++++--
 transport.h                     |    1 +
 11 files changed, 116 insertions(+), 43 deletions(-)

 [PATCH 1/6] push: mention --verbose option in documentation
    Push uses parseopts, which supports '--verbose'.

 [PATCH 2/6] push: teach push to pass --verbose option to transport layer
    Adapted to paresopts changes.

 [PATCH 3/6] push: support pushing HEAD to real branch name
    Same as before.

 [PATCH 4/6] add ref_abbrev_matches_full_with_rules()
 [PATCH 5/6] push: use same rules as git-rev-parse to resolve refspecs
 [PATCH 6/6] refactor fetch's ref matching to use ref_abbrev_matches_full_with_rules()
    Start unification of refspec matching rules.
