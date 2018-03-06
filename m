Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 336391F404
	for <e@80x24.org>; Tue,  6 Mar 2018 23:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932892AbeCFXBB (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 18:01:01 -0500
Received: from mail-pl0-f43.google.com ([209.85.160.43]:36000 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932604AbeCFXBA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 18:01:00 -0500
Received: by mail-pl0-f43.google.com with SMTP id 61-v6so198034plf.3
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 15:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wLu5qgFFJHGa3mchY62rmvB/u57GJepAOPNpV2xZgNI=;
        b=SRdlXfIpAgzmBN9S/lP8By46DJpq9keF2gu8Ea5rYmN2kdqM1MjNpTkTu5IF968yQ/
         juOIsrrhTf9psaVF4scQadufZR5UZ9x/UvzfgcE6t7BSeTTr1Tg9K8MpLEtoZoC3cS6J
         jRTBmJBRCpoccoswU7qWOjacNbjM8zok+YOlfzQwcYQ2f8Qyg0yckiP/IEc/fa+4OEt0
         8fdV5xDMszysXd26p00NVM9FtgE472wj0HVURrt+OH+OKNk55FMjGU7ogWVueqU6sdhq
         +Ydi0wCqa6GXmQcXpnM48u/llb58XojXDGtjOKP5QGTzj+I/6etkU/LvsI8avEOXklIh
         lDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wLu5qgFFJHGa3mchY62rmvB/u57GJepAOPNpV2xZgNI=;
        b=awNtfETZ2E2E5Uply0AaL63nnLBU3Hgm03cJMS6HyPC6pF18a4KIYac+Q+gGVb9aJV
         9NSH6YicEQmPDOVVuhj/c1L8c3fEUL/r9Tz4EKLlqYnen2itV5JUX5JcA5WwINKumWj9
         +LSPPgUe5wrb5ZeEUXEO6Nvborwuplt4z2U8Upr2OfieDKIa8BXotsn5+m0ok6r+xN4g
         Pb+er17P1EfwdSya7hXJIwr9+N0hJG/B0+YWQgAF8/LvnSBfmThi4kiJ03tdDgsjNydC
         G11TEL494fy2c5kIUtXRg0zMoodhbyDg69PZKGvDUpJfwDXhcVLBPUPizWJdFeUEjkzg
         2ojA==
X-Gm-Message-State: APf1xPBoIR1IB8OA9ZL78anGuFokorsIOQDa+cLWoDnesvtXU6s3YlOf
        6b+SxQZAaMsrIVrGuz2XI/s=
X-Google-Smtp-Source: AG47ELsp26IpQ0suDq2fD2YvawulyI89pINdWKdQ8OjPhQxvm++KoE/Gw3ByeERY7KJZCSyP6HtR/w==
X-Received: by 2002:a17:902:4201:: with SMTP id g1-v6mr18199904pld.62.1520377259852;
        Tue, 06 Mar 2018 15:00:59 -0800 (PST)
Received: from neu8r3hm32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id k83sm37638234pfg.110.2018.03.06.15.00.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Mar 2018 15:00:59 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v9 4/8] utf8: add function to detect a missing UTF-16/32 BOM
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq8tb43jfe.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 7 Mar 2018 00:00:54 +0100
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: 7bit
Message-Id: <CF78BB76-B42C-4A83-B18C-3FBAB0339346@gmail.com>
References: <20180304201418.60958-1-lars.schneider@autodesk.com> <20180304201418.60958-5-lars.schneider@autodesk.com> <xmqqvae92ajv.fsf@gitster-ct.c.googlers.com> <0DCED348-C6DB-49B2-8C0A-E4E1F485B255@gmail.com> <xmqq8tb43jfe.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 06 Mar 2018, at 23:53, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>>> Also "UTF16" or other spelling
>>> the platform may support but this code fails to recognise will go
>>> unchecked.
>> 
>> That is true. However, I would assume all iconv implementations use the
>> same encoding names for UTF encodings, no? That means UTF16 would never be
>> valid. Would you agree?
> 
> After seeing "UTF16" and others in "iconv -l | grep -i utf" output,
> I am not sure what you mean by "Would you agree?"  People can say in
> their .gitattributes file that this path is in "UTF16" without dash
> and that is what will be fed to this coe, no?

On macOS I don't see UTF16... but I just checked on my Linux box and
there it is. Consequently, we need to check both versions: with and
without dash.

I'll reroll ASAP (I try to do it first thing in the morning).

Thanks,
Lars
