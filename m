Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C00720986
	for <e@80x24.org>; Tue,  4 Oct 2016 17:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbcJDR1v (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 13:27:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:52162 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752537AbcJDR1u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 13:27:50 -0400
Received: (qmail 4619 invoked by uid 109); 4 Oct 2016 17:27:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 17:27:49 +0000
Received: (qmail 7420 invoked by uid 111); 4 Oct 2016 17:28:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 13:28:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 13:27:47 -0400
Date:   Tue, 4 Oct 2016 13:27:47 -0400
From:   Jeff King <peff@peff.net>
To:     Luciano Schillagi <luko.web@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: error
Message-ID: <20161004172747.ho53gxs3rcfucub7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK99BNA_2hwgkLUap_ThOG8drWkP6f74hdW=SNq_DpuNW=j2ew@mail.gmail.com>
 <C1F7B566-69F4-4A22-89EA-59B24677DF43@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[re-adding git@vger to the cc; please keep conversations on the list so
 everybody can benefit from the answers]

On Tue, Oct 04, 2016 at 01:13:16PM -0300, Luciano Schillagi wrote:

> I ran the command
> 
> Luko ~ $ git config --global --unset push.default
> 
> 
> and it gives me the following
> 
> warning: push.default has multiple values

Ah, OK. "--unset-all" would do the trick, but it may only be one
instance that you want to get rid of...

> I can access my file .gitconfig
> 
> I send attached...
> [...]
>
> [push]
> 	default = upstream
> 	default = aguas

Yep. Deleting the second line there will make your problem go away, and
presumably the first is a config setting you'd want to keep. That still
doesn't answer the question of how the "aguas" line got there, but I can
guess that at some point you might have set "push.default" instead of
"remote.pushdefault".

-Peff
