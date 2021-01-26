Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8642C4360C
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DC12067B
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbhAZWD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:03:57 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54157 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405401AbhAZULC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 15:11:02 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D8852115315;
        Tue, 26 Jan 2021 15:10:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GSVHRXNVY56bUA7jcxGjzcoVBBY=; b=uISOhE
        oUWdKtVym1Cpmv4J91FDcN4ZdlrD7UW1obm7W18yclxJu+t5f4BuuNrsyfC0aVtU
        Nh9U818XOZJztKq5V4r0VpiRT+tUlxM8sKrwRaj2ODdd3B6FYDI9fIihxU6T3BCG
        8nMbLemwNt1GTxJ9fAjPYkXYwgDPmCZ0HiJTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PriJcqSGi6Dmv3Zp0bmqe7dGQFyuZuhw
        VSVVilAxOzkGz/4K5jRasJzK2PSFcZPKM4Z42rN4WqO1Qwx9TXbwEYoTDZVsz6Ia
        UC54CU+v4PeO+XFBfdceJkYspJn0YvThFiPikPxfVTY7IfIcRl9CbCGo0XIoRPZB
        VRY8BZ7CFfQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D0E75115314;
        Tue, 26 Jan 2021 15:10:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0AA72115313;
        Tue, 26 Jan 2021 15:10:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: Re* [PATCH v2] fixup! mergetool: add automerge configuration
References: <20210109225400.GA156779@ellen>
        <xmqqmtxhd1zx.fsf@gitster.c.googlers.com>
        <xmqqa6thcn1n.fsf_-_@gitster.c.googlers.com>
        <20210110072902.GA247325@ellen>
        <xmqqh7np9gqn.fsf@gitster.c.googlers.com>
        <20210116042454.GA4913@ellen>
        <YAo9aTkZBCSGLYTT@camp.crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2101221728410.52@tvgsbejvaqbjf.bet>
        <YAte7ixZYdz1AOMX@camp.crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2101261522200.57@tvgsbejvaqbjf.bet>
        <20210126180635.GA28241@ellen>
Date:   Tue, 26 Jan 2021 12:10:17 -0800
In-Reply-To: <20210126180635.GA28241@ellen> (Seth House's message of "Tue, 26
        Jan 2021 11:06:35 -0700")
Message-ID: <xmqqr1m71mty.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 832151FA-6012-11EB-931A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> On Tue, Jan 26, 2021 at 03:32:13PM +0100, Johannes Schindelin wrote:
>> So I'd rather see `git mergetool` be turned into a portable C program, or
>> alternatively using a built-in helper that _is_ written in C, to perform
>> that desired text munging
>
> I tend to agree. Though my personal preference is Cygwin's (eventual)
> approach, I can appreciate the arguments made by the MSYS2 folk. But
> setting that aside, IMO, the ideal place to handle this would be the
> same place where the conflict markers are written in the first place,
> xmerge.c if my limited C literacy is correct.
>
> I don't see a big distinction between writing a single file with
> conflict markers and writing two, diff-able files with each "side" of
> the conflict -- they're ultimately two different formats for expressing
> the same information. That would give us the portability you described
> and the (pretty amazing) performance that merge-file already enjoys. :)
>
> I'm more than happy with calling merge-file twice for now. A future
> C optimisation, perhaps exposed via merge-file as a new (e.g.)
> --write-conflict-files flag, would be even more awesome.

I am OK with that "two merge-file invocations, one with --ours and
then another with --theirs" approach, as I already said in
https://lore.kernel.org/git/xmqqh7n9aer5.fsf@gitster.c.googlers.com/


