Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2FAC433E0
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 05:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40860206BE
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 05:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGCFV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jul 2020 01:21:56 -0400
Received: from ikke.info ([178.21.113.177]:40596 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgGCFV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jul 2020 01:21:56 -0400
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Jul 2020 01:21:55 EDT
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id E45FD440122; Fri,  3 Jul 2020 07:14:22 +0200 (CEST)
Date:   Fri, 3 Jul 2020 07:14:22 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Tomas <correo@tomaszubiri.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: commiting a change from command line with newlines.
Message-ID: <20200703051422.GB2450243@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>,
        Tomas <correo@tomaszubiri.com>, git <git@vger.kernel.org>
References: <17312e90c37.fefa495d137526.1559287962218705021@tomaszubiri.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17312e90c37.fefa495d137526.1559287962218705021@tomaszubiri.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 03, 2020 at 01:22:09AM -0300, Tomas wrote:
> Hello,
> 
> I'm trying to write stanzas in my commit message, and naturally the ASCII newline character is the best tool for this, beautifully integrated throughout my whole system, from my keyboard to my screen.
> 
> My question is, how can I add a newline from the git command line without opening an external program like vi, atom, notepad, word etc...
> 
> Since I'm using a unix like system I even tried with pipes (and xargs, the necessary evil) but with something like "printf "a\nb" | xargs git commit -m" b gets interpreted as something else. 
> 
> Does anybody know of a way to adorn a commit message with newlines in a single git commit command? 
> Thanks in advance.
> 

git commit accepts multiple `-m` arguments, where each message will be
concattenaed with two newline characters.

So `git commit -m "add foo to bar" -m "foo is necessary to allow bar to
..." -m "baz would not work in this case because.."`

Would turn out as:

> add foo to bar
>
> foo is necessary to allow bar to...
>
> baz would not work in this case beacuse..

Hope this helps,

Kevin
