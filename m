Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 204432035F
	for <e@80x24.org>; Fri, 11 Nov 2016 20:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936613AbcKKUC4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 15:02:56 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36208 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933931AbcKKUC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 15:02:56 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so10007173wma.3
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 12:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lU3hrJjflwbrdANf3o5oUpwk3G3uKogAqKYyofzOQFA=;
        b=BP2lRa2+zu+DIXUp7TCl92v2kqtBiNYyls6GfW9fElcrHvsA4XNolnqgnZ99zCgNZE
         Th2sZKM3/mNUTPnVag+wVu+A478Ic5+f5dVZluO0M0lIHNPV+EjR7niiQaW5xg/Nvp8w
         8+8WjRu8PEY24hgNM0/R10yq2hp6Hb3TA9EekCjyK8/fHdds40AmKCJc35NbrGZnjTo4
         wAMduwotJ1Xbo0u294HMhDvdLy6NJRAtervis71GvKXBxI506OF+9EUhPucW8C+mhBNJ
         k61jrnWBrqBPBTPfuVGnXlF9UHTSyo8W6a4YELHA93+wlVNLUD7CzUXr7Ls1l1nQ8Tpy
         E0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lU3hrJjflwbrdANf3o5oUpwk3G3uKogAqKYyofzOQFA=;
        b=aPqRP4d1SHHy9aHxUd4SJZHVhJIsTSJ6PJFxtxF1r/1g/0PCmSiaCAxcZhZkW8BEk7
         BTxi/4Mhf9350V92Ke1+bGf8bOW1JxVgxPsZBbyNBhWBu0vsEjH5jrwvJUJ+vRIJz/qw
         dY5Iuf36xDJnxoRiJD600Pm500rPMSgREKyYBWgcl6h16svIL/5nevj13OTVmHxqDC/s
         Q6HeuRsdFNTUVjYIWMjO9tw3GkyXtUgZBd3rCOic9GSblLxBNo7cu/ioX4EQOvaFhKXV
         Z2r3Gxz5EA30dLDtCZTkIfeHHu23YR7OQWldAgqwIIWdSQ2KAw2NnxP3Ql22ETjnQ7EB
         LAvQ==
X-Gm-Message-State: ABUngvfBXkhYFu5Eq4gzX0nq+VM3EabekuTCopdoL6SYtS3MXPees2IUdcLhqSout484eQ==
X-Received: by 10.28.39.193 with SMTP id n184mr13481384wmn.72.1478894574201;
        Fri, 11 Nov 2016 12:02:54 -0800 (PST)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id u17sm12929800wma.24.2016.11.11.12.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Nov 2016 12:02:53 -0800 (PST)
Message-ID: <1478894572.12153.1.camel@kaarsemaker.net>
Subject: Re: [RFC] Add way to make Git credentials accessible from
 clean/smudge filter
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        git <git@vger.kernel.org>, me@ttaylorr.com
Date:   Fri, 11 Nov 2016 21:02:52 +0100
In-Reply-To: <4060C484-B42E-42AB-BB42-4753373F0E7F@gmail.com>
References: <4C8C5650-7221-4F62-A9CC-81AE01EF6DC7@gmail.com>
         <vpqoa1n1qom.fsf@anie.imag.fr>
         <20161110160809.2gvf67rlnvounulf@sigill.intra.peff.net>
         <77603924-3552-4146-9C9E-A106CFA96D7A@gmail.com>
         <20161111093122.osbdwmze5x5t742v@sigill.intra.peff.net>
         <4060C484-B42E-42AB-BB42-4753373F0E7F@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2016-11-11 at 10:40 +0100, Lars Schneider wrote:
> On 11 Nov 2016, at 10:31, Jeff King <peff@peff.net> wrote:
> 
> > On Fri, Nov 11, 2016 at 10:28:56AM +0100, Lars Schneider wrote:
> > 
> > > > Yeah, that is the solution I was going to suggest. The credentials are
> > > > totally orthogonal to the filters, and I would rather not shove them
> > > > into the protocol. It's an extra process, but with the new multi-use
> > > > smudge filter, it's one per git invocation, not one per file.
> > > 
> > > 
> > > The trouble with "git credential" is that it works only if the credential 
> > > helper is setup correctly. Although I assume that most people have setup this, 
> > > I have also worked with a number of people who prefer to enter their passwords 
> > > every time Git makes a network connection.
> > 
> > 
> > Are you sure about that? If I do:
> > 
> >  echo url=https://example.com/repo.git |
> >  git credential fill
> > 
> > I get prompted for a username and password.
> 
> 
> Hm.. either I don't understand you or I expressed myself unclear. 
> 
> Let's say a user runs:
> 
> $ git clone https://myrepo.git
> 
> If no credential helper is setup, then Git asks the user for credentials.
> Afterwards Git starts downloading stuff. At some point Git will run my
> smudge filter on some files and in my case the smudge filter needs the
> Git credentials. AFAIK, the smudge filter has no way to get the credentials 
> from Git at this point - not even by invoking "git credential". 
> Is this correct?

I think that's correct, but the same argument goes both ways: unless I
use a credential helper, or explicitely give a filter application my
credentials, I don't want a helper to be able to get to those
credentials. I'd consider that a security bug.

D.

