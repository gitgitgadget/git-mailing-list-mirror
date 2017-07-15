Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8E762027C
	for <e@80x24.org>; Sat, 15 Jul 2017 11:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751184AbdGOLMa (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 07:12:30 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35223 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdGOLM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 07:12:29 -0400
Received: by mail-wm0-f41.google.com with SMTP id w126so39563440wme.0
        for <git@vger.kernel.org>; Sat, 15 Jul 2017 04:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=QhPeBNrDHAKwUj87uzlMxiq+3w2t8/YghzVZVNCPaOg=;
        b=BNffQQRjXM/nSp+RnvE/lktz2gfx08HTZU4oJvALwL6TjuzhEvvgyiJYm1wl7EnRkp
         rAs7sAuiQ9miD5LuulvRyo/XeSg4M9fDEiJJ5RCi2oWrCwQerQoVngP6lWCZCQ+t2YHL
         gaqEDFRXU9EgMjmrWvYgo2qZXExRGcmtv/RJb/hTUsTPURAJa7SVkxRG4CRL1OIlYXyX
         JEAh2QMeWP0mhIkGQgddbi+iPRC6eJoDRK4nn8WtnCuRe9nWtzYFp1mBNRKflc1taWl2
         SQvSnlswYsYDXewCR8Jc50QQ5fdc/H9pH9yZk4G+Qw7sSdA7FMErB2KgKv7MO6F4xnwP
         cWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=QhPeBNrDHAKwUj87uzlMxiq+3w2t8/YghzVZVNCPaOg=;
        b=G7HTnF90TOlvLl6BT+xT43FSj5yxSpPyWTkgflGR+qtFrgdGpKkuCmTXJeEJpN8wLy
         rDRgfhiTdb6AmTp1BHVho1ltTY+jJYIWhBO9UtTQaowNJ6HLb0XHGoiWmm0m1nOJT41O
         y5N5xv+nC97rwmR15fcIy5Dc+ch9UPDvrhoGNZpA1A+xmY2+t+MHHJPba0JI+4S0qsQ7
         0sdWoZhsMiw990r7RtKZruTWa9sLnRlQTDnEaMniyBqlgvXGT2urlCw3Gb6vBl3eyr49
         cCf8ZmnFkaUOOk5cT5yw3TME1sIO+iJNzEVu2T+pwzq1B1YAv9iuqAiKERyaF9grA8HY
         t2sw==
X-Gm-Message-State: AIVw11188K2cInhhCKJaZeESwz1UhEkjcLBn5XffUhfWCm4uci5G4VUY
        ejezcaQ83A+EXtYKrJw=
X-Received: by 10.80.144.68 with SMTP id z4mr10321328edz.143.1500117147872;
        Sat, 15 Jul 2017 04:12:27 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id g25sm5399623eda.59.2017.07.15.04.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jul 2017 04:12:26 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dWKzp-0002B3-UC; Sat, 15 Jul 2017 13:12:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2017, #04; Thu, 13)
References: <xmqqo9snsy0k.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqo9snsy0k.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 15 Jul 2017 13:12:25 +0200
Message-ID: <87iniu2bty.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 13 2017, Junio C. Hamano jotted:

> Here are the topics that have been cooking.  Commits prefixed with
> [...]
>
> * jc/allow-lazy-cas (2017-07-06) 1 commit
>  - push: disable lazy --force-with-lease by default
>
>  Because "git push --force-with-lease[=<ref>]" that relies on the
>  stability of remote-tracking branches is unsafe when something
>  fetches into the repository behind user's back, it is now disabled
>  by default.  A new configuration variable can be used to enable it
>  by users who know what they are doing.  This would pave the way to
>  possibly turn `--force` into `--force-with-lease`.
>
>  Will wait for feedback, then merge to and cook in 'next'.

Aside from the feedback I just sent now 87k23a2d28.fsf@gmail.com,
there's my outstanding comment on the config variable name in
877ezkbn6x.fsf@gmail.com which is waiting on your feedback.

> * sd/branch-copy (2017-06-18) 3 commits
>  - branch: add a --copy (-c) option to go with --move (-m)
>  - branch: add test for -m renaming multiple config sections
>  - config: create a function to format section headers
>
>  "git branch" learned "-c/-C" to create and switch to a new branch
>  by copying an existing one.
>
>  Undecided.
>
>  I personally do not think "branch --copy master backup" while on
>  "master" that switches to "backup" is a good UI, and I *will* say
>  "I told you so" when users complain after we merge this down to
>  'next' and eventually to 'master'.

For anyone following along with this. The reason Sahil & I hacked it up
like that is because that's analogous to what the --move option does.

Let's see what *nix does:

    $ rm -rf /tmp/{master,backup}; mkdir /tmp/master && cd /tmp/master && mv /tmp/{master,backup} ; file /tmp/{master,backup}
    /tmp/master: cannot open `/tmp/master' (No such file or directory)
    /tmp/backup: directory

Similarly to that, when you're on "master" "git branch --move backup"
could have left you on an orphan branch, but it doesn't, it's the
equivalent of "mv && cd" in *nix terms.

So since our --move is really --move-and-checkout I think it would be
confusing to introduce a --copy sister option that has the semantics of
--copy-no-checkout instead of a corresponding --copy-and-checkout.

I think it's easier to explain & use an option that's "like --move
except the old branch doesn't get deleted", which is what this does,
instead of "actually not analogous to --move at all".

I happen to want to use this for something where the semantics on that
topic work better for me, but I recognize that that's just a matter of
taste, if we were green-fielding this I wouldn't mind either way.

But since we're not, and especially with all the confusion around
checkout/branch (some of the hairiest UX in git) I think our --move &
--copy should be symmetric in the same way that mv(1) an cp(1) are
symmetric. Let's not add yet another special case to whether a ref is
created/checked out when being manipulated by some mode of
checkout/branch.
