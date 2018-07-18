Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2CAE1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbeGRRyN (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 13:54:13 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:42622 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731362AbeGRRyN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 13:54:13 -0400
Received: by mail-pl0-f44.google.com with SMTP id z7-v6so554552plo.9
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4F5h9zH7BXA7efsuSRG6Wds6QA9cl111enymDLFy60g=;
        b=chJmSI1iRBtlWPH6JREbaM+jnT7mGfsCOKKYdJbvNC99fuBhIoBNkxqeg4vKwwlAGn
         ppAa9wFj29947fopwoisESHbKsQ1KsKN6Yiad0fVln9t4rEoITpcceLyBr2hOhzDXRiq
         KsqWsqBimZWPFBoiPMCb9/uoTJFKZJm/zzvp+NePzmEAmLV437PaLx1ORF+VSvdNWUak
         j06V7FreIz2y82uxSxCng2PElXMKcGLVGS2j/JezxRlE7whCmS6jdKYOHLYeeI6644YP
         NDPX87NueTpt6sh6N/wfnFONwrf766wIWuifdMUiCxOFAly4xXGwATOJkOyKmugNIPTw
         0Xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4F5h9zH7BXA7efsuSRG6Wds6QA9cl111enymDLFy60g=;
        b=TAGysZ7ulONMo6OTaMv39amZj2zPlGOeSu2Hw9kmdv8zYltkPknxjtxBcit6QH4Q7F
         YtpvbaZG+QWoyb11vl8syojQ9PfIkaj5JCth97KHfwLAnHT1yTq2lNt1KvxDLo5+HCoK
         mlwAB8o202JFICtvuDETvnxsQe36LWWd5Nel+jWyykAw61Cy1cC+ANpgipLV6HOmz3mF
         a1sANJOU3LbNFP2lg8BwLL3ebYlytJbPZm2rM+YREdt8dEsOuGHhsPI3BAgv2ZwUjdye
         Zf6sIrIDkAe53eAMz9cgw6QlY4ykuosh2E999YlntHgnN+7+o+JrNceKS4N3hNjjkW9X
         s+IA==
X-Gm-Message-State: AOUpUlGiPkgUYlOHH/03Wjazme+VWSqBJVfeiCLYwn30SvVWGXO+uVZq
        yMKftLkGPVCUvrxethKY9+bjYA==
X-Google-Smtp-Source: AAOMgpfNHt03DRWW4dnKSho/4BV2Hi6CgRQS3/OAA/FqxJO/XrPWnxBam58/uLZ/Z3wIw1qL3KVjlQ==
X-Received: by 2002:a17:902:bc41:: with SMTP id t1-v6mr6825818plz.26.1531934121658;
        Wed, 18 Jul 2018 10:15:21 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id o4-v6sm5466882pgq.91.2018.07.18.10.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 10:15:13 -0700 (PDT)
Date:   Wed, 18 Jul 2018 10:15:12 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [RFC] push: add documentation on push v2
Message-ID: <20180718171512.GC17137@google.com>
References: <20180717210915.139521-1-bmwill@google.com>
 <CAGZ79kZEpNLkXuEQEiMB_nc-MOOp-KOziHyONmr4SiajA5+F2g@mail.gmail.com>
 <a7c43308-a388-e307-6bea-47e6df74b65c@gmail.com>
 <CAGZ79kbLn-uwQOXfqhtO46v0EWevY43Tf4W5Rz9gDD9_qbmX=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbLn-uwQOXfqhtO46v0EWevY43Tf4W5Rz9gDD9_qbmX=A@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/18, Stefan Beller wrote:
> On Wed, Jul 18, 2018 at 6:31 AM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > On 7/17/2018 7:25 PM, Stefan Beller wrote:
> > > On Tue, Jul 17, 2018 at 2:09 PM Brandon Williams <bmwill@google.com> wrote:
> > >> Signed-off-by: Brandon Williams <bmwill@google.com>
> > >> ---
> > >>
> > >> Since introducing protocol v2 and enabling fetch I've been thinking
> > >> about what its inverse 'push' would look like.  After talking with a
> > >> number of people I have a longish list of things that could be done to
> > >> improve push and I think I've been able to distill the core features we
> > >> want in push v2.
> > > It would be nice to know which things you want to improve.
> >
> > Hopefully we can also get others to chime in with things they don't like
> > about the existing protocol. What pain points exist, and what can we do
> > to improve at the transport layer before considering new functionality?
> 
> Another thing that I realized last night was the possibility to chunk requests.
> The web of today is driven by lots of small http(s) requests. I know our server
> team fights with the internal tools all the time because the communication
> involved in git-fetch is usually a large http request (large packfile).
> So it would be nice to have the possibility of chunking the request.
> But I think that can be added as a capability? (Not sure how)

Fetch and push requests/responses are already "chunked" when using the
http transport.  So I'm not sure what you mean by adding a capability
because the protocol doesn't care about which transport you're using.
This is of course unless you're talking about a different "chunking"
from what it means to chunk an http request/response.

-- 
Brandon Williams
