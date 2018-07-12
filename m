Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB6801F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 20:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbeGLUMs (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 16:12:48 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:45283 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732481AbeGLUMs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 16:12:48 -0400
Received: by mail-oi0-f47.google.com with SMTP id q11-v6so32512221oic.12
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 13:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lr+fnYn0H3wDTgLyZ0QEJfFVzzQk/M1VGhdQeYZssEI=;
        b=vhV6YaffPDJBPOFMUi5SvUVjIl0mYiEu6Okb4XkKDkaQ3bowoN/6DkWxyNS+xL4jjW
         ESIMObNw7QDXwsXC6mvUztNKmHYKl6KMPyaDUJrmSn+OAHFHORW0jyUsG4K/mOMm+x+6
         Wk1XUHApiBPByB69NiJuyWLalNuRsiiVvzzMlkeJBZwIJEmwGkqBvuBUN4/qvlpAD6W/
         FjbAsQZ4UoEq3mRBy+c1qRPHqpXbo7ZQjRwxAMxyCUlzYTOlnA5LM1VyZpKPwdXZ5Pfl
         mmYjdGdsc/WLAwt6T3PIq5ek5go6EdpZaZCyTUPZ02T6BVIY7q01Aef+gFN18IXziXRv
         wuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lr+fnYn0H3wDTgLyZ0QEJfFVzzQk/M1VGhdQeYZssEI=;
        b=t7lFz8RWTTWSRZwqSC/a6hv2RrMhjI84G6peaCVLRgfPx8qhOZOTQhflrX6eZAjXF0
         Z66wOGMyxrdDE9uUbY80CIugfAS6D/bBpLV80BBKG8F5xEJ7RFjPSHy65w5fZZmCQGSJ
         U8U4jb3ipXkKBfUnK/X1bz5g8LOLyPggEJbquKW5s0QjVbgkKX+i1dyeZ28dAIsyp1Re
         8draXJc82zP+aiDtbn/VY7T5gDyxCK7MmC9gkHVHKYUTNaque8wV4/Px1gJUeT5lueZQ
         tW4gpjJdgli81zB/sqH9AY12bqyIPU7wQXvVUxyJDE7iJuXR7+StaswYgDddWh9+K7uh
         XHlg==
X-Gm-Message-State: AOUpUlFrRaW9MPl9zF61QoAxP8o8C9kA8g6ryUhyRgkfYZEhHbgBzlY5
        DMtGtmaqFqlUeCs/3RyuSYK6Py4f9UgRKOHWcaU=
X-Google-Smtp-Source: AAOMgpd1OEMAFnfOaQfOUDYpr3AvlpdeI+GZVIP1TESJFRC5YNycQ4kZ6gVsfjRpEUZTwQZSR59zlxnzXMaGp2Prq7c=
X-Received: by 2002:aca:bc54:: with SMTP id m81-v6mr4090538oif.308.1531425703515;
 Thu, 12 Jul 2018 13:01:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:74c3:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 13:01:23
 -0700 (PDT)
In-Reply-To: <xmqqva9kw9ru.fsf@gitster-ct.c.googlers.com>
References: <CAFW+GMD62V=o4hoEYKVteBZHzqBtquzLzTv2WXiSPZf3ZhOpeg@mail.gmail.com>
 <20180712054909.29077-1-wchargin@gmail.com> <xmqqva9kzbhi.fsf@gitster-ct.c.googlers.com>
 <CAFW+GMAp2bA2=_BZ2S0HLO2x2aLE01zXigHrY3QtCmWxRuyAtA@mail.gmail.com> <xmqqva9kw9ru.fsf@gitster-ct.c.googlers.com>
From:   William Chargin <wchargin@gmail.com>
Date:   Thu, 12 Jul 2018 13:01:23 -0700
Message-ID: <CAFW+GMByLBbj6oDu-ERhN-bFO__Tj_M752-OYLYa7=z5DF0Ckg@mail.gmail.com>
Subject: Re: [PATCH v2] sha1-name.c: for ":/", find detached HEAD commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Contents look good to me. I don't understand why the file name in your
patch is sha1_name.c as opposed to sha1-name.c (I see e5e5e0883 from
2018-04-10, but that sounds pretty old), but I trust that whatever
you're doing there is correct.

> Thanks for working on this.

You're quite welcome. Thanks to you, Peff, and Duy for your help. This
was a pleasant experience for me as a new contributor. :-)
