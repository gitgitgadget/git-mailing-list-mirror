Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED61120437
	for <e@80x24.org>; Tue, 24 Oct 2017 12:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932199AbdJXMPq (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 08:15:46 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.27]:31577 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbdJXMPp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 08:15:45 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1e6y7S-0005NT-VP; Tue, 24 Oct 2017 14:15:43 +0200
Date:   Tue, 24 Oct 2017 14:15:36 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] status: do not get confused by submodules in excluded
 directories
Message-ID: <20171024121536.GA88363@book.hvoigt.net>
References: <244d71f47336e985ae265573b7d523cd8b3943bd.1508244305.git.johannes.schindelin@gmx.de>
 <xmqqo9oxkts6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9oxkts6.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 02:18:49PM +0900, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > We meticulously pass the `exclude` flag to the `treat_directory()`
> > function so that we can indicate that files in it are excluded rather
> > than untracked when recursing.
> >
> > But we did not yet treat submodules the same way.
> 
> ... "because of that, we ended up showing <<what incorrect result in
> what situation>>" would be a nice thing to have here, so that it can
> be copied to the release notes for the bugfix.  

Yes I agree that would be nice here. It was not immediately obvious that
this only applies when using both flags: -u and --ignored.

Seems to be a corner that not many people are using. At first I thought
a plain 'git status' would show that behavior...

> How far back a release do we want to make this fix applicable?  It
> seems that it applies cleanly to maint-2.13 without breaking from my
> quick test, so that is probably where I'll queue this, even though
> we may no longer issue further maintenance releases on that track.
> 
> Any comment from submodule folks?
> 
> Sorry that I didn't notice this was left unattended by anybody til
> now.  Will queue while waiting for those who are into submodules to
> respond.

Looks good to me.

Cheers Heiko
