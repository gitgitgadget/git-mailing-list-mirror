Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6457B20989
	for <e@80x24.org>; Mon, 10 Oct 2016 20:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbcJJUqs (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 16:46:48 -0400
Received: from mout.web.de ([212.227.15.14]:62489 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751335AbcJJUqr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 16:46:47 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MgqrQ-1bXcFM3jua-00M49H; Mon, 10 Oct 2016 22:46:32
 +0200
Subject: Re: [PATCH] use strbuf_add_unique_abbrev() for adding short hashes,
 part 3
To:     Jeff King <peff@peff.net>
References: <c830e99d-4fc9-b001-cce3-38f66dc2c678@web.de>
 <20161010000035.mfcf55wqfcbcnarh@sigill.intra.peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <af55f6d7-e1b1-272b-4fbe-a6eb2422b3be@web.de>
Date:   Mon, 10 Oct 2016 22:46:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161010000035.mfcf55wqfcbcnarh@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:/vXAteEvPk7lzG2X1N8KzNeoHctmGYUXov3tu/86DxCyomKkEIN
 BGLlqVGpcSiVwl1jSquybgH3Es8IcoKexHdlqbaKYGBfFAU1LxpsUdpiT4h5tLdgWfcDl2e
 CDEF+HEm/T0ZnUSv8wKNDFvqPWVLzK2jcyGhNuA8QzAecL4QaS0ZJ7HFp0zdr45WDaNdrVs
 b5N6CqvhRspvqRQq+DZOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vsn8JsFgu8s=:SJziTl4Ebo56x1NPrEH9sZ
 Rmpuw/+05ShOv1TJ80i39od80ZK5U/INpMUZPUjmC4CuQG1dKZUCsGi1w/R0WUIb8SsiHdSJv
 irzmZpA7jV6zg5Eg698uPt+7NU6gNHcHqLFsb6iOqP9L7tFk/2MtE5Ic0ri+LofIyJETz0mvg
 SV4pNVRRrtp5zWB/A+ZtIyUADGhP9JjTdspjfoc6mJsSecJYVZNvtNrhQ+rUEi/CUFqeky5vH
 ZldQxTsLg5ut3KM9ghbFar83X50fV6ZL057D07LtJ4pruUhgI1We8rMpYeJyvgZpia3HwyOLE
 fFmaX//9tqmQwB2WhBHGqwjrv6AEfnvBUEAMUneEgnxZKzajSWCnMhoEqpKpZ28ZuQkp7zZ/d
 lyGDG7Z3VBxlMr7cP7VIfyj8MDCnlMUUar/nXZwVU/pWsCoaSZn60hTA/HSPHqQw7aFHre7ML
 dCtu/r5IChVu4rT//bboWu4NCvANCBUw/BxgMep8vH+jRmBifyC/JXthO4Tr/o3LyHWwR8XGi
 QtLSOwmk4Hi65njRRb36OZG+oVEsSlfwH8L08fM9gakK4TfDNLJsEkVfDg3jQswlAMFWA5+tV
 47VpP57Cq4WLAwXyuTRqiP+ZkBlAm+4g3NtZGuF+tFgmqPpp/lw8ohR6dulSN/uM5lMzVu1vX
 EqAelDPpC+hEJstUrPRjW4OGSRY8YSjISLoDdo2BfjZKDmtLeCIc49PO9pRC/iDiq3ELpXuxK
 FMDoA9FlX9/zZj7+/Lcs90v/kEkEARoDAZQDW88gh27BqL/pBlxPHw980Oo55MCDZdVZCcdLr
 1iFyJsY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.10.2016 um 02:00 schrieb Jeff King:
> On Sat, Oct 08, 2016 at 05:38:47PM +0200, René Scharfe wrote:
> 
>> Call strbuf_add_unique_abbrev() to add abbreviated hashes to strbufs
>> instead of taking detours through find_unique_abbrev() and its static
>> buffer.  This is shorter in most cases and a bit more efficient.
>>
>> The changes here are not easily handled by a semantic patch because
>> they involve removing temporary variables and deconstructing format
>> strings for strbuf_addf().
> 
> Yeah, the thing to look for here is whether the sha1 variable holds the
> same value at both times.
> 
> These all look OK to me. Mild rambling below.
> 
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index 5200d5c..9041c2f 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -202,9 +202,9 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
>>  		strbuf_addf(&o->obuf, "virtual %s\n",
>>  			merge_remote_util(commit)->name);
>>  	else {
>> -		strbuf_addf(&o->obuf, "%s ",
>> -			find_unique_abbrev(commit->object.oid.hash,
>> -				DEFAULT_ABBREV));
>> +		strbuf_add_unique_abbrev(&o->obuf, commit->object.oid.hash,
>> +					 DEFAULT_ABBREV);
>> +		strbuf_addch(&o->obuf, ' ');
> 
> I've often wondered whether a big strbuf_addf() is more efficient than
> several strbuf_addstrs. It amortizes the size-checks, certainly, though
> those are probably not very big. It shouldn't matter much for amortizing
> the cost of malloc, as it's very unlikely to have a case where:
> 
>   strbuf_addf("%s%s", foo, bar);
> 
> would require one malloc, but:
> 
>   strbuf_addstr(foo);
>   strbuf_addstr(bar);
> 
> would require two (one of the strings would have to be around the same
> size as the ALLOC_GROW() doubling).
> 
> So it probably doesn't matter much in practice (not that most of these
> cases are very performance sensitive anyway). Mostly just something I've
> pondered while tweaking strbuf invocations.

Good question.  ALLOC_GROW() doesn't double exactly, but indeed the
number of reallocations depends on the size of the added pieces.  I
always thought of strbuf_addf() as an expensive function for
convenience, but never timed it.

Numbers vary a bit, but here's what I get for the crude test program
at the end:

$ time t/helper/test-strbuf strbuf_addf 123 123456789012345678901234567890
123123456789012345678901234567890

real    0m0.168s
user    0m0.164s
sys     0m0.000s
$ time t/helper/test-strbuf strbuf_addstr 123 123456789012345678901234567890
123123456789012345678901234567890

real    0m0.141s
user    0m0.140s
sys     0m0.000s

Just a data-point, but it confirms my bias, so I stop here. :)

> Just thinking aloud, I've also wondered if strbuf_addoid() would be
> handy.  We already have oid_to_hex_r(). In fact, you could write it
> already as:
> 
>   strbuf_add_unique_abbrev(sb, oidp->hash, 0);
> 
> but that is probably not helping maintainability. ;)

