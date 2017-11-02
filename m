Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D1C120281
	for <e@80x24.org>; Thu,  2 Nov 2017 17:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755610AbdKBR1R (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 13:27:17 -0400
Received: from mout.web.de ([212.227.15.4]:52470 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754143AbdKBR1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 13:27:16 -0400
Received: from [192.168.178.36] ([91.20.50.17]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUWCB-1dj3L332pP-00RLux; Thu, 02
 Nov 2017 18:27:10 +0100
Subject: Re: [PATCH] imap-send: handle NULL return of next_arg()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <2d466b78-77fc-fa2c-c5e1-7b8737a00958@web.de>
 <xmqqefphs9rx.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e71377c8-ce87-c7f4-138a-41dc1cc6f3dc@web.de>
Date:   Thu, 2 Nov 2017 18:27:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqefphs9rx.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:bti8eRmbd84rqEoioFSM+ZraJ/ZUmbk+7JYaFywR3jiWy1+RGrU
 UkokarFqoId+dQ4mppq4KjDvpB/3bu7Qy52KooruG8jXhoxb39XqIueSZbmEwntIEXER5D3
 3o7elLGBDaTyhYRCxAYl6hRUzpkd5unPMPiMxynkzlLBfRCHT3sSh/klPSTb1nRzgJpAfJx
 HKuZUhbATGh1BFx4e2asQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:afTekTqN/Kc=:yX6t6AYaCvwowcQ7r3e0EP
 HGkz3MyJViP8i8wRggEAORgWbh5IWeOiPI8hA9wfAHrQNqX9a732sJtPgqFD2fUXR03VcINga
 vC1impxIUW8alAKWRlSYhO3PFrzuHa06BnGIy1qrC41u8CtWgs0+vnpCH6TSB6FYSxriP7kp4
 HC/csyPhQBbxW/LNmAxRMd/HebBeQDgAW7CIbkcpOndQG6Zln2kGwVTVhHXAp8+bivytzkQqq
 ROup989zKQ4fEGGJjAyEoJBisSTwU3t3Br4CnaT+0yYAySppZhu0m8Bj7e0LJnBwpfP994s2D
 PRL3cPDV0Rx+Zm8YpojJXL5TC/I9qazdwSGpGghV254lX0XorQ5Adnd8Q1LGloyy+T6Z+yedu
 JidP5Hp+NmKOevoxyZvyPR9ErTD2393dBITJ55OPALZKk7IOUyii7VbDOksgyv2RVzJ57h7dC
 O6SDxK96ESdD04ZtZgrzXAfQ3QY0Pg6bGZX/xOdDnqFfkqwuaUhCig3uzVZFgK54F2aK0Q72K
 ngUnvLRA0TnX0KH0pG15cAjl7rYdhjseeb1G2bgNeHvIWVfrJ4P7w0TRiZdMsJetjBlntdMuj
 SSp8C7ybY/NILS7PR8bSeXMdmNaxjfnKY5ogyXO9C0aeog1uGnczhNaqVjdqb5R25aNhrrxDr
 gfedGLtnhoftg3PsJrxlNE1/aOoQ/QQEehNI/N0Xpz7fxVVs03R10B4uYNjw6nxSGcJMqSJxo
 bdZ0+2I2x5tTFi29eZrQSteTIS089klT54Eh6X9Gyp+RB1Y7KL4Z05nEZpmMebrtBHPZzW1/a
 U0o5vHWmSP/CGBeqUzwly7SbCJDAn54SnVFjS6XArQXqzll31w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.11.2017 um 03:18 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
> 
>> @@ -807,6 +816,8 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
>>   			if (cmdp->cb.cont || cmdp->cb.data)
>>   				imap->literal_pending = 0;
>>   			arg = next_arg(&cmd);
>> +			if (!arg)
>> +				arg = "";
> 
> This is being cute and needs reading of the post-context a bit.
> 
>           arg = next_arg(&cmd);
> +        if (!arg)
> +                arg = "";
>           if (!strcmp("OK", arg))
>                   resp = DRV_OK;
>           else {
>                   if (!strcmp("NO", arg))
>                           resp = RESP_NO;
>                   else /*if (!strcmp("BAD", arg))*/
>                           resp = RESP_BAD;
>                   fprintf(stderr, "IMAP command '%s' returned response (%s) - %s\n",
>                           !starts_with(cmdp->cmd, "LOGIN") ?
>                                           cmdp->cmd : "LOGIN <user> <pass>",
>                                           arg, cmd ? cmd : "");
>           }
>           if ((resp2 = parse_response_code(ctx, &cmdp->cb, cmd)) > resp)
>                   resp = resp2;
> 
> 
> Because the existing code does not explicitly check for "BAD", we
> get RESP_BAD, which is what we want in the end, and the error
> message we give has "returned response (%s)" which is filled with
> this empty string.
> 
> I notice that when this change matters, i.e. we hit a premature end,
> next_arg() that yielded NULL would have cleared cmd.  That is OK for
> the fprintf() we see above, but wouldn't it hit parse_response_code()
> that is shared between good and bad cases?  The function starts like
> so:
> 
>      static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
>                                     char *s)
>      {
>              struct imap *imap = ctx->imap;
>              char *arg, *p;
> 
>              if (*s != '[')
>                      return RESP_OK;		/* no response code */
> 
> so we will get an immediate NULL dereference, it appears.

Good catch.

The NULL check in the fprintf() call (two lines above) makes it obvious
already that cmd can be NULL.  So parse_response_code() needs to learn
to handle NULL passed as its third parameter.  And since "no response
code" yields "RESP_OK" I guess that this should be an appropriate
reaction to s == NULL as well.

RFC 3501 seems to agree (response codes are optional):

   7.1.    Server Responses - Status Responses

   Status responses are OK, NO, BAD, PREAUTH and BYE.  OK, NO, and BAD
   can be tagged or untagged.  PREAUTH and BYE are always untagged.

   Status responses MAY include an OPTIONAL "response code".  A response
   code consists of data inside square brackets in the form of an atom,
   possibly followed by a space and arguments.  The response code
   contains additional information or status codes for client software
   beyond the OK/NO/BAD condition, and are defined when there is a
   specific action that a client can take based upon the additional
   information.

The follow-up patch below makes sense in this light, but I wonder why
it hasn't been necessary so far.  Do most IMAP servers actually send
response codes?  Or at least some other string after a status response?
Are no users of git imap-send left?  I have no way to test any of that.
:-(

René

-- >8 --
Subject: [PATCH 2/1] imap-send: handle missing response codes gracefully

Response codes are optional.  Exit parse_response_code() early if it's
passed a NULL string, indicating that we reached the end of the reply.
This avoids dereferencing said NULL pointer.

Noticed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 0031566309..12cc4ea4c8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -684,7 +684,7 @@ static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
 	struct imap *imap = ctx->imap;
 	char *arg, *p;
 
-	if (*s != '[')
+	if (!s || *s != '[')
 		return RESP_OK;		/* no response code */
 	s++;
 	if (!(p = strchr(s, ']'))) {
-- 
2.15.0
