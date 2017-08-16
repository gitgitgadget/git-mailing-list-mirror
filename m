Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 775CE208CD
	for <e@80x24.org>; Wed, 16 Aug 2017 00:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753121AbdHPAXC (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 20:23:02 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33645 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752756AbdHPAXB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 20:23:01 -0400
Received: by mail-pg0-f49.google.com with SMTP id u5so15305969pgn.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 17:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qjkVYkHZDnpoDA002IpH/xLvZmn74BR9Wfj/KKZybJg=;
        b=OsBPkrU6AEpQlIuJ5HiseVmiaZ2JGe300w2v+sQ4cdvzELMXDY/ydXWo1uyu9EDshu
         FL0mC8iYM1d+EoDskCshsaDP6CO5xruMr4lZA/wWVUHfZWaiF5IWc2ALrgQ0c3Ao0MMR
         cWo/HLN2JJVGDxRmS0CeD+kchD/WRx5NgUhzvBg0S7o6XCYOzBiXZ+RkJgpjUr1RUKDn
         7hnUOkLVFi6AtSYLs1d8HPtvr6BmnPMG2G/K7KNTroED0+xWk1LsUjxphgBNJpjU1ch3
         zHmSECtEacFjUFDWITF0kcyxpXN4N4fd7Z4gg6YjwTeFqJtyjxOU3gkRGmgiUxO8pzQq
         Nm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qjkVYkHZDnpoDA002IpH/xLvZmn74BR9Wfj/KKZybJg=;
        b=V4W3Fv/W1G2Fg6+x4ydm5o6+k5YQy9PBKGSNgU2MtTWGTtWtuwLaWYujceXBpOOBX3
         ESaLAhC+rFJ8Ynuoc7vHEsKwgk6++E+M5yIA89OdV67ZEAw2VmTo8yDhWT/rAzksNAMs
         SESt0JYlQUmCMdjMtD8KVyNn01biKzaQ7KL6G3URbnRJYDEkgQEwO48VeIzGiT+DbzVU
         jYzDpwsRVMXQrR72+tNMYtPjn82z3i5Ssk7k6qK2LRYd9sUeds4lJ2sVw1lzWd3xf+zO
         FxcLohdg9XZbnF4JW0LP0QzSc/NPIpGifRhyi/pvoybvznkNq/4fxi8B+VBQmK03b6fT
         cCTw==
X-Gm-Message-State: AHYfb5hhqnPNK6vWNz62Wdpml+oWwdTeCuoR4rtdttU6nNw3p+jvFLRZ
        7Yuh2RDUJzlXiA==
X-Received: by 10.84.216.76 with SMTP id f12mr33163183plj.219.1502842980913;
        Tue, 15 Aug 2017 17:23:00 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:3932:90a0:1342:ce37])
        by smtp.gmail.com with ESMTPSA id d15sm15490240pgt.44.2017.08.15.17.22.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 17:22:59 -0700 (PDT)
Date:   Tue, 15 Aug 2017 17:22:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] sub-process: print the cmd when a capability is
 unsupported
Message-ID: <20170816002257.GG13924@aiede.mtv.corp.google.com>
References: <20170815173611.2267-1-chriscool@tuxfamily.org>
 <20170815111725.5d009b66@twelve2.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170815111725.5d009b66@twelve2.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:
> Christian Couder <christian.couder@gmail.com> wrote:

>> In handshake_capabilities() we use warning() when a capability
>> is not supported, so the exit code of the function is 0 and no
>> further error is shown. This is a problem because the warning
>> message doesn't tell us which subprocess cmd failed.
[...]
>> Let's improve the warning() message, so that we can know which
>> subprocess cmd failed.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
> This looks reasonable to me.
>
> I am still wondering if protocol errors should be fatal,

Yes, please.

Thanks,
Jonathan
