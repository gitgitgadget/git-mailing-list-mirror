Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 330FC1F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 16:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbdKHQcz (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 11:32:55 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:54603 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752256AbdKHQcy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 11:32:54 -0500
Received: by mail-wm0-f47.google.com with SMTP id r68so12081348wmr.3
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 08:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7KHETFLwwuOduzb62SqLqe8RoopI7KkIygOIDvzElns=;
        b=m1H82XYcKV4HerpdUfFw+vtGJr+34dVkrW7z91QnZQgJ1qHTeDN8RrMbMuPZ2MXYhw
         7KKaS8lMKfsh3XmdRhj5aktHuo5M0KdGbgSb/gGe02C3lzcsTSz71QLPfmFlexUdgNVe
         i8hd39pTUs5NXiMuFL+vCQJK/1AJPWuj82chY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7KHETFLwwuOduzb62SqLqe8RoopI7KkIygOIDvzElns=;
        b=nRHPIZ4/vKSM1ArWoWer8QEieUexXkT5vMubub6ETZw9OZ4nBzXgbSv3z9zSDLT7ch
         fE/VcUC3+ULbJ/T0WCXzhQPyEly5205Bsgn1ckF11nPoyS/ekbaEJVvdlZ51JzsJHaqy
         DREdZkG8FngPvsKQ1NwXkYOZbxU/VVdI2OZBtzsLbyPX9dXi+heN/LEmNe/qMz96UgKY
         +rbs+wV83K+MXU/VGPPspIZZ7Bwn6CXhFb5PGBqJ+jPJfAFThP0RbNKHOtJAg3W46Pre
         oKi/uWI0LJHF7aZzOAYlcHIYazVplfXcxgzppp73kFw3YfC3dmGu4tMFiCKIjxf32BhN
         8xvA==
X-Gm-Message-State: AJaThX41ISzwjoySdMJ41/m6zLcATajYfTa5LZo1OoyrB/mvXZD66A2F
        NaaI7EyanBxoGGGI7p7Wc/8UENTp9RA=
X-Google-Smtp-Source: ABhQp+SM9tXc2vUciHR/1CkSvNhlddPQ3Fyhex+rMS2zxOcr5ureNsuqa0Cq2SuV4138cgBZqtxRyQ==
X-Received: by 10.28.230.140 with SMTP id e12mr818671wmi.118.1510158773087;
        Wed, 08 Nov 2017 08:32:53 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id p7sm4304828wmg.44.2017.11.08.08.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Nov 2017 08:32:52 -0800 (PST)
Date:   Wed, 8 Nov 2017 16:32:50 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [RFC PATCH] rebisect: add script for easier bisect log editing
Message-ID: <20171108163250.GE20681@dinwoodie.org>
References: <20171108135931.166880-1-adam@dinwoodie.org>
 <CAP8UFD015i76L4BgSZdr2k2TZk+C0vRAqOsj4DaqtNYuJjtNxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD015i76L4BgSZdr2k2TZk+C0vRAqOsj4DaqtNYuJjtNxQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 08 November 2017 at 05:12 pm +0100, Christian Couder wrote:
> On Wed, Nov 8, 2017 at 2:59 PM, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> > +git bisect reset HEAD
> 
> I guess that using "reset HEAD" could be cheaper than just "reset" and
> that's the reason you are using it.

Exactly that, yes.  I often use `reset HEAD` in my own workflows in the
name of speed, and I can't see any disadvantages of doing it here, too.

> > +git bisect start
> 
> Are you sure that this "start" is necessary? The doc says that "reset"
> followed by "replay that-file" should be enough.

It isn't necessary, in that the process works if you skip that command.
However, without it, the `git bisect replay` command prints "We are not
bisecting" before it does anything else, so having the `bisect start`
there explicitly removes that extraneous output.

If the script were integrated into git-bisect itself, it would probably
make sense to change that behaviour so the warning isn't printed.  (It
quite possibly makes sense to remove the warning when running `bisect
replay` regardless.)  But when writing the stand-alone script I wanted
things to work without any changes to the core Git code.
