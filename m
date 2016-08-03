Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2C661F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 20:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758214AbcHCUHa (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 16:07:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34507 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757747AbcHCUH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 16:07:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so37963679wma.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 13:06:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=RCbpTs0muMiQQUtrschggLyfp1N/BKkAuDPkwavN8FM=;
        b=vviqLuf+5xTxu6AfyBBvZCd9yPhgEj7LrQ6MAB4sZZzD2bw91zvYvGAsA4QqVage/r
         JSUMsN27vD6CGmx+DgipY3FkIkre/4yoR4KRKVdVnmRoU9C/vORx9FSXFXSTEPcbGxqW
         /ky38ZGxjRMjzsL5G5cAwJfDCAcDZqmnwM+fLwMIvA5lMNvUr1QZxKl3oifbFyfaiLNv
         4XeROcN2E4ecmaTl/U7opgESmYRBVXXaaOJjO8HSUGt1Z6Z2wUK3tb6vA0szQXoaBnJU
         TQR58piqMKI8evSdbdyT/5AwO0fDIhLPwjd5Qs921ZrExfbrSkj/UiOGL/XbKWJOgTfZ
         1R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=RCbpTs0muMiQQUtrschggLyfp1N/BKkAuDPkwavN8FM=;
        b=NgxPmVxSEiGhsC6Nen8hM4kKXAsvdy7upzYhejfflHOJkkBbM9SdQ89HrWLXm2/YCK
         f3AF0esfpgPr7E48baAOcVZ0GjmKMgZwEUFkbJ5genuWZlnCT+qXsxHH9HuN3W+aCMoc
         3T6aaHJYKB4OhoYRnKCeKdYYiGpGpRIYwZAiAZpG90WW6ijUaV4NqWxS3Jq6UUKiGh/3
         CGDIclJUgxDZr+PsAlQHFA/xCTWG/qUOG7O8Pagv44lSPgE2iNYvVKpjbLjlf6FPAvdA
         zh9hu1yySzQuoi0R2qv6uqJ6fZw0vKIq3ndNtzV/y2GJAbZiyRzgiOnpceCWakJb3cYR
         teqA==
X-Gm-Message-State: AEkoouv70rS1IfU4rG3nj39qeact0bfD3mpDup3jehqS8bSMoudms0F1yEreHuxHi8sW1A==
X-Received: by 10.194.169.39 with SMTP id ab7mr71056449wjc.0.1470254775841;
        Wed, 03 Aug 2016 13:06:15 -0700 (PDT)
Received: from [192.168.1.26] (adbx179.neoplus.adsl.tpnet.pl. [79.184.23.179])
        by smtp.googlemail.com with ESMTPSA id t188sm49360wme.19.2016.08.03.13.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2016 13:06:14 -0700 (PDT)
Subject: Re: [PATCH v3 01/10] pkt-line: extract set_packet_header()
To:	Lars Schneider <larsxschneider@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-2-larsxschneider@gmail.com>
 <4081bc44-d964-79ec-165f-f49f33823c17@gmail.com>
 <73AED3FA-C666-4C49-90B2-387E410F7D52@gmail.com>
Cc:	git@vger.kernel.org, gitster@pobox.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <51080fb7-2bab-a100-0971-e82063c1ac78@gmail.com>
Date:	Wed, 3 Aug 2016 22:05:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <73AED3FA-C666-4C49-90B2-387E410F7D52@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

[This response might have been invalidated by v4]

W dniu 01.08.2016 o 13:33, Lars Schneider pisze: 
>> On 30 Jul 2016, at 12:30, Jakub Narębski <jnareb@gmail.com> wrote:

>>> #define hex(a) (hexchar[(a) & 15])
>>
>> I guess that this is inherited from the original, but this preprocessor
>> macro is local to the format_header() / set_packet_header() function,
>> and would not work outside it.  Therefore I think we should #undef it
>> after set_packet_header(), just in case somebody mistakes it for
>> a generic hex() function.  Perhaps even put it inside set_packet_header(),
>> together with #undef.
>>
>> But I might be mistaken... let's check... no, it isn't used outside it.
> 
> Agreed. Would that be OK?
> 
> static void set_packet_header(char *buf, const int size)
> {
> 	static char hexchar[] = "0123456789abcdef";
> 	#define hex(a) (hexchar[(a) & 15])
> 	buf[0] = hex(size >> 12);
> 	buf[1] = hex(size >> 8);
> 	buf[2] = hex(size >> 4);
> 	buf[3] = hex(size);
> 	#undef hex
> }

That's better, though I wonder if we need to start #defines at begining
of line.  But I think current proposal is O.K.


Either this (which has unnecessary larger scope)

  #define hex(a) (hexchar[(a) & 15])
  static void set_packet_header(char *buf, const int size)
  {
  	static char hexchar[] = "0123456789abcdef";

  	buf[0] = hex(size >> 12);
  	buf[1] = hex(size >> 8);
  	buf[2] = hex(size >> 4);
  	buf[3] = hex(size);
  }
  #undef hex

or this (which looks worse)

  static void set_packet_header(char *buf, const int size)
  {
  	static char hexchar[] = "0123456789abcdef";
  #define hex(a) (hexchar[(a) & 15])
  	buf[0] = hex(size >> 12);
  	buf[1] = hex(size >> 8);
  	buf[2] = hex(size >> 4);
  	buf[3] = hex(size);
  #undef hex
  }

