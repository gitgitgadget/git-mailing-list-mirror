Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6E1C001DF
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 15:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjGaPZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 11:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGaPZY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 11:25:24 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D17B1702
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 08:25:22 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F18561A99F1;
        Mon, 31 Jul 2023 11:25:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K0VbIpH3NMxOD+ZPECOxZvqCl2Wh69k+nu08pi
        iEBl0=; b=MC+N6csN8MHlbiVr1ABX86icA9TVdnQNAhpQq94CP90frbNK6JJDsg
        EqpF/N2WsvtdFLwjtAbKOdOagp4Id9LJ6kwIa8pmURqfnX8c/de9cNdxLJvbZujd
        kedhaa+Bi7CwTg2k4M0Yd49/7fq7ZljHj+p4nWRv+QnTSjRAgIerQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8B711A99F0;
        Mon, 31 Jul 2023 11:25:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4CD3E1A99EF;
        Mon, 31 Jul 2023 11:25:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: Re* [PATCH v4] MyFirstContribution: refrain from self-iterating
 too much
References: <xmqq3583uyk0.fsf@gitster.g>
        <20230123175804.2bkcr7yawyz5fhkb@tb-raspi4>
        <xmqq8rbbbzp2.fsf_-_@gitster.g> <owlycz0deykz.fsf@fine.c.googlers.com>
        <xmqq7cqkanm9.fsf@gitster.g> <xmqqmszg987u.fsf_-_@gitster.g>
        <eaky7y2tprkzvhjdcg5vv2asekclywfcthzolpfu5o363423ca@b3p33bsbcqi5>
        <xmqq7cqk8vuk.fsf@gitster.g> <xmqqa5vg59ga.fsf_-_@gitster.g>
        <ivxtqzb46kp5uz5luuxkow6fjzwqrnvxu6f7mgu5a4mnatt6hc@djeykymbumn6>
Date:   Mon, 31 Jul 2023 08:25:19 -0700
In-Reply-To: <ivxtqzb46kp5uz5luuxkow6fjzwqrnvxu6f7mgu5a4mnatt6hc@djeykymbumn6>
        (Jacob Abel's message of "Sat, 29 Jul 2023 02:12:05 +0000")
Message-ID: <xmqqr0oo14tc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75E0B4BA-2FB6-11EE-BB5B-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Abel <jacobabel@nullpo.dev> writes:

> Maybe something along the lines of "wait 24 hours after any discussion
> regarding the current revision has settled before publishing the next
> revision" would be a good guideline even if it's not included in this 
> patch?

Perhaps.

Usually after an iteration or two of a topic, it will become clear
who are available and interested in the topic, and "Wait and give
them enough time to respond to what you write" would become the most
appropriate guideline at that point.

But for new contributors and for more experienced ones alike, the
interest level from others is much harder to assess for the first
iteration, until everybody on the list has chance to notice and get
interested in the topic.  So "wait at least for 24 hours after
posting the first iteration" would be a good guideline for those who
do not know who on the list are the likely candidates to be
interested and know how quick their responses usually have
historically been.

A mistake I have often seen by new folks is to send their v2 soon
after they get a single minor response to their v1, without saying
why they are sending v2 at the time (e.g. "I am only fixing the typo
that was pointed out").  It takes much shorter time to come up with
a response to point out a typo or two in the proposed log message
than giving a deeper analysis, which may only come after a few
iterations of such trivial changes.
