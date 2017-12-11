Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A38301F404
	for <e@80x24.org>; Mon, 11 Dec 2017 20:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbdLKUnW (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 15:43:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52128 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750929AbdLKUnV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 15:43:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FC5EB02F8;
        Mon, 11 Dec 2017 15:43:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZzDLquGHR6+B
        Xdo8HrVhHzQxzuQ=; b=ZiPKkItbJMLe6BYnSCEdtRt0eLpSVVRy4MIrFcPDULda
        B1uF/a99Cxv7nziv0o+QvDzs5Coqv+ymXQHv3PV/nibrfgytTzFD/9nfNDwg7Nso
        wbS3ZE+pwrRoLBz2cQVzd39WmTEk8bGa8rOnCE0ALYnPCO3UMju74YT/wyVVeh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=L6cxf9
        qhhnqaXOUFx0kzJ1BPlOnIXOpTQ+KQl4YorULsAjV/zyy5OhPyzcXkXp6Swb7/XY
        WEiuBdYS0ugSscglE0rn80Ixow74B762drCEgUPAT1RptCHMOePVW3Gr0OC4SV9T
        DduA1s1O5qFlYtMC5vvL0eMtDCmBBHxt+GR98=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1734CB02F6;
        Mon, 11 Dec 2017 15:43:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 481D3B02F5;
        Mon, 11 Dec 2017 15:43:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Subject: Re: [PATCH Outreachy 1/2] format: create pretty.h file
References: <01020160364a23d5-471a2fd0-9fff-4599-86f8-b2f37a4a0a84-000000@eu-west-1.amazonses.com>
        <xmqq7etx9kzq.fsf@gitster.mtv.corp.google.com>
        <20171210145354.GA20367@sigill.intra.peff.net>
        <xmqq8tea5hxi.fsf@gitster.mtv.corp.google.com>
        <CAL21Bmnq63BNGwbkgbSpY-G+GMYBG4UC9+-YL1Gru84Be3EkeA@mail.gmail.com>
Date:   Mon, 11 Dec 2017 12:43:18 -0800
In-Reply-To: <CAL21Bmnq63BNGwbkgbSpY-G+GMYBG4UC9+-YL1Gru84Be3EkeA@mail.gmail.com>
        (=?utf-8?B?ItCe0LvRjyDQotC10LvQtdC20L3QsNGPIidz?= message of "Mon, 11 Dec
 2017 12:58:05
        +0300")
Message-ID: <xmqqzi6p3sih.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EC4D6ABC-DEB3-11E7-B05B-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F  <oly=
atelezhnaya@gmail.com> writes:

> Is it true that I need to fix only one commit message? (a typo
> s/futher/further/)
>
> Do you have any other advises what do I need to change?

I thought I mentioned that adding #include to all the current users
of "commit.h" is way too noisy.  I may have pointed out other issues
as well, but I offhand do not remember ;-)
