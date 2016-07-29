Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFA831F71B
	for <e@80x24.org>; Fri, 29 Jul 2016 11:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbcG2LZJ (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 07:25:09 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37002 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbcG2LZH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 07:25:07 -0400
Received: by mail-wm0-f47.google.com with SMTP id i5so147487295wmg.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 04:25:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=TpmLGAugVCOEQ64R1gAZV+ozGR076ShaYXJ5rYsl3aA=;
        b=WKeS5bqMX89bGETPQmqnguqYIGZvlRT9PCu0P2i749xXBk0ka9NSIqfe6bkrphucil
         KuiPccv14lBV/ZxgT1jRsB6pku8MhcUFJLaTOLjx54IZoX2AbWhgASQSpwtw/vX58RD4
         8Ppaeb71S22SpPivgJJlO+ZlxUs1jIx/4QDu+8TZ4tI2YaXIvdSYAcPlkdTpkaOsm2bO
         AgGgaJ/EeWAa7sal+LRuBmwcXOF/4jV6sSp5Q0eCHYK4h0IFKhS9LEe40whiLFN/GUd5
         mEDrcYGugbNlc/4KvTvl+ZXRkx3c7fTL++6ZhfEej/2hjjBIo6905YOt8HEf3GtNpa5o
         EruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=TpmLGAugVCOEQ64R1gAZV+ozGR076ShaYXJ5rYsl3aA=;
        b=BVoS8d9aFHQpuQR5qQX57t+1ccCObO3SkBGt/i5MfuMBBOhG+7ei3Lzhgjt2vjeJzp
         HbMnbK/PBdZyanYHPWm+AkpG+v3aS/nbsJESmawYQo3tDZhPzJ0R+rCF2uaxxQz5GHu0
         naWWYf5dWpwIfHfoUiHgr1g88rapADLgZTdjTtMHi4uZMPJCfF0NlJjsunu2N/5+ZqTx
         BHUw+0BRChGPz0P52YYiD7qnXvWVfSHCvpCOXYy3J84D8iDbs1hjpAzp3CNrhA5iYs2t
         667lK7WiywnVvqmdj9HexqgLlaPo/ucapkZf3aiPjyqaX6mC/r/28QEW0r/e3YhvVYcH
         fVEA==
X-Gm-Message-State: AEkooutGn0Xus4NJ1izvTAk6m/liLW9uaHuIYClfGGWWemC1ucpE+RRlxEqVKGCNQDI55g==
X-Received: by 10.28.86.65 with SMTP id k62mr619271wmb.53.1469791505093;
        Fri, 29 Jul 2016 04:25:05 -0700 (PDT)
Received: from [192.168.1.26] (ewj64.neoplus.adsl.tpnet.pl. [83.20.233.64])
        by smtp.googlemail.com with ESMTPSA id w129sm2581877wmd.9.2016.07.29.04.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jul 2016 04:25:04 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
To:	Lars Schneider <larsxschneider@gmail.com>, Eric Wong <e@80x24.org>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
 <20160727000605.49982-6-larsxschneider@gmail.com>
 <20160727094102.GA31374@starla>
 <64C7D52F-9030-460C-8F61-4076F5C1DDF6@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	ramsay@ramsayjones.plus.com, peff@peff.net
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <579B3CFF.6040601@gmail.com>
Date:	Fri, 29 Jul 2016 13:24:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <64C7D52F-9030-460C-8F61-4076F5C1DDF6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-29 o 12:38, Lars Schneider pisze:
> On 27 Jul 2016, at 11:41, Eric Wong <e@80x24.org> wrote:
>> larsxschneider@gmail.com wrote:

>>> +static off_t multi_packet_read(struct strbuf *sb, const int fd, const size_t size)
>> 
>> I'm no expert in C, but this might be const-correctness taken
>> too far.  I think basing this on the read(2) prototype is less
>> surprising:
>> 
>>   static ssize_t multi_packet_read(int fd, struct strbuf *sb, size_t size)
>
> Hm... ok. I like `const` because I think it is usually easier to read/understand
> functions that do not change their input variables. This way I can communicate
> my intention to future people modifying this function!

Well, scalar types like `size_t` are always passed by value, so here `const`
doesn't matter, and it makes line longer.  I think library functions do not
use `const` for `size_t` parameters.

You are reading from the file descriptor `fd`, so it state would change.
Using `const` feels a bit like lying.  Also, it is scalar type.
 
[...] 
> I agree with your reordering of the parameters, though!
> 
> Speaking of coding style... convert.c is already big and gets only bigger 
> with this patch (1720 lines). Would it make sense to add a new file 
> "convert-pipe-protocol.c"
> or something for my additions?

I wonder if it would be possible to enhance existing functions, instead
of redoing them (at least in part) for per-command filter driver protocol.

Best,
-- 
Jakub Narębski

