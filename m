Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C2A31F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758347AbcHCUTH (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:19:07 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38040 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758124AbcHCUTF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:19:05 -0400
Received: by mail-wm0-f50.google.com with SMTP id o80so352407542wme.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 13:19:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Fa7Uw/8ZVsO/UYgjNW2lCvNH2ptladKWXGg1xYV2m88=;
        b=xUU1KywDB3qw0ibL5MPdXHRFYTblmlfvgrhUKWqrBrr24BPJvFUakb3xmPGmEknrYJ
         ajT++VAryG/FVkYW28SPs1iGs0PczQasLaUEX9RYe2jJSv06M2zjIrFEiK5QfA1kYSZ6
         9I2cHe61XZTDUOX0/LAp3vJPvJmEpAMOI3HIU0VFFoeaJAiw9ZLFRUmvpnM+zs18Qb7V
         3kWF8n+p+HJjfwci6NaiOAENjvY/Gc09Yd1YPvyMNi88VmxyF5z6ufe2Ne2qjFC6YnFK
         /vmV2kBar9tYfmyAC0J6Uu4H8baIHlyTJTHLt19SLE9JSXybsbyfnS39fhoG28YpUQp3
         9UfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=Fa7Uw/8ZVsO/UYgjNW2lCvNH2ptladKWXGg1xYV2m88=;
        b=dMqy0JarSwsEm4Jd1cJid96OMFd38kLMxOoASzbCyygirEfd8JvIRDd2MPYuXmROBH
         dZk+9ppvIT8rG20vsPRst6+jSKhLxww3AFLME6wWGuh23fqD73KdtIVZ4zXDUT+Q1GzG
         1fDJoTKxeX6owCV1O/6D1X81X5PWevdWKK4coGz5l58EkCXdctU6PRGg/RyJsOS1Pf1w
         ZmgTfLLGeoBspWvMGkj9l9RXqo0DF/ZLXAq0d1B06jKkA8G1Ia4E2VACeQtxgAkoRfMh
         0lTw2zvQgJ2Vcz5M3+X9BPtLW0rpkHf2okalzo5BVlyqwwCyoinbLXi+1NloRHi9EZe8
         28cQ==
X-Gm-Message-State: AEkoouta+esxPqWawgL0kAtgh3EEWIHLQ3D91sjD82QPMgFopYcSivQ81A0Ups/m2JrPcQ==
X-Received: by 10.28.150.146 with SMTP id y140mr26775370wmd.32.1470255192321;
        Wed, 03 Aug 2016 13:13:12 -0700 (PDT)
Received: from [192.168.1.26] (adbx179.neoplus.adsl.tpnet.pl. [79.184.23.179])
        by smtp.googlemail.com with ESMTPSA id bc10sm9297019wjc.32.2016.08.03.13.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2016 13:13:11 -0700 (PDT)
Subject: Re: [PATCH v3 02/10] pkt-line: add direct_packet_write() and
 direct_packet_write_data()
To:	Lars Schneider <larsxschneider@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-3-larsxschneider@gmail.com>
 <58e4737b-6e0e-565c-2468-05c705dea426@gmail.com>
 <64783AA5-D579-4783-88E7-E0B3BDE5FDEB@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, tboegi@web.de,
	mlbright@gmail.com, Eric Wong <e@80x24.org>,
	Jeff King <peff@peff.net>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <e8b550ed-1765-764f-49e5-72e5a609d936@gmail.com>
Date:	Wed, 3 Aug 2016 22:12:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <64783AA5-D579-4783-88E7-E0B3BDE5FDEB@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

[This response might have been invalidated by v4]

W dniu 01.08.2016 o 14:00, Lars Schneider pisze:
>> On 30 Jul 2016, at 12:49, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 30.07.2016 o 01:37, larsxschneider@gmail.com pisze:
>>>
>>> Sometimes pkt-line data is already available in a buffer and it would
>>> be a waste of resources to write the packet using packet_write() which
>>> would copy the existing buffer into a strbuf before writing it.
>>>
>>> If the caller has control over the buffer creation then the
>>> PKTLINE_DATA_START macro can be used to skip the header and write
>>> directly into the data section of a pkt-line (PKTLINE_DATA_LEN bytes
>>> would be the maximum). direct_packet_write() would take this buffer,
>>> adjust the pkt-line header and write it.
>>>
>>> If the caller has no control over the buffer creation then
>>> direct_packet_write_data() can be used. This function creates a pkt-line
>>> header. Afterwards the header and the data buffer are written using two
>>> consecutive write calls.
>>
>> I don't quite understand what do you mean by "caller has control
>> over the buffer creation".  Do you mean that caller either can write
>> over the buffer, or cannot overwrite the buffer?  Or do you mean that
>> caller either can allocate buffer to hold header, or is getting
>> only the data?
> 
> How about this:
> 
> [...]
> 
> If the caller creates the buffer then a proper pkt-line buffer with header
> and data section can be created. The PKTLINE_DATA_START macro can be used 
> to skip the header section and write directly to the data section (PKTLINE_DATA_LEN 
> bytes would be the maximum). direct_packet_write() would take this buffer, 
> fill the pkt-line header section with the appropriate data length value and 
> write the entire buffer.
> 
> If the caller does not create the buffer, and consequently cannot leave room
> for the pkt-line header, then direct_packet_write_data() can be used. This 
> function creates an extra buffer for the pkt-line header and afterwards writes
> the header buffer and the data buffer with two consecutive write calls.
> 
> ---
> Is that more clear?

Yes, I think it is more clear.  

The only thing that could be improved is to perhaps instead of using

  "then a proper pkt-line buffer with header and data section can be created"

it might be more clear to write

  "then a proper pkt-line buffer with data section and a place for pkt-line header"
 

>>> +{
>>> +	int ret = 0;
>>> +	char hdr[4];
>>> +	set_packet_header(hdr, sizeof(hdr) + size);
>>> +	packet_trace(buf, size, 1);
>>> +	if (gentle) {
>>> +		ret = (
>>> +			!write_or_whine_pipe(fd, hdr, sizeof(hdr), "pkt-line header") ||
>>
>> You can write '4' here, no need for sizeof(hdr)... though compiler would
>> optimize it away.
> 
> Right, it would be optimized. However, I don't like the 4 there either. OK to use a macro
> instead? PKTLINE_HEADER_LEN ?

Did you mean 

    +	char hdr[PKTLINE_HEADER_LEN];
    +	set_packet_header(hdr, sizeof(hdr) + size);

 
>>> +			!write_or_whine_pipe(fd, buf, size, "pkt-line data")
>>> +		);
>>
>> Do we want to try to write "pkt-line data" if "pkt-line header" failed?
>> If not, perhaps De Morgan-ize it
>>
>>  +		ret = !(
>>  +			write_or_whine_pipe(fd, hdr, sizeof(hdr), "pkt-line header") &&
>>  +			write_or_whine_pipe(fd, buf, size, "pkt-line data")
>>  +		);
> 
> 
> Original:
> 		ret = (
> 			!write_or_whine_pipe(fd, hdr, sizeof(hdr), "pkt-line header") ||
> 			!write_or_whine_pipe(fd, data, size, "pkt-line data")
> 		);
> 
> Well, if the first write call fails (return == 0), then it is negated and evaluates to true.
> I would think the second call is not evaluated, then?!

This is true both for || and for &&, as in C logical boolean operators
short-circuit.

> Should I make this more explicit with a if clause?

No need.

-- 
Jakub Narębski

