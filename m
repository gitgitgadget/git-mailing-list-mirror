Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C9C20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 13:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751113AbdFANdb (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 09:33:31 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34906 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbdFANda (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 09:33:30 -0400
Received: by mail-qt0-f196.google.com with SMTP id r58so5664371qtb.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 06:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2LxUFAa7Wk5FsXILfSICEsbT0PiXB8Et8hUVtoo/X0k=;
        b=pZq8oBe+1N6iVBhIG6Wkhpu+0FHwW2WRFXatVXyJa4PW6H3r2v582x4RYr0/3bd/k5
         RzEuYuiW0i3A5/x7OhhKtKFabxuYUzdMvZzrkgsm8ABmPhpdr/tiokZY1y8rqAgP68AV
         DXv7TnOQ6QLn/ALaZ5KnLSWFAs2LitwdXq2DTTR92jYUpSw9l/ranerUpFT92U8Nqy8y
         9UDgYxO0DhPtXkGvO/gz8ZI1Rtsuy6Ndsw8SPWXp17zASVfd9X37BC9/nHaPP7p4bg2n
         39sy5a78ai0KlHQ8dLGs5oQSVnol90EftLfe6vLy+FE8fpMX8yGDFKbbZny1eLwgG4Tw
         i4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2LxUFAa7Wk5FsXILfSICEsbT0PiXB8Et8hUVtoo/X0k=;
        b=kXY0nQ4+SYGB7myWuPFthswWwsUIfkFYMyTSNkZTDmIJ7/88GD/1SXNVN8iqBKk0GX
         e4OhwwidOyghYZyh31F9PkIzqGMA+fNEuKonF4l3PsddJAyYpBPvApAtlGzCfalsPioX
         NOqA3hI50xN0urXS8LRYNNsi4ykNL/Gk2qU3u6qeRPDi3DtRsKMJdN1KffpLVrLQRlGs
         6EZIDI0lu90JvXCWWH0CZq8DhKIrnsBbzEHtb9e7fhiz2GEzjHgHJeRQjUX3cRvor0B5
         +dDuGwzBKr7Kulw+oh+zpJJ1xXF2BFi45adNdjnRDNqrng37hVFti/+eOXXThVTOxcO/
         ACug==
X-Gm-Message-State: AODbwcBcLIkw0eS4yaq+9s1T25YHiweRgDfv59DQ2kSA3bm+LygAh8s4
        e45Hl6V8AKUyjuUDz/Y=
X-Received: by 10.237.62.115 with SMTP id m48mr1743025qtf.179.1496324009182;
        Thu, 01 Jun 2017 06:33:29 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id i51sm12939484qte.28.2017.06.01.06.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 06:33:28 -0700 (PDT)
Subject: Re: RFC: Would a config fetch.retryCount make sense?
To:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <6762A30E-C558-4085-943B-AB85EBF18706@gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <cf8ce12b-8d5a-ae03-efd8-0f82ea40fce7@gmail.com>
Date:   Thu, 1 Jun 2017 09:33:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <6762A30E-C558-4085-943B-AB85EBF18706@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/1/2017 8:48 AM, Lars Schneider wrote:
> Hi,
> 
> we occasionally see "The remote end hung up unexpectedly" (pkt-line.c:265)
> on our `git fetch` calls (most noticeably in our automations). I expect
> random network glitches to be the cause.
> 
> In some places we added a basic retry mechanism and I was wondering
> if this could be a useful feature for Git itself.
> 

Having a configurable retry mechanism makes sense especially if it 
allows continuing an in-progress download rather than aborting and 
trying over.  I would make it off by default so that any existing higher 
level retry mechanism doesn't trigger a retry storm if the problem isn't 
a transient network glitch.

Internally we use a tool 
(https://github.com/Microsoft/GVFS/tree/master/GVFS/FastFetch) to 
perform fetch for our build machines.  It has several advantages 
including retries when downloading pack files.

It's biggest advantage is that it uses multiple threads to parallelize 
the entire fetch and checkout operation from end to end (ie the download 
happens in parallel as well as checkout happening in parallel with the 
download) which makes it take a fraction of the overall time.

When time permits, I hope to bring some of these enhancements over into 
git itself.

> E.g. a Git config such as "fetch.retryCount" or something.
> Or is there something like this in Git already and I missed it?
> 
> Thanks,
> Lars
> 
