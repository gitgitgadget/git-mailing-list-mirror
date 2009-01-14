From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH v2 0/3] Add test cases for "git mv -k" and fix a known breakage.
Date: Wed, 14 Jan 2009 18:03:20 +0100
Message-ID: <1231952603-32527-1-git-send-email-git@drmicha.warpmail.net>
References: <alpine.DEB.1.00.0901141653540.3586@pacific.mpi-cbg.de>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 18:06:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN9Ax-0006nq-Hz
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 18:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763432AbZANRDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 12:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761163AbZANRDk
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 12:03:40 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60387 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757289AbZANRDk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 12:03:40 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id EA335210F11;
	Wed, 14 Jan 2009 12:03:38 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 14 Jan 2009 12:03:38 -0500
X-Sasl-enc: O7vlsADtouCxP49k+i1nvXPcTypoLqpA24w7CsXLeElj 1231952618
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 51C3F2B7D2;
	Wed, 14 Jan 2009 12:03:38 -0500 (EST)
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <alpine.DEB.1.00.0901141653540.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105661>

This adds test cases for the "-k" option of "git mv", including one
known breakage reported by Matthieu Moy <Matthieu.Moy@imag.fr> which
appears when multiple untracked files are specified as consecutive
arguments. This breakage is fixed in the second patch and marked
"expect_pass" in the last one.

The cumulative code/other ratio is 1 line/27 lines which I blame solely
on Dscho ;) Seriously, feel free to squash. But on the other hand: How
else can I see the beautiful "1 known breakage fixed" other than by
having 2 and 3 separate in this series...

The patch is off master but builtin-mv.c hasn't changed since 
81dc2307d0ad87a4da2e753a9d1b5586d6456eed tags/v1.6.0-rc1~1, so I suggest
this patch for maint.

Michael J Gruber (3):
  add test cases for "git mv -k"
  fix handling of multiple untracked files for git mv -k
  mark fixed breakage as expect pass for "git mv -k" multiple files

 builtin-mv.c  |    1 +
 t/t7001-mv.sh |   25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)
