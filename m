Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7B9C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 13:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiGVNSh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 09:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVNSf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 09:18:35 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BBD9F07E
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 06:18:31 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id j70so5549051oih.10
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=pVoJ90L4TMIuiVRcz94G8FWVUcX8saF5y7uDJd7N9G4=;
        b=W1rEryFnQVh5ioZKBAAh9OlNorn9wG4/Ug0UNKxcop4oAE3dezV9D48j+JvqYX82KL
         FX5EqizGdVFFnknMWmZ2aTrCGJZS0tPd1Xs9Ye1/lIFukVLVN1vX+vdFIv/U4BcUhXOU
         S0ZMIauocYip1BISC7E3o13vpyb+WSNlBga604z9Ay0xIt8UfQspT22EB4D0o/od7zzq
         a3avFPWK60dpFxzM/kas745ILLyek8Vg3ETsHwWmu2gsy0vbcTn/8v/RDmoBKsGLrl5Y
         +HLhbR/1/3ympe4LOwHoJwMf0IZY3ceB6FcuSzV3hHo+A2CNc79BqmVp8qLdpdlzgY/a
         tAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pVoJ90L4TMIuiVRcz94G8FWVUcX8saF5y7uDJd7N9G4=;
        b=wrEab2+mA6rCVOHOQcEdtozFG53rcSUl2/hdHhEh/PpnOlmuhV1X8V3Hz56M0+n4HG
         KfG2AeebxTMRrdDazOUBw5Ys3v6k3FGRhcVCaWjFP856canRN8bEhmWwotVPKK7+28OQ
         GhARx6bz8v3vFxP7yF+bX6CH82CmoYn5hLV59hwQDo8mINukieLvKFRztXKZIs2xd3db
         kFb++Pv7On4uMgB+gZgOQkk79V2zLm5b3E4QPPyQfqX2rPWKONXyFAFiaemLmvcQ2SOT
         wshlL0IFfQMN0zlzdU5lrbkmiUpJE25hw5Sk+thC8uOhCCweUQ1bWe24SBYTC1ZVddAB
         IpQw==
X-Gm-Message-State: AJIora/KClw2G9GQUZ7oFA3TThcHWI0iGO8LH4br1Cq3/y4GxY86jk0r
        2YPwMMEJCZtle57XwnRm15NsDY/s6Tfp
X-Google-Smtp-Source: AGRyM1ukymoHlJQwQ40nZ0ke65PNkpwoE+v26/MJJ8qFUZzY/wxmw1SfePHKHfie9lVbao+r0gsE9g==
X-Received: by 2002:aca:1003:0:b0:33a:84ce:f366 with SMTP id 3-20020aca1003000000b0033a84cef366mr138242oiq.117.1658495909357;
        Fri, 22 Jul 2022 06:18:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:89e1:7440:c819:d192? ([2600:1700:e72:80a0:89e1:7440:c819:d192])
        by smtp.gmail.com with ESMTPSA id w19-20020a056830111300b0061c514a3b7bsm1952454otq.10.2022.07.22.06.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 06:18:28 -0700 (PDT)
Message-ID: <ea70aea1-139e-ab92-6dfb-b9442e915383@github.com>
Date:   Fri, 22 Jul 2022 09:18:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/6] bundle-uri: create basic file-copy logic
Content-Language: en-US
To:     Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
 <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
 <abec47564fd9cea5ef9d8f112e90368681a4e066.1656535245.git.gitgitgadget@gmail.com>
 <YtnJEm1N5IQ/y3mj@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YtnJEm1N5IQ/y3mj@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/21/2022 5:45 PM, Josh Steadmon wrote:
> On 2022.06.29 20:40, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>
>> +static void find_temp_filename(struct strbuf *name)
>> +{
>> +	int fd;
>> +	/*
>> +	 * Find a temporary filename that is available. This is briefly
>> +	 * racy, but unlikely to collide.
>> +	 */
>> +	fd = odb_mkstemp(name, "bundles/tmp_uri_XXXXXX");
>> +	if (fd < 0)
>> +		die(_("failed to create temporary file"));
>> +	close(fd);
>> +	unlink(name->buf);
> 
> Is there a reason why we unlink() here? If we allow the empty file to
> remain on-disk until we write to it, wouldn't that prevent odb_mkstemp()
> from being racy?

I still need to test this, but that should work. Thanks!

>> +static int copy_uri_to_file(const char *uri, const char *file)
> 
> Nitpick: from a brief glance, it seems that most other copy* functions
> take the destination as the first parameter, and the source second. I
> don't feel strongly about it, because to me src followed by dst feels
> more natural, but perhaps we should be consistent with other functions.

Yeah, this is definitely my personal option that (src, dst) feels more
natural to me and I need to do a mental swap whenever dealing with the
standard methods. However, it's best to be consistent, and...
 
> 
>> +{
>> +	/* Copy as a file */
>> +	return copy_file(file, uri, 0444);

...we have exactly that standard usage right here.

>> +	if ((result = unbundle(r, &header, bundle_fd, &extra_index_pack_args)))
> 
> Can we just pass NULL here instead of creating an empty
> extra_index_pack_args?

This isn't the first time I've populated an option instead of just
passing NULL. I'll work on fixing that bad habit.

Thanks,
-Stolee
