Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F9DC2BBD1
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 08:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 050A72075B
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 08:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIQINg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 04:13:36 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:52761 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgIQING (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 04:13:06 -0400
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 04:13:06 EDT
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MXH3Y-1jzeih3jKA-00Yhki; Thu, 17 Sep 2020 10:07:33 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id E83E21E01E7;
        Thu, 17 Sep 2020 08:07:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TxaBqwmE-x8s; Thu, 17 Sep 2020 10:07:32 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id AD5DF1E01E6;
        Thu, 17 Sep 2020 10:07:32 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 817C68051A; Thu, 17 Sep 2020 10:07:32 +0200 (CEST)
Date:   Thu, 17 Sep 2020 10:07:32 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: option transfer.ipversion to set transport
 protocol version for network fetches
Message-ID: <20200917080732.GB8079@pflmari>
References: <20200915130506.GA2839276@coredump.intra.peff.net>
 <20200915135428.GA28038@pflmari>
 <20200916200203.GA37225@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916200203.GA37225@coredump.intra.peff.net>
X-Provags-ID: V03:K1:9fq3GTeh8KpRc5c6HlJq2IISy87Lf3fq8X+c8l2KJdM/6R8yJJu
 Ev6hc8pF8Xpbuk/P2HmBQ4XHRrDTgBLwsV3qE/lL40yAsNGL6136bUFI/jKWKP3u/yAQYi8
 MqPiFlQ0i49DvWqS54p2rQka9asujeNpttoQsrBzKWm6FfJKOPo5NZl8RN0nIyENikrHRZ0
 npeKoS3tVYpRTpQbxC1CQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x0oULTi1r68=:vgUVvN9vqhcDOfYr9KE5kg
 5WwDuhmfNxcCNFv8D6fCCHyuJD4hbrbvDo451tpXh936eMX9kyJDT7m3GN7DheadQTwWHOrHk
 pdxzFXhNoXBl7dfa2baZpXsRlQb4ZCY788cAK/eRHpmbstRpXmcE8/Qk5arQGW6pMvHGLZHba
 PI5h7Nik0AibM3jJrD1hPuzVqyojuAWhSf9HdqFK90Ded5ZPHhwaDY3WJs9/j/DATCuC1AUZf
 ryZV1z2Yol5qCFysgQ7SLfWyROLejdsZHPSHIC4tTv+xtV2VIl5k17UOHzCLZRhiq/7aEGeK4
 Salr7VkvAtgY+L2Je9gIWRNsPH5C4lA+sjpXvb44XwF5JALWatw5F3x1tJL0fgzgKTswwq6pS
 0T9jCNdbE3tcS1f9s7zAenqEkL3vrnHG/frUpbeqP50rcshovni9L24M3V78VhpL+LVZxd5fW
 3au06UU2c2FiyemymS7Gj5YLQ1+dMuQGL34SSuQcr9YTZxdIFUqkbGifHhiKjI0/3BR3aY220
 /67ZDnb/+yekoFsrBBatya9nqx9RGA5UoRLYLWSq6MgIxJo7+sxiRCL2tJoJnbat+7u4bYxrW
 Z6/MzgoSRSfDEZNNm06VFgz1aQ+tbf2jxinV9vYIKqbfp2wMw73pm4mm9hpwrvaRg48tcrX5E
 BNK32kh3hiLRNqXYJnb7671KD5moVVJDE9WdYiYENyilwHVQQ55kiJfrds8IfjxdJX/td5XJe
 O7j8y7DR5VtICqRcEWafEZGhLab0XbjVfzCZwq97UchYRTE2nQVtcVNcVUfom3PlkEovn7eaw
 jFuQLLMvevk8DIj9M4rzgkHEas3wKNo2Z1CezJb99oswissS35qAek30mYf9aUEU2/WZf+aYu
 Pmq/GTwjLBDN7bLsd4RA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King, Wed, Sep 16, 2020 22:02:03 +0200:
> On Tue, Sep 15, 2020 at 03:54:28PM +0200, Alex Riesen wrote:
> 
> > Jeff King, Tue, Sep 15, 2020 15:05:06 +0200:
> > > On Tue, Sep 15, 2020 at 01:50:25PM +0200, Alex Riesen wrote:
> > > > Sure! Thinking about it, I actually would have preferred to have both: a
> > > > config option and a command-line option. So that I can set --ipv4 in, say,
> > > > ~/.config/git/config file, but still have the option to try --ipv6 from time
> > > > to time to check if the network setup magically fixed itself.
> > > > 
> > > > What would the preferred name for that config option be? fetch.ipv?
> > > 
> > > It looks like we've got similar options for clone/pull (which are really
> > > fetch under the hood of course) and push. We have the "transfer.*"
> > > namespace which applies to both already. So maybe "transfer.ipversion"
> > > or something?
> > 
> > Something like this?
> 
> That's the right direction, but I think we'd want to make sure it
> impacted all of the spots that allow switching. "clone" on the fetching
> side, but probably also "push".

Ah sorry. Missed that push case.

