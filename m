Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B45C41F461
	for <e@80x24.org>; Sat,  7 Sep 2019 23:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392800AbfIGXQT (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 19:16:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46089 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbfIGXQT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 19:16:19 -0400
Received: by mail-io1-f68.google.com with SMTP id x4so20801275iog.13
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 16:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A8MhT8VHpuOgHx+o1mi10VEm0GJKv2v++pUtd56mrcY=;
        b=rzMJ1wINM9eic2C07D6ziiSR2VQW0ZxiXxi8wo8C1dbdW9BdsO4iRZhBIyaaSfO1mK
         DtURBw7BR7lxykp6BgBQVRDSPMIUp05ynuP67CjtdjWeL+yQ/rliaXt4I//EhOkAIrus
         dt/lNkHAmcLCdvakHjn1NyKhwWFogQiP3QpgscKwmE3aTW4jYcp60txBdsPDo97x/Lus
         aV5YWgMfHy4Loso07Igb2kSTgTsiNmdoErmp/Xdgy5f2E60fRU1XTbPeH3MRcFDnSAvo
         M2vU0JQxQvqvxi+aJQ9NCHC1e9jsQKwsAe5w46ANi3nTiw5AMRpgNi03ctN9Ey8G37AM
         h5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A8MhT8VHpuOgHx+o1mi10VEm0GJKv2v++pUtd56mrcY=;
        b=bAC1+0w5e8QsC67/PcLcbXa022Coz4diisLMeHS18OXCOCA6id0Ld+tjZ7Id1UkRy+
         QwmwFWeo4R/OsXNm7mVqDooY9zMLW4S4oqI0I1q4FjgdXXl5JcFaC4H79gb2mhLLLVDR
         ThLuldLKRZktgom/2kdgGN9aPoyECSeJqFmBQ7kQCl8aLvFaR3TNHTRitFNSSwRJ4I4z
         BzfxahJcYba38wCxTgwL8W6lKcOVTbODxYU4fHeJAeXpSRogi0yHBcPzOn95L8lHu+4e
         qxDxKgdnCJfDcJQo+5whsgmjvzFVblCZG2qKU6i3qVVLhZkEqpQyqZGGYmM4cif3E0oV
         c2CA==
X-Gm-Message-State: APjAAAVFFxRILJMvA/x1ckg2BuE31KekEyuHxxY8ufa/pVRgjrF5GJG4
        o1tkoMhkrZvhQCNnI0xOKL3xmi4esxI=
X-Google-Smtp-Source: APXvYqyQuFJ9De1J/We5VCg7RNfu83C0tbYQzfs06uWJkELYKYzhkALexeg7peTR0Ni6H7IIUXFUYw==
X-Received: by 2002:a05:6602:25d3:: with SMTP id d19mr18776927iop.206.1567898178552;
        Sat, 07 Sep 2019 16:16:18 -0700 (PDT)
Received: from localhost ([206.121.37.170])
        by smtp.gmail.com with ESMTPSA id f7sm7468750ioc.31.2019.09.07.16.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 16:16:17 -0700 (PDT)
Date:   Sat, 7 Sep 2019 19:16:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Freese <ericdfreese@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] for-each-ref: Add '--no-symbolic' option
Message-ID: <20190907231617.GA36491@syl.local>
References: <20190907213646.21231-1-ericdfreese@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190907213646.21231-1-ericdfreese@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sat, Sep 07, 2019 at 03:36:45PM -0600, Eric Freese wrote:
> Hi,
>
> I was recently using git-for-each-ref in a script to get a list of
> remote refs that pointed at a particular commit so that they could
> automatically be updated and pushed back to that remote. This fails when
> it comes across refs/remotes/origin/HEAD, which is a symbolic link.
>
> I was able to solve the problem with:
>
> ```
> git for-each-ref ... --format="%(refname) %(symref)" | grep " $"
> ```
>
> But that feels a little clumsy to me. I would have expected there to be
> a flag like `--no-symbolic` that would exclude symbolic refs from the
> output. So I went ahead and added it :)

Indeed, that does seem a little clumsy to me, too. It's kind of a great
hack, but I could foresee functionality like '--no-symbolic' to be
useful to avoid hackery like this.

> I could forsee this option also being added to git-branch and git-tag,
> but decided to keep it to git-for-each-ref to test the waters before
> investing any further time into it.

Yep. It's good that your patches are mainly in the 'ref-filter.[ch]'
code, so it would be easy to wire up new flags in both the branch+tag
builtins, too, since they use the same ref-filter API.

> Cheers
>
> Eric Freese (1):
>   for-each-ref: add '--no-symbolic' option
>
>  Documentation/git-for-each-ref.txt | 3 +++
>  builtin/for-each-ref.c             | 4 +++-
>  ref-filter.c                       | 4 ++++
>  ref-filter.h                       | 3 ++-
>  t/t6302-for-each-ref-filter.sh     | 6 ++++++
>  5 files changed, 18 insertions(+), 2 deletions(-)
>
> --
> 2.23.0

Thanks,
Taylor
