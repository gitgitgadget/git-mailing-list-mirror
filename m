From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH 0/3] Fixes for OS X
Date: Mon,  5 Aug 2013 11:59:21 -0400
Message-ID: <1375718364-13824-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 05 18:00:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6NCQ-0000wg-JG
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 17:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921Ab3HEP7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 11:59:42 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:48871 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013Ab3HEP7l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 11:59:41 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id CBEE72736303; Mon,  5 Aug 2013 15:59:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-142-105-190-134.rochester.res.rr.com [142.105.190.134])
	by silverinsanity.com (Postfix) with ESMTPA id 1EEA52736194;
	Mon,  5 Aug 2013 15:59:35 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.rc1.384.g0976a17.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231666>

A few changes recently broke my build on Mac 10.8, possibly because I have a
more strict set of warnings/errors enabled.  The first two handle minor
problems with the use of APPLE_COMMON_CRYPTO, which was expanded for use in
imap-send but had a couple of problems.

The last is likely due to curl version skew between Dave Borowitz and myself.
(see 912b2ac).

There are a few notes on the patches indicating where I was less than sure
about my solutions.

Brian Gernhardt (3):
  Makefile: Fix APPLE_COMMON_CRYPTO with BLK_SHA1
  OS X: Fix redeclaration of die warning
  t5551: Remove header from curl cookie file

 Makefile              |  4 +++-
 git-compat-util.h     | 20 ++++++++++----------
 t/t5551-http-fetch.sh |  6 ++----
 3 files changed, 15 insertions(+), 15 deletions(-)

-- 
1.8.4.rc1.384.g0976a17.dirty
