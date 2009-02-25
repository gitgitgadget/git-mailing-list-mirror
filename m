From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/4] Fix git submodule add for funky paths
Date: Wed, 25 Feb 2009 14:26:28 +0100
Message-ID: <1235568392-19705-1-git-send-email-git@drmicha.warpmail.net>
References: <49A541D3.4030001@viscovery.net>
Cc: Andrei Thorp <garoth@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 14:28:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcJo5-0001ls-FS
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 14:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530AbZBYN0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 08:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756046AbZBYN0n
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 08:26:43 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56336 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755793AbZBYN0n (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 08:26:43 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 290982A62E6;
	Wed, 25 Feb 2009 08:26:41 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 25 Feb 2009 08:26:41 -0500
X-Sasl-enc: LTN5iHN6TIz+sE1LzP0oZm/RmOEVZDZEryD7Clx0YbyE 1235568400
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7E46012B06;
	Wed, 25 Feb 2009 08:26:40 -0500 (EST)
X-Mailer: git-send-email 1.6.2.rc1.30.gd43c
In-Reply-To: <49A541D3.4030001@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111452>

As reported by Andrei Thorp <garoth@gmail.com>, git submodule add does
not work with paths containing './'. This series exposes the problem
with tests and fixes it. (For details see the commit messages.)

On a side note: There were no tests at all so far for git submodule add.
Now there are at least two, but there should be more, especially for
adding repos in place and such.

v2 adds 2 more tests for paths with // and /.. and helps g sm add pass the tests.

Michael J Gruber (4):
  git submodule: Add test cases for git submodule add
  git submodule: Fix adding of submodules at paths with ./
  git submodule: Add more tests for add with funky paths
  git submodule: Fix handling of // and /.. in paths for added
    submodules

 git-submodule.sh           |    9 +++++++++
 t/t7400-submodule-basic.sh |   29 +++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)
