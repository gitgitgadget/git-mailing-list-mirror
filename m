Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B7DC20986
	for <e@80x24.org>; Sat,  1 Oct 2016 16:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750853AbcJAQUD (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Oct 2016 12:20:03 -0400
Received: from mout.web.de ([212.227.17.12]:52513 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbcJAQUB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2016 12:20:01 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LopiJ-1bIR2s2R9H-00gqr3; Sat, 01 Oct 2016 18:19:49
 +0200
Subject: Re: [PATCH 1/3] add QSORT
To:     Junio C Hamano <gitster@pobox.com>
References: <67bddc37-4ee2-fef0-c852-e32645421e4c@web.de>
 <xmqqponmcp07.fsf@gitster.mtv.corp.google.com>
Cc:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <83398160-555f-adab-6b1e-3283c533b5ff@web.de>
Date:   Sat, 1 Oct 2016 18:19:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqponmcp07.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ALLtOvDmKmjZWfn7xSGJI3isoQr7+tlSQKkAs3yHvP65eVT+1dc
 rPZS/2lyCEFv4aNBUkPDfVx5MAcMwbl+yHI/uqvwG5k0yjD5dFxKKFHN+9nwJ88hjMU2nt0
 RB6isMIG/7LTxdI65dMYnhoS6/yKiDz4pLJZTseCJDA0QxqllcOjMRi2GmUN8/jUlarEEoH
 +yTn1Eoh4JLbdZgaUBOcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:70A1WkGW6QI=:TUyV0X78QpjWm6TYxEyPTQ
 nIMybcd9Ab20HVecfuj1O9Pa75N6fDstlUSgeRDESMcchBqG+ZqNLRpDPCyt3fVY+YfNXP1uu
 IJ4zzZt0aDsTyWyu9Tfnmlz2G2p7BhaymVYsxVeDWG36Dd8AiO37CfVueHw5Dru38pjHQfefE
 8K1aPKOiFFY9J+2/OnyauimqqiOGWKXqJLr9UMhzJ2Fi03knEipmL0Nw4XGEBSWv1tqqZIkdP
 ZkV2tRpwWalrNFKr2LBq4UBSwk3Sur9vHbE20FkBfbAzeGzIhiXZ3cMIXWMSUkG7ueSW1YAqY
 OhP26rsaf/Tw5b2YuzFdCUOuXtJL8m4V76kbjnEP8Mly1WR9nE+HNegCUCfug/YDoN+m/sr1V
 hGcUATk+epSeMRQV2oc/rArhSxYlTQ3aSwhdebKXsAlTQt+lNEnwOK7T/q0uFP6SUacHVFrJ1
 2aOGhYF2TT1g0ewZNjCOCLEjQGbgPKESKXasuFdARL29Ur+6ZwZVI1NCjjcfLNIiQXwGOK+QI
 vnujQaHH1hHG99FJVzDE3hpAv964gWzLY0u/GlzADJRi4KL5TkBqhkwdqiKaZjZz0ASDLR48V
 8vwO83IcGt5hVPMHF+Do5aGLGdZFl3FB7FJx3/d24JxBbzvq1WNKE/SqnfJVc3PqWgsP4KFnG
 hIrp/vcYjUZVEXgUcOgKSSv4qDUacSped4UB4TUBFRRD8KuUT46/l385oYBVHg+t9w1z+NHGB
 6I7tGkmDBC3B3QnHkQwDYG6MeLCBJattGHXpuI8Y6F00lYOmiaNXUlqqU21ik9itj9Xg8D1XJ
 IQ91Coy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.09.2016 um 00:36 schrieb Junio C Hamano:
> 3. builtin/show-branch.c does this:
> 
>     qsort(ref_name + bottom, top - bottom, sizeof(ref_name[0]),
>           compare_ref_name);
> 
> where ref_name[] is a file-scope global:
> 
>     static char *ref_name[MAX_REVS + 1];
> 
> and top and bottom are plain integers.  The sizeof() does not take
> the size of *base, so it is understandable that this does not get
> automatically converted.
> 
> It seems that some calls to this function _could_ send the same top
> and bottom, asking for 0 element array to be sorted, by the way.

It's hard to imagine an implementation of qsort(3) that can't handle
zero elements.  QSORT's safety feature is that it prevents the compiler
from removing NULL checks for the array pointer.  E.g. the last two
lines in the following example could be optimized away:

	qsort(ptr, n, sizeof(*ptr), fn);
	if (!ptr)
		do_stuff();

You can see that on https://godbolt.org/g/JwS99b -- an awesome website
for exploring compilation results for small snippets, by the way.

This optimization is dangerous when combined with the convention of
using a NULL pointer for empty arrays.  Diagnosing an affected NULL
check is probably quite hard -- it's right there in the code after all
and not all compilers remove it.

builtin/show-branch.c never passes NULL, so it's not affected by that
hazard.  We can (and should, IMHO) still use QSORT there for
consistency and convenience, though:

-- >8 --
Subject: [PATCH] show-branch: use QSORT

Shorten the code by using QSORT instead of calling qsort(3) directly,
as the former determines the element size automatically and checks if
there are at least two elements to sort already.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/show-branch.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 623ca56..974f340 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -353,8 +353,7 @@ static int compare_ref_name(const void *a_, const void *b_)
 
 static void sort_ref_range(int bottom, int top)
 {
-	qsort(ref_name + bottom, top - bottom, sizeof(ref_name[0]),
-	      compare_ref_name);
+	QSORT(ref_name + bottom, top - bottom, compare_ref_name);
 }
 
 static int append_ref(const char *refname, const struct object_id *oid,
@@ -540,8 +539,7 @@ static void append_one_rev(const char *av)
 		if (saved_matches == ref_name_cnt &&
 		    ref_name_cnt < MAX_REVS)
 			error(_("no matching refs with %s"), av);
-		if (saved_matches + 1 < ref_name_cnt)
-			sort_ref_range(saved_matches, ref_name_cnt);
+		sort_ref_range(saved_matches, ref_name_cnt);
 		return;
 	}
 	die("bad sha1 reference %s", av);
-- 
2.10.0


