Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08FFB2018D
	for <e@80x24.org>; Thu, 11 May 2017 02:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753492AbdEKCRJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 22:17:09 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35494 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbdEKCRI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 22:17:08 -0400
Received: by mail-pg0-f49.google.com with SMTP id o3so6742269pgn.2
        for <git@vger.kernel.org>; Wed, 10 May 2017 19:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=EnmP9X/qeYg3sw/ZLPRUhBkzaEeIKLdpPtQ7nz/NneE=;
        b=Jx2YuhK7XNM8Wx+37wsaS+hAL3b960RExDH8q/vsviEMte6lQLcUWM1rN4dVuHThTH
         7g4SHeCnZLHj+5yUZVTHRr4+JdtlxtENhdTxtvlR3AsIdNSEoVuQD5B/u5P46njfT3fI
         s+bvDf5ORoBDqzvKgYjWl83TUkoLNZGnMQebTpUMITHbjOjpONXu+w/LrD+cBodfvC9J
         ovU7ZTDypIQC+zqLJwzL/Xubkv44dlacCOR6mWAeGSj8yPdpTslhWA6498HXYB5I2HoD
         WmJAGrUAmh4uGH/1OkO+R9BDnVfvK42jvI3xErUqHxIsSi5nHPP3ryl6EjvRcw7QGTFG
         BMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=EnmP9X/qeYg3sw/ZLPRUhBkzaEeIKLdpPtQ7nz/NneE=;
        b=HiMT5b93cHcxxWTA+vMKYy5Eqz1iSGGwuM8WyIE7Q4rZuayub75vWzyYRivZ+tie09
         /QKBzPhdJy5h++WQue3UBYK0a5yggNpfgNbQ0m11NRCvHYVB9PWkf8AFQJDiR5JK8UkS
         S2OxORtaxQiG0CVTDqkrl8qd6ls9TDnz0dmaOrEl0Zr8LdS+sqpsn5EUdwqsDO0Hec2W
         CxN2jhxHV6Pssr09QGWNCkKx436pkG1yELXccWLr0KUYeBTMyOP7AXvVcjL7dackEIcZ
         RFc3JhEarzIwD+aySFbUvUUPTp4tl7fEYdBndTHsFlf/xaXDkWfLhl1B9njPzlhFsTwU
         ZMfA==
X-Gm-Message-State: AODbwcBhyVQhOdTlnOuMLfItnzJqHRBpKpkce73M+pDdy79wbhfwusqc
        FANmHYs+TiKK+klPdZQ=
X-Received: by 10.84.179.193 with SMTP id b59mr12573116plc.56.1494469027913;
        Wed, 10 May 2017 19:17:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4994:7ba7:e883:c475])
        by smtp.gmail.com with ESMTPSA id 84sm330536pfi.88.2017.05.10.19.17.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 19:17:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torstem =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "larsxschneider\@gmail.com" <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 1/1] t0027: tests are not expensive; remove t0025
References: <11da00e8-a62c-bf07-d97e-ab755647082b@web.de>
        <20170510140619.22808-1-tboegi@web.de>
        <alpine.DEB.2.21.1.1705101746470.146734@virtualbox>
        <7BD61CA1-47DC-481D-8491-5945333C8E55@web.de>
Date:   Wed, 10 May 2017 19:17:06 -0700
In-Reply-To: <7BD61CA1-47DC-481D-8491-5945333C8E55@web.de> ("Torstem
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Wed, 10 May 2017 21:55:22
 +0200")
Message-ID: <xmqqziekcf31.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torstem Bögershausen <tboegi@web.de> writes:

>> Am 10.05.2017 um 17:52 schrieb Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> 
>>  ...
>> While at it, retire t0025: Recent "stress" tests show that t0025 if
>> flaky, reported by Lars Schneider <larsxschneider@gmail.com>, but all
>> tests in t0025 are covered by t0027 already.
>> 
>> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
>> Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> Ok for me, thanks for helping out.

I'll do a s/if flaky/is flaky/ and queue it.

Thanks, both.  

