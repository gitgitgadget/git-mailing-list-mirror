Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63E1F1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 20:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeCYU52 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 16:57:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38942 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeCYU51 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 16:57:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id f125so11879760wme.4
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 13:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/itiSbnXiIROYewZ4L803qedkBKttulsokdT6/iqwYU=;
        b=cpecWLSzS5ec7KNtcrz9PLZgK1JjKfcCcsxCXUKJG/rK922tQ8oyWbz2r1s51nRtGO
         VVcXD2aJYS2tgBmViALwX9ykQT9qAjZrWPI92IegWO2rmhT2y4I+AvH4LkBRVe9crN8X
         bvbk/xtaWo0UvO3bU0aGI8uU2smA6eIE8q4UOR/mHD0B+qhUBlbPlAVc/L47GXq56btN
         3YrR0t175sbkIgsLEjUcKNQi9auzS7D8p64E/SdLjqzKvqWK+tUaWbYlIiTjbD5youN7
         Ss/WzQRpqmHeoPJNIF6mzvXb+qCwBG7vJjlMgGFt+pA9+prc6pv8QMBYcM0XjU7o1v5J
         01aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/itiSbnXiIROYewZ4L803qedkBKttulsokdT6/iqwYU=;
        b=ow72QVzoERGYfECakziq35xT+2Mie5d1eKimdOl80KFwAZFGrDVAtpX3AConHrq5hB
         duW2QV/oPmkakmTNxfi18n7oqzxmeJvTRyuN3ChaRnVO9g0WrN94ayfhXVCBAaLyeHAp
         A+7HKok8ZjblpBpjx3lLSIPybxdWavYn7UVr2GqQpyEa/Hu/I844j4+yhUfUoA24vtFP
         P7AKY2mO4wMIYDcaRBIdRrWzPF4L4SDjGlYOZYWPvB9/M1gEee0SixXkSCFkoKcNxJ4p
         7dqv4TGsOD1uIZRk3tGm34/LGk3mbO1+OIG/AQo82D7QysPJoNVq+osihz+fgeYgCu8l
         LGPg==
X-Gm-Message-State: AElRT7GP06J4ZAWg8kPBHo6ZgseHvzyeBaX6DXAOjiowXICaTyLItYDg
        wXLA+z8EG0EqMYol2UMWZFrd0kRf
