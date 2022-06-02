Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6612EC433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 12:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbiFBMZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 08:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiFBMZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 08:25:25 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220EBFD375
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 05:25:24 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id f35so3216642qtb.11
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 05:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=RNj5Ol7nLbB9WR4aEO9ptQJbTJXUQRqtDvSoVCR7PJY=;
        b=bc20e5RNgPIV2FDwRR8/55r4Cxr9f+mhoJzrD9npUABD/tLMwa5M+xVsSqxGKsXBJZ
         nbSU5Hry3pByeZLZhGSB6vgMdV2AFKmTwMkQfavzL3sYkmZjO4k4IbvE7JGRSXyxyKGC
         jh10qhAi9dqG1DGa+f6X8Ya28HDPfjHqfjMo11/A1hjhVmJqwPOM34c+7cCfISzL3shA
         h7kRLfMKSx9VxumUvg22w67NPiDz4sLqfwR7NfdDcQQ//dL7quVATdTBg3/vvKFDFhPo
         syfZi+wsKLph4OAXGoAWNGHzQrL0BbODqi2NEIMcZ8bzPEZRp+cPCfHFrZPM+sBMkvZF
         PrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RNj5Ol7nLbB9WR4aEO9ptQJbTJXUQRqtDvSoVCR7PJY=;
        b=EX0iO2anMlTHVjWvA9oyO7vDpr9Rvp+5748+Bq2i2wpc1/29VFV6OSDxrXhkMpE3z1
         /8mVTGNGPIpG3FgJO6fuIi3VY2AMzILQEGvyYcsG13csq2Mn5DPpadbDBAo+wA6GeT3j
         iuxKBV1r84gl8nK9/4WKE9ltLtIF5i1r0NwCvDNLtPnNkxkL1PoALb1zI0cKFWQIiAMB
         u9itxu+314mcLqoLhmyc39Wef9P2f+cz1J25QRtIKLg1HcUMzudm0n0gk8LmAxnFQcmC
         B1SdjuzY8lM4i7VovOg1Jp9iR5d+S92Dr9GS4i9QNZY1VtxwFG+QpdyEY6KL1J9AAFuY
         zZDA==
X-Gm-Message-State: AOAM5329IRTSVTbWgDpkJ22ATT8oTcDuFQTIh1xybdq8eL1QyMKZfgn1
        BYEX4qUiPExth+kC/CkVyO88
X-Google-Smtp-Source: ABdhPJypPpuSRvWbGsNoxcPLyB4ORAazjEXxtWJGg09296VK7CMSrx6bmIsQztZW3nQH3Xnlsn1k9w==
X-Received: by 2002:a05:622a:50a:b0:304:d2e9:c197 with SMTP id l10-20020a05622a050a00b00304d2e9c197mr1604673qtx.141.1654172723256;
        Thu, 02 Jun 2022 05:25:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9cc9:fda3:3ddf:6700? ([2600:1700:e72:80a0:9cc9:fda3:3ddf:6700])
        by smtp.gmail.com with ESMTPSA id v186-20020a3793c3000000b0069fc13ce1f3sm2979082qkd.36.2022.06.02.05.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 05:25:22 -0700 (PDT)
Message-ID: <383beb65-d507-18f2-24e4-f4bf23e7d99e@github.com>
Date:   Thu, 2 Jun 2022 08:25:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: What's cooking in git.git (Jun 2022, #01; Wed, 1)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqee07q3xc.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqee07q3xc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/2022 8:55 PM, Junio C Hamano wrote:

> * ds/bundle-uri-more (2022-05-20) 24 commits
>  . t5601: basic bundle URI tests
>  . clone: unbundle the advertised bundles
>  . bundle-uri: download bundles from an advertised list
>  . bundle-uri: allow relative URLs in bundle lists
>  . bundle-uri client: add boolean transfer.bundleURI setting
>  . bundle-uri: serve URI advertisement from bundle.* config
>  . bundle-uri client: add "git ls-remote-bundle-uri"
>  . bundle-uri client: add minimal NOOP client
>  . protocol v2: add server-side "bundle-uri" skeleton
>  . bundle-uri: fetch a list of bundles
>  . bundle-uri: parse bundle list in config format
>  . bundle-uri: limit recursion depth for bundle lists
>  . bundle-uri: unit test "key=value" parsing
>  . bundle-uri: create "key=value" line parsing
>  . bundle-uri: create base key-value pair parsing
>  . bundle-uri: create bundle_list struct and helpers
>  . clone: --bundle-uri cannot be combined with --depth
>  . clone: add --bundle-uri option
>  . fetch: add 'refs/bundle/' to log.excludeDecoration
>  . fetch: add --bundle-uri option
>  . bundle-uri: add support for http(s):// and file://
>  . bundle-uri: create basic file-copy logic
>  . remote-curl: add 'get' capability
>  . docs: document bundle URI standard
>  (this branch uses ds/bundle-uri.)
> 
>  RFC/ seems to trigger errors in linux-leaks CI job
>  source: <pull.1234.git.1653072042.gitgitgadget@gmail.com>

I'm not surprised about failing the linux-leaks job, but I'm
sorry that it is causing noise. Please eject from 'seen' to
reduce the noise here.

I also haven't had any feedback on this RFC series, so I plan
to break out the first few patches and clean them up for full
submission soon. I've seen more feedback on topics that might
be candidates for merging.

Thanks,
-Stolee
