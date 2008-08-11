From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] Add "extern" qualifier to function declarations in header files
Date: Tue, 12 Aug 2008 01:32:19 +0200
Message-ID: <1218497539-9545-1-git-send-email-s-beyer@gmx.net>
Cc: Junio C Hamano <gitster@pobox.com>, Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 01:33:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSgtE-00060g-6h
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 01:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbYHKXc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 19:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbYHKXc0
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 19:32:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:59076 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753243AbYHKXcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 19:32:25 -0400
Received: (qmail invoked by alias); 11 Aug 2008 23:32:23 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp028) with SMTP; 12 Aug 2008 01:32:23 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/05btw0oz0NQuDBNxp8p5tkHllY1iKtmoOqTEty5
	3hR8MB4Rtw+5LC
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KSgs7-0002UL-He; Tue, 12 Aug 2008 01:32:19 +0200
X-Mailer: git-send-email 1.6.0.rc2.274.ga7606
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92023>

This patch prepends "extern " to function declarations in
all header files in the root source directory.

Lines that were longer then 80 characters, are kept this way.
Declarations with more than 80 characters that were stretched
over several lines, are reindented if the indentation followed
some logic.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Hi,

Junio wrote in <7vod3zuqpv.fsf@gitster.siamese.dyndns.org>:
> > Is this a mistake that some forward declarations in header files are not
> > declared "extern"?
> 
> Yup, that looks old fashioned.

Ok, so I changed this, though I think it's not really useful because it's
really only cosmetic.  (But I needed some very simple task to bring me down
to make me go to bed now.) ;-)

The patch itself is 53kiB, so it's not inline-attached, but can be found
on
	http://pkqs.net/~sbeyer/tmp/extern.patch
or the commit can be fetched from
	git://repo.or.cz/git/sbeyer.git extern

I've grepped through *.h and it seems that no function declaration is left
without either "static inline" or "extern" now.

 attr.h            |    4 +-
 blob.h            |    6 ++--
 branch.h          |    7 +++--
 bundle.h          |   14 +++++-----
 cache-tree.h      |   18 ++++++------
 cache.h           |   50 ++++++++++++++++++------------------
 color.h           |   10 +++---
 commit.h          |   72 ++++++++++++++++++++++++++--------------------------
 diff.h            |    2 +-
 diffcore.h        |    6 ++--
 fetch-pack.h      |    2 +-
 fsck.h            |    6 ++--
 git-compat-util.h |    8 +++---
 graph.h           |   24 +++++++++---------
 list-objects.h    |    4 +-
 ll-merge.h        |   12 ++++----
 log-tree.h        |   20 +++++++-------
 mailmap.h         |    4 +-
 merge-recursive.h |   26 +++++++++---------
 object.h          |   24 +++++++++---------
 pack-refs.h       |    2 +-
 pack-revindex.h   |    2 +-
 patch-ids.h       |    8 +++---
 pkt-line.h        |    8 +++---
 progress.h        |   16 ++++++-----
 quote.h           |    4 +-
 refs.h            |    4 +-
 remote.h          |   51 ++++++++++++++++++++-----------------
 revision.h        |    2 +-
 run-command.h     |   16 ++++++------
 send-pack.h       |    6 ++--
 shortlog.h        |    6 ++--
 sideband.h        |    4 +-
 string-list.h     |   16 ++++++------
 transport.h       |   19 +++++++------
 tree-walk.h       |   12 ++++----
 tree.h            |    8 +++---
 unpack-trees.h    |   10 +++---
 utf8.h            |   12 ++++----
 walker.h          |   15 ++++++-----
 wt-status.h       |    6 ++--
 xdiff-interface.h |   14 +++++-----
 42 files changed, 284 insertions(+), 276 deletions(-)
