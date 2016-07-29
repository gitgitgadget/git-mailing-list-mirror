Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A9A1F71B
	for <e@80x24.org>; Fri, 29 Jul 2016 11:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbcG2LbL (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 07:31:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35037 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbcG2LbJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2016 07:31:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so15312861wmg.2
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 04:31:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=l44B/WY3U+sMCnKrLxvoWPuCsbd75V2uDwUuna7bD+Q=;
        b=rqXR8hM+poBRegncDv4yVXozYAYTVKA0eWu2eECEKvCOTOMabeUMSuzlyd+5LWaMVn
         +n/UgXPsMBtH+GaiMlzHQ81UDxcOkrw83jOzXlcqPQ+R5Nfy67mW0V9LCrtZOlhMhvGB
         KSfJL20oIFGZ8RZUCj2gDBWNxkakJ7H7m/Yaj2Gh3DXU52H2SHV7cnUXWAKmgoFlcXZY
         eQ1GnA1KfOZ85dEoKNb61fT+PJXvceUBlw5A01qwsBIRXRPuatpiEOWAZzarsIL4n8Mi
         KQXzKcijujE8OhegGwFSSdOu0nhWKuuEIs4sDxf+zyK33kEf6DGenihzP1Zr7jkd12ac
         lfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=l44B/WY3U+sMCnKrLxvoWPuCsbd75V2uDwUuna7bD+Q=;
        b=HOBo+g1RsufS0+kfMRpaGsboBK6IfWSl23QqBt214gOd3d50nM+K9HxKDt2LCWcu+t
         vzMw6Taupio+t9ZIgFcN+W2ODhlCJEwBAMJ1Hq+NE0VsAHHehDDdACXv9+fqeKwPZEmZ
         mpKajjDgdDeD+39dec+gcfuAt1fBtDg1qdyaEvemVx6lgzlz4bp5hVQlqQ3vmMHHBRAi
         MUeE5rcpLpSia4cCN/CGA1ujAe0uypEygUPkJM9tuXL9i3mB0SdTKplb8gc4S16LS1KJ
         7ltHkjCPDctFMuFq2+MPpKoy0dGCbXfjz2QbSYs9KNdHMet/K6c0qq/Bx42Lk4p6nbst
         rzDw==
X-Gm-Message-State: AEkoouvncLPxFwfr9nlkAH8aEgWB2r8aeFxoYNXuoICkcKG4xHj18hJfczKlKDYbUHKdXw==
X-Received: by 10.194.187.134 with SMTP id fs6mr9105471wjc.3.1469791868178;
        Fri, 29 Jul 2016 04:31:08 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id a194sm2569233wmd.24.2016.07.29.04.31.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 04:31:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <579B3CFF.6040601@gmail.com>
Date:	Fri, 29 Jul 2016 13:31:06 +0200
Cc:	Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
	gitster@pobox.com, tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	ramsay@ramsayjones.plus.com, peff@peff.net
Content-Transfer-Encoding: 8BIT
Message-Id: <C6CC2E23-5E9F-4A88-B80C-FC4AC16F5BEC@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160727000605.49982-1-larsxschneider@gmail.com> <20160727000605.49982-6-larsxschneider@gmail.com> <20160727094102.GA31374@starla> <64C7D52F-9030-460C-8F61-4076F5C1DDF6@gmail.com> <579B3CFF.6040601@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 29 Jul 2016, at 13:24, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> W dniu 2016-07-29 o 12:38, Lars Schneider pisze:
>> On 27 Jul 2016, at 11:41, Eric Wong <e@80x24.org> wrote:
>>> larsxschneider@gmail.com wrote:
> 
>>>> +static off_t multi_packet_read(struct strbuf *sb, const int fd, const size_t size)
>>> 
>>> I'm no expert in C, but this might be const-correctness taken
>>> too far.  I think basing this on the read(2) prototype is less
>>> surprising:
>>> 
>>>  static ssize_t multi_packet_read(int fd, struct strbuf *sb, size_t size)
>> 
>> Hm... ok. I like `const` because I think it is usually easier to read/understand
>> functions that do not change their input variables. This way I can communicate
>> my intention to future people modifying this function!
> 
> Well, scalar types like `size_t` are always passed by value, so here `const`
> doesn't matter, and it makes line longer.  I think library functions do not
> use `const` for `size_t` parameters.
> 
> You are reading from the file descriptor `fd`, so it state would change.
> Using `const` feels a bit like lying.  Also, it is scalar type.

OK, since you are the second reviewer arguing against `const` I will remove it.


> 
> [...] 
>> I agree with your reordering of the parameters, though!
>> 
>> Speaking of coding style... convert.c is already big and gets only bigger 
>> with this patch (1720 lines). Would it make sense to add a new file 
>> "convert-pipe-protocol.c"
>> or something for my additions?
> 
> I wonder if it would be possible to enhance existing functions, instead
> of redoing them (at least in part) for per-command filter driver protocol.

I think I reused as much as possible.

Thanks,
Lars
