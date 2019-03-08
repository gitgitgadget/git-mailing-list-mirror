Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59E4D20248
	for <e@80x24.org>; Fri,  8 Mar 2019 16:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCHQxY (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 11:53:24 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39384 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfCHQxX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 11:53:23 -0500
Received: by mail-ua1-f66.google.com with SMTP id s15so11600707uap.6
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 08:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C7bKbDDQTXGHDhclr9mgt5DPYNN9dfo19+SD3+kXQfs=;
        b=uN5Kk7RLISq7pO9F/pyj+xuWVCBW3ko/NjDxEsp2rEcbvNXkNDv27m40ikjFg6tKxF
         A3ic4q3DuJ9IOCgERDpwVkHJSIl8NJeCx6UTOEUPiT3L3RkMxNMaNeLBy3Ufp/g0oSpX
         7FTDIUGIbGOhJd+Ybb4oi3IUh7IINTrGe4gyM6U3tXxI7NPSWoWs6U4nkNkHZH3yYa/D
         BhWG7MECzatErrFH0joMmb9I7+Zd6eGratXFFEZ8bP5tfHnZcgnMbMMTVxKRipUHkzcC
         +d+EgnczIgu4PDaikqRflZKLH0iKWHH0C9Lwy43f3yWnYGEnwIk7ByeOGFEp9GEkpfHW
         apRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7bKbDDQTXGHDhclr9mgt5DPYNN9dfo19+SD3+kXQfs=;
        b=M9okkUN6pSNyXFfpltv3WqlHTNdZsA7HdPA1RUgveUQNOzmQ2Wv0yqjrh0f2+PTUWM
         4N7skiI2kAVp4fYpXMc8Y+btV1TAWzZE9d7G+yHPDoCzloe9IA4L8upOSEQzj0+i+Ym4
         RF0ui1/cc+YCkNCt+i8XlWciQQihoCi/hOOl+kLHR2EKFCsas8SmZP2/T+f/l3dlUtMb
         N+2KkI3iA2/9ixtaL0BBKnaBUeT8roJ7ObJwz3ng8TkJjqN5aNJ5ttWkYNaM/ujq7u1w
         NZzkE2Harq4wwYVdngUCtK6Iyqqw0s0Zl6Y+jk2MNeXyqQRQ6SiSc/W1nAuNV1H8WRXt
         wE2Q==
X-Gm-Message-State: APjAAAVz/w1DH3WRnk7Xt1nDhlignoRNZ5cY48eZdpC+nACkPszo4Cul
        gU2UWjDP7N69U5sEL5r51Lj/BiiKGgZJvT+FEpMTYQ==
X-Google-Smtp-Source: APXvYqwYlwGG6TTsdjRB4v6bd6Lddcz3g08M5s0dVWCb7YFKs7+K83vFJjiVlxuOVZ88rdlczsVKCItrcTDvV1vVpCI=
X-Received: by 2002:ab0:6513:: with SMTP id w19mr10322395uam.19.1552064002448;
 Fri, 08 Mar 2019 08:53:22 -0800 (PST)
MIME-Version: 1.0
References: <20190220225846.10658-1-newren@gmail.com>
In-Reply-To: <20190220225846.10658-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 8 Mar 2019 08:53:11 -0800
Message-ID: <CABPp-BHp83H1qhrd-j1yvdWz56AwDJogFjf_3iaEDVjFvGansg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Fix some fast-import parsing issues
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, David Barr <david.barr@cordelta.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Feb 20, 2019 at 2:58 PM Elijah Newren <newren@gmail.com> wrote:
>
> I found a few issues with parsing in fast-import (dating back to
....
> I've cc'ed the relevant folks, and have a few patches that fix the
> issue and I think make the parser more robust against future issues in
> a way that I think is safe enough for backward compatibility, but
> "backward compatible enough" might concern some folks; if so, please
> take a look at patches 4 and 5.

Just thought I'd ping to see if folks have any concerns with this
slight tweak to backward compatibility; if not, I'll just repost the
patches removing the RFC label.
