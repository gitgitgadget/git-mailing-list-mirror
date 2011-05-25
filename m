From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: t7810.94 (git-grep -E -F -G) never passed
Date: Tue, 24 May 2011 23:27:59 -0400
Message-ID: <BE19630B-8E48-4CA8-B956-A4DC767BFFDD@gernhardtsoftware.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 05:28:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP4lU-0003TG-H0
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 05:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360Ab1EYD2C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 23:28:02 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:38665 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235Ab1EYD2C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2011 23:28:02 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 316BF1FFC146; Wed, 25 May 2011 03:27:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id C263F1FFC135
	for <git@vger.kernel.org>; Wed, 25 May 2011 03:27:49 +0000 (UTC)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174370>

I'm not sure why it's supposed to pass, actually.  -G makes the pattern be a basic regex and basic regexen don't recognize the + repetition operator.

expecting success: 
	echo ab:aab >expected &&
	git grep -E -F -G a\\+b >actual &&
	test_cmp expected actual

--- expected	2011-05-25 03:19:05.000000000 +0000
+++ actual	2011-05-25 03:19:05.000000000 +0000
@@ -1 +1 @@
-ab:aab
+ab:a+b
not ok - 94 grep -E -F -G pattern

~~ Brian G