Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74ACB1F404
	for <e@80x24.org>; Sun,  1 Apr 2018 14:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753489AbeDAOTB (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 10:19:01 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:41139 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752890AbeDAOS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 10:18:59 -0400
Received: by mail-pf0-f179.google.com with SMTP id a2so5354601pff.8
        for <git@vger.kernel.org>; Sun, 01 Apr 2018 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZzOn5h1mbMKeXXZHD4xmyJh6jg96MHqbIIQLtXHxpP8=;
        b=Nw3oq8R3FBMY/uMA9n0eba7Zo1JPbpUTWJh3KHPTCmSqR8w1RzV6+cEt1kEY3Evg3U
         HnatVRePliJPheP0Lb7xhZ1Lvq50hrCe+VEe+NkMz1aq7S5JVl/8CPaqG1r/G4y2b6zt
         6gf1UH8cI68VNh6E0ihTvMwzYjAPk5ontMRNSQY0Ew4FTPcf8Jkeqa61WQvWgxQ4vJp8
         wfOa9sPRUXku95L7mRDdPek91KFy4RWR4UqiIAwCHk0BYMfSZT8TCbhiFv78dKhXFQdY
         GOWU9trZevvK/tIvj1BGEZiTyyL52jPhtvF2bHvUm6VlhymsHh9zUPnPsutLR1xMVcte
         2AAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZzOn5h1mbMKeXXZHD4xmyJh6jg96MHqbIIQLtXHxpP8=;
        b=ahSK9sL59EPoy3Ye83s7yGniyY9huYQNjPmTMxh/33JPkVIL7rqqm++RK770Vtp5i4
         U+SNsYTSRlZTpvtq4Q3zOqIEj40Bzl9pW1Yh6ukJWulGbzsrNnJf/WkMHc5ZPC2cygBn
         r7+TXKv5XNFXRFePQiZNEBvP2HlKS7K6wg1BMURjSN6oHG0nBDdxwd8adetGD1MaYH2N
         LKENQKyhEmpotude2wVGsLFo8EP66QFOnqE6KUqwv1QhKvLvwb02Xf/MEATydr0JN1hc
         ACgtn9dnHdM+RM/WZSlk22usKvDQoB2X60L4EiqFlME/CgoL7DcpV7FQ0xRbwsZycGX1
         kyPg==
X-Gm-Message-State: AElRT7FKgLHGZ+rugfU1ikQkYf/RXhHPqr83tz/76ZumyHoTfITWymIF
        7ArVYQNCjumoyAcL8+PtdNo=
X-Google-Smtp-Source: AIpwx48r0gyBtd1/C8L2c0f2gOfgac1/GshNrs3nVxTndcqXmgAVgSdR8MgyGrbBGCjdZg7XhX56+Q==
X-Received: by 10.101.100.210 with SMTP id t18mr4145952pgv.123.1522592339435;
        Sun, 01 Apr 2018 07:18:59 -0700 (PDT)
Received: from rempc0jmh7t.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 199sm25165374pfy.51.2018.04.01.07.18.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Apr 2018 07:18:58 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v12 04/10] utf8: teach same_encoding() alternative UTF encoding names
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAPig+cS2xRPP9P7GZMgkKzE899AQiMkkpNsGeB-MwmAymAzCiQ@mail.gmail.com>
Date:   Sun, 1 Apr 2018 16:18:48 +0200
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <3CF5EC69-3DBD-4BC6-8D89-F6437A4686A0@gmail.com>
References: <20180315225746.18119-1-lars.schneider@autodesk.com> <20180315225746.18119-5-lars.schneider@autodesk.com> <CAPig+cSvBi1pJYC-DND1_x9rHhmoAPs90B_3Fg53-X5FjtCQhA@mail.gmail.com> <328BE614-1927-450A-85D1-7391D0BB5C47@gmail.com> <CAPig+cQpDKHwzjCHpka+v1uGaJNfJGSmXpAVwPWVXSf5F1pR-g@mail.gmail.com> <xmqqfu4z3o61.fsf@gitster-ct.c.googlers.com> <CAPig+cS2xRPP9P7GZMgkKzE899AQiMkkpNsGeB-MwmAymAzCiQ@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 16 Mar 2018, at 19:19, Eric Sunshine <sunshine@sunshineco.com> wrote:
> 
> On Fri, Mar 16, 2018 at 1:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> However, I'm having a tough time imagining cases in which callers
>>> would want same_encoding() to return true if both arguments are NULL,
>>> but outright crash if only one is NULL (which is the behavior even
>>> before this patch). In other words, same_encoding() takes advantage of
>>> is_encoding_utf8() for its convenience, not for its NULL-handling.
>>> Given that view, the two explicit is_encoding_utf8() calls in
>>> same_encoding() seem redundant once the same_utf_encoding() call is
>>> added.
>> 
>> So... does that mean we'd want something like this, or do you have
>> something else in mind?
>> 
>>        int same_encoding(const char *src, const char *dst)
>>        {
>>                static const char utf8[] = "UTF-8";
>> 
>>                if (!src)
>>                        src = utf8;
>>                if (!dst)
>>                        dst = utf8;
>>                if (same_utf_encoding(src, dst))
>>                        return 1;
>>                return !strcasecmp(src, dst);
>>        }
> 
> I am not proposing anything like that for this patch or patch series.
> I'm merely asking why, after this patch, same_encoding() still
> contains the (in my mind) now-unneeded conditional:
> 
>    if (is_encoding_utf8(src) && is_encoding_utf8(dst))
>        return 1;

My main motivation was to keep the existing behavior "as-is"
to avoid any regressions.

However, I agree with your critic of the inconsistencies. 

Therefore, I will use Junio's suggestion above as it makes 
the intented behaivior clear.

Thanks,
Lars
