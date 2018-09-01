Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D523A1F404
	for <e@80x24.org>; Sat,  1 Sep 2018 22:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeIBCbT (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 22:31:19 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46172 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeIBCbT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 22:31:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id k14-v6so11447720edr.13
        for <git@vger.kernel.org>; Sat, 01 Sep 2018 15:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=QlyUe/oz1jjtplJjTN2oV0HFuO81hoBKm/PiQU7L5MI=;
        b=FM31+6tRw2tC+R8RvrfODZEfYfJGCuazOzlVURnZPgaIx7DRp8McLwL+/vYhPE8IH3
         baGeNxCCqLfCyQo0RIHItPQ/z496aUpzvyCcK0IXejbM63yvVDrSptFrjhgPvnJO34Lu
         0KVDickbgmihr/BZ0oL58ATWjlWMqZ0xxWX3LCMwbyBMrTzthW/aH117w/QW7GvWIbZp
         tn1D/ISqQFMrWOPmVAv73HGrXLKjG16r8I4iwj6WlvQ8lSc0esbYbwi9LSvdCgp+RBfs
         QF3PwB2qFU9XVfUpeEW2EbwErPDKKUFZXnQNcAx0vr5LEC5Hb7lu0+yvA2BNDxB/arZ/
         rDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=QlyUe/oz1jjtplJjTN2oV0HFuO81hoBKm/PiQU7L5MI=;
        b=tpBRxx8eMTL//ZYmej7vlkpMF+x8fOfkhYGT+qZ1IEe2yzJAsVW78sYMTn4glR/j3i
         ZtujQ1W6179q8HR0XoiG8yhrLwD2drUMVTkRjRBDH9ryC+lZB77XHLGvpExs1Dtlg7WN
         pcrSyjO0crNk+5+Je2Qc08pjP+hCM+M4+l0uzP0qbcIN/5ii6YnFenHN6eXbaJOewL1U
         UdCKbbivpyI6JHy1/Tm284OYERdXonj8od2W9whVveFtA3ebKN8rUxyYX4rXD3KfJGgo
         qNZMMV+Akvcd2dNEDAHeYCd/vaBtnFXWjZxKCYlFNdjbO1iyTtIUz+ONwVpz3TwZtVfT
         OlvQ==
X-Gm-Message-State: APzg51C1foAmxojp4YBsouPOWQmzI0ZI3hbzufNv6l4eGxMF42KKvTwi
        Lh/z5Xb2M6HmB5lemkXTbHw=
X-Google-Smtp-Source: ANB0Vdaut4x5SJFUGDuKfTn5KMlJkOpYkBRa++Cbhw4ci/o6jf0qg+q/ycvo3G9YW4E3spMvhrbj/A==
X-Received: by 2002:a50:b1d1:: with SMTP id n17-v6mr24220223edd.52.1535840274474;
        Sat, 01 Sep 2018 15:17:54 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id s36-v6sm7721391edb.56.2018.09.01.15.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Sep 2018 15:17:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     git@vger.kernel.org, Kevin Willford <kewillf@microsoft.com>
Subject: Re: [BUG] index corruption with git commit -p
References: <20180901214157.hxlqmbz3fds7hsdl@ltop.local>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180901214157.hxlqmbz3fds7hsdl@ltop.local>
Date:   Sun, 02 Sep 2018 00:17:53 +0200
Message-ID: <87tvn8c166.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 01 2018, Luc Van Oostenryck wrote:

> Hi,
>
> I've just had a scary error:
> 	error: index uses $?+? extension, which we do not understand
> 	fatal: index file corrupt
>
> Things were quickly recovered by deleting the index but it clearly
> looks to a but to me.
>
> Here are the steps to reproduce it:
>   $ git clone git://github.com/lucvoo/sparse-dev.git <somedir>
>   $ cd <somedir>
>   $ git co index-corruption
>   $ git rm -r validation/ Documentation/
>   $ git commit -m <some message> -p
>   $ git status
> error: index uses $?+? extension, which we do not understand
> fatal: index file corrupt
>
>
> The 'extension' pattern '$?+?', can vary a bit, sometimes
> it's just '????', but always seems 4 chars.
> If the commit command doesn't use the '-p' flag, there is no
> problem. The repository itself is not corrupted, it's only
> the index. It happends with git 2.18.0 and 2.17.0

Yeah this is a bug, I didn't dig much but testing with this script down
to 2.8.0:

    #!/bin/sh

    cd ~/g/git
    make -j $(parallel --number-of-cores) USE_LIBPCRE2=YesPlease CFLAGS="-O0 -g -ggdb3" DEVELOPER=1 DEVOPTS=no-error NO_OPENSSL=Y all

    (
        rm -rf /tmp/x;
        ~/g/git/git --exec-path=/home/avar/g/git clone git://github.com/lucvoo/sparse-dev.git /tmp/x &&
        cd /tmp/x &&
        ~/g/git/git --exec-path=/home/avar/g/git checkout index-corruption &&
        ~/g/git/git --exec-path=/home/avar/g/git rm -r validation/ Documentation/ &&
        ~/g/git/git --exec-path=/home/avar/g/git commit -p
    )

    ~/g/git/git --exec-path=/home/avar/g/git -C /tmp/x status

    if ~/g/git/git --exec-path=/home/avar/g/git -C /tmp/x status
    then
        exit 0
    else
        exit 1
    fi

I found that the first bad commit was: 680ee550d7 ("commit: skip
discarding the index if there is no pre-commit hook", 2017-08-14)

Now, note the two invocations of "status" in my script. Before we'd
already been complaining about a bad index, but after that commit is the
first time we started getting a persistent error, and indeed even
reverting it now on top of master makes the error non-persistent.

So not a fix, but a strong signal to see where we should start
looking. I.e. the index file handling around discard_cache() &
"interactive" in commit.c is likely what's broken.
