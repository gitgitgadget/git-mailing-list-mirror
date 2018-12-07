Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B8DC20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 19:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLGTZj (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 14:25:39 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:34248 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeLGTZj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 14:25:39 -0500
Received: by mail-ed1-f45.google.com with SMTP id b3so4615431ede.1
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 11:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=kj06v6o8dQrjzAtUDCoVMXcJAmHMHoLHdfQHYn0DMjk=;
        b=u4i9+xex/XRGXbmjusikh0m3iw4l8/Qrr08xeJtCQF9jJsffUA3RZFUjRmJ8i/mfWo
         Yl6Vg/1//NNMkLkL1KDw+P9C967dTqsMNNNfYGrsTVxkugc+ydbA7DSVVY43Y/N2uVMt
         8Pu7+hG42W9XNRL38AMzox4KXNh3h1xCZZ0KNjiAX20qNXG3q+piKrkOsr0MzRFAgV08
         ESmIaFKGKDdgDbsSsVvJU5yaaFby3vPml+xB6IdkV3C0a6Mulyja8kd2Itt283U9rX3a
         aUt0vXjT+pu+ha4+D27IENRXSdoEvRPgOFkc/8rzI80lvosGLjsHWQP83DDTM1gAiab+
         CC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=kj06v6o8dQrjzAtUDCoVMXcJAmHMHoLHdfQHYn0DMjk=;
        b=qodIWEo9Lys+JNIKz8Qo4IoAr73whsgxXbQlYE6ttaU/jeIkevaQCo9DB+ZKPtiCUe
         Dtrxmn90fPUui/61WGgqMUbz+eGbKk2KRWaH9cK857IfK0rqXgt8K4hc/XyXATgpM4X6
         Cnuo90Ho6n+js+KKnoehgCDA89l6RAaAHSAM1RqL2MrehlqUHbzSb44ZFeddIZVfuQWA
         8QVuFltRtTJxadrWJP/TU/qNB7SqrXcm+E2hESIuXgeUgxTgQHyiLPNhVxx748v7Izxv
         b3lNWj/GlviVW0qe/y3oh4uD9jauycqKMPUI7NNz5urpVJI0kiZox7E27I/FH2ymmJg6
         G3bQ==
X-Gm-Message-State: AA+aEWbS6bGnazUymsxHNhYFCKI+YBU9gCBMb/Prs7UF3I+pqjGOLRDa
        6o/1OXZZPXQKJ477ulD85G0=
X-Google-Smtp-Source: AFSGD/Wrp3c38w+3tyrzCdb5LCFC2fql0mHPE3J38vN3nOxmQgx2pWYVfpQfr5qdKc3u9lAjr5nm/A==
X-Received: by 2002:a17:906:ca03:: with SMTP id jt3-v6mr2775520ejb.165.1544210736929;
        Fri, 07 Dec 2018 11:25:36 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id v20sm1233302edm.29.2018.12.07.11.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 11:25:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: RFE: git-patch-id should handle patches without leading "diff"
References: <20181207181942.GA6411@pure.paranoia.local>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181207181942.GA6411@pure.paranoia.local>
Date:   Fri, 07 Dec 2018 20:25:33 +0100
Message-ID: <87va45xhoy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 07 2018, Konstantin Ryabitsev wrote:

> Hi, all:
>
> Every now and again I come across a patch sent to LKML without a leading
> "diff a/foo b/foo" -- usually produced by quilt. E.g.:
>
> https://lore.kernel.org/lkml/20181125185004.151077005@linutronix.de/
>
> I am guessing quilt does not bother including the leading "diff a/foo
> b/foo" because it's redundant with the next two lines, however this
> remains a valid patch recognized by git-am.
>
> If you pipe that patch via git-patch-id, it produces nothing, but if I
> put in the leading "diff", like so:
>
> diff a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
>
> then it properly returns "fb3ae17451bc619e3d7f0dd647dfba2b9ce8992e".
>
> Can we please teach git-patch-id to work without the leading diff a/foo
> b/foo, same as git-am?
>
> Best,
> -K

The state machine is sensitive there being a "diff" line, then "index"
etc.

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 970d0d30b4..b99e4455fd 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -97,7 +97,9 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 		}

 		/* Ignore commit comments */
-		if (!patchlen && !starts_with(line, "diff "))
+		if (!patchlen && starts_with(line, "--- a/"))
+			;
+		else if (!patchlen && !starts_with(line, "diff "))
 			continue;

 		/* Parsing diff header?  */

This would make it produce a patch-id for that input, however note that
I've done "--- a/" there, with just "--- " (which is legit) we'd get
confused and start earlier before the diffstat.

So if you're interested in having this I leave it to you to run with
this & write tests for it, but more convincingly run it on the git &
LKML archives and see that the output is the same (or just extra in case
where we now find patches) with --stable etc.
