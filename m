Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203BDC0018C
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 23:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB39B23B85
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 23:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394368AbgLJXdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 18:33:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58140 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387939AbgLJXcw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 18:32:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F0B5810B42D;
        Thu, 10 Dec 2020 18:32:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p+0pgTswC8SjsDeAZ1yvqVH42AM=; b=mLoAkC
        /zU433hry1N3qMzVAZEJ0ITOtDEWb61VgpUVeO1PbvvD+Yet66GnRSyOh2hUjIzZ
        mdpNEbAbWvXfDUXuudcRBAMU2RqzxZ72LRPbXiiCF5eadVsboL0nGr8EHwPS8TiW
        szrO2K5ozGVfHw8Vt6lRajX61OeWT4AbiFQ1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mKjTyMQ8VibBFiwhfX6or1fNOqK0Fr0I
        JnVQrp0+upps9wqcLQtFR5VHMpEuJkpDumIuu7QNgDYLb9vVfIzmjQ9p6kWGzcn+
        bq4OTKKpmOzJLevK0wrxxOGQ8xVNCST14URvaS3Aq+8sGWeypw5iNQny8B37YAHo
        aD5fi7GnzXA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EAD1810B42C;
        Thu, 10 Dec 2020 18:32:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2D92310B42A;
        Thu, 10 Dec 2020 18:32:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] init: provide useful advice about
 init.defaultBranch
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
        <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
        <bccef953913da629057b3e9b211bc54081fa4475.1606173607.git.gitgitgadget@gmail.com>
        <xmqq8sarljfn.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011240648160.56@tvgsbejvaqbjf.bet>
        <xmqq8saqjx2n.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2012091513540.25979@tvgsbejvaqbjf.bet>
        <xmqqblf21v9e.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2012101309590.25979@tvgsbejvaqbjf.bet>
Date:   Thu, 10 Dec 2020 15:32:03 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2012101309590.25979@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Thu, 10 Dec 2020 13:12:08 +0100
        (CET)")
Message-ID: <xmqqpn3hqlu4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA22471C-3B3F-11EB-982C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I talked to a couple Git users whether they'd be fine if `git init` used a
> different branch name by default, and everybody I asked said essentially
> "yeah, whatever, I don't really care".

Yeah, I would expect that, too.  They would not have asked about the
details on when that switchover of the default would happen, and
would not have been told that the timing is not under their control.
I would answer to such a question with "yeah, whatever." that does
not give you an assurance that I won't complain when the switchover
actually happens ;-).


