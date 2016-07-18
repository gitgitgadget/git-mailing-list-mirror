Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55352018B
	for <e@80x24.org>; Mon, 18 Jul 2016 21:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbcGRVg1 (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 17:36:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751892AbcGRVg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 17:36:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C7BB02C1B4;
	Mon, 18 Jul 2016 17:36:24 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZrccIgyOy8kTNgDoWK2Ha5/STbI=; b=RDY66P
	wKDEshQb0TBD5lsLfgObX1C8I7eDjX7/tNsVC3yNH4XZHS95d4GAjI/EZmWNTyqa
	MaPGxZDEgSc3kqyBKuA1vyqS26HNAJ/uySGRnHXk+XEg+UZ4nVS+lzOUsV1PSjMo
	2fwD1klG8f3BHBhH+OQdb1vDY0UClqhHvoz/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OlMIXfMGdL2MYwQZ8jqQBfFCSXpwnJ1X
	7ML6bIaXNjCteecg3iqb2ehLqM5uDGjBwsXUpODoCz1nmVJwB398L6CheRdI9RJ+
	klrhlS9ZzwYNGsc0gMqLhi9BtPXCQxD4MUmNk1UG/qB2L3bItXbrUjQC1XEKlFX2
	0Yq3ljRVwKc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BE7F12C1B3;
	Mon, 18 Jul 2016 17:36:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 59E9C2C1B2;
	Mon, 18 Jul 2016 17:36:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jonathan Tan <jonathantanmy@google.com>
Cc:	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] fetch-pack: grow stateless RPC windows exponentially
References: <1468867019-13086-1-git-send-email-jonathantanmy@google.com>
	<20160718185527.GB29326@google.com>
	<xmqq37n6kbib.fsf@gitster.mtv.corp.google.com>
	<CAGf8dgJVkkVwJ5aJCQBcYKw7F9g7u3pMsuJHedSGLG6PQk2Keg@mail.gmail.com>
	<20160718193147.GC29326@google.com>
	<xmqqoa5uiumu.fsf@gitster.mtv.corp.google.com>
	<CAGf8dgJWMBbU1rbU1hTOjX9d-b-ocmYs-td9kpQ=skQFM7XcSA@mail.gmail.com>
Date:	Mon, 18 Jul 2016 14:36:22 -0700
In-Reply-To: <CAGf8dgJWMBbU1rbU1hTOjX9d-b-ocmYs-td9kpQ=skQFM7XcSA@mail.gmail.com>
	(Jonathan Tan's message of "Mon, 18 Jul 2016 14:05:22 -0700")
Message-ID: <xmqq37n6iq7d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD11CDDC-4D2F-11E6-BB43-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> and it would look like that patch. (I would probably redefine
> LARGE_FLUSH to be 10 times its current value instead of multiplying it
> by 10, since it is not used anywhere else.)

Sounds good.  Care to do the final version of the patch to be
applied?

Thanks.
