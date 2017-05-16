Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C22E81FAA8
	for <e@80x24.org>; Tue, 16 May 2017 17:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbdEPRLH (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 13:11:07 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33296 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdEPRLG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 13:11:06 -0400
Received: by mail-oi0-f53.google.com with SMTP id w10so33820990oif.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 10:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QOFs/NQ9sEwnr2fRVv5M1k08B4niDR+f5ZT1deLVkKI=;
        b=bkwgqAq1rt9zaYigd50I0BizBw1CdQYRtFj6wQuQWtcB8535l+pdTt7Z7RpXEveGTf
         IIfBar6QZJ7xqtQLtUkSkTjZ+2uJgeFoG4PLYBo8Lji8D2LGds7vSwP1y+neCvNlewbD
         Gl1C1hy8kBB2U3YvIdkFuB1UTovK/inmsQST6o6QqpDFKO0z+AFWBFEifCBLo1OGKCBt
         7Gex2GMyRZHujMaLIruYJbZxjWtmksPvYjpUG8YBz34NH8JadWfGT9qLpol1gr6h/gFQ
         76kBp6XInWEwKOFEoijp1UI6og5B5zuT/f0kUd1RrrhIKpPs3W9FdRNbq+0QWOnlpYcy
         R35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QOFs/NQ9sEwnr2fRVv5M1k08B4niDR+f5ZT1deLVkKI=;
        b=kS48ldBsw6N6nC0eawJlE19A1XO1XfMe02ZvG3M19s1aHDjdyjVbuHMdUewz+jj847
         Hb6HnHmzN/Q3ZkDbFF3XblRe98qrbVoedcFPvTitccnbC4//BjpK8qxvFKEs38pGvkC9
         wuFmv/QqDoMq+5cFF+gcg7ae8lZjCKq+nJ5dF+WB0Pmwz/+Vot/E0fcnYrQQ3xDMMEco
         Baz1zHbZMRIUu1eTRsHfIVmL0HLGY6i5q2sq2iwnESMzqg6BSL5XlZK/hhZ5b5JN1jho
         HhGFVERzQadnFdI63QE0qUhkWfEZJCC6SZMvpP0i24Qq8fNc80pW3tb+d0wQ6cL7J6n7
         7O1Q==
X-Gm-Message-State: AODbwcCjUI45VZ9Nr3R3CluXaAoRhW9rEE6Y31n/KTScLWX+Bg+i9jP1
        Qh+1rNHWm375/95z+bvS/nypnjgOvg==
X-Received: by 10.202.214.6 with SMTP id n6mr2658155oig.190.1494954665503;
 Tue, 16 May 2017 10:11:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.54.53 with HTTP; Tue, 16 May 2017 10:11:05 -0700 (PDT)
In-Reply-To: <20170516164750.3tw6xlbcbyuu5t72@sigill.intra.peff.net>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net> <20170516033736.23cfkouus3p67vhc@sigill.intra.peff.net>
 <20170516164124.GO27400@aiede.svl.corp.google.com> <20170516164750.3tw6xlbcbyuu5t72@sigill.intra.peff.net>
From:   Eric Rannaud <eric.rannaud@gmail.com>
Date:   Tue, 16 May 2017 10:11:05 -0700
Message-ID: <CA+zRj8VjNDaX0vgWX5pRMMVnFHzb_Hgx-WhHgVEe74JaRawO0g@mail.gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly to --exec
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeremy Serror <jeremy.serror@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 9:47 AM, Jeff King <peff@peff.net> wrote:
>> I think we want to behave consistently for shell builtins and for
>> exported functions --- they are different sides of the same problem,
>> and behaving differently between the two feels confusing.
>
> Yes, I think ideally we'd handle it all transparently. Although I'd also
> point out that Git the behavior under discussion dates back to 2009 and
> this is (as far as I can recall) the first report. So documenting the
> current behavior might not be that bad an option.

This is on Arch Linux which is usually pretty aggressive with their
Git upgrades and I first saw the problem this week. The script that
hits this case runs constantly on my machine so my guess is that if
anyone relies on the old behavior, they're just starting to see a
new-enough Git to have a problem.
