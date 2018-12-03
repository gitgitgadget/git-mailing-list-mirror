Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ECCC211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 23:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbeLCXnB (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 18:43:01 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37987 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeLCXnB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 18:43:01 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so7189789pfi.5
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 15:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=biGN3K5k8LoqLz7cRGGvQzxDproDAYMOfKwz/uXKwkA=;
        b=d/st3TS5BWuLUKG8xaaFGx1CpP/VixOmPQBSj3OMTyQPEwzMHmtxkoefth4WnaCRum
         0ma9ctfyWaxDjiTar22lAxXCXMGga/R/OSWZPf5kLSqZgBpnqOSc8daB6kGH2jOMFBf8
         aF3AJfWkdZd3EX+Rdfq92Tkyk6jV7A4IxMIiw8XscN9uwBXYM6SAVnk5hxnqi6zg4vwg
         0nY8dSvKRONFUhN0s9EGxGCWr/N8yd943MPjHl8rb3SRo1Cm8SBEWtr1irCmjtGU2LIQ
         awlcfqQz78nelQb3ehDd6+5bjIEM0cJvF9WCb+Nq/ikfcElx4KHwmTBiI2bT1S6HQ6wP
         04tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=biGN3K5k8LoqLz7cRGGvQzxDproDAYMOfKwz/uXKwkA=;
        b=GOdurTck4oz0A78JFBSt4R85jZMjUTl00IFLGbJyDIMmHhynCPwf7yC/Y/63wxjcQ8
         3Nvde+nmZeAhmPHYUujbyN0hCTLKeE87huz9tGRnGoYyisArtvFG/4eUeFVmSuV3l7qY
         gPVGbWlRmF2f8NQ0ZIki+L4UHHDz9l+WZp3OxXWFrNpcjW6HI+ogUD24CwooCOXi2xFw
         A+0UgaL93skTmmBPS+pSaI8/XsMJ1jF3hbHSu3IF1FbeY25aLK3wqXrHa4NaTJn5TiGy
         cr2TBJkXMgbY5CtnJBVaaFJstLE5cRRdWGy3KUf8AO0mIu2kqBTBoPd9+J5KHYAutB/x
         QIzQ==
X-Gm-Message-State: AA+aEWasSR9WVEsXEbJ8Q4OvNUmDmjqz4mJdCnZ3+9RQUVbLqVeHK6JA
        UxxC4s8AJ8XvE8vTVTAWupjbxk3n
X-Google-Smtp-Source: AFSGD/V22q38rFB1L9W0BNIc6GPc1tjny0tOtgEkTxG8lU+mPu7S5+cUT+QEDrDF6+6EklPLPKPUYQ==
X-Received: by 2002:a62:ea09:: with SMTP id t9mr13505552pfh.228.1543880579931;
        Mon, 03 Dec 2018 15:42:59 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id 125sm22506521pfd.124.2018.12.03.15.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 15:42:59 -0800 (PST)
Date:   Mon, 3 Dec 2018 15:42:57 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] sideband: color lines with keyword only
Message-ID: <20181203234257.GC157301@google.com>
References: <20181203223713.158394-1-sbeller@google.com>
 <20181203232353.GA157301@google.com>
 <CAGZ79kY0w7Zt0Z4KNu7qL4Lz8fFpv2p51D-w_MgZBYPqPFbZKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kY0w7Zt0Z4KNu7qL4Lz8fFpv2p51D-w_MgZBYPqPFbZKw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
> On Mon, Dec 3, 2018 at 3:23 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

>> I was curious about what versions of Gerrit this is designed to
>> support (or in other words whether it's a bug fix or a feature).
>> Looking at examples like [1], it seems that Gerrit historically always
>> used "ERROR:" so the 59a255aef0 logic would work for it.  More
>> recently, [2] (ReceiveCommits: add a "SUCCESS" marker for successful
>> change updates, 2018-08-21) put SUCCESS on a line of its own.  That
>> puts this squarely in the new-feature category.
>
> Ooops. From the internal bug, I assumed this to be long standing Gerrit
> behavior, which is why I sent it out in -rc to begin with.

No worries.  Can't hurt for Junio to have a few patches to apply to
"pu" or "next" to practice using the release candidates. :)

[...]
>> In the old code, we would escape early if 'n == len', but we didn't
>> need to.  If 'n == len', then
>>
>>         src[len] == '\0'
>
> src[len] could also be one of "\n\r", see the caller
> recv_sideband for sidebase case 2.

Yes, I noticed too late[*].  Sorry for the noise.

The patch still looks good.

Jonathan

[*] https://public-inbox.org/git/20181203233439.GB157301@google.com/
