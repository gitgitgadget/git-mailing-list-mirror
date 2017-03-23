Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39B1020958
	for <e@80x24.org>; Thu, 23 Mar 2017 17:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755530AbdCWRQ0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 13:16:26 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36065 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdCWRQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 13:16:25 -0400
Received: by mail-io0-f179.google.com with SMTP id l7so1462759ioe.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=C+OuyAfheZjA0XfoRbYxpc5dlhT5ojMOEKMuwylcqHc=;
        b=CksZRQiyn+Gy2T62jr3shVcpSEABJPsxwPiKypYp0CybadPRQa834N+woihlPPPnmb
         0umNXLcaIyzAYMnYQGLlYV7qMGGAylFZIolvU+L0XdsyBUZavRqzl/4TonbnPnq+EhKX
         xXqYmovTmTD8A2mjAkmz2aXd7oqBNeOKTv5eZLP0ThBmoakVnYK6s/X7v8VYPnzruQFT
         cFK5PBXFH2aNWS0TsHg6gvKUTMscJ8svd/+/TwSbHmoGhJCp5l4dLrdJMX76bauEFMqN
         bjuP2lUUMIPA2CFmJhJXMyHzevfy95MgcE3FN4tu1FBNAfcRxfxJ1pDah3RjqySKDVHU
         QcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=C+OuyAfheZjA0XfoRbYxpc5dlhT5ojMOEKMuwylcqHc=;
        b=dbRKLdC8Bh4XUv1RB3lpYilaHu2JS2Qrn6keajcEUD9zux+yxFpyDToFE5lm2jbY74
         BhQWQh4rVTr6LxYrjL7xMeyaF743N9O2GONJWCze85BdiCIqZYGQqXAA4jGKTN/GujU3
         NU7oEHTnIiCqiiYFjMpK7Da18dVyKUEO3pBcJu7EWUhGZ5WYqjwtbgTedrhb/Lu9P4ON
         8RhDMbgtyuWF5dzI4u0TWHxlgXZ6Ey7NF8dh34kRRdwjn/GUUiMysO9/FibuahPufrO8
         kfo807/YUD/NavkXJKCgoI7GS3Lrt4/jOVsk2R5gDm7gx8lg+UquPecyAexa/Nb5R4u3
         GDSA==
X-Gm-Message-State: AFeK/H23q098gR28Lwe65qk1nEzeNDG4HKRDEfa0izZvFmALXbuphN3h3AdjiG/Kwp6Iwxyn5TovYLrW5oZvgA==
X-Received: by 10.107.136.93 with SMTP id k90mr3713285iod.224.1490289384560;
 Thu, 23 Mar 2017 10:16:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.102 with HTTP; Thu, 23 Mar 2017 10:16:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1703231724350.3767@virtualbox>
References: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com>
 <2B1DE627-11C8-4FA5-A354-76B6C475666A@gmail.com> <FFC0EFBD-C4D9-4FB8-A45D-7B10689724A1@gmail.com>
 <alpine.DEB.2.20.1703212105030.3767@virtualbox> <xmqqh92mo06a.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703221530040.3767@virtualbox> <20170322220246.GD26108@aiede.mtv.corp.google.com>
 <alpine.DEB.2.20.1703231724350.3767@virtualbox>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Mar 2017 10:16:23 -0700
X-Google-Sender-Auth: cKMQbAizyk7Z6YLhyvvCywWvtCo
Message-ID: <CA+55aFyFS2r6isdQU_i5FUQnrzjvWhZdmEVE=KmBVTrMukBbkw@mail.gmail.com>
Subject: Re: USE_SHA1DC is broken in pu
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 9:43 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> What I am saying is that this should be a more fine-grained, runtime knob.

No it really shouldn't.

> If I write out an index, I should not suffer the slowdown from detecting
> collisions.

The index case is a complete red herring.

As already noted, the proper fix for the index case is to simply do it
asynchronously on read. On write, it's harder to do asynchronously,
but for a 300MB index file you're likely going to be doing IO in the
middle, so it's probably not even noticeable.

But even *if* you want to worry about the index file, it shouldn't be
a runtime knob. The index file is completely different from the other
uses of SHA1DC.

But the fact is, if you don't want SHA1DC, and you have crazy special
cases, you just continue to build with openssl support instead. Nobody
else should ever have to worry about *your* crazy cases.

                Linus
