Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23E7F2018D
	for <e@80x24.org>; Tue,  9 May 2017 22:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750780AbdEIWN0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 18:13:26 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33387 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbdEIWNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 18:13:25 -0400
Received: by mail-pg0-f43.google.com with SMTP id u187so6371600pgb.0
        for <git@vger.kernel.org>; Tue, 09 May 2017 15:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8gmPGOeHHaSfH0Vlxhuful7J+KAAZhUYJVl/aqNGCOk=;
        b=d6evq+YOk/7rZ17ie4XmY2gmTTrg/hfoU1iI/ToNntUQoJuVEg5WG/BBb36kaMJpE6
         eNk1Mayzb4apSHjZJdsm+L94R6yahC8PLRHq67Vx2rV/zrlSa05zwgfhEHXD+8Cd2xBq
         DlJ7DR4Wsw0Y+OJh0j7j8fqy8l4wcPsdC8adyQncTNrU0CJTnwRhI936jmfP0TdwDpX0
         P8Ys69WSWPqPioadW3u1PVd/960QQcqNzyUN4uZZv3x69+6mNAAPYFzLtLvo8nHR7QMz
         j7tFvg9ZtApO4weV5nnSzFMRXiPnRawXpQ1TOPyhFmM1ltbKLn8bH4HnwpAUEGS+L+Kr
         Frbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8gmPGOeHHaSfH0Vlxhuful7J+KAAZhUYJVl/aqNGCOk=;
        b=iP/baQNGPf9kZkDjP9es+p0cpfKAaYk73jeURjCciNTyB3amupoD4vzZZyGELwnEHX
         3Avz002lIlAR0uxhUPkJMros+wnkkEntOh86sYIC55WHiLDkKQu+WOmAN+mcBvXqWVdq
         qo4j3rHq5wj0whq/Du+y6xtdDfEmtiCF8OAS+s4v/+3lJFd09Tw3jHO7Y0IX+OEeWtI1
         97ixa61NQJPHYuAARgpvyA6sRwHZ6Km5C2n74FqlIAexz20gOjRVRfmijgE8XelrD/s7
         btPzkOk+USGKvL5BBcy8AhOpDAo8oiQnpqTTucrWMS8RAbRzvmvsjOKd/C0pFiTqXvTt
         tHmA==
X-Gm-Message-State: AODbwcB3uRbSJp0Q6m85m5AxivratKriqsFWwMwjr5P1/fqiPCdsWGcN
        M1wRvxapOtewlG2P
X-Received: by 10.84.143.129 with SMTP id 1mr3363648plz.105.1494368004559;
        Tue, 09 May 2017 15:13:24 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b127:d26b:19a3:378d])
        by smtp.gmail.com with ESMTPSA id o5sm1561351pga.64.2017.05.09.15.13.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 15:13:23 -0700 (PDT)
Date:   Tue, 9 May 2017 15:13:22 -0700
From:   Brandon Williams <bmwill@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 00/53] object_id part 8
Message-ID: <20170509221322.GA106700@google.com>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/06, brian m. carlson wrote:
> This is the eighth series of patches to convert unsigned char [20] to
> struct object_id.  This series converts lookup_commit, lookup_blob,
> lookup_tree, lookup_tag, and finally parse_object to struct object_id.
> 
> A small number of functions have temporaries inserted during the
> conversion in order to allow conversion of functions that still need to
> take unsigned char *; they are removed either later in the series or
> will be in a future series.
> 
> This series can be fetched from the object-id-part8 branch from either
> of the follwing:
> 
> https://github.com/bk2204/git
> https://git.crustytoothpaste.net/git/bmc/git.git
> 
> Changes from v2:
> * Remove spurious space after ampersand.
> * Undo more needless line rewrapping.
> * Expand computation for notes path.
> * Remove check for line->len with parse_oid_hex.
> 
> Changes from v1:
> * Rebase on master.  This led to a conflict with the ref-cache changes in patch
>   39.  Extra-careful review here would be welcome.
> * Undo the needless line rewrapping.
> * Fix the commit message typo.
> * Use GIT_MAX_RAWSZ instead of struct object_id for the pack checksum.

I wasn't able to find any issues with v3.  Looks good.

-- 
Brandon Williams
