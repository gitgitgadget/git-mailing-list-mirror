Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB9DA1FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 14:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932720AbeAKOMS (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 09:12:18 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:41357 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754252AbeAKOMR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 09:12:17 -0500
Received: by mail-wm0-f41.google.com with SMTP id g75so5882372wme.0
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 06:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:user-agent:date:message-id:mime-version;
        bh=wh+xAVueCZU2scLLvC769DKoZtaE7Tcim9XIpR/sil0=;
        b=IMdICGjfTXtyYi60GxTJB8jEkmlYDejswtFQs8fUqNl5bBqLQ8eHpR2pVIQ9cxipym
         3oQK7RPPa8cgX5DWj1XqV7kpyZCZHYHW3TswnDGK1HOjJ2dWLdtD1A+x+BrIcnKcO62N
         11wCie/DhONNGTjMJbQ+SskWggOGexL4jR6PHdOoaYEj+6XQl7FlYVxGPAewr8bV+w8z
         fqwRvCapP8PLuTmFXjiEWAhKa4IFhGniq/j4tdVZdTcJKcmMQSWav+bpcKxLy4hnOCyb
         7oVrS7V+JWJQyWOLjFngwPcB6JcX7MsVayo/kTYZlENyjrB+tTYeZXlQlbWyKe5Sgu+T
         T6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:user-agent:date:message-id
         :mime-version;
        bh=wh+xAVueCZU2scLLvC769DKoZtaE7Tcim9XIpR/sil0=;
        b=KI1ExrhgoKvqzNx518JMjLYxnm798aX36/VQgRhGMWvdot29KVhXHktk53dBeLbeX0
         bjhXY1DIDSejC5KEs/dBSofnup/SzM0+T33PLekMTO6yjrfx6z1n36Yj95b0dNm6NJBK
         rlpDhxLKwM92WI7URrii6hFQrjARhxpljOtDFTfuCDapGeYv0aKo8p/GP0hiS3zBxt+e
         otUFKL7Rl87vWiVXhjlmFzmKevM2M7D/NRmPy5Vip0AGo8fxuMC266wUYlgDh7ru4pSH
         IkYI6DevoFu3L4b7sMDzSUsvAJE11pR8i4yY1EHqdzWc+giNjvHQzMKoWgBlvZD+JY2q
         g/+g==
X-Gm-Message-State: AKwxyteY+lI+ofGgZ06wIvZuPbEIMJKroCx1ZJTneMqvNqHa4Fn8jGvW
        CTUW2djdN+RmRk5wZkv0oK8bFemj
X-Google-Smtp-Source: ACJfBovD7wZHAwYs+5wWCOTx49I539VbKsz2OERATet+2+I+idce8kdi+XG6+wyWWgro17WjYOQ8xQ==
X-Received: by 10.80.130.35 with SMTP id 32mr2709193edf.7.1515679935843;
        Thu, 11 Jan 2018 06:12:15 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id c7sm1667771edc.37.2018.01.11.06.12.14
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jan 2018 06:12:14 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Unable to de-init stubborn submodule
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
Date:   Thu, 11 Jan 2018 15:12:14 +0100
Message-ID: <87k1woa3i9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What if we wanted to drop sha1collisiondetection/ as a submodule and
replace it with a copy of what's now in sha1dc/? I ran into this with
another project, but here's a way to reproduce it on git.git:

    (
        rm -rf /tmp/git &&
        git clone git@github.com:git/git.git /tmp/git
        cd /tmp/git &&
        git tag nuke-before &&
        git submodule update --init &&
        git rm -r .gitmodules sha1collisiondetection &&
        git commit -m"Nuke sha1dc submodule" &&
        cp -Rvp sha1dc sha1collisiondetection &&
        git add sha1collisiondetection &&
        git commit -m"Now it's not a submodule" &&
        git tag nuke-after &&
        git reset --hard nuke-before &&
        git submodule update --init && # skip this and the below won't fail
        git reset --hard nuke-after && # Emulate someone doing a pull
        git ls-tree HEAD | grep sha1collisiondetection && # OK, shows "tree" not "commit"
        test $(git rev-parse HEAD) == $(git -C sha1collisiondetection/ log -1 --pretty=format:%H) && echo OK || echo WTF
    )

This results in a really bizarre state where according to ls-tree
sha1collisiondetection is a tree at the current commit:

    040000 tree 81583289d96bdde4b366c243ab524ea28d895ea5    sha1collisiondetection

But git still believes there's a submodule there for some reason, and
shows the log for the upstream sha1collisiondetection project:

    git -C sha1collisiondetection/ log -1
    commit 19d97bf (HEAD, origin/master, origin/HEAD, master)
    Merge: 3f14d1b c93f0b4
    Author: Dan Shumow <shumow@gmail.com>
    Date:   Sat Jul 1 12:36:15 2017 -0700

        Merge pull request #37 from avar/fixup-pull-request-34

        Fix endian detection logic for Sparc, little endian BSD etc.

Doing:

    git submodule deinit sha1collisiondetection

Does nothing to help, then I thought it might be:

    git config -f .git/config -l|grep ^submodule
    submodule.sha1collisiondetection.active=true
    submodule.sha1collisiondetection.url=https://github.com/cr-marcstevens/sha1collisiondetection.git

But running:

    git config --remove-section submodule.sha1collisiondetection

Doesn't help either, neither does removing the index:

    rm .git/index &&
    git reset --hard

If you then do:

    rm -rf .git/modules

You'll get this error:

    git -C sha1collisiondetection/ log -1
    fatal: Not a git repository: /tmp/git/sha1collisiondetection/../.git/modules/sha1collisiondetection

But I can't see what's still referencing it.

This problem is avoided if, as noted with a comment I skip:

    git submodule update --init

But I shouldn't need to remember to de-init a submodule before moving to
a new commit that doesn't have it, least I end up in some seemingly
unrecoverable state.

Am I missing something obvious here?
