Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 327FB2018D
	for <e@80x24.org>; Mon,  8 May 2017 06:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbdEHGbT (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 02:31:19 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:33761 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdEHGbS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 02:31:18 -0400
Received: by mail-io0-f178.google.com with SMTP id p24so44396529ioi.0
        for <git@vger.kernel.org>; Sun, 07 May 2017 23:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WQgcy4Bv+oNGsJyrarOFqaa6gBQE0AObQWlgR1KOSf0=;
        b=Mjvug2tLuDA0bzYIV6Kdb4iqDDWsBZNMdgp7EIcm14vVoy4ievyLrkeCsozBPZnhsn
         akciMnF4GPmnP0mbReLfsP0PT+n1LTX4tL4nCRv1iwdYe+gupm+pfRyC1/F6/JroRgaO
         pE5iohbfA7yZtvSVN7ey7DzU+bwDr61BM67uK2jnetJPsVmbQ8A2ERSooWo/XxdnWXh8
         H/l02/XoQ4sQRRK2cn/wwGu3XGHZT6HPUjpSj4p9OJaaJs4ywPt6lukUpxSBrz7vjWlG
         CsvHSNVZL5qQuhJUoPJJaTCqwJx96Z5j6K0o0tZHatr5xSl5kE5eXJcvTAYh+4eQ63MF
         hyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WQgcy4Bv+oNGsJyrarOFqaa6gBQE0AObQWlgR1KOSf0=;
        b=KcpOpZi1UXfFYwmgy00D3K+OdSf4H9tdMaUwRywe6xEEf86XquIIzJb0ulEpCgbIhz
         Z3UkhA/Dy3MxGiQzDMZl1nZnl9MOKKtwGNa6XOorHXY3tSX7uEO9uX5kmW8Bm1SWcq6I
         kun3V6lH9m0UNvZZXFynvuANY9S5NoLaD+rFxjxqMu0ZWXy9AmzM28AkSlhHm5Pogvvo
         mUcsYmXHeFO3/qhgWUDt7kUTKydmrl3Yr9vx4qdveelPsWn2shaDzdAm9kaQl8tZhpQC
         4zmB3YH5eLcMF7HCxl1KLZZsm5QptnWdTd58jd0QBrayIuLwvrZbX7v+Z4b1Bl4omAPk
         SNgA==
X-Gm-Message-State: AODbwcBir1FqSuRYnZk1WXkxMFkMAxpJu490eSg4SqLlp9FdIg7CP96V
        EbM6HB747O4uiKYphRBGvnrkHJWNkQ==
X-Received: by 10.107.178.12 with SMTP id b12mr6071817iof.50.1494225077517;
 Sun, 07 May 2017 23:31:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sun, 7 May 2017 23:30:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1705041328190.4905@virtualbox>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1705021406510.3480@virtualbox>
 <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com>
 <alpine.DEB.2.20.1705021756530.3480@virtualbox> <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
 <alpine.DEB.2.20.1705031139090.3480@virtualbox> <CACBZZX6_5krLp93PmsW639-N4f1efUT5rPnN+5im=d9-66=QbQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041104070.4905@virtualbox> <CACBZZX5bPN3vZhE=0TSQNdRvKYuV3635=VCQAppAfcZ_tuGpvg@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041328190.4905@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 8 May 2017 08:30:56 +0200
Message-ID: <CACBZZX75nvfQft-gjUG+YP0Y-e-=Knm3bMeDWHSUF=Juz9Ua5Q@mail.gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 4, 2017 at 1:32 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi =C3=86var,
>
> On Thu, 4 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> So I think if your criteria for working on integrating v2 is users
>> noticing it elsewhere and asking you for it you'll likely never switch
>> to it.
>
> Speaking for myself, my biggest problem with your patch series is to find
> the time to work on packaging PCRE v2 as an MSYS2 package.

This won't be in my next PCRE submission, but I have a path locally to
simply import PCRE into git.git as compat/pcre2, so it can be compiled
with NO_PCRE=3DY similar to how NO_REGEX=3DY works.

This will hopefully address your concerns partially, i.e. when you do
want to try it out it'll be easier.
