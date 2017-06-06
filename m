Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41D50209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 12:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751703AbdFFMta (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 08:49:30 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35549 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbdFFMt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 08:49:29 -0400
Received: by mail-wm0-f46.google.com with SMTP id x70so36343315wme.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 05:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZmFQ6O4wVh7sM6A3z4uqo8hhgX5okLMrWRBCbWf8YNk=;
        b=sajGqUBRqj6uQVy9KXMngnlakzna5R4oGfZDdQpWPhZbgmdJOUA1yK3syRItG3fiSP
         1a4jdp37yXqi9bBYM6Zt3ekP3rkFJuSopL9orlCLmJmMRR0Fi3kJj7qxUbQrResFQ9SC
         rYXCTDrek9GCMi6umLA5xUKY3rVe8jXQcl+McNJNcfSAWn2wgjGAfYNf8IrHR3512YJd
         8+sYj4TVeq0aeJhTwrSNQhywlKXG6EwX6EsKpEaV/DvSmAzR/G7cndMaXvoBooBJczSG
         7oeSUt7ODpFQ202HRoEUNwxrtNQA/4IrYNBTuZkrmJpV0JSpbBtZ3isEDmwL87ZoA4Xt
         VTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZmFQ6O4wVh7sM6A3z4uqo8hhgX5okLMrWRBCbWf8YNk=;
        b=s8AF/IT8DDpjjwHWVq2KvF+2O36vNlirAsz2G7OidFFKu9dUYEG1owqnatlL3q+LOV
         M3sZVp6I5KTcE0zwa5BRU8171A/hNCFArjLUtU+3jB3rp0Y3yuorXfL7wYLYa1GDeQF+
         SGPsAnROqrUx7nFyBY0QUVaT42zDX4IrURczV6RvBP2E9pouS7c/C4NddXQL7e5sEPsZ
         w+RrI5wqZikhlwCOVw1NHEWc8+97YCDhPdheaDP8A7h57iNJb3zHhKG9ty2xqfMExJaX
         o9Y5aPaEn0PMb4NVpgXuorM3omvxj+T1xJO5b1L7QOGZ98y4pPxg0hpXYD5Wfoucol+C
         0Zmw==
X-Gm-Message-State: AODbwcCl9edTl6iiqigHv1vRLwN1x16PH4Ya3VMAwxPT2GMcxJzm2byx
        0dd6tZIibLGrOexNiKmc79Wlehivag==
X-Received: by 10.28.167.135 with SMTP id q129mr7092926wme.73.1496753363554;
 Tue, 06 Jun 2017 05:49:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.152.139 with HTTP; Tue, 6 Jun 2017 05:49:22 -0700 (PDT)
In-Reply-To: <xmqqmv9l8h5z.fsf@gitster.mtv.corp.google.com>
References: <20170605203409.GB25777@dinwoodie.org> <CACBZZX6vOr+ZjUaAf8i1xdjEFfY_Exj+_Xn2-1u0RcWoLy+X1g@mail.gmail.com>
 <xmqq4lvtap3m.fsf@gitster.mtv.corp.google.com> <20170606100355.GC25777@dinwoodie.org>
 <xmqqmv9l8h5z.fsf@gitster.mtv.corp.google.com>
From:   Morten Welinder <mwelinder@gmail.com>
Date:   Tue, 6 Jun 2017 08:49:22 -0400
Message-ID: <CANv4PN=G82J86eaPkvy8ZaXZGSnHoJRuKFeLcF34aX6_9Y9fcg@mail.gmail.com>
Subject: Re: Git v2.13.1 SHA1 very broken
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        GIT Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One could have configure ask some existing dependency that has already
determined the byte order.  For example:

# perl -e 'use Config; $o=$Config{byteorder}; print(($o=~/^1234/ ?
"little" : ($o=~/4321$/ ? "big" : "weird")), "\n");'
little

Good: less #ifdef soup; bad: not so great for cross-compiling.

(That's the integer byte order.  The floating-point byte order can be different;
hopefully git doesn't care.)

Morten





On Tue, Jun 6, 2017 at 7:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Dinwoodie <adam@dinwoodie.org> writes:
>
>> Digging briefly into the endianness detection, it appears Cygwin has
>> both _LITTLE_ENDIAN and _BIG_ENDIAN defined.  Git's detection works by
>> assuming it's in a little endian environment and switching to big endian
>> if it detects any of the defines that indicate such, and a010391 adds
>> _BIG_ENDIAN to the set of defines that indicate big endianness.
>
> I suspect that the upstream has already fixed this one to cope with
> FreeBSD.  My preference is that we do another import on top of the
> ab/sha1dc-maint topic, below the commit on ab/sha1dc that adds the
> upstream as a submodule.
>
