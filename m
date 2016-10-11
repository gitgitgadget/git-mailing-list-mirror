Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 308AA1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 18:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754006AbcJKSt4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 14:49:56 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36086 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753033AbcJKSty (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 14:49:54 -0400
Received: by mail-pa0-f46.google.com with SMTP id ry6so19205849pac.3
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 11:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TnxE1yG6I9f33ygYfmGHgqpb5STcQjwc29h8ZqNSjZE=;
        b=Yu1g5Nzrouf2YqoUsvYF4gewlIdogK9aUfTPmKDSWPI0dRbi66V38tSKXI785CUPt+
         EqfCFwNDSxR4ein4G1fQGuWvQJDIwUY4Q9zUW4bya4UjeMKwQ7y3nHTX+4Oj4zCjTXj7
         OupR00q52QROyU5PmMc8c59oFtzJhoH3CBduPMdtk5CFkgcQ5Q882nvPrPdASliHn1LU
         MrqY02LCfL9d6LXfMcogDDl3PkndB62fakUXnxDf/BCpS3c+EKwNZ6LplUvuqfOrXdSc
         rGaQsch5m0mcJehT4TlU98vpHV+qygHUYythZ3OlHwjGCTGtYKbE1w0lql6lzFvFJipT
         takA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TnxE1yG6I9f33ygYfmGHgqpb5STcQjwc29h8ZqNSjZE=;
        b=Zkhf5TKPsr6mNbcbs6t9yJo+B/bLvyZUo1/oXWdTJSuDDB38LHAMtOmrnCtGrSJ+q2
         xJajf8quDyE+qmocJaZrB9PonFIOlr04h2Tr47lEZTYNw8CMT5nSxL3r9Cpqd4ugYZpA
         oATsw34syidbkodP0uSit41QfcoB4jkAHjAF/GuaSfZcGR+QM0VU8eBiwbHQeoGYncTA
         hZY+tyfZ2BSgZKBpmrWHwAtMMepb/rlrSohB9hELFVAwikamyw6FZCto/nUZDVEYGfmQ
         mmyWebcFGqcneupIRi3DB+LzaYTz/8bPa5flV3A+FRXf13t7Ypa+wKmtuhtYjD51BMub
         yq8w==
X-Gm-Message-State: AA6/9RlYC2bdLmHLFmulAgSJ8kgtVA291MMj2olIxABWZg9PgiOrCT7FGEofxuNsGIGke1QA
X-Received: by 10.66.11.231 with SMTP id t7mr9051487pab.203.1476211212132;
        Tue, 11 Oct 2016 11:40:12 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:19ef:1eb0:a061:def1])
        by smtp.gmail.com with ESMTPSA id yo3sm5965855pac.42.2016.10.11.11.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Oct 2016 11:40:11 -0700 (PDT)
Date:   Tue, 11 Oct 2016 11:40:10 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 17/28] attr: expose validity check for attribute names
Message-ID: <20161011184010.GA16014@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
 <20161011002115.23312-18-sbeller@google.com>
 <20161011172805.GB9085@google.com>
 <CAGZ79kbqikTtUGxXFB3W9k1nL6ST2iwRRi5zEuL9BOpHxZWc8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbqikTtUGxXFB3W9k1nL6ST2iwRRi5zEuL9BOpHxZWc8A@mail.gmail.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11, Stefan Beller wrote:
> On Tue, Oct 11, 2016 at 10:28 AM, Brandon Williams <bmwill@google.com> wrote:
> > On 10/10, Stefan Beller wrote:
> >> From: Junio C Hamano <gitster@pobox.com>
> >> -static int invalid_attr_name(const char *name, int namelen)
> >> +int attr_name_valid(const char *name, size_t namelen)
> >>  {
> >>       /*
> >>        * Attribute name cannot begin with '-' and must consist of
> >>        * characters from [-A-Za-z0-9_.].
> >>        */
> >>       if (namelen <= 0 || *name == '-')
> >> -             return -1;
> >> +             return 0;
> >>       while (namelen--) {
> >>               char ch = *name++;
> >>               if (! (ch == '-' || ch == '.' || ch == '_' ||
> >>                      ('0' <= ch && ch <= '9') ||
> >>                      ('a' <= ch && ch <= 'z') ||
> >>                      ('A' <= ch && ch <= 'Z')) )
> >> -                     return -1;
> >> +                     return 0;
> >>       }
> >> -     return 0;
> >> +     return -1;
> >> +}
> >
> > Whats the reason behind returning -1 for a valid attr name vs 1?
> >
> At first I thought the two different return path for -1 are different
> error classes (one being just a minor error compared to the other),
> but they are not, so having the same code there makes sense.
> 
> So I think we could change it to +1 in this instance, as a non zero
> value would just indicate the attr name is not valid, but not necessarily
> an error.

Wouldn't a +1 indicate that the attr name is valid while the 0
indicates that it is invalid? It looks to me like we are checking each
character and if we run into one that doesn't work then we have an error
and return 0 indicating that the attr name we are checking is invalid,
otherwise the name is valid and we would want to return a +1 indicating
a success.

Am I understanding the intent of this function properly?

-- 
Brandon Williams
