From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/4] Allow different time commands
Date: Tue, 16 Oct 2012 13:39:43 +0200
Message-ID: <cover.1350387132.git.git@drmicha.warpmail.net>
References: <k5gq60$q8c$1@ger.gmane.org>
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 13:40:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO5VN-00049d-GP
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 13:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530Ab2JPLjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 07:39:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57924 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754499Ab2JPLjv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 07:39:51 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4BA82208FD;
	Tue, 16 Oct 2012 07:39:49 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 16 Oct 2012 07:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=r73V18xWCGY5O51n85BGOtuBq
	jk=; b=ff7G/RZIHrggSfPi1wsTu0eBFMnwN/1DYAxMmm7G1FmY+yj2GnBCLZ+lW
	itVG17HznY1M+an6+Q9djXzqYktOgZ0DSAx2FxrwkT+w9RIOMHuHuh5V5lvDQuZX
	IHodEZC+vcuTYHL0hmaExr7n1Y1cMdf7g1v6oPe40n+sM2oTsg=
X-Sasl-enc: sbngneRNv17/K6EoclkxhKvs0Ew9oz8HaZWUXh8XwXZD 1350387588
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id D081F4827C7;
	Tue, 16 Oct 2012 07:39:48 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc2.304.g9f3ac5c
In-Reply-To: <k5gq60$q8c$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207820>

This mini series enables the use of the lazy prereq framework for tests
which need a (non-builtin) time command.

1/4 is a bugfix
2/4 allows lazy prereq test scripts to set variables for later use
3/4 implements the prereq
4/4 uses it

This should solve the problem reported by Joachim Schmitz.

3/4 could be done in various different ways, see the comments there.

Michael J Gruber (4):
  t3419-rebase-patch-id: heed USR_BIN_TIME prereq
  test-lib: allow variable export from lazy prereq tests
  test-lib: provide lazy TIME_COMMAND prereq
  t3302,t3419: use the TIME_COMMAND prereq

 t/t3302-notes-index-expensive.sh | 5 ++---
 t/t3419-rebase-patch-id.sh       | 7 +++----
 t/test-lib-functions.sh          | 6 ++++--
 t/test-lib.sh                    | 7 +++++++
 4 files changed, 16 insertions(+), 9 deletions(-)

-- 
1.8.0.rc2.304.g9f3ac5c
