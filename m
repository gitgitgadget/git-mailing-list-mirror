Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5049E207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 23:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934982AbcI2XVh (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 19:21:37 -0400
Received: from mout.web.de ([217.72.192.78]:50691 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934911AbcI2XVf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 19:21:35 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MEEa4-1bj8vA04oC-00FWUL; Fri, 30 Sep 2016 01:21:28
 +0200
Subject: Re: [PATCH 1/3] add QSORT
To:     Junio C Hamano <gitster@pobox.com>
References: <67bddc37-4ee2-fef0-c852-e32645421e4c@web.de>
 <xmqqponmcp07.fsf@gitster.mtv.corp.google.com>
Cc:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <eeb2791e-c09b-b7bc-f8e8-336d4f3906b8@web.de>
Date:   Fri, 30 Sep 2016 01:21:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqponmcp07.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:aMlxYC7l+gFiEJEmR5RHR1lGXii8GuCAmuKNFExZvL15XFdcG0Y
 A/b2MKjFzSCYA8rJku+492Dv7a0cjxF+lFeNm038HfkEoWtPfY6KaeZxRMhbxhWmjjzB7PE
 0m/5leEpSTN5J0fHzta/Gx4KedRARmNiBW1vcq3MbwhCJImhZPzsqK6ySNBmrm9BbBmpvZy
 NjhlXjqH4QSzgoSe12srg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o5VcJ8ogSb8=:kK80e3yHaF2VfB3pIuWr1u
 xVfF01q8EVoLKHeAFjXRe5/KzVHktW6TkONq3ACmnuerPa/6onME5XqMO+Ia1UVYXjfPkaxXm
 jb5Z+wMnr3LcvVNkH6aWPP1ioX6EJhNLc2o0Ux2dtko1EpnG9WXA7KXUID7tf4kdCAfVIrsRf
 8tQLKZ7U/NaJx4RLd5DQDapJ0vq98AS4/d90+/9aVDPj2KDOycZrtEY/XJcCxWdIzIeS/G6Qh
 gPTS17OkLoOHUBhiMNzxKVVGPdZgERQxvlAV7ti4U4D3KcfLcEehP3JbWwuKFpMmum0bOijet
 SDhm3i8HTBD+OlSWsUvv0fIlJJuoDFFzQCiDw+zTWXjMw/F5OMncdA5sM2gfIVcjQ1THiDSLU
 UJypuuRYjw+Rpj9gHWCzqYDxHLCOjZpqgsU6UNTVx+15TRsrTapAY0+tD9304BnBqsOs7ye6c
 th+2k04U0pFO3vI7tnZteRkCWz10M16u9Go4vKRzYU12P9VRCIIqxOyZ4jHi97+qNwnkbvnAG
 IEa3ZD6+HdFt+oD2rN4H7pH1nun+bmBi6oo9M6YTQfgDYKdUddOCMl9icbQdeYTz5MBMGvnRf
 FMm35wfRXbe3OvTME7VYLTW9II4QGSk9P6F4o9vERVMr0ad1kRafZ0VHiqMweT7qQUUH2vQ7Q
 mYMhelQbYNU1ijlIhI/j4B8iOsvmg8cpOsVqN+ECzQCEKVP4Y0b6An77YzCScmWKzFPKy5oaf
 TqVY1ehiNxmbhZhYzyx8lBYRBVlr8tf2WRuRmJnHk1RHN/N+9fgTAFRkr0C0B1vzFtM0pRi/7
 gkWBVeA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.09.2016 um 00:36 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Add the macro QSORT, a convenient wrapper for qsort(3) that infers the
>> size of the array elements and supports the convention of initializing
>> empty arrays with a NULL pointer, which we use in some places.
>>
>> Calling qsort(3) directly with a NULL pointer is undefined -- even with
>> an element count of zero -- and allows the compiler to optimize away any
>> following NULL checks.  Using the macro avoids such surprises.
>>
>> Add a semantic patch as well to demonstrate the macro's usage and to
>> automate the transformation of trivial cases.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>>  contrib/coccinelle/qsort.cocci | 19 +++++++++++++++++++
>>  git-compat-util.h              |  8 ++++++++
>>  2 files changed, 27 insertions(+)
>>  create mode 100644 contrib/coccinelle/qsort.cocci
> 
> The direct calls to qsort(3) that this series leaves behind are
> interesting.
> 
> 1. builtin/index-pack.c has this:
> 
> 	if (1 < opts->anomaly_nr)
> 		qsort(opts->anomaly, opts->anomaly_nr, sizeof(uint32_t), cmp_uint32);
> 
> where opts->anomaly is coming from pack.h:
> 
>     struct pack_idx_option {
>             unsigned flags;
>             ...
>             int anomaly_alloc, anomaly_nr;
>             uint32_t *anomaly;
>     };
> 
> I cannot quite see how the automated conversion misses it?  It's not
> like base and nmemb are type-restricted in the rule (they are both
> just "expression"s).
> 
> 2. builtin/shortlog.c has this:
> 
> 	qsort(log->list.items, log->list.nr, sizeof(struct string_list_item),
> 	      log->summary ? compare_by_counter : compare_by_list);
> 
> where log->list is coming from shortlog.h:
> 
>     struct shortlog {
>             struct string_list list;
>     };
> 
> and string-list.h says:
> 
>     struct string_list {
>             struct string_list_item *items;
>             unsigned int nr, alloc;
>             ...
>     };
> 
> which seems to be a good candidate for this rule:
> 
>     type T;
>     T *base;
>     expression nmemb, compar;
>     @@
>     - qsort(base, nmemb, sizeof(T), compar);
>     + QSORT(base, nmemb, compar);
> 
> if we take "T == struct string_list_item".

Transformations for these two are generated if we pass --all-includes
to spatch.  So let's do that.

-- >8 --
Subject: [PATCH] coccicheck: use --all-includes by default

Add a make variable, SPATCH_FLAGS, for specifying flags for spatch, and
set it to --all-includes by default.  This option lets it consider
header files which would otherwise be ignored.  That's important for
some rules that rely on type information.  It doubles the duration of
coccicheck, however.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1aad150..d15bf8d 100644
--- a/Makefile
+++ b/Makefile
@@ -467,6 +467,7 @@ SPATCH = spatch
 export TCL_PATH TCLTK_PATH
 
 SPARSE_FLAGS =
+SPATCH_FLAGS = --all-includes
 
 
 
@@ -2314,7 +2315,7 @@ C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
 %.cocci.patch: %.cocci $(C_SOURCES)
 	@echo '    ' SPATCH $<; \
 	for f in $(C_SOURCES); do \
-		$(SPATCH) --sp-file $< $$f; \
+		$(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS); \
 	done >$@ 2>$@.log; \
 	if test -s $@; \
 	then \
-- 
2.10.0

