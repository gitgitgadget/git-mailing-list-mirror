Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 833651F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 01:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755309AbcHSBnG (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:43:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50414 "EHLO mx1.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754686AbcHSBnD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:43:03 -0400
X-Greylist: delayed 2744 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Aug 2016 21:43:03 EDT
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u7IGGd2j006453
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 18 Aug 2016 18:16:39 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u7IGGfj7013597;
        Thu, 18 Aug 2016 18:16:41 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: git format-patch --break-rewrites broken in 2.9.3
References: <20160818144421.GA9062@aepfle.de>
        <20160818150522.56gdx2mhgo7qwvru@sigill.intra.peff.net>
        <vpqa8gayumw.fsf@anie.imag.fr>
        <20160818154022.5mp4cr5jq57doh3d@sigill.intra.peff.net>
        <20160818154813.GB9062@aepfle.de>
Date:   Thu, 18 Aug 2016 18:16:41 +0200
In-Reply-To: <20160818154813.GB9062@aepfle.de> (Olaf Hering's message of "Thu,
        18 Aug 2016 17:48:13 +0200")
Message-ID: <vpq60qyxdau.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Thu, 18 Aug 2016 18:16:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u7IGGd2j006453
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1472141800.31244@6f/7E2Bn5zT+1KidYDxDVQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olaf Hering <olaf@aepfle.de> writes:

> On Thu, Aug 18, Jeff King wrote:
>
>> Olaf, what version of patch are you using?
>
> Mostly 2.7.x, but also add 2.5.x to the mix.
> So far I did not try what the tools dealing with the resulting patch
> file would actually do with such a stripped down variant.

I think the way to go is --no-renames until you stop using patch <2.7.
If you don't want to specify it each time, you can revert to the pre-2.9
behavior by setting

[diff]
	renames = false

in ~/.gitconfig.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
