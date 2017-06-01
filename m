Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F358420D12
	for <e@80x24.org>; Thu,  1 Jun 2017 00:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751033AbdFAAPY (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 20:15:24 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33466 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbdFAAPX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 20:15:23 -0400
Received: by mail-pf0-f180.google.com with SMTP id e193so21349559pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 17:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nG2ncnj8IuoJlujC6BhGFZ3fh6k+IawKW5UC59ojmEo=;
        b=CEx11vMFDj2s4SM+uF5j9RfmYAYGgBEE/XeW/tmmNDg9k1T3wXk+778JWKhxhoZwts
         2vrg/oqq5rzHdPzzWGtl+q4G4P1+HeM5Qi6j9wgv0qO6x3nA3b7+NZNzqGAYIloSxCtL
         M/CzpPgo1cA3XWeGM+27OBO0I4C9vbr0NclWC/4asZvhfzkTnEJPfN1WkYC+zN+e6RI9
         Y+iIKK1YOA5CnBotZxGubTG4+L3SVY/fbo808rSxTpiK20aBNFV+2S+J+PbooDeXbH+T
         EYVr9eZ9XKy/vub07LN44eFZXLZ180mrzGSiHxSu2Bd6c/Om5WdODic5UvEb6o5EodN1
         PndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nG2ncnj8IuoJlujC6BhGFZ3fh6k+IawKW5UC59ojmEo=;
        b=S8H5KbfVO/ZbVJdZq2HJYAzedMH8sxJwp0CTGAmCn9Qeu1P2xzIXlEv+QVD3UK0lS3
         Q2Pqy2TxD9H2sAjBpSGo5bd5vhRBdU8197pGP/S/REKv66n52HbE/PF5a+li2vJSZrUE
         Cg8qlZitIaqRz+uqQ65iStY6mUbRUX5KVlrzLJ+cgPNJTeXSCz4hxm79GjYTqjwAK0jN
         bHwd7W5O9vQ0PK4ifbU3cFCV3KIYcnxLdHCtpwxcySsZMmWYBzBu24n1///nwowv3vVA
         qrzGFGH6mOHQLZDXS8my0iRS8orPDyBYB7OMmUAOPqsshQg51GgYELl88kIDzBam+R26
         SGoQ==
X-Gm-Message-State: AODbwcDamKQ6MJgZecFDqspN/uYvYspojxoWsUcJdCMN2poZ1NSCa5Dp
        ypDeZUv+GuDoMlYQ
X-Received: by 10.84.236.72 with SMTP id h8mr93305685pln.187.1496276122910;
        Wed, 31 May 2017 17:15:22 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:dcdb:b4e5:f1c4:8595])
        by smtp.gmail.com with ESMTPSA id l65sm31526046pge.29.2017.05.31.17.15.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 17:15:21 -0700 (PDT)
Date:   Wed, 31 May 2017 17:15:20 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Elliott Cable <me@ell.io>,
        Dennis Kaarsemaker <dennis.kaarsemaker@booking.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] docs/config: mention protocol implications of
 url.insteadOf
Message-ID: <20170601001520.GB43421@google.com>
References: <CAPZ477MCsBsfbqKzp69MT_brwz-0aes6twJofQrhizUBV7ZoeA@mail.gmail.com>
 <1495230186.19473.7.camel@kaarsemaker.net>
 <1495230934.19473.10.camel@booking.com>
 <20170520070757.jekykxagzze3t2wy@sigill.intra.peff.net>
 <CAPZ477PoSXqahxaQVpO+m==vng==o4vQahrg_WA8Oeh7wmoW0w@mail.gmail.com>
 <20170531051804.w6f7yvz4k5wkrwvc@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170531051804.w6f7yvz4k5wkrwvc@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/31, Jeff King wrote:
> On Fri, May 26, 2017 at 11:22:37AM -0500, Elliott Cable wrote:
> 
> > 1. Most simply, better documentation: mention `GIT_PROTOCOL_FROM_USER`
> >    explicitly in the documentation of/near `insteadOf`, most
> >    particularly in the README for `contrib/persistent-https`.
> 
> I agree that a hint in both places would be helpful.  The patch for that
> is below.
> 
> > 2. Possibly, special-case “higher-security” porcelain (like
> >    `git-submodule`, as described in 33cfccbbf3) to ignore `insteadOf`
> >    rewrite-rules without additional, special configuration. This way,
> >    `git-submodule` works for ignorant users (like me) out of the box,
> >    just as it previously did, and there's no possible security
> >    compramise.
> 
> I don't think we can do that. Rewrites of "git://" to "ssh://" are
> pretty common (and completely harmless). Besides, I think submodules are
> a case where you really would want persistent-https to kick in. IIRC,
> the original use case for that helper is Android development, where a
> user is likely to update a ton of repositories from the same server all
> at once. Right now the fetches are all done individually with the "repo"
> tool, but in theory the whole thing could be set up as submodules.

This right here is why Stefan and I have been working on submodules.

> 
> -- >8 --
> Subject: [PATCH] docs/config: mention protocol implications of url.insteadOf
> 
> If a URL rewrite switches the protocol to something
> nonstandard (like "persistent-https" for "https"), the user
> may be bitten by the fact that the default protocol
> restrictions are different between the two. Let's drop a
> note in insteadOf that points the user in the right
> direction.
> 
> It would be nice if we could make this work out of the box,
> but we can't without knowing the security implications of
> the user's rewrite. Only the documentation for a particular
> remote helper can advise one way or the other. Since we do
> include the persistent-https helper in contrib/ (and since
> it was the helper in the real-world case that inspired that
> patch), let's also drop a note there.

Documentation changes look sane to me.  Thanks for whipping this up!

> 
> Suggested-by: Elliott Cable <me@ell.io>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/config.txt        |  7 +++++++
>  contrib/persistent-https/README | 10 ++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 43d830ee3..5218ecd37 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -3235,6 +3235,13 @@ url.<base>.insteadOf::
>  	the best alternative for the particular user, even for a
>  	never-before-seen repository on the site.  When more than one
>  	insteadOf strings match a given URL, the longest match is used.
> ++
> +Note that any protocol restrictions will be applied to the rewritten
> +URL. If the rewrite changes the URL to use a custom protocol or remote
> +helper, you may need to adjust the `protocol.*.allow` config to permit
> +the request.  In particular, protocols you expect to use for submodules
> +must be set to `always` rather than the default of `user`. See the
> +description of `protocol.allow` above.
>  
>  url.<base>.pushInsteadOf::
>  	Any URL that starts with this value will not be pushed to;
> diff --git a/contrib/persistent-https/README b/contrib/persistent-https/README
> index f784dd2e6..7c4cd8d25 100644
> --- a/contrib/persistent-https/README
> +++ b/contrib/persistent-https/README
> @@ -35,6 +35,16 @@ to use persistent-https:
>  [url "persistent-http"]
>  	insteadof = http
>  
> +You may also want to allow the use of the persistent-https helper for
> +submodule URLs (since any https URLs pointing to submodules will be
> +rewritten, and Git's out-of-the-box defaults forbid submodules from
> +using unknown remote helpers):
> +
> +[protocol "persistent-https"]
> +	allow = always
> +[protocol "persistent-http"]
> +	allow = always
> +
>  
>  #####################################################################
>  # BUILDING FROM SOURCE
> -- 
> 2.13.0.678.ga17378094
> 

-- 
Brandon Williams
