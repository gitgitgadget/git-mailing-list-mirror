Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1597A1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 23:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeIGE2f (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 00:28:35 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:44265 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbeIGE2e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 00:28:34 -0400
Received: by mail-ua1-f68.google.com with SMTP id m11-v6so10535520uao.11
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 16:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GouLo342ToIy8G69Yuy5Ye/Qku5JWp0+ixPTG+kVvAs=;
        b=MgWmoD9igF6OyCL4idAdIPG0eeItGZK/CLle8J5ZhPfh/9a8rAmZT4p8/wXxm+qHBz
         TGdYfyxUQ5H8+JwrQQVoICG2ZcG/L8BD1q5ciyxWw9TDISh8Aip0B/vmxBdrKnVqCzWu
         TRRE6l/T69s/lVv5iMI7RevAcFRnF61YTc3lr3sPuxadP0lYwADDtCymdi0DRvIoENN3
         EqyzhdRLPXSXBlwQn+7ezoTi8jTHinrwNad0q20WIPQDgY+ezuN+BuUIklGcKM/bf57j
         FC1ijj2om0KVB3+3UKQ13yZ5VdJZw3s7uhRXsfQ0vYN7l5NcVd9QVdpxVLWSAFMp9xqO
         zMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GouLo342ToIy8G69Yuy5Ye/Qku5JWp0+ixPTG+kVvAs=;
        b=ropVh4qaSrSvbPgDXJWpHKDGV8ydTNBR2iN7/6+wpe1HMHtflCPjBEHt1sltflxBmB
         S9JJVmmx6xnF9HxHeiK/3h2JsN9LLxvdDXGJy4XXoH0tdtELXDz/S96i2IWad4C636Mp
         dCQO9WwlVDcWyu0vbSTfFPcFN4nKZRb3nYglHQSguBfhY49oCOTRgBHGLwz4uaCIwoFq
         5qXGGS84PObOx2in6mJ0TC5D81CBZBRu0uLR0RxC/qcUCmEjWCk/TT+xdE1AdEwkKCI8
         aWHIenzC1wc2hi8PoEy5GQnCbE2LqtMvFJ/+V3TXS+1il7p1eR99Gy/cmoI7FV/UgJcq
         kW2g==
X-Gm-Message-State: APzg51DxbSNb6k2t/exCFdmfBibbWJM5LSkfR2a1i2lPDpTUakq9tPii
        xvEfDSObTk+S/sHBlDyQYGE=
X-Google-Smtp-Source: ANB0VdYHkADhwMAs/aNms7pmsjCBjWy+Of9+NY4rR63gg4P3mtq+uH32Fp4M1tznTxpOC0kMofbM9g==
X-Received: by 2002:ab0:51ac:: with SMTP id g41-v6mr2033802uaa.155.1536277838456;
        Thu, 06 Sep 2018 16:50:38 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b130-v6sm1225925vsd.17.2018.09.06.16.50.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 16:50:37 -0700 (PDT)
Date:   Thu, 6 Sep 2018 16:50:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>,
        gitster@pobox.com, pclouds@gmail.com
Subject: Re: ordered string-list considered harmful, was Re: [PATCH v3] Allow
 aliases that include other aliases
Message-ID: <20180906235033.GA100309@aiede.svl.corp.google.com>
References: <20180906191203.GA26184@sigill.intra.peff.net>
 <20180906192021.GB26575@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906192021.GB26575@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> But what I think is harmful is a _sorted_ list, because of the
> "accidentally quadratic" nature, and because it's easy to call its
> functions on an unsorted list.

I agree --- in general, it tends to be better to build an unsorted
string list and then sort it.

Once I've done so, what is your advice about getting fast lookups
in the result?  Should I build an auxiliary hashmap as well?  Or
is this an argument for the 'sorted' flag + BUG approach you
already mentioned?

Whatever we do, I agree with your goal of getting rid of
string_list_insert.

Thanks,
Jonathan
