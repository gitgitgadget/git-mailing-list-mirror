Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E80E61F404
	for <e@80x24.org>; Mon,  9 Apr 2018 23:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbeDIXf0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 19:35:26 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:42765 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751757AbeDIXfY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 19:35:24 -0400
Received: by mail-pl0-f53.google.com with SMTP id t20-v6so3316061ply.9
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zgIbX/dtIAH70l7s92e9+rLhZQbT0dMaIHBFX0MV1c4=;
        b=G4ElCj6fyEM/1O+YmA6e0XRnjMODhSHmG06aoYNc/WvWaPy3Nl8JKdkNA2I7WkyOr8
         DfO8ceh1rWb1dzWwTzNu3yjyL38MPQlAyM4rx7iwOqktw9N8DCqf55tLLs207n1Kv0RP
         FMCUXmEwaB8Ndz8E8sHFanUGtfUamiMx9f3+ePSQ3ayeH74PrSR7enMSxQonuCPt6Pb0
         ZylQhvC1iqqFbO6kPq62hSU2rKSQkM3GP3Jfccp1UpRQmH/RMMiQZrt6CoTPtplmFy/v
         ccZg1R+nezzM0ulSfBVg3pRDGtvHZBCySZuydEzUULEKKLhNDiloDpR5pen9lr1Bsuck
         AoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zgIbX/dtIAH70l7s92e9+rLhZQbT0dMaIHBFX0MV1c4=;
        b=pjoZxORqoYY5lQlX4KLt4Cb0gbP8bfpOJNeAUoT4tr+1sEvXaHfip27QEuImMSDkSt
         q1RW0Gr57HexuphSgek1cvZ44YBTv3mXWRixt1aRb6LHR6c6I4qoj4i9oZyx6yxPVJeO
         a3z/uYu/9cWFz2VdlPtL79KBnRMX4RiOYshUQn35WA+s31NvNne3suSuXIcSBCoK4kc8
         kzt9wDSyqEQ1KzH3fBIw7egSSUFlX2kpbxBzuw7FlbLlVlgi6jBxiIAC0J440vmJSlL1
         LFboZdZYzZWz+6FSyJu3sm+PEr/LGOKB2/0oP2KeAKMTovCMeI0bKS/S5ILmS+I1YZEp
         5amg==
X-Gm-Message-State: ALQs6tDJ57ifPmQENY0ELynfBXxcSqhVhMvAGoawyA9/HdY7OH5sEter
        p2fU4qgJtsFnMvJy1ncbNXR+/g==
X-Google-Smtp-Source: AIpwx49L2rH3A1l1Q7qJTF5JMoSYG5+mfmZ3ctVhd7PqgZcdKXq5g9cMkF7JxU5soOVhbkY+68qClQ==
X-Received: by 2002:a17:902:8e8a:: with SMTP id bg10-v6mr4201792plb.329.1523316923370;
        Mon, 09 Apr 2018 16:35:23 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id t15sm2112337pfh.76.2018.04.09.16.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 16:35:22 -0700 (PDT)
Date:   Mon, 9 Apr 2018 16:35:21 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 12/16] refs: store the main ref store inside the
 repository struct
Message-ID: <20180409233521.GC102627@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
 <20180409224533.17764-13-sbeller@google.com>
 <20180409232416.GA102627@google.com>
 <CAGZ79kYWb=AXCBRodnoYbf9s5HP9Tf-yUoMHjMKm4tTrXa4Bgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYWb=AXCBRodnoYbf9s5HP9Tf-yUoMHjMKm4tTrXa4Bgw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/09, Stefan Beller wrote:
> Hi Brandon,
> 
> On Mon, Apr 9, 2018 at 4:24 PM, Brandon Williams <bmwill@google.com> wrote:
> 
> >> -     main_ref_store = ref_store_init(get_git_dir(), REF_STORE_ALL_CAPS);
> >> -     return main_ref_store;
> >> +     r->main_ref_store = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
> >> +     return r->main_ref_store;
> >
> > I assume that since this takes in a git dir as a parameter
> > that the ref-store is in a good enough place to be embedded in a
> > repository struct (as in this would work with an arbitrary repo)?
> 
> That is my current understanding.
> 
> As the refs code can also take a path into a submodule and construct
> a submodule ref store for the caller, we'd want to resolve the tension
> between the ref store and the repository struct who is responsible for
> the submodule ref store eventually by removing the submodule
> functionality from the ref store and only relying on the ref stores created by
> the repository struct.

oh right, assuming it can already handle submodule ref-stores it should
work as-is then.

-- 
Brandon Williams
