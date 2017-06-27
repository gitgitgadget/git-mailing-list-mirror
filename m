Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 526272082F
	for <e@80x24.org>; Tue, 27 Jun 2017 17:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbdF0RDq (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 13:03:46 -0400
Received: from mout.web.de ([212.227.15.3]:57536 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752103AbdF0RDp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 13:03:45 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LcPRO-1e8KzC3EEY-00jt5r; Tue, 27
 Jun 2017 19:03:32 +0200
Subject: Re: [PATCH 1/2] apply: guard against renames of non-existant empty
 files
To:     Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Michal Zalewski <lcamtuf@google.com>
References: <20170225101307.24067-1-vegard.nossum@oracle.com>
 <baf195cc-ef81-bbad-4e01-4149498efedb@web.de>
 <xmqqinnvwg2d.fsf@gitster.mtv.corp.google.com>
 <ed46f675-559a-88a3-cf97-d0ba7cf3112f@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e9c9c1f9-a8b3-95ac-e74e-c82e52de5b73@web.de>
Date:   Tue, 27 Jun 2017 19:03:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <ed46f675-559a-88a3-cf97-d0ba7cf3112f@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:rvWRLSL1tEVJcvofGjlSfgywWpANchXOThUKynLGubGxYVXIgnW
 XdLbdIBtrMAbYKSkTICAs3TAVPLBj6+0u4bWLarndRD9FG2NL3XxOtqtEo1t6HiWi6ZlrtP
 IJrsHpyPjPQtdhu7UDfBUeuI3wcjSiEHN7F/i/MIfwplmEtNLFig465goOD0fFAmda5ne6q
 dX8ADGk8Ly78g6Ls0cMhg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F0VVJaPWOCM=:rCRhhJ6GtVWg4dx9voJTcp
 2exx0zEDBUxSMbwA4jW6O8TATYenAquDNQi4c0C22/s3JDj670D0FdVxtHWL3vfzsXUHIL0fv
 C8gq7/v6DIjahpKEqgdNfP/EMkc3LAi2XVrkX8wuxhfSBPPClW4o4jh95zdAZL0NtD3v6wuUp
 xklhYrAc1CRq4sbmY4oaDuqZpeeRDYLG36yr901pw9vCH9LqCatWkC9AEHAEqtU6lbq94PKle
 mbCelSgOIsKPLCdc659XSso3GgTABde7X5Nt3Oau/eqotzT0r6BVz7Y8LWnYjuFpKwiLPlz/y
 qs9ZLslsnfrfAvFEVSryyDLmZtMGMLa28mlpFs9TC4q6WcE6dKLJvRjjja0YZauUdQcDM97gI
 Wh6/BhuJhgGY6xUE3uMS8OuI9G0WOEGzLhFuqkKw9jlO3Qx34tUzf7wK0F0W14Z6h8+3BN/ZS
 Iw7JEiKAjaMwAC4ybc5rDia0qJ8+n2P2N6ZssYDh0FRxfhaGm/2AF4j/tZhFwIyQDEDX09tMt
 uexfeSNvCX0RXB5CvkxsPE9IjrQgVeGPWv3gM5TRyeZhNyXwvorOX6eXKfJkkT31kbWUQgwwr
 zBUdQGBv1r6ZPnSIprQjw5ZiYBUAwNfQ/UdelTqCszmnG+6ofD51Gxm8YYZnD+F3hvq0P+zII
 Zud6Hm3MS43nPVVGD3CNOjArrNZhKMScyoJl5LrERq72DjfswAEM3A7DT8TW/pZ7QwwrQHDyn
 /7XMHcK/yb6IdHftRVjjmi1Xr5gbIel8KZApLFFEltSpYus++X2iulNNsIemCLRcnOerUHeuB
 jaQf03j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.02.2017 um 23:18 schrieb René Scharfe:
> Am 27.02.2017 um 21:10 schrieb Junio C Hamano:
>> René Scharfe <l.s.r@web.de> writes:
>>
>>> Would it make sense to mirror the previously existing condition and
>>> check for is_new instead?  I.e.:
>>>
>>>             if ((!patch->is_delete && !patch->new_name) ||
>>>                 (!patch->is_new    && !patch->old_name)) {
>>>
>>
>> Yes, probably.

So let's actually do it!

-- >8 --
Subject: [PATCH] apply: check git diffs for missing old filenames

2c93286a (fix "git apply --index ..." not to deref NULL) added a check
for git patches missing a +++ line, preventing a segfault.  Check for
missing --- lines as well, and add a test for each case.

Found by Vegard Nossum using AFL.

Original-patch-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 apply.c                    |  3 ++-
 t/t4133-apply-filenames.sh | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index b963d7d8fb..8cd6435c74 100644
--- a/apply.c
+++ b/apply.c
@@ -1575,7 +1575,8 @@ static int find_header(struct apply_state *state,
 				patch->old_name = xstrdup(patch->def_name);
 				patch->new_name = xstrdup(patch->def_name);
 			}
-			if (!patch->is_delete && !patch->new_name) {
+			if ((!patch->new_name && !patch->is_delete) ||
+			    (!patch->old_name && !patch->is_new)) {
 				error(_("git diff header lacks filename information "
 					     "(line %d)"), state->linenr);
 				return -128;
diff --git a/t/t4133-apply-filenames.sh b/t/t4133-apply-filenames.sh
index 2ecb4216b7..c5ed3b17c4 100755
--- a/t/t4133-apply-filenames.sh
+++ b/t/t4133-apply-filenames.sh
@@ -35,4 +35,28 @@ test_expect_success 'apply diff with inconsistent filenames in headers' '
 	test_i18ngrep "inconsistent old filename" err
 '
 
+test_expect_success 'apply diff with new filename missing from headers' '
+	cat >missing_new_filename.diff <<-\EOF &&
+	diff --git a/f b/f
+	index 0000000..d00491f
+	--- a/f
+	@@ -0,0 +1 @@
+	+1
+	EOF
+	test_must_fail git apply missing_new_filename.diff 2>err &&
+	test_i18ngrep "lacks filename information" err
+'
+
+test_expect_success 'apply diff with old filename missing from headers' '
+	cat >missing_old_filename.diff <<-\EOF &&
+	diff --git a/f b/f
+	index d00491f..0000000
+	+++ b/f
+	@@ -1 +0,0 @@
+	-1
+	EOF
+	test_must_fail git apply missing_old_filename.diff 2>err &&
+	test_i18ngrep "lacks filename information" err
+'
+
 test_done
-- 
2.13.2
