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
	by dcvr.yhbt.net (Postfix) with ESMTP id 516B31F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 19:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeKSGNH (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 01:13:07 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46846 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbeKSGNH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 01:13:07 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so1011557edt.13
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 11:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SWwFyU/uCAdLhEavKJKyKhrVvaWTG7Sr4EemtJAEpyo=;
        b=trwfyfyLyq3BWsD5Zt3XYzTR7df/ghH9nUuuTuVee1vGnhOb0LWhqyvTcdON2YSHsC
         WIE5Ps7fF0koZESMZr/+yGlwP1gQhnui3qI1UXAI7dE+Gl56jCJMtsauhKPD7Fl6Vdgr
         CToegyL5U6v5+BXcbVSMDJhawhyHTboPx3Rf+Jhr3+Qb7dG+DXXiqUgYWujqG6bRYh6B
         RlbWEJNsl2uWOdsMIvrvoWL4QlwcGDQ6gT4JVeJfuy7ZX8seoQ37shyTQNOfQ1qz5MGB
         tt7DljoPOUlonhBEvBucGQKk1o/CmzCh8XINaIaancqVamiEY1HZr08gIyVQZougprO6
         HwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=SWwFyU/uCAdLhEavKJKyKhrVvaWTG7Sr4EemtJAEpyo=;
        b=VH91eJKWds4JZkayNn2PyzEHNI4CLcz8VU/kpCQXk8V+6/8V2N3yOpVSqRcKQBwZTX
         OQ1aGyOfWr1ijE2envc8Sq1l7ubm/oD1vSBtjlq/sFF8WKcPLYn5suflpqoel4mkMR1u
         SKRArRT8Hp5oYQrPLdDoL47qJpUw6kBh4utZFs6TuJQRVOC63vMS7Bt38ZwiYQbOVxXz
         SGSq5FgK9AWT26aDgoypfzDdugGVXfHO2RvrJ/cSM58xTLe1BoZvQoOobe/Qp2yrvZ8R
         37ljx4eZH0wmnTH2l48rKoHRQYg1xi8L3z6kt/SSGzRZrRPJGikZJG/adcSYPHp2oVni
         IY3w==
X-Gm-Message-State: AA+aEWalGOY68RMziKQAmjSogtw3wkaRI5fo/xeCU0RyDsTzco8LRru4
        9OvoThOvVfleL00LApPkCAY=
X-Google-Smtp-Source: AFSGD/UhpVYxyTVC69I9ZjnBlz7uJPu0cXiH5zOUtl18ps2nM0IKzPOiGHJBk+lS1CJVFmXceRjAEA==
X-Received: by 2002:aa7:d749:: with SMTP id a9mr5891827eds.223.1542570714731;
        Sun, 18 Nov 2018 11:51:54 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id g3sm10426578edc.63.2018.11.18.11.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Nov 2018 11:51:53 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/5] Make :(attr) pathspec work with "git log"
References: <20181118164800.32759-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181118164800.32759-1-pclouds@gmail.com>
Date:   Sun, 18 Nov 2018 20:51:52 +0100
Message-ID: <87d0r217vr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 18 2018, Nguyễn Thái Ngọc Duy wrote:

> When :(attr) was added, it supported one of the two main pathspec
> matching functions, the one that works on a list of paths. The other
> one works on a tree, tree_entry_interesting(), which gets :(attr)
> support in this series.
>
> With this, "git grep <pattern> <tree> -- :(attr)" or "git log :(attr)"
> will not abort with BUG() anymore.
>
> But this also reveals an interesting thing: even though we walk on a
> tree, we check attributes from _worktree_ (and optionally fall back to
> the index). This is how attributes are implemented since forever. I
> think this is not a big deal if we communicate clearly with the user.
> But otherwise, this series can be scraped, as reading attributes from
> a specific tree could be a lot of work.

I'm very happy to see this implemented, and I think the behavior
described here is the right way to go. E.g. in git.git we have diff=perl
entries in .gitattributes. It would suck if:

    git log ':(attr:diff=perl)'

Would only list commits as far as 20460635a8 (".gitattributes: use the
"perl" differ for Perl", 2018-04-26), since that's when we stop having
that attribute. Ditto for wanting to run "grep" on e.g. perl files in
2.12.0.

I have also run into cases where I want to use a .gitattributes file
from a specific commit. E.g. when writing pre-receive hooks where I've
wanted the .gitattributes of the commit being pushed to configure
something about it. But as you note this isn't supported at all.

But a concern is whether we should be making :(attr:*) behave like this
for now. Are we going to regret it later? I don't think so, I think
wanting to use the current working tree's / index's is the most sane
default, and if we get the ability to read it from revisions as we
e.g. walk the log it would make most sense to just call that
:(treeattr:*) or something like that.
