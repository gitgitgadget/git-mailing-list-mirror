Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 920D11FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 15:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbdBMPx6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 10:53:58 -0500
Received: from ikke.info ([178.21.113.177]:48880 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751714AbdBMPxl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 10:53:41 -0500
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Feb 2017 10:53:40 EST
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id E74DD4400C9; Mon, 13 Feb 2017 16:44:07 +0100 (CET)
Date:   Mon, 13 Feb 2017 16:44:07 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Istvan Pato <istvan.pato@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug in 'git describe' if I have two tags on the same commit.
Message-ID: <20170213154407.GA31568@alpha.ikke.info>
References: <CAOcUJQwnCJOhUUU2RqJP2H5YxUr4qCEpyDj_XiiQSe4V6rcBmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOcUJQwnCJOhUUU2RqJP2H5YxUr4qCEpyDj_XiiQSe4V6rcBmg@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 12, 2017 at 01:15:22PM +0100, Istvan Pato wrote:
> I didn't get back the latest tag by 'git describe --tags --always' if
> I have two tags on the same commit.
> 
> // repository ppa:git-core/ppa
> 
> (master)⚡ % cat /etc/lsb-release
> DISTRIB_ID=Ubuntu
> DISTRIB_RELEASE=16.04
> DISTRIB_CODENAME=xenial
> DISTRIB_DESCRIPTION="Ubuntu 16.04.2 LTS"
> 
> (master)⚡ % git --version
> git version 2.11.0
> 
> (master) [1] % git show-ref --tag
> 76c634390... refs/tags/1.0.0
> b77c7cd17... refs/tags/1.1.0
> b77c7cd17... refs/tags/1.2.0
> 
> (master) % git describe --tags --always
> 1.1.0-1-ge9e9ced
> 
> ### Expected: 1.2.0
> 
> References:
> 
> https://www.kernel.org/pub/software/scm/git/docs/RelNotes-1.7.1.1.txt
> 
> * "git describe" did not tie-break tags that point at the same commit
>   correctly; newer ones are preferred by paying attention to the
>   tagger date now.
> 
> http://stackoverflow.com/questions/8089002/git-describe-with-two-tags-on-the-same-commit
> 
> Thanks,
> Istvan Pato

Are these lightweight tags? Only annotated tags have a date associated
to them, which is where the rel-notes refers to. 
