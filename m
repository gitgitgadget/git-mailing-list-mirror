Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32A111F453
	for <e@80x24.org>; Wed, 20 Feb 2019 22:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfBTWjQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 17:39:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37088 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfBTWjP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 17:39:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so7965988wmg.2
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 14:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RgbxEeGkSZ6ufzgLBzLzvL/Hm3PDMt+DyysF+7258o4=;
        b=iDJ7QtfPU2d4EAZN6rYYiaa0/+yhubwgDhqBIUv0uiYXfu53nZVxjOFPZDy0CpwMb2
         KQwjnT2WMhz/ZMnTke8RWT7s63WTWtF/QDBXkI+1GV7SnXhCDAl7ipcAfHEfqnO+rb0t
         p7fwWHHIIg++H4YfuQCso85FeVdK9apKMqmDap6H1ebZBAUTpyfIwBjQp+jgm95jASly
         fW5/ZyyE/XtfMG15rnMojC0oKOMP4h2lQ4P+BKUxgln/Zf4l2IIYCsBlVS0sRyt6udu5
         jspTvrNA/QFUehCdGD3b1ACMfFVFx1397wJEB1GA+VV/O1gJ8Nllndje5Bp2XjU/Ufpr
         R7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RgbxEeGkSZ6ufzgLBzLzvL/Hm3PDMt+DyysF+7258o4=;
        b=gfQxyWSiX8iaVRbW1grwCBEgTF5tu380cw31FFu6KBftR0zQA18+Dg78ViIDFVFsjc
         LeBH3QkzP7ov5lRP9zhK2oqrWJCLQylCDokm2TahL6eQ25CJLSPbScNw/+chRzE9PDmq
         UjbTX938WzRwJSOlqD2yDWIanFvUfXNDqdhz04aN+oO57uEEc/rX2zvTumV23eIIwVsv
         0SnhAoX3j6cVLLhQTcCMcKHY3h7qG1i1NQaceHkWRIvA4f1SytYgrq1dAS+PZC2pLcDU
         3ykLkoB38vV0JVBsLrb9AHBnZiW32egTbXILdF4fR7Q7hHxY6zeIMKfAfkcwq/9PplSM
         NEsA==
X-Gm-Message-State: AHQUAuYWBQrlPHT97vLnJW89f2ZWC6OAPnbRTwrkBeNel2uRkthEHOoG
        PykhdxQbSuUh9guXE7V2YYM=
X-Google-Smtp-Source: AHgI3IZjphI3zyUGuDO95tuOykybme/Qn8955L48FosaI2um5PnkwzOVdmdMWUNCvdwA26uPgcbyng==
X-Received: by 2002:a1c:9acd:: with SMTP id c196mr8538470wme.145.1550702353657;
        Wed, 20 Feb 2019 14:39:13 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m4sm4147411wml.2.2019.02.20.14.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 14:39:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 1/1] Introduce "precious" file concept
References: <20190216114938.18843-1-pclouds@gmail.com>
        <20190216114938.18843-2-pclouds@gmail.com>
        <87wolzo7a1.fsf@evledraar.gmail.com>
        <CACsJy8CR7VGp7htC_wKC9BUCaQsmkp5Zd4+M7bddPL-jKyfDMQ@mail.gmail.com>
        <xmqq8syb3b3j.fsf@gitster-ct.c.googlers.com>
        <87h8cy6cme.fsf@evledraar.booking.com>
        <CACsJy8B15hORnaOdYW8TNE3Gniv9NBJopyLYmHR5iF0U3beq6g@mail.gmail.com>
Date:   Wed, 20 Feb 2019 14:39:12 -0800
In-Reply-To: <CACsJy8B15hORnaOdYW8TNE3Gniv9NBJopyLYmHR5iF0U3beq6g@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 20 Feb 2019 16:41:51 +0700")
Message-ID: <xmqqo976ultb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> There is a trade off somewhere. "new user first" should not come at
> the cost for more experienced users.

Probably.  Nobody will stay being newbie forever.

> Making "git checkout/merge" abort while it's working before breaks
> scripts. And requiring to mark trashable files manually duplicates a
> lot of ignore patterns. Have a look at any .gitignore file, the
> majority of them is for discardable files because "ignored" class was
> created with those in mind (*.o and friends).

Very true.  That is why we were OK for so long with "ignored" that
means "ignored and expendable".  We know in some situations we want
"ignored but precious", and that is why we are discussing this topic.

> So now you would need to
> add more or less the same set of ignore rules in .gitattributes to
> mark them trashable, and gitignore/gitattributes rules are not exactly
> compatible, you can't just blindly copy them over. Every time you add
> one more .gitignore rule, there's a good chance you need to add a
> similar rule for trashable attribute.

I am not sure why you would even need to _duplicate_.

Are you saying for each and every rule that specify "ignored and
expendable" in .gitignore there always will be "ignored but
precious" exception that match the pattern?  Given that we have been
OK for so long without even needing "precious", I find it somewhat
unrealistic to assume so.
