Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EB791F463
	for <e@80x24.org>; Tue, 24 Sep 2019 17:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390849AbfIXRlC (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 13:41:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35418 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387559AbfIXRlC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 13:41:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id y21so1009916wmi.0
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zzUUKD6resH5b5vCnp+MRpC1aIQpyiybh+b8Nma/AHw=;
        b=Z8jwbcoi08RmWhrZKbOVi3WwFsOWevtz6/niCy40TmUcwO4/fQ0G8nMbnpHnx/ZWlx
         8HDb4TQTCEbRpY+t4x/H8sOfUEiDwJ+zy17ldv49VfCnMjmmxL3OJVbaZkJ+QDFLD7Xw
         naz1ha4LR0thakLFDeCza52WSbaF+OKWiG+v2LHZ/TzTBc4xVRmUZW/hQWTTFM6WqU5D
         A6f1/gX/8IxoxnSEg4MS1Rt2BzUU7KApuAPj+lx+7BJXHzxmcd8RBQz13S4Lkd0MOPAB
         WxTd0XU0i8vzvMFS3OdVBPU9Hv3a/jDyvek/aOC3plBm7heMbPFzFo6L/OF5Kkz6Pyp5
         H8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zzUUKD6resH5b5vCnp+MRpC1aIQpyiybh+b8Nma/AHw=;
        b=Ht7ZPgCjOC24rBswa9to1kSV/qag8kTivE08XvY03p6PvhytKQJdjPnPSI2AL6JOdz
         IFKS9vebPxOtO7RPruN0ZG/U9yTLK7B3SIAzqWzUKrD/2NIibhJUnT/E/qoxv2Eluy7n
         RjJ/Unprf9nmgM/Y5JsTEJ4ryXIYUANr0BhIgApXevVJ2ECTBQ54eHkR0nLDXQk9oNYN
         lAyXRCJgy/mzRs5xCykfzaiQ2/HXgTg/yITUV9VHGTMoqHLV2L5YIYK9cmiXh8tvhSsd
         yU3OO2+yPnAA1sFHIjm2dZgxJ9YUnK1gTYTHT+iZkZ+K2LZ9UQTSINtbVLgJGrnoLWuC
         P4HA==
X-Gm-Message-State: APjAAAUrQ+SvTgmBnXRB1UGRJGw+EWkd6GGomKd+vAbmyt7N704ClmCi
        TmCncpA0x/YRaqiGitGYEmI=
X-Google-Smtp-Source: APXvYqx/ULxUWlwUnx12mL7sAzF8jckBN6iY6RdNVEHvNlKM8iE1142CL4J0jPCTes4iG8fUOZ3p5A==
X-Received: by 2002:a1c:1903:: with SMTP id 3mr1353835wmz.4.1569346859981;
        Tue, 24 Sep 2019 10:40:59 -0700 (PDT)
Received: from localhost ([2.31.128.161])
        by smtp.gmail.com with ESMTPSA id s19sm5522799wrb.14.2019.09.24.10.40.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Sep 2019 10:40:56 -0700 (PDT)
Date:   Tue, 24 Sep 2019 18:40:56 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, git@sfconservancy.org,
        Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [PATCH] add a Code of Conduct document
Message-ID: <20190924174056.GA55104@cat>
References: <20190924064454.GA30419@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924064454.GA30419@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/24, Jeff King wrote:
> We've never had a formally written Code of Conduct document. Though it
> has been discussed off and on over the years, for the most part the
> behavior on the mailing list has been good enough that nobody felt the
> need to push one forward.
> 
> However, even if there aren't specific problems now, it's a good idea to
> have a document:
> 
>   - it puts everybody on the same page with respect to expectations.
>     This might avoid poor behavior, but also makes it easier to handle
>     it if it does happen.
> 
>   - it publicly advertises that good conduct is important to us and will
>     be enforced, which may make some people more comfortable with
>     joining our community
> 
>   - it may be a good time to cement our expectations when things are
>     quiet, since it gives everybody some distance rather than focusing
>     on a current contentious issue
> 
> This patch adapts the Contributor Covenant Code of Conduct. As opposed
> to writing our own from scratch, this uses common and well-accepted
> language, and strikes a good balance between illustrating expectations
> and avoiding a laundry list of behaviors. It's also the same document
> used by the Git for Windows project.
> 
> The text is taken mostly verbatim from:
> 
>   https://www.contributor-covenant.org/version/1/4/code-of-conduct.html
> 
> I also stole a very nice introductory paragraph from the Git for Windows
> version of the file.
> 
> There are a few subtle points, though:
> 
>   - the document refers to "the project maintainers". For the code, we
>     generally only consider there to be one maintainer: Junio C Hamano.
>     But for dealing with community issues, it makes sense to involve
>     more people to spread the responsibility. I've listed the project
>     committee address of git@sfconservancy.org as the contact point.
> 
>   - the document mentions banning from the community, both in the intro
>     paragraph and in "Our Responsibilities". The exact mechanism here is
>     left vague. I can imagine it might start with social enforcement
>     (not accepting patches, ignoring emails) and could escalate to
>     technical measures if necessary (asking vger admins to block an
>     address). It probably make sense _not_ to get too specific at this
>     point, and deal with specifics as they come up.
> 
> Signed-off-by: Jeff King <peff@peff.net>

I don't have much to add to this, the commit message spells out all
the reasons why we should have this nicely and I wholeheartedly agree
with introducing it, and choosing the Contributor Covenant as our
template.  So I'm adding my ACK to the others that have been coming in
already.  Thanks for submitting this!
