Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904C3C433E9
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD8B221EC
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbhAZE7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 23:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbhAYMVC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 07:21:02 -0500
Received: from vps892.directvps.nl (unknown [IPv6:2a02:2308::216:3eff:fede:83d0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C45BC06178B
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 03:22:56 -0800 (PST)
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 53B8C44012C; Mon, 25 Jan 2021 12:22:53 +0100 (CET)
Date:   Mon, 25 Jan 2021 12:22:53 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Eugen Konkov <kes-kes@yandex.ru>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Can not rebase to first commit
Message-ID: <YA6qDe07eHNKBE6l@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>,
        Eugen Konkov <kes-kes@yandex.ru>,
        Git Mailing List <git@vger.kernel.org>
References: <1327609829.20210125123816@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1327609829.20210125123816@yandex.ru>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 12:38:16PM +0200, Eugen Konkov wrote:
> I can not rebase to first commit.
> 
> This is how to reproduce:
> 
> kes@work ~/work/projects/general/Auth $ git tree
> * 67857d5 (HEAD -> dev) asdf
> * 1e99034 (local/dev) Initial commit
> kes@work ~/work/projects/general/Auth $ git rebase -i --autostash --rebase-merges 1e99034^
> fatal: invalid upstream '1e99034^'
> 
> 
> git --version
> git version 2.30.0
> 
> --
> Best regards,
> Eugen Konkov 
> 

This is because the first commit (1e99034) does not have a parent, so
1e99034^ cannot be resolved.

git rebase does however have an option for this: git rebase -i --root.
That allows you to rebase the root commit.

Hope this helps, Kevin
