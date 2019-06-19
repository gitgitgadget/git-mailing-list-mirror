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
	by dcvr.yhbt.net (Postfix) with ESMTP id BEBAD1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 13:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfFSNQd (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 09:16:33 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35599 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfFSNQd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 09:16:33 -0400
Received: by mail-qk1-f195.google.com with SMTP id l128so10861119qke.2
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 06:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4FJWaGpXl/NQUrUnNrr18lPCymZzrTWXwPAnH5Bhhk8=;
        b=aWpUcGj6p0SCf6Mjq2ae2YiTZ6MqXr5k08RTfzrCbIbZXYGPwm1C/zVIccZy3vM2Lj
         /Z/plcDIFNWyJufIqVsQPB9qJvedfXFO+jfY+sdNEcZv52phoyljhY149iZgZZ3eymuY
         bJz4FZwpNve1bRKTKbaTJQrMrS+woL47uoA0rd4cs7CbOtNViQKjNI85DBiq26/p9Sjy
         GZmbgT3tm7xrrS0Vv4nhZh3O7HLW2eD5sJUMw359Okh6VV7KVzIEhuW88zdvkfHJtt05
         NB2COyBQo+c8Oeo2cqgik3KoIioRU5tZppaPcc5Ptzwjb5pHPbqa9wQ/RI19KwWmWhmF
         Aj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4FJWaGpXl/NQUrUnNrr18lPCymZzrTWXwPAnH5Bhhk8=;
        b=nnEwx9UvwYeNzh9JKaNSqvlnEFljQrAZIg+NyfIfuU1nbIUXYZpi2QMHU8+ececy2i
         CKceY+JcICGiwDkJ9NppSF9RjC4oN2G3vBJlkIzJct5NsGidlSvUS5FyB6v8HSP5EEHp
         8Jaf/2wYOjQR2CdgikA+A9Y1Wubg47IFcLcsW8DK0kfPZkmmMe1z/tA+9ZeRMXzjNjGa
         V9dnodWSWtPYFHzC69pBSFDLA0wgw591TgxrHkUMe4mxwyOn8LrD5PXlp1ssY7yzJBoX
         FsNYkS2vclcFAL6cfHQ6h8MEfiXCVUn36cN6l+0OipFsfd0pIQSwq2n1M7qA79LfjAEk
         X7og==
X-Gm-Message-State: APjAAAV2GY+fuihxB3lzEXRg2x+UqHJ/pXBpvrwsrtTYIJHJoAlOJZmW
        wXR9Wg6zGATolcTYZfYFHoXAHpco
X-Google-Smtp-Source: APXvYqyJQx0d5B+aHWsDQHfeEqBHb6A5PboIIjNl8N1CP12dqlxFMQyoWQQEXI8ZRO1V1FJ41fgOig==
X-Received: by 2002:a37:670e:: with SMTP id b14mr27854044qkc.216.1560950192349;
        Wed, 19 Jun 2019 06:16:32 -0700 (PDT)
Received: from [10.0.1.15] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id e52sm6115021qtk.20.2019.06.19.06.16.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 06:16:31 -0700 (PDT)
Subject: Re: [PATCH 4/8] resolve-undo.c: dump "REUC" extension as json
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20190619095858.30124-1-pclouds@gmail.com>
 <20190619095858.30124-5-pclouds@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3dba92fa-68ce-8204-fdfe-a0435528a9c2@gmail.com>
Date:   Wed, 19 Jun 2019 09:16:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190619095858.30124-5-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/19/2019 5:58 AM, Nguyễn Thái Ngọc Duy wrote:

> +	if (jw) {
> +		jw_object_inline_begin_object(jw, "resolve-undo");
> +		jw_object_intmax(jw, "ext-size", size);
> +		jw_object_inline_begin_array(jw, "entries");
> +	}

While reading this block, I noticed the use of hyphens in the
member names could cause some problems when translating into
object models in some languages. While this is valid JSON, I
found helpful recommendations in the Google JSON Style Guide [1]
that could apply here and elsewhere. Specifically, this
recommendation:

  "Property names must be camel-cased, ascii strings."

Treating JSON members as camel-cased variable names would
promote consumption by third-party tools.

Thanks,
-Stolee

[1] https://google.github.io/styleguide/jsoncstyleguide.xml?showone=Property_Name_Format#Property_Name_Format
