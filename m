Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3911A20401
	for <e@80x24.org>; Wed, 14 Jun 2017 09:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbdFNJyg (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 05:54:36 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36620 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752306AbdFNJy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 05:54:29 -0400
Received: by mail-pg0-f53.google.com with SMTP id a70so73639534pge.3
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 02:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l1I/KMhfR63VzzhpiHXcplZ3JfLuLrAIMudamcc6e3s=;
        b=rpyhApNHKG8byj+GEi7Bcqeq2D1k7TR4H37ovLjL1fwRsQoNH5QBCXT+91Z/IzGXTc
         +MFbpjiUmMWerxxU1X1ZHBJGgDh7kH0Qrnju3OJeRQUY7VJeZG+sZe61dvoTFg+u14pc
         g/yF/46JtnVj7go8Wyopic15vGR9qCMgpOBmzVnIxmx/oq9ro1KJHAvFSrmul2FfAAQX
         aQkFGfIjut2c6wQt7mwysJUyYyrgig1hejLvnFYKLK9Rlu1lDjbPPiWY6lbFbT59xzB7
         ZeR8GdQ14yMLvv/GQ8k18F39Z5Bkl2P0WabDLJDFWJDri15vfocM56Yw/zDpWzZ+ry5C
         7WEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l1I/KMhfR63VzzhpiHXcplZ3JfLuLrAIMudamcc6e3s=;
        b=oUPWxjJChDKLrBin+N+FBoSCTtJmKc2D1Cbd2MQYQvg7yolagTWrzlKAAXoPguPqaG
         JVnAxAnea+c96dty1EsltLXPaas1M/aT3bjda0QSz8n67l+1ecyB1X/OF0Q3XkmquclR
         AqT93OnzLTdymxkXbHFRBDA7l++Rc8WBLkgufoSRxMQyFgER6NpUramlBt2eYbclmg5s
         vA8AJCNnCZ97hzQxxNhs1I+EwitkYxbgbmDfjjqJQ49ubYCBfFuUilIgOU855S+rNLiG
         sJ4LirTaR7aLCoyeeYSXGSQl974vVR+ezoMppdlvUFeqAnopxVvVCN+k5z7mY6803MtB
         gsNA==
X-Gm-Message-State: AKS2vOxntXjcTshnk4HkC0haTBKk9e+ePr108BV9RKWRQiP7jDvEOJFp
        NV+Hk+NhMKN8OQ==
X-Received: by 10.98.102.28 with SMTP id a28mr3255176pfc.200.1497434063706;
        Wed, 14 Jun 2017 02:54:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id d88sm1618604pfk.133.2017.06.14.02.54.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Jun 2017 02:54:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jun 2017, #03; Mon, 5)
References: <xmqq1sqzkrui.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY2Z-fJYxczbzheu1hChLkKkdjEcDMwsP-hkN0TjUBotQ@mail.gmail.com>
        <xmqq8tl5apkk.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xpvZDHum-A4omMySTebgBLFzhkpD=DiL-_Mm_Qv-OkMaw@mail.gmail.com>
        <CA+P7+xpCWUBap757N45DrGjvh+v51dg=A9MNOgN8xfVDqZtvog@mail.gmail.com>
        <CAGZ79kZU-QGYAiv+9tK9UoujuLVD8Ejar=zaHVm8YR2p4cbgOQ@mail.gmail.com>
Date:   Wed, 14 Jun 2017 02:54:21 -0700
In-Reply-To: <CAGZ79kZU-QGYAiv+9tK9UoujuLVD8Ejar=zaHVm8YR2p4cbgOQ@mail.gmail.com>
        (Stefan Beller's message of "Tue, 13 Jun 2017 15:19:15 -0700")
Message-ID: <xmqqo9tq51yq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The color experts agreed that (3) might be the best solution
> as this gives most flexibility:
>
>     "I would be happy as I can configure the bounds highlighting
>     to not exist, it would degenerate to a pure Zebra, which is
>     very simple to understand. Junio seemed to like (2) a lot, so
>     he would configure both dim colors to be 'context', but configure
>     the highlight colors to be attention drawing. So everybody would
>     be happy. It is also not too many colors, we are good at for loops."

Another thing I found a bit confusing in the description of choices
in the documentation was that description for some began with "Based
on X.", and as a plain reader, I couldn't tell if that is saying
"the implementation happens to be similar or shares code with X"
(which is not all that interesting to the end user) or "the meaning
this mode tries to convey is the same as X but the presentation is a
bit different" (in which case the end user is hinted that it is
benefitial to understand what informacion the mode X shows and how).

For example, I view what I prefer (i.e. (2)) as a variant of Zebra
(i.e. (1)).  Conceptually, you paint the diff output using water
soluble paint into a Zebra pattern, then apply thin strips of
protective tape to places where two Zebra colors are adjacent to
each other (i.e. do not cover the boundary between a block of a
Zebra colored moved lines and a block of context lines), dunk the
whole thing in water and then remove the strips of tape.  Regions
covered by the strips of tape will retain the Zebra colors, while
the remainder of the Zebra colored part are colored in a much subdued
way.  Understanding how Zebra mode marks the moved lines would help
understanding its output, but your implementation may not share much
code with the actual implementation of Zebra-painting.

Thanks.

