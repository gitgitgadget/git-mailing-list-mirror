Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B81822018E
	for <e@80x24.org>; Fri,  5 Aug 2016 11:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161197AbcHELwI (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 07:52:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34236 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161166AbcHELwH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2016 07:52:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so3455928wma.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 04:52:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kRzNwHl+ctBnQ5tuGq4JoNpGQIoUB1iAr+bf/ErT4U8=;
        b=h9vKaS5z4yZgnNeBaFzq0dXp1aM22Xsy8h/IVksOy/3mSJm8rSpMft32MxKutbPenF
         9+vUHSIqlufhyxl7LEdI/48JORLqZaIVA2enVyeX+YaDWmcX2AL8BKesj/zasmDVT+5E
         3hpP2CXLry+U+hDTFoIsVCvEtJB7HMNcWwPDLQQg1a8YesRKGfPIJy29Eu1fv+oCuduR
         SZmdrGGnlQUG786LuZ0mvbTg8aYfRPmfrtz+7uEwXjpFN2upaIfm9kvGL7A/IdKZr/OA
         Get0RSDaQqNReTcs96RMV99ksFEwjbDlPmb3JAg6vqn4rQC0Yi/s/+s2j6DKKORxAGWn
         3wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kRzNwHl+ctBnQ5tuGq4JoNpGQIoUB1iAr+bf/ErT4U8=;
        b=TQtY9CKOsmWrb34R7DbUEbdixLRRgMHI6cV2hMrhL/M7RyoKGSfpndiMyq2AkiLhAY
         yQkxd/i3JXayz5w87+W61RD0evSa20kxXB/YZd4FLCWt5++XFx9JMmWbH0uifnIY+8F3
         RVqXFw0a0FatGEZg3oCE/SWWfmz68SSxr6VYuDah6TgYaxkruUJL64xmJIWB95zdz76/
         RVoKgPED/poY6RbFaWg1sA/S4qlRmz07ze8urAUR1mtK6VM0LMSFOA1RN0YUgQ274S6x
         cKLwPXXrPHhe5RCXETKctfjJtM/gKnrD5J56aWjZHcWyvyoZwNmiWeRBAfaWg4fya/M1
         2uGw==
X-Gm-Message-State: AEkooutM2RMX8qW+BhR/zWgk/HkEp14VNJxQkM1Ekj1+mGj9r7sZraOI7yulGrPQEaAC1Q==
X-Received: by 10.28.88.144 with SMTP id m138mr2891367wmb.79.1470397925042;
        Fri, 05 Aug 2016 04:52:05 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id bc10sm17486987wjc.32.2016.08.05.04.52.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 04:52:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 01/10] pkt-line: extract set_packet_header()
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <51080fb7-2bab-a100-0971-e82063c1ac78@gmail.com>
Date:	Fri, 5 Aug 2016 13:52:03 +0200
Cc:	git@vger.kernel.org, gitster@pobox.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net
Content-Transfer-Encoding: 8BIT
Message-Id: <1DDE4AD4-C87F-42BE-AE88-BE302A0D208A@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/> <20160729233801.82844-1-larsxschneider@gmail.com> <20160729233801.82844-2-larsxschneider@gmail.com> <4081bc44-d964-79ec-165f-f49f33823c17@gmail.com> <73AED3FA-C666-4C49-90B2-387E410F7D52@gmail.com> <51080fb7-2bab-a100-0971-e82063c1ac78@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 03 Aug 2016, at 22:05, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> [This response might have been invalidated by v4]
> 
> W dniu 01.08.2016 o 13:33, Lars Schneider pisze: 
>>> On 30 Jul 2016, at 12:30, Jakub Narębski <jnareb@gmail.com> wrote:
> 
>>>> #define hex(a) (hexchar[(a) & 15])
>>> 
>>> I guess that this is inherited from the original, but this preprocessor
>>> macro is local to the format_header() / set_packet_header() function,
>>> and would not work outside it.  Therefore I think we should #undef it
>>> after set_packet_header(), just in case somebody mistakes it for
>>> a generic hex() function.  Perhaps even put it inside set_packet_header(),
>>> together with #undef.
>>> 
>>> But I might be mistaken... let's check... no, it isn't used outside it.
>> 
>> Agreed. Would that be OK?
>> 
>> static void set_packet_header(char *buf, const int size)
>> {
>> 	static char hexchar[] = "0123456789abcdef";
>> 	#define hex(a) (hexchar[(a) & 15])
>> 	buf[0] = hex(size >> 12);
>> 	buf[1] = hex(size >> 8);
>> 	buf[2] = hex(size >> 4);
>> 	buf[3] = hex(size);
>> 	#undef hex
>> }
> 
> That's better, though I wonder if we need to start #defines at begining
> of line.  But I think current proposal is O.K.
> 
> 
> Either this (which has unnecessary larger scope)
> 
>  #define hex(a) (hexchar[(a) & 15])
>  static void set_packet_header(char *buf, const int size)
>  {
>  	static char hexchar[] = "0123456789abcdef";
> 
>  	buf[0] = hex(size >> 12);
>  	buf[1] = hex(size >> 8);
>  	buf[2] = hex(size >> 4);
>  	buf[3] = hex(size);
>  }
>  #undef hex
> 
> or this (which looks worse)
> 
>  static void set_packet_header(char *buf, const int size)
>  {
>  	static char hexchar[] = "0123456789abcdef";
>  #define hex(a) (hexchar[(a) & 15])
>  	buf[0] = hex(size >> 12);
>  	buf[1] = hex(size >> 8);
>  	buf[2] = hex(size >> 4);
>  	buf[3] = hex(size);
>  #undef hex
>  }
> 

I probably will drop this patch as Junio is not convinced that it
is a good idea:
http://public-inbox.org/git/xmqqd1lp8v2o.fsf%40gitster.mtv.corp.google.com/

- Lars

