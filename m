Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9B21F597
	for <e@80x24.org>; Thu,  2 Aug 2018 15:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387700AbeHBRgF (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 13:36:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54092 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387654AbeHBRgE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 13:36:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so3053330wmh.3
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 08:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZAoIec3WDb86CpZunwAcXeq1v75nOEP/OyypNX9y+l8=;
        b=iJ5cUzsNRZoCzKrgjTaiub0OCKV3wyIa493QTgZfsNduLexx2twom8xGDhYkzGBt8p
         N5ipfJIAV/VUI8IsJ+wuVuNETdv8JCb/tV25wK2O3G1SkpllY1aWcP9C2ExJYHjwWqug
         yY+x7hDgQtGmCjHaR3N8oAx978viRmudNBmeDOAkNYq93FKYPzy/2l6zsbxHXuMiKm4b
         /wq0lTnLVdoEHQmD8mJW63EckuwoeYSZ+hULHL8e1uBtB85s6zYM2EOpJ9t+fnM99cjs
         geUWerqjPoYtv7pGxfrba/VBY640Qtm9u0JD4Ny9f519UL66lyLJDsYYoyCUNERIQJgs
         kFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZAoIec3WDb86CpZunwAcXeq1v75nOEP/OyypNX9y+l8=;
        b=B3b9FrCTcft6RWwm2svbJrw3j5aS/ndT5F+DqKpQoHJAa2Odnn2ORhua/hUYss8xdh
         1vE01zay0zQexC4IWz8qZ6lJq4C0PsbwVznn/FcoKRLlQmvdOUrGxgup4VXkHv0peOlb
         GHAv+abqr7L9Fg+2NH3ZjXY/AJF8kR8vaq0IDeEAiW7cT/3h5nVQnYd3wyE43sfbEa48
         d9Skxy/LbkWEBv5XjlRad0LL+sfqpg7QGcHSchyJYMIaVMz0egW155baa1R8w7vem86f
         faqXTQrw0cpwTaJTm0WIuFYvQLAmU6kTdnIaVdU49d8UiMQVq+D6wAscjlRTNGTEQpbN
         fCLA==
X-Gm-Message-State: AOUpUlHln6BasZrJubynq6GLehEl4GbnyLBSjedwWvrhS/QcB3uXCP7I
        f1tzXPnQmo7GYytg0c7+WDnVsipf
X-Google-Smtp-Source: AAOMgpcWLkrkCYG1cmrZKZvFDh7vWlSpBNFR8StgtwcGt6+BMFu1552DGOwNKuKFXkq7AtGyHgGINQ==
X-Received: by 2002:a1c:9bc5:: with SMTP id d188-v6mr2494164wme.33.1533224659623;
        Thu, 02 Aug 2018 08:44:19 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2177788wrv.2.2018.08.02.08.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 08:44:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re* [PATCH] push: comment on a funny unbalanced option help
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
        <87k1p9u860.fsf@evledraar.gmail.com>
        <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 02 Aug 2018 08:44:18 -0700
In-Reply-To: <xmqqwot969mp.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 01 Aug 2018 14:48:46 -0700")
Message-ID: <xmqq36vw4vu5.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>> +		  /* N_() will get "<>" around, resulting in "<refname>:<expect>" */
>>
>> ...but this comment isn't accurate at all, N_() doesn't wrap the string
>> with <>'s, as can be seen by applying this patch:
>
> I know.  It is a short-hand for "what's inside N_() we see here".
> Try to come up with an equivalent that fits on a 80-char line.

OK, let's scrap the comment patch but do this instead.

If we decide to take René's "auto-literal" change, the update to the
arg help string in this patch will become a necessary preparatory
step, even though "auto-literal" will make the addition of the
PARSE_OPT_LITERAL_ARGHELP bit redundant.

-- >8 --
Subject: [PATCH] push: use PARSE_OPT_LITERAL_ARGHELP instead of unbalanced brackets
From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Date: Thu, 02 Aug 2018 00:31:33 +0200

The option help text for the force-with-lease option to "git push"
reads like this:

    $ git push -h 2>&1 | grep -e force-with-lease
       --force-with-lease[=<refname>:<expect>]

which comes from having N_("refname>:<expect") as the argument help
text in the source code, with an aparent lack of "<" and ">" at both
ends.

It turns out that parse-options machinery takes the whole string and
encloses it inside a pair of "<>", to make it easier for majority
cases that uses a single token placeholder.  

The help string was written in a funnily unbalanced way knowing that
the end result would balance out, by somebody who forgot the
presence of PARSE_OPT_LITERAL_ARGHELP, which is the escape hatch
mechanism designed to help such a case.  We just should use the
official escape hatch instead.

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 1c28427d82..ef4032a9ef 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -542,9 +542,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
 		{ OPTION_CALLBACK,
-		  0, CAS_OPT_NAME, &cas, N_("refname>:<expect"),
+		  0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
 		  N_("require old value of ref to be at this value"),
-		  PARSE_OPT_OPTARG, parseopt_push_cas_option },
+		  PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP, parseopt_push_cas_option },
 		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, "check|on-demand|no",
 			N_("control recursive pushing of submodules"),
 			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
-- 
2.18.0-321-gffc6fa0e39



