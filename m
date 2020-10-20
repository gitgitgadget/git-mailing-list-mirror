Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416B8C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 21:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B20882225F
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 21:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QpROJsWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438614AbgJTVA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:00:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63365 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438555AbgJTVA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 17:00:58 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 389E386D81;
        Tue, 20 Oct 2020 17:00:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e5hSc9c1BPnhNrROwuyndT2WaO8=; b=QpROJs
        WLnitGIK3FQtpuBzO5VXYttJLfTHpu4WudNrAazNwVYDEKlmaoazbMXC2SvDAP4T
        efdtjYXew7/5yJzbAQREkoWac/DzcP4u59/kB9pbMK8o027yFWOprWlcOIdSHHKJ
        2Z37ZMWlFlcvOgnUTbxDhrhbhYoswVEXqcJKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z6sRc+Ql1CNktl15bVNBtMHC4ZRWw2RR
        sbKKvu+qM+AcgoGuT494pa3YBpMsSH+An+jmdV2pJYJIGwqDlyqg1C5tRU7n1BjC
        WSa1L+Vdn7JWAOIW65mcoMFEazjajL9HTbA8gfBvMBwZG8gsDFtFJC0Byr0ZIWWq
        wdihIDFe1AE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30AA786D80;
        Tue, 20 Oct 2020 17:00:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B40A286D7F;
        Tue, 20 Oct 2020 17:00:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        congdanhqx@gmail.com
Subject: Re: [PATCH v4] t7201: put each command on a separate line
References: <20201017075455.9660-1-charvi077@gmail.com>
        <20201020121152.21645-1-charvi077@gmail.com>
        <xmqqa6wgbqpq.fsf@gitster.c.googlers.com>
        <20201020201535.GB75186@nand.local>
        <xmqq1rhsbq6a.fsf@gitster.c.googlers.com>
        <20201020203024.GC75186@nand.local>
Date:   Tue, 20 Oct 2020 14:00:56 -0700
In-Reply-To: <20201020203024.GC75186@nand.local> (Taylor Blau's message of
        "Tue, 20 Oct 2020 16:30:24 -0400")
Message-ID: <xmqqk0vka9yv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59414DCE-1317-11EB-84F4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> As [v4] single patch won't apply standalone, we cannot quite declare
>> the victory yet.  Are [v3 1-5/5] (or [v3 1-4/5] + [v4]) good to the
>> reviewers of the past rounds?
>
> For what it's worth, I'm happy with [v3 1-4/5] + [v4].

Yeah, I'm happy with them, but this is an impression only from a
quick skimming---I guess I'd just trust you and won't go back to the
patches with fine toothed comb myself ;-).

Thanks, all.
