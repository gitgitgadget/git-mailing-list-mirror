Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECEF020248
	for <e@80x24.org>; Wed, 20 Mar 2019 13:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfCTN6W (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 09:58:22 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36722 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfCTN6V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 09:58:21 -0400
Received: by mail-io1-f66.google.com with SMTP id f6so2058911iop.3
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 06:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFUh/gPWls+3/tZwItFszDr3bUswGyEf80A26SQXbl8=;
        b=Ea8yt7r+OiNQtn9Ek/VyQN2Py7MhGbnszKmRXTFZER3vNFy8dosE5GsljJTyLh+8hn
         ebVTZ6GgdhwlDK9qxUXubLI5iuILjq0lngJqeNuy6qeNDPo1u3ODLL8lMgTfL6bsk4Mx
         Uhe6IkPf1U/4B8lHlheHp3370tBZh1YR5ZFg4mZ1lNABEDoGU32v6798lZ9s2mRo8QHh
         gX1lCYiQ/dTKQO9/AWJl7Jp5h35iYUwoh/kMwqDC8Nlq1+jA2ZAK22xs8E5y/spJAlbj
         AHC2Q1IJLHZLTsxhiM0YcTnlAwDeSM4FBNqZeH3zHrcYoKR1b2gPEDomUrStE5eaaruY
         TWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFUh/gPWls+3/tZwItFszDr3bUswGyEf80A26SQXbl8=;
        b=hhMBD4yBEoUvjpQUStl1vyfuCtoWIKDqTwhhNpGv1M/S5S2IuLS2oJ9w8L6UCHzDsZ
         L+myHCzG5CnSe8z669wmvGIdC3oRUeubGyoKlhiibYwbb5grL6Mr+0zt2kV/X4AmobrX
         KQz9wN+EYWxF6v4gz1L1Xo3ip92pgXfNtPs6SoghrSUMF5LpUwFJXGfAkTwVydQFVdQR
         dc+MsFv1q2AjHVZIDnjyZPgmRRu7GjJFWeMcghxy/AYmFzt2DTboyvvnckNH04RMV9cu
         3Rj3lOPNce7AP8RxR/jh52qPKfTD+9/geXKHulo5a22H6a897foCUxEpTpLBnPiXj/u/
         Qnbw==
X-Gm-Message-State: APjAAAX1gi9nA0jnCT2dyUChj/6VusCGHAKiN/JV+4+k6lGvBIX2OdbG
        Y3VJ92zFGANUKXEODhUhV0ufovEJ4XQDBUhH/uE=
X-Google-Smtp-Source: APXvYqy7IYUX6HBeZx9mVFzJghotbZ22ChMqrXhd0yFKT9vJW3n8dFvlNCOdfXPxSop8PTwuxwMipwkT4Pvek2G2ilM=
X-Received: by 2002:a5d:9446:: with SMTP id x6mr15762203ior.236.1553090301090;
 Wed, 20 Mar 2019 06:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <78628256-79dc-3036-c57b-a96797ceb120@gmail.com>
 <20190319093910.20229-1-pclouds@gmail.com> <xmqqimwexujm.fsf@gitster-ct.c.googlers.com>
 <CACsJy8BLxWea0ZrHkSU6+nE7dr5YvFNVH1tLhaqPRadi+2Hhwg@mail.gmail.com>
 <xmqqk1guwdeu.fsf@gitster-ct.c.googlers.com> <CACsJy8AUH4nOkt6H=yu=eRktK4me9kEkjqsC3zyNZDwUKXqCPg@mail.gmail.com>
 <xmqqftriwbz6.fsf@gitster-ct.c.googlers.com> <CABPp-BFB0jafua0CGEsr66EzQvHncLYvws8rt+LdkQ_LXcEq5A@mail.gmail.com>
In-Reply-To: <CABPp-BFB0jafua0CGEsr66EzQvHncLYvws8rt+LdkQ_LXcEq5A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Mar 2019 20:57:54 +0700
Message-ID: <CACsJy8BdPgPgaWW=3_y5peLdqo24-ozC=s90WW2DN9OsYe9v_w@mail.gmail.com>
Subject: Re: [PATCH] checkout.txt: note about losing staged changes with --merge
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 20, 2019 at 8:53 PM Elijah Newren <newren@gmail.com> wrote:
> So, I think we do need something (eventually at least).  Would you
> prefer we dropped this patch from Duy and instead made 'checkout -m'
> abort when the index is dirty?

I have no problem with this. Still scratching my head wondering if
t7201-co.sh has a slightly incorrect setup, or aborting is actually
wrong. You're probably a better person to understand that test case
;-)
-- 
Duy
