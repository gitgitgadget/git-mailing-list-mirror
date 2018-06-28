Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E29241F516
	for <e@80x24.org>; Thu, 28 Jun 2018 16:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965156AbeF1QQy (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 12:16:54 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41081 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964893AbeF1QQx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 12:16:53 -0400
Received: by mail-pf0-f194.google.com with SMTP id a11-v6so2826467pff.8
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 09:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=batRKlP47UOgc73lBoX5d5+OksNO5e/ffv5o4+1T/wM=;
        b=NCqY/mKowl9ecCIC2ZsltMYgJt9bzsvzrwz+zfizvxdd1fW/bTCfr/0iQK5uNuHrZZ
         uJvtW6CG9CJI05s6JSVM4DchNlakDu53giS3wEhf828uIhyN6sdodq1EpbdX9LKEPzUO
         fqwLapm4BWJUZzzCbMhAgnkR7lsJBmwbrdbIxY+IvwptnoMAaZb1FnW6K9Flsi5n2TfX
         Ni5zr1+CNn6iHqIfyaQBaVgiNOV1CI75rftBAEDXfC/HEYngsHECe6H9UD07MnmPe7OM
         u5d+e+uTislsOEiE2nT83SX4g+/CY1mev4WBxUyKuGLA23yTl6huUhIFQEvVDmVStbU3
         1MFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=batRKlP47UOgc73lBoX5d5+OksNO5e/ffv5o4+1T/wM=;
        b=L5Mk6rxwqcRN+dLJ+jGhpT0cQZTO0HnpqqLpIcNQZCXbPirsYADA6WkCs8NweSSXNX
         diszBafeEqNbVdWFs0uQJyPq7815R9DPk0R2fb+wM/wa+qqSnv7QZEsEBtAaV3g07eHU
         luLanHFrsyP1XpvyUcUFlXgE2e/+FuyA3sMBPH3db0RIdCUklPNsMFtxI02X6NCYUWQu
         QyHi1uj12tkpEyEqd34y/2nGVKYqMJh7owlFrHSggQWDpniaqxLT9XDut/M9KHXDJmEl
         L3OzZgRKahGqg10F6H6sITj0GRFbzmMVuD3amt3isrWJ1cKSp6ZHa8GY7mPZlSZtOYIh
         6Z2w==
X-Gm-Message-State: APt69E3DH4wYLW4a//LNTafyOo0pjPZ4ZxwwMxZgjoU8b8NGGuPSLhSX
        1W7QmRsM7bdyjoQmrusnVgNexg==
X-Google-Smtp-Source: ADUXVKLCRmBTxM9CgnsDufxV/zKkdYgJPqUT3k31d0JIIOEKO388Ea0nGvok9/H0pshi9MQvZPwatA==
X-Received: by 2002:a65:5106:: with SMTP id f6-v6mr9292869pgq.72.1530202612245;
        Thu, 28 Jun 2018 09:16:52 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 76-v6sm13502572pfh.26.2018.06.28.09.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 09:16:50 -0700 (PDT)
Date:   Thu, 28 Jun 2018 09:16:49 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2] fetch-pack: support negotiation tip whitelist
Message-ID: <20180628161649.GM19910@google.com>
References: <20180628155630.GL19910@google.com>
 <20180628161216.68872-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628161216.68872-1-jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/28, Jonathan Tan wrote:
> > This seems like a pretty difficult to use feature, requiring that I
> > provide the actual OIDs.  I think a much better UI would probably be to
> > accept a number of different things ranging from exact OIDs to actual
> > ref names or even better, allowing for ref-patterns which include globs.
> > That way I can do the following:
> >   
> >   git fetch --negotiation-tip=refs/remotes/my-remote/* my-remote
> > 
> > in order to easily limit the tips to all the refs I have from that
> > particular remote.
> 
> Actual ref names are already supported - it uses the same DWIM as
> others. As for globs, I thought of supporting both DWIM objects and the
> LHS of refspecs, but (1) it might be strange to support master and
> refs/heads/* but not heads/*,

I don't think that would be strange at all, and no where in git do we
handle heads/* but we do already handle refs/heads/* as well as DWIM
master.


> and (2) I can't think of anywhere in Git
> where you can provide either one - it's either SHA-1 and DWIM name, or
> SHA-1 and refspec, but not all three.

fetch is a perfect example of supporting all three.  I can do

  git fetch origin SHA1
  git fetch origin master
  git fetch origin refs/heads/*:refs/heads/*

-- 
Brandon Williams
