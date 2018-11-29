Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63283211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 16:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbeK3DQe (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 22:16:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33383 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbeK3DQd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 22:16:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so2494418wrr.0
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 08:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5fQrJ3hTKqTWzNGVNNv+rcb169JmkRqBSN/f1mk8x+4=;
        b=CTatARe6wb6bJvEnyqGdCjBPBBI/Ve9nKJCq1qaB92WxbYMvAAjPFnOJS+izu+R1zV
         xycakYR0gVxbuwCYH+p02YwLzPZIcMCW8bEnCH1zCKBizZNpLfpJPSB+EF9Dlny/kx8w
         vckj5S56ZFEYHevxSD43A/f8ljZZI/dHP8xANg5TIhBA0neoTKZswhQdd02JwROjgNIJ
         A/lzbA6CLwSter8u/p1RW+FYw13JuKVnYy/tbj5BLQYT4V1coctOHN6/TextTk9CFnOE
         GowJKpVyTBqH72k4dD9MfoJ5qs+kua5lp5fijjg2oVCREGmEnHlaott9nEx409SOgcz1
         XOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fQrJ3hTKqTWzNGVNNv+rcb169JmkRqBSN/f1mk8x+4=;
        b=WZCYIOYAD72G6/hhPxP1WRaexF81AaB2mNMdC4MaPY4FL/PFYcF+14kkgzeK/8uKGH
         KBgrMOeYhT9vdADwhblByJSP54Di8ZIUD3UGtWULw79x8VAxb+KifyaaYn90RWNMmZvK
         i1ZjgXryXezk1W/uBkw4FjowijNrlcB6zR+lP7lBnJHy4SQ5RLwbbaHXhQuhScOUlUeB
         I+WOcjTu0rNP7qmSBdAuAcEpFP3vYHexJCxT+MocZb2eWJ4HYHAyhysynsWlwHhWpxO1
         x+/j3vXwesSl7ziVgIeduaBXDH2fARBr6hTuZ7dRZv75coqVhPQlIbKiOeZaJp8BmI0T
         ZXVw==
X-Gm-Message-State: AA+aEWbhyWAfSqm40N87tSpnukJaIa05qBzFk242mUzJxHOXvJ2Ntx9d
        vwKULpkvdRmuBawetYei87f+4v2Oy9P8ccpbULiHYMjkluA=
X-Google-Smtp-Source: AFSGD/VDG6I67CtWkrdYRCCbIJBJQokPveSsvDIgN/7gMWsigqRykFo7vkgB5l5DFA9v0neGk2RV1Q42GW1ooc5uyno=
X-Received: by 2002:adf:bc02:: with SMTP id s2mr1895772wrg.255.1543507839796;
 Thu, 29 Nov 2018 08:10:39 -0800 (PST)
MIME-Version: 1.0
References: <20181127045301.103807-1-masayasuzuki@google.com> <xmqqwoowmfzt.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwoowmfzt.fsf@gitster-ct.c.googlers.com>
From:   Masaya Suzuki <masayasuzuki@google.com>
Date:   Thu, 29 Nov 2018 11:10:27 -0500
Message-ID: <CAJB1erVBMq84gXir1YD=3R_RXS+qXYAsPKo6ecEJBBNv-4JOFQ@mail.gmail.com>
Subject: Re: [PATCH] pack-protocol.txt: accept error packets in any context
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 29, 2018 at 3:42 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Masaya Suzuki <masayasuzuki@google.com> writes:
>
> > In the Git pack protocol definition, an error packet may appear only in
> > a certain context. However, servers can face a runtime error (e.g. I/O
> > error) at an arbitrary timing. This patch changes the protocol to allow
> > an error packet to be sent instead of any packet.
> >
> > Following this protocol spec change, the error packet handling code is
> > moved to pkt-line.c.
> >
> > Signed-off-by: Masaya Suzuki <masayasuzuki@google.com>
> > ---
>
> Have you run tests with this applied?  I noticed 5703.9 now has
> stale expectations, but there may be others.

Yes, I did. And it also didn't end up in a build error. Do I have a
different build option...?
