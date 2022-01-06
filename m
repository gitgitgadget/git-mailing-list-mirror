Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE15C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 17:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbiAFRut (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 12:50:49 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51800 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241987AbiAFRus (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 12:50:48 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE4D6162897;
        Thu,  6 Jan 2022 12:50:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TOYSqEdlHZWZ72mxfXW+pv0FmOrwC5YQrZ5KC0
        QmUno=; b=ik4ZkfwXJCX9XOooeQj5DPxgUOZkNvoVyf7xHDThRFNfRDp1ob9qiB
        ivGfWm4JUex4LSKrH2ssZGbZ37DnpwJfZn44MtOduKwHn62OupeD3pGJEQnAvFZ9
        cBO6rXbC8oBB3CoDHrrNNl94tkbfVoVXN4uRJcb9rnK86fbBpO830=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E7C22162896;
        Thu,  6 Jan 2022 12:50:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5B440162895;
        Thu,  6 Jan 2022 12:50:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Pedro Martelletto <pedro@yubico.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] gpg-interface: trim CR from ssh-keygen
References: <CAPig+cS6h6o2_dJAZC1M1Ace29bN2mhPgaEtTWtj3oXfcHq9cA@mail.gmail.com>
        <xmqqee5oieb2.fsf@gitster.g>
        <CAPig+cTM3wZz4NXjxYeBuFv0CVNS-T+pBFeVkfMQ-25pL1kBzw@mail.gmail.com>
        <xmqqmtkcguvm.fsf@gitster.g>
        <CAPig+cR93GyN53JoZbaiROrNtzGjiet7eTPQOk-26G+mB0KaCA@mail.gmail.com>
        <20220104125534.wznwbkyxfcmyfqhb@fs> <xmqqo84rcn3j.fsf@gitster.g>
        <CAPig+cQinNZp_2=eo7nokMCZ9gc-tAKO1V_jejL2Ei9J63tSDQ@mail.gmail.com>
        <20220105103611.upfmcrudw6n3ymx6@fs> <xmqqsfu1hq6x.fsf@gitster.g>
        <20220106102603.cmb3rf4whd4hmfbb@fs>
Date:   Thu, 06 Jan 2022 09:50:44 -0800
In-Reply-To: <20220106102603.cmb3rf4whd4hmfbb@fs> (Fabian Stelzer's message of
        "Thu, 6 Jan 2022 11:26:03 +0100")
Message-ID: <xmqqpmp4eosr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C8C3D84-6F19-11EC-9662-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> There are a few more places where the same thing happens and text
> is just split by LF, ignoring CR. The gpg parsing where this code
> originated being the most prominent example. ...  ... Since the
> gpg stuff is in place for a long time and no one complained we can
> probably leave it as is.

Yeah, that is the conclusion I was hoping for.
Thanks.
