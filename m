Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5A81207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 06:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164920AbdDYGwc (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 02:52:32 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34100 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164733AbdDYGwb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 02:52:31 -0400
Received: by mail-pf0-f196.google.com with SMTP id g23so8136726pfj.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 23:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KzjkGUCB3B6yoSChQD2FSjTkzdYxEbdt7acuCfAV6Qk=;
        b=flTlncn5/L9BMLKexKadseB3QQTJIcg8+g0HSlvKrAszJTLarFv9Lyhvc7MMQGvGz0
         E1dzgqyvgvzZb2Ff+0l5t1+WW+829puAJVknS+B3/l4FPXeptTsB7nZVXD4cnz179dRD
         knFc9pv9BucaNi4oxd9rhWdHR4OTKxzLaFCEQ1ouPKAqouUCWbItt2+vW4y6cR4aG7qj
         S9vYXkSZpcdm5UUFv30HYslq/4Zz2z6VU/fCFTQGdqfUlqjhWyCDnjWrhHBFnZ2lXn3n
         iyLqq1PLUyDQpvi6a1ldkcwgSiVuellR7s4VJx3cjhautqyYY8VnE6j3xMQVeuOkZDWC
         8bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KzjkGUCB3B6yoSChQD2FSjTkzdYxEbdt7acuCfAV6Qk=;
        b=qqi+b8hKZMpncxCeDoEu/kK2Iz1UndUwzJaP954LAXSd48+uhV4+2c6AAUyvUmR1FQ
         cxxhyeLGNkHb5yCbpzf31xV3b6NziLY/MUl3uvkuhIx+9l08YdnrHcgHDreyFR1R4RLl
         vtpjeNS70fMUmkNAbK8D2fRRdaWUtuDdISEe06YQMy27QybrlIqoD/MK9rp2YfJCBsMe
         fT/5ORCpTahOXPcozQ2oCfhZDWqTgQ12xWE3tuCIYZxB/Z+GeiApta6sdFBKxwp43LTl
         TGGKqjPDSPCiFDjIiyQeoYM+yFJCOqswt0YkodZbYcvEocAtaN/0UX/32qO/liVHKVVj
         Yu2A==
X-Gm-Message-State: AN3rC/42uIrdlQSRTc8fCipLOrwqYBmKe6PqQyLBVw4RpskBeOK58NtP
        kXrfTFat1RHjgA==
X-Received: by 10.98.48.199 with SMTP id w190mr27604768pfw.132.1493103150436;
        Mon, 24 Apr 2017 23:52:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id s3sm34417396pgn.29.2017.04.24.23.52.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 23:52:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com>
        <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com>
        <xmqqbmrq8z4j.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704211135430.3480@virtualbox>
        <CAP8UFD19DVqQLHBta74uLcFPwJaRUKF8Ppmnhct5ub=OkKSqCQ@mail.gmail.com>
        <a9685abc-50ad-3ee6-3384-0e043d205612@kdbg.org>
        <CAP8UFD1r9TFE9ns5pobDOpugF8MBiJAYgrRALCqGVmgWud=QjQ@mail.gmail.com>
        <3bd4a2d7-ada9-6198-8cf1-573d80cae1b4@kdbg.org>
Date:   Mon, 24 Apr 2017 23:52:28 -0700
In-Reply-To: <3bd4a2d7-ada9-6198-8cf1-573d80cae1b4@kdbg.org> (Johannes Sixt's
        message of "Tue, 25 Apr 2017 07:51:51 +0200")
Message-ID: <xmqqa875uggj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> The idea of marking git-gui and gitk histories that none of their
> commits is checked out: it erases all Git source code from the working
> directory, and a later bisection step places all code back and it
> requires a full build. Not a big deal with Git, but there are much
> larger code bases.
>
> The current bisect behavior makes this idea unworkable. For me, it was
> a big step backwards when it was implemented. :-(

I think it is sort-of unfair to blame bisect for that.  It talks
more about how "coolest merge evar!" cross project merges are
unworkable in practice.  With a proper submodule support, nobody
should be doing it, but we started the cross project merge way
before we had submodules, so...
