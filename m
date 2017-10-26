Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00AA1202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 21:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932409AbdJZVdl (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 17:33:41 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:52929 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932394AbdJZVdl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 17:33:41 -0400
Received: by mail-io0-f178.google.com with SMTP id f20so8503021ioj.9
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 14:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EP83c/tOwV5/2rDB/7VtxUbbB2LScj+SOvCs0pB2imQ=;
        b=b+K8v5GfNxAeIi4gD4UiSKVR2Emd5n5nN//lL+aGm8tg8Ye9iF1AKd0budyPm1T20O
         +aF3zdjb7ZBSodHozuhMdcxxV6UTCmcw3go5S/biubQBmwI1JDpmroGx3uWEilEnKzR9
         3zXg8hvhF46f9caQWVyCLTOdpE75isk6/Nqa0JCDxppShE1rqyAv2Ljgo54xwNk0+UoJ
         A79CDutycrxpgCVTeY0VDiKsWvsxH/TGeHd5nP6bESgbqPmvA34UnwRpKk6XQmiHlh00
         sPyQwmci5OzP3IgE+yBFB0O9UgyKzHJdyte6mETL+xCY0qOfwd1bYZnRq8fwKfFQjuo4
         B4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EP83c/tOwV5/2rDB/7VtxUbbB2LScj+SOvCs0pB2imQ=;
        b=AVRk32hhd6lXsg9g3aEM8fDLvj/vJeu6XqQTEP0w/WnV2pdUs8meIZvcgDzIYDS1P2
         p4UxAHilk3Jbn2F2ZbFbE8DS1Lb91q2tiJi9CCFHFmWS1okFvTCq4X45HXuXKB6ZyotI
         9cGa6PfmTHb1hacUdihSGx+g/9Wgq06wH1i2WLrlR5nO3hiieKj5mCWjfHZD3XL3MX+g
         unllcY2grWbAFnnygtb9nn7I7JT4M6MAg8+6Oxzrz+r6cWxoJHmTSI7JN6vDeg1xDS0y
         xyoaTCUMpijeEftwMmhwn6MS2x76y4inXQggTHd2DA3omDaK/uESXRSCmYumduJ3uVp7
         4GfA==
X-Gm-Message-State: AMCzsaVdMNSRTquTqA3O0xrPOqmxNYI/uknBjn8Xq9D9vnabrF3Ox6L7
        C/5CZ5LgrEK/O3Ctzrx8JSOTyxHr
X-Google-Smtp-Source: ABhQp+Q2V1qYOdMfNaCrO6qvrBTinhPEPTDldQSQuTGbRGnuA9grMaonLOBUkMVVLNQz/lvmmeVw3Q==
X-Received: by 10.107.46.32 with SMTP id i32mr11334051ioo.8.1509053620334;
        Thu, 26 Oct 2017 14:33:40 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id o137sm2697859iod.51.2017.10.26.14.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Oct 2017 14:33:39 -0700 (PDT)
Date:   Thu, 26 Oct 2017 14:33:37 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] tag: add tag.gpgSign config option to force all tags be
 GPG-signed
Message-ID: <20171026213337.kbmwnaxlsyubat4w@aiede.mtv.corp.google.com>
References: <20171026195516.3354-1-tigran.mkrtchyan@desy.de>
 <20171026205509.2ydjd3bai2l6pqxi@aiede.mtv.corp.google.com>
 <1113033991.3307260.1509051676201.JavaMail.zimbra@desy.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113033991.3307260.1509051676201.JavaMail.zimbra@desy.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

Mkrtchyan, Tigran wrote:
> Jonathan Nieder wrote:
>> Tigran Mkrtchyan wrote:

>>> In some workflows we have no control on how git command is executed,
>>> however a signed tags are required.
>>
>> Don't leave me hanging: this leaves me super curious.  Can you tell me
>> more about these workflows?
>
> Well, this is a build/release process where we can't pass additional
> command line options to git. TO be hones, is case of annotated tags
> there is already option tag.forceSignAnnotated. However, non annotated
> tags are not forced to be signed.
>
> Additionally, the proposed option is symmetric with commit.gpgSign.

Now I'm even more curious.

I don't think we have the full picture to understand whether this
change is needed.  When adding a configuration item, we need to be
able to explain to users what the configuration item is for, and so
far the only answer I am hearing is "because we do not want to patch
our build/release script, though we could in principle".  That doesn't
sound like a compelling reason.

On the other hand, perhaps the answer is "our build/release script
does not have a --sign option for the following reason, and this is a
better interface for configuring it".

Or perhaps there is an answer that does not involve the build/release
script.

But with no answer at all, it is hard to see why we should move
forward on this patch.

To be clear, I am not saying that writing the patch is wasted effort.
E.g. you can continue to use it internally, and it means that once we
have a clear reason to add this configuration, the patch is there and
ready to use to do so.

Thanks again,
Jonathan
