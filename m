Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89294208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 16:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754086AbdHUQVE (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 12:21:04 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:55303 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753684AbdHUQVC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 12:21:02 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1djpRi-0000tC-1k; Mon, 21 Aug 2017 18:20:58 +0200
Date:   Mon, 21 Aug 2017 18:20:56 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, bmwill@google.com,
        git@vger.kernel.org, larsxschneider@gmail.com
Subject: Re: [PATCH] pull: respect submodule update configuration
Message-ID: <20170821162056.GB1618@book.hvoigt.net>
References: <xmqqpobsbsk1.fsf@gitster.mtv.corp.google.com>
 <20170818220431.22157-1-sbeller@google.com>
 <xmqqvalk9is0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvalk9is0.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2017 at 11:24:47PM -0700, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> > From: Lars Schneider <larsxschneider@gmail.com>
> >
> > Do not override the submodule configuration in the call to update
> > the submodules, but give a weaker default.
> >
> > Reported-by: Lars Schneider <larsxschneider@gmail.com>
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
> >   
> > Personally I dislike this patch, but I have no better idea for the time
> > being.
> 
> The patch text from a cursory look seems reasonable to me.
> 
> It's not like you have 47 different codepaths that need to pay
> attention to the .update config and they all have to pass the new
> --default-update option, this is merely to fix one of them that
> relates to the problem reported by Lars, and you need a similar fix
> to other 46, right?
> 
> If you want the "--recurse-submodules" thing to always do the
> "weaker default" thing in your project, you can choose not to set
> .update to custom values in any of your submodules, so I do not
> think the reason why you dislike this change is because it would
> affect your use of submodules.
> 
> So I am a bit curious to learn which part of this change you dislike
> and why.

I am also curious. Isn't this the same strategy we are using in other
places?

Cheers Heiko
