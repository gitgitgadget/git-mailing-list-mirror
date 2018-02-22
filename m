Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA1491F576
	for <e@80x24.org>; Thu, 22 Feb 2018 06:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbeBVGx0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 01:53:26 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:34577 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeBVGxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 01:53:25 -0500
Received: by mail-io0-f195.google.com with SMTP id e7so4913264ioj.1
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 22:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vhiOTsp9Xiv3Yrg7Vr6rETcZ1xhY4ODB+ZlEegC4v8k=;
        b=NGq4tXW9Rss26R3WvfUbycmGTff3bBHFHgACJFf84Av79wQmJGEb72cQOGM+sc7WoN
         shmaVXlcclFNBMiyKOKsJ4fVr9OCXqr3aVzogBO/zB1ZO2XEFARYsdvKsPer+qCVTfHx
         e5TA5gIfowu5XZP5D4xLtZpJy6pq+QY3XH/H5ambS2Og2RVZP7ZVcQhEjozRgeb+i9pC
         f8JSj3dJ5O0hZgMki4goVa0R5IQC7GrTT0aoN1FCpk2C9JRFC3u++aQ1kXI+Z2ohYU0V
         DNlX6GI26dTC84d8LJ3Q/RWphBZitYoj0+e31cBchLc97n+PxBcRkOwYaxSa51HPcME/
         9Z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vhiOTsp9Xiv3Yrg7Vr6rETcZ1xhY4ODB+ZlEegC4v8k=;
        b=Sx66/WP3meW27ewlSk3YDNHRWK/NeSaX9rY3rC0E8zzxNzifvUsmvOgldIxpcFgRGF
         acmOm93o2wm9mZ0I+3lkQsW/i2Ezgv6Qbienr2B99TzxZpz9Tb8N+uZPmORE6SvCSVb1
         u6srBUq21Kh2WJQkcrZkwUBITFkBRvfqhClVMfvDnQlwSZfsiHtDFUZjoxEgSwHBkVJz
         ds5Y3AjrfPfPGqUA31b1Nca/ScF25+n19i/ogFZTc7UPubiE7vwoxAlvPKR83J4Im9MN
         b7wsU6elhwTgtdNUAQUCFoHu8a65JFgK1lYnt3fuwwoKl0knoEjQ3jLX2vIZpcCpSng/
         K2dg==
X-Gm-Message-State: APf1xPAbihsMC9BV7tRQB+nYxUSgzDbaSz34twj784VCkhjXzQQI1A9Q
        shljC3vyW2HRPtA5hJpq1nM=
X-Google-Smtp-Source: AH8x225856sgLhYKvw53dScFLwGRcqvfFtp6Fn287vtUT5svgEyh8AfvkSftJg3F7n1WhIrNNhj2yA==
X-Received: by 10.107.56.69 with SMTP id f66mr7484453ioa.170.1519282404934;
        Wed, 21 Feb 2018 22:53:24 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id t123sm25789800itb.14.2018.02.21.22.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 22:53:24 -0800 (PST)
Date:   Wed, 21 Feb 2018 22:53:22 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH 21/27] sha1_file: add repository argument to
 sha1_loose_object_info
Message-ID: <20180222065321.GG133592@aiede.svl.corp.google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-22-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221015430.96054-22-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> Add a repository argument to allow the sha1_loose_object_info caller
> to be more specific about which repository to act on. This is a small
> mechanical change; it doesn't change the implementation to handle
> repositories other than the_repository yet.
>
> As with the previous commits, use a macro to catch callers passing a
> repository other than the_repository at compile time.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  sha1_file.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Simple and obviously correct.
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
