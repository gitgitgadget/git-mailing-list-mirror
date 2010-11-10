From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/5] Handling of rfc1991 signatures
Date: Wed, 10 Nov 2010 12:17:25 +0100
Message-ID: <cover.1289387142.git.git@drmicha.warpmail.net>
References: <cover.1289041051.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 10 12:19:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG8i8-0004yp-Oo
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 12:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397Ab0KJLTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 06:19:22 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:40869 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754088Ab0KJLTW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Nov 2010 06:19:22 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 80D82963;
	Wed, 10 Nov 2010 06:19:21 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 10 Nov 2010 06:19:21 -0500
X-Sasl-enc: pY7xPXs/6gS2laJuO6NOWb63ov2AisfSC8V1O7LHs6lm 1289387961
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 02F35404155;
	Wed, 10 Nov 2010 06:19:20 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.193.g78bbb
In-Reply-To: <cover.1289041051.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161142>

This mini-series fixes the handling of signed tags for users
with "rfc1991" in their gpg config. In fact, the refactoring
done in the middle three patches would be worthwhile even
without the side effect of having to fix the handling in
one place only rather than three...

v2 has these changes:
* additional tests for dealing with rfc1991 sigs without the rfc1991 option set (1/5)
* macros in tag.c rather than tag.h since they are used only in tag.c (2/5)
* logical && at eol for continued logical expression in C (5/5)

Michael J Gruber (5):
  t/t7004-tag: test handling of rfc1991 signatures
  verify-tag: factor out signature detection
  tag: factor out sig detection for body edits
  tag: factor out sig detection for tag display
  tag: recognize rfc1991 signatures

 builtin/tag.c        |   16 +++---------
 builtin/verify-tag.c |   10 +------
 t/t7004-tag.sh       |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tag.c                |   15 +++++++++++
 tag.h                |    1 +
 5 files changed, 88 insertions(+), 20 deletions(-)

-- 
1.7.3.2.193.g78bbb
