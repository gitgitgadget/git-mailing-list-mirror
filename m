Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 761EC1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 21:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeBHVgX (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 16:36:23 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41155 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752159AbeBHVgW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 16:36:22 -0500
Received: by mail-qk0-f196.google.com with SMTP id p23so7535776qke.8
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 13:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pNqYHxgXETV4e7iRHmqHnZ3kGsQXjaAJva61vy2A5UM=;
        b=BjhL7P6wPOdLQOqPoILcYPCVgH1qO4sbXPcTGAjtwrfembBE6ZHLn6Aq5tRAKgxTCh
         u+0nzG0YM+Kyho+r41gOUUaWZ2jKuPSn6SB6TmSh2qU/+kDDnQraDzJb0qzCNP+QHaH3
         qeSEMSZb0AI3xj+3E+2qlNJH8GvR470Rth61eZwTqx0wMcSA36yL1/DebqBjFoA3Vbrp
         G5nx3knoa1YtirOLIyCG1N0OVey5mg1sT5yKhZCQW9JIGfpq2K93EcZeE+HJeJdSiW57
         d3I9af/10T+GeO/WPbIpNrqps6trFlqvvgiOPc3WGvZw/LuJKNSjdZa4e771emUvGTuP
         TLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pNqYHxgXETV4e7iRHmqHnZ3kGsQXjaAJva61vy2A5UM=;
        b=Byf9J6SSPtovv8ekaqFUoeVFAFg3aoHjd5GRSIo2L59VUrF3uupYL10NVVfRP7zopC
         HZfOUhHN87oU1+76uupJxpMxtTKI33jWK71JDI6iFlmnuXfirYeYx/W5aVtWwlQiq1Tj
         Yr7DZfrrkSi2mbCepFQE8ByYwj/Vl0hg1kgvkpp+vBYE6s5AGm3dMcsQ4YyyXpVZ0IQp
         zr88m0smr0D2ll0TDTo0GIvUQDfq8lv9+q4RqhuMVRWBhoVIeiiVWWr5vbM8dbt8XOrY
         rAfigVdGdvsl2vznlf9fckGLubQm3rF4pf/iHBH7TZB6SVwnhI7SAPwZPEzv0XF5tTks
         F/gA==
X-Gm-Message-State: APf1xPDK3r+IDal/kJK2HpSpXlCovbbbpH2A9buaITPDBAgz+Wed5Q05
        Awh+jenXZP4S06dBJ2NJ4Yo=
X-Google-Smtp-Source: AH8x2248EmdAnu2vuB1Z4FiPP9GgtiSMMek4RYfBfxt0MRnvjGlVAJQrhuWys2w91HFdwi+wPKfhMQ==
X-Received: by 10.55.41.12 with SMTP id p12mr212415qkh.136.1518125781852;
        Thu, 08 Feb 2018 13:36:21 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id m82sm605087qki.81.2018.02.08.13.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2018 13:36:21 -0800 (PST)
Subject: Re: [PATCH v3 03/14] commit-graph: create git-commit-graph builtin
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
 <1518122258-157281-4-git-send-email-dstolee@microsoft.com>
 <xmqqzi4jp3y5.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9c473af6-fc67-5612-07dd-54b2a6e24ff0@gmail.com>
Date:   Thu, 8 Feb 2018 16:36:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqzi4jp3y5.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/8/2018 4:27 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> Teach git the 'commit-graph' builtin that will be used for writing and
>> reading packed graph files. The current implementation is mostly
>> empty, except for a '--pack-dir' option.
> Why do we want to use "pack" dir, when this is specifically designed
> not tied to packfile?  .git/objects/pack/ certainly is a possibility
> in the sense that anywhere inside .git/objects/ would make sense,
> but using the "pack" dir smells like signalling a wrong message to
> users.
>

I wanted to have the smallest footprint as possible in the objects 
directory, and the .git/objects directory currently only holds folders.

I suppose this feature, along with the multi-pack-index (MIDX), extends 
the concept of the pack directory to be a "compressed data" directory, 
but keeps the "pack" name to be compatible with earlier versions.

Another option is to create a .git/objects/graph directory instead, but 
then we need to worry about that directory being present.

Thanks,
-Stolee
