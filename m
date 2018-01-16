Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 554DC1F404
	for <e@80x24.org>; Tue, 16 Jan 2018 19:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeAPTXH (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 14:23:07 -0500
Received: from mail-pl0-f51.google.com ([209.85.160.51]:34874 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbeAPTXG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 14:23:06 -0500
Received: by mail-pl0-f51.google.com with SMTP id b96so6911991pli.2
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 11:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QCSrcvGvPcpZqz16AwPhZiRpSg7cJx0uOxwEGupRcmU=;
        b=n7qJDEO1erDYe4cD0w2S4Ncax6YAnZuNNuTJXRXNkmLAcQJnGZToDcnpuRQHDZoxeL
         O/17Ct0aWLMzHWE3S4/13Fdv6lkYOwbfjCEk7M/bKKLTIZXam0RqQ27FSLqNhDKIjNFL
         5/HtsSSW6JCHWCoe57B6hu8QZq3Kgj/lshlTvm7jVTgqnKiNq3mH6aur3KumeTOLGafO
         khLEt92TphfSLlw7W/n+Q6YbMzogN44vksRFJNaBqTodQTwRoP7Dz0+9WjXiNMnMAiHW
         1MUN+5Cmvi19nYu+aV73sv25sJm4N549xwT/g/jARSBA36BLDXx5HmFXBKj3hDidSDra
         g9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QCSrcvGvPcpZqz16AwPhZiRpSg7cJx0uOxwEGupRcmU=;
        b=VePDUOViN/+M5dF5hfj4p1Xt2NDt0aLMxMH73ArJBm7rt5rXvW6sBl3eyV+YqbDdMt
         hLHiak4bAfohfBHCSPeFZ2pYdpWyuTSZeDwwRfgP1mzx9ki4jHSI7+OiOtktCWVdBK/9
         TvofQHTHD/LGBWkANl0zQW8LHvb8CzvMUkJ4Z0Xv2UkSCZNCxYS1rPoErlUronYJA3DD
         bu8/MYrCHKQd8MgVlSkS3qHffNlUenJbp7cpQVfNsLzmRhT1hmMsjuhx2zol0EVYlov9
         0BNF614GAVAkneQ9jtIxV02qgklChkWUMCvGZoibKh0myQejd5ibLTwqlMyOhE4Kx6bd
         NM5A==
X-Gm-Message-State: AKGB3mJj6ur4IeGPKIY3sI+HivPR+DzsQCOc2/7pgwSJYJCqAg4fvWJB
        WHNaAhnVK+HUcYDsfUiUbQmbGw==
X-Google-Smtp-Source: ACJfBovBMZAiAmUZy7mgJSizGJusZiio5QuXlFTlNDwNlP7oDBHC/bAOngPlzPs/fupCRlKQPLdgBg==
X-Received: by 10.159.218.151 with SMTP id w23mr31453398plp.100.1516130586198;
        Tue, 16 Jan 2018 11:23:06 -0800 (PST)
Received: from google.com ([2620:0:100e:422:f523:b526:bbca:bb86])
        by smtp.gmail.com with ESMTPSA id k90sm5054897pfk.171.2018.01.16.11.23.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 Jan 2018 11:23:05 -0800 (PST)
Date:   Tue, 16 Jan 2018 11:23:03 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 12/26] ls-refs: introduce ls-refs server command
Message-ID: <20180116192303.GC135179@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-13-bmwill@google.com>
 <20180109125025.6c88700e6e00e45822ee8932@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109125025.6c88700e6e00e45822ee8932@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/09, Jonathan Tan wrote:
> On Tue,  2 Jan 2018 16:18:14 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > +  symrefs: In addition to the object pointed by it, show the underlying
> > +	   ref pointed by it when showing a symbolic ref.
> > +  peel: Show peeled tags.
> > +  ref-pattern <pattern>: When specified, only references matching the
> > +			 given patterns are displayed.
> 
> I notice "symrefs" being tested in patch 13 and "ref-pattern" being
> tested in patch 16. Is it possible to make a test for "peel" as well?
> (Or is it being tested somewhere I didn't notice?)

Really good suggestion.  I'll introduce unit tests for both the
git-serve cmdline as well as for more simple server commands (ls-refs).

-- 
Brandon Williams
