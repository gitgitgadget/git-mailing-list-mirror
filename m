Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347E72021E
	for <e@80x24.org>; Sun,  6 Nov 2016 17:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751175AbcKFRPA (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 12:15:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62529 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750995AbcKFRO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 12:14:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F9724AA23;
        Sun,  6 Nov 2016 12:14:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OHY7c2KisBwotbgvfq6xdflpV8s=; b=LY14oV
        GSHL44OjrIKf6M4Mfcnc/WmlgpNq9JXgUSKD9BpVQ1pva8KYQI2rrcoFuPZ2Snks
        Tufgs6TfWBn4K9Qu6LcpVVKam1v0H/QLUJg79jpMRV+HIxlf2fEPLbSi052J8CwX
        w3KyCpgRO+CicKKndVjVvbzOkDsozIGjHJmog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vf5ai7OALKvFB/jKKo95uzhCEHbgvV1Z
        rRboraKqsWQfk9eXD0VPNTJAj9kIhFdTqJIcbVshobtDTzrgrjM3kmDP5Bq/OxHI
        ksgRxcCOBDn5j/6NPtvYnyUKIc3v7pmtQyy5GV4YsRGSRVCpotUawHuVYnlpkwML
        e88I3K7f1H0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 24FF24AA22;
        Sun,  6 Nov 2016 12:14:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 91E5F4AA21;
        Sun,  6 Nov 2016 12:14:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>
Subject: Re: Regarding "git log" on "git series" metadata
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD2+A0MUKazAfSwCvv61TJRPuoOzH5EkqcrBOUi4TcuoDw@mail.gmail.com>
        <xmqq1syqedv4.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD0bqNQZ3nuGUDX0qrSo44hf1NL9LeZB_FQcXg3j0mD38A@mail.gmail.com>
        <CAP8UFD1EZ8HBzLAeyFBFgU7n2uJpswqgEgA4XM1YJuRAG_ZAAQ@mail.gmail.com>
        <20161105151836.wztypzrdywyltvrc@x>
        <CAP8UFD3XFHr7POKmZr_6guapC6sme3GvWBV5vPw4XO7FE5HOPw@mail.gmail.com>
        <20161105202553.migx75gfuujakqyk@x>
        <CA+P7+xoG3ag8dj7s_NRoqz-EwjVENSJSzE_qj6gnW-SmWt0bgA@mail.gmail.com>
        <20161106163410.ilysej5r6qd3744e@x>
Date:   Sun, 06 Nov 2016 09:14:56 -0800
In-Reply-To: <20161106163410.ilysej5r6qd3744e@x> (Josh Triplett's message of
        "Sun, 6 Nov 2016 09:34:10 -0700")
Message-ID: <xmqqshr4cyy7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AEACD14-A444-11E6-A35B-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> We could, but if we (or one of the many third-party git implementations)
> miss a case, gitlinks+reachability may appear to work in many cases with
> dataloss afterward, while gitrefs will fail early and not appear
> functional.

I wonder what happens if we do not introduce the "gitref" but
instead change the behaviour of "gitlink" to imply an optional
reachability.  That is, when enumerating what is reachable in your
repository, if you see a gitlink and if you notice that you locally
have the target of that gitlink, you follow, but if you know you
lack it, you do not error out.  This may be making things too
complex to feasibily implement by simplify them ;-) and I see a few
immediate fallout that needs to be thought through (i.e. downsides)
and a few upsides, too.  I am feeling feverish and not thinking
straight, so I won't try to weigh pros-and-cons.  

This would definitely need protocol extension when transferring
objects across repositories.
