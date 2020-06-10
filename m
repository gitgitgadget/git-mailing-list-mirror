Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AC1C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 06:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA96320801
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 06:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.de header.i=@mail.de header.b="A3cjz2t7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgFJGCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgFJGCV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 02:02:21 -0400
Received: from shout02.mail.de (shout02.mail.de [IPv6:2001:868:100:600::217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4ECC05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 23:02:21 -0700 (PDT)
Received: from postfix01.mail.de (postfix03.bt.mail.de [10.0.121.127])
        by shout02.mail.de (Postfix) with ESMTP id 13FC1C014A;
        Wed, 10 Jun 2020 08:02:17 +0200 (CEST)
Received: from smtp04.mail.de (smtp04.bt.mail.de [10.0.121.214])
        by postfix01.mail.de (Postfix) with ESMTP id EDA1380142;
        Wed, 10 Jun 2020 08:02:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
        s=mailde201610; t=1591768937;
        bh=JBiaL+ljJ96L5Zo0OCQPv5dxvdReNOlW4jiwScqFtCg=;
        h=From:Subject:To:References:Date:In-Reply-To:From;
        b=A3cjz2t70hsAcMC+EELZx87wMvuKXKO5SZ6yJFEh5M0onno+NTfUGuYu9qBuLHxS7
         f5ES48BY3xmvTb61w6yohoSHrPTp31mlPjdp49GwSAGfZ9DFtaObUbLg9hcX9Pdtpd
         rn4lV1zUu1f9hGvPEW/t7TRL8iAHGvBfvtNDL2R8=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp04.mail.de (Postfix) with ESMTPSA id 777B8C00E8;
        Wed, 10 Jun 2020 08:02:16 +0200 (CEST)
From:   Stefan Moch <stefanmoch@mail.de>
Subject: Re: git submodule question
To:     Laura Smith <n5d9xq3ti233xiyif2vp@protonmail.ch>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <Wri_F6OxTiG7HZNvyVdFwGp7qrTWqC7Oipu214kLQ8gGMhna7SU6AXdm_m8tkDaPlMKtXGXc84TSACkN0tigR9satiLkrXn23bfM331g09U=@protonmail.ch>
Message-ID: <02d1bf3e-0fc8-a02b-68d0-2982dc209c55@mail.de>
Date:   Wed, 10 Jun 2020 08:02:08 +0200
MIME-Version: 1.0
In-Reply-To: <Wri_F6OxTiG7HZNvyVdFwGp7qrTWqC7Oipu214kLQ8gGMhna7SU6AXdm_m8tkDaPlMKtXGXc84TSACkN0tigR9satiLkrXn23bfM331g09U=@protonmail.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 2645
X-purgate-ID: 154282::1591768936-00000568-55C241D1/0/0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Laura Smith wrote:
> I'm using git submodule to pull some third-party config templates into my git tree, using the following:
>
> git fetch  foobar-github master
> git subtree pull --prefix software/files/perimiter_mail/foobar-github foobar-github master --squash
>
> Now, the question is, when the upstream makes a new commit can I force pull that commit and make git overwrite any changes I've made in the subtree.

(Side node: there is `git submodule` as well as `git subtree`, they
are similar in their goals, but work quite differently.)

I have not used subtree much, but from a first glance it seems to me
one would have to either (a) revert the own changes or (b) commit
checked out files from the last upstream version again prior to the
`git subtree pull` to get git subtree merge/pull deliver exactly the
files from new version the upstream repository into the subtree.
That would lead at least to a untidy history with a back and forth
of placeholders and replacements and scripting it could also be a
bit cumbersome.

However, /not/ changing the template files would also be a
possibility to generate your files:

> At the moment I get bitter complaints from git, e.g. :
> CONFLICT (content): Merge conflict in....
> Automatic merge failed; fix conflicts and then commit the result.
>
> Basically, I want to make myslef an update script that force-pulls the latest upstream repo and then the script will take care of making the necessary modifications (the upstream puts placeholders in their repo, so my script would take care of replacing the placeholders with the real values so that everything works again)

If you are going to write a script that replaces the placeholders in
the config templates, you could as well leave the whole subtree /as
it is/ in upstream (i.e. without replacement of placeholders) and
only use `git subtree pull` go get the upstream changes – without
conflicts from now on. (Or maybe only make structural changes to the
templates itself (e.g. added/removed blocks of text), if needed at
all. That should probably lead to fewer conflicts than changing the
placeholders in place.)

You can then use your script to generate /another/ file (with
replacement of placeholders) from each config template as part of
your build process or whatever is run from this repository. The
generated files may or may not be added to the repository (outside
of the subtree). If their content is reproducible (with templates,
script, and replacements), it is not necessarily needed to add them,
just regenerate them if needed or if their corresponding template
changed.


