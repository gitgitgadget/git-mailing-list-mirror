Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48AF81F424
	for <e@80x24.org>; Tue, 24 Apr 2018 18:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbeDXSmh (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 14:42:37 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35316 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeDXSmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 14:42:36 -0400
Received: by mail-pf0-f180.google.com with SMTP id j5so13001445pfh.2
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 11:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=27g0P0bF3OYj9XRFg5Knt2iyM0pTlfjtu2XE1ZoBbNk=;
        b=Ilo3phAMy55iBPD+Bs42u43WgRA1u5AxtmKGf3Wad7Cqp/XS0IJdpODooNZSrYaqpN
         Iun2yQjSLTv2IENqhUlpSXfLMxjSTWyPTbgqLDyEVxY6GrASpeaR1OR6Dex+0NQzqoPd
         M+FS/ZVUUeHx+alHM1gMVlgXCz7cfx1EfS/ADD+xq395GSpL7S8JjjQJjGz6AufKvkJf
         jsHuX0f4UbEcxHEUVgAaOgangFplXR100l3Td09ctjE2WVpApTQW7z7G8Vhc6kvLUXhv
         nsWHxV3fN82RYMtSg3XghGdRWcgFTRs4sG48zBWez+2oK//FOAogqW7i4pcpcUBpxwn1
         tN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=27g0P0bF3OYj9XRFg5Knt2iyM0pTlfjtu2XE1ZoBbNk=;
        b=XZUQQ5M42yJ2VVF3NPDjkNkMj613M/FK0Mj/ZlvLubhf/SeXxb5Zbo9Ci7oeLrcQyk
         bFBAgV9tXweBZHd3D7JO045xQhq5fIeW78IeugVLX3SbHNE+PZlR1005b3Dh6/MxZeE+
         1BlmxFPGocpOqXEn+mD0DhGmw9htf25yAoX6NnoXLIBzmgd4WrwJLi9g4k1rCeDP9xJY
         fE+jevKqt03CYBVAHmuNqWjftrRMWOGIFjo+Nsth/yIcJ/lDYWz6u38TVLuPT6YXWnYJ
         3n+ibSWvEc0J2h7bXehIMYVtQhnPE3N6dzRlp6HSuxmbx9UNdP9rLN8HogTLvEjE+92x
         uwwg==
X-Gm-Message-State: ALQs6tB4xq4RAL+D/646UmXjTrWZzzczkjm8Xo7tuMPnEb0PFiFK4hCG
        lw4QUQsI1s/VB1/N/LdnsAhuEA==
X-Google-Smtp-Source: AIpwx49HAWUdKwJc4/warYZgDd0do7ZUw+BuRw+MKWKt5HWyhoZqlEo/3uu2CtM22UMoIr7jWbfCfA==
X-Received: by 2002:a17:902:5602:: with SMTP id h2-v6mr23239803pli.115.1524595355692;
        Tue, 24 Apr 2018 11:42:35 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id t12sm22656387pgp.3.2018.04.24.11.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 11:42:34 -0700 (PDT)
Date:   Tue, 24 Apr 2018 11:42:33 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 9/9] cache.h: allow sha1_object_info to handle arbitrary
 repositories
Message-ID: <20180424184233.GA90854@google.com>
References: <20180423234327.250484-1-sbeller@google.com>
 <20180423234327.250484-10-sbeller@google.com>
 <20180424112332.38c0d04d96689f030e96825a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424112332.38c0d04d96689f030e96825a@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/24, Jonathan Tan wrote:
> On Mon, 23 Apr 2018 16:43:27 -0700
> Stefan Beller <sbeller@google.com> wrote:
> 
> > This involves also adapting sha1_object_info_extended and a some
> > internal functions that are used to implement these. It all has to
> > happen in one patch, because of a single recursive chain of calls visits
> > all these functions.
> 
> In packfile.c, unpack_entry() invokes get_delta_base_cache_entry(),
> which references a global (delta_base_cache). Does delta_base_cache need
> to be moved to the repo object (or object store object) first, or is
> this safe?

After looking at this, I think it should be safe for now since its a
cache that requires a packed_git pointer to access (and those would be
per repository).  We may want to move it in to the repository at some
point though.

> 
> Also, in sha1_file.c, oid_object_info_extended() invokes fetch_object(),
> which attempts to fetch a missing object. For this, I think that it's
> best to guard with a "r == the_repository" check, or if there's a better
> way to distinguish between the "default" repository and any repository
> that we newly create (I vaguely remember some distinction when parsing
> environment variables when determining repo paths - the envvars were
> only used for the "default" repository, but not for the others).

This is a little more difficult and I'm not sure I know what the best
course of action would be for this.  Mostly because then this puts a big
recursive dependency on the whole fetch mechanism to handle arbitrary
repositories at the same time these functions are converted.  So maybe
throwing in the runtime check would be the best way to break the
dependencies for now.

-- 
Brandon Williams
