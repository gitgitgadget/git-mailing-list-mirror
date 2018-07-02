Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E59231F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 22:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932797AbeGIWig (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 18:38:36 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:44413 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeGIWid (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 18:38:33 -0400
Received: by mail-pf0-f175.google.com with SMTP id j3-v6so14636902pfh.11
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 15:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-original-authentication-results:x-gm-message-state:resent-from
         :resent-date:resent-message-id:resent-to:date:from:to:cc:subject
         :message-id:references:mime-version:content-disposition:in-reply-to;
        bh=BlNtE/5NoBYcWl6xt5z73oxSJwKrs9snfDeTNSQ5CV8=;
        b=rHFJCTyH8JaSsBiCdiCUDDLOdAeSk6U/34ZFTWMJAEvrok/2zhujR/bNTcGLr7uStq
         hedkT3rLhKfWWZMZcXpnobwQikbwGeGZlt5+oXW+ngr2O+ZxEDZzUS4Kr2ODYd9qtKAh
         Xs8io1pxkxpTFnU4DC9aDNeI1RmnR4fXbt55ukoNZki5in+/5b8JxMh3zkNaxOf3ty0w
         YJmLuMIv6JCGuu54fMtWo7kpJquQ5NNLYFlG8dWVlbSLfKoSltfgJJWtwLtJFDhoz/52
         AAXJAuRlVzhrn+6HTh517x5XutOjLSGHB8POv7xTtrolLHJ6HZpn31zme4FMWEi2A/qa
         edew==
X-Original-Authentication-Results: peff.net; auth=none
X-Gm-Message-State: APt69E1f+pSYE+j3YONVCavyCZvKDv8yKOIxOOZWaCfZuacAkwECvGfe
        C8AEG5X8cRafzI/MiS1B5wTlH9Bv
X-Google-Smtp-Source: AAOMgpfGH5mFBfizr81c4vz9Vz8+Jc012XSAUEyvoJwx0Dgj2e8wDoymfFftSxgxQXIE7Fl0d9fXeQ==
X-Received: by 2002:a62:6303:: with SMTP id x3-v6mr23133412pfb.91.1531175912199;
        Mon, 09 Jul 2018 15:38:32 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h132-v6sm25305141pfc.100.2018.07.09.15.38.31
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 15:38:32 -0700 (PDT)
Authentication-Results: peff.net; auth=none
Authentication-Results: cloud.peff.net; auth=none
Received: by 2002:a6b:c8cc:0:0:0:0:0 with SMTP id y195-v6csp387359iof;
        Mon, 2 Jul 2018 12:50:19 -0700 (PDT)
X-Received: by 2002:ac8:701d:: with SMTP id x29-v6mr24446387qtm.98.1530561018933;
        Mon, 02 Jul 2018 12:50:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1530561018; cv=none;
        d=google.com; s=arc-20160816;
        b=tCCSiacRQhy4gEcsCAtJqIO3q26ouVy/fsOcbS0EKjzPgFpidcbkHuVRTYNtK9wbPv
         EvqPI3ECFxW27o81l4fQlpEcpah2P69/BKmf1mUPm+0l1dLbUCRVyw74fz8Br1mJgjcV
         DPYkpkADeU4bPiNsDOBD0iX9kdypCK8Hml+x8bQTQaetf/NjpKllF3RWkavb+kBhNFOc
         WWeRqoIMibXm3jvkVwqoVVwLz5lfP8eQOt+6cYM/QJa8WGHf9Fr4kbgqpTTNiuXOMw7P
         k71aEXGxdx7NuE+PsLfwZu2VfHJ35rFKPa1rFYUCu0hDRcQRXCK2o7gxsGfMwKN7h7Hk
         tmyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:arc-authentication-results;
        bh=BlNtE/5NoBYcWl6xt5z73oxSJwKrs9snfDeTNSQ5CV8=;
        b=CeWCirQt0gj7RoL6S7IVK+L8K9Jwdy0FywZSRZfE3c5mwsBKXtuhOf2qO28ycalCUC
         nom3GhJ+Bdct7hTWevSCCKfObPny0W3Xw5xzSZ8fJt+K9BvgOd0pvCQNzQ4qIPMw6bUW
         9eHjteYXqdtvsmDwlq22/elP6CVTn5zDm4dnUloXqhs588ElOMt5jz5Xbh66yTIgzrPj
         WP4dUwK3joLhU2UN5BXUBF9CGHjU99LBw6W8zR4/L+Bm88mlf2PCzSQhJfNzGcdqCkPr
         gbOZz8hem7q+k4cEz8vXuyWTKgkNrjIprDSl1eyLieKtfaxHPzSZom+ESWdUBU8lNjf9
         SQgg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of peff@peff.net designates 104.130.231.41 as permitted sender) smtp.mailfrom=peff@peff.net
Received: from cloud.peff.net (cloud.peff.net. [104.130.231.41])
        by mx.google.com with SMTP id i6-v6si5390391qvb.31.2018.07.02.12.50.18
        for <jrnieder@gmail.com>;
        Mon, 02 Jul 2018 12:50:18 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 104.130.231.41 as permitted sender) client-ip=104.130.231.41;
Received: (qmail 4774 invoked by uid 109); 2 Jul 2018 19:50:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Jul 2018 19:50:18 +0000
Received: (qmail 26854 invoked by uid 111); 2 Jul 2018 19:50:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 02 Jul 2018 15:50:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2018 15:50:17 -0400
Date:   Mon, 2 Jul 2018 15:50:17 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian@gitlab.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jeremy Huddleston Sequoia <jeremyhu@apple.com>,
        Tim Triemstra <timt@apple.com>,
        Eliran Mesika <eliran@gitlab.com>
Subject: Re: Subscribing Apple people to git-security@googlegroups.com
Message-ID: <20180702195016.GA17102@sigill.intra.peff.net>
References: <CAGba+=U4nbxL2uuSxyqyZqiiavJpo_E=GhUkipz6DczLdmnkgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGba+=U4nbxL2uuSxyqyZqiiavJpo_E=GhUkipz6DczLdmnkgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 02, 2018 at 09:29:41PM +0200, Christian Couder wrote:

> When people complained a month ago about the MacOS package on
> https://git-scm.com/ not being up-to-date after the Git security
> release, I got in touch with Apple people GitLab has been working with
> to see if they could help on this.

Unfortunately I don't think this will quite solve the issue we had, just
because people get their copy of Git in various ways. So Homebrew
updated pretty promptly, but people going to git-scm.com to find a
binary package were left without help. Likewise, this will help people
getting Git as part of XCode, but not people gettin the package from
git-scm.com.

All that said, I'm happy to get as many binary packagers into the loop
as early as possible. It can only help, even if it doesn't solve all
problems. :)

> Please add these addresses to the git-security mailing list:
>     jeremyhu@apple.com
>     akilsrin@apple.com
>     dt-epm@group.apple.com

Done.

> Please add these GitHub accounts to the cabal repo:
>     jeremyhu

Done.

>     productsecurityOSSapple

I couldn't find that account. Is it maybe a team name within the apple
org or something?

> I am also personally very happy with the Apple developers' willingness
> to get involved and help.

Yes, welcome aboard!

I hope that maybe they're also interested in reducing the overall diff
between upstream Git and what ships with XCode. Last time I looked
(which was admittedly a while ago), a lot of the changes seemed like
things that could probably be considered upstream.

-Peff
