Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8775F202F2
	for <e@80x24.org>; Wed, 22 Nov 2017 07:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbdKVHHM (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 02:07:12 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:42525 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbdKVHHM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 02:07:12 -0500
Received: by mail-io0-f195.google.com with SMTP id u42so22143423ioi.9
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 23:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3YYMbWvF3xg6YcMUNCzoTlRWt0M9X+s9UwytYfRXHYY=;
        b=IVFt41QIDxN513NjmGzY1nFeH4VX9ak20j6zrtJiqT3FMtE4pv6DGWhfaa9cFTnhHk
         ld9NrxzA8MmfXK09lFjjEJ1QWOeEow5n00+uC5KRkXaHLgp+S6zIw34jBQ4C1BcVOGFc
         uLhG2qOTdDNHCRyahz85Ao3NP1F5QXUnfj+/TDh8WK6K4rOnsZB5276tMjDKgcs2cW0R
         OOvK7HEW6YOaiMNcgcAaPoEsp8R5GW+NWPr1xIXA3avGW5SQ0muSL/mgUpuoO4uOlmlK
         cmGKy0BWfk8tERfdN6h4jTfHKaaKbsoMXmANSvhsyh8riTwu/An54WUWXDbo2RPXZ2JB
         fjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3YYMbWvF3xg6YcMUNCzoTlRWt0M9X+s9UwytYfRXHYY=;
        b=p6td0sYWZKmFcWojQqUYjw+BstJqa59Vwr65oFfIIOzCFq6iOUXPXIc7xnVhVqasHO
         J4sMvQk7UgAB0bwEFpP/lSom5ak6LdzWkcfU+UzYWxXuBUZWXNourYNVJxYjVOc24jK+
         W7t+6cQYTfIJX17ESeEXKKM6M3dHgwiVlr8fsMYPnrfgOWnDFYwcPKP3Vt9c4A5I3QO2
         AOy2KfwQ0rR2XJM0AmNxUA1lB0ecnnRt2BE0O6LY8RR/KPTn3u6WdoPvCqjj3pVJlgbO
         TQjENu9l7/30FI0CdvLtJ6kawz9sA5Mm5ilbtPod/MkwMO9fEF5+4INxKbGZF2XdnT/l
         eDXg==
X-Gm-Message-State: AJaThX6cHpFIsmOl3g4YVTHzOPwBFtbUqapTxQ0vtFHTCFYxrh8qJHQi
        lF+6FShTSBj6m1vphXd0pTQ=
X-Google-Smtp-Source: AGs4zMbF47E9fjkv+yaC4ozr8vk6Z1RAWWpZqYYTmCsX9id+o92GuYvmSrfHLkQBlTW1LMjGIEJ5uQ==
X-Received: by 10.107.104.5 with SMTP id d5mr21208087ioc.84.1511334431437;
        Tue, 21 Nov 2017 23:07:11 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id o20sm1664413ioo.73.2017.11.21.23.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 23:07:10 -0800 (PST)
Date:   Tue, 21 Nov 2017 23:07:08 -0800
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
Message-ID: <20171122070708.GD7625@aiede.mtv.corp.google.com>
References: <20171121160939.22962-1-chriscool@tuxfamily.org>
 <20171121191900.GD3429@aiede.mtv.corp.google.com>
 <xmqq60a3vv63.fsf@gitster.mtv.corp.google.com>
 <20171122051014.GA7625@aiede.mtv.corp.google.com>
 <xmqqfu96u8s4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfu96u8s4.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Junio C Hamano wrote:
>>> Jonathan Nieder <jrnieder@gmail.com> writes:

>>>> This comment doesn't tell me how to use the function.  How do I detect
>>>> whether it successfully read a line?  What do the return values
>>>> represent?  What happens if the line it read doesn't match the key?
>>>
>>> Would this work for both of you?
>>>
>>> # Read a text packet, expecting that it is in the form "key=value" for
>>> # the given $key.  An EOF does not trigger any error and is reported
>>> # back to the caller (like packet_txt_read() does).  Die if the "key"
>>> # part of "key=value" does not match the given $key, or the value part
>>> # is empty.
>>
>> Yes, thank you.
>
> Heh.  I actually was expecting a different response: "that describes
> what the reader can easily read out of the implementation and is
> useless", though.

The main context that I'm missing and that this function comment
doesn't answer is what this function is for.  When would I want to
read a line and exit if it doesn't match "key" but not exit if I hit
EOF?  It seems very strange.

The function comment does successfully capture the strangeness,
though, and that already helps.  When looking at the implementation, I
had a bit of a double-take and wondered what I was missing.  This doc
comment says "you weren't missing anything --- that is actually the
contract that this function intends to fulfill".

Thanks,
Jonathan
