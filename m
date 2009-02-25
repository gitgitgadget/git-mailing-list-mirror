From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/2] Fix git submodule add for paths with ./
Date: Wed, 25 Feb 2009 12:03:38 +0100
Message-ID: <1235559820-3096-1-git-send-email-git@drmicha.warpmail.net>
References: <80055d7c0902241556s4d24285bqd171275f58bdb37d@mail.gmail.com>
Cc: Andrei Thorp <garoth@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 12:06:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcHZt-0000te-5i
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 12:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760740AbZBYLDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 06:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760703AbZBYLDw
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 06:03:52 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47071 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760386AbZBYLDv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 06:03:51 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4D4002A5F86;
	Wed, 25 Feb 2009 06:03:49 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 25 Feb 2009 06:03:49 -0500
X-Sasl-enc: JZyTnrhaOZFj/lGda6QNuvyJRbAsSHKbfYRLPgrWhItp 1235559828
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9A89D2B654;
	Wed, 25 Feb 2009 06:03:48 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc1.30.gd43c
In-Reply-To: <80055d7c0902241556s4d24285bqd171275f58bdb37d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111445>

As reported by Andrei Thorp <garoth@gmail.com>, git submodule add does
not work with paths containing './'. This series exposes the problem
with tests and fixes it. (For details see the commit messages.)

On a side note: There were no tests at all so far for git submodule add.
Now there are at least two, but there should be more, especially for
adding repos in place and such.

Michael J Gruber (2):
  git submodule: Add test cases for git submodule add
  git submodule: Fix adding of submodules at paths with ./

 git-submodule.sh           |    3 +++
 t/t7400-submodule-basic.sh |   19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)
