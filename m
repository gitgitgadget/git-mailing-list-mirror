Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33F8C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350141AbiHSSoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349974AbiHSSoo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:44:44 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBD2C2E91
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:44:44 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id q74so3941210iod.9
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 11:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=beViF7KWSrvaXdJraevzlVth2Xsuj+0pEfidyhs8RPA=;
        b=QqCNV6TpMWPoVgc39E99XSZkw+W1z1HEunPLQW/Z5kQCwwb71vg03AIgSYoAKACmv3
         Fqxww5E+nAlWijImBBcvVQds1c2GfqMeZ8+yIGJDtA2wgH73BqVzwPMElGfExLC04ako
         1TkM0a1eLDjD7Ys254dD6DwBpfUSLowebhBKr0V0hPXEYmPSae0rd8IcuZ2KAM9Gj5VI
         G5+NLTML2D35vi0mid1gvQEzCKOajbughNgr4J9AJzrWTFVbEk27nB5qZQ5ODxlKWQNS
         JJg9izwywR8XFkzPqKz/nY5FyoXKRTPxQKxm3SkqHgax+1XMf8LDXxGQZuNQCegmgXkU
         jatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=beViF7KWSrvaXdJraevzlVth2Xsuj+0pEfidyhs8RPA=;
        b=ypbxxjJ1VntSwXvW3QpzyK1SElDCGk1zuXP9SkIH7tJKu0gjNY9e58ST3k1JLaeeih
         bZqcieeRVIBC2YBulWfKFj1ntkXeukuWA1EOWnoMfYUIDapPpb3MQcpRxhnOZH37OuNS
         qttcct9posAEuXrXwnZC5APRD2DKWKwvIZJdM5gdZNj5raVYXWqpoH4hcFHH1k7h/Cxl
         4jltM26DbRaR0M3ztEWNQQ5yurPpEzH5Qtz9uVSoEzdbE368SS0r44jC0j+PMtGm4qt+
         HKregpSkmoEgEvCd23k5S9HzHGHoqxIinTyMVcRypC9P1Vamwzl7YKsOehb9fLqHrCZD
         1EFQ==
X-Gm-Message-State: ACgBeo0SnzaOdxVsBS04WbBkdy9hZL29mwJO6XvmxRseB47gByI9XtTr
        Y42uViJpmqzB2hhcv1y/qSFF
X-Google-Smtp-Source: AA6agR5VH0GOM4lCe3U8g4g7+q6kunK2D+GuhRtEpeWZcp9ysrY9z3gfN/cPrcChc2G1cvmrFcUiNQ==
X-Received: by 2002:a05:6638:3015:b0:341:de68:602c with SMTP id r21-20020a056638301500b00341de68602cmr4075196jak.10.1660934683384;
        Fri, 19 Aug 2022 11:44:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:55ca:650:1968:6180? ([2600:1700:e72:80a0:55ca:650:1968:6180])
        by smtp.gmail.com with ESMTPSA id z5-20020a056602080500b00689007ec164sm2445312iow.48.2022.08.19.11.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 11:44:43 -0700 (PDT)
Message-ID: <3120a57c-3600-c583-7dd3-c13e2e4cdc52@github.com>
Date:   Fri, 19 Aug 2022 14:44:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 6/8] scalar: enable built-in FSMonitor on `register`
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Victoria Dye <vdye@github.com>
References: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
 <pull.1324.v3.git.1660858853.gitgitgadget@gmail.com>
 <fb379fd2097b1e4b18428d791b9bcd48571d7b73.1660858853.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <fb379fd2097b1e4b18428d791b9bcd48571d7b73.1660858853.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2022 5:40 PM, Matthew John Cheetham via GitGitGadget wrote:
> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
> Using the built-in FSMonitor makes many common commands quite a bit
> faster. So let's teach the `scalar register` command to enable the
> built-in FSMonitor and kick-start the fsmonitor--daemon process (for
> convenience).

> +static int have_fsmonitor_support(void)
> +{
> +	return fsmonitor_ipc__is_supported() &&
> +	       fsm_settings__get_reason(the_repository) == FSMONITOR_REASON_OK;
> +}

The only thing I needed to check was that the_repository was initialized
properly as part of 'scalar clone' and it indeed is.

Thanks,
-Stolee

