Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B271F403
	for <e@80x24.org>; Fri,  8 Jun 2018 20:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753207AbeFHUHf (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 16:07:35 -0400
Received: from mout.web.de ([212.227.17.12]:59563 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753176AbeFHUHd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 16:07:33 -0400
Received: from [192.168.178.36] ([79.237.242.156]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfztP-1g2MEX2JMh-00pdES; Fri, 08
 Jun 2018 22:07:18 +0200
Subject: Re: [PATCH v8 1/2] json_writer: new routines to create data in JSON
 format
To:     git@jeffhostetler.com, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180607141209.24423-1-git@jeffhostetler.com>
 <20180607141209.24423-2-git@jeffhostetler.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0690b5a8-6c1c-e664-bb89-5d4e48258ddb@web.de>
Date:   Fri, 8 Jun 2018 22:07:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607141209.24423-2-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1+dNlIIxHu6zN/bsrxyz6/4PJvjvZx64/1afJJQ0URwpG5m5J7d
 iGnyJ5allVhiHhBIlf1UkVkxgMK9cPubH5eNaf27RT9Ovje4hD9AkGh8/zZJV0AXDh/ZJBc
 6TWGq7wM9mLnVY2JtlMrG+IvAaEzN0Oxmu4wS7nB8FwTZzqtCzLMIuFc3WyV8mmGax60Hci
 JNv7QhhwLfECEyqIuSONQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8negLxdVeyM=:ElAdbAZWcWhSnPDMZGqjdy
 5Kn2Ew0F8HotcC4CJg17UNJIduRRP7l4Ya3C6DedeFhwl2FV6subsfnscY1UzDsQNL9Jk2oeQ
 EuHFKDvxPizT+TLm5bYEESXOWp/UB0ObnYca1uFLvvtZW+yqxO/IDL7zl4iZKelE/EZEEnQWs
 lL1KMN9ALYH+FlfpdCileLU1GWNxewOZNq4FkOQX5IzX46RcLVw4nAQq6HyiWwY/gvgrFCnpR
 uQEoMy4RG92UJJbhS7TB5rrcVVAj0ZfUOZM4zT498XrtatLSka/79JqD2Gg4JvrAitKHUnw0k
 1/VYj6iTBXZKhIZKkBTSssASpWXQTXi0L4eT2CSDBZeMKRelb8GKVKjLr+S53cNqbcZoN4Jgr
 x0ECFcaMiytoTj4jamLTeJ1FoSRt+PDV2ulHGc7aXTYr+DOp9zk5YWm0+qDOh4lkgQkvHYxRq
 2wALoVpdI/Hy+OJHOaOAsXP832lYMxNEH6npzUwRJgq7sqgGqfRZNIiL4nJVthhMYFA6YYiMz
 sp8DxRjYC+XxMPZAcW5l8Bj/siM+UYspYzucm9JNmFW+jhcS5CO/Y4BbDyaBKTV0B1SCnXfvn
 gQ/qLFguEJpBuVRwHoPJRYakRV0hreU8sTW5pQWMqqMKTaVXjYxFECdmBSB63Fz+FQLfmMjN0
 WDAjea2n74kyvhzDxDShidVC1+rARGnHkD/gCwuw597XDPjzu/mvkKHZWDtmhu1Sj8PdvQMpq
 3/rSLsswYU7OldIAuLsTLgAvRfO0Jcn6remA7WCnVVprHi2Le5tcCt1FX+zv8Z+fjyzeexixm
 V17CwQT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.06.2018 um 16:12 schrieb git@jeffhostetler.com:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> +/*
> + * Add comma if we have already seen a member at this level.
> + */
> +static inline void maybe_add_comma(struct json_writer *jw)
> +{
> +	if (!jw->open_stack.len)
> +		return;

This is impossible.  maybe_add_comma() is only called directly after
assert_in_object() and assert_in_object(), which abort if open_stack 
is empty.

> +	if (jw->first_stack.buf[jw->first_stack.len - 1] == '1')
> +		jw->first_stack.buf[jw->first_stack.len - 1] = '0';
> +	else
> +		strbuf_addch(&jw->json, ',');

You only need a binary flag to indicate if a comma is needed, not a
stack.  We need a comma at the current level if and only if we already
wrote a child item.  If we finish a level then we do need a comma at the
previous level because we just wrote a sub-object or sub-array there.
And that should cover all cases.  Am I missing something?

I get a sense of déjà vu, by the way. :)

Here's what I mean:
---
 json-writer.c | 17 ++++++-----------
 json-writer.h | 13 +++++--------
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/json-writer.c b/json-writer.c
index f35ce1912a..14a4e89188 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -5,7 +5,7 @@ void jw_init(struct json_writer *jw)
 {
 	strbuf_reset(&jw->json);
 	strbuf_reset(&jw->open_stack);
-	strbuf_reset(&jw->first_stack);
+	jw->need_comma = 0;
 	jw->pretty = 0;
 }
 
@@ -13,7 +13,6 @@ void jw_release(struct json_writer *jw)
 {
 	strbuf_release(&jw->json);
 	strbuf_release(&jw->open_stack);
-	strbuf_release(&jw->first_stack);
 }
 
 /*
@@ -69,7 +68,7 @@ static inline void begin(struct json_writer *jw, char ch_open, int pretty)
 	strbuf_addch(&jw->json, ch_open);
 
 	strbuf_addch(&jw->open_stack, ch_open);
-	strbuf_addch(&jw->first_stack, '1');
+	jw->need_comma = 0;
 }
 
 /*
@@ -99,12 +98,10 @@ static inline void assert_in_array(const struct json_writer *jw)
  */
 static inline void maybe_add_comma(struct json_writer *jw)
 {
-	if (!jw->open_stack.len)
-		return;
-	if (jw->first_stack.buf[jw->first_stack.len - 1] == '1')
-		jw->first_stack.buf[jw->first_stack.len - 1] = '0';
-	else
+	if (jw->need_comma)
 		strbuf_addch(&jw->json, ',');
+	else
+		jw->need_comma = 1;
 }
 
 static inline void fmt_double(struct json_writer *jw, int precision,
@@ -397,8 +394,6 @@ void jw_end(struct json_writer *jw)
 	char ch_open;
 	int len;
 
-	if (jw->open_stack.len != jw->first_stack.len)
-		BUG("jwon-writer: open_ and first_ stacks out of sync");
 	if (!jw->open_stack.len)
 		BUG("json-writer: too many jw_end(): '%s'", jw->json.buf);
 
@@ -406,7 +401,7 @@ void jw_end(struct json_writer *jw)
 	ch_open = jw->open_stack.buf[len];
 
 	strbuf_setlen(&jw->open_stack, len);
-	strbuf_setlen(&jw->first_stack, len);
+	jw->need_comma = 1;
 
 	if (jw->pretty)
 		strbuf_addch(&jw->json, '\n');
diff --git a/json-writer.h b/json-writer.h
index af9c2612f8..c437462ba8 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -59,18 +59,15 @@ struct json_writer
 	struct strbuf open_stack;
 
 	/*
-	 * Another simple stack of the currently open array and object
-	 * forms.  This is used in parallel to "open_stack" (same length).
-	 * It contains a string of '1' and '0' where '1' indicates that
-	 * the next child-element seen will be the first child (and does
-	 * not need a leading comma).
+	 * Indicates if the next child item needs a leading comma.
+	 * Only the first item of arrays and objects doesn't need one.
 	 */
-	struct strbuf first_stack;
+	unsigned int need_comma:1;
 
-	int pretty;
+	unsigned int pretty:1;
 };
 
-#define JSON_WRITER_INIT { STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, 0 }
+#define JSON_WRITER_INIT { STRBUF_INIT, STRBUF_INIT, 0, 0 }
 
 void jw_init(struct json_writer *jw);
 void jw_release(struct json_writer *jw);
-- 
2.17.1
