Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA19C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 07:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88DF421734
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 07:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgIRHRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 03:17:04 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:58765 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgIRHRE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 03:17:04 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MdNHa-1ksVO51eWe-00ZRtZ; Fri, 18 Sep 2020 09:16:49 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 334591E01E7;
        Fri, 18 Sep 2020 07:16:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O_SBveOFVqeA; Fri, 18 Sep 2020 09:16:47 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id A925C1E01E6;
        Fri, 18 Sep 2020 09:16:47 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 7E8D28051A; Fri, 18 Sep 2020 09:16:47 +0200 (CEST)
Date:   Fri, 18 Sep 2020 09:16:47 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: option transfer.ipversion to set transport
 protocol version for network fetches
Message-ID: <20200918071647.GA17896@pflmari>
References: <20200915135428.GA28038@pflmari>
 <xmqqtuvxwkbz.fsf@gitster.c.googlers.com>
 <xmqqk0wtv204.fsf@gitster.c.googlers.com>
 <20200917140254.GA28281@pflmari>
 <xmqqbli4ox0h.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbli4ox0h.fsf@gitster.c.googlers.com>
X-Provags-ID: V03:K1:pabLYQ+djiq1iVnjJq7oMoAG7PSeV0vYo1eE18hGQ4oNUqQ2RT6
 dcOT1o+kcORPiamukiW9mpsHZElM7xRb3pwmusUd0eA2CZCjpBXkbU1M0cJtEe7uHh3VSRk
 YjB3Dw8jSvfsCnCmEMIJ68O0IJTExpq4XkeJzlHJtzKflQUprxnHSNtcxOOBT+mdrpFDaIC
 qmZRefMlyxjMAOFOQWc3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:88X5yfb4vgA=:XPTx4u9p7a2qjVbbuEY9m9
 h8UpFFIDu6M7FMTeqHDN72rYmVwlSTrs8nb+8E63YLBtY0OFXPtyRoCqTVJjWqg9gWsD4aAUS
 LNdlTXK6UR4u+m2IyUNKVrswkHi8/poxYJMPNOP5zhA83mVNqVj/JWywHegAJajy9zhCd5S3m
 XdVmfpqaikMpa0zRKOwOVUMztT/Ojpt2Rx8SImLXRYjhPZ4diK0ZeMEpd7ifXVXiUPQKr/fWS
 ZhWpKIsOCrnMDlcurb1Llcfre+BXRyFz28CHmkmbIJV4KpwQBk8kLqzztm2AILdC8LMZ0KS2H
 0UbV9q6VggVOwHMGfvZWeESWDIcRw1LlvqOTebIvXrG0u53aWL+OFpjOu4p6/gwzuhF6gd0mL
 1VFB2vp/alWerCV752tfdNwt8Ia6ymaHjBDb2t3SXyQOakXCvEH4kg7Z3GSPRAGeNisZ6KsMd
 txpdC+rcsmHQBslJHzij6DAJTRnge1oa9Id0bymUX2dkHdTCIhhWI0liU1X+dLkyTtZ8MHPfX
 SOREkYYMH7e0Y2iXJZKeQL8k1QS5Ads1SEKTOdi7ZpPrcwPgsmdoBojsk5UoMR9RrkjhihjKQ
 LFz8AvPx2sMv3wQeFFLtF6zfb+BZ/hPzdpVYl6kqVo9baN+0pD4DBvxnIIvmomR2BAZrpKklg
 pYO2irYbN08g0XX/JR3A1uY9oCVnM6MjtynoYE49eBy9YGkZrarrxM/2QDjhZt9M7CBX81IFG
 8kQMlJS5cVh1Z3yqgEq5KBtn+0taxDf8Rts0ZDhXtm1PRNxtlZKKPXLsELB8r9h2hGyIMzKY2
 +/roeVBsrn25gyCwfDURPpwSG37Cdh3M3EkJVlS1e4f0xSIqAW115DDWpE5iWlyC1/YBMM8tE
 5xf1hITcVG2DdPTFDItg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Fri, Sep 18, 2020 00:31:58 +0200:
> Alex Riesen <alexander.riesen@cetitec.com> writes:
> 
> > If the configuration variable is allowed to be set to that "lack of
> > preference" value, we kind of have a command line option for it:
> >
> >     git -c transfer.protocolFamily=any fetch ...
> 
> Yes.
> 
> But we typically do not count that as being able to override from
> the command line.  If "git fetch --ipv4" will defeat the configured
> "transfer.protoclFamily=ipv6", the users will expect there is some
> way to do the same and say they accept any protocol family to be
> used.

Makes sense. I even wondered myself why there is no way to override
an --ipv4/--ipv6 in command-line back to "any" with an option added
after it:

    $ cat my-fetch
    #!/bin/sh
    git fetch --ipv4 "$@"

    $ ./my-fetch --ipv46

But how about making the command-line and config option a list?
(renaming it to ipversion, as elsewhere in the discussion)

    git fetch --ipversions=ipv6,ipv8

Given multiple times, the last option wins, as usual:

    $ cat my-fetch
    #!/bin/sh
    git fetch --ipversions=ipv4 "$@"

    $ ./my-fetch --ipversions=all

BTW, transport.c already converts transport->family to bit-flags in
connect_setup.

