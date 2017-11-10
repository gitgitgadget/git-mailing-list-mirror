Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB961F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 13:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbdKJNiw (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 08:38:52 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52297 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbdKJNiv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 08:38:51 -0500
Received: by mail-wm0-f66.google.com with SMTP id t139so2830474wmt.1
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 05:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qRKsZQHRbOOFqif1i0MCmTcAddxjiEd4xPkvgOthNTk=;
        b=csDtLLUl0n/4HWKUkcalhbuFH2e4KyO5PX7kEEMwF3Rp1bEI8xh63F34JkhUYIhSE8
         tDnx7TGbkdiotzla6FLC39KAwlwLgUyd+AWk7un/AjuIrsN2PFJxygQ2OYYOh403/so4
         CiXv0BM29kQdcmyXubsN6+9QZhtgDK5Gq861bfr3acllovWeLDZAkCB6GfwpUcfx14U7
         n8IMfEf74msawa8hQ9zXOD3usOHnZjAg1n3WO2UF84O1r6pa7xjU0MlyibLRq8smSU+y
         sZAc3PPClzFJq4lPqO1Jn3mL5HsuX9K5uuVmcIoSAmsC64y6NI+RL9056VfUtqg1WKTt
         Okog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qRKsZQHRbOOFqif1i0MCmTcAddxjiEd4xPkvgOthNTk=;
        b=EN99Gm9HK0cjHJ7XN3q6F7zIA4TQOERBCDEWNzBWfpr7uA7FjPY1mX68KWy7VBnEhQ
         UcxMqd5mMb+fLMOUMOK9YfFXDP3xBrkTKJCwhBNSBXgNvmlwJPTPKrqziUPo9AJMzxLA
         Vqt9PJdsUzxO/oI9VafBRkPIIvWtR7ejx5r3BsCa6lYDzqXaNqNAfhcJseL3FOapY58m
         OcfBJ6pWz69wymJRptTxTbGsqiboqsJ35JrrgmSuoF6Fytm1Eyr48TNBERT1+2hYgnJ4
         F6CTuMhnDMVdiquE4RuajnpzO0jQpWjLW7s6pdVB8xdGNyUVmGG4DlKHsMSAF859lZvb
         Y7/Q==
X-Gm-Message-State: AJaThX4NeavxeF0urcdxCfH7KDI39T84OXjCoLPjCw9H76iLoQ4s0hPa
        TnhvtveI4B0+BFZ4Q9kTX8s=
X-Google-Smtp-Source: AGs4zMaUvZnIc1I+Kc1IT78uQ5Lmur7s4LIADYC7mI4NJj3gvlxnR3zP1kqtfIkmCNXhGSkCKxtFeQ==
X-Received: by 10.80.152.72 with SMTP id h8mr529004edb.9.1510321130578;
        Fri, 10 Nov 2017 05:38:50 -0800 (PST)
Received: from [192.168.1.22] (101.154.108.93.rev.vodafone.pt. [93.108.154.101])
        by smtp.gmail.com with ESMTPSA id w13sm8303946edk.46.2017.11.10.05.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2017 05:38:49 -0800 (PST)
Subject: Re: [PATCH v1 2/2] log: add option to choose which refs to decorate
To:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Cc:     git@vger.kernel.org, me@ikke.info, hjemli@gmail.com,
        mhagger@alum.mit.edu, pclouds@gmail.com,
        ilari.liusvaara@elisanet.fi
References: <20171104004144.5975-1-rafa.almas@gmail.com>
 <20171104004144.5975-3-rafa.almas@gmail.com>
 <xmqq60aqn1ok.fsf@gitster.mtv.corp.google.com>
 <B24042DB-BB27-41DE-82B7-5F3ED502D7D0@gmail.com>
 <xmqqbmkfhrf3.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Rafael_Ascens=c3=a3o?= <rafa.almas@gmail.com>
Message-ID: <89e7f8e0-8b0d-fde0-5e28-31173213a26e@gmail.com>
Date:   Fri, 10 Nov 2017 13:38:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmkfhrf3.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11/17 00:18, Junio C Hamano wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
> 
> I would have to say that the describe's one is wrong if it does not
> match what for_each_glob_ref() does for the log family of commands'
> "--branches=<pattern>" etc.  describe.c::get_name() uses positive
> and negative patterns, just like log-tree.c::add_ref_decoration()
> would with the patch we are discussing, so perhaps the items in
> these lists should get the same "normalize" treatment the patch 1/2
> of this series brings in to make things consistent?
> 

I agree that describe should receive the "normalize" treatment. However,
and following the same reasoning, why should describe users adopt the
rules imposed by --glob? I could argue they're also used to the way it
works now.

That being said, the suggestion I mentioned earlier would allow to keep
both current behaviors consistent at the expense of the extra call to
refs.c::ref_exists().

+if (!has_glob_specials(pattern) && !ref_exists(normalized_pattern->buf)) {
+        /* Append implied '/' '*' if not present. */
+        strbuf_complete(normalized_pattern, '/');
+        /* No need to check for '*', there is none. */
+        strbuf_addch(normalized_pattern, '*');
+}

But I don't have enough expertise to decide if this consistency is worth 
the extra call to refs.c::ref_exists() or if there are other side-effects
I am not considering.

>> That being said, if we think the extra glob would not cause
>> problems and generally do what people mean... I guess consistent
>> with --glob would be good... But it's definitely not what I'd
>> expect at first glance.

My position is that consistency is good, but the "first glance
expectation" is definitely something important we should take into
consideration.
