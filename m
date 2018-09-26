Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DC1F1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 00:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeIZHGh (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 03:06:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34949 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeIZHGh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 03:06:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id v133-v6so5278653pgb.2
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 17:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t3kmIagyNzueFxEtYjRNT0CiF5hvNSrUwpLJ7Mq9Hjo=;
        b=y0z/2/6511qUW0vBQ0NgBgsxDKjveW/QTL7uDV3c+l5ctGCSIL1Sl1t5hRGD/xfBj8
         5yzXnenJ+g1xqOK/1/qDP9q7lchT8WRIuzct8jvfcD85gWixHzLFEP6RA5jgar5pTT3Q
         xjT/eaLBEqPZNrPwlNx1LIrr8EEZmhT6dDFSmuRLvSe55MXobCnkX16xtLNG22U6Ivx5
         meIOX5pEaQJ+9/VcdwnRN4dQCZR4o3bYy4I1i7IUkLKiaEWYzQVRwV8iwGwOIUfO9Jse
         FL8cLMwzWN5vMiOXzXFaamBja8IZKvyiINCm90p936wTlXToGslq50YKjC10dD+qwidR
         dSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t3kmIagyNzueFxEtYjRNT0CiF5hvNSrUwpLJ7Mq9Hjo=;
        b=lopYy/H99PAnVD4JEsZVKxVVXmSO5ZMURBIIJKqaEG1hNGGM+NzJatjKY15Ws3Gtyf
         3WDpOl9Rr4BFb2oT10vBCszVsDkFoHJdHv4X+bbaK5N2ggb5JiDk7NCh1euax+caMvMC
         kcGrwpIr+1XMgmyhfFL39oT/vZBw4cdhcKMZY2MA9d8O3JvvKFMkdH3y6CGlDPJq2b2h
         eJU385Q4+u72OB+2lLCItYaYjLXvkn2WDNGQGtez4eufmQj4LaF2GGXFW+SkvkAjRXcT
         kTHcWlvZCvp6p2R9PP3/3Hfew6osV5bBsaP5repgKisiwErcc/E17aIsReL3abuoCI2w
         EwDg==
X-Gm-Message-State: ABuFfoh+s8oY47YKE4tARPBa8eN53I4F/67AJOGxP0m+P8faAnn+lzbi
        WLh3LvgVvyQ2erV2UHN5/L6l4Qg45SD3Xw==
X-Google-Smtp-Source: ACcGV61AuUspn9BS6byqJBM2IUB1l18hHAeFCxPeyoAuRRyIS9UEcJ/42pqTKaPblOfR01o+kQO9Dg==
X-Received: by 2002:a63:e918:: with SMTP id i24-v6mr3386502pgh.64.1537923384478;
        Tue, 25 Sep 2018 17:56:24 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d190:33d6:11d2:d23b])
        by smtp.gmail.com with ESMTPSA id f15-v6sm4105078pgv.66.2018.09.25.17.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 17:56:23 -0700 (PDT)
Date:   Tue, 25 Sep 2018 17:56:20 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180926005620.GH4364@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <4c4900722cab253b3ce33cb28910c4602ce44536.1537466087.git.me@ttaylorr.com>
 <xmqqlg7ux0st.fsf@gitster-ct.c.googlers.com>
 <20180921174825.GA17718@syl>
 <20180921175739.GA21514@syl>
 <xmqqr2hmvcyz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr2hmvcyz.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 12:59:16PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > In fact, I think that we can go even further: since we don't need to
> > catch the beginning '^.*' (without -o), we can instead:
> >
> >   extract_haves () {
> >     depacketize - | grep '\.have' | sed -e 's/\\0.*$//g'
> >   }
>
> Do not pipe grep into sed, unless you have an overly elaborate set
> of patterns to filter with, e.g. something along the lines of...
>
> 	sed -ne '/\.have/s/...//p'

Thanks, I'm not sure why I thought that this was a good idea to send
(even after discussing it to myself twice publicly on the list
beforehand).

Anyway, in my local copy, I adopted Peff's suggestion below in the
thread, which is:

  extract_haves () {
    depacketize - | perl -lne '/^(\S+) \.have/ and print $1'
  }

I think that that should be OK, but I sent it here to double check
before sending you real patches.

Thanks,
Taylor
