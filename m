From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] fixup! t3210: test for spurious error messages for dangling packed refs
Date: Tue, 23 Apr 2013 11:15:56 +0200
Message-ID: <1366708556-9172-1-git-send-email-mhagger@alum.mit.edu>
References: <7vehe2nr16.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 11:16:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUZKy-0005ja-5I
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 11:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756564Ab3DWJQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 05:16:21 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:49161 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756003Ab3DWJQU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Apr 2013 05:16:20 -0400
X-AuditID: 12074413-b7f226d000000902-83-517651635a06
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id DB.AA.02306.36156715; Tue, 23 Apr 2013 05:16:19 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3N9GAPQ010118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 23 Apr 2013 05:16:18 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <7vehe2nr16.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqJscWBZoMPuRlkXXlW4mi4beK8wW
	t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE74+On+4wF
	54Qr2h7LNDCe4e9i5OSQEDCR2PusnwXCFpO4cG89WxcjF4eQwGVGiU8rG1ghnDNMEt+vzgCr
	YhPQlVjU08wEYosIqElMbDsEFmcWSJF49XcXmC0sECGxavJsRhCbRUBVov3iJHYQm1fAWWJG
	wywmiG0KEse3bwOr4RQwk3j2egcriC0kYCpxadIUxgmMvAsYGVYxyiXmlObq5iZm5hSnJusW
	Jyfm5aUW6Zrr5WaW6KWmlG5ihISP8A7GXSflDjEKcDAq8fAKuJcGCrEmlhVX5h5ilORgUhLl
	LfArCxTiS8pPqcxILM6ILyrNSS0+xCjBwawkwntNCijHm5JYWZValA+TkuZgURLnVVui7ick
	kJ5YkpqdmlqQWgSTleHgUJLgTQ8AahQsSk1PrUjLzClBSDNxcIIILpANPEAbHEEKeYsLEnOL
	M9Mhik4xKkqJ8/aDJARAEhmleXADYJH+ilEc6B9hXheQKh5gkoDrfgU0mAlocGZCCcjgkkSE
	lFQDY9MvzyqumZueyv532Rx1yvaH2BnN16t43AtsDsa1bGlw+1l5LZVPYmFBJ+vq/kNBvz59
	9FunusrI9kT5/5mXMk0msYXYTkrLuHVN4d0pxULb77ePrymy0WfeNj/itYDv8t1mS793Z07V
	5r0spbI96NQ7X7FUrbmqS1bNzHFf+Dz7/b+UFSmcN5VYijMSDbWYi4oTAcbg1HjP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222139>

On 04/23/2013 12:23 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> For now I left the sleeps in t3210.  Given that the problem will be
>> solved by topic jc/prune-all, building a fancier workaround into this
>> test for the old broken --expire behavior seems like a waste of time.
>> I propose that the sleeps be removed when this patch series is merged
>> with jc/prune-all.
> 
> I wouldn't mind to queue this on top of the "prune --expire=all" topic
> at all, especially if that makes the tests easier.

OK then let's do it that way.  The prune-all branch is not risky so I
can't imagine that it will hold up my changes.

If you rebase my patches on top of jc/prune-all, then you can
autosquash this patch to remove the sleeps from

    [PATCH v2 16/33] t3210: test for spurious error messages for dangling packed refs

Let me know if you would prefer that I re-roll.

Michael

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t3210-pack-refs.sh | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 559f602..1a2080e 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -122,9 +122,8 @@ test_expect_success 'explicit pack-refs with dangling packed reference' '
 	git commit --allow-empty -m "soon to be garbage-collected" &&
 	git pack-refs --all &&
 	git reset --hard HEAD^ &&
-	sleep 1 &&
-	git reflog expire --expire=now --all &&
-	git prune --expire=now &&
+	git reflog expire --expire=all --all &&
+	git prune --expire=all &&
 	git pack-refs --all 2>result &&
 	test_cmp /dev/null result
 '
@@ -135,9 +134,8 @@ test_expect_success 'delete ref with dangling packed version' '
 	git pack-refs --all &&
 	git reset --hard HEAD^ &&
 	git checkout master &&
-	sleep 1 &&
-	git reflog expire --expire=now --all &&
-	git prune --expire=now &&
+	git reflog expire --expire=all --all &&
+	git prune --expire=all &&
 	git branch -d lamb 2>result &&
 	test_cmp /dev/null result
 '
@@ -147,9 +145,8 @@ test_expect_success 'delete ref while another dangling packed ref' '
 	git commit --allow-empty -m "future garbage" &&
 	git pack-refs --all &&
 	git reset --hard HEAD^ &&
-	sleep 1 &&
-	git reflog expire --expire=now --all &&
-	git prune --expire=now &&
+	git reflog expire --expire=all --all &&
+	git prune --expire=all &&
 	git branch -d lamb 2>result &&
 	test_cmp /dev/null result
 '
-- 
1.8.2.1
