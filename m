Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2B031F453
	for <e@80x24.org>; Thu, 18 Oct 2018 13:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeJRVEV (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 17:04:21 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34247 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeJRVEV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 17:04:21 -0400
Received: by mail-ua1-f68.google.com with SMTP id k4so6108508uao.1
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 06:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=zbQSXJDVFxGBpNzrGt2r2xJXkgGHnbLRxYPRHSbMTkg=;
        b=RWbnWmCFOLt1NFP2D6SFphfbX5UYqbJ1vKXMIIcP/Dpp/zJ6IpGoJCGXfg6msXkUhC
         k5rVmy0w6dQAtfcogWkl31KTZPZmbmCZzCija73SkQNyDO2nl5CXeeXYwtIoVTtWKFPa
         tLVjfOlo6uQRBe7kbGCe4ZuyGUKS90ba6Ic1UIEVty6pClVz3bPpXqtMct26NMUrnxCq
         5zNAex6bxWqA0QU3tzmcx9OozKYn3MlHtheK5oi7M9v24OhoAGwQFXnN96K0iyKvvaoL
         qRVZaFYc33JU/Fbv2Y+7zhN9f/e/O3ZzTxm22EKL50t0Br946bauVogjTcelosSSMlQp
         DI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zbQSXJDVFxGBpNzrGt2r2xJXkgGHnbLRxYPRHSbMTkg=;
        b=R6m8kf/cPyC7AZxDPHBDc/oCzZQJuO0ye3uv0HIse/gLxT90m4nKnCXlFvnMLQJd4P
         y6SBSTI5YehOaUkEcXYNPTJESATMV8W1bj1i5FVLm9pOZ9npbAAVDKnMEIjMjIU5+mpM
         zZ0Um7R9JnIfXq6ihgLO91s9ANTBKqE6BtOjlAP2nq92TIrHiNh85ZH3UD2s1VXa7uZ2
         QMg0w3/HSQcL96VB2OR6cdfIHwixsDGZs+Dmu8L7DRlolBLrwIZjxVWOtWjuag7HmN9u
         i/KBtT7SGgF7QOt/z0arwb80PYlMZP9KSDPARyjjFUAD9sFq3yagZryY7azcRvP+iu/x
         HwUg==
X-Gm-Message-State: ABuFfoiiZRurAnxsYiveQKEm1/XUT+t+i4M1MMDbGVQDBYCIiieMMabD
        SLSDJQ9Ua2bQEwSzJ/tPwGg=
X-Google-Smtp-Source: AJdET5cBmP9MqKSPr4GwoIUyDnRw0jZIj/NeZ9ZF25IQfAaxktY3pxdoQhIQ33ezzwae6LehHHf+5g==
X-Received: by 2002:ab0:184e:: with SMTP id j14mr603275uag.10.1539867804448;
        Thu, 18 Oct 2018 06:03:24 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c079:83d:1a9:9f46? ([2001:4898:8010:0:a9af:83d:1a9:9f46])
        by smtp.gmail.com with ESMTPSA id x143-v6sm4792120vke.8.2018.10.18.06.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 06:03:23 -0700 (PDT)
Subject: Re: [PATCH v2 13/13] commit-graph: specify OID version for SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-14-sandals@crustytoothpaste.net>
 <CACsJy8C6o9PAHsm+t7Rijg6jsz5dXZ5pT79nYGdGbKuK6gGTLQ@mail.gmail.com>
 <fbd59390-42ee-8c06-74b7-1e7081680913@gmail.com>
 <CACsJy8Bg6BpQp4dDXzs8Y_d6RHW9ti4+FLqnAqGwW8F-SWUnPg@mail.gmail.com>
 <20181016224404.GD432229@genre.crustytoothpaste.net>
 <CACsJy8C9nySzG0Uqs6_5V2rXHkAKr-ShXU7N9sPp4N5z=D0zQA@mail.gmail.com>
 <20181018000618.GM432229@genre.crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <734fb14a-b9c8-a27b-5cda-862486c77052@gmail.com>
Date:   Thu, 18 Oct 2018 09:03:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:63.0) Gecko/20100101
 Thunderbird/63.0
MIME-Version: 1.0
In-Reply-To: <20181018000618.GM432229@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/17/2018 8:06 PM, brian m. carlson wrote:
> On Wed, Oct 17, 2018 at 04:31:19PM +0200, Duy Nguyen wrote:
>> On Wed, Oct 17, 2018 at 12:44 AM brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>>> Honestly, anything in the .git directory that is not the v3 pack indexes
>>> or the loose object file should be in exactly one hash algorithm.  We
>>> could simply just leave this value at 1 all the time and ignore the
>>> field, since we already know what algorithm it will use.
>> In this particular case, I agree, but not as a general principle. It's
>> nice to have independence for fsck-like tools. I don't know if we have
>> a tool that simply validates commit-graph file format (and not trying
>> to access any real object). But for such a tool, I guess we can just
>> pass the hash algorithm from command line. The user would have to
>> guess a bit.
> I'm going to drop this patch for now.  I'll send a follow-up series
> later which bumps the format version for this and the multi-pack index
> and serializes them with the four-byte value.  I probably should have
> caught this earlier, but unfortunately I don't always have the time to
> look at every series that hits the list.
We should coordinate before incrementing the version number. I was 
working on making the file formats incremental (think split-index) but 
couldn't come up with a way to do it without incrementing the file 
format. It would be best to combine these features into v2 of each format.

Thanks,
-Stolee
