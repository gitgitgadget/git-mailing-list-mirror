Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B06CE1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 21:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeBWVWf (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 16:22:35 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34073 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeBWVWe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 16:22:34 -0500
Received: by mail-pf0-f170.google.com with SMTP id j20so590580pfi.1
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 13:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bCfTrDwu7id2ODOwmED6C56WNNPw/MmkzUIgZTWxDhE=;
        b=TEYPuCw7ZowvxJJVT1o6hlJO6rkTwx4S/eN517zPqUd1PHpOWAtCMGqWFglGkFxDZy
         rN+Yp22/JDYmFoxp0XaLZ6QK1Hu+c/rjJSckwuqA8/oS457tnU+hVLU7KFpbj4CDIoi1
         yFSFEh1i88a4PbaUki33d0ma7wUbVjPpuIA3bafjohRaZ6mXaHB9ppgB0CidJwzZWgYI
         gi/r5ONdLEQQEClspD/Tieg16d2x1oktBFfPiZRTD+A+Tn4PgTNyhtKOmjjgfRF4eNNX
         hQuJ9PdM/4UrBXCi+Y86Pl5PjQ3Vc77/IDqnQJeA4ENSHYjp5PEK4Q+eGYAcQVf1IC+8
         PvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bCfTrDwu7id2ODOwmED6C56WNNPw/MmkzUIgZTWxDhE=;
        b=dDyR0VUl2CJ9ovvlFWz7MKLw9yFJiatFfVRDUNTR01kqdB2drWNOABo7wMyYKdkAj1
         8LGInsO7ugrX8HSMoM143Gt641ggCMw1CdTr0h2i9RKgUHnkqxM83JTZZkzBUFoyYZ44
         7ESmW/8jmrSgn1iMLHvPrTa8zKGKVsjFoGCEm+nzaIKC9/FWPZbMbXkDHqlapPIHLe8m
         4/zEs6vzuJxAkVKYO0bx9z95d10e3FMbRrF8LTjK2H9ceZB7w9qJvUMsMBXpcUONJD72
         esG86pn3JHkKS1AoWqB+yRbscMNrvJZIc1KWDbGi/okdsOWuIr3Lr0dbjf848hm8yYGK
         OXDg==
X-Gm-Message-State: APf1xPDkqGIBEP52hxHFZo/mkH4zwKsY1ETfs1iCKRPFpAo3SFMBeWwV
        yaxmw04ZIMdHL5qDahnt/sJdAg==
X-Google-Smtp-Source: AH8x224/5FijHgc7PGl+aijvyDssexBRAsEEYnlZfZ+aR+dSTjjoJm0roqoQK6s1omOCuADf1lrH/A==
X-Received: by 10.99.125.69 with SMTP id m5mr2402326pgn.77.1519420953397;
        Fri, 23 Feb 2018 13:22:33 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id r28sm6580450pfl.9.2018.02.23.13.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 13:22:32 -0800 (PST)
Date:   Fri, 23 Feb 2018 13:22:31 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 11/35] test-pkt-line: introduce a packet-line test
 helper
Message-ID: <20180223212231.GC234838@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-12-bmwill@google.com>
 <CAGZ79kbrm2Ei=spoDbjrwVFoF+mi0AAsXNLDBgCozFVoXM6+1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbrm2Ei=spoDbjrwVFoF+mi0AAsXNLDBgCozFVoXM6+1w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22, Stefan Beller wrote:
> On Tue, Feb 6, 2018 at 5:12 PM, Brandon Williams <bmwill@google.com> wrote:
> 
> > +static void pack_line(const char *line)
> > +{
> > +       if (!strcmp(line, "0000") || !strcmp(line, "0000\n"))
> 
> From our in-office discussion:
> v1/v0 packs pktlines twice in http, which is not possible to
> construct using this test helper when using the same string
> for the packed and unpacked representation of flush and delim packets,
> i.e. test-pkt-line --pack $(test-pkt-line --pack 0000) would produce
> '0000' instead of '00090000\n'.
> To fix it we'd have to replace the unpacked versions of these pkts to
> something else such as "FLUSH" "DELIM".
> 
> However as we do not anticipate the test helper to be used in further
> tests for v0, this ought to be no big issue.
> Maybe someone else cares though?

I'm going to punt and say, if someone cares enough they can update this
test-helper when they want to use it for v1/v0 stuff.

-- 
Brandon Williams
