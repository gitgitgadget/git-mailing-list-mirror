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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8087B1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 14:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeJCVKx (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 17:10:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55766 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeJCVKx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 17:10:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id 206-v6so5922700wmb.5
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 07:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=c/cnlOxFp9CiLxoUpc7vvUrEXjwHAqOf/i9ZkMQ2F1M=;
        b=RUm4v3pqX+hLJRRtgOzoRKtQxw2zbxfRhI99RmfdRHWj37bYAk/7i4qEY8RC7rf/Qc
         gdRH8all72mA6H5qBwf1qQ+HAp/z7eblAZ9QP1HDm6I7BXr8RLnudocAAP4Djzvtn0bv
         xQQouO+Ynt1kD8FobGi+plrwAMIicg5ttDStnQUH2Dh2L+LVms4d69Yvakn0FNMlzNZV
         OfROT03VOyvENddE52sUNmFRGIMjDAArY1o6r2XQAENYJyhq2RqVoPP4W9xs9PsacgXs
         pfYh+DUA3UFYHC/qruB7blCPheKJSi3tu66QHyil5pDLzsHCDLktY1d2ISHisIuSn4xK
         kdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=c/cnlOxFp9CiLxoUpc7vvUrEXjwHAqOf/i9ZkMQ2F1M=;
        b=XtS/Rg4XMj1hio3pzUW01wVEKiYXch8eBexepWuXPlOitNP6KoncaV4xX3dxKK2XTv
         VZqMRVxAYyQ0muJAUrkX3dPTlT8MFVPCFKpgMTNVdNEqPP92ujYuQJEr4jMaQGmEt3PJ
         z1PI+HmVRY6VKmqEXykxSkc/uWbxD8WJs/MmjdYjHzKS1sG/b4AUjjpJN4rrFpxs6QnX
         bTCpcX+UE/gcFAbktrwIsm/3NRpnXSC5MV6amQuXtElGipQyGZ1pSJ22Tf1EYfcs1fl8
         BIdeG5TV/SHfRKsYr4v05KEFVgJYcA4qSGk1UFDEMKas5J2PKaeXS5RJuYLfbwrePUpv
         Mrig==
X-Gm-Message-State: ABuFfojLoAnK5jqE6MHEohVe59XkrEdOjTlr6DBwrZ636fzA+JwIDTjh
        dVzK3qqcucQMykmKXPYFT6dTC8QD
X-Google-Smtp-Source: ACcGV61Z9mYw9rLsHqP0d7nWAvChfCFlCoFcOGwuhlZVY8pBITID+rHdSylHjobVCmK8hI4DORllxw==
X-Received: by 2002:a7b:c259:: with SMTP id b25-v6mr1602578wmj.138.1538576534385;
        Wed, 03 Oct 2018 07:22:14 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id a17-v6sm1724237wme.40.2018.10.03.07.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 07:22:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit graph
References: <87tvm3go42.fsf@evledraar.gmail.com>
        <20181003133650.GN23446@localhost>
        <87r2h7gmd7.fsf@evledraar.gmail.com>
        <20181003141732.GO23446@localhost>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181003141732.GO23446@localhost>
Date:   Wed, 03 Oct 2018 16:22:12 +0200
Message-ID: <87o9cbglez.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 03 2018, SZEDER Gábor wrote:

> On Wed, Oct 03, 2018 at 04:01:40PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Wed, Oct 03 2018, SZEDER Gábor wrote:
>>
>> > On Wed, Oct 03, 2018 at 03:23:57PM +0200, Ævar Arnfjörð Bjarmason wrote:
>> >> Don't have time to patch this now, but thought I'd send a note / RFC
>> >> about this.
>> >>
>> >> Now that we have the commit graph it's nice to be able to set
>> >> e.g. core.commitGraph=true & gc.writeCommitGraph=true in ~/.gitconfig or
>> >> /etc/gitconfig to apply them to all repos.
>> >>
>> >> But when I clone e.g. linux.git stuff like 'tag --contains' will be slow
>> >> until whenever my first "gc" kicks in, which may be quite some time if
>> >> I'm just using it passively.
>> >>
>> >> So we should make "git gc --auto" be run on clone,
>> >
>> > There is no garbage after 'git clone'...
>>
>> "git gc" is really "git gc-or-create-indexes" these days.
>
> Because it happens to be convenient to create those indexes at
> gc-time.  But that should not be an excuse to run gc when by
> definition no gc is needed.

Ah, I thought you just had an objection to the "gc" name being used for
non-gc stuff, but if you mean we shouldn't do a giant repack right after
clone I agree. I meant that "gc --auto" would learn to do a subset of
its work, instead of the current "I have work to do, let's do all of
pack-refs/repack/commit-graph etc.".

So we wouldn't be spending 5 minutes repacking linux.git right after
cloning it, just ~10s generating the commit graph, and the same would
happen if you rm'd .git/objects/info/commit-graph and ran "git commit",
which would kick of "gc --auto" in the background and do the same thing.
