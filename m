Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE9322018E
	for <e@80x24.org>; Fri,  5 Aug 2016 12:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935000AbcHEMCY (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 08:02:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33971 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934989AbcHEMCY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2016 08:02:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so3492535wma.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 05:02:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HQv4ruwBUzllPsJYiXdoq2F51br1M48ujONdVpIrYBU=;
        b=yGfFCZ14eJVHnxJaa5gL0+HoqTVqR8pwYK3CWcnCx4BffNOymLTyf8sx5jfRcN1UK/
         8QAJJZ+8oc2IbSsmb5OzDm0Enj+QfWMx85M3qEog7c1o0GeroLma5fCdyRygrvDHoDmx
         VR8ldB9zB/jCQU56I7iLtU3bRmp+/kmeiyFaEe5VgY4a0Qu4E20vCQRlbrcgJW96e0Sn
         wJ8pLrIm46obQV7T7+6uBsyyJT8DozorYnkX3YgxT+R3zCWcuXLPAnw4BZvYTn9Jp0AD
         QMpSeysbhmQng3RZsTD1sAerFJ4dDifyRi4VIjLNUm44N5VZHoSpdbMvI/f6Km9dUmMO
         zuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HQv4ruwBUzllPsJYiXdoq2F51br1M48ujONdVpIrYBU=;
        b=F7A7VCWmi8qFikfng5WHYWwhBHIayJDaP/bKKYZzicSKmQEiuyTlQvYmxKLasHOzl5
         5Z3WE6+xUPbwmB94ncFeV8JOf3hBJs8jN8jXA/TcGZFY1g468bOq07NRQIAYFlW3mY+b
         2EmZz1qZxDd+tZFfwi/fFw/GBUKtvruSaNt84wvoi/sa9hwkaQYjJdA8vv9Am74lu5iM
         N/p3ILrWzYqlxae0C5VqcCy/Q5OKZyZ/xwxFcdKCgOGTagM3HMcttMmM8c2xVt+69FM1
         TGyvUfcBJ+X3V9XiCSiytK9yLN4TDq0kP1axK5UoiMogAc5uNKR/dGeqhlB5a4EoNlyt
         BsBg==
X-Gm-Message-State: AEkooutrvQtANXVgc55QVkUujXJoGqDQHznv50fPGBcPapO4DOuF8UxXqqrM003OFE+2yg==
X-Received: by 10.28.70.65 with SMTP id t62mr3152565wma.53.1470398527570;
        Fri, 05 Aug 2016 05:02:07 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 190sm8319614wmk.13.2016.08.05.05.02.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 05:02:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 02/10] pkt-line: add direct_packet_write() and direct_packet_write_data()
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <e8b550ed-1765-764f-49e5-72e5a609d936@gmail.com>
Date:	Fri, 5 Aug 2016 14:02:03 +0200
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, tboegi@web.de,
	mlbright@gmail.com, Eric Wong <e@80x24.org>,
	Jeff King <peff@peff.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <B113DD3B-A8AD-452A-B1E6-A92C84665D65@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/> <20160729233801.82844-1-larsxschneider@gmail.com> <20160729233801.82844-3-larsxschneider@gmail.com> <58e4737b-6e0e-565c-2468-05c705dea426@gmail.com> <64783AA5-D579-4783-88E7-E0B3BDE5FDEB@gmail.com> <e8b550ed-1765-764f-49e5-72e5a609d936@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 03 Aug 2016, at 22:12, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> [This response might have been invalidated by v4]
