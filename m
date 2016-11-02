Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D674C20193
	for <e@80x24.org>; Wed,  2 Nov 2016 23:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932873AbcKBXe7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 19:34:59 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35649 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932766AbcKBXe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 19:34:58 -0400
Received: by mail-pf0-f176.google.com with SMTP id i88so19736464pfk.2
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 16:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=noJ5m21C0sEH/55DWK3SqnOoRzUSZ8TP4FOxr0vZ0YA=;
        b=VNBtzv0+ulsfaMvUAssThucQ5KFXMsuo19fqwYt2Nzk2rz0zyK2FWQwjuuqdafC3Dd
         NooNoXgm0YiqZ6KU8q5hROz86f5dV2mX/4Yzezg/l8FgtzkQeX2vo1+INLpNMX3TXh0A
         LiyPL2f3Ng6WZbgO2pu/SjiSGsL30NV5XOVzEJragCJURkhqkXe/XdO7ebSVSe554sy0
         LLDyD8LAqX47a6Vgmyhl1T57dX59awFnEiW7aafvEaM3oYsZAQEPpucipxi1er4rwYU8
         eyeLBKxmUydKH2RoB6p4R42ROY3cB/NLT9zXbN/FWG6WgkS+RuRih4vvPAtLJTgKSbKK
         zbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=noJ5m21C0sEH/55DWK3SqnOoRzUSZ8TP4FOxr0vZ0YA=;
        b=SWyJSSN50RKR2t6el10HI+BhOwYLp1cazmw/G1pUXNwnyufkB6nN4RHvoTmyZDFWsr
         kDPFPbWncA6G1t2dK5gKv1IpUDycxNf5wwu1V/b4dlPTlBvtTQvEwjl+LpQm5AqTjeVK
         hegZOrlu1/sMhn7A29pgBqB9Wyiti1f65YPq3l9+AErLrXeJQ0pvRKwk1yTYQ6sHQ1vF
         vYGAwhxnM2VVM1cgZNGW1ziCQbPe3lnlw9PkOyksv22qBFsCXrh9q5ltnUfM3bCRplYw
         n8g9bMrFbIVcE+qe9TGkR2SUPCdt8prEH7Z6pgNrfOxWUFlh4MRfNEDAG5yNP0PK/wrA
         LZzw==
X-Gm-Message-State: ABUngvdGDkWJMWT9NkXRS+5/9DffuLuWnQCoZC8HmfdJR484/hpbG8mRjiK7icu1pJB6TPJw
X-Received: by 10.98.16.203 with SMTP id 72mr11455934pfq.57.1478129697237;
        Wed, 02 Nov 2016 16:34:57 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:8080:eeb8:e27c:9538])
        by smtp.gmail.com with ESMTPSA id s64sm7230460pfk.81.2016.11.02.16.34.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 16:34:56 -0700 (PDT)
Date:   Wed, 2 Nov 2016 16:34:55 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161102233455.GC183367@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161102230538.jx3jwa4hqgrrltno@sigill.intra.peff.net>
 <20161102230853.3xdk6ksnzzote5ud@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161102230853.3xdk6ksnzzote5ud@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/02, Jeff King wrote:
> On Wed, Nov 02, 2016 at 07:05:39PM -0400, Jeff King wrote:
> 
> > > +core.allowProtocol::
> > > +	Provide a colon-separated list of protocols which are allowed to be
> > > +	used with fetch/push/clone. This is useful to restrict recursive
> > > +	submodule initialization from an untrusted repository. Any protocol not
> > > +	mentioned will be disallowed (i.e., this is a whitelist, not a
> > > +	blacklist). If the variable is not set at all, all protocols are
> > > +	enabled. If the `GIT_ALLOW_PROTOCOL` enviornment variable is set, it is
> > > +	used as the protocol whitelist instead of this config option.
> > 
> > The "not set at all, all protocols are enabled" bit is not quite
> > correct, is it? It is true for a top-level fetch, but not for submodule
> > recursion (and especially since you are talking about submodule
> > recursion immediately before, it is rather confusing).
> 
> Heh, just saw that you copied this straight from the discussion of
> GIT_ALLOW_PROTOCOL. What idiot wrote the original? :)
> 
> It might be worth fixing both places (or possibly just fixing the
> original and phrasing this one as "If GIT_ALLOW_PROTOCOL is not set, use
> this as the default value; see git(1) for details").
> 
> -Peff

haha K I'll fix the original as well.

-- 
Brandon Williams
