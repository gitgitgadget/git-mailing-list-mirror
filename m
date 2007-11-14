X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] user-manual.txt: fix a few mistakes
Date: Wed, 14 Nov 2007 11:42:03 -0800
Message-ID: <7v8x50hawk.fsf@gitster.siamese.dyndns.org>
References: <87bq9x7w4d.fsf@osv.gnss.ru> <20071114181858.GH14254@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 14 Nov 2007 19:42:58 +0000 (UTC)
Cc: Sergei Organov <osv@javad.com>, git@vger.kernel.org,
	gitster@pobox.com
To: "J. Bruce Fields" <bfields@fieldses.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
In-Reply-To: <20071114181858.GH14254@fieldses.org> (J. Bruce Fields's message
	of "Wed, 14 Nov 2007 13:18:58 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1IsO8b-0000gB-OM for gcvg-git-2@gmane.org; Wed, 14 Nov 2007
 20:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753174AbXKNTmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2007
 14:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753258AbXKNTmQ
 (ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 14:42:16 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:38706 "EHLO
 sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1751978AbXKNTmP (ORCPT <rfc822;git@vger.kernel.org>); Wed, 14 Nov 2007
 14:42:15 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1]) by
 sceptre.pobox.com (Postfix) with ESMTP id 90E002FB; Wed, 14 Nov 2007 14:42:36
 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No client certificate
 requested) by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E4C6D95AEA;
 Wed, 14 Nov 2007 14:42:31 -0500 (EST)
Sender: git-owner@vger.kernel.org

"J. Bruce Fields" <bfields@fieldses.org> writes:

> I actually prefer "head" here.  On something like:
>
> 		 A--B--C
> 		/
> 	o--o--o
> 		\
> 		 o--o--o
>
>
> The term "branch" could be used to refer to the whole line of
> development consisting of A, B, and C.  The term "head", on the other
> hand, refers to either C or a ref that points to it.  We also use the
> terms "branch head" or just "branch" for that case, but I think "head"
> is more precise.
>
>> +This lists the commits reachable from the previous version of the branch.
>> +This syntax can be used with any git command that accepts a commit,
>>  not just with git log.  Some other examples:
>
> (Otherwise looks fine, thanks!)

Oops, I think I skipped the hunk #2 and applied hunk #3.  Will
fix-up with:

-- >8 --
From: Sergei Organov <osv@javad.com>
Subject: user-manual: minor rewording for clarity.

Junio screwed up when applying the previous round of the patch;
rewording from "previous" to "old" does make the description
clearer.

Also revert the rewording from head to branch.  The description
is talking about the branch's tip commit and using the word head
is clearer.

Based on input from Sergei and Bruce.

Signed-off-by: Junio C Hamano <gitster@pobox.com>

---
 Documentation/user-manual.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 60e1385..c7cfbbc 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1367,7 +1367,7 @@ If you make a commit that you later wish you hadn't, there are two
 fundamentally different ways to fix the problem:
 
 	1. You can create a new commit that undoes whatever was done
-	by the previous commit.  This is the correct thing if your
+	by the old commit.  This is the correct thing if your
 	mistake has already been made public.
 
 	2. You can go back and modify the old commit.  You should
@@ -1567,7 +1567,7 @@ old history using, for example,
 $ git log master@{1}
 -------------------------------------------------
 
-This lists the commits reachable from the previous version of the branch.
+This lists the commits reachable from the previous version of the head.
 This syntax can be used with any git command that accepts a commit,
 not just with git log.  Some other examples:
 
-- 
1.5.3.5.1746.g62954
