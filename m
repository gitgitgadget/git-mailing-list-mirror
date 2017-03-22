Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEF2520323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbdCVVdo (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:33:44 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33165 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753407AbdCVVdh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:33:37 -0400
Received: by mail-wr0-f193.google.com with SMTP id 20so609452wrx.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 14:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ihr64TEqhS9kkwTB4iCgVJy/3dxqe+U0KJ95p08bBbo=;
        b=qfrFBVq02RuHXo3QT0fxze69fD88CcJwPm94DoJXyI4u5efRAfPJD18lbhCkfs0IXE
         z3Bpse2XETkluMSFTJU2RbjEKsHqwGaji4+aqJeGgDuxrLEhpm3ajaJQwKqkDQXP9i6x
         CYWu4VqTibfm/i4XEvC1wRNofZEON/EnXbzy9fnfy5LW++3qCA6FHpLnPLcJqmfBHCO5
         airzbXHADVk6v03Ib9sPJ2AMRqR+RwNy5IW4YJHWHTf9QdTxefhuSKc1emMfCjGtX4/e
         cG/XlkjyfaxSTKJXXSnlY7KNBO2B4HkGnzNjRMmct3RP9ZhERSLhhLPH46p+eEz9G2mX
         +/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ihr64TEqhS9kkwTB4iCgVJy/3dxqe+U0KJ95p08bBbo=;
        b=MIs8sewuwKSku7aRt3inStdxqJMT12xvYN+JHpfuFQq8AXpApDC01WV4Rd65K5lrHD
         eOOGdeYRJKv/NoMkbbL8RJr1m747z+8e7yZDUspS4g8Vl9W507eiGcsbAJZ4S8g1zxK6
         z8loBdxqCXEy8geyM480x51Dwr+4O/tB24tVCoSgaXR9YX/K16G9V2DrWwlBijB1a1KE
         41vukOWBaFymCzeNXoPK6t0O2dNtVOaD0cyzd+YIz4z2r8dvThgejxedhDTgdYRZ4uXX
         tAx0Mfi4/HdhKuulI/fwRUvYFRAm6G1vnAnmlx3gVkisbFJrSvQLRv0cG0tVvLu676HV
         0xog==
X-Gm-Message-State: AFeK/H1fhc4jcVdheH284degk2ve4sGEvK4TH8Fuyg8zMDSBim7/uv58iAafylPAvo8Ydg==
X-Received: by 10.223.135.109 with SMTP id 42mr41650766wrz.141.1490218409521;
        Wed, 22 Mar 2017 14:33:29 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id z88sm3292921wrb.26.2017.03.22.14.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Mar 2017 14:33:28 -0700 (PDT)
Date:   Wed, 22 Mar 2017 21:33:47 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] stash: don't show internal implementation details
Message-ID: <20170322213347.GF27158@hank>
References: <20170319202351.8825-1-t.gummerer@gmail.com>
 <20170321221219.28041-1-t.gummerer@gmail.com>
 <20170321221219.28041-2-t.gummerer@gmail.com>
 <20170321221445.3jpaoce7qbshtdoq@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170321221445.3jpaoce7qbshtdoq@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/21, Jeff King wrote:
> On Tue, Mar 21, 2017 at 10:12:17PM +0000, Thomas Gummerer wrote:
> 
> > git stash push uses other git commands internally.  Currently it only
> > passes the -q flag to those if the -q flag is passed to git stash.  when
> > using 'git stash push -p -q --no-keep-index', it doesn't even pass the
> > flag on to the internal reset at all.
> > 
> > It really is enough for the user to know that the stash is created,
> > without bothering them with the internal details of what's happening.
> > Always pass the -q flag to the internal git clean and git reset
> > commands, to avoid unnecessary and potentially confusing output.
> > 
> > Reported-by: Jeff King <peff@peff.net>
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> 
> I think combining these is fine. The incorrect output with pathspecs
> isn't mentioned anymore, but I think that's OK.

Yeah, they felt so similar now that splitting this up in different
patches would be a bit too noisy.

> [...]
> 
> > diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> > index 89877e4b52..ea8e5c7818 100755
> > --- a/t/t3903-stash.sh
> > +++ b/t/t3903-stash.sh
> > @@ -663,7 +663,7 @@ test_expect_success 'stash apply shows status same as git status (relative to cu
> >  		sane_unset GIT_MERGE_VERBOSITY &&
> >  		git stash apply
> >  	) |
> > -	sed -e 1,2d >actual && # drop "Saved..." and "HEAD is now..."
> > +	sed -e 1,1d >actual && # drop "Saved..."
> >  	test_i18ncmp expect actual
> >  '
> 
> This too, though I think "1d" would be the more usual way to say it.

Right thanks, I'll keep that in mind for another time. (I guess just
changing this doesn't warrant a re-roll?)

> -peff
