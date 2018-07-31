Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 341E01F597
	for <e@80x24.org>; Tue, 31 Jul 2018 16:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbeGaRnP (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 13:43:15 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35476 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbeGaRnP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 13:43:15 -0400
Received: by mail-pl0-f68.google.com with SMTP id w3-v6so7358010plq.2
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IwXnLXj39WFCq+bfPdR5rmoAWjpoIqVei7j4+dZrcEE=;
        b=K6Nl328rIxqFlF+ewDBYwcWqk8ma6cgdoaIAqHmrvJ+Jx9fD39Zmb5AkSF/KZptjNw
         kvzxU/2a7ddc0yKmKuUgOl62PXOWoddJBjDEZLV7A22iwgTmUHXnShY4Gwswgku3KLHl
         K7+sEUxwbFkMcWnXcGM3bqE8ctkpb2r8yqTip1QHdppDUpOvRUaSiMxtT8w0kd2p/GVR
         21rw0C/7SY6dyCGX9lZ5/j92nfoXWXCr4om6B3tVW8IGsqZ1Qhl4wRkSF7feFlt+FwoT
         c705w+9tesZ/6j2NmoTjMJaqdEibxTb4nhS7lVODkE3t/nmY3KDxuWYSYBA9jgJ1NeWr
         96Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IwXnLXj39WFCq+bfPdR5rmoAWjpoIqVei7j4+dZrcEE=;
        b=o+uItwjMgNnHtakhQvgSYH5dv8h7mZWO/J9MNn+TtUXOclw0txJZpn9o1aFmvNgH1v
         b5tJ8KjqIOvznO7l2QrQkDQRSl4IGGK7aSsqRx9P+8OVCIrg5bf10GSkI3/IiP68QXra
         V3vRC2gZDdcJJrQ12WtSlYdcxWvbZ7hUZZyKdAltJcA+UBwZQgkOv8/O94BvdnY4Zpaz
         YrGkTg67+k8/wVlCpC6Jw2vQpFN750ANuYU5goDW7DO2PqIlv6SeW2WhQy9ybq2p2WYu
         S0sDpb5ZUdpyS39jDfiVSoPEt3o99tX0JYs0LJwD/nNWkYRlWxVPn4XQIQj5CIzF5UWS
         xILA==
X-Gm-Message-State: AOUpUlEhmenK6kaIIAy7gJPLw4ssPLGqBlmY31WK9SX8Xk1pg5kCxV+2
        fU2uYpX3Uqo8V6tBqWJBMDSQIg==
X-Google-Smtp-Source: AAOMgpehhX1Su2nEaSLdJVu97nNV806/WcFNqJe4K/7ThY4i8CQYVo07w1pHpTPCSO3hxQbXvSiIcg==
X-Received: by 2002:a17:902:8506:: with SMTP id bj6-v6mr20768108plb.210.1533052935787;
        Tue, 31 Jul 2018 09:02:15 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id g11-v6sm38722170pgi.90.2018.07.31.09.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 09:02:14 -0700 (PDT)
Date:   Tue, 31 Jul 2018 09:02:13 -0700
From:   Brandon Williams <bmwill@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] refspec: allow @ on the left-hand side of refspecs
Message-ID: <20180731160213.GA192506@google.com>
References: <20180729192803.1047050-1-sandals@crustytoothpaste.net>
 <20180730175051.GA154732@google.com>
 <20180730231451.GG945730@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730231451.GG945730@genre.crustytoothpaste.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/30, brian m. carlson wrote:
> On Mon, Jul 30, 2018 at 10:50:51AM -0700, Brandon Williams wrote:
> > On 07/29, brian m. carlson wrote:
> > > The object ID parsing machinery is aware of "@" as a synonym for "HEAD"
> > > and this is documented accordingly in gitrevisions(7).  The push
> > > documentation describes the source portion of a refspec as "any
> > > arbitrary 'SHA-1 expression'"; however, "@" is not allowed on the
> > > left-hand side of a refspec, since we attempt to check for it being a
> > > valid ref name and fail (since it is not).
> > > 
> > > Teach the refspec machinery about this alias and silently substitute
> > > "HEAD" when we see "@".  This handles the fact that HEAD is a symref and
> > > preserves its special behavior.  We need not handle other arbitrary
> > > object ID expressions (such as "@^") when pushing because the revision
> > > machinery already handles that for us.
> > 
> > So this claims that using "@^" should work despite not accounting for it
> > explicitly or am I misreading?  Unless I'm mistaken, it looks like we
> > don't really support arbitrary rev syntax in refspecs since "HEAD^"
> > doesn't work either.
> 
> Correct, it does indeed work, at least for me:
> 
> genre ok % git push castro HEAD^:refs/heads/temp
> Total 0 (delta 0), reused 0 (delta 0)
> To https://git.crustytoothpaste.net/git/bmc/git.git
>  * [new branch]            HEAD^ -> temp
> 
> genre ok % git push castro @^:refs/heads/temp
> Total 0 (delta 0), reused 0 (delta 0)
> To https://git.crustytoothpaste.net/git/bmc/git.git
>  * [new branch]            @^ -> temp
> 
> Note that in this case, I had to specify a full ref since it didn't
> exist on the remote and the left side wasn't a ref name.

That's what I was missing, a full refspec! Thanks for the illustration.

> 
> Now it doesn't work for fetches, only pushes.  Only the left side of a
> push refspec can be an arbitrary expression.
> -- 
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204



-- 
Brandon Williams
