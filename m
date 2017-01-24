Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E02631F437
	for <e@80x24.org>; Tue, 24 Jan 2017 21:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750986AbdAXVwY (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 16:52:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57341 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750877AbdAXVwW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 16:52:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B01DD62A6A;
        Tue, 24 Jan 2017 16:52:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JRjz+C1FqQhgv8IF26OSgGmxapU=; b=Wa+792
        SCIkmnOfJ9eYcgLY/BVMzebYxQAHYnl7QzniCYqMdrndfRZ0ZRxyQ7DGFkOl+rL7
        id1gXAXHYHqDdDQgHCOAiAHMt0f7pmt78jAkVKTQgpy1oFQvSmk/znkPX476CN14
        PMKSDteI5gPKZBUxDVcBxGF0R893fNIw5pM7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QFGHppm58qunKsHpN6P161NBgxMWdH1i
        odDUUzqQG12z3Timr9Pf6Nmkpb5HtmbenBjBwzOC9CLSnQdsXQqeI2Mmjw1lmdO3
        gqD7r4UUsJ1HUszhpuDH/vcG3LBnPoa+RaSPMLuwpBFRVLc+xnFuk8QCXo6lHMKA
        L2CNtKfGp/0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4EF962A69;
        Tue, 24 Jan 2017 16:52:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0E1A162A67;
        Tue, 24 Jan 2017 16:52:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David Aguilar <davvid@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] difftool.c: mark a file-local symbol with static
References: <xmqqtwaod7ly.fsf@gitster.mtv.corp.google.com>
        <20161130212510.ihcmvig7jq44p3nx@sigill.intra.peff.net>
        <3e6a6685-19ec-4536-4a5f-3a56e30fb530@ramsayjones.plus.com>
        <20161130231848.v5ge6otytim2t6d2@sigill.intra.peff.net>
        <xmqqinr4bkf4.fsf@gitster.mtv.corp.google.com>
        <59da5383-16a0-b327-75a8-b4c4ad7bd479@ramsayjones.plus.com>
        <20161201040234.3rnuttitneweedn5@sigill.intra.peff.net>
        <xmqq60n3bjel.fsf@gitster.mtv.corp.google.com>
        <20161201185056.eso5rhec7izlbywa@sigill.intra.peff.net>
        <20170122052608.tpr5pihfgafhoynj@gmail.com>
        <20170124142346.u3d7l6772mtkgpcf@sigill.intra.peff.net>
Date:   Tue, 24 Jan 2017 13:52:13 -0800
In-Reply-To: <20170124142346.u3d7l6772mtkgpcf@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 24 Jan 2017 09:23:46 -0500")
Message-ID: <xmqqlgu0ceia.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E368B72-E27F-11E6-8335-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > As ugly as warning("%s", "") is, I think it may be the thing that annoys
>> > the smallest number of people.
>> > 
>> > -Peff
>> 
>> How about using warning(" ") instead?
>> 
>> For difftool.c specifically, the following is a fine solution,
>> and doesn't require that we change our warning flags just for
>> this one file.
>
> I dunno. As ugly as the "%s" thing is in the source, at least it doesn't
> change the output. Not that an extra space is the end of the world, but
> it seems like it's letting the problem escape from the source code.
>
> Do people still care about resolving this? -Wno-format-zero-length is in
> the DEVELOPER options. It wasn't clear to me if that was sufficient, or
> if we're going to get a bunch of reports from people that need to be
> directed to the right compiler options.

I view both as ugly, but probably "%s", "" is lessor of the two
evils.

Perhaps

	#define JUST_SHOW_EMPTY_LINE "%s", ""

		...
		warning(JUST_SHOW_EMPTY_LINE);
                ...

or something silly like that?

