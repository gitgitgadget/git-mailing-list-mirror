Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9A0B203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 19:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756247AbdGXTLQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 15:11:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54961 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756182AbdGXTJP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 15:09:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0CB09920BE;
        Mon, 24 Jul 2017 15:09:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/3FkvxQud2wbchbQFZng9Tee0VQ=; b=TauQBd
        ta5xvnV1H4aT5SMBLHIASZqFZEKkNiOzC+X+CmqSL/OdtlUJEipJ/Y29tZnePuxh
        dZfbMOdNWMgUxTxq2YueFg7g9ESXkwVCy0K6qj6O1S+5nxrmAESzMcKWN1g5s6c1
        J9XkVFR6G5TZhXhtPAWWq6uSyRPWD5tRIIeJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PWkcCk4pkZUdUV4RsikrOqVkSvaC7zg7
        zCUazvhdPgrGLvWNV8jGnO4lg6c56Aax6zSAud6JzCevdL+N17cC2pEyhseBHZNT
        aYOvRWWxyxYcF33O8Z41ev3kXPSjojI+XwJpJGT7dtTpuNlITgKBiAQRsrKsBhH1
        d14PeUAGrsM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03FDF920BD;
        Mon, 24 Jul 2017 15:09:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4DF6A920B9;
        Mon, 24 Jul 2017 15:09:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
        <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
        <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com>
        <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
        <xmqq60epfy27.fsf@gitster.mtv.corp.google.com>
        <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
        <alpine.DEB.2.21.1.1707191456010.4193@virtualbox>
        <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com>
        <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com>
        <CANYiYbGSaaFOq7iw=ON1Oo87bSA96o=zyzym5RDT32kMae7bsw@mail.gmail.com>
        <xmqqvamlfm6s.fsf@gitster.mtv.corp.google.com>
        <CANYiYbF+XDANNbpZJ-jL7y81QhggW_snBuWeONSCUc4CPn2zMw@mail.gmail.com>
        <xmqqr2x9fjpi.fsf@gitster.mtv.corp.google.com>
        <CANYiYbGkuGNNYn4OF5w=1+Pqn9hEHWcD+DYVB6AXRs0vFEsY2Q@mail.gmail.com>
        <alpine.DEB.2.21.1.1707221323420.4271@virtualbox>
        <CANYiYbHMMJ1tubajHNZVsQ=ihmogtF4=FqrRWvPJg4+wuBapbg@mail.gmail.com>
Date:   Mon, 24 Jul 2017 12:09:10 -0700
In-Reply-To: <CANYiYbHMMJ1tubajHNZVsQ=ihmogtF4=FqrRWvPJg4+wuBapbg@mail.gmail.com>
        (Jiang Xin's message of "Mon, 24 Jul 2017 09:38:17 +0800")
Message-ID: <xmqqd18pejop.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9403AAE8-70A3-11E7-8A67-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

>> So let's go with Junio's patch.
>
> I agree.  We just go with the sed-then-cleanup version until we meet
> ambiguities (I mean some words other than PRItime need to be
> replaced).

OK, thanks for all involved to get us to a conclusion.  Jiang, I saw
you already made an announcement for the second round.  Thank you
very much for doing so without waiting me---I was stuck on something
else and my morning was blown X-<.  I'll still try to tag -rc1 by
the end of business today.

