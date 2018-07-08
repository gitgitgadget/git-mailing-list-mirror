Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CBD21F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 21:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754377AbeGHVoS (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 17:44:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:57283 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754370AbeGHVoR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 17:44:17 -0400
Received: from MININT-6BKU6QN ([89.204.155.168]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LxMgg-1g8ip91FFa-016z2U; Sun, 08
 Jul 2018 23:44:09 +0200
Date:   Sun, 8 Jul 2018 23:44:08 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratik Karki <predatoramigo@gmail.com>
cc:     git@vger.kernel.org, christian.couder@gmail.com,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v4 4/4] builtin/rebase: support running "git rebase
 <upstream>"
In-Reply-To: <20180708180104.17921-5-predatoramigo@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807082331490.75@tvgsbejvaqbjf.bet>
References: <20180628074655.5756-1-predatoramigo@gmail.com> <20180708180104.17921-1-predatoramigo@gmail.com> <20180708180104.17921-5-predatoramigo@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:V5+gP7QM1SLHyZNjeDwvb9iebpjT9R6KnC8Ls0Ln6nbHRIOkjzT
 OgxRYO74dajDpkQ+UejymRFERtuK1jilfriI6HELbLeYUtPopga1Ryij/BMM5LegpSAcIaP
 IXTU6GStWBF3lBf4LA63LpqfEUDv2qqjRJlW5TCbO4U6oAYlPnDzNirmT+RTczTeBr5CTPN
 4xMJQKu4H/iazrArcF2NA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:51zJFXgG/OE=:tsoD/MUdNKrMgu166vnbfJ
 VLmKcWQGFBobrecIOPzJSaAwU3x9szhrZGL40f8Dpx5NGIDe4AKcmud6SV4dvus8l3A0Ur5it
 7t9dpQwbpEozGRZUfluoS1XitNkowkQNb7YnfeaX/nF9I6VcN9bWGKJ7h8nIcD3FsmSxPSYbE
 wrS/QJSJm/cN/4VibH7l9/WBVfh/o0P7t/Psj9sZ7FOsZKDir4chaz2aWHBAhuNOMXV96UErd
 VrZlUSBEPoOzYqZewgU2wZminPsq6KNs6Y/Cs6GW/FAaENWXoIWHonNzo86yEe1fYmzlXzJGC
 NndJEZWJh86def3+KG+gMyMrfgNg+uJaGMS6VrVuFR34YqdmrWbnw37j64kNsLE3sKXV1jKJB
 zyfxYY48vLkIdJkozwO6ITAtMJAhx9NcwmHRm5e9TaJxXKWckV6BM76+z7JTnb2PCJbBax/e3
 R5/Z8JrsO/T0o5QRS3LWzhSuOgZQzZPYgHyyO8DT7NM1bbWUY4SWONhMnua5jRjw2KnjLxcTi
 lRRng0jSpUHJKbhIM5z5M+Pb+WoGyO0jkORChHwRVxtbwT3pPDd9ON2AfLxZSwNUiy/LY79sg
 Baici+1QPi/7AxQ9Wduxk2T1wiqFEeFpiHJaFuN24d5K65SuuSpQnldBaYUFduwi4ZS/WszhI
 AZ08nZ+e51mKRrfgRaz0MFwrk0yDXHa1W1tjqFcVO3iKdf9TI6hZSJObrRwx8Han0ItVn+qwE
 G27bB/hG3HYctbkWFguxUeepY4nkMJbOYuMavPFPiG+YayGvVMt9oFXolPTYMq9Dm+jJ79OS2
 a37AvGx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratik,

On Sun, 8 Jul 2018, Pratik Karki wrote:

> +	strbuf_addf(&script_snippet,
> +		    ". git-rebase--common && . %s && %s",
> +		    backend, backend_func);

In my quick test (on top of `wip-rebase`), this line needed this change:

-- snip --
@@ -269,7 +279,8 @@ static int run_specific_rebase(struct rebase_options *opts)
        }

        strbuf_addf(&script_snippet,
-                   "set -x && . git-rebase--common && . %s && %s",
+                   "set -x && "
+                   ". git-sh-setup && . git-rebase--common && . %s && %s",
                    backend, backend_func);
        argv[0] = script_snippet.buf;
-- snap --

Obviously, the `set -x && ` part was not part of the patches you sent to
the Git mailing list, so please do not let that distract you from the fact
that I had to source also `git-sh-setup` (it implies `git-sh-i18n`, and
the `eval_gettext` function is defined there and used in the
`move_to_original_branch` fnuction).

With this (and the REF_NO_DEREF change), t3404-rebase-skip.sh passes,
which is pretty cool.

Ciao,
Dscho
