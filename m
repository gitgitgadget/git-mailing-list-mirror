Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 648DF1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933614AbeBVSHU (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:07:20 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41062 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933441AbeBVSHS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:07:18 -0500
Received: by mail-pl0-f65.google.com with SMTP id k8so3310174pli.8
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 10:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/FfpgAMe4VPXVIXBYBN580oxyNxqFwddSYUJ1LwL+Dg=;
        b=hj1XUqLGuln5HF2LKAkqEq8rBwW/GbcsKuLq3MaH0TvrVH50V91PQRxYw9L+W3P3F9
         JTAz7IUcGP1nFXwGhb76edexqSsj58oKCLTXzo5B3VQ3ocvb8077VHHaOrx4+eOHnYiW
         Ce/Dj3cMrhmE2lac/NqdZJfGReIKOAbeaWEafMAA+5WHjFqzLVWh/vUpSsoowLpL5WL8
         TLhVAmQ5VYLYCSmq1wbJLrxfmEVizOCWc19yRCC7oHnpV4yqG7YgitCWcwS65btSHa8+
         PSxUdFg1hBCB5dfK9evIuIDbTQW2tJ9BB+PgNiYenO5CPXvnzDLarVc0LQ6yGyUcCtac
         vuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/FfpgAMe4VPXVIXBYBN580oxyNxqFwddSYUJ1LwL+Dg=;
        b=LNCRG/fmC5Vi+VcgvD0LLbtxomx5NzNRQltfRCed3yCZOrW8mnh9kwX7MXB9I9wy+3
         PoNUY5Q/B9aPDAY60XP8eyRTZCuPxSoQLc/4u5Q1OwykSTLLcFw6swu30AMwf23SPtZG
         iLfDKTbtcRUy45sLOrcZTefikkPpUgiRKEg8Pe5zlIfZ0UsnTuFy56QY/fcuOuT0oQz3
         s3AjvffYKWAB720Jgf4a7DaRfRirT4epiXnMsXPbPqxtK8YzPk82kHhBAJL9Xxd5BbYK
         Pi1w6Io5zqaKHNIR84OI6kXqu2+8c70tN/dK5qABlsBrQ/uSe/g2QBj8vi9qJzL4uL5x
         hZOQ==
X-Gm-Message-State: APf1xPCjgDW73UfP3jKaPnl0gJPAeqNQZdi7k0syW+3ZkwLrTWDo+3iN
        Up3mcEev5E5bEMg+wnxX3iug57n27gE=
X-Google-Smtp-Source: AH8x227YQRJZQ2WXzJSfoH7MpWuXogfBI5XHFdgAa2jmVDFm9EXug0MVHJ/+PW5HlXk9TOuzVev4ow==
X-Received: by 2002:a17:902:8489:: with SMTP id c9-v6mr47123plo.439.1519322838006;
        Thu, 22 Feb 2018 10:07:18 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id t8sm940944pgr.21.2018.02.22.10.07.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 10:07:17 -0800 (PST)
Date:   Thu, 22 Feb 2018 10:07:15 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        stolee@gmail.com, git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 04/35] upload-pack: convert to a builtin
Message-ID: <20180222180715.GB185096@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-5-bmwill@google.com>
 <20180221134422.2386e1aca39fe673235590e7@google.com>
 <20180222095833.GC12442@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222095833.GC12442@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22, Jeff King wrote:
> On Wed, Feb 21, 2018 at 01:44:22PM -0800, Jonathan Tan wrote:
> 
> > On Tue,  6 Feb 2018 17:12:41 -0800
> > Brandon Williams <bmwill@google.com> wrote:
> > 
> > > In order to allow for code sharing with the server-side of fetch in
> > > protocol-v2 convert upload-pack to be a builtin.
> > > 
> > > Signed-off-by: Brandon Williams <bmwill@google.com>
> > 
> > As Stefan mentioned in [1], also mention in the commit message that this
> > means that the "git-upload-pack" invocation gains additional
> > capabilities (for example, invoking a pager for --help).
> 
> And possibly respecting pager.upload-pack, which would violate our rule
> that it is safe to run upload-pack in untrusted repositories.

And this isn't an issue with receive-pack because this same guarantee
doesn't exist?

> 
> (This actually doesn't work right now because pager.* is broken for
> builtins that don't specify RUN_SETUP; but I think with the fixes last
> year to the config code, we can now drop that restriction).
> 
> Obviously we can work around this with an extra RUN_NO_PAGER_CONFIG
> flag. But I think it points to a general danger in making upload-pack a
> builtin. I'm not sure what other features it would want to avoid (or
> what might grow in the future).
> 
> > Having said that, the main purpose of this patch seems to be to libify
> > upload-pack, and the move to builtin is just a way of putting the
> > program somewhere - we could have easily renamed upload-pack.c and
> > created a new upload-pack.c containing the main(), preserving the
> > non-builtin-ness of upload-pack, while still gaining the benefits of
> > libifying upload-pack.
> 
> Yeah, this seems like a better route to me.
> 
> -Peff

-- 
Brandon Williams
