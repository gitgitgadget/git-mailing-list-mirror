Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA8512070F
	for <e@80x24.org>; Thu, 15 Sep 2016 21:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756199AbcIOV0h (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 17:26:37 -0400
Received: from mout.web.de ([212.227.15.3]:52565 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753255AbcIOV0f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 17:26:35 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MMIdp-1beroE08CL-0085ro; Thu, 15 Sep 2016 23:26:11
 +0200
Subject: Re: [PATCH] use strbuf_addstr() for adding constant strings to a
 strbuf, part 2
To:     Junio C Hamano <gitster@pobox.com>
References: <f7294ac5-8302-03fb-d756-81a1c029a813@web.de>
 <20160915184448.awipvg2kmlq7weei@sigill.intra.peff.net>
 <xmqqbmzpnex4.fsf@gitster.mtv.corp.google.com>
 <20160915193804.d2mmmeard2rj6vye@sigill.intra.peff.net>
 <79f6cfb5-3b9b-2ae7-d9a3-5c1c65c7d4cf@web.de>
 <xmqq7fadnd9s.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <67756074-836f-2238-37c3-0d186325bd00@web.de>
Date:   Thu, 15 Sep 2016 23:25:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqq7fadnd9s.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:HxlqVT0fvfgnFYKSfzSnstH5LLHF4GGIvOTqE7EuPbIQ2mJ+SCt
 KbMO1rtJ9SROwB82uruTd2twFh5Lwg/EXKfBYp9c75m3HpdE3Wjl8RYfcCMUOXwjZtjwcvV
 BLPLrKMDbCALZsvAwqD0ZbaMv9ZzKABFUONuPrdURKVSAinXZVfXJVwp+0Hkxexsu3H9tGo
 Z5YbPU6EKLj3/sIWACstg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YiRqWlM2TX0=:1LP1Sb18kGYh79A7gdAtcr
 1Q5L6XgAkhFxAiFPj0rlgQvwscNd7x/cWLbhfPbmKr01CJ89DbdaK2CM3n6DZJIE6ZIshIqhO
 gKlHQFcc8UmbAYiknU0bFUgxemQ9RLxSkpaI24PeVjD5eZ25qpv7VTWvcxmq0zR649YR012by
 RbfHV3aUMwptSFY+Mf4LyosIzxeye00w7FlbHqphGR9CrpqM6ddmO1wayugCQrBAokW2Q8hq1
 s56/NQE9+r/YjG74tBdiY/nprQ3+Qa5f53wEM3nSQs9GJjAxPQduOwxQrNEuOefLM0zl/nPHu
 FUX0hsfKGnqaTMZzafqHO+NnMAPNTYFUtAyEaBAgXgh1Nz7syUMDUkGilSmBoCRes2ATBi1pc
 Cu92ax5c2al30okEwEXv6moulhaPCCqLjiUaf94WhVh8/6kv+48WuyFmDdPDwFw8r6ECxJ7Om
 /HRmnKFfcwmjJbk1GrQVo6fgeF7iKKqEjpX2UBicllmc+rH0ag+tPq7xISTYhzdxJ6+EbXZ+Y
 +cyQVgmkFPuhYbrHEwEDsSy4VRxTPUD75U43xkXHnJl2LOQeBIpHit/faRx8P2t3FlW1so6r9
 EVFqJHxGu4ozA4R0wg7y4B9QNk9hQ73rHYh+a/7ziANkzIW6ZTe9LFSU7cU58iSnzsPadjEWu
 3mTlfH2FpqSiRHX8LFPudPcHHj6agtFTnmBPvfVQ6I6kaYQxFvofsCuganAzBt5v7XVbQKHps
 WfFuwOAgCLX7/9uSbk5yOH/TOhzJ8PKzRO42Q9nBFewkZIsddk9URjPblkJKLUhk5p80rh+JS
 qSD4IdP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.09.2016 um 22:01 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Take this for example:
>>
>> -			strbuf_addf(&o->obuf, _("(bad commit)\n"));
>> +			strbuf_addstr(&o->obuf, _("(bad commit)\n"));
>>
>> If there's a language that uses percent signs instead of parens or as
>> regular letters, then they need to be escaped in the translated string
>> before, but not after the patch.  As I wrote: silly.
> 
> Ahh, OK, so "This use of addf only has format part and nothing else,
> hence the format part can be taken as-is" which is the Coccinelle rule
> used to produce this patch is incomplete and always needs manual
> inspection, in case the format part wanted to give a literal % in
> the output.  E.g. it is a bug to convert this
> 
> 	strbuf_addf(&buf, _("this is 100%% wrong!"));
> 
> to
> 
> 	strbuf_addstr(&buf, _("this is 100%% wrong!"));

Right.  Such strings seem to be quite rare in practice, though. 

> Thanks for clarification.  Perhaps the strbuf.cocci rule file can
> have some comment to warn the person who builds *.patch file to look
> for % in E2, or something?

Something like this?

---
 contrib/coccinelle/strbuf.cocci | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
index 7932d48..3f535ca 100644
--- a/contrib/coccinelle/strbuf.cocci
+++ b/contrib/coccinelle/strbuf.cocci
@@ -1,3 +1,5 @@
+// Careful, this is not fully equivalent: "%" is no longer treated
+// specially.  Check for "%%", "%m" etc. in the format string (E2).
 @@
 expression E1, E2;
 @@
-- 
2.10.0



