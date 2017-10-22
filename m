Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13FA5202DD
	for <e@80x24.org>; Sun, 22 Oct 2017 16:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbdJVQaZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 12:30:25 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:54155 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdJVQaY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 12:30:24 -0400
Received: by mail-wr0-f195.google.com with SMTP id u40so9243506wrf.10
        for <git@vger.kernel.org>; Sun, 22 Oct 2017 09:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fENI4u3CX7l7mFVU0fvbH7fOiJXlmAwL3F9vWI2HlBk=;
        b=hnRT5cN+E29XDmp/T6xHAG23SgxdKdjB5LTdw02PrXrHiIGCoOgEE29vY57s1Bgqh6
         NKdaLhmIw6h7Wg7vxCVZNXximWVnhdfzmYVtDSFYtFlMR67RoWkjM1MgdaPMDw+2d7H6
         rsaRy/Vws9rfVVpBtC91byCLeTW8u4X7LWrVAeEIPjgIeXjTNVT130tNZ7OHW8f9jCt+
         kMN9C52ksmJY2cVD6JHz0Gn5vI5Ipq3876Yk9A531qDdaGENWUPbL36lvxZzzY8VH46F
         IXUk1vg6TLyxmR5cr/8LQdYIBRqpD6yPEk8E+HqYoHmS6NrwkXjPofRe+m7KTNR+uq80
         rcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fENI4u3CX7l7mFVU0fvbH7fOiJXlmAwL3F9vWI2HlBk=;
        b=PdOBd3lOXdG27Ni9GclERKBAg0wsapUBiqvlhjPiWG34JlJ8SQpJ3OH33v9skNQm8y
         mFxJ26Loa0I8IzBJW+j3iezfNIFYEaK1wwkAOtO3v48QJEMaNH7smOf0mhejivBhRS6r
         Bka99rVkeBFti/rkfnjkFjFKkaKjJu1donlHiF/un4jdgAdEVGK0V1HKhPmIIcd0ubvd
         fQ9vC/BUIm404CsP6c2//Psy4KVFD3i091CjRFjiZ44hcvNCpf6C6CUMbQn/j7/Qg2y/
         My1USi3XRadt8ewJvJfNUmmNHp6yaoXJ5ZGBUZW0KMq0A6r1vAfBOvZhOLUiCnnyuETA
         cwSw==
X-Gm-Message-State: AMCzsaV3/9mRUzpKUSv6Ta7b8IXYjR6Q27Lj1WLe8zZEVwHMPJSUQq0m
        X7+blB6Lf/vFRZBPRQLCjYsfbZQ/
X-Google-Smtp-Source: ABhQp+Tw9HedkcW0UadEOBKp0ZEmFp7nzxVPHow4VkUgbdmOoLuSlia3IkWiJ//Ir74ZZpXGdhuq4w==
X-Received: by 10.223.133.4 with SMTP id 4mr8613996wrh.56.1508689823135;
        Sun, 22 Oct 2017 09:30:23 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id z35sm14506229wrc.9.2017.10.22.09.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Oct 2017 09:30:22 -0700 (PDT)
Date:   Sun, 22 Oct 2017 17:31:27 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        "Robert P . J . Day" <rpjday@crashcourse.ca>
Subject: Re: [PATCH v2 2/2] mark git stash push deprecated in the man page
Message-ID: <20171022163127.GK15399@hank>
References: <20171005200049.GF30301@hank>
 <20171019183304.26748-1-t.gummerer@gmail.com>
 <20171019183304.26748-2-t.gummerer@gmail.com>
 <20171021062846.s6rzo2hxmeqigk3e@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171021062846.s6rzo2hxmeqigk3e@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/21, Jeff King wrote:
> On Thu, Oct 19, 2017 at 07:33:04PM +0100, Thomas Gummerer wrote:
> 
> > 'git stash push' fixes a historical wart in the interface of 'git stash
> > save'.  As 'git stash push' has all functionality of 'git stash save',
> > with a nicer, more consistent user interface deprecate 'git stash
> > save'.  To do this, remove it from the synopsis of the man page, and
> > move it to a separate section, stating that it is deprecated.
> 
> This looks fine.
> 
> > @@ -87,6 +84,10 @@ linkgit:git-add[1] to learn how to operate the `--patch` mode.
> >  The `--patch` option implies `--keep-index`.  You can use
> >  `--no-keep-index` to override this.
> >  
> > +save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
> > +
> > +	This option is deprecated in favour of 'git stash push'.
> > +
> 
> We could possibly go into more detail, like:
> 
>   It differs from "stash push" in that it cannot take pathspecs, and any
>   non-option arguments form the message.
> 
> or something. Since we don't want people to use it, it probably doesn't
> matter much. I just wondered if people would peer at the (long) synopsis
> line trying to figure out how it's different.

Yeah, feels like it could potentially help somebody.  I'll add that, thanks!

> -Peff
