Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50E8720193
	for <e@80x24.org>; Wed,  2 Nov 2016 22:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756184AbcKBWrj (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 18:47:39 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36697 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755897AbcKBWrj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 18:47:39 -0400
Received: by mail-pf0-f173.google.com with SMTP id 189so19228551pfz.3
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 15:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pq1ddquo+PeYvWsUHMqXxxJtbeMzDN7PHMtBeIlcU1o=;
        b=YlH8GgDobfLO6r7Yl2WrxclCOqi4FtZhdW41r9E78CD3Fmj0IysA7EJ7YsDFpGhNWz
         IL0Xpsm08ScCQG3IEEER/bC4bEX/v0MCG1MmXCNO71sNmqWapxNkkX3oi7iLWKZVh5A5
         /kbHyuzchWml6Xznty57b2Szcz34noEyqeXd5zbVdjn8lSiBydhJRUPkU+6ZWpVnl+HA
         NJKxLVce5j5lrQvqeb8NXShlip3kOVidN/tWndPcgHowzDBoDZnDjMehRHUSBVKrCtJt
         sjna08wt+ox/o255xPAfmB7fs9Rt35ik9Hf0sWrv/4si8R/gWKjqT4npLj5V7VFfljUV
         pUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pq1ddquo+PeYvWsUHMqXxxJtbeMzDN7PHMtBeIlcU1o=;
        b=fPBLlPXDdb4Bia6lrhowjneihVQFLUztmttcbrs/bUBpXJO+XIUU7bYNbkyIHN+flF
         gqKMdFwnnfTiIbDA9eXkT8Z1YgCZKV8RR456y5Gja/n1lG7LYwD5JXZb9cSI8SGz+JQ6
         0wfKmqf5a2JL/vkUluSc2BpHn95hGcrZfyK6drRGBqglWzjz9t0F7bFq1rXkho6oHLNW
         4vBOp6dwvDxvKpDtzSbrnXbBstp2zrlPWcxEc8MPNhDWgTJUhNVnhIhA7jgoRhorBAdS
         UUsujYkZyP1piAU5APeoObrcvU9vSiUMqvsmBA3a3tcz8Zp3V5MCaCarWXNoijy0WCYE
         vqdw==
X-Gm-Message-State: ABUngvc5DOZHmV1Ozn0VSe6HkQ8iERCgvz173YfamCuQySVJq4EIhvaYXwyGogcZ2dUIYjf3
X-Received: by 10.99.110.201 with SMTP id j192mr9159831pgc.133.1478126858236;
        Wed, 02 Nov 2016 15:47:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:8080:eeb8:e27c:9538])
        by smtp.gmail.com with ESMTPSA id j68sm7107558pfk.95.2016.11.02.15.47.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 15:47:37 -0700 (PDT)
Date:   Wed, 2 Nov 2016 15:47:36 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161102224736.GA183367@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <CAGZ79kbytopD1UgvU6R0X18Ge6JsJ46K2KQ-SFLh+hu5tprTmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbytopD1UgvU6R0X18Ge6JsJ46K2KQ-SFLh+hu5tprTmA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/02, Stefan Beller wrote:

> > This is useful to restrict recursive
> > +       submodule initialization from an untrusted repository.
> 
> ok. Though as a user submodules may not spring to mind immediately here.
> I think this is generally useful, too. e.g. an admin could put this in
> the system wide
> config to prevent certain protocols from being used.

Oh I pretty much copied the description from what exists for
`GIT_ALLOW_PROTOCOL` which included this bit about submodules.

> > Any protocol not
> > +       mentioned will be disallowed
> 
> For the regular fetch/clone/pull case. For the submodule case we still
> fall back to
> the hardcoded list of known good things?

Yep! This is done by explicitly setting GIT_ALLOW_PROTOCOL to the
hardcoded list if the user hasn't supplied a whitelist.

> 
> > (i.e., this is a whitelist, not a
> > +       blacklist).
> 
> That is very explicit, I'd drop it. However this inspires bike
> shedding on the name:
> What about core.protocolWhitelist instead?

Simply to keep the name similar to the env variable that already exists
for this functionality.

> So the env var is of higher priority than this config.


> > -: ${GIT_ALLOW_PROTOCOL=file:git:http:https:ssh}
> > +config_whitelist=$(git config core.allowProtocol)
> 
> So first we lookup the configured protocols.
> 
> > +: ${GIT_ALLOW_PROTOCOL=${config_whitelist:-file:git:http:https:ssh}}
> 
> Then if they are not configured use the current hard coded white list.

The lookup of the configured whitelist is done first but wont be used
unless GIT_ALLOW_PROTOCOL is unset.  If neither is set it will fallback
to the hardcoded list.

> Do we have any tests for this that could be extended? (Otherwise we'd
> maybe want to add a test for both the regular case as well as a forbidden
> submodule?)
> 

I can write a couple tests for a v2 of the patch.

-- 
Brandon Williams
