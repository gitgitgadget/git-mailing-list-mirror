Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAC101F453
	for <e@80x24.org>; Thu, 24 Jan 2019 16:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfAXQBz (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 11:01:55 -0500
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:39358 "EHLO
        gproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727649AbfAXQBz (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 Jan 2019 11:01:55 -0500
X-Greylist: delayed 2099 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jan 2019 11:01:55 EST
Received: from cmgw10.unifiedlayer.com (unknown [10.9.0.10])
        by gproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id DEFF8175B02
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 08:22:44 -0700 (MST)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmsmtp with ESMTP
        id mgq4gDD5huj2omgq4gNFgE; Thu, 24 Jan 2019 08:22:44 -0700
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=waCNAxYeQXprtKh74nICbY8si0K/VfWzIhwcTy68YNE=; b=u1dMHlvdg1Xlms3AYXITgjjGes
        knBHWvkH5VNOVABUFjOyqm2Q9LX+Q9WX8poRXp1zT/KYUH+xtfkYkwBAIQa5fH64KP0WmpGv8hJSf
        TBcelBqfKr+lYoE/ZQEByWoqK;
Received: from [50.226.24.42] (port=37338 helo=pdslaptop)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <paul@mad-scientist.net>)
        id 1gmgq4-0008Wo-9U; Thu, 24 Jan 2019 08:22:44 -0700
Message-ID: <9dce6a3d8ff2f10621ea81fbd9ac9964c10aff9c.camel@mad-scientist.net>
Subject: Re: Removing data from repository
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Naum Derzhi <Naum.Derzhi@halliburton.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Thu, 24 Jan 2019 10:22:42 -0500
In-Reply-To: <7A854577E980BE4FB29FDD041B9B75E701798CEE@NP1EXMB203.corp.halliburton.com>
References: <7A854577E980BE4FB29FDD041B9B75E701798CEE@NP1EXMB203.corp.halliburton.com>
Organization: Please remain calm--I may be mad, but I am a professional!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 50.226.24.42
X-Source-L: No
X-Exim-ID: 1gmgq4-0008Wo-9U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (pdslaptop) [50.226.24.42]:37338
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 2
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2019-01-24 at 14:51 +0000, Naum Derzhi wrote:
> Greetings,
> 
> I have this problem: years ago one of our developers committed a
> large (Gigabytes) piece of binary data into our project repository.
> This should not have been done, but it happened. (Honest, it was not
> me). We never needed this data in the repository.
> 
> Using git rm removes these files from the working tree, but they are
> still somewhere in the repository, so when we clone, we transfer
> gigabytes of unneeded data. 
> 
> Is it possible to fix this problem?

It is possible, but it isn't pretty.  By waiting so long to try to fix
it you've compounded the impacts dramatically unfortunately.  By
removing that file you will in effect be rewriting the history of your
repository starting with the commit that introduced the problematic
file, that will be removed, all the way forward.

That means that every clone of the repository will have to be, at the
very least, "hard-reset" and preferably (to avoid accidentally re-
introducing the bad file) re-cloned from scratch.

As for actually removing the file, you can find information on how to
do this all over the Google.  Here's some reasonable advice from
StackOverflow:


https://stackoverflow.com/questions/2100907/how-to-remove-delete-a-large-file-from-commit-history-in-git-repository

