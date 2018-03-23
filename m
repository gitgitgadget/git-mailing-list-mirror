Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349B41F404
	for <e@80x24.org>; Fri, 23 Mar 2018 16:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbeCWQlH (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 12:41:07 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32783 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbeCWQlF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 12:41:05 -0400
Received: by mail-pg0-f65.google.com with SMTP id i194so572105pgd.0
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 09:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bxCt7zB26Hn5x7m0WxODv1rPRGAq3+SIKJryZZEBB6I=;
        b=aKPnaff7S8J0HOv+nyAxxTPXyyFrcLWfraHHBQEu9mSnQb0DNcVc5Evyg0smtSrINb
         X9KTGnnpqiKdrrvbTtXRdW9KZPgf/QARWNQcBdM0M4CAf9WcYKfscBkYT6PQ6iQX8wc1
         4MSaYKZ+LxKbxFT7L4/A0WwWWrkNQXpJ8ob68kDdg/xqfirMYjHkNgoEosPpOt5w2egG
         OFqGEnRDsobcxOkgAF3qpzR7i8isalRry1y1+Km6NXjbQtXroVUb551NX3FhUCrZuibp
         NVm4uJl042LuDW+Lxq7cnfG5Mej9DPL1jq1ioXU+b2mDDEG3BLeX8C32eRj7/sbWqTsn
         xl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bxCt7zB26Hn5x7m0WxODv1rPRGAq3+SIKJryZZEBB6I=;
        b=im6PWQrNkpph3wkKwRGD+5Lb7BDiSDqPenqui2BxBUDF9bhP19xRLlPNhNJLyQ4Feg
         zMs3XCgMU54p+hFTcYCjb0q8tUpF4KU429fn9ry5nv60qrJn5PN5t4qdCETdYUG7OT+h
         0c2whDt7KwgbrZ8TuhJDe6Svpt1R9CRjj9J9XPdxBTsm+hc0KatcvEOfggYGdZ8F/CvW
         /C6zERqTnRNKfP8OSCVXBY9kFx+oWvNDlBQpnBxehBYVHMqcqCz0ULHhCKJVuZX1C1J0
         8jNVOlA/8dMPvhYH4Matk0i39gEhiB84uKxxp1hDIXhA/6oSKa6gkhIyIYQBLJfDFEOb
         z2wQ==
X-Gm-Message-State: AElRT7Gx45Y9e+AqEZNk7x+kUlXZRCWNytc4kYe6ndfrySA9TnxSRhev
        llqdCGdy5+cDNT2uk3hc1pL+3TU1
X-Google-Smtp-Source: AG47ELuvZXKi5xl8gNYby/3/4y65Hi64xe3aXVlM1ciskgTkvohnBydrk22urqZdYU2uN9OCXopxow==
X-Received: by 10.167.129.217 with SMTP id c25mr5057374pfn.143.1521823264382;
        Fri, 23 Mar 2018 09:41:04 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a13sm16732908pgd.1.2018.03.23.09.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 09:41:03 -0700 (PDT)
Date:   Fri, 23 Mar 2018 09:41:00 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        avarab@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3] routines to generate JSON data
Message-ID: <20180323164026.GC179915@aiede.svl.corp.google.com>
References: <20180323162952.81443-1-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323162952.81443-1-git@jeffhostetler.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git@jeffhostetler.com wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> This is version 3 of my JSON data format routines.
>
> This version addresses the variable name changes in [v2] and adds additional
> test cases.  I also changed the BUG() calls to die() to help with testing.

Can the information below go in the commit message?

Usually to avoid that kind of problem, I don't send a cover letter in
one-patch series.  Information that I don't want to make part of
permanent history (like the above) can go after the three-dash line to
ensure it doesn't go in the commit message.

Thanks,
Jonathan

> The json-writer routines can be used generate structured data in a JSON-like
> format.  I say "JSON-like" because we don't enforce the Unicode/UTF-8
> requirement [3,4] on string values.  This was discussed on the mailing list
> in the [v1] and [v2] threads, but to summarize here: Git doesn't know if
> various fields, such as Unix pathnames and author names, are Unicode or just
> 8-bit character data, so Git would not know how to properly encode such
> fields and the consumer of such output would not know these strings were
> encoded (once or twice).  So, until we have a pressing need to generate
> proper Unicode data, we avoid it for now.
>
> The initial use for the json-writer routines is for generating telemetry data
> for executed Git commands.  Later, we might want to use them in other commands
> such as status.
>
> [v1] https://public-inbox.org/git/20180316194057.77513-1-git@jeffhostetler.com/
> [v2] https://public-inbox.org/git/20180321192827.44330-1-git@jeffhostetler.com/
> [3]  http://www.ietf.org/rfc/rfc7159.txt
> [4]  http://json.org/
