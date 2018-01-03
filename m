Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CB431F406
	for <e@80x24.org>; Wed,  3 Jan 2018 14:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeACOWC (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 09:22:02 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33855 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752332AbeACOWB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 09:22:01 -0500
Received: by mail-wm0-f68.google.com with SMTP id y82so20367925wmg.1
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 06:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=fnSMASJ2UEVYjcYBOpbWUjgql/fYy5L+G5UnzE1PWH4=;
        b=me1Ik1iAlec8wAj0wiyH0Qe+JCzy6eS2ZJUGFr8owlUMGT+zCSTm/Qu2Evm4iDVwwu
         fcVHETv5Exyu41fIg9rv+nDa8HVOGCdGRUn1widqKh8/Nm5kl/r3YsCHD7d9vMlaZ0UA
         fz6BWQhwXnh5GBCSmf+2Umbfu7DDEhrg5V17jQLmMLhdx4fKXtlSlQOcF2AYM8j5xDef
         70jPPw/5V0EdOmm+ZhhtcKalJuWJbTSmI+nFtMCEezhoVjlqX76B9IKMYhwFMgS8hQ+k
         +veCBkgSuPPrBuGgUmDSniICqCrCAc+HXZFGgZ1fAH1K9qzPaKpvGcgwLWyaPIMSucIl
         HXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=fnSMASJ2UEVYjcYBOpbWUjgql/fYy5L+G5UnzE1PWH4=;
        b=nB+r2skKnQPGx+hw0j4smhlk5OSbxIPF05XrlQrF+AJjCXp/hQPiUHSeE1aki8/QWH
         UdKt3IZY15Q3Ilf6ALP/GjAGysP+LfrgeM+JeJsaSV9INbCAno7hIowItTUkXDX+ik0T
         5a9fCfLWMtCclzK0Kzi6PVXllUFhEmGMdMN++y3Ej+ijJrGdfo3BsSaSPrsCNUAsnnH8
         DSnRFiJhk/NWwuyGTzt+R4/cLEGYu+LAyhIT8alsC3TSTU+gT0zmEKxFETlMbgytRi3n
         xZI7r03NxjW1W80Wov5gD1/8VAXUmKtNsccgZIrwzWMKFGbocvbe58H2UGtdk5rk4E/K
         Jp0g==
X-Gm-Message-State: AKGB3mLJ7wBWu8/oX4fX5StoUJzL4sJd4n2IMJ7MIFsSnDZ66yEqdzwa
        x9LMhWIN0wP1puslQU6uwks82oZ1
X-Google-Smtp-Source: ACJfBotLa1eVTLije5jTppSP8AZwmwoTlWU3BtqZZgIm/75HZAQi3LqN+EikGZ2Y46j1xiBy5pxI+g==
X-Received: by 10.80.136.49 with SMTP id b46mr2899346edb.155.1514989319939;
        Wed, 03 Jan 2018 06:21:59 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id e29sm812433edd.44.2018.01.03.06.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jan 2018 06:21:58 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Yasushi SHOJI <yasushi.shoji@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [BUG] v2.16.0-rc0 seg faults when git bisect skip
References: <CAELBRWKYZK2tVhGZSExXRXrRB94jFN-4N3d=iKARzEsqLu7k1g@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CAELBRWKYZK2tVhGZSExXRXrRB94jFN-4N3d=iKARzEsqLu7k1g@mail.gmail.com>
Date:   Wed, 03 Jan 2018 15:21:57 +0100
Message-ID: <87fu7nc9a2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 03 2018, Yasushi SHOJI jotted:

> Hi,
>
> git version 2.16.0.rc0 seg faults on my machine when I
> [...]
> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  0x000055a73107f900 in best_bisection_sorted (list=0x0, nr=0) at bisect.c:232
> 232 free_commit_list(p->next);
> (gdb) bt
> #0  0x000055a73107f900 in best_bisection_sorted (list=0x0, nr=0) at bisect.c:232
> #1  0x000055a73107fc0f in do_find_bisection (list=0x0, nr=0,
> weights=0x55a731b6ffd0, find_all=1) at bisect.c:361
> #2  0x000055a73107fcf4 in find_bisection (commit_list=0x7ffe8750d4d0,
> reaches=0x7ffe8750d4c4, all=0x7ffe8750d4c0, find_all=1) at
> bisect.c:400
> #3  0x000055a73108128d in bisect_next_all (prefix=0x0, no_checkout=0)
> at bisect.c:969
> #4  0x000055a730fd5238 in cmd_bisect__helper (argc=0,
> argv=0x7ffe8750e230, prefix=0x0) at builtin/bisect--helper.c:140
> #5  0x000055a730fcbc76 in run_builtin (p=0x55a73145c778
> <commands+120>, argc=2, argv=0x7ffe8750e230) at git.c:346
> #6  0x000055a730fcbf40 in handle_builtin (argc=2, argv=0x7ffe8750e230)
> at git.c:554
> #7  0x000055a730fcc0e8 in run_argv (argcp=0x7ffe8750e0ec,
> argv=0x7ffe8750e0e0) at git.c:606
> #8  0x000055a730fcc29b in cmd_main (argc=2, argv=0x7ffe8750e230) at git.c:683
> #9  0x000055a731068d9e in main (argc=3, argv=0x7ffe8750e228) at common-main.c:43
> (gdb) p p
> $1 = (struct commit_list *) 0x0
>
> As you can see, the code dereferences to the 'next' while 'p' is NULL.
>
> I'm sure I did 'git bisect good' after git _found_ bad commit.  Then I
> typed 'git bisect skip' on the commit 726804874 of guile repository.
> If that matters at all.
>
> I haven't touched guile repo to preserve the current state.

I can't reproduce this myself, but looking at the backtrace it seems
pretty obvious that 7c117184d7 ("bisect: fix off-by-one error in
`best_bisection_sorted()`", 2017-11-05) is the culprit.

That changed more careful code added by Christian in 50e62a8e70
("rev-list: implement --bisect-all", 2007-10-22) to free a pointer which
as you can see can be NULL.

If you can test a patch to see if it works this should fix it:

diff --git a/bisect.c b/bisect.c
index 0fca17c02b..2f3008b078 100644
--- a/bisect.c
+++ b/bisect.c
@@ -229,8 +229,10 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
                if (i < cnt - 1)
                        p = p->next;
        }
-       free_commit_list(p->next);
-       p->next = NULL;
+       if (p) {
+               free_commit_list(p->next);
+               p->next = NULL;
+       }
        strbuf_release(&buf);
        free(array);
        return list;

But given the commit message by Martin maybe there's some deeper bug here.
