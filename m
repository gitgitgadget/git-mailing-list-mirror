Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9BC91F404
	for <e@80x24.org>; Sat,  8 Sep 2018 17:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeIHVyu (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 17:54:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43479 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeIHVyu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 17:54:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id h3-v6so4559124plh.10
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 10:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x6OEyTlU9mNIXujZ7wKKpyFNZv1b8IQBziMQJSoPf/g=;
        b=ogb6FcG+X7AnVMrF31kew2DDtjRjeDI8BqoX0UtnbW5QAyTBA1CM9FATr10Ey+crl4
         NFpPIkvHhYcLHDPzMNZUjiivrVwa+2DrRvcytPgrHFm3ZbXb3r8n+3lAoY50nUl2HVYA
         92GNsipPxntdtzgctq0J8y80y3kAC7kR0Nj+CwYd8NbOaUYofyNr5ubpibljugOyX70m
         bHdsCKfgpO2/z5bLqgZUXInT57EjshcvMWYTPEJWxL5bw2Inr/H7+g39TzCBbq9vDTHP
         SinN6yz5bn0VcL2luIatbEZLtSqyyfkhtXpLccbsdoFMW26JeuucL6R0BAekJCDcGhhH
         U7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x6OEyTlU9mNIXujZ7wKKpyFNZv1b8IQBziMQJSoPf/g=;
        b=iIRQmgmcDX1QvAMkGFAFjwEntkYN0DaJ2MVba+kSsRJpyTaItK1Ab9jLzPq3GCMO5P
         dQ2ytrT+E/S8ln8Qm+Zz2sZuOBYFSlSA8vSL3jRlGy70okCaF2Oiu5BZY/4IlEeleXAB
         MR/edDWn0JAwyrDzF10USI3TVMhYO42o8RUobRynm5z9jdVzV2bIsx9P1FWruQsGWrpH
         iheqibpReRG+EftC+llYBIAhZc9h1Ro54pJuki74mY9SvFIoAHTLsbZlA25B8OJCvKUW
         v9SS6Xxw2sN7f5QSB85j45aI47YSCHellceBKlP5mIVtzzTtWh8MTP/uPI8RNry6n3bu
         YcRw==
X-Gm-Message-State: APzg51DA7HY+IfAvx8LGPiPgoK7FdaaUj1MDfjcq+g/bHuqYa3aWvBdu
        Cke5Fkm86D9/A5k8qgE8IjMVMcCe2op5Q3IaZ28=
X-Google-Smtp-Source: ANB0VdbO/3C1xszhridg080wsDnMW+El457yjMxJ2g6wITGUZpG0113uci8bZ1jxwFrn2dr0U/SMk0tC/75nSHfWoI8=
X-Received: by 2002:a17:902:9893:: with SMTP id s19-v6mr13870149plp.130.1536426503823;
 Sat, 08 Sep 2018 10:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180906210227.54368-1-benpeart@microsoft.com> <20180906210227.54368-3-benpeart@microsoft.com>
 <xmqqpnxpw5sn.fsf@gitster-ct.c.googlers.com> <fc531863-c46c-6d27-4749-c6b092a14a6f@gmail.com>
 <CAN0heSreAfMsseZcxR75CFDph-n1b8EUNsRhpFsVqxMLc0hvpA@mail.gmail.com> <ba1c8611-5480-deae-2b45-75fc9943086c@gmail.com>
In-Reply-To: <ba1c8611-5480-deae-2b45-75fc9943086c@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 8 Sep 2018 19:08:11 +0200
Message-ID: <CAN0heSqiMQ0iW-pvsfDrf+NDjhnY+dznWHHL5H2k+c2MBpJp8g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] eoie: add End of Index Entry (EOIE) extension
To:     Ben Peart <peartben@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Ben Peart <Ben.Peart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 8 Sep 2018 at 16:04, Ben Peart <peartben@gmail.com> wrote:
> On 9/8/2018 2:29 AM, Martin =C3=85gren wrote:
> > Maybe it all works out, e.g., so that when someone (brian) merges a
> > NewHash and runs the testsuite, this will fail consistently and in a
> > safe way. But I wonder if it would be too hard to avoid the hardcoded 2=
4
> > already now.
>
> I can certainly change this to be:
>
> #define EOIE_SIZE (4 + GIT_SHA1_RAWSZ)
>
> which should (hopefully) make it easier to find this hard coded hash
> length in the sea of hard coded "20" and "160" (bits) littered through
> the codebase.

Yeah, that seems more grep-friendly.

Martin
