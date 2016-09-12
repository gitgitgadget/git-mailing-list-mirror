Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA1EE20984
	for <e@80x24.org>; Mon, 12 Sep 2016 11:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756193AbcILL6A (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 07:58:00 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38687 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757549AbcILL57 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 07:57:59 -0400
Received: by mail-wm0-f44.google.com with SMTP id 1so140191905wmz.1
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T54Z6h1Riie+ZBsc4nAEYRjHT7Lh8uqEpzhbQxjQYyU=;
        b=AcdaUnOQWk8E2PLri+Vj5D0ZVvOMb2EbVIfHWV66p39Ujhmm7cEHs5Rvao80kDdddh
         xLP3Uf9l3ksPJDkTHAeSB+j0Os0goAZgFDv824TqHd3pMqmA4PqOxBO6p0nCPFAgZIvt
         3zrSiwCw0loAeGQPFHmUh/rdeSAUb1uPstsVXDZt1CpOZY6i/aZP4cu5VWDdm+WpdqZB
         nSAv7gHtvC8HvFdHbZg6vqM7bt5wxLiReqWWyblEiMSzNdHgHG/UTuRN9ymEofVVesLY
         IZDcbPNff5wPM952dw3uvNt/XjdeVl1JPnL6mzeaJdJpNBvXDuMjoK15TbVuW3JpS6bZ
         C4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T54Z6h1Riie+ZBsc4nAEYRjHT7Lh8uqEpzhbQxjQYyU=;
        b=ZYZXSQ+apnBhzEA0/4R3RNylifZNwzr1o4Bn+mviouFnWGiBOhnIn4lA+reCPfixJT
         sx2o0AlJ6/h0LXQLX3xtPBno565wciwy5j6I6dI0bHFdl+dhrl/ba68PmclZXZj9rXUT
         W1QWKOsIaKr8PWbjCtRvzfnNJcEsVnUxK9CTqUEnRFGV9xr2g3RSE38p0LVle6zZILSE
         3mZwbcIQaTwpJcjMsymdgZeiIaPCvxuYSdG6il8Xp1j2b4KF+2BnE7/k+s4Rs7P9+Ap7
         Iu2qFwBW2wUUcDQlt14zhVWB7jp1orVBOWf+qYnRwFW2DxSBw1QAB3oM7B0eximMjNbS
         JOXw==
X-Gm-Message-State: AE9vXwNXVPOg+lLHv2vMaIGZ2PHeFz68AyexwbogZXrHj7xwYBD+JoeGU2PD8EKki5G4Jw==
X-Received: by 10.194.141.13 with SMTP id rk13mr14051905wjb.25.1473681478506;
        Mon, 12 Sep 2016 04:57:58 -0700 (PDT)
Received: from [172.31.96.158] ([91.231.145.254])
        by smtp.gmail.com with ESMTPSA id q139sm17515399wmb.18.2016.09.12.04.57.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 04:57:57 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 03/10] pkt-line: add packet_write_fmt_gently()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAGZ79kZaRdJqbjfacdxT5eqOaK-RObJo+AddZ8heaU-KzWCOwQ@mail.gmail.com>
Date:   Mon, 12 Sep 2016 11:22:24 +0200
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <0365589B-7733-4C97-A566-957BACC67B29@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com> <20160908182132.50788-4-larsxschneider@gmail.com> <CAGZ79kY0GaWuuh_MzKL6FZ7KWF2Kwhfh9qnEYd-qX8VDQWNmCQ@mail.gmail.com> <714C1346-6A7D-4A8B-AAA2-BA936EB6B739@gmail.com> <CAGZ79kZaRdJqbjfacdxT5eqOaK-RObJo+AddZ8heaU-KzWCOwQ@mail.gmail.com>
To:     Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 Sep 2016, at 18:01, Stefan Beller <sbeller@google.com> wrote:
> 
> On Sun, Sep 11, 2016 at 4:36 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
> 
>>> 
>>>   call check_pipe from write_or_die here instead of
>>>   reproducing that function?
>> [...]
> 
>> Maybe it would be more suitable to move check_pipe to
>> run-command.h/c?
> 
> That's certainly possible.
> I don't have a strong opinion, where the code actually
> resides, but I do have a strong-ish opinion on code
> duplication. ;)

OK, then I will move check_pipe() to run-command.

Thanks,
Lars

