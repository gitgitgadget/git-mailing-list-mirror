Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F7B1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 13:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeJCUMY (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 16:12:24 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:36569 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeJCUMX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 16:12:23 -0400
Received: by mail-wr1-f51.google.com with SMTP id y16so6137720wrw.3
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 06:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=wUpUUz+eOzh+TSQeUbyMbasOhxIU+JI7/etjfpDbuV0=;
        b=ANouHP0jTbAHR5hiEMDLTzSZmEMGRwQorWwlfLBUczobL6MbCK8fg2srQ1ikjaYptq
         A/+Kq4Bk47Brsv7FV8YE14WcuFkFaTpWq34zn7yN/YXEcxJkgPqqdbD/G2FxLjEtoPfk
         EfarENDbLZaU1K1EjkzVtaclWmtdSc47GDGC/pEyE3YmLJOMa+20F9cwobagR3zwh/oU
         /LFtHkcmv91xiTcTnSkPiVwl8dUB7aPFRlTkZvsDq8av+ZapeFnOsrsZ6n1IR2415YBh
         r3Kull5y7Z5rGULCQxe1vAzDFh8mc51azQUyjoxUL/4q9QBeefmMRnaWTmgU5b48mZDR
         BzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=wUpUUz+eOzh+TSQeUbyMbasOhxIU+JI7/etjfpDbuV0=;
        b=NowLZgQSEqj94VoAnehk+jCIghom0TohpdBVmFxzBvs3mUIWl02OE0fLXpyvt6N5UF
         YjQaVFONMFNORZyomkhIlUfd4FgIAh1YeEQbqIdg/D38eBADE/nyl/GigLphMT/EHQ+Y
         a/TSrZtLSeVutzNcGXxj/5sIE1sZqojc9aoNO3RF/AmIZH0VSC6H4+V8CP+tVk7bTI90
         M5/KCWKQdFUZ0Qd7/H8sKQcb46N8YOGzmmb0ZHMic9ZzXGfAlPZGztf1D+0tDDG1PrAw
         At/y5VFvcqK9gX+LjYOH2J+lZRCaFViyzXN77P5yFV/woqEr7w3PNBaPaO0lM4qbJtq/
         F3SQ==
X-Gm-Message-State: ABuFfohCZTO+fPGYeC/05dT7NeS1Y6VmfIhh2/JQlSrzMr0zGPk5g3Jf
        VggJm+U09iWoA2QgqPPd+HPXgEiG
X-Google-Smtp-Source: ACcGV60UJadyZLrAoNioVLMKeSsFR7PgtZV4WxGhQ9LdX/0oukS+E6KZ/4tjsx2atIPc1K4m+WMYUw==
X-Received: by 2002:adf:fc0b:: with SMTP id i11-v6mr1402466wrr.9.1538573038531;
        Wed, 03 Oct 2018 06:23:58 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id 188-v6sm2251819wmg.13.2018.10.03.06.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 06:23:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: We should add a "git gc --auto" after "git clone" due to commit graph
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
Date:   Wed, 03 Oct 2018 15:23:57 +0200
Message-ID: <87tvm3go42.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't have time to patch this now, but thought I'd send a note / RFC
about this.

Now that we have the commit graph it's nice to be able to set
e.g. core.commitGraph=true & gc.writeCommitGraph=true in ~/.gitconfig or
/etc/gitconfig to apply them to all repos.

But when I clone e.g. linux.git stuff like 'tag --contains' will be slow
until whenever my first "gc" kicks in, which may be quite some time if
I'm just using it passively.

So we should make "git gc --auto" be run on clone, and change the
need_to_gc() / cmd_gc() behavior so that we detect that the
gc.writeCommitGraph=true setting is on, but we have no commit graph, and
then just generate that without doing a full repack.

As an aside such more granular "gc" would be nice for e.g. pack-refs
too. It's possible for us to just have one pack, but to have 100k loose
refs.

It might also be good to have some gc.autoDetachOnClone option and have
it false by default, so we don't have a race condition where "clone
linux && git -C linux tag --contains" is slow because the graph hasn't
been generated yet, and generating the graph initially doesn't take that
long compared to the time to clone a large repo (and on a small one it
won't matter either way).

I was going to say "also for midx", but of course after clone we have
just one pack, so I can't imagine us needing this. But I can see us
having other such optional side-indexes in the future generated by gc,
and they'd also benefit from this.

#leftoverbits
