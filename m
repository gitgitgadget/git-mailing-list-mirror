Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D14BF1F915
	for <e@80x24.org>; Sat, 14 Jul 2018 21:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbeGNVo5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 17:44:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:59648 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727580AbeGNVo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 17:44:57 -0400
Received: (qmail 28465 invoked by uid 109); 14 Jul 2018 21:24:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 14 Jul 2018 21:24:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3609 invoked by uid 111); 14 Jul 2018 21:24:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 14 Jul 2018 17:24:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jul 2018 17:24:33 -0400
Date:   Sat, 14 Jul 2018 17:24:33 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <Dilyan.Palauzov@aegee.org>
Cc:     git@vger.kernel.org
Subject: Re: bash completion with 2.18.0/maint: unknown options
Message-ID: <20180714212433.GB6430@sigill.intra.peff.net>
References: <d9272a12c2a38429857777f7811010956b7b6ed5.camel@aegee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9272a12c2a38429857777f7811010956b7b6ed5.camel@aegee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 14, 2018 at 02:46:17PM +0000, Дилян Палаузов wrote:

> After upgrading to 2.18 the completion does not work:
> 
> typing "git de<TAB>" prints
> my@host:~$ git deUnknown option: --list-cmds=list-
> mainporcelain,others,nohelpers,alias,list-complete,config
> usage: git [--version] [--help] [-C <path>] [-c name=value]
> [...]

In v2.18, the completions are generated programatically using new
options added to the git binary. The completion and the git binary
you're using have to be upgraded in lockstep (this has always been the
case, though I think this is probably the case where not doing so would
have the biggest effect).

Are you sure the git binary you're running matches the completion?

You mentioned that you're sourcing the completion from a clone in
/git/git. What does `type git` report?

-Peff
