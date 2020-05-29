Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79155C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 17:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B2462065F
	for <git@archiver.kernel.org>; Fri, 29 May 2020 17:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="owAHYqYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgE2RjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 13:39:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60778 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2RjE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 13:39:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7267FBCAEB;
        Fri, 29 May 2020 13:23:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JPRwUBc4KR4SoplkpHBlhPGZJz8=; b=owAHYq
        YA69NBK4gMf3vWg51nY6fr85zBvUJbGidM1k287DuDhLeebz80PhWKzp+l7W8ar2
        BTxp/hJ6PttAgcqtvVtyCi89boo/exFdFXgZCIFVwvQpQAgyYMpyBYB9/pyK2Wu2
        6SScn9iTrq41q6LejfY2HIaPSGYXSxyTUAurY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WLuDccAfyPITP04GtI+3IXPAMnJun8Hk
        OxF4HtxPIVlKqZ4YGfX2ruUEEkXOr6almBKiIAvRe5WKZM1/mPNFIeWuUAhcl26W
        ixOeIOKQBRbMei549Zy1lsJK4UNPTQq0heRI6KaCkwAECMqeZeyBPxSnBHJVXRlC
        1TIzglPzD5I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 69E2ABCAEA;
        Fri, 29 May 2020 13:23:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A3B3ABCAE9;
        Fri, 29 May 2020 13:23:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: symbolic links in Git for Windows v2.27.0, was Re: [ANNOUNCE] Git for Windows 2.27.0-rc2
References: <20200526204539.6181-1-johannes.schindelin@gmx.de>
        <nycvar.QRO.7.76.6.2005282322580.56@tvgsbejvaqbjf.bet>
Date:   Fri, 29 May 2020 10:23:44 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2005282322580.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 28 May 2020 23:35:24 +0200 (CEST)")
Message-ID: <xmqqsgfizmcf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26A58E00-A1D1-11EA-9BF9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Dear Git users,
>
> On Tue, 26 May 2020, Johannes Schindelin wrote:
>
>> I hereby announce that Git for Windows 2.27.0-rc2 is available from:
>>
>>     https://github.com/git-for-windows/git/releases/tag/v2.27.0-rc2.windows.1
>
> Git for Windows v2.27.0 will be out on Tuesday (or even on Monday if Git
> v2.27.0 is released early enough). It has a (last-minute) bug fix where
> the length of symbolic links that is recorded in the Git index is the
> _actual_ length of the link target, so that `git status` agrees between
> Git for Windows and WSL Git.
>
> Unfortunately, that means that every existing checkout that contains
> symbolic links tracked by Git will report them as changed until `git add
> <path-to-symlink>` (or `git add -u`) is called.

So, this is not something "git update-index --refresh" would be able
to fix?

>
> In cases where users use both Git Bash and another version of Git, this
> might cause the problem where one of them will always report the symbolic
> links as modified in `git status`, but not in `git diff`.
>
> Sorry about the late heads-up, I only just realized that this might pose a
> problem. Granted, symbolic links are not all _that_ common on Windows.
>
> Ciao,
> Johannes
