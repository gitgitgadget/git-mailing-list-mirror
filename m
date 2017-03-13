Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFEFD20373
	for <e@80x24.org>; Mon, 13 Mar 2017 20:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754275AbdCMUNI (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 16:13:08 -0400
Received: from fester.cwi.nl ([192.16.191.27]:37654 "EHLO fester.cwi.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753717AbdCMUNG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 16:13:06 -0400
Received: from fester.cwi.nl (fester.cwi.nl [192.16.191.27])
        by fester.cwi.nl (8.14.4/8.12.3) with ESMTP id v2DKCerA021638;
        Mon, 13 Mar 2017 21:12:40 +0100
Received: from [192.168.4.61] (541FB48C.cm-5-8c.dynamic.ziggo.nl [84.31.180.140])
        (authenticated bits=0)
        by fester.cwi.nl (8.14.4/8.12.3) with ESMTP id v2DKCdYP021630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Mon, 13 Mar 2017 21:12:40 +0100
Subject: Re: [PATCH] Put sha1dc on a diet
To:     Jeff King <peff@peff.net>, Dan Shumow <danshu@microsoft.com>
References: <20170301195302.3pybakmjqztosohj@sigill.intra.peff.net>
 <CA+55aFwf3sxKW+dGTMjNAeHMOf=rvctEQohm+rbhEb=e3KLpHw@mail.gmail.com>
 <20170301203427.e5xa5ej3czli7c3o@sigill.intra.peff.net>
 <CA+55aFz4ixVKVURki8FeXjL5H51A_cQXsZpzKJ-N9n574Yy1rg@mail.gmail.com>
 <CY1PR0301MB21073D82F4A6AB0DAD8BF1FCC4280@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <xmqq1suge1jn.fsf@gitster.mtv.corp.google.com>
 <CY1PR0301MB2107112BCC2DECD215E70549C42A0@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <20170313151322.ouryghyb5orkpk5g@sigill.intra.peff.net>
 <CY1PR0301MB2107B3C5131D5DC7F91A0147C4250@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <CY1PR0301MB2107876B6E47FBCF03AB1EA1C4250@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <20170313194848.2z2dlgpomu6e3dkh@sigill.intra.peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
From:   Marc Stevens <marc.stevens@cwi.nl>
Message-ID: <1e6a592f-7da1-8043-0b29-0bb7c8cda3f3@cwi.nl>
Date:   Mon, 13 Mar 2017 21:12:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170313194848.2z2dlgpomu6e3dkh@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Indeed, I've committed a fix, and a small bug fix for the new code just now.

The merge incorrectly removed some control logic,
which caused more unnecessary checks to happen.
I already marked this in the PR, but committed a fix only today.

BTW as noted in the Readme, the theoretic false positive probability is
<<2^-90, almost non-existent.

Best regards,
Marc Stevens


On 3/13/2017 8:48 PM, Jeff King wrote:
> On Mon, Mar 13, 2017 at 07:42:17PM +0000, Dan Shumow wrote:
>
>> Marc just made a commit this morning fixing problems with the merge.
>> Please give the latest in feature/performance a try, as that seems to
>> eliminate the problem.
> Yeah, b17728507 makes the problem go away for me. Thanks.
>
> FWIW, I have all sha1s on github.com running through this right now
> (actually, the ad744c8b7 version), and logging any false-positives on
> the collision detection. Nothing so far, after a few hours.
>
> -Peff

