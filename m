Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26F481F404
	for <e@80x24.org>; Sat,  7 Apr 2018 18:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbeDGSji (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 14:39:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33780 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbeDGSin (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 14:38:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id o23so11749218wmf.0
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 11:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+RQ1DsB2MKvHa8So55tEaLDt6OFxMWyAIoFmj8bHmog=;
        b=WTne9bdQUhCzXUlA+/wDb6g2dzOr+hho8vOik3OWTtrZ2PN+RYtaVD8V0jrqea+SJ0
         tZef60wrE8Lb3fNzBgGPB8ey2NU0tBbw+nDq3vJGTHamnV9xm2gVCsJR63+NHuZjMEq9
         aPHrBH6u9JWeEh1uXoWyy3xi5BbRC+lHVUVwzNtdaNgSq6WvniwmPIbKTWF5gKBnQniy
         gcOxKaPXh9BNRoW9TKnmDkOb8OcgJo0pLTKmnfSO6NfXOjqthu6U7F2WlpO/J+HPG/FB
         Hg2wZ65eu2vchGCseAnxredrG6FAchoKGl+D+HBz3HoloP7gay0M15b3TKGMlLcEmoNj
         SrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+RQ1DsB2MKvHa8So55tEaLDt6OFxMWyAIoFmj8bHmog=;
        b=IKengfukoTWGFao2xm2T3BBN1fUug4Se92dvY0gkvbHiMlyOqznv90RwvPitlFn0Xc
         hdn+14dJa5XchdzDaSG0x0H7w/A2GfBkt1ELrQ29aGltxdRzgYpK0YBnxoYm2JSGFeBa
         AfNVUaBLKRYYXsqsMh7lyN6y6o3Z4krvdRSElkrk8xE9NG6di5Tuttv2ybIDRH44eWjE
         XeBgakKZ30+w8nOsLgWpUzhVW673H0S7uQSshCw5JSmIr9BE8tGJYKHp0qGJurEkfpDJ
         8MxP68bapSdy/dZ2vQQRRiSFjqCnJUyiZ3KQ6sPz8DFPOhdiAcd45+alfRqfgrYqfeoU
         n45w==
X-Gm-Message-State: ALQs6tDftnfyQaIc5XIt6wjBIR22M46PcYKOcmO+IO0jKtIp3MFfUMQd
        h2b+m+AhMjBUprIBIiGD6u1ujmo7
X-Google-Smtp-Source: AIpwx4/AD8B4PJ4AZAnqnyswAoUEAI8NGH5ZV18o2l4LCOSMJoyuVoVQINFNP6sN+4mAPcp5rwQeDg==
X-Received: by 10.80.212.41 with SMTP id t41mr12977291edh.75.1523126322388;
        Sat, 07 Apr 2018 11:38:42 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id j36sm8511814ede.97.2018.04.07.11.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Apr 2018 11:38:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        ric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/3] Makefile: untangle DEVELOPER and -Werror
References: <20180329150322.10722-1-pclouds@gmail.com>
        <20180331164009.2264-1-avarab@gmail.com>
        <CACsJy8CyB0igY365NMkswSgAi9_rf+XBOMQyJ7XW6iQxQiCEyQ@mail.gmail.com>
        <87woxove8d.fsf@evledraar.gmail.com>
        <20180403151700.GA24602@duynguyen.home>
        <20180406214236.GF7870@sigill.intra.peff.net>
        <CACsJy8BOVnu+HXcVbkTKW6YZ8vQnwbAcaF4d2CzUbQLrZjuOJg@mail.gmail.com>
        <87r2nryz0j.fsf@evledraar.gmail.com>
        <CACsJy8BNmKTweFiUgDtSfor7OYk1akzcPbLxadA7YfSZ56eCJQ@mail.gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CACsJy8BNmKTweFiUgDtSfor7OYk1akzcPbLxadA7YfSZ56eCJQ@mail.gmail.com>
Date:   Sat, 07 Apr 2018 20:38:40 +0200
Message-ID: <87po3azwsv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 07 2018, Duy Nguyen wrote:

> On Sat, Apr 7, 2018 at 2:36 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> Anyway, I see you've pushed a new version with DEVOPTS. I'll submit mine
>> on top of that once your new version lands (unless you want to try to
>> integrate it yourself).
>
> Actually I think I'll just drop both EAGER_DEVELOPER and DEVOTPS.

OK. I'll submit something on top to optionally get rid of -Werror, since
that's the only bit I actually care about & have a use-case for.
