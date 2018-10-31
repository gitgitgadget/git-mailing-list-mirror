Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 177CF1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 14:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbeJaXAE (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 19:00:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38420 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbeJaXAE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 19:00:04 -0400
Received: by mail-qk1-f196.google.com with SMTP id p3-v6so9558404qkb.5
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/FEnh32gCTlPMKogAUvcS/Ht9nCksQ3e+0glbTfbQ9E=;
        b=qWZyi9eWNWdqVzwyamTdq+ySGXg5HUAc9qaT80APQBKImuTQzlD0wY0N8OuzSTiFt7
         +qw+ZKgeNiKLUBF7lk7vg+mkD3wdHfyVG8bKOhhXFymLYsLEl9oifaNggxkxWztDAolQ
         KPENwmZqWxlJp7Yl/Bxx0fl0sr85HnkoRMEiSHufZBHnc279frI8OEHnWM/Gxe949JTz
         MbqdhJ8uMaGoPR4I3OSazsqydmZ+QaV2b5b9IDhI8FZ+IcL14bPKJ6cXjfuB79Lo0URx
         i0My6GrOEKplMjtSfvKNEAqVxnAP49rVi8YQwm5T6oYV0fp8NzSserdgZjkFbWERdowd
         HQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/FEnh32gCTlPMKogAUvcS/Ht9nCksQ3e+0glbTfbQ9E=;
        b=cSnciRxrHISwoqSiyo9NXSl8/NvhyUMXyXHiF6dtRnawWHoskeXOcgKZthszvyBfQZ
         EffWgz/K3NlnBXDjJQbJhtd4hJcgaBCOSL/hHAWo5HzsfMANXEwzNuzMHcnZiNznP2ta
         nivi1elZxBUdI9XuiZsc/+T1X8Mhe3Dq+vCW4Z/ouxka9ktBaiS87eHY3OqIzQwdDNJ3
         3JOczHerM2DgqBdrPjJHY4Xa/EzwTiLCVKm+rts8Jai9fvmj/HP8MSL4Bkgek0IBQFQW
         abG/N4rMZOMs6qULiY98N8cJjhST5Bpxq2H2heBSfGWl/st9HtQuD1BcUq7n/ksOcss0
         nLiw==
X-Gm-Message-State: AGRZ1gLZwMISjol7WgEK49lKrzFYpoWqTXAWOU1bEU1NzcIPjgjqb7jW
        jLYH1CMPi7gQ+mh8tBp+qkE=
X-Google-Smtp-Source: AJdET5eNMDeUmByQ9WROHxkNkjI3ej6UcB5sOZ1dZQOuAnESJu+BQ7jMUv+F+1pcUZibStar+KkMGg==
X-Received: by 2002:aed:2461:: with SMTP id s30-v6mr2712991qtc.160.1540994513823;
        Wed, 31 Oct 2018 07:01:53 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:1547:f48:38e6:a522? ([2001:4898:8010:0:fe7c:f48:38e6:a522])
        by smtp.gmail.com with ESMTPSA id z31-v6sm20153705qth.67.2018.10.31.07.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 07:01:53 -0700 (PDT)
Subject: Re: [PATCH v3 2/8] t6036, t6042: testcases for rename collision of
 already conflicting files
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20181014020537.17991-1-newren@gmail.com>
 <20181019193111.12051-1-newren@gmail.com>
 <20181019193111.12051-3-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b14a0c79-5dce-a1dd-cd26-16e061154c43@gmail.com>
Date:   Wed, 31 Oct 2018 10:01:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181019193111.12051-3-newren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/19/2018 3:31 PM, Elijah Newren wrote:
> +test_expect_success "setup nested conflicts" '

nit: should these test names be single-quoted? I see you using double-quotes
in PATCH 1/8 as well, but that seems to be because there are variables in
the test names.


...
> +test_expect_failure "check nested conflicts" '

Same here.

> +test_expect_success "setup nested conflicts from rename/rename(2to1)" '

> +test_expect_failure "check nested conflicts from rename/rename(2to1)" '

Thanks,
-Stolee
