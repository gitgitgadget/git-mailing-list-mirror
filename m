Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C14D1F461
	for <e@80x24.org>; Sat, 29 Jun 2019 01:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfF2BnI (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 21:43:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41192 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfF2BnI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 21:43:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so8475575qtj.8
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 18:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Z64Jq4e6L5+kfXBUPK8t4Gy91gFNNiNCsokFQw3ZIU=;
        b=RkeK9ppDwexVysoaCxfg+372vu0fTT1PbuMi6mUm5sonPbG9ysTzhHoR0LaHhq+Jgk
         RdnTo9emz4Y86PyuV0BQSlDN9SDbol1/vF33Nx5xgXVcU2Ji6crh93ZeNbE4pkeDdU0J
         em9Rwmm38dxp6bBJIwB8V+eU4hT9mUkI/ZdbSPptBgg+Ikc2dV3dJGzwWr4N02V+Jo2F
         VRSB1R2tGCPbJyJlJZkWUzfJ0VgLFXp9iDey9slcpuULjcs7nc9wTT1PzCVLOv6yoKv2
         gb/5U2b2+8XjWgqqwmredifmEInVOcNfDZtc7yqSHSu+vfO0Ix2PtdkpTd7Am2xDlNNL
         tzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Z64Jq4e6L5+kfXBUPK8t4Gy91gFNNiNCsokFQw3ZIU=;
        b=WIrD6F4QbvSD1RmNclHFXFPOHYzP9z5nA3dWOtJV9WMuMqVfiNYj8nVEio9dAbBfcb
         /5+mgu/6W3dvyRJ7FhnWSRitCAwqBwV1Y+zSK4BXpoynczskMvtVlN23fkOyGOiyzox1
         7CeB3AzSuYJt8VmcH8fSeopbeMjMBeMvgojWZNrE5eXfr+pozJqcQYZVnugn43iKi3Fe
         NPnlaILPTs6YPHRckhZKFTNF+gwju8BJ2ttWwDt1ERBANjL9Jrftb8ISqGe02tLee19T
         qGVag4n3fCjBJmmfSg1Kh6ycGcf7gzncbsdWbfpZpgmbLlcIauNtdJVCeKZmZf86k8dj
         6GDA==
X-Gm-Message-State: APjAAAV47ZzwsLuITJjMt3w9f5uZESoHMFiDfzEAFR+qZMRDTs7tZaOa
        wn65jcJZwpSdUH8lXcw7hXA=
X-Google-Smtp-Source: APXvYqzOwTMQPf80/M2LkQKFhvu0cUuSMafRniwheMRPwh9Hb+rfdtneywBB/+oo4/HdihIkJNaPtA==
X-Received: by 2002:ac8:264a:: with SMTP id v10mr10513172qtv.255.1561772587067;
        Fri, 28 Jun 2019 18:43:07 -0700 (PDT)
Received: from [10.0.1.15] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id l4sm1733073qtd.25.2019.06.28.18.43.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 18:43:06 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] repo-settings: create core.featureAdoptionRate
 setting
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.254.git.gitgitgadget@gmail.com>
 <pull.254.v2.git.gitgitgadget@gmail.com>
 <bdaee3ea9df0533c268d6bebbd252c00cfbaccd6.1560957119.git.gitgitgadget@gmail.com>
 <xmqq8stl8k09.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e684ad41-ca93-bad5-cf39-9dcf578a04ae@gmail.com>
Date:   Fri, 28 Jun 2019 21:43:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <xmqq8stl8k09.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2019 5:42 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +struct repo_settings {
>> +	char core_commit_graph;
>> +	char gc_write_commit_graph;
>> +};
> 
> I do not see a particular reason to favor type "char" here. "char"
> is wider than e.g. "signed int :2", if you wanted to save space
> compared to a more obvious and naive type, e.g. "int".  More
> importantly, the language does not guarantee signedness of "char",
> so the sentinel value of "-1" is a bit tricky to use, as you have to
> be prepared to see your code used on an "unsigned char" platform.

I was unaware that platforms could change the signedness of "char".
Thanks for guarding against it.

You're right that it probably isn't worth saving space here, as these
values are replacing existing globals somewhere anyway. If we start
worrying about these being present for each of thousands of submodules
then we probably have bigger problems.

> Use of "signed char" would be OK, but this is a singleton instance
> per repository, so I am not sure how much it matters to save a few
> words here by not using the most natural "int" type.

I'll use 'int' in v2.

Thanks,
-Stolee