X-Google-Smtp-Source: AG47ELtbQ7lh5nTcZMKarJMN2QbVfl6RtIRbYPAVCLW2DMBqQ7nZ2rUPN6tNcy42YvhVl420iSyIrA==
X-Received: by 10.80.246.3 with SMTP id c3mr32516808edn.185.1522011445701;
        Sun, 25 Mar 2018 13:57:25 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id h64sm8384874edc.86.2018.03.25.13.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 13:57:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Joel Teichroeb <joel@teichroeb.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH] Remove contrib/examples/*
References: <CA+CzEk9QpmHK_TSBwQfEedNqrcVSBp3xY7bdv1YA_KxePiFeXw@mail.gmail.com> <20180325204653.1470-1-avarab@gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180325204653.1470-1-avarab@gmail.com>
Date:   Sun, 25 Mar 2018 22:57:23 +0200
Message-ID: <878tafyito.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 25 2018, Ævar Arnfjörð Bjarmason wrote:

> There were some side discussions at Git Merge this year about how we
> should just update the README to tell users they can dig these up from
> the history if the need them, do that.
>
> Looking at the "git log" for this directory we get quite a bit more
> patch churn than we should here, mainly from things fixing various
> tree-wide issues.
>
> There's also confusion on the list occasionally about how these should
> be treated, "Re: [PATCH 1/4] stash: convert apply to
> builtin" (<CA+CzEk9QpmHK_TSBwQfEedNqrcVSBp3xY7bdv1YA_KxePiFeXw@mail.gmail.com>)
> being the latest example of that.

The people on CC got this, but it seems the git ML rejected the message
as it's too big. The abbreviated patches is here quoted inline, and at:
https://github.com/avar/git/commit/cc578c81c2cb2999b1a0b73954610bd74951c37b

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>
> On Sun, Mar 25, 2018 at 6:51 PM, Joel Teichroeb <joel@teichroeb.net> wrote:
>> On Sun, Mar 25, 2018 at 1:09 AM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> It seems to me that the apply_stash() shell function is also used in
>>> pop_stash() and in apply_to_branch(). Can the new helper be used there
>>> too instead of apply_stash()? And then could apply_stash() be remove?
>>
>> I wasn't really sure if I should remove code from the .sh file as it
>> seems in the past the old .sh files have been kept around as examples.
>> Has that been done for previous conversions?
>
> I was skimming this patch and it seemed to me like it would be more
> readable if the *.sh code was removed in the same change (if
> possible). It's easier to review like that.
>
> Also, we should just stop maintainign contrib/examples/*.
>
>  contrib/examples/README                |  23 +-
>  contrib/examples/builtin-fetch--tool.c | 575 ---------------
>  contrib/examples/git-am.sh             | 975 ------------------------
>  contrib/examples/git-checkout.sh       | 302 --------
>  contrib/examples/git-clean.sh          | 118 ---
>  contrib/examples/git-clone.sh          | 525 -------------
>  contrib/examples/git-commit.sh         | 639 ----------------
>  contrib/examples/git-difftool.perl     | 481 ------------
>  contrib/examples/git-fetch.sh          | 379 ----------
>  contrib/examples/git-gc.sh             |  37 -
>  contrib/examples/git-log.sh            |  15 -
>  contrib/examples/git-ls-remote.sh      | 142 ----
>  contrib/examples/git-merge-ours.sh     |  14 -
>  contrib/examples/git-merge.sh          | 620 ----------------
>  contrib/examples/git-notes.sh          | 121 ---
>  contrib/examples/git-pull.sh           | 381 ----------
>  contrib/examples/git-remote.perl       | 474 ------------
>  contrib/examples/git-repack.sh         | 194 -----
>  contrib/examples/git-rerere.perl       | 284 -------
>  contrib/examples/git-reset.sh          | 106 ---
>  contrib/examples/git-resolve.sh        | 112 ---
>  contrib/examples/git-revert.sh         | 207 ------
>  contrib/examples/git-svnimport.perl    | 976 -------------------------
>  contrib/examples/git-svnimport.txt     | 179 -----
>  contrib/examples/git-tag.sh            | 205 ------
>  contrib/examples/git-verify-tag.sh     |  45 --
>  contrib/examples/git-whatchanged.sh    |  28 -
>  27 files changed, 20 insertions(+), 8137 deletions(-)
>  delete mode 100644 contrib/examples/builtin-fetch--tool.c
>  delete mode 100755 contrib/examples/git-am.sh
>  delete mode 100755 contrib/examples/git-checkout.sh
>  delete mode 100755 contrib/examples/git-clean.sh
>  delete mode 100755 contrib/examples/git-clone.sh
>  delete mode 100755 contrib/examples/git-commit.sh
>  delete mode 100755 contrib/examples/git-difftool.perl
>  delete mode 100755 contrib/examples/git-fetch.sh
>  delete mode 100755 contrib/examples/git-gc.sh
>  delete mode 100755 contrib/examples/git-log.sh
>  delete mode 100755 contrib/examples/git-ls-remote.sh
>  delete mode 100755 contrib/examples/git-merge-ours.sh
>  delete mode 100755 contrib/examples/git-merge.sh
>  delete mode 100755 contrib/examples/git-notes.sh
>  delete mode 100755 contrib/examples/git-pull.sh
>  delete mode 100755 contrib/examples/git-remote.perl
>  delete mode 100755 contrib/examples/git-repack.sh
>  delete mode 100755 contrib/examples/git-rerere.perl
>  delete mode 100755 contrib/examples/git-reset.sh
>  delete mode 100755 contrib/examples/git-resolve.sh
>  delete mode 100755 contrib/examples/git-revert.sh
>  delete mode 100755 contrib/examples/git-svnimport.perl
>  delete mode 100644 contrib/examples/git-svnimport.txt
>  delete mode 100755 contrib/examples/git-tag.sh
>  delete mode 100755 contrib/examples/git-verify-tag.sh
>  delete mode 100755 contrib/examples/git-whatchanged.sh
>
> diff --git a/contrib/examples/README b/contrib/examples/README
> index 6946f3dd2a..18bc60b021 100644
> --- a/contrib/examples/README
> +++ b/contrib/examples/README
> @@ -1,3 +1,20 @@
> -These are original scripted implementations, kept primarily for their
> -reference value to any aspiring plumbing users who want to learn how
> -pieces can be fit together.
> +This directory used to contain scripted implementations of builtins
> +that have since been rewritten in C.
> +
> +They have now been removed, but can be retrieved from an older commit
> +that removed them from this directory.
> +
> +They're interesting for their reference value to any aspiring plumbing
> +users who want to learn how pieces can be fit together, but in many
> +cases have drifted enough from the actual implementations Git uses to
> +be instructive.
> +
> +Other things that can be useful:
> +
> + * Some commands such as git-gc wrap other commands, and what they're
> +   doing behind the scenes can be seen by running them under
> +   GIT_TRACE=1
> +
> + * Doing `git log` on paths matching '*--helper.c' will show
> +   incremental effort in the direction of moving existing shell
> +   scripts to C.
> [...]

The rest of this patch is deleting everything in contrib/examples/ that
isn't the README.
