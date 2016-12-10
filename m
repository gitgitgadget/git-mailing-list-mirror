Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 437F41FF7F
	for <e@80x24.org>; Sat, 10 Dec 2016 18:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbcLJSQG (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 13:16:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57992 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751892AbcLJSQF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 13:16:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7375B53E2A;
        Sat, 10 Dec 2016 13:16:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iTO0XyB+guPWvbFeRmGpC/x/hOw=; b=U1HjCf
        qxk/+DfnCRa/yo46gHM8hW9ctawnnNJydVlJqppcjacFoqUBPx16HALqae1PKii2
        MYlhtr1TSrpG0rszWH8WXGhP7FSNFkrowuSLyRhVuj2Ab2Ih9gsS5RRMb48uB71C
        G9jNKlT9aVTrNqyiV3j4/VQaGYJy0Np21DXXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v786IQ0QsmmQDy7siSEjaGuYHRsgzKon
        jqpR07tb3/bF3hbbPtOBOvFuy37UWEcl49Qlzlb2uZUnlmUIlO4C0hYyoPqMtaDz
        LduDXUKj35LmwjwYhbuiASf3HcVpY00hqcNKaISMaBADv0QsbHveRLbCgXo0tqNt
        v/O0+xTxm4I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B6D453E28;
        Sat, 10 Dec 2016 13:16:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D8D3253E27;
        Sat, 10 Dec 2016 13:16:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
Subject: Re: Any interest in 'git merge --continue' as a command
References: <CAFOYHZDs5rBt5+4D_ViMYfV04foq3h_UrsSMA3FfyMzLh9QdwA@mail.gmail.com>
        <20161209091127.sxxczhfslrqsqs3m@sigill.intra.peff.net>
        <xmqqshpwrjyz.fsf@gitster.mtv.corp.google.com>
        <20161210085938.rfbkuwpvyhnhuzhn@sigill.intra.peff.net>
Date:   Sat, 10 Dec 2016 10:16:02 -0800
In-Reply-To: <20161210085938.rfbkuwpvyhnhuzhn@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 10 Dec 2016 03:59:39 -0500")
Message-ID: <xmqqoa0jps4d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B634993E-BF04-11E6-AC09-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> No, I think your reasoning makes sense. But I also think we've already
> choosen to have "--continue" mean "conclude the current, and continue if
> there is anything left" in other contexts (e.g., a single-item
> cherry-pick). It's more vague, but I think it keeps the user's mental
> model simpler if we provide a standard set of options for multi-step
> commands (e.g., always "--continue/--abort/--skip", though there are
> some like merge that omit "--skip" if it does not make sense).

Yup.  I know you know me well enough to know that I didn't mean to
say "oh this one needs to be called differently" ;-)  I just felt
that "--continue" in that context did not sit well.
