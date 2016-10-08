Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF819207EC
	for <e@80x24.org>; Sat,  8 Oct 2016 09:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbcJHJMG (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 05:12:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:60365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752731AbcJHJME (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 05:12:04 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LpsmR-1bGysR0zJ9-00fl8n; Sat, 08 Oct 2016 11:11:52
 +0200
Date:   Sat, 8 Oct 2016 11:11:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 05/25] sequencer: allow the sequencer to take custody
 of malloc()ed data
In-Reply-To: <xmqqeg3tjn7n.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610081108520.35196@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de> <942aa559a0af9b52e079c5c78fa313f49b87d50d.1473590966.git.johannes.schindelin@gmx.de> <xmqqzinc295y.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610051338530.35196@virtualbox> <xmqqeg3tjn7n.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KzjwBVoxZEIZIwgem0dpzwr1VU3oW6qJSFJbKaNzMJNcOEo+MeA
 8eJmDAAPl+Yuee27VVu0JaiiIUoplp7C4j+BKUi8zEu4UseO82/P4XKNX5+qBtumw/fITM0
 UD02wyjI+gdzBndvPw79exfGssOCO4rBHmu3e7/68+dlci8hXQvqYQnm4/sPYG8pIoX0E1M
 UzCwA2U58QCX5xCfxynSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e8vvY/+OV28=:Txs/+IWC3QVPcfwoQpPcFU
 MNDIG1mBm8jBCGpgDm3JKCD0UyNqUqXPn1BfGJVF9O8YPFzgIHy6/gmorQupeS4KT96MzOvOI
 NFIBeJmqs2+brOGBm+2rt7iCpmVFGBwQk9GLt8I8VjYz8YB2IjmpzxZkvmyTZCfB9l82BkJna
 9RUI1i8+BQJVGQOjPx+SmmYBnykQ5JB7PWYzJZpOHP7GRc6N9iONxxFT2k0c1Z5ouzhGchhKG
 dcCdcQ2up+9LvSOQrud2OaUM+fAHSviiJhZhZyM6P7ATz8NAibgTcsQsUnsMMUfa29Yt3J/V3
 1vTyUtCx6o9cPal7S9ZxQbSzHR1QUwaTo9rQ33lT8wFvOYZ4wGav91MtVWVWeGoWihxehhtwS
 3i5BxpD4LS7wQRXvrtcWxmowDCRSIuOV6/bMT71AOQ8ONIiVkACqNwStwJNWoEz8fs3y6klyI
 G357hBG0fM8JeivpdNofSWh7Oa/lsuNdrxneLFiKf9t5DgK04aoJE6JNghyCbcLMspfdF7IXC
 f+bXG4EOyvoLhLPVK5yBfZUA8m0QEmJJWhzzBS5zSAGqC42pdXDx26Q7wdy3NXVgnB5xVK0jO
 jsSCf7XbQ1yZk1prByXVYuLSGtouGK19UEXb4PwFlO0Du9Xr0TbWN/Z0q4/Vns4foAuvg21ic
 IwDexcIeIRzk9F+h91saxE7k2j6ukJBDfLAMG2gKrNNlnbymyAr83QXfbWVlSJdZHiLA84Ho/
 L/M89lKWMysJ/BMnH4yo6lL1IVotHqOUt1n846UfBFJeBI4SJByhlRmfrnQQ29bOe81umW9KN
 egWGgMn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 6 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > If you prefer to accept such sloppy work, I will change it of course,
> > feeling dirty that it has my name on it.
> 
> I do want neither leaks nor sloppyness, and I thought that was
> understood by everybody, hence I thought the last round made it
> clear that _entrust() must not exist.

Well, you leave me with but one choice. With shame in my face I will send
out the next re-roll with this construct:

@@ -796,24 +1002,52 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
                opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
        else if (!strcmp(key, "options.mainline"))
                opts->mainline = git_config_int(key, value);
-       else if (!strcmp(key, "options.strategy"))
-               git_config_string(&opts->strategy, key, value);
-       else if (!strcmp(key, "options.gpg-sign"))
-               git_config_string(&opts->gpg_sign, key, value);
+       else if (!strcmp(key, "options.strategy")) {
+               if (!value)
+                       config_error_nonbool(key);
+               else {
+                       free(opts->strategy);
+                       opts->strategy = xstrdup(value);
+               }
+       }
+       else if (!strcmp(key, "options.gpg-sign")) {
+               if (!value)
+                       config_error_nonbool(key);
+               else {
+                       free(opts->gpg_sign);
+                       opts->gpg_sign = xstrdup(value);
+               }
+       }
...
@@ -37,18 +26,32 @@ struct replay_opts {

        int mainline;

-       const char *gpg_sign;
+       char *gpg_sign;

        /* Merge strategy */
-       const char *strategy;
-       const char **xopts;
+       char *strategy;
+       char **xopts;

(this is not the complete diff, of course, but you get the idea.)

Ciao,
Dscho