Yes, a function for adding full hashes without using a static
variable is useful for library functions that may end up being
called often or in parallel.  I'd call it strbuf_add_hash,
though.



diff --git a/Makefile b/Makefile
index 1aad150..ad5e98c 100644
--- a/Makefile
+++ b/Makefile
@@ -628,6 +628,7 @@ TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sha1-array
 TEST_PROGRAMS_NEED_X += test-sigchain
+TEST_PROGRAMS_NEED_X += test-strbuf
 TEST_PROGRAMS_NEED_X += test-string-list
 TEST_PROGRAMS_NEED_X += test-submodule-config
 TEST_PROGRAMS_NEED_X += test-subprocess
diff --git a/t/helper/test-strbuf.c b/t/helper/test-strbuf.c
new file mode 100644
index 0000000..177f3e2
--- /dev/null
+++ b/t/helper/test-strbuf.c
@@ -0,0 +1,25 @@
+#include "cache.h"
+
+int cmd_main(int argc, const char **argv)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int i = 1000000;
+
+	if (argc == 4) {
+		if (!strcmp(argv[1], "strbuf_addf")) {
+			while (i--) {
+				strbuf_release(&sb);
+				strbuf_addf(&sb, "%s%s", argv[2], argv[3]);
+			}
+		}
+		if (!strcmp(argv[1], "strbuf_addstr")) {
+			while (i--) {
+				strbuf_release(&sb);
+				strbuf_addstr(&sb, argv[2]);
+				strbuf_addstr(&sb, argv[3]);
+			}
+		}
+		puts(sb.buf);
+	}
+	return 0;
+}

