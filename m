Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C13BF1FAE2
	for <e@80x24.org>; Thu, 18 Jan 2018 11:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754094AbeARLgI (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 06:36:08 -0500
Received: from mail-ua0-f169.google.com ([209.85.217.169]:33456 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752062AbeARLgH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 06:36:07 -0500
Received: by mail-ua0-f169.google.com with SMTP id z47so15348827uac.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 03:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LZfP5LjKdneUsoJGvk2LDjOFjUU5dBzC90KUJFPgItY=;
        b=MXPWXwgDX8SJU3Q/gUi/Ok20SgkdTL6qVNhQoE0OebsR8TaGiU/3KCp4j1W7vSVjXP
         d3T7o/SLMG5PYcYpZqBg+y1OugkD5ZLjJWtY9x0jap9bgvnd/Mq9SfDbZlfEqyCMr0m1
         9/SvDootIScRosZMgiZR/+xVOnh3NeVQX14g3HPrusgc6PMYXRkdZxPT1aaxxzvzzssb
         bQXORDLcfbhlQS0oojNGp79dvZNUH2L4jGoBouMnGxXZmVvdtZ5klWU4neCVVUJSg6E2
         5QOd05fN5tSC2MUO5fLirLRUCvmXCvoB1wmqphIzjtHNeHQk7HjwYU4nJSZ5EXieBgJM
         Atrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LZfP5LjKdneUsoJGvk2LDjOFjUU5dBzC90KUJFPgItY=;
        b=hPYYlKEPIZu2NZ/VMEyH6dEI0savCZS08d6hBuiEsxz20ORD01x4c07C+okGYRx6xA
         JO9zKl+r3dOoip4eRo1VPJ6Jn1M1ft0qsEG8tzPlLdpTVOgvAARYiGn8lkoOIhxo1Yc9
         F+aWbrw4t4GDkHxbG0lX7ai0OAggeIKkZ4ksXFXRshDPLGTwb5BNRit/oda/mT53+db0
         O9EA5M1mblwQ3RmC5RlaSZdKfnTVA47mXCRp9gZp8osDyZwiYRQW1squD6ER+tVm9QNW
         ItIfC6/gQk5H2fB26wQn4REK4bSbTRpATkPV6FJ0J13L8Zzw3SO148LMSEEvsj2bu2XP
         3gfw==
X-Gm-Message-State: AKwxytcQao0w4hSODsFPBmE112c9Nd3rqwI/h+D+9SoBJeO8394oBGZe
        blcVUhJ/mB6+gW7AVGMyJrDfLg0e/GPOpQFM3yg=
X-Google-Smtp-Source: ACJfBosN15CtD1m0lxEBTgZI8fm+hZTbBRJqAnQ4zcg/qi/NI1OZMZ8Hve9cr79qc2XJlcJ5U0lR4KlK+gVdDN8Almc=
X-Received: by 10.176.76.43 with SMTP id l43mr4502590uaf.93.1516275366853;
 Thu, 18 Jan 2018 03:36:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.10.140 with HTTP; Thu, 18 Jan 2018 03:36:06 -0800 (PST)
In-Reply-To: <20180114101820.4273-3-pclouds@gmail.com>
References: <CACsJy8A_moFProjfPAJFn2aP52w5qdYdOu4Ygox1qMMitNUHLg@mail.gmail.com>
 <20180114101820.4273-1-pclouds@gmail.com> <20180114101820.4273-3-pclouds@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 18 Jan 2018 12:36:06 +0100
Message-ID: <CAM0VKjmGo5gjUBpTQp9M+pvZzBMDAmYYCu-5VfG-8LYRxU7i0Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] read-cache: don't write index twice if we can't write
 shared index
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series, queued as 'nd/shared-index-fix', makes the 32 bit Linux
build job fail on Travis CI.  Unfortunately, all it can tell us about
the failure is this:

  Test Summary Report
  -------------------
  t1700-split-index.sh                             (Wstat: 256 Tests: 23
  Failed: 1)
    Failed test:  23
    Non-zero exit status: 1
  Files=809, Tests=18491, 401 wallclock secs ( 7.22 usr  1.60 sys + 263.16
  cusr 49.58 csys = 321.56 CPU)
  Result: FAIL

because it can't access the test's verbose log due to lack of
permissions.


  https://travis-ci.org/git/git/jobs/329681826#L2074
