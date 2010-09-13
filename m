From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH] t7003: Use test_commit instead of custom function
Date: Mon, 13 Sep 2010 00:14:25 -0400
Message-ID: <214E9A5B-E9CE-4B98-88EC-744DBE1F3C32@gernhardtsoftware.com>
References: <1284156396-81023-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 06:14:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov0RD-0005wn-7R
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 06:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208Ab0IMEOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 00:14:33 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:48526 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab0IMEOd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 00:14:33 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id BC31C1FFC54B; Mon, 13 Sep 2010 04:14:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id EF3F01FFC545;
	Mon, 13 Sep 2010 04:14:17 +0000 (UTC)
In-Reply-To: <1284156396-81023-1-git-send-email-brian@gernhardtsoftware.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156068>


On Sep 10, 2010, at 6:06 PM, Brian Gernhardt wrote:

> Not only is this unneeded code duplication, it also was something
> simply waiting to fail on case-insensitive file systems.  So replace
> all uses of make_commit with test_commit.

To be more specific: this causes a failure in next on case-insensitive HFS+.  The commit that finally triggered the problem is 7ec344d: "filter-branch: retire --remap-to-ancestor", by using `git reset --hard A` which got confused on if 'A' was 'refs/branches/A' or './a'

However, the patch applies to master or maint.

~~ Brian