Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59017C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 11:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C18822311
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 11:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CXtjG9Xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfKTLf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:35:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53550 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfKTLf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 06:35:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 854D826166;
        Wed, 20 Nov 2019 06:35:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9TsPWna1lq3v
        2wbQOLMljfqot4I=; b=CXtjG9XwIxHiZCTs+XMxab6Tt7AUWLbb9CheOFuygT/Y
        uu3+esLYDenGQYqiAceVs1+271kH2Iae6/SEf0M9C8krMxdRTUZOjlkpqaeLsnMO
        icjLPZaP3nwdt+MEtfzkreEJIYCNE5xYMb/w1XIav8UXyFaS4qnVTkrG+ho+dGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PpEXkO
        YK72rctJmRlK+rees0WZ9rl/SRrEUzvEGPq13FrvB5Snl/degkEiH193u8cSPUHB
        VfLDu9EY+ivGkxiJP8X+9N+Cqw3WNd1OEKbEyWioLWWspczYOVIBFncC1pxVqZ4s
        9Ls8s7IbJ+73YDYUuduF+bjUB3mx0eoTYGXNg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C26726165;
        Wed, 20 Nov 2019 06:35:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB65726160;
        Wed, 20 Nov 2019 06:35:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/1] ci(osx): use new location of the `perforce` cask
References: <pull.400.v2.git.1571316454.gitgitgadget@gmail.com>
        <pull.400.v3.git.1571789978.gitgitgadget@gmail.com>
        <9d80e845bf923c4543c49f9947aacb10c59ff6ce.1571789978.git.gitgitgadget@gmail.com>
        <20191118221804.GA23183@szeder.dev>
        <nycvar.QRO.7.76.6.1911192155140.15956@tvgsbejvaqbjf.bet>
        <xmqqk17ve45s.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911201157500.15956@tvgsbejvaqbjf.bet>
Date:   Wed, 20 Nov 2019 20:35:55 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911201157500.15956@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 20 Nov 2019 11:59:22 +0100
        (CET)")
Message-ID: <xmqqo8x6bx0k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EAFE3038-0B89-11EA-8D24-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Subject: ci(osx): update homebrew-cask repository with less noise
>>
>> The OSX CI build procedure updates the homebrew-cask repository
>> before attempting to install perforce again, after seeing an
>> installation failure.  This involves a "git pull" that by default
>> computes and outputs diffstat, which would only grow as the time
>> goes by and the repository cast in stone in the CI build image
>> becomes more and more stale relative to the upstream repository in
>> the outside world.
>>
>> Suppress the diffstat to both save cycles to generate it, and strain
>> on the eyeballs to skip it.
>>
>> Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Log of tonight's 'pu' https://travis-ci.org/git/git/jobs/614370507
shows me that this did the job, compared to tonight's 'next' that
does not have it, https://travis-ci.org/git/git/jobs/614370474

So let me merge it down to 'next' and further soonish.

Thanks.
