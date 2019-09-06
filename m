Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B7361F461
	for <e@80x24.org>; Fri,  6 Sep 2019 17:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395104AbfIFRAp (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 13:00:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46319 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfIFRAp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 13:00:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so4879379pfg.13
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 10:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ynNb3ynu/mQP6ipc9KEq3UZbjUaoERuWCZpXiFxzOj0=;
        b=ULGp9LintBhyeEsMNJjCvCfaL2nL7YMOh8lEIp+GDZn7WLt0NxKb7ZSEImSIQHf9/g
         bvf+XDHSjoUC8VTUa8wDq7DYxqbzFNs6tCJ2pF6ALt3Wxnfy4D1J3PtRdBy/I2ro/2gG
         jgjSG+pAh3s3GLt5VhgeMDdS19ANClD56GWcc4T3+RA7NAT+0axDGmetZnnFGLWJ8npC
         6UZ1H5ZqsgT6im0UtTqeh5tpTkK9oSYVcsFaymZBYEFtFF0pr4DGRe1weye4nkzxx/TG
         XJfFxt/flpZVs7tetu+9lumEfHKjRetmUuCzgbcdMpTrpLpf+EX5tTBCEEhW94g5RsUo
         2ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ynNb3ynu/mQP6ipc9KEq3UZbjUaoERuWCZpXiFxzOj0=;
        b=gep2ETSvLRpRdteh2ZCAyn05MabCBingnmzWpEK17EjU/4ny/Ycd9pFS2XCuKW2AJ4
         4G2mWxJy5sGPNlxxl9ueyQe282pgxOmEm16gijbGlWMM4aMAoNjZ1PskNSB4CraOTUvl
         zfUyyZvXceoqYm2i1/sGbKWfSejbTczI0bKo7JEABXDFdRJqSxqkKvhR7a1I9idbJKLs
         SrBE2BZ+es3q+brIIa3kCPvdkl2Nv0zb72thXqwKvOz2SP1Oa/ogcZgzaJPwhDZ7Ppn1
         DNekTvZsXDEBoFqO+W1ViM1dArQRcSYfIkRN51zPwtgC5lCRnTAiKVba80bFcg3JVNf6
         yirQ==
X-Gm-Message-State: APjAAAUh/mMbyAjVNGyX8Ec7l4kyJm8knhoRvGS5aIZucz8DIDgUCZMF
        erxEFEXNNWouGmxBMMvMB1Y=
X-Google-Smtp-Source: APXvYqzRGfcEyFD/4mwIugEGcemKCvdq3zNvXUU+Jd1HWspEKVNDcEnqRGWJRiuNEmIJzQjFXilWwA==
X-Received: by 2002:a62:2603:: with SMTP id m3mr12235197pfm.163.1567789244055;
        Fri, 06 Sep 2019 10:00:44 -0700 (PDT)
Received: from ?IPv6:2603:3023:803:400:4c28:4024:4b1c:1fde? ([2603:3023:803:400:4c28:4024:4b1c:1fde])
        by smtp.gmail.com with ESMTPSA id s18sm8784384pfh.0.2019.09.06.10.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 10:00:43 -0700 (PDT)
Subject: Re: [PATCH 1/1] fetch: add fetch.writeCommitGraph config setting
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.328.git.gitgitgadget@gmail.com>
 <49f877c85ca2be5bb76d9082ee4aa26e26111a14.1567477320.git.gitgitgadget@gmail.com>
 <20190904030829.GB28836@sigill.intra.peff.net>
 <xmqqa7bipjil.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a697c4de-e269-c330-ece2-8ac7007e6c55@gmail.com>
Date:   Fri, 6 Sep 2019 13:00:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <xmqqa7bipjil.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/5/2019 4:37 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> Do we want to to have fetch.writeCommitGraph, receive.writeCommitGraph,
>> and then a master transfer.writeCommitGraph?
> 
> If anything, it may be good for consistency.
> 
> I am not sure if it is a good idea to trigger writing the commit
> graph when accepting a push, though.  It tends to be a lot finer
> grained than fetching, right?

And I expect a push to include many fewer commits than a fetch.
In a server environment, I would expect to have a separate
maintenance task responsible for updating the commit-graph after
receiving new data, but not in an in-line fashion with the push.

Think about the situation of many pushes that happen in a short
burst: one write after all of the pushes would have close to the
same performance benefits as writing with every push, but does
a lot less work.

Thanks,
-Stolee
