Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3826520248
	for <e@80x24.org>; Thu, 21 Mar 2019 17:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfCURSp (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 13:18:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53890 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbfCURSo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 13:18:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF6A14C4F1;
        Thu, 21 Mar 2019 13:18:42 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=QSkN+V6UJZZQN
        cwxprpWgFqXfJA=; b=jRNA0c97BnJ5ufKq9PREbE2rJylAwCY66gT7jnz3R9lr4
        SeGAIJapZrIhjBbrJ5TkA1jgRM747VPZGITrYa93Dni8VPNXCrUJYBw+oC4wIvS8
        nqQQPnTd4OTNhICLK9sUOqy3tl2+NL4JH3iwPN/Q5rpwkUlvGVtuf3hIAHRIeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=vgBRBXb
        nxwZPLhEnfaASIDkahmjyxM75Iup4bABhdyyy3pcscgASdt+9S4dS0KB0LE9pLtl
        urn5KDxxQ9XTViv4rrR544tDNLZzJUtDsxsJgN1SGWM/mHYRvkU4x74Q+ZFOOmmA
        /e7bg8go2WgEUq260lMXuBgMCssZbgCK3VwU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B7BB94C4F0;
        Thu, 21 Mar 2019 13:18:42 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5ADA64C4E9;
        Thu, 21 Mar 2019 13:18:39 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Thu, 21 Mar 2019 13:18:36 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/4] completion.commands: fix multiple command removals
Message-ID: <20190321171836.GC4047@pobox.com>
References: <CACsJy8DiQwmAKMruOAO4roPbiRTvt5TESBTd682hTwkZjcoj2Q@mail.gmail.com>
 <20190320180329.22280-1-tmz@pobox.com>
 <xmqq8sx9szlx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <xmqq8sx9szlx.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 5EA514E0-4BFD-11E9-9580-D01F9763A999-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
>=20
>> Other than a follow-up to update the commit reference in 4/4
>> after 1/4 is in the final form on pu, I think this might be good.
>> If it's easier, we can skip 4/4 and I'll resend it after the
>> others are on pu.
>=20
> A series that makes a single topic should expect to be read by a
> reader who understand the context of individual pieces in the topic,
> so it is more common to refer to an earlier step of a series from a
> later step without the object name.  I would have written the log
> message like so instead:
>=20
>     completion: use __git when calling --list-cmds
>=20
>     As we made --list-cmds read the local configuration file in an
>     earlier step, the completion.commands variable respects repo-level
>     configuration.  Use __git which ensures that the proper repo config
>     is consulted if the command line contains 'git -C /some/other/repo'=
.
>=20
> The whole series looks good to me.  Thanks for working on it.

Thank you for amending the commit message, and to Jeff, Duy,
Eric, and G=E1bor for all the help.

--=20
Todd
