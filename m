Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DF001F4F8
	for <e@80x24.org>; Sun,  2 Oct 2016 22:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbcJBW7C (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Oct 2016 18:59:02 -0400
Received: from mout.web.de ([217.72.192.78]:59538 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751576AbcJBW7A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Oct 2016 18:59:00 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LlniO-1bHUxd2OXo-00ZQjb; Mon, 03 Oct 2016 00:58:25
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
 <67756074-836f-2238-37c3-0d186325bd00@web.de>
 <xmqqwpiclu65.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <9014c48e-9b9d-995b-47ba-9ecc48a10ac7@web.de>
Date:   Mon, 3 Oct 2016 00:58:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqwpiclu65.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:RD/AaUIdhlnysW0l1MscKX8m7JtsUzvDEgCM2qQzcCNRGu9Ukhp
 y84WsUgzd2wgQz38aLmkGqZWpd+djpstZSmiihqeVyIC8pmRNFsMZzfnJtcnPvt7g100fQC
 SOPF5WRTIIivndOkiVvts3khCxY8Jlb6t0koLwu4CjAbPsiJIy2Lfeu2edeU3W3fkikiHkN
 KMeL+Cp+1iQqkaYUavcXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QUl58NjpEF8=:Z7SMoh85flZKpXNEhes9ZN
 QXREMAJUqMbQCWJuayekUCtP9v+kobpC9FPxhNdrakB9090i3bmMgnaoKJY345/TQvE1epFN2
 SJ90BVpOlr/JuGVy6NRvQDYe5qmjWZL1ORHV6WqsnENabquvU/PgZB+06jBjqURhj38NbiYfJ
 nem/DTzjcMquPQKkOu6cl8K3sbWmACAelTSByLYSDv16wzOhv46jWZLv9fxFWeBEYBgFqZ1T/
 /piL9Wzy1vuaObGj9W/CXXMgpBpRCin1Jc924hDmSpLN0tL9xK1BfV58W8Hl/3Yd7oOO3W1uW
 +7zWWA35o0+78mSKGnTzWhNFHGXOtiEb8NjwPMuqJ5y9VKJ+n+o4ZuBDZBIQZAobxgM9L4wP+
 BMagsuFoWu0e3ALgJfCvfImVhpBjCivqUJEbmsNKogv3XApymLrIXnzmCpb9cPMl+kcEUYP4Y
 SZI6r39DioJY4mJbCXnruwSA7PtvFia6VwJDka4nULUJmsKeDzJ1ZwB+LLoq22yNQomLIwwAU
 FqAX3tzVN0bS1H01DfWwQaWAROD/EJodmOGEyNUXy0QlBzhHFS2zlQPj7zfpGpIh8SA4/DgIA
 QHEvkqWS5rxVKtvz4/UsKvAqyEvlS/ZQm6QmH8QWQ2OBhwtXMsb7AG16QJskHIXAvtCbaiELM
 kQUlB8Cwvdkhj1LmTQ9dQ+2ZxRc8pTd8PSDn9F6ml/i5BVA6x1lc6V28PAI++TI2vhR0o0pZh
 33DvS98Wosyd5D3cUlBpn4Uk2Y0ef6eT4AFv0YINA+xZzN9kaEjAQy0HlFQfGxIGNq/ni0Slt
 ceLOmqu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.09.2016 um 23:39 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> Am 15.09.2016 um 22:01 schrieb Junio C Hamano:
>>> René Scharfe <l.s.r@web.de> writes:
>>>
>>>> Take this for example:
>>>>
>>>> -			strbuf_addf(&o->obuf, _("(bad commit)\n"));
>>>> +			strbuf_addstr(&o->obuf, _("(bad commit)\n"));
>>>>
>>>> If there's a language that uses percent signs instead of parens or as
>>>> regular letters, then they need to be escaped in the translated string
>>>> before, but not after the patch.  As I wrote: silly.
>>>
>>> Ahh, OK, so "This use of addf only has format part and nothing else,
>>> hence the format part can be taken as-is" which is the Coccinelle rule
>>> used to produce this patch is incomplete and always needs manual
>>> inspection, in case the format part wanted to give a literal % in
>>> the output.  E.g. it is a bug to convert this
>>>
>>> 	strbuf_addf(&buf, _("this is 100%% wrong!"));
>>>
>>> to
>>>
>>> 	strbuf_addstr(&buf, _("this is 100%% wrong!"));
>>
>> Right.  Such strings seem to be quite rare in practice, though. 
>>
>>> Thanks for clarification.  Perhaps the strbuf.cocci rule file can
>>> have some comment to warn the person who builds *.patch file to look
>>> for % in E2, or something?
>>
>> Something like this?
> 
> Yup, with something like that I would understdood where that
> puzzling question came from.

Here's something better than a comment:

-- >8 --
Subject: [PATCH] coccicheck: make transformation for strbuf_addf(sb, "...") more precise

We can replace strbuf_addf() calls that just add a simple string with
calls to strbuf_addstr() to make the intent clearer.  We need to be
careful if that string contains printf format specifications like %%,
though, as a simple replacement would change the output.

Add checks to the semantic patch to make sure we only perform the
transformation if the second argument is a string constant (possibly
translated) that doesn't contain any percent signs.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 contrib/coccinelle/strbuf.cocci | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
index 1e24298..63995f2 100644
--- a/contrib/coccinelle/strbuf.cocci
+++ b/contrib/coccinelle/strbuf.cocci
@@ -1,8 +1,31 @@
+@ strbuf_addf_with_format_only @
+expression E;
+constant fmt;
 @@
-expression E1, E2;
+  strbuf_addf(E,
+(
+  fmt
+|
+  _(fmt)
+)
+  );
+
+@ script:python @
+fmt << strbuf_addf_with_format_only.fmt;
 @@
-- strbuf_addf(E1, E2);
-+ strbuf_addstr(E1, E2);
+cocci.include_match("%" not in fmt)
+
+@ extends strbuf_addf_with_format_only @
+@@
+- strbuf_addf
++ strbuf_addstr
+  (E,
+(
+  fmt
+|
+  _(fmt)
+)
+  );
 
 @@
 expression E1, E2;
-- 
2.10.0
