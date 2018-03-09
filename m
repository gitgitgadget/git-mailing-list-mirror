Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C89C1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 15:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbeCIPyc (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 10:54:32 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:55033 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeCIPya (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 10:54:30 -0500
Received: by mail-wm0-f42.google.com with SMTP id z81so4734227wmb.4
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 07:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KbuamIHKK/qk1QxzoRYTiE7+1CPTCaJyk2S+Ry3Qbjs=;
        b=f2JTdvLG36mUEtSeOwWNKz9bQCr3maBeAGpyuH2sVILcb/k+GskC1XNHvB3tHNLiaH
         peKKlUCEWil5ni3nHDQGL1xq6OrzBPgXx5kRNig3GIxZFNZZ2mQkiOdBsEbPziAKjVGA
         jNmYuxp2JTGvfMgmx19MlkZg08vEVcjzWIUzC2VQU3b0lk4E22fxr+vKVO6CDTi93VGt
         tix8ptFZz6ZREyUqxfJ+aDO5/qSu/Ng8MV21Oi34sY96jwoYB+P9X4y2KXTfMcwL02Oz
         3Fler4IEKrOZqIciTtkpEG6qy+YtY0+C2ozfl2RGKC5CBLxcgcpQ7ALxnhUEagO8vD2p
         nvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KbuamIHKK/qk1QxzoRYTiE7+1CPTCaJyk2S+Ry3Qbjs=;
        b=m2NnyU1IUh2Wi4fmzCsWI0PiUkuN9iTHmjTVncW0pDslm8QC2NnJjSUjLJ6lGW89v3
         Kk83G1RtSGdc44+bS8+slLt4/o7qkHvu8JmzoKSyB0kJ4FLkcHW8lbus9m933SXL0L5N
         EIOuHjRGhy8MrUulpIRinNlJXZT2kelNbkP6ncUcGK8Z7OFqXYZf1EOqbK7WRoZeU32/
         uMGg+6kzWlIRM0Jk4PIpKLPyWfxPcA78IRkuDA5O/3qtgJRSFzMbOrGLC7cJ36afYfNt
         iIjSXd3HwE4DIjACIsqWUouBsuJbaIdyrZEmf++Jx3sSCTRjtuCrq0Zep4JxZwIyOoNO
         mQkg==
X-Gm-Message-State: AElRT7FkidqmjbVr1p/xekyAEiq2exPsnz+Nuwq2P8pc6fLYJogS4w4n
        o5xx8nm2Qb6ZSX/Q9JGOmVQ=
X-Google-Smtp-Source: AG47ELss/hrHTWBb+vIFFxVEC58gN2wyKO0B20BqJLiUbhyNfl0v2CGRMqcF99ZLRI6vH42G80bLaA==
X-Received: by 10.28.141.131 with SMTP id p125mr2450756wmd.0.1520610869298;
        Fri, 09 Mar 2018 07:54:29 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB50CB.dip0.t-ipconnect.de. [93.219.80.203])
        by smtp.gmail.com with ESMTPSA id e17sm1197437wri.42.2018.03.09.07.54.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Mar 2018 07:54:28 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v10 3/9] strbuf: add a case insensitive starts_with()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq4llq88ms.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 9 Mar 2018 16:54:30 +0100
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Transfer-Encoding: 7bit
Message-Id: <7920610F-8B51-4E8F-83C6-7B29D0EBF852@gmail.com>
References: <20180307173026.30058-1-lars.schneider@autodesk.com> <20180307173026.30058-4-lars.schneider@autodesk.com> <CACsJy8DWMmC9mvz783XQFHUopbVMH00LoqpW-CQunzg0qgiEEA@mail.gmail.com> <xmqq4llq88ms.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 09 Mar 2018, at 00:12, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Duy Nguyen <pclouds@gmail.com> writes:
> 
>>> extern int starts_with(const char *str, const char *prefix);
>>> +extern int startscase_with(const char *str, const char *prefix);
>> 
>> This name is a bit hard to read. Boost [1] goes with istarts_with. I
>> wonder if it's better. If not I guess either starts_with_case or
>> starts_case_with will improve readability.
> 
> starts_with_case() sounds quite strange even though
> starts_with_icase() may make it clear that it is "a variant of
> starts_with() function that ignores case".  I dunno.
> dir.c::cmp_icase() takes the _icase suffix for not quite the way
> that is consistent with that understanding, though.

I think following the boost lib makes most sense. Therefore,
I would like to go with "istarts_with". OK with you?

- Lars
