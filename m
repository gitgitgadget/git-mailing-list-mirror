Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81B7C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 22:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879912053B
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 22:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OJSvIHyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfLJWU3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:20:29 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50262 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfLJWU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 17:20:28 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE549AAC15;
        Tue, 10 Dec 2019 17:20:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6mgDcrmGqJD2h9Iv0AIfE/pjYY0=; b=OJSvIH
        yq/r+uGnX9+h7/uLfyGSGtFf5JyAtaQC9PdIJ7ir/fxm/zMQNj2ZPvFoRrcjL7gt
        etWkwrr55iJLBbOn4ewoSv5vvFh2HLk8zPyg0uay7i+e3vZReKeXrk69RU23QpeG
        roinnMOm9wyfTX4Cb0mPRn85NER7qLVDwwvZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=If/oPaT7MZYjEX3APvstcI6ookv08iu2
        ZVBW0JIAnxws7mcK0iCqtNw0+MOugDDcAGIAoEI4djliRdxadRtryFDvRj6C/VEi
        o5nLPe2IGSjvaChQrqP7YlelgojmbiL00mx+zgJFrWh81ZeNzHoZgU43LWLgHtk+
        CX260a/6eyw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A5F19AAC14;
        Tue, 10 Dec 2019 17:20:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B488DAAC12;
        Tue, 10 Dec 2019 17:20:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, KOLANICH <kolan_n@mail.ru>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: Could /Documentation/technical/commit-graph.txt be relicensed under a permissive license?
References: <E2770343-BB39-458C-835E-04F0753783C3@mail.ru>
        <xmqqimmoq6vw.fsf@gitster-ct.c.googlers.com>
        <70575b23-6adb-a29b-8df8-f9099f86eb0e@gmail.com>
        <20191210205056.GA14079@coredump.intra.peff.net>
Date:   Tue, 10 Dec 2019 14:20:21 -0800
In-Reply-To: <20191210205056.GA14079@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 10 Dec 2019 15:50:56 -0500")
Message-ID: <xmqqeexbrffe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 427C9E1E-1B9B-11EA-A86F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> What _could_ be problematic is repeating the documentation directly
>> in another permissive-licensed repository.
>
> That's my understanding as well. That said, I would not be opposed to
> some kind of statement in the documentation making our view explicit.

In principle, I do not mind that either.

But quite honestly, I cannot say that I am (or "want to be") all
that sympathetic.

It takes me some effort to convince myself that it is worth for us
to spend extra brain cycles even thinking about making such
statements, when those who would benefit the most from such an
effort are the ones who call the software we work on "contamination"
and proclaim that they cannot be bothered to spend the necessary
effort to comply with the license as a waste of time.

I'd be more receptive to those who are more friendly and
respectful---these things tend to be mutual.
