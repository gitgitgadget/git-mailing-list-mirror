From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/8] Updated git-gc --auto series.
Date: Mon, 17 Sep 2007 01:27:05 -0700
Message-ID: <1190017633436-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 11:43:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXD8Z-0006vM-RZ
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 11:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbXIQJnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 05:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753822AbXIQJnF
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 05:43:05 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42683 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbXIQJnD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 05:43:03 -0400
X-Greylist: delayed 4537 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2007 05:42:51 EDT
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070917082713.EIS29193.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>
          for <git@vger.kernel.org>; Mon, 17 Sep 2007 04:27:13 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id pLTD1X00S1gtr5g0000000; Mon, 17 Sep 2007 04:27:14 -0400
X-Mailer: git-send-email 1.5.3.1.967.g6bb01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58419>

An updated series of "git-gc --auto", on top of 'next',
consisting of 8 patches, will follow this message.

Differences from the previous round are:

 - Earlier if you have too many unreachable loose objects,
   automated gc would have tried to "repack -d -l" which would
   not improve the situation at all every time it was run.  It
   now at least warns upon such a situation;

 - pack-objects learned --keep-unreachable option which helps
   "repack -a -d" not to lose packed but unreachable objects
   while repacking existing packs into a new pack;

 - repack learned -A option which is similar to -a but gives
   --keep-unreachable to underlying pack-objects;

 - "git-gc --auto" runs "git-repack -A -d -l" when there are too
   many packs in the repository;

 - These changes are documented ;-)
