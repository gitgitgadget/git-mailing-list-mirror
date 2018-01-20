Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9D851F404
	for <e@80x24.org>; Sat, 20 Jan 2018 00:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755247AbeATAXV (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 19:23:21 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:40573 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753427AbeATAXT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 19:23:19 -0500
Received: by mail-qt0-f182.google.com with SMTP id s39so8075205qth.7
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 16:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=SPVDgolKis0Pw8lU6S8o5+ULYHGdN/fbjElmIVDZYr0=;
        b=uD8NXul2j99L1wO44w3W4468D9a1ypB8xeAtiOGEg/k/33Zsba1+Hq2TZVBimRnvaK
         C5iiILZQzM1f/HQ+EW5TzkyA8fy5CoH9TIn4UdjQKWfvn1t3HGyICcL5k3ZIRr4R8TOq
         Mo0bfp68zKHyjdI+3i9uyArVQQpVtk/KXZlgu+K/OngL0/SKM5E66MMW8d+dYrhM7FMw
         yD4btWcQzU1kyPcuyuf9JchRy8eGm1ivgoQlR+1T2qbHg0DKOpna8LiatcVGZMFcBQWk
         XHWV9pf3Bt5/y1y44psch8NBEofHXEWEQb97YAYGLui47QRgJCOoZr1rfz7Czk7JiyxC
         VNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=SPVDgolKis0Pw8lU6S8o5+ULYHGdN/fbjElmIVDZYr0=;
        b=hbc0dmrwrUaF8cCXsrTxcFdf9jd4nYF+0+9yuPrCJOsIhUQZ2lLeLY2HU0mppyLMxf
         iiSaBzpiNrL/o39+3LqzgUGM8tlroFZnK+RYMzLaeb9S2q0vs+Wrp3CuOE5OtC+U2SKJ
         U+px8BkTqrKnvHq8EVhzhYRksWDTPzPG+V9L/8OUD46FWYgra9TU4b89JzO/Z7BU7CEE
         Uzy4dpa4X+GfMG2j6+EXo1Gom2MMRdSocPlVM49Pf2tPSudL3pCZqa1MNMIyDqZLbDx2
         OSyZgq8BwcjNE7FqxZb5Lf5moY55/xscOgy+JtAiopyt+ERzNYQ/p5RXRQYZQhCwU7qB
         yZFQ==
X-Gm-Message-State: AKwxytfoCopOlQtSfyLXEXn+3RrPjx+ueoVMDEbzorLT/7YTxkbhEOSL
        Jf9jeSrQuk89iNFfsfOC38bqU5COKdfrc8yolFo=
X-Google-Smtp-Source: AH8x224lI6vBGuVD9oGMwxKADyi0Ek13PriY5G7h0B9Pf3RaTX+sAsLRRzwd3TZykp2tFE8VAYvz5xTRYEvnKUDDf6U=
X-Received: by 10.55.104.17 with SMTP id d17mr341516qkc.306.1516407798611;
 Fri, 19 Jan 2018 16:23:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 19 Jan 2018 16:23:18 -0800 (PST)
In-Reply-To: <20180119172549.GK1427@zaya.teonanacatl.net>
References: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com>
 <CAPig+cTkBEGyoS93GYCtoDgccTF_UixqBkVTExg7Zf0M1J7KRQ@mail.gmail.com>
 <20180119024738.GA222163@genre.crustytoothpaste.net> <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
 <20180119034025.GB222163@genre.crustytoothpaste.net> <CACsJy8BTFm_0sv=roL1OKKW=1DyU3vqD50NKyHg3KQ7G+mAepQ@mail.gmail.com>
 <20180119074001.GA55929@flurp.local> <20180119172549.GK1427@zaya.teonanacatl.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Jan 2018 19:23:18 -0500
X-Google-Sender-Auth: Y92_wXcwpxwC6Rdci965qVeEydg
Message-ID: <CAPig+cSRN1zHc=zsO1Y_aQ_eO+sbsd0cq5iZ9hYz3ruK_E-0Dw@mail.gmail.com>
Subject: Re: git 2.16.0 segfaults on clone of specific repo
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 12:25 PM, Todd Zullinger <tmz@pobox.com> wrote:
> Eric Sunshine wrote:
>> Nice detective work. This particular manifestation is caught by the
>> following test which fails without brian's patch on MacOS (and
>> presumably Windows) and succeeds with it. On Linux and BSD, it will of
>> course succeed always, so I'm not sure how much practical value it
>> has.
>
> The CASE_INSENSITIVE_FS prereq could be used to avoid
> running the test on systems where it won't provide much
> value, couldn't it?

As mentioned in [1], my original questioning of the practical value of
the test was tied to the belief that the full test suite is probably
rarely run on MacOS, and it wasn't until I pressed "Send" that it hit
me that it would manifest on Windows as well, and that Dscho does test
on Windows regularly. Therefore, the test could have value.

At any rate, the test potentially could catch some sort of future
regression even on case-sensitive filesystems, therefore, it would be
better not to hide it behind CASE_INSENSITIVE_FS.

[1]: https://public-inbox.org/git/CAPig+cQmWqQWQrRQHHn=3hn6UFzJxT=9d5kKnJht_dt8sCgwkQ@mail.gmail.com/
