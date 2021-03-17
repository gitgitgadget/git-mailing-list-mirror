Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9785AC433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 07:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8E064F99
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 07:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhCQHEB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 03:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhCQHDv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 03:03:51 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6DAC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 00:03:50 -0700 (PDT)
Received: from [121.99.166.194] (port=51468 helo=[192.168.1.2])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <victor@engmark.name>)
        id 1lMQDb-0000Ib-HP
        for git@vger.kernel.org; Wed, 17 Mar 2021 08:03:48 +0100
Message-ID: <d327e1005e0d487c0c9e8e2f7a9ea17ed6036fce.camel@engmark.name>
Subject: RFC: Additional git-for-each-repo synopsis
From:   Victor Engmark <victor@engmark.name>
To:     git <git@vger.kernel.org>
Date:   Wed, 17 Mar 2021 20:03:44 +1300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all

git-for-each-repo is similar to a tool I wrote over a decade ago and
have been using ever since,
`fgit` <https://gitlab.com/victor-engmark/fgit/-/blob/master/fgit.sh>. 
Looking at the git-for-each-repo documentation it seems it's doing
things very differently, and I'm wondering if you would be interested
in an additional synopsis for the same command:

git for-each-repo <arguments> -- <directories>

For example, `git for-each-repo fetch -- ~/*/` would fetch in each
directory directly underneath the home directory. If some of the
directories are not repositories it can easily be amended to
`~/*/.git/..`, which is going to match only actual Git repositories on
sane systems. This is similar to the command I run every day or so,
`fgit pull -- ~/*/.git/.. ~/dev/*/.git/..
"/run/media/${USER}"/*/*/.git/..`.

This means not having to configure anything to use this tool. The
overhead of dealing with a configuration file is significant,
especially for beginners. It also means not having to go through
several steps every time my collection of repositories changes
(approximately weekly to monthly), and either coming up with some hack
for injecting all my repos into that configuration or forever second-
guessing whether the configuration is up to date. A third advantage is
that this would make it possible to use relative paths.

Cheers
Victor

