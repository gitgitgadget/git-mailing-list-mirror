Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14BCB2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 05:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbdKVFKV (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 00:10:21 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:36344 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbdKVFKU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 00:10:20 -0500
Received: by mail-it0-f67.google.com with SMTP id 187so4838781iti.1
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 21:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bL1/XJrEqxlP+8d1Y36Z/Gx1ojW7TQ6Ok4vs9WjGmTQ=;
        b=m5kIIbVIgMjIuwaiUXpCl+8r7e+wVfxDKW3buL+nuzKWa6xgPWWtTXInioFlZ/3jiy
         K+hH/MTncuBnGhxT08Iat2HdrqGeYIPL2fYlkD0s2fBwicCFivGL0PmRvORFGgEb2Prr
         OGoLqi1azeZWMbUE4aZq/h4xgZR02D5bbFwhzBRKgXA3BOD9QB1tNe5nlEk3WwNfuiHt
         UXSc6aJEdGWDjCQOYMbOZsgPpSDqqcG7NE36RGsBUvH3ECsHCPBCf5+gYRc7EhvKJnGf
         agcRuMmoZJYLOK8WfDDqDK5oNKmfjUuBf1oFsWTvOl3gRZXRrVcuWTGlvtK5nyvltNH0
         uOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bL1/XJrEqxlP+8d1Y36Z/Gx1ojW7TQ6Ok4vs9WjGmTQ=;
        b=uib1QQzYNNuMA5ixySrrWKDvPDjC6Yt+8U17m+/GISI0WA5/RN1llwCDOuB92MpBHR
         3Y4aHILlOXortKkQx+VUDcf2V4ecXXg8IF16nbd44zhRFzG/+4xxJ84F/aoVvaB8HF79
         3BAdQUP+rnoViJlvrtm518jKu2ADgYVy3gI4vPS4J6P8de5u4Qrir0FcQpcnaxa5ffoR
         RqjXgbEpNgWT4PuZvcNb3YyNGmFv3rdsTAIfmPjn8xCzVMCAbB796q3QgvmzXWu7ATn+
         8lKLKISh/Bpm8S0GYwNIMSe9zK84EcGE7fXKoK1bmAcdmm2tyiUaHJT+II0b9Z0BmkmK
         QsTg==
X-Gm-Message-State: AJaThX75WjKJovjJ8Kj1HymvJx0K4FSLETaBQBFE3CZcpF+wociFIz3v
        1xi9UllXQqmysfbsl4rQx/E=
X-Google-Smtp-Source: AGs4zMaJuxhbMJtsgpFLskWjVbkW4H2T9BHQ/tH2Kv97YbN8aUetD/DMgpXrOEu79q/0gFIa40O+Yw==
X-Received: by 10.36.248.6 with SMTP id a6mr5284175ith.11.1511327420223;
        Tue, 21 Nov 2017 21:10:20 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r124sm1523833ita.13.2017.11.21.21.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 21:10:19 -0800 (PST)
Date:   Tue, 21 Nov 2017 21:10:14 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] Git/Packet.pm: rename packet_required_key_val_read()
Message-ID: <20171122051014.GA7625@aiede.mtv.corp.google.com>
References: <20171121160939.22962-1-chriscool@tuxfamily.org>
 <20171121191900.GD3429@aiede.mtv.corp.google.com>
 <xmqq60a3vv63.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq60a3vv63.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Christian Couder wrote:

>>> +# Read a text line and check that it is in the form "key=value"
>>> +sub packet_key_val_read {
>>
>> This comment doesn't tell me how to use the function.  How do I detect
>> whether it successfully read a line?  What do the return values
>> represent?  What happens if the line it read doesn't match the key?
>
> Would this work for both of you?
>
> # Read a text packet, expecting that it is in the form "key=value" for
> # the given $key.  An EOF does not trigger any error and is reported
> # back to the caller (like packet_txt_read() does).  Die if the "key"
> # part of "key=value" does not match the given $key, or the value part
> # is empty.

Yes, thank you.

Jonathan
