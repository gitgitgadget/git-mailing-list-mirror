Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D6961F404
	for <e@80x24.org>; Tue, 23 Jan 2018 18:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeAWSl7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 13:41:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55182 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752082AbeAWSl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 13:41:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80453B7732;
        Tue, 23 Jan 2018 13:41:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jRpjIaBnG3oePD3NjBPJhLfqoyc=; b=w/gnDS
        t9tnGzfwf9q1pWsq+3ubiEgIt3ZGtXXmGjDhMqw531EOBAiF+oW1PYXMDTp44h/Q
        R+zlls3bZoI2IX/SpD5LQ58jQzsyPMjf59Lx0Bs6QEHYF1hDUyUQf7QBCJ6Xtzv3
        uxbFdBgJ+fXQmR4H/Jdjx8M3lF9hH2XjNPpOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r4f+F+bkidIsaQjUw6q5BCWmxCLklEgP
        N2D8WkHDVvkf3/ZWKNq1b9rQaw8GC6eGy84uH9zNjGMkkvYMSZQ7hvGBef5ZOv4g
        m9supIYkvUU7tFFgik+xUoaCzhg71gkKq5Hj1O8qKgtQEA3bH4OnTbci9/JBeLhX
        DXsMYCuTGvM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7614AB7731;
        Tue, 23 Jan 2018 13:41:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DCAEEB772F;
        Tue, 23 Jan 2018 13:41:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/2] t7505: Add tests for cherry-pick and rebase -i/-p
References: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
        <20180123102420.19911-1-phillip.wood@talktalk.net>
        <20180123102420.19911-2-phillip.wood@talktalk.net>
Date:   Tue, 23 Jan 2018 10:41:56 -0800
In-Reply-To: <20180123102420.19911-2-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Tue, 23 Jan 2018 10:24:19 +0000")
Message-ID: <xmqqzi54h0y3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 177567AA-006D-11E8-9F41-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> +			export GIT_SEQUENCE_EDITOR GIT_EDITOR &&
> +			test_must_fail git rebase $mode b &&
> +			echo x>a &&

"echo x >a"
