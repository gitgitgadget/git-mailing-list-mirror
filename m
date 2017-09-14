Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9329D209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 15:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbdINP5y (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 11:57:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:51242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751328AbdINP5x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 11:57:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36F84AB1E;
        Thu, 14 Sep 2017 15:57:52 +0000 (UTC)
Subject: Re: Rebase & submodules
To:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
References: <CAHd499ApnHpt0CmcQMx+qVQ60NV6auFKkuvikCq2Zut4p4rzaQ@mail.gmail.com>
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Openpgp: preference=signencrypt
Message-ID: <bf4275e5-ad96-4b71-e6a0-52c198cd541e@suse.de>
Date:   Thu, 14 Sep 2017 17:57:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <CAHd499ApnHpt0CmcQMx+qVQ60NV6auFKkuvikCq2Zut4p4rzaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 14/09/2017 à 17:39, Robert Dailey a écrit :
> So I often will have a submodule that points to one of my own forks,
> because I will have work done on a feature branch that hasn't been
> merged upstream yet. Assuming this merge takes a long time to get
> approved, I will occasionally rebase my topic branch to keep things up
> to date and clean.
>
> However, any previous commits in my parent repository that refer to a
> SHA1 prior to the rebase will now be pointing to dangling/orphaned
> commits, which means I wouldn't be able to go back to that commit in
> history and do `git submodule update` since that checkout will fail.
>
> One obvious solution to this is: Don't rebase. But, this could result
> in a lot of merging between the upstream and my fork which would make
> things not only ugly, but prevent me from making a pull request that
> makes sense to the upstream repository (They'd likely request a rebase
> in order to accept the PR, which I wouldn't be able to do for the
> reasons outlined above).
>
> Are there any other workflows that would support this kind of model better?

Without changing your workflow too much, simply add an annotated tag to your branch before your rebase.
This way the SHA1 will always exists. Unless you want to cleanup at some point (branch merged ?) and then you can simply delete all those old tags.

Nicolas


