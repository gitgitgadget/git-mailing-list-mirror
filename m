Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94BB820248
	for <e@80x24.org>; Fri, 15 Mar 2019 13:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfCONTa (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 09:19:30 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:39062 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfCONTa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 09:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eyR63mrVUlJUmwolelGupCWCmTWCE3M0b1SA1fUiftA=; b=waOQdxTvYd/EYIVBnLcqCnVtk
        qXZQmIRM7F69mpRIzs7Wy7Z+fP9u2ugb2LByjHQj0BsyjhGJ6OT/QFQN8WgiWTKKt/RIfsRICTxLH
        xv9zpM8cGI6mfRJ9nFbveiN0Rk25caAG5w32McWUVVeFntbLbB+X1VT/JZiie8q0DPZqxxTQ5zW8B
        lhdRMdgJqvgE1S985Y0/DwAO7QCf6e/NnkkYRd9isGgQAKXaXHga3MQXnLXEaMZC5arDjgEIfWL2B
        XMWfJUKk0xiCP2dg6e1H2k0zwWeyvBqERZ7mmHChlOQL0OcwtAZ1cF+3uRBjgLS7bU2MeeixoCAca
        zy5T2/6YQ==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:34358 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h4mkA-006oWC-WC; Fri, 15 Mar 2019 09:19:28 -0400
Date:   Fri, 15 Mar 2019 09:19:26 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "git clone --shallow-exclude ...", fatal: the remote end hung
 up unexpectedly
In-Reply-To: <CACsJy8DVRJ4DG6PEkFuzytOQJ7RX6GMaHd4BRQTR9N7Y9V6fqQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1903150917360.27423@localhost.localdomain>
References: <alpine.LFD.2.21.1903150809070.26709@localhost.localdomain> <CACsJy8DVRJ4DG6PEkFuzytOQJ7RX6GMaHd4BRQTR9N7Y9V6fqQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 15 Mar 2019, Duy Nguyen wrote:

> On Fri, Mar 15, 2019 at 7:17 PM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> >
> >   probably doing something idiotic but i'm enumerating variations of
> > shallow cloning, and tried the following:
> >
> > $ git clone --shallow-exclude=master https://github.com/django/django.git
> > Cloning into 'django'...
> > fatal: the remote end hung up unexpectedly
> > $
> >
> >   it is entirely reproducible, and some googling suggests that this
> > represents an error at the *other* end, which in some weird way does
> > not support that clone option. that seems strange ... should this
> > option work? am i using it incorrectly?
> >
> >   wait, hang on ... i just picked one of django's topic branches at
> > random, and this did succeed:
>
> Yeah i think when you request shallow clone, by default it only gets
> one branch (see --single-branch, often 'master'). So when you
> specify --shallow-exclude you essentially say 'give me master branch
> but exclude everything from master'.
>
> I should probably make it print a friendlier message than simply
> terminateing like that (it's still a guess, I haven't tried it out)

  this is the first time i've played with this feature, so i'm still
working my way through the man page, trying to figure out the various
valid combinations for shallow cloning.

  i notice that the SYNOPSIS for "man git-clone" does not contain all
of the supported options (eg., --shallow-exclude is missing, among
others). is that deliberate?

rday
-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
