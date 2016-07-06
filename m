Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 146922070C
	for <e@80x24.org>; Wed,  6 Jul 2016 19:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291AbcGFTCd (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 15:02:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63835 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754490AbcGFTCc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 15:02:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 32B2F28C05;
	Wed,  6 Jul 2016 15:02:31 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3Fp+vNMRCizzEk5UMOxwMcB8KyQ=; b=KvvdLn
	g5fGx00t95wqLasqDwJCp4uuJ+2CATichdlL6/0i77qpib3awe/J5KI1dXpiYn5o
	ZphT5AeYPN9oImd0ys6+vs9zp1HdpVQy3z518sLZipp4pkl4wzJsGqaJb74G5XQW
	AoX4HhnU+BpY/dZnyU4RXJF+msIC1h9At3YOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NA4yIjqutE/7YCkI9He4Vbvfg44vmukO
	Uz8opWSup09GzZRXbAS5kkf/zLtAYFkUPj33W9aqHqYCNeG47NtR9VCeXDSkG3R3
	FNeNAanf+H6VjVhrkSy58O/tYFbmghP2ctjc0ojq1FV5wj+2oUA9/4XMezR0hQLX
	KtVJbQy13qc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BC5C28C04;
	Wed,  6 Jul 2016 15:02:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A3C528C03;
	Wed,  6 Jul 2016 15:02:30 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/2] t3404: add a test for the --gpg-sign option
References: <cover.1467210629.git.johannes.schindelin@gmx.de>
	<0df34c45db5b1500e55262c8948c9140e7ad6cb8.1467210629.git.johannes.schindelin@gmx.de>
	<xmqq8txn4zm5.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606301019040.12947@virtualbox>
	<xmqqpoqxz6kp.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607020933080.12947@virtualbox>
	<xmqqeg76vmzb.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607061733200.6426@virtualbox>
Date:	Wed, 06 Jul 2016 12:02:28 -0700
In-Reply-To: <alpine.DEB.2.20.1607061733200.6426@virtualbox> (Johannes
	Schindelin's message of "Wed, 6 Jul 2016 17:34:54 +0200 (CEST)")
Message-ID: <xmqqmvlusi7v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30605286-43AC-11E6-8A13-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Okay, so here is the deal: on the development machine where this was
> developed, I do not have gpg installed. So please take this test case just
> to make sure that things work as intended for the moment.
>
> Before sending the last rebase--helper patch series, I will make sure to
> add a real test that requires gpg, and submit that, too.
>
> Deal?

I do not particularly care if the latter one happens.

The only thing I care about is that the earlier round documents that
we know we probably should test the real driving of the GPG program,
but we deliberately do not do so in the series, and hint that such
an enhancement can happen later.

That might even entice others to help writing a test or two ;-)
