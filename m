Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A30420281
	for <e@80x24.org>; Tue,  3 Oct 2017 00:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbdJCAwY (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 20:52:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57997 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750869AbdJCAwX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 20:52:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A00FAB3035;
        Mon,  2 Oct 2017 20:52:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NJPsotqqobRxCdDbTBIkr6kwgDg=; b=MSs7B1
        9MDTxNXMRQRCLK/SpE0fPmwfaykC/iiCAe/2IPs+eBho4m6Z3NseCJXegrAlj0du
        EOKJGJPePSgd1DF51qk+tphBZW7VahVFmtU6G4X8UC2cOV2YNNimdkGnavL/aMYw
        UmDgvSnLk9YrNgXumzsVt7YKxJ1abWsU8hJQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nzJqziKHMC3VjqsFJKZJXKroDqibSUuO
        nKxQXzkazUGzBiJciXbenY5V+nkmEcjtyVJWpuhSBKo99Z7RSaytOj9r+Z2eVuiT
        n3ecZ1gwCbahOtUekacfB09VPpyfTRCh3twWSsZr9E9mCMULUVqYt/cSNprUKzUe
        TcIvjvIOn2U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97B82B3034;
        Mon,  2 Oct 2017 20:52:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 001A8B3033;
        Mon,  2 Oct 2017 20:52:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.org>,
        Pavel Kretov <firegurafiku@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [idea] File history tracking hints
References: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com>
        <E8C827ED458648F78F263F2F2712493B@PhilipOakley>
        <alpine.DEB.2.21.1.1709131322470.4132@virtualbox>
        <04DDB36236444FFD8C3668AA7B62B154@PhilipOakley>
        <alpine.DEB.2.21.1.1709300110350.40514@virtualbox>
        <5fb263a8-d83b-64a7-812f-fd8e3748feb6@jeffhostetler.com>
        <xmqqtvzjv987.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbghnWmvQweup=Z79HnVQQCMM65CKgEO3oqDoRp-Bj=2Q@mail.gmail.com>
        <ea1538e3-2b2e-f7eb-9c0e-e29c15bf2ea9@jeffhostetler.com>
        <CAGZ79kbjfXC3CxMDouUrCUVt-OJXckDtg9U_7=R=FM-eon4ikA@mail.gmail.com>
        <f9b722d9-cd37-40f3-7ae4-6f7f3d90de83@jeffhostetler.com>
Date:   Tue, 03 Oct 2017 09:52:20 +0900
In-Reply-To: <f9b722d9-cd37-40f3-7ae4-6f7f3d90de83@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 2 Oct 2017 16:02:09 -0400")
Message-ID: <xmqqy3otkq7v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D608E06-A7D5-11E7-87D1-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>> How do you know when a guid needs adaption?
>
> I'm not sure I know what you mean by "adaption".

I think he meant adapting, and I think he is referring to what I
wrote in the message upthread to explain why "file ID" would not
help.

It seems to me, from reading the remainder of your message, that it
is also becoming clear to you that "file ID" would not help and your
conceptual thing was merely a hand-waving that was dubious how it
could be made into a concrete working design?  Hopefully we can
converge on a workable design that does not involve "file ID", and
that would be a good outcome.


