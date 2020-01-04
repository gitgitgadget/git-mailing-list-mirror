Return-Path: <SRS0=9bkr=2Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E2BC32767
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 22:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7768724653
	for <git@archiver.kernel.org>; Sat,  4 Jan 2020 22:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jo6B2UN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgADW5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 17:57:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63987 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgADW5F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jan 2020 17:57:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1BF5962CF;
        Sat,  4 Jan 2020 17:57:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JOzeeGaCX2XCa3REPuJk0s5hQ/Q=; b=Jo6B2U
        N3nd32jjdE7lQK9LnBMtaIKggJfYTeLj45HabCpSR6oBxB5EOABBJ1t71HZQOH0R
        4Pb4CvE0QcBPHjqNQSeypaXWfOe1pB5dREc2NgBUxT9P6p2AWX3V20Lw4k0qw/9m
        TMT3ossfN85Iml+xgFa2xEQctuwQNqEbPj/7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uAbeyROhRRw0KeusVHzVSoWqv0Rsw0ZR
        7tTxTS6GqeFoy99I2XMSXyv8EIWQB+dWxrOUi5v4pn+E8JNfSCQ0tNzlaX0Et6O9
        AgbEZQSLsfSfW3VIIJAr5eaWdejKmN+h9BBcGP0lHmKwJ8CIB+s67ziYzfvIi2HI
        q8WvJorz2VA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E9805962CD;
        Sat,  4 Jan 2020 17:57:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 16FF1962C9;
        Sat,  4 Jan 2020 17:56:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matthew DeVore <matvore@comcast.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        Matthew DeVore <matvore@gmail.com>, jonathantanmy@google.com,
        jrnieder@gmail.com, steadmon@google.com
Subject: Re: [RFC] xl command for visualizing recent history
References: <20191029003023.122196-1-matvore@google.com>
        <20191031003929.GA22855@google.com>
        <nycvar.QRO.7.76.6.1910310851300.46@tvgsbejvaqbjf.bet>
        <20200103201423.GA20975@comcast.net>
        <xmqqk168cjn0.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2001042115550.46@tvgsbejvaqbjf.bet>
Date:   Sat, 04 Jan 2020 14:56:57 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2001042115550.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 4 Jan 2020 21:30:28 +0100 (CET)")
Message-ID: <xmqqv9pqbzk6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83F19E68-2F45-11EA-95BD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In any case, as stated before, I would like to see this feature be
> implemented as a `git log` (or even `git rev-list`) option before
> implementing a dedicated command.
>
> In other words, this new feature should be treated as a _mode_ rather than
> a new command. The command can come later, just like `git whatchanged`
> is essentially a special-case version of `git log`.

Yup, I agree that we may have plenty of commands that this can
become a feature of, and if there is a good match, we should make it
a mode of an existing command, and "git log" might be a natural
first candidate.  If the focus is on the "recent topics in flight",
"git show-branch" might be a good home.  There may be some other
candidates.

On the other hand, this thing may be sufficiently different from
everything else and deserves to be a separate command, just like
nobody would think it is a sane design choice to try making "git
shortlog" a mere mode of "git log".

An unrelated tangent, but I wonder if we want to start drafting the
transition plans to deprecate whatchanged.  The command was invented
about two weeks before "log", but back then the latter did not know
how to drive diff-tree (iow, it was only about the commit log
messages), so they have both stayed to be "useful" for some time,
until the underlying machinery for "log" matured sufficiently and
made "whatchanged" more or less a special case of "log".  It is not
hurting right now to keep it as-is and unmaintained, though.


