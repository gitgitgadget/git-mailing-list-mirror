Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DBFE1F461
	for <e@80x24.org>; Fri, 23 Aug 2019 18:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405392AbfHWSUB (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 14:20:01 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40092 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405291AbfHWSUB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 14:20:01 -0400
Received: by mail-io1-f67.google.com with SMTP id t6so22200096ios.7
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 11:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cyoXo4v1WTPtd1huN6c4VRamlctEw1bvpyWKGt1EVE8=;
        b=Ek6/IvUPQvzeeb2aoqejR9hqDkgmoYL3zoNgETtg7P/R2BOKxMgCBTEIXuof4akdiI
         4N5mDgx4+NNGoKY3pnywTvHcG7J6unydXzq0jGhIXB2XxdTcJJyzv9I9e7OySlVItMQP
         moknTG8+/yRmkurSf1XFgxYmh6H+7k55wpqZAzxrCk1blCeaSSTpPs97qkuqkgmU7VKH
         YQnvpZdRh5ZqLuJH5h0dk7fSQYNF2I7qiRLATmIEYDunyfCDaUj8Ge2CYFf42osW7S3X
         XwXiUk0CUIfExdB+ZVLMwMfsL2oLPKsvDp3/XdReVZr+Os1+7eRbmqCvOevebNtzGD0S
         7r0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cyoXo4v1WTPtd1huN6c4VRamlctEw1bvpyWKGt1EVE8=;
        b=crFVf94LcNEgTrEM38sJ/XbC9ec4u9KlVlhPrXZiOdzf0qaZalVLEWQTnezCb9+FIA
         7Y36A3mIDk+S2DBDYwmgtthlElZKthwaTlOPf5W4bXS1RdJsQrcPh+a8hfPpZrwHaK/M
         SijviFi9u+WsJ3ztTs02YIXjysumpUSDtTKMJjFx6zqOY8bFTF3nnNSEvfhY8Byet5gR
         FggzpAQH0425hom5KwmBsZghhoYXoRRA/w8ik/ky9Jw+qVuMeJ5MAYsGasOFAUTmjuCR
         91evijMuHQMFK+PRWDXSUrPEW6DI8i4jmYGdztmPvOeAOfnSrigRD55jufdyz8Olt0RJ
         6I0Q==
X-Gm-Message-State: APjAAAVRREvz4SzOreCmacb5lwacLfZJZlVWGRYMIH/dSxTm3r3DopGU
        jPXIwtyRKS8e5146L6L7zKY=
X-Google-Smtp-Source: APXvYqztOAI+1zZ+nbwnzZopbNCwsF/+gRGBTpi4mcuWKcbTefF/ZOn3jANyofaUOlS+ecb/CZGt9Q==
X-Received: by 2002:a5d:8f02:: with SMTP id f2mr8808183iof.192.1566584400149;
        Fri, 23 Aug 2019 11:20:00 -0700 (PDT)
Received: from archbookpro.localdomain (CPE001a8c429ab1-CM1cabc0716f20.cpe.net.cable.rogers.com. [174.116.84.77])
        by smtp.gmail.com with ESMTPSA id y25sm5732087iol.59.2019.08.23.11.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 11:19:59 -0700 (PDT)
Date:   Fri, 23 Aug 2019 14:19:56 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/13] format-patch: learn --infer-cover-subject
 option (also t4014 cleanup)
Message-ID: <20190823181956.GB14048@archbookpro.localdomain>
References: <cover.1566258525.git.liu.denton@gmail.com>
 <cover.1566285151.git.liu.denton@gmail.com>
 <xmqqsgptnedb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsgptnedb.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 22, 2019 at 01:18:08PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > While we're at it, perform some major cleanup of t4014 including some
> > stylistic cleanup and also, unmasking of Git return codes.
> 
> Wow.  It seems that "while we're at it" grew quite large and (from
> purely patch count's point of view) ends up appearing as if it were
> the primary focus of the series ;-)

For housekeeping, since this patchset now exists as two branches
(dl/format-patch-cover-letter-subject and
dl/format-patch-doc-test-cleanup), would you prefer any new revisions
exist as one big patchset or two separate patchsets targeting each
individual branch?

> 
> Thanks for tackling the age-old mess.  Admittedly, this particular
> script is from the older parts of Git's history and a clean-up was
> long overdue.
> 
> With the "split pipes" approach taken in patches 09 and 10, we'd end
> up leaving more untracked and unignored cruft in the working tree. I
> do not think they would cause problems with the existing tests after
> reading the patches over.
> 
> 
