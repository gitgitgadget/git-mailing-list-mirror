Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36182208DB
	for <e@80x24.org>; Thu, 24 Aug 2017 10:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbdHXKWI (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 06:22:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33497 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbdHXKWH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 06:22:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id b79so2294932wmf.0
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 03:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uaLhJBOvF1NZv7RKz9yZBVp+JLmkPYyVEOJ+rARVCKM=;
        b=NadqwqRGg++tgKug4nLKVt8NdbPx7euhogewvragw5Pho9qrV/h7/XWpai8u+K8Xml
         ZaBXbZPegjNYgqCdusGFjmUJDnqLXoMJQD6kgmMcGOq4GD297N9Vk7/H8XBA99ipWpJW
         xDAcgOX6Ic2ew8y2bwtbxp4ROK3COABRvjOG/KpCnFrHq13x5mCqxspURfmhzGnlgJFB
         I4xoFDTocCJBDQv0v2/Pj+kA9RdUVKCFJTrmrb78dHWK99th0fzeEj1HUsAOR1ux3TQy
         yUZOY5YiQ8Q7a5ShnSIU0jSkigoQ1unVMPN919TPBgtOxkOrRsPmdfS2mo1o+gro+kPa
         ofrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uaLhJBOvF1NZv7RKz9yZBVp+JLmkPYyVEOJ+rARVCKM=;
        b=nILj0hXGoMivI3EhF1vSftVfQzuempCRUfcM3BR2XjVbYZy1W011NECyFWAh5xJGjw
         sAtjt820f7kG8PK5z/b0OeEJCLIwFJnMOlyb5Omz414Kd8aMYHXAoHwpOPYRuYR1R3NP
         NZnGEtsOv0NhHg6v6wSwiGhDGyNwl5eekXJQRP+Xdx61rNWSHjo0GoXYGSeytsvynpcc
         7IOiskXQLrRyS7CI12OxLVJKHtdWkW8gNQNe8Md7AFOOZRy46etzHLXvM86RyNivP1Cq
         Qp4tP0wnP5PDk2aAOJCZbkbrqbVcg53Aljav3YYicXZm8a8PtXVWv2GPOLhEdwfzTejN
         0CRA==
X-Gm-Message-State: AHYfb5h/HFj6bylz9Js0/BT/7Q3+o8o3XGrpCwLdO3WRqWmAEVsUbMoL
        NGNvRBrTqeyLDhg0
X-Received: by 10.28.183.212 with SMTP id h203mr3147950wmf.140.1503570126059;
        Thu, 24 Aug 2017 03:22:06 -0700 (PDT)
Received: from mimir ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id s4sm4061442wrc.13.2017.08.24.03.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2017 03:22:05 -0700 (PDT)
Date:   Thu, 24 Aug 2017 11:20:16 +0100
From:   Richard Maw <richard.maw@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC PATCH 0/7] Implement ref namespaces as a ref storage backend
Message-ID: <20170824102016.GA2021@mimir>
References: <20170813193611.4233-1-richard.maw@gmail.com>
 <xmqqefscsqj1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefscsqj1.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 10:13:22AM -0700, Junio C Hamano wrote:
> Richard Maw <richard.maw@gmail.com> writes:
> 
> > This is not my first attempt to improve the git namespace handling in git.
> > I tried last year, but it took me so long that all the ref handling code changed
> > and I would have had to start from scratch.
> >
> > Fortunately the pluggable ref backends work provided an easier starting point.
> 
> Yeah, I also made an ultra-brief foray into ref backends a few weeks
> ago, and found that Michael did an excellent job identifying the
> building blocks backends may want to implement differently and
> abstracting out major parts of the ref processing.  I also hit some
> of the same issues you mention, e.g. "HEAD" and other funny refs.
> 
> I do suspect that the current GIT_NAMESPACE thing may have outlived
> its usefulness and with the pluggable ref backend thing in place, we
> may want to redesign how support for multiple views into the same
> repository is done.  I do not have a need for such a thing myself,
> but I am glad somebody is looking into it ;-)

It was great to be able to get something mostly working this time around,
which would not have been possible without the pluggable ref backends.

I've no intention of giving up just yet,
though it'll be a while before I can devote significant time to it.

I'll be keeping an eye on the refdb backend.
If it in the process fixes the issues I'd been having that'd be so much better
since I've not got the time or community standing to champion big changes.
