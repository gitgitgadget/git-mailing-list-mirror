Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE88820A40
	for <e@80x24.org>; Tue,  5 Dec 2017 12:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbdLEMfR (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 07:35:17 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65276 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752042AbdLEMfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 07:35:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E2FD0AFBD3;
        Tue,  5 Dec 2017 07:35:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H25uPUnmCOmU4oGtG7tUdiBPiro=; b=UAxRUc
        xuI2rtE/1oRWPybT9ZSSxNv9J9jFc0Ymn64yWrTX/Qk7oLxrOwiBCuOxHamtLkvd
        YSkPqDnjrvWrjUSB+7IenpxrY/DfFYMEk7YH88CaJWKjjDsUSK301RKzto+aX1Cg
        4gG8ohBpoY7rC1IKhu2DFABrHVwItGZ5G7lXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mW7hES5QSd6I2xC6WygcRSf6Qd/erz1r
        UhUwzgx6NDw81xPw6irL8nigySMuk1GiMAdQBHeyvH8UC88Tjf+nGFV3fLkIB8Bg
        iYFtO1gFPpQ5sK/oiRCthwxvtdxuzS2HdBa89gCcARFGhOI45W8B05qenPKGhde/
        2SzyvSbcZRk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DBA75AFBD1;
        Tue,  5 Dec 2017 07:35:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6111DAFBCE;
        Tue,  5 Dec 2017 07:35:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     liam Beguin <liambeguin@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 4/9] rebase -i: refactor transform_todo_ids
References: <20171127045514.25647-1-liambeguin@gmail.com>
        <20171203221721.16462-1-liambeguin@gmail.com>
        <20171203221721.16462-5-liambeguin@gmail.com>
        <alpine.DEB.2.21.1.1712041541000.98586@virtualbox>
        <xmqq4lp6o4p4.fsf@gitster.mtv.corp.google.com>
        <ddb4bc14-0598-aaab-af1c-e3a714a6c49b@gmail.com>
Date:   Tue, 05 Dec 2017 04:35:14 -0800
In-Reply-To: <ddb4bc14-0598-aaab-af1c-e3a714a6c49b@gmail.com> (liam Beguin's
        message of "Mon, 4 Dec 2017 22:36:53 -0500")
Message-ID: <xmqq1sk9l5dp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BEA9E72A-D9B8-11E7-AC6C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

liam Beguin <liambeguin@gmail.com> writes:

> Good suggestion. Would transform_todos() work too?

If the function is about munging multiple of them, then todo"s"
would work well; I wasn't focusing on singular vs plural, as I
thought the choice between them needs much less thought to make
correctly.

