Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 737031F404
	for <e@80x24.org>; Wed, 21 Mar 2018 22:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753764AbeCUWn4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 18:43:56 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:42988 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753958AbeCUWnx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 18:43:53 -0400
Received: by mail-wr0-f176.google.com with SMTP id s18so6785251wrg.9
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 15:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Z9tNBl1cYy8a2fgChBbJUCHtldbb45hdrUp6e8f8Ixg=;
        b=qij7jrAUNBKf6saHWJME5PtAQ5ndyVhGEvpqyeJUpSYMw2kAFCXf3kKhQZMPw84lOK
         bol8WfnpNBIU+hRC79QVHsmqrnL1zy8mmgidFesgpcYM+/MngxRQyxpiLJFIwlreGssd
         MMpMDbUhcCLOtQGtBgnwujYTB7EGtVNxnTqLcLa5ZCx1+b8LceDc8rjd8M0rcVgMSW9i
         QA3kMhYZM53qrWwTQ+0glInrKkJXvXg+TvxUb2AxVVbX70xSjNImK3Bf6sZpilBe5tV+
         uyhYeb94P/+mbuT/3VT/S44TPBxCjCOR7tt3p2YMsf6XzlXuw9PHjUYaf+g0dMAdG38O
         Myiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Z9tNBl1cYy8a2fgChBbJUCHtldbb45hdrUp6e8f8Ixg=;
        b=i95AN+5pEOzPuLJ5qRx2CeOJ2Svgz6eF2tVF37L9dqdccx82lmv4hWSHORUEIC3m+X
         GdRjtOJhxa3g+5yDpuRnE++HsRoPoWfw7iaBxT+pb7VmYlavqwPPFzt8Mo9LpnSAJXyr
         O1vnb0O1ZinpFFeu9k81vocefOJoMpNhpzOy9KORp4qyjuGIsLjYbMYb4mUj6zpUwubF
         2JnDfEG3Cl17AUgBnltJ5tlxmT9NN17YxsyyA3ti4eXD+QskqxM2odXndbtYwkybsVfa
         0VG0NzKAepng8mxIMQgJlNps1s6et2f8ux4JdbKZYS2Mr2f5dpIEli69kImBcCEj7CW+
         kTHQ==
X-Gm-Message-State: AElRT7HgZ8Jjj8JML5iGK9h/TReOZFpRW1Vi1SzWQVVowW4oqd8vCxe9
        Lw547+9mT+ifcs4v1fendj0=
X-Google-Smtp-Source: AG47ELvljEueOidBR7tQ1Rsmcc+MtNeEvZWZ7LqZr3u1LRw0Utb8+eDmNYIsZvO0shTci5qwzNw2/g==
X-Received: by 10.223.136.248 with SMTP id g53mr17283501wrg.78.1521672232365;
        Wed, 21 Mar 2018 15:43:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q8sm268766wrd.69.2018.03.21.15.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 15:43:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wink Saville <wink@saville.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v2 1/1] rebase-interactive: Add git_rebase__interactive__preserve_merges
References: <CAPig+cSm3kHF_hTRKutCCNsY82sE3xZfXJkQsKi+zedq9rdnPw@mail.gmail.com>
        <cover.1521653702.git.wink@saville.com>
        <c169a69be3c61fd1e90eaf79febccef2afdfbd3b.1521653702.git.wink@saville.com>
        <xmqqy3ilnrkn.fsf@gitster-ct.c.googlers.com>
        <CAKk8isqopygpS0BfPi7Xa3jVTacptup-WKusZ3rzRzgU_WDaZg@mail.gmail.com>
Date:   Wed, 21 Mar 2018 15:43:51 -0700
In-Reply-To: <CAKk8isqopygpS0BfPi7Xa3jVTacptup-WKusZ3rzRzgU_WDaZg@mail.gmail.com>
        (Wink Saville's message of "Wed, 21 Mar 2018 14:49:06 -0700")
Message-ID: <xmqqvadpm4m0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wink Saville <wink@saville.com> writes:

>> Good code simplification that turns
>>
>>         if A
>>                 if B
>>                         do this thing
>>                 fi
>>         fi
>>
>> into
>>
>>         if A & B
>>                 do this thing
>>         fi
>
> Will be keeping this in a future commit

I think this one is simple enough to be in the "prelim clean-up"
change, so that you can reduce the size of the remaining stuff that
really needs focused review.

> But if that doesn't come to past, I believe my goal of simplication and fixing:
>   "not ok 24 - exchange two commits with -p # TODO known breakage"
> In t3404-rebase-interactive.sh is worth while.

Oh, thanks for working on this.  
