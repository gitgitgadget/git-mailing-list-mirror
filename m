Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188D2209A9
	for <e@80x24.org>; Tue, 20 Sep 2016 21:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754806AbcITVu1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 17:50:27 -0400
Received: from mout.gmx.net ([212.227.17.21]:56872 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754314AbcITVu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 17:50:26 -0400
Received: from virtualbox ([108.198.118.51]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lfppu-1bBSA21un4-00pIBW; Tue, 20 Sep 2016 23:50:04
 +0200
Date:   Tue, 20 Sep 2016 23:50:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2016, #05; Mon, 19)
In-Reply-To: <xmqqd1jzcvs5.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609202349260.129229@virtualbox>
References: <xmqqd1jzcvs5.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UE7pHAbSK7BgkqE3aZLBPheu6GIFp2rJDt0NmObWalRs4OYXqS7
 bp2S9J2NL4S76Okrd4rdy82ZPudAgiwKWZaURWf85/0PZyFN4FX5KMGCS90zC4K21tfPzzu
 IJlvr1IXvGScRGSiJ+bZHunPl4t04HHHle4TiGvSRHE96QxlYUnJTcb2sdh+306NiG/IzSr
 54qvFdwduZUYnRMOhKuZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J32GHax4PEs=:oSTEpxhW9NfPq62FSbUevM
 GhWbp5ctzZKSm5V1DzYUwhAVxsxH93sXty21W4AkM+bnFFHdxICcq113agdA8VOKpww/sSSRq
 hxWAZ8jDhilIalUMfnjhA4MnAugA/m7vO4yDj+uibZJSktMy5hR9QMIpSJgdFfpv39W18dvYY
 MIRkFYcjKQFkIOtnw/qXyquZqve6gY3gK8QdlELpcwZvk5yU37sLuqYppFYt3tXYodbXSr9/D
 xZs4OST1If5+UHvmwb/KyV1VN+IGNsTx2ZuZZE3t/84uDL+S7TBoxJKoNQ02CyKDE4BobrZ3T
 +F/e4geprbDIh+Mi0B156l6zo8znDtEbMT7NWvrddymaPPtRLzs13gfD0L9ZxKejLT72YQI2J
 qYFqIBNv/zDcxkD37RvBwA5ajX58CBRvofMEzbwHnQajq4MLhZifmOK2ETNWA+PsRTlRQjCCy
 IT/lClJGY1WxIiMKCQNze1xRTXsikVqJKphanGG3PTjILG+BsSix1ul6uwInfjcbwBJG4Plrn
 weuVMCkU0kM6XfGJd932TJ5pwne6GqkgUJN5gQf8Zz7KS6pTKEtA7rCyia70t+I3chVLqzGBw
 2cu/91ckM6bDljqpe+NFj1zPrlf72KdNQIzjQkDNI9zPBu1CjOHpsVa7CCU3kGWdF/1nwy+lC
 UvpW5fm+3RiaPIy5W0+iQzyeCt8eNBgRLSfZlIGuPp6i4X8nyD/5gKEYQh7KS6To0f8I8TAtG
 PWIs5utJ6j+MFPPqbAfJOXWB/6IaHrpsDzUsgu4vLJe22ZPMGU9Wp1LgtzRl5FdP3NrX6IET8
 yZRX4BZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 19 Sep 2016, Junio C Hamano wrote:

> * jk/rebase-i-drop-ident-check (2016-07-29) 1 commit
>   (merged to 'next' on 2016-08-14 at 6891bcd)
>  + rebase-interactive: drop early check for valid ident
> 
>  Even when "git pull --rebase=preserve" (and the underlying "git
>  rebase --preserve") can complete without creating any new commit
>  (i.e. fast-forwards), it still insisted on having a usable ident
>  information (read: user.email is set correctly), which was less
>  than nice.  As the underlying commands used inside "git rebase"
>  would fail with a more meaningful error message and advice text
>  when the bogus ident matters, this extra check was removed.
> 
>  Will hold to see if people scream.
>  cf. <20160729224944.GA23242@sigill.intra.peff.net>

Let's do this.

Ciao,
Dscho
