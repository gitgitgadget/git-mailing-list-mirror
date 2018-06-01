Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28D41F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 17:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeFARQR (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 13:16:17 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36248 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751792AbeFARQM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 13:16:12 -0400
Received: by mail-qt0-f170.google.com with SMTP id q6-v6so33039795qtn.3
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 10:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=m3lpGN8hmsvV5ovxWaKmslLqUVJlOAX7QXuQBG1xA08=;
        b=MLjhw30y6xk9IXvYniXES0CCAwxZV4sWCJepgPV6S+O/Q8GpaeJ9HZTZb1ON7LnfcR
         8UbIrSnd94NoPapoe5B5MKmFv12Yx2WeGje/4weYxqwP3UGBS1X++lYwrrQK1KjXKZRM
         DPuvrJxRNyQ0OHdqrZAzqZVmLo+QmyRLPg/2tbOEWX69q0RSEjF3CIpdN3iv/fwuDixO
         9yM2hOyy6/V5eXIKvwEZm2GcR3px/+HbBkmnWzwHb6Pr5MPUmcmQagYYzm5cDWjHMpxR
         WjphgLBVQhtuu86THbqG7Oma57EoucnhNC/9gdeQB2yaWXEVnYSpLpr5Yzmsan4l4uVo
         /Fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=m3lpGN8hmsvV5ovxWaKmslLqUVJlOAX7QXuQBG1xA08=;
        b=GqYJwFgDg1FOvEhFakzJha1MURdNI8OIKQdcIeUbnYBCGofZPVfj/Jw1yypFg0gzuK
         JKrub6PWgNzY79ApYpcvSi1Vvmze6MusE5eRQ881ISUSS8uZLBLWjX+qRifREwWNvqXU
         ISRQnEIvmMuEux6WSZtT9BPEREAhlmVKA1CNyNugLC5uxC0k0nrRWMIxJDk4snyxNr5g
         QDlAknYYcVIgl9IWr00EwhUVpriZK7RxTIE4E/bXJhEac6V1AI9g2S5hxeyjjWzyt4P8
         PMEb0pmVqSakD32c1JLMDUaR5E5HiGX7cBLOpepWv8s/O3iLzFxCS1n94V2wZaGLiyuW
         OU5w==
X-Gm-Message-State: APt69E2cy9u+MFfihSzV8pdtAcEZ5y3xykzw8QMdvGTRKiguZbpOr+MD
        Mjx3hH9W5hAqkq+9mtGHLvO7fDlP
X-Google-Smtp-Source: ADUXVKKDBLRFdlGCcHll516b0DH692MLZc5ql8CHk0Qq0HOq/ieENTl7IANcy0SQ3O/Z+rPk84+ajw==
X-Received: by 2002:ac8:308c:: with SMTP id v12-v6mr8059275qta.233.1527873371143;
        Fri, 01 Jun 2018 10:16:11 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d9c1:ef62:cbbf:29be? ([2001:4898:8010:0:c2f7:ef62:cbbf:29be])
        by smtp.gmail.com with ESMTPSA id b14-v6sm2386747qtp.26.2018.06.01.10.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 10:16:10 -0700 (PDT)
Subject: Re: t5318-commit-graph.sh breaks travis gettext poison job
To:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CACsJy8CRgkyjcpK3FPaF7mrAuEFjGOShNjBZgjgrshg365T3Rw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e3181d02-34cc-fbfb-367b-1d9172930c10@gmail.com>
Date:   Fri, 1 Jun 2018 13:16:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CRgkyjcpK3FPaF7mrAuEFjGOShNjBZgjgrshg365T3Rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/2018 12:17 PM, Duy Nguyen wrote:
> In case you're not checking travis, [1] reports
>
> Test Summary Report
> -------------------
> t5318-commit-graph.sh                            (Wstat: 256 Tests: 62
> Failed: 2)
>    Failed tests:  61-62
>    Non-zero exit status: 1
>
> This usually means you're grepping an i18n string
>
> [1] https://travis-ci.org/git/git/jobs/386532326
>

Thanks, Duy. I believe this is related to the place Szeder pointed out 
[1] with the one translatable string in verify_commit_graph().

I've fixed this in my local branch, and plan to push v4 when review of 
v3 is complete.

Thanks,
-Stolee

[1] 
https://public-inbox.org/git/20180530123529.32090-1-szeder.dev@gmail.com/
     Re: [PATCH v3 16/20] commit-graph: verify contents match checksum
