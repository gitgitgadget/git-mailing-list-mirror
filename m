Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76502203F3
	for <e@80x24.org>; Fri, 21 Jul 2017 22:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755065AbdGUWkx (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 18:40:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57104 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755058AbdGUWkv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 18:40:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 52A6D9DB7E;
        Fri, 21 Jul 2017 18:40:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ERkgnZ5NuZWk+EAP6BjeLmywKP4=; b=RxWjr+
        UC61vRORpwl5uR0xAwNkDHyATQlccrdvcpsoOQYn8mmwSmY2MqD1Tp42kHz8j9sz
        pkZTy92Oh/pFwCrYUIxfPhRZMeJd1qPWYznA2vvqV7DOO4oKPWtPjC7s37GPME/o
        a219oivhsp37Jc1o5838cBTiHmj//IT3YLpf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c/jfk9QgNfI+28l0FdPO5TsEiNHvJnSW
        Aad5u41ZuYrFKWkh6ctwA+CY/VO2IfJBN2vLNxytVIaEHGwBdiYHVmqbBKoTswlA
        K3vtBciMfpph3BWT+E6mD0Lcu9rx6QT5VVnt/tIPwk/5WCOe3eN7gqxdtVySuMhr
        O4t8PCSUU5s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4AF439DB7D;
        Fri, 21 Jul 2017 18:40:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4A659DB7C;
        Fri, 21 Jul 2017 18:40:44 -0400 (EDT)
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
Date:   Fri, 21 Jul 2017 15:40:43 -0700
In-Reply-To: <CANYiYbGSaaFOq7iw=ON1Oo87bSA96o=zyzym5RDT32kMae7bsw@mail.gmail.com>
        (Jiang Xin's message of "Sat, 22 Jul 2017 06:17:52 +0800")
Message-ID: <xmqqvamlfm6s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A201EFA0-6E65-11E7-BF81-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Sorry, I'm late. I want to try a safer way to change PRItime to
> PRInMax using a hacked version of gettext.

Why?  A vanilla version of gettext tool that is fed a known PRIuMAX
in its input would be a safer choice, I would have thought.

I've already queued the patch you responded to on 'master', but
haven't tagged -rc1 yet, so it is possible for you to update on top
of it before -rc1 is tagged.  I do not yet understand why you think
a modified version of gettext would be a safer way to go, though.

Thanks.
