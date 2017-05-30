Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56D0F20D0A
	for <e@80x24.org>; Tue, 30 May 2017 00:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751060AbdE3A4x (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 20:56:53 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33574 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbdE3A4w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 20:56:52 -0400
Received: by mail-pf0-f181.google.com with SMTP id e193so56611879pfh.0
        for <git@vger.kernel.org>; Mon, 29 May 2017 17:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3WAx7bC2VNlxr/Ptz5xHYcZ9z0aKtW/733PvUBRNyGg=;
        b=oTutazVir9roJsIrC8syGZeZUMLWXZX7uXihvwZ+iWugXr3pLs35x8av9xGfZF5pBq
         zbm3hWGvbWMOrF4yU/xsBVDAi6EwVBxeaQIbtffkWclFkWLniHRlMXrKeTTNqGFZuI3r
         BA80gTriXdBYLHvyQbqjaQuN/WbORBjNCHFYk9ct+jVJcoFm5jKG0HJqOIZU22gxIl2p
         GqwMFpcl23AX2J5EaTDFLN3Y9Rve4XheNgstS1MTC1rcVKMPokja2yZ3bbnxPtxknuvc
         g3HL5icXZieg93fAzylepIh8VhR1PswPFt3GjKbjBROP2FD2x5pECeTQAnWt0GywaAZW
         DGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=3WAx7bC2VNlxr/Ptz5xHYcZ9z0aKtW/733PvUBRNyGg=;
        b=Ev/Heaw1Ls8RAqNqixxjJvPjOWJoHdcNAc1mn+DOUgLLP6lx0uc1dDBM/T4ZnGdlHH
         7xHq4Q00fy4w+HuWx8Ll+viiVQPyT+9hRBtB1pV71fp8gLbb0KVgLCpLSs11VFjDWrrk
         GCHBZC8MrPWV70ZDpJJh3n8Dyj0Fsjtdi+KWeioqN0UUhUAoYYwAJwweeORvaXB2BClO
         kRId4Pc1RKTyp4z17KPHWkfWSnsUcO7QLE0lUm7AAOmvL0aV+hUgShMye2QWNGSyMjEG
         85gjMAmRaMEEKVY2igURCW70IXTtw3tk5VjCuyOArojVWT3/wy06pkabQF37nfxd54r1
         Cr2w==
X-Gm-Message-State: AODbwcCwlXsZoMoFDDZWzGO38eT6PUmxJk0MbF8v/Aqz+i5+WNtjyryA
        itesxzB9Hv7tNg==
X-Received: by 10.84.254.2 with SMTP id b2mr79450683plm.185.1496105812069;
        Mon, 29 May 2017 17:56:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id 192sm16386339pfb.10.2017.05.29.17.56.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 17:56:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] WIP: add deprecation & experimental process/interface
References: <20170527111032.30897-1-avarab@gmail.com>
        <CACsJy8CUpHNDfvN+P7=Jub4+Z281rzExFV9x3_hdVKw6ORUSqQ@mail.gmail.com>
Date:   Tue, 30 May 2017 09:56:50 +0900
In-Reply-To: <CACsJy8CUpHNDfvN+P7=Jub4+Z281rzExFV9x3_hdVKw6ORUSqQ@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 29 May 2017 17:23:09 +0700")
Message-ID: <xmqqwp8zduwd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>>  * Add a new config variable `core.version`. E.g. `core.version =
>>    2.14.0` With this the user can specify that they'd like
>>    new/experimental features introduced in that version (and below),
>>    as well as immediately getting new deprecations added in that
>>    version as errors.
>
> We have extensions.* for this purpose (or close to this purpose). I
> think it's more flexible to go with extensions.* instead of a single
> "core.version". extensions.* are non-optional though (if a git binary
> does not understand it, the repo can't be accessed). So it's more
> about fundamental experiments (like sha256 transition). I'm guessing
> we can have a "soft" extensions (warn if not understand, instead of
> die), like what we have in $GIT_DIR/index.
>
> Deprecation via extension.* though may be unintuitive. But I think
> something along that line (e.g. deprecation.*) might work.

The difference/orthogonal-ness of what Ævar wants to do and what the
extension mechanism wants to do has been covered by others correctly
so I won't repeat.  But I do agree with you that "run at this
version level" is probably less useful than a la carte "I want to
enroll in this and that experiment but not the other one".

I also agree with Peff that we should name it as distinctively as
the names used by extensions mechaism---we must strongly discourage
the latter from being futzed by the end users, while this opt-in
thing is very much open to them.

