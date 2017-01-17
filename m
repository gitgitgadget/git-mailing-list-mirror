Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89765215FB
	for <e@80x24.org>; Tue, 17 Jan 2017 21:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbdAQVrY (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 16:47:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59806 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751033AbdAQVrV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 16:47:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D91AB61CEB;
        Tue, 17 Jan 2017 16:46:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9uXoZyEqMsoR7cK7oUdZAmplo4o=; b=lkVF7J
        KyoT26GL7Qd+EWm+VvSloY7uoaR5L5a/f8WwwKdLT1zDJwTEBhXlwtoQDo0fINcI
        W9TESSLBPH1m3Fmxl78uWJz1Yz5o7OyjiPz9XATgJWFiAeLf7P1a0ebD55cakeO0
        VMXIeuHbTwSzpGyyPflwgvk5FdX6T5WBt+VKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qOSpn4lnG1I2XbQkUuOkD03CmdESsup1
        PvJBaWrbCJcvVZelFRAdQYfFL/JZJ9uoHc4tnmMbZbB2GgRuO3IR3gAkjFG6A7k3
        Fmh2nltrtRGALicdUj/eiKSQie9fWvM1ZdiS9gKopVmQiUB3wGMqCzlVtyVri458
        6EaF1ndO2q0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D069A61CEA;
        Tue, 17 Jan 2017 16:46:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3065261CE9;
        Tue, 17 Jan 2017 16:46:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Paul Sbarra <sbarra.paul@gmail.com>
Subject: Re: [PATCH v5 3/3] Retire the scripted difftool
References: <cover.1483373635.git.johannes.schindelin@gmx.de>
        <cover.1484668473.git.johannes.schindelin@gmx.de>
        <8238bba389c031b091a37396fed43cac94d944e7.1484668473.git.johannes.schindelin@gmx.de>
Date:   Tue, 17 Jan 2017 13:46:51 -0800
In-Reply-To: <8238bba389c031b091a37396fed43cac94d944e7.1484668473.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 17 Jan 2017 16:55:04 +0100
        (CET)")
Message-ID: <xmqqk29tcqb8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74E1D146-DCFE-11E6-9FD0-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It served its purpose, but now we have a builtin difftool. Time for the
> Perl script to enjoy Florida.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

The endgame makes a lot of sense.  Both in the cover letter and in
the previous patch you talk about having both in the released
version, so do you want this step to proceed slower than the other
two?  I.e. merge all three to 'next' but graduate only the first two
to 'master' and after a while make this last step graduate?

