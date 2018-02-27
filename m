Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2E751FAE2
	for <e@80x24.org>; Tue, 27 Feb 2018 19:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeB0TU2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 14:20:28 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35546 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbeB0TU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 14:20:27 -0500
Received: by mail-pg0-f66.google.com with SMTP id l131so7894605pga.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 11:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b9NOpy4s1kSqefgXZPbNqBaLykSgcffUciqNOjV1tzA=;
        b=J3n0GTWRlHih80NT1QLixN2buYNzEEfHfju2ztCMmzgx9N/uoQuMJ/qCR7fbhXbXjT
         3ToZW7lR9iZ/gXWbAUfVXaKLsCcIVTbWV9q3VM7hUjI570oR1kJ7cPWEtGHsc4h7Kc7h
         Xnr834EAs6oSIlnnE1YE7Y+GC92DR/PEc2nEqO+5KzuDhOUaN3Zt7L/HqtgaLhs6v3Kj
         93KjKB/KzsV66/jGkJzg9L/2kH0p6294jyQw6UkJK5SGryD/CmvfJRTxRVLsY99yrrL9
         9uI/HuksLbIfXjM/TSIsa3KfHFig3QP7y3J2brXshQ/DY8BqBgMQ0NPYcmBjeE1rYowV
         HUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b9NOpy4s1kSqefgXZPbNqBaLykSgcffUciqNOjV1tzA=;
        b=G99JTDRjzfKRU0N2m0t1H0JOKHHBtq89zOg+loFq4yKVA2FTe+6vtOYPl5l+uS3ORd
         2ld6GiT8QNAtungicxIRDFKJEudejrsk/b2mhDw1FEwrPGh5IQx6O7PzgNFtxS+wQk2t
         aNYSOqUTCrJJSX4qMo4nFPB1L8EwSGBWxD1gm7RDj58pi/lUiMq8vvF4Xlj8gUhST96c
         6vjI8AkeY9mOP+/OPS565slfTJhdnYCecK5PLIy2i+j/W2ACPmyAwx9mNeQRQcPdvyg1
         cQXVsgfaxgcbDHecNWbeZWMk2Bxretxa29G+cZHOKKhn1If6vKdv/WA54KptS4QMixNL
         XNHA==
X-Gm-Message-State: APf1xPCfZFbnaD3krQ726tgfhzKv5iAvwXKoVDmHTDhaCfHP/GBvtbNr
        KOjmIZoEZFemzT1RAH9areM=
X-Google-Smtp-Source: AH8x2256to+8h4ryucBKKPxXR5fRZH9TLHpixB+/DAUBk0Gg52d4tnp1S3RSBCGx/zmI76miQ5xaPw==
X-Received: by 10.98.254.19 with SMTP id z19mr15130686pfh.76.1519759226882;
        Tue, 27 Feb 2018 11:20:26 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b5sm26008344pfc.12.2018.02.27.11.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 11:20:26 -0800 (PST)
Date:   Tue, 27 Feb 2018 11:20:24 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 02/35] pkt-line: introduce struct packet_reader
Message-ID: <20180227192024.GB174036@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-3-bmwill@google.com>
 <20180213004937.GB42272@aiede.svl.corp.google.com>
 <20180227181428.GB209668@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227181428.GB209668@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams wrote:
> On 02/12, Jonathan Nieder wrote:

>>> --- a/pkt-line.h
>>> +++ b/pkt-line.h
>>> @@ -111,6 +111,64 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
>>>   */
>>>  ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out);
>>>  
>>> +struct packet_reader {
>>> +	/* source file descriptor */
>>> +	int fd;
>>> +
>>> +	/* source buffer and its size */
>>> +	char *src_buffer;
>>> +	size_t src_len;
>>
>> Can or should this be a strbuf?
>>
>>> +
>>> +	/* buffer that pkt-lines are read into and its size */
>>> +	char *buffer;
>>> +	unsigned buffer_size;
>>
>> Likewise.
>
> This struct is setup to be a drop in replacement for the existing
> read_packet() family of functions.  Because of this I tried to make the
> interface as similar as possible to make it easy to convert to using it
> as well as having no need to clean anything up (because the struct is
> really just a wrapper and doesn't own anything).

Sorry, I don't completely follow.  Are you saying some callers play
with the buffer, or are you saying you haven't checked?  (If the
latter, that's perfectly fine; I'm just trying to understand the API.)

Either way, can you add some comments about ownership / who is allowed
to write to it / etc to make it easier to clean up later?

Thanks,
Jonathan
