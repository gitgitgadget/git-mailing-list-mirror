Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2385C20958
	for <e@80x24.org>; Thu, 23 Mar 2017 19:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965831AbdCWTQC (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 15:16:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50037 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965827AbdCWTQB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 15:16:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3729A66E1B;
        Thu, 23 Mar 2017 15:16:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pg7nC5IljsDgUwkoLj7es1SmGnc=; b=Xo1Hnn
        ppBY10AtHA1XianPtDDPxfyRZoy7XztjHgwwd3RAGmE/1baDkZp51LTc129BpruJ
        ROz6z5zgJRxi37Owb1P/DFEkLBCS7PY+0QlQ986tc+9YTaefWioVwMLOG/3Dd6m9
        euMurid9og7U2vwbmjCbhkFirnIXKwWv9D+Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mrus6CHhOcoKe4IrNZ7We06+7hSNmTsG
        XrCb8PF3p11rDqXUvMHa6slF24YFO1oHszysTYhB0otb51F/42799w41lknDXQm4
        VdPSgP9kWZnMtTaBw0e0pxe8U0l76mMwShgIls67OHR/b3bm/M/WBNx8vdZc6VDg
        JQm0RVt2/fo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FB1566E1A;
        Thu, 23 Mar 2017 15:16:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 935B866E18;
        Thu, 23 Mar 2017 15:15:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
References: <20170322065612.18797-1-larsxschneider@gmail.com>
        <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703231716320.3767@virtualbox>
        <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net>
Date:   Thu, 23 Mar 2017 12:15:58 -0700
In-Reply-To: <20170323180134.geoyvq7qbm5vujo6@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 23 Mar 2017 14:01:34 -0400")
Message-ID: <xmqq7f3fdcsx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25F6B8E4-0FFD-11E7-8ABE-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think both Junio and I have access to the Travis config. Travis does
> have a "this is secret" flag for setup config. But I think we'd need to
> verify that running the Travis build does not leak the variable in any
> other way.

I am not sure if I want to "Authorize application" at the GitHub
site to give Travis that broad set of permissions, though.  That is
why I do not "log in with GitHub" to Travis.

I just logged into Travis and it seems to me that git/git is set to
build branch updates (which sounds sensible) and also is set to
build pull request updates.  That somehow sounds like a dangerous
mix with the "secret environment variables" thing, at least to me.

> For instance, if it's in the environment, can I push up a branch that
> does "set | grep GFW_CI_TOKEN", open a PR, and see it? I don't know the
> answer.