> 
> W dniu 01.08.2016 o 14:00, Lars Schneider pisze:
>>> On 30 Jul 2016, at 12:49, Jakub Narębski <jnareb@gmail.com> wrote:
>>> W dniu 30.07.2016 o 01:37, larsxschneider@gmail.com pisze:
>>>> 
>>>> Sometimes pkt-line data is already available in a buffer and it would
>>>> be a waste of resources to write the packet using packet_write() which
>>>> would copy the existing buffer into a strbuf before writing it.
>>>> 
>>>> If the caller has control over the buffer creation then the
>>>> PKTLINE_DATA_START macro can be used to skip the header and write
>>>> directly into the data section of a pkt-line (PKTLINE_DATA_LEN bytes
>>>> would be the maximum). direct_packet_write() would take this buffer,
>>>> adjust the pkt-line header and write it.
>>>> 
>>>> If the caller has no control over the buffer creation then
>>>> direct_packet_write_data() can be used. This function creates a pkt-line
>>>> header. Afterwards the header and the data buffer are written using two
>>>> consecutive write calls.
>>> 
>>> I don't quite understand what do you mean by "caller has control
>>> over the buffer creation".  Do you mean that caller either can write
>>> over the buffer, or cannot overwrite the buffer?  Or do you mean that
>>> caller either can allocate buffer to hold header, or is getting
>>> only the data?
>> 
>> How about this:
>> 
>> [...]
>> 
>> If the caller creates the buffer then a proper pkt-line buffer with header
>> and data section can be created. The PKTLINE_DATA_START macro can be used 
>> to skip the header section and write directly to the data section (PKTLINE_DATA_LEN 
>> bytes would be the maximum). direct_packet_write() would take this buffer, 
>> fill the pkt-line header section with the appropriate data length value and 
>> write the entire buffer.
>> 
>> If the caller does not create the buffer, and consequently cannot leave room
>> for the pkt-line header, then direct_packet_write_data() can be used. This 
>> function creates an extra buffer for the pkt-line header and afterwards writes
>> the header buffer and the data buffer with two consecutive write calls.
>> 
>> ---
>> Is that more clear?
> 
> Yes, I think it is more clear.  
> 
> The only thing that could be improved is to perhaps instead of using
> 
>  "then a proper pkt-line buffer with header and data section can be created"
> 
> it might be more clear to write
> 
>  "then a proper pkt-line buffer with data section and a place for pkt-line header"

OK. I changed it to

"If the caller has control over the buffer creation then a proper pkt-line
buffer with header and data section can be allocated. The 
PKTLINE_DATA_START macro can be used to skip the header and write
directly into the data section of a pkt-line (PKTLINE_DATA_LEN bytes
would be the maximum)..."

However, I am not yet sure if I can/will keep this patch:
http://public-inbox.org/git/xmqqeg645x6b.fsf%40gitster.mtv.corp.google.com/


> 
>>>> +{
>>>> +	int ret = 0;
>>>> +	char hdr[4];
>>>> +	set_packet_header(hdr, sizeof(hdr) + size);
>>>> +	packet_trace(buf, size, 1);
>>>> +	if (gentle) {
>>>> +		ret = (
>>>> +			!write_or_whine_pipe(fd, hdr, sizeof(hdr), "pkt-line header") ||
>>> 
>>> You can write '4' here, no need for sizeof(hdr)... though compiler would
>>> optimize it away.
>> 
>> Right, it would be optimized. However, I don't like the 4 there either. OK to use a macro
>> instead? PKTLINE_HEADER_LEN ?
> 
> Did you mean 
> 
>    +	char hdr[PKTLINE_HEADER_LEN];
>    +	set_packet_header(hdr, sizeof(hdr) + size);

yes!


>>>> +			!write_or_whine_pipe(fd, buf, size, "pkt-line data")
>>>> +		);
>>> 
>>> Do we want to try to write "pkt-line data" if "pkt-line header" failed?
>>> If not, perhaps De Morgan-ize it
>>> 
>>> +		ret = !(
>>> +			write_or_whine_pipe(fd, hdr, sizeof(hdr), "pkt-line header") &&
>>> +			write_or_whine_pipe(fd, buf, size, "pkt-line data")
>>> +		);
>> 
>> 
>> Original:
>> 		ret = (
>> 			!write_or_whine_pipe(fd, hdr, sizeof(hdr), "pkt-line header") ||
>> 			!write_or_whine_pipe(fd, data, size, "pkt-line data")
>> 		);
>> 
>> Well, if the first write call fails (return == 0), then it is negated and evaluates to true.
>> I would think the second call is not evaluated, then?!
> 
> This is true both for || and for &&, as in C logical boolean operators
> short-circuit.

True. That's why I did not get your "de morganize" it comment... what would de morgan change?

> 
>> Should I make this more explicit with a if clause?
> 
> No need.

OK


Thanks,
Lars
