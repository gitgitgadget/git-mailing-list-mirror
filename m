Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C40C1F935
	for <e@80x24.org>; Tue, 20 Sep 2016 11:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753997AbcITLJY (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 07:09:24 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:35977 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752159AbcITLJY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 07:09:24 -0400
Received: from [91.63.252.67] (helo=book.hvoigt.net)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bmIp2-0002kT-9E; Tue, 20 Sep 2016 13:02:44 +0200
Date:   Tue, 20 Sep 2016 13:02:40 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Jonas Thiel <jonas.lierschied@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Homebrew and Git
Message-ID: <20160920110228.GA64315@book.hvoigt.net>
References: <trinity-9c8f1bd1-d6be-48f3-8575-03be09bd1243-1474213828361@3capp-gmx-bs53>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-9c8f1bd1-d6be-48f3-8575-03be09bd1243-1474213828361@3capp-gmx-bs53>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Sep 18, 2016 at 05:50:28PM +0200, Jonas Thiel wrote:
> A while ago I have described my problem with Homebrew at the following
> GitHub channel
> (https://github.com/Homebrew/homebrew-core/issues/2970). In the
> meanwhile, I believe that I my problem with Homebrew is based on an
> issues with my Git. I have found the attached Git Crash reports on my
> Mac and because I am not familiar with reading/analysing Crash
> Reports, it would be great if someone could give me some feedback on
> it.
>  
> If you have any question, please do not hesitate to contact me.

From your crash reports I see that git is apparently crashing in a
strchr() call from within ident_default_email() which is a function that
tries to assemble a name and email to put into your commits.

Can you post us the output of

	hostname -f

and

	whoami

?

Since it seems you are using an Apple git can you also give us the
output of

	git version

Since it seems that Apple is compiling its own git (and not publishing
the changes they made conveniently via git). Have you tried
installing a vanilla git via homebrew and seeing whether that also
produces the issue?

In your bugreport you are talking about modifications you do to your
system after which the issue occurred. I would suggest to exactly find
out which step lead to git crashing (if it actually is the issue). First
to identify an issue we need something that is reproduceable.

Cheers Heiko
