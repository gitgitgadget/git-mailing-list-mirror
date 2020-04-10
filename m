Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACA7C2BA2B
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 15:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C465E20857
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 15:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lt2l/vvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDJPmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:42:16 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57910 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgDJPmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 11:42:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BDA8DC8563;
        Fri, 10 Apr 2020 11:42:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pzfWJLZdIT+EdKUHhhZufjk/OjY=; b=lt2l/v
        vArun3RmJcfh5ZKVthEvfaMuFnRFRD3gQ2or3K/Rd8fSgS8eYPFeR6gZyQAits/o
        Cvy5Rxd4yQJSTiXBOiDojlL7lBGotxreDCVfXsCX2d3+MWMQZwU1hyrNusFEN9Mi
        EwuIQDL6BQjqZ/rgivH/btQ0O7wvN3PG1rjwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KJFRqS0VhYAs5n0wNLCBKmaGONnyVH0I
        X+e7cGZzdki1fWdcske28Oizpk5eBgpcm/jszpgKe+NcrRQ9eW6/GFMmJ3FPuql8
        GxBNZvjQEF7hGSqwGA6BSViQkUPIQu5oCiV2zqob2+JR8JYLwqDJW6Ys+P2aiMnY
        JCMjA+deo/s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B59E5C8562;
        Fri, 10 Apr 2020 11:42:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 07E5BC8561;
        Fri, 10 Apr 2020 11:42:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 00/12] ci: replace our Azure Pipeline by GitHub Actions
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
        <cover.1586309211.git.congdanhqx@gmail.com>
        <xmqqpncgmk5z.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf.bet>
Date:   Fri, 10 Apr 2020 08:42:10 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 10 Apr 2020 16:34:15 +0200 (CEST)")
Message-ID: <xmqq1rovl54d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D850F88A-7B41-11EA-87E2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Judging from two CI runs for 'pu' ([*1*] and [*2*]), among the
>> topics that are cooking, there are only a few topics that these
>> tests are unhappy about.  Perhaps those on Windows can help these
>> topics to pass these tests?
>
> I would like to point out that there is only one single topic that is
> cause for sorrow here, and it is the reftable one.

I first thought so, too, but vsbuild failures like the one in
https://github.com/git/git/runs/575116793 do not appear to be
caused by that topic (6a8c1d17b8 excludes reftable), so there
must be somebody else that is broken.

An all green build https://github.com/git/git/actions/runs/74741625
was my attempt to see how ready these tests are (not 'how ready
other topics are to be tested by this topic) by moving the
swap-azure-pipelines-with-github-actions topic early in 'pu',
temporarily discarding many other topics, and pushing it out, by the
way.
