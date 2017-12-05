Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD20220A40
	for <e@80x24.org>; Tue,  5 Dec 2017 16:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbdLEQFl (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 11:05:41 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50883 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751937AbdLEQFl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 11:05:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A3D4BDEC4;
        Tue,  5 Dec 2017 11:05:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pPtFm+aR/RRSOUsg1FCg2DoL2E0=; b=bkPdOc
        c8Ehb2zZAfaKYKooPM2ZntL+gJztHNLhmgQEktsff91vZL8HwAS1P1FeXxHKdp+v
        +1vXizaoqUdRNrVBzY32HDw+O93tm9/868iD9ZOdNoYp6/enasBipGEFMyh5CwC8
        YJAcVhAFeKDdIqYxI7TRxN1mB8oXuIeSbwLrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aqZMX5FqnG5fGdQluiwqvqJZWyXyWW6b
        +OjW+4Ky2LDmXUbhS70FYZCRaO/ruYs4YlI742gNQJplGARMgtXhj/WgTjtL6qHU
        C/I/plRXuPGARhmeXI0IrmQdFXIwSTZ/XfNA39DoPOrGOFTcSvZmorZtksLpVwgG
        ZcQweU0dy6Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FBCCBDEC3;
        Tue,  5 Dec 2017 11:05:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A686BDEC1;
        Tue,  5 Dec 2017 11:05:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kerry\, Richard" <richard.kerry@atos.net>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "peff\@peff.net" <peff@peff.net>,
        liam Beguin <liambeguin@gmail.com>
Subject: Re: [PATCH v2 6/9] rebase -i: update functions to use a flags parameter
References: <20171127045514.25647-1-liambeguin@gmail.com>
        <20171203221721.16462-1-liambeguin@gmail.com>
        <20171203221721.16462-7-liambeguin@gmail.com>
        <alpine.DEB.2.21.1.1712041643250.98586@virtualbox>
        <22f665eb-0ed1-27d4-7184-e6063ea5b47e@gmail.com>
        <xmqqwp21jqpl.fsf@gitster.mtv.corp.google.com>
        <HE1PR0201MB19938A1581F799CB9D48AE999C3D0@HE1PR0201MB1993.eurprd02.prod.outlook.com>
Date:   Tue, 05 Dec 2017 08:05:36 -0800
In-Reply-To: <HE1PR0201MB19938A1581F799CB9D48AE999C3D0@HE1PR0201MB1993.eurprd02.prod.outlook.com>
        (Richard Kerry's message of "Tue, 5 Dec 2017 12:41:03 +0000")
Message-ID: <xmqq4lp5jh2n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 221A4D50-D9D6-11E7-B643-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kerry, Richard" <richard.kerry@atos.net> writes:

> "Shorted" is what happens when you put a piece of wire across the terminals of a battery ... (bang, smoke, etc).
> It's short for "short-circuited".

Or it is what you do to something that you sell and that you yet do
not own, expecting that you can later buy it cheaper, allowing you
to pocket the difference ;-).


