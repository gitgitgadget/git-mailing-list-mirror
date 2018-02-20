Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC0F91F404
	for <e@80x24.org>; Tue, 20 Feb 2018 22:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750829AbeBTWAD (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 17:00:03 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:56011 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeBTWAD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 17:00:03 -0500
Received: from homiemail-a3.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id AE00F90ED8
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 14:00:02 -0800 (PST)
Received: from homiemail-a3.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a3.g.dreamhost.com (Postfix) with ESMTP id D261E284091
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 14:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mergebase.com; h=
        mime-version:from:date:message-id:subject:to:content-type; s=
        mergebase.com; bh=J+/34byAuha0txPSKP0kN/luUDc=; b=Pg+iUhcRE33HG/
        xiT+w7lrbAHQ1CT3Kt74S7ETI48dU+K5GUAdtZ7resFuZQZ5kvTkHD42UHImWn+d
        /Y00MJzobzez0Z14YZK+TXXWOnfsADC0DDlVZMo70e7F94V9nGpkm4eyIpSJiySd
        FbwXTr1a8mi1VfSFYCPd2NedG4tkM=
Received: from mail-io0-f177.google.com (mail-io0-f177.google.com [209.85.223.177])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: julius@mergebase.com)
        by homiemail-a3.g.dreamhost.com (Postfix) with ESMTPSA id A654C284087
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 14:00:01 -0800 (PST)
Received: by mail-io0-f177.google.com with SMTP id e7so16618104ioj.1
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 14:00:01 -0800 (PST)
X-Gm-Message-State: APf1xPBBHNW7DFMFD0zPfh0L1rCi4Um7U81Yq65LT8V8kmb0pQs0tNY2
        76wHwC2WMftqbyuBwehSSMgcEx5Mv9s9J6pHdg==
X-Google-Smtp-Source: AH8x226xkyVmGTqa11587/pOFLPhT/3cwmHxU/CCT4zwYdMNmvAtl2qGWbz5USo3YXowMYsDSP/zFBSSKpMIlI2Ioxg=
X-Received: by 10.107.205.196 with SMTP id d187mr1547470iog.42.1519164000938;
 Tue, 20 Feb 2018 14:00:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.1.69 with HTTP; Tue, 20 Feb 2018 14:00:00 -0800 (PST)
From:   Julius Musseau <julius@mergebase.com>
Date:   Tue, 20 Feb 2018 14:00:00 -0800
X-Gmail-Original-Message-ID: <CAA7Zk=vWdEUnrfBcxCH6WAFH9Jss7T9_zK-zMnWbVO7B+2YySw@mail.gmail.com>
Message-ID: <CAA7Zk=vWdEUnrfBcxCH6WAFH9Jss7T9_zK-zMnWbVO7B+2YySw@mail.gmail.com>
Subject: I'm trying to break "git pull --rebase"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Git Developers,

I'm currently writing a blog post about "git pull --rebase".   The
point of the blog post is to examine scenarios where two people are
working together on a short-lived feature branch, where history
rewrites are allowed, and where both are using "git pull --rebase" to
stay in sync with each other.

I was hoping to concoct a situation where "git pull --rebase" makes a
mess of things.

So far I have been unable to do this.  I tried version v1.7.2 of Git
as well as version v2.14.1, and as far as I can tell, "git pull
--rebase" is bulletproof.

Does anyone here happen to know a situation where "git pull --rebase"
makes a mess?

Here's a draft of the blog post:

Title:  "(Too much) fun with git pull --rebase"

https://mergebase.com/doing-git-wrong/2018/02/17/fun-with-git-pull-rebase/


Here are the "git pull --rebase" scenarios I've tested so far:

1.  origin/feature rebased against origin/master

2.  origin/feature squash-merged against origin/master

3.  origin/feature squashed in-place`

4.  origin/feature dropped a commit

5.  origin/feature insanity (adjusted merge-base, reversed commits,
squashed some commits)

6.  undo of 5


So far "git pull --rebase" does the exact right thing in every case!

If anyone knows a scenario where "git pull --rebase" fails to do the
right thing, I would be very grateful to hear of it.



Thanks!

yours sincerely,

Julius Musseau
