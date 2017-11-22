Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 929E720954
	for <e@80x24.org>; Wed, 22 Nov 2017 12:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbdKVMJ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 07:09:59 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:46364 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbdKVMJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 07:09:57 -0500
Received: by mail-wm0-f42.google.com with SMTP id u83so9903259wmb.5
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 04:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9JKp8cn9rYL5CSHExk+VGgVXyScD6pCSv8qvTbfaouE=;
        b=ucdM2fphuMCQUxOAudsk1E08f6/RW6W62SzG57A7ielCsQ7xIf5f0PjKAnpfZPddI6
         dTZzgFS+mSjfTyWaitHJx/Jqx/zAdmUP7A2hp417onoM4sW+eRCYuQ9OxXFLj8+DkWoI
         ZD1vLLHHSg+aZenddmsX1H0C8NpJt2OWerv+yWbIAwY8tLJU7tZD0Qq65567FW2TsEAJ
         Zen70I3lhjBXCqe2UWS2CgwPP3s9KRFeb31fV0bX7rLmBPYG6N2pzLLcM+G4HGy1mRgu
         BQjthkeDcVGlrKGcALVB6zgm5jLwljt3NYhKD3czsD2nmsgVboAzk7i+zYzDQeQqzxbd
         0Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=9JKp8cn9rYL5CSHExk+VGgVXyScD6pCSv8qvTbfaouE=;
        b=bdLcRqe1CQRBGL+5f15wEHSaD/7QOexptifVMe453VdmF2tJAlF7+A7zQh5NXqZ84z
         ozOrAJlNCFINudeyrHruUeFvi+3zcEAaaYB9BYP5TRvhKR1BsH2A9jhhI/QXsz6P1ghk
         eOioCH3DHSe5YrxIdqcuGPd9YYwx7hRKe35VBKXzxuDGJTXbCfLgDgqbX4w/jgLfORCI
         60Dn+w9OUXmc1AA+3qyD40LKQ0IigNkWT0cOhwH9bzrawk1eQd+BxerL0J8MRT1UA0lI
         x+BWfpQ7UFlfwqw5R7xEbjmBziVpWt+pOQX1gIuGTpsyYYoxWkNCih5iwEDN+s3vbLRx
         +bXQ==
X-Gm-Message-State: AJaThX6MSi/yEu6cqzsVGjW61FAeUb8sn3B+zQuDCc4ELwc38afM8bGY
        O64H+qO3BYfOP+cktAEKHVYcgpo7
X-Google-Smtp-Source: AGs4zMY1SxnUih+We7v8D+W2YQgpzurbOWqBLG13r+tcFtEUZMHa86Sz5weFER5UgXe9UF5ID5B3/A==
X-Received: by 10.80.212.27 with SMTP id t27mr27072358edh.89.1511352595822;
        Wed, 22 Nov 2017 04:09:55 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id x5sm7974528eda.8.2017.11.22.04.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 04:09:54 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eHTqk-0004Me-5M; Wed, 22 Nov 2017 13:09:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Dan Jacques <dnj@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        Petr Baudis <pasky@ucw.cz>
Subject: Re: Re [PATCH 1/1] exec_cmd: RUNTIME_PREFIX on some POSIX systems
References: <87k1ykwrfv.fsf@evledraar.booking.com> <20171121024102.14153-1-dnj@google.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171121024102.14153-1-dnj@google.com>
Date:   Wed, 22 Nov 2017 13:09:54 +0100
Message-ID: <87efoqwm3x.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 21 2017, Dan Jacques jotted:

> Ævar Arnfjörð Bjarmason @ 2017-11-20 21:50 UTC suggested:
>
>> So LeonT over at #p5p helped me with this. He believes this'll work
>> (unless MakeMaker INSTALL_BASE is set, but that should break the Git
>> install anyway):
>
> I think that the problem with this approach is that it uses the local
> "Config" module. The primary purpose of RUNTIME_PREFIX(_PERL) is that one
> can build/install Git into a directory, then either move that directory
> somewhere else or archive it and put it on a different (binary-compatible)
> system altogether.
>
> The latter case concerns me here. If the "Config" module is loading local
> system paths, then the relative pathing between "$Config{installsitelib}"
> and "$Config{siteprefixexp}" may not be consistent between systems, so an
> archive built from one system may not have a compatible relative
> directory structure when resolved with the Config module on another
> system.

I don't see how this is different from any other option we build git
with. When we dynamically link to e.g. PCRE under RUNTIME_PREFIX*=Yes
you can move the installed git from /tmp/git to /tmp/git2, but it'll
still expect the specific version of the *.so libraries to be in
/usr/lib or whatever.

Similarly we under the default MakeMaker path add the perl version to
the directories we have, you can move git from /tmp/git to /tmp/git2 no
problem, since that won't change the perl version, but if you upgrade
the global perl itself from 5.20 to 5.24 you'll need to re-build.

> Since we control the installation process and paths, we know that the
> directory structure looks someting like:
>
> .../prefix/$GITEXECDIR/git-perl-script
> .../prefix/$RELPERLPATH/Git.pm
>

Having said the above, I don't understand why we're using MakeMaker at
all and I think we should just get rid of it.

We're not using the perldoc toolchain to build manpages from *.pod for
these, and we don't have any C bindings, it seems to me that we could
simply replace this whole thing with a removal of all things Make-y from
perl/* and just do the minor work of creating a top-levle git-perl-lib
in our install $PREFIX and make the perl stuff use that.

Looking at the history of the Makefile.PL it originally had XS stuff
(which you'd need a Makefile.PL for), but this was removed in 18b0fc1ce1
before it made it to master.

My comment on your patch series was just that with the method I posted
there's no reason for why RUNTIME_PREFIX*=Yes and MakeMaker need to be
mutually exclusive, so if we're keeping the MakeMaker it seems to me
that we can support both.

But we can probably just get rid of MakeMaker.

> Our goal is to, given the directory that "git-perl-script" belongs to,
> first identify the path for ".../prefix" and then append "$RELPERLPATH" to
> it to generate the full library path.
>
> The most straightforward way to do this, to me, is to:
>
> 1) Have the Makefile hard-code "$RELPERLPATH" and "$GITEXECDIR" (relative
>   paths) into the header code.
> 2) Assert that "$FindBin::Bin" (the directory containing the script) ends
>   with "$GITEXECDIR".
> 3) Remove "$GITEXECDIR" from the end of "$FindBin::Bin" to obtain
>   ".../prefix" ($prefix). Simple string truncation is probably fine for
>   this.
> 4) Add "File::Spec->catdir($prefix, $RELPERLPATH)" to "lib".
>
> I don't think path separators are a problem, since the Makefile uses "/"
> indiscriminately. Even Git-for-Windows seems to run its PERL scripts in
> a POSIX environment (mingw).

Right. I don't know that they are either, it just stuck me as an odd
inconsistency that you're going out of your way to do catdir($p, "lib")
in one place and then hardcoding unix-like paths in another place.

If it's not neede dwe can just do "$p/lib".

> Does this sound like a reasonable way to proceed?

I think the best way to proceed is probalby to just start getting rid of
the perl/* make stuff as discussed above.

Is that something you're interested in / have time for, otherwise I
could see if I could find some time, but I don't have a lot these days.

Which is not to say that I think that should block this patch series or
anything. If it really needs to disable MakeMaker to work we're no worse
off than before.
