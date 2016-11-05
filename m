Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70EDC2022D
	for <e@80x24.org>; Sat,  5 Nov 2016 00:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbcKEASN (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 20:18:13 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35834 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbcKEASM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 20:18:12 -0400
Received: by mail-pf0-f181.google.com with SMTP id i88so59331255pfk.2
        for <git@vger.kernel.org>; Fri, 04 Nov 2016 17:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=az6+MNTuvnO5HfyPAFZqRv9S657f4ab2aGYnIfGSJnM=;
        b=Ncz2ruvMcP6OJBp1j1KDwMcBa6kpelmrK6DhJwUigAN33sXSooGEDdC/HFD23oHuJY
         uskDhgiLCSnmj1YiPK0q3PzfVGCyN7jwyewc8nF4uhTKU5c8+SAkmHqA/gERVjox+bKG
         esnqDYlrBPEZEfsRT65v98GZiyAXSNPYUki5WENAZmX81+xn9UTFu4dRl7AYGStLaHst
         2BAjzIVutlBmovc2vyOMHMrIhrNYxYG761UJOdCY6ucIfQkUiaTVBYogFNu376Pl7O22
         IQAdLTNX6pFs5t0tyEdcxhKvWhv2C2LjO82RXNFxJCYQJSg/5mY4GS3p3IDVAgh1S451
         uoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=az6+MNTuvnO5HfyPAFZqRv9S657f4ab2aGYnIfGSJnM=;
        b=RouV7oFTRpe99QeEk59SAn8Wy2M7XtqOnZbYW/+m1svJquF64E8B2B23Kq/qLHfwsq
         2qY2HqmTttCIZweupbb2WQF+7I1Jzvvu1fDf6hQLgt5sARzSHOIw38vySLnuqOEH11wY
         gPODH21srbhXFsEft9INNf/uQN9Td5OWJ0LHgL5Kl/SZhYazYTvTdjHpSH+WbG/yc/qg
         iNXwonSX114JKmCRxqNWda3yjVoXVHqZ/RUq7nN3MMOQSm8/6tQ9mL3PulAu1CfqXE/M
         hxH4quO33smYQ6zGEhFje2JWnMFaoimuWg9hqYA5IsRMsoUZ8NdPdYnrSNpXjna0MuTV
         HjfQ==
X-Gm-Message-State: ABUngvfL50cpzZlc6zQF6Zs3T8KHCLD+XQ5KdoCzOTwwc/8oaM9IWLJEeBtcEG8Q7fkBSO7L
X-Received: by 10.99.196.70 with SMTP id m6mr25923978pgg.118.1478305091542;
        Fri, 04 Nov 2016 17:18:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:28d2:ac2e:cc40:c119])
        by smtp.gmail.com with ESMTPSA id p62sm22853693pfb.42.2016.11.04.17.18.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Nov 2016 17:18:10 -0700 (PDT)
Date:   Fri, 4 Nov 2016 17:18:09 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Blake Burkhart <bburky@bburky.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] transport: add protocol policy config option
Message-ID: <20161105001809.GB127933@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <1478292933-7873-1-git-send-email-bmwill@google.com>
 <20161104205815.GA127933@google.com>
 <CAGZ79kZB9wMgPDktMUpBfcvgJy16N8P74SvLP5740UNftZkbVg@mail.gmail.com>
 <20161104230902.ulkyejwamm6q575a@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161104230902.ulkyejwamm6q575a@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/04, Jeff King wrote:
> On Fri, Nov 04, 2016 at 02:35:57PM -0700, Stefan Beller wrote:
> 
> > On Fri, Nov 4, 2016 at 1:58 PM, Brandon Williams <bmwill@google.com> wrote:
> > > On 11/04, Brandon Williams wrote:
> > >> Signed-off-by: Brandon Williams <bmwill@google.com>
> > >
> > > Is there an acceptable way to give credit to Jeff for helping with this patch?
> > 
> > What about:
> > Helped-by: Jeff King <peff@peff.net>
> 
> That, or often I would write:
> 
>   Based on a patch by Jeff King <peff@peff.net>
> 
> in the commit message. Basically anything is OK _except_ forging
> signed-off-by, because it has a very specific meaning. So let me also
> say that I am happy to give my:
> 
>   Signed-off-by: Jeff King <peff@peff.net>
> 
> to the original (which you should add in, to make clear that the
> copyright issues are OK).
> 
> In some cases it makes sense to just roll somebody's patch into your
> series, and then build on top. I'm fine with it all going into a single
> patch here.
> 
> -Peff

Oh if it would be more clear I can easily break it up into two patches.

-- 
Brandon Williams
