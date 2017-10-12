Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3D120437
	for <e@80x24.org>; Thu, 12 Oct 2017 11:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752986AbdJLLsx (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 07:48:53 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:47630 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752138AbdJLLsw (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Oct 2017 07:48:52 -0400
Received: from app04-neu.ox.hosteurope.de ([92.51.170.138] helo=null); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1e2bys-0003qU-JQ; Thu, 12 Oct 2017 13:48:50 +0200
Date:   Thu, 12 Oct 2017 13:48:50 +0200 (CEST)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Message-ID: <591155758.21471.1507808930483@ox.hosteurope.de>
In-Reply-To: <CAGZ79kYTY6U0eNwvU0PcDyt_QXGyYGm5VkDvWLtuQgQG6BbtFA@mail.gmail.com>
References: <788230417.115707.1507584541605@ox.hosteurope.de>
 <CAGZ79kYTY6U0eNwvU0PcDyt_QXGyYGm5VkDvWLtuQgQG6BbtFA@mail.gmail.com>
Subject: Re: Branch switching with submodules where the submodule replaces a
 folder aborts unexpectedly
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev10
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1507808932;6db20736;
X-HE-SMSGID: 1e2bys-0003qU-JQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Stefan Beller <sbeller@google.com> hat am 9. Oktober 2017 um 23:59 geschrieben:
> 
> 
> On Mon, Oct 9, 2017 at 2:29 PM, Thomas Braun
> <thomas.braun@virtuell-zuhause.de> wrote:
> > Hi,
> >
> > I'm currently in the progress of pulling some subprojects in a git repository of mine into their
> > own repositories and adding these subprojects back as submodules.
> >
> > While doing this I enountered a potential bug as checkout complains on branch switching that a 
> > file already exists.
> 
> (And I presume you know about --recurse-submodules as a flag for git-checkout)

No I did not know about it. I tend to not know options which don't complete in my shell (patch follows for that).

> This is consistent with our tests, unfortunately.
> 
> git/t$ ./t2013-checkout-submodule.sh
> ...
> not ok 15 - git checkout --recurse-submodules: replace submodule with
> a directory # TODO known breakage
> ...
> 
> > If I'm misusing git here I'm glad for any advice.
> 
> You are not.

Glad to know that.

> Apart from this bug report, would you think that such filtering of
> trees into submodules (and back again) might be an interesting feature
> of Git or are these cases rare and special?

For me not particularly. In my case it is a one time thing going from an embedded project folder to a submodule.
