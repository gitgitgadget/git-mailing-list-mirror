Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2C0D211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 22:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbeL0Wk1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 17:40:27 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:40793 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730062AbeL0Wk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 17:40:27 -0500
Received: by mail-ed1-f54.google.com with SMTP id g22so16276070edr.7
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 14:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=MGokIOJ6DxzuGMgAq5dGDie+Wg4pUALXfC4MWVpTtkU=;
        b=E1D8r08wGoTGRxrIiyrn7NpZWk819sz0vX98x5irE7kdQ9TYbZJ98x4NwbA+6PBVjk
         bwnCStpgCoa1zVkbkbOvt3HTzxJysBejJsI+6SMe/eC9KGRTgmv15NwLuH83T5mxH6UX
         lvrrT9FvDQZGIltywKWgBk1C5ZQqyVo+ZGUeb+GFKDCtypRnVMdu0mwJp6hjNx0OkPdB
         GzZVduLm0+3cREFpTtSfQk2M64mK/BQH0xU1/0o6yqO2AWQAU2fwxkukfJZmk2bOSaE/
         LmhLFOFYV/OtNiIE3jQZlz9X0ILknrML2BYYyR3Auf/u8uQFkIl+O414jSWvSpO99oxc
         Ap1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=MGokIOJ6DxzuGMgAq5dGDie+Wg4pUALXfC4MWVpTtkU=;
        b=mvHcWzhB+ceUvAjWsjIRSOzp2zexXspPn9lf2eE/svVL8XKWpjyN6erXlIiF4GdDvG
         WJO6GhrYNguyha+AggcWmMml7F3JBOFSTHYD1G3QaFaIMIoCIoWHxedp7aHRWpQP2PUj
         A9uEO/hF+aRLVdscPZywX9RYy9mg7f0s7SGekT/Ld70LpEwnzUtwQNGv+ZWc6OZjlzt0
         qHPHr1XcvnEA+1sKyyCskoef1vBn07rDdvJK0VKyFGteRhdDQ7ujrbK0VRF9snFg7Qgr
         5TR6nMrjOX7XdfVnIhczDwKdA0uL/mqYzOvnaxi0vqWmQZAHh0OD8eqzaSQtxDCvWkNs
         tsWQ==
X-Gm-Message-State: AA+aEWbtmCbe7Tb0TSXi9iXI/7xBS6LMlXsfB0KGerM+0CQX4F25uovY
        WEDH20lgBupq5fJy74DoBCX7zol7MBI=
X-Google-Smtp-Source: AFSGD/WYtLp6w2XF/YNuDRu/wkzujaDdq+YuZHgixdIrpgYskk2MBPC0IBZ44pfhW8zMWkzkByBlEw==
X-Received: by 2002:a50:9624:: with SMTP id y33mr19564701eda.206.1545950425163;
        Thu, 27 Dec 2018 14:40:25 -0800 (PST)
Received: from evledraar (i40217.upc-i.chello.nl. [62.195.40.217])
        by smtp.gmail.com with ESMTPSA id n29sm11822345edd.40.2018.12.27.14.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 14:40:24 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Stefan Beller' <sbeller@google.com>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Joachim Schmitz' <jojo@schmitz-digital.de>
Subject: Re: Missed Commit in 2.20.1
References: <002401d49d07$325c7900$97156b00$@nexbridge.com> <875zwm15k2.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <002401d49d07$325c7900$97156b00$@nexbridge.com>
Date:   Thu, 27 Dec 2018 23:40:22 +0100
Message-ID: <87pntmegq1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 26 2018, Randall S. Becker wrote:

> Please stay tuned for patches. We are very much looking forward to having
> the two (or three) different NonStop hardware personalities supported
> without mods in the very near future. Our goal, assuming those patches are
> acceptable, is to move our build/test/distro into a Jenkins config that runs
> with minimal human involvement (a.k.a. me).

Portability patches like that are definitely wanted.

In case you haven't seen my recent work on getting GitLab CI up &
running check out
https://public-inbox.org/git/875zwm15k2.fsf@evledraar.gmail.com/

It differs from existing CI implementations for git.git in being focused
on doing the actual run on remote hosts that can be ssh'd to.

So perhaps you'd be interested in some of:

a) Contributing a NonStop box to the GCC Compile Farm
   (https://cfarm.tetaneutral.net/machines/list/). Then I can add it to
   my tests, but also other people porting free software will fix bugs
   pro-actively before you spot them.

b) I now have a gitlab-runner I maintain powering this git-ci.git stuff
   & presenting it on gitlab.com, if you give me SSH access I can add it
   to my own runs...

c) ...or you can just run your own gitlab-runner on
   https://gitlab.com/git-vcs/git-ci/ (although this amounts to giving
   me ssh access, since you'll be running my code)....

d) ... or reuse the CI code I wrote to setup your own runner/pusher
   against NonStop, only you'd have access to this....

e) Or do whatever you're planning with Jenkins.

If you want to just go with e) that's fine, just saying that you could
re-use some existing stuff with a-d) if you wanted.
