Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D6992049B
	for <e@80x24.org>; Sun, 25 Dec 2016 00:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbcLYAw7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Dec 2016 19:52:59 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:35866 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbcLYAw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Dec 2016 19:52:58 -0500
Received: by mail-io0-f175.google.com with SMTP id h133so41017963ioe.3
        for <git@vger.kernel.org>; Sat, 24 Dec 2016 16:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dClsA7KLKfruZVfZ23JjCuV8oTAEzhhesDhsGYOBPls=;
        b=A833I6gBmRa6X/OnpfcgQskubNmxJ+wx4w++83LBQIA2RInyyMFCHTePVFMud/g5gv
         CTxcjt1PIhiQ4GlKdCP9GcjTe4voePg+HXW62VMx1RICTG3zHAOiiGemcnFhJMHuyx/+
         rkGSpAYaIRmIPKL51gK7SBSZ8HduF728Zp8ftI8sJtgElkrvtsw6PH7Ft9+/XE7jCaQc
         dKKoeEeSOXA4dH5ewTh2B5AckepM7/a8pwYkmE9mMSOhdKqnE/qs+NLSnwVNyvrU+Sk7
         Ymx5Yo6CO3NuQw5OcIvOoozKxR0Uyv1dMkJl6riOf3sUEs7HNNTJ/Q7QfGD8SIAsLTw8
         mVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dClsA7KLKfruZVfZ23JjCuV8oTAEzhhesDhsGYOBPls=;
        b=GDJPM365XonP8fGfPeQ8Gpj4kUchiAf9QXJXWb3cyDel+anLGWEqVW/rdXwFl7Llz4
         h3uOKBVgARe2WCM9Na1MZPNs1JCjmi4QYTv2CELUQEkN4zyfIzhi8xucmNOQ8fdCa59p
         N+pkV5bmfeP4kxe22Y2znlXd1utXyKxYS+M2s8YrvxfAewSUeCpRscJ9JrgdbSnBVZQ9
         3aA+xcuCDKvwxKOgVd1MSJ4Cyf8WFrbGFLLdvkcW/Kax2jlKpgX6LR4F9Bs5pCTfG8Ky
         6u/6N8dbvT9+TZXaLDn3VyffTmFKzJuFJJKlH2KGj0R2tjYbQZpLNrq86oCW9OkolvpL
         qB8Q==
X-Gm-Message-State: AIkVDXK2p56kX0D/euoqIhhs8y04IzZJIMRec+naUzl9Z4NaejN4L9J8s4+sS93y8EgOrPu6wsPtuw/4qwLguQ==
X-Received: by 10.107.198.9 with SMTP id w9mr7946444iof.19.1482627177448; Sat,
 24 Dec 2016 16:52:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Sat, 24 Dec 2016 16:52:26 -0800 (PST)
In-Reply-To: <20161222221327.7354-1-sbeller@google.com>
References: <alpine.DEB.2.20.1612222239390.155951@virtualbox> <20161222221327.7354-1-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 25 Dec 2016 07:52:26 +0700
Message-ID: <CACsJy8B8uaKGqc0MV0v35RT0i0P=Fo8Md0J2BtA25cq5+d4t5g@mail.gmail.com>
Subject: Re: [RFC/PATCH] add diffstat information to rebase
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 23, 2016 at 5:13 AM, Stefan Beller <sbeller@google.com> wrote:
> *Ideally* I would rather have a different formatting, e.g. maybe:
>
>     $ git checkout remotes/origin/js/sequencer-wo-die
>     $ git rebase -i --new-magic v2.10.0-rc2^
>
> which produces:
>
>     pick d5cb9cbd64 Git 2.10-rc2                                    | Documentation/RelNo.., GIT-VERSION-GEN -..(+5, -1)
>     ...
>     pick dbfad033d4 sequencer: do not die() in do_pick_commit()     | sequencer.c - do_pick_commit              (+7, -6)
>     pick 4ef3d8f033 sequencer: lib'ify write_message()              | sequencer.c - write_message, do_pick_com..(+11, -9)
>     ...
>     ...
>     pick 88d5a271b0 sequencer: lib'ify save_opts()                  | sequencer.c - save_opts + sequencer_pick..(+20, -20)
>     pick 0e408fc347 sequencer: lib'ify fast_forward_to()            | sequencer.c - fast_forward_to             (+1, -1)
>     pick 55f5704da6 sequencer: lib'ify checkout_fast_forward()      | sequencer.c - checkout_fast_forward       (+6, -3)
>     pick 49fb937e9a sequencer: ensure to release the lock when w... | sequencer.c - read_and_refresh_cache      (+6, -3)

Instead of guessing the changes based on diffstat, you could add the
actual commit message (besides the subject line) after that '|' for
fixup! and squash! commits (and it's probably should be "#" instead of
"!"). Then you could just describe what you have changed in the commit
messages. If you don't use autosquash, you'll need some way to mark
"to-be-merged" commits though, so that you don't put all commit
messages here.
-- 
Duy
