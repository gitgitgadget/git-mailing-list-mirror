Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D141420282
	for <e@80x24.org>; Wed, 14 Jun 2017 12:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbdFNMlj (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 08:41:39 -0400
Received: from gproxy6-pub.mail.unifiedlayer.com ([67.222.39.168]:49047 "EHLO
        gproxy6.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752624AbdFNMlf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Jun 2017 08:41:35 -0400
Received: from cmgw3 (unknown [10.0.90.84])
        by gproxy6.mail.unifiedlayer.com (Postfix) with ESMTP id C146B1E096A
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 06:41:34 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmgw3 with 
        id YchX1v00A0QvKlu01chaz2; Wed, 14 Jun 2017 06:41:34 -0600
X-Authority-Analysis: v=2.2 cv=VKStp5HX c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=IkcTkHD0fZMA:10 a=LWSFodeU3zMA:10 a=59-1Do2XgdqkvuIjYDgA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gmzKvIr4Co8u3DljmEa6POn1+iyOirdzK9Yv1tpCyJY=; b=LcA3c8SE7zm4wFLtvcCHKJLZF8
        V105WUjwECNuZAGfDoNQJAPHBsOcWDhA97WspNV21IqSaIb4DgMBXyMrbthVWGNSWZQDU2zq7vNUQ
        Qfgg8BjSlfCEjUroFdoAdHT+s;
Received: from pool-72-70-58-27.bstnma.fios.verizon.net ([72.70.58.27]:35280 helo=homebase)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.87)
        (envelope-from <paul@mad-scientist.net>)
        id 1dL7c3-0005vW-1A; Wed, 14 Jun 2017 06:41:31 -0600
Message-ID: <1497444089.13409.108.camel@mad-scientist.net>
Subject: Re: Minor missing features in worktree compare to new-workdir
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Yichao Yu <yyc1992@gmail.com>, git <git@vger.kernel.org>
Date:   Wed, 14 Jun 2017 08:41:29 -0400
In-Reply-To: <CAMvDr+Qxjdgnm0aW3WenDpFs2NBhyrNXZA2M7sjsCjJs+RzM3Q@mail.gmail.com>
References: <CAMvDr+Qxjdgnm0aW3WenDpFs2NBhyrNXZA2M7sjsCjJs+RzM3Q@mail.gmail.com>
Organization: Please remain calm!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 72.70.58.27
X-Exim-ID: 1dL7c3-0005vW-1A
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-72-70-58-27.bstnma.fios.verizon.net (homebase) [72.70.58.27]:35280
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-06-14 at 08:31 -0400, Yichao Yu wrote:
> 1. the branch name in new-workdir has the same behavior as checkout,
> i.e. when it matches a remote branch name a local branch tracking that
> remote branch will be created and checked out. worktree gives an error
> in this case. This is very useful for fetching someone else' feature
> branch into a different work dir for testing.

I agree; this behavior of worktree is frustrating.  It's a very common
use-case to aid in code reviews etc. and it's not easy to explain to
people what they need to do to make this work.

> 2. worktree doesn't seem to support multiple worktree on the same
> branch.

I think this is a very good thing about worktrees as opposed to
workdirs.

In a situation where I may want multiple worktrees pointing to the same
commit I just check out the SHA rather than the branch: you can have as
many branches set to the same SHA (detached HEAD) as you like, and
there's no concern about dirty workspaces.  This latter can actually be
a really big problem (suppose the workdir contained some modified files
then you update another workdir with the same branch... it's not easy to
figure out what happened here!)
