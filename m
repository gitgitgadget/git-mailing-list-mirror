Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 157F82022A
	for <e@80x24.org>; Sat,  5 Nov 2016 02:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751095AbcKECed (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 22:34:33 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34255 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbcKECec (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 22:34:32 -0400
Received: by mail-pf0-f169.google.com with SMTP id n85so61039424pfi.1
        for <git@vger.kernel.org>; Fri, 04 Nov 2016 19:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=AIEFKx3ReK3SdwFltfbVoZV5Ooru3FNed+DjbdO6jGo=;
        b=YvdKKVvj9wuBOccWl4ExTzcBpOpCi1Z3Nm6/HZ5TO9nCgFPyYDlBVoKieD4Jdwom57
         FxZi0vDSwjSomf8qn/e2y7EWrZcrffZ3nkFwVylGJEHyNaIn1eWcUTCrR9KLRtjtvRIU
         UTTP0ba/XAAi5otABh0EaoqqhTPh15p63RlWBkf163z9IwhONFO3JLtT4NroecMlEIR3
         VLDkWBfnJmpKV6JlOlxvlHbxW6AhxqMf3M3F7Awr+zGh7BM4TKTe4m3ead7RM/fIZsuW
         xZcxU8zLlk0yNkrx5uZ6XPiyKdH4iyqGW9p94o/dqxGz+wFKZK/P7iviqjO+CQ9mkuB9
         pOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=AIEFKx3ReK3SdwFltfbVoZV5Ooru3FNed+DjbdO6jGo=;
        b=H6XHW/ttU5fygQP6zHQxIHIfKUCRc9r1IJaAfQDbgT9mC76fHq3CAqPGCpUKwzAh7U
         Xpvsa6UdSZ1hGpBbEDvb0YCrsgpnL6oS9ZjNl095uIFOQdfwioEXgg7tznhSfXX9EwgR
         ppCxmCBbpRdyEDlAElSSB9GddQMmF713QNkICb0Wtyypco3Z3igFV42MK2LiEWkLhh5B
         u4sLAEQDvgc65xuhI/Z3JhYa/UfmI4DCEh5+hqnhGBsIkNJ1VmWPSvFHIpOtpGj98Y/x
         ZYS6w9hL/NiS9PCeTGGjKaNHwIP2O2It7EsOv1FAiUqfYKScLsGVJOy70OG33xZGgNZv
         OYFQ==
X-Gm-Message-State: ABUngvfUtxjfQ2b7DEmCT0JB9buLokzWuQ1V+4+SpvItdD6cHgNsnnKj8g1+Wif9ioo8ATw5
X-Received: by 10.99.125.77 with SMTP id m13mr26239980pgn.58.1478313271201;
        Fri, 04 Nov 2016 19:34:31 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:7490:9b59:ecd5:8fe2])
        by smtp.gmail.com with ESMTPSA id dj2sm7758770pad.19.2016.11.04.19.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Nov 2016 19:34:29 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] submodules: add helper functions to determine
 presence of submodules
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com
References: <20161027223834.35312-1-bmwill@google.com>
 <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1477953496-103596-2-git-send-email-bmwill@google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <313ffcf0-b75d-425d-050a-1eaa2f850f1e@google.com>
Date:   Fri, 4 Nov 2016 19:34:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1477953496-103596-2-git-send-email-bmwill@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/31/2016 03:38 PM, Brandon Williams wrote:
> +		struct strbuf buf = STRBUF_INIT;
> +		char *submodule_url = NULL;
> +
> +		strbuf_addf(&buf, "submodule.%s.url", module->name);
> +		ret = !git_config_get_string(buf.buf, &submodule_url);
> +
> +		free(submodule_url);
> +		strbuf_release(&buf);
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Determine if a submodule has been checked out at a given 'path'
> + */
> +int is_submodule_checked_out(const char *path)
> +{
> +	int ret = 0;
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	strbuf_addf(&buf, "%s/.git", path);
> +	ret = file_exists(buf.buf);
> +
> +	strbuf_release(&buf);

In this and the previous function, you can use xstrfmt.
