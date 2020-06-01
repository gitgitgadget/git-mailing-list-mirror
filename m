Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72D0C433E0
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 15:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE812074B
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 15:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nbU9loU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgFAPp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:45:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52438 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAPp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 11:45:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A6E564FE7;
        Mon,  1 Jun 2020 11:45:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=B9SsusoaVaMl
        lPRpFXg94fuALLk=; b=nbU9loU8iz1zXIMT5NyxytDQqFZPCrR41Ct00G/JsX2f
        PBqvGo7Atu1rw1F2ybMqKWcrQ6Ua0ptdxl3dL9Zqh/nT10luP1XBpnbC4q8t3mWJ
        Z7Ep7kIKBet4to5Z/DyBuP53kSf/kwSxhO7efMGfPKrXVXSg1fSH+pudybgbeLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QHqNPo
        41Eaj97/zgxd4O8N+qB6Z8P3czLTW8yXdLVAYcs+r1NmWFfWpIYzkMSggd/eJfiz
        OWjTHrQHXYG6O0MpgqrSZ1+bNjF0Yb61gDD8jeE6/taW1OqBbZ7pFjojIpT2BQZm
        agygJuFfzI8G9pkWQVgjl1Nnj+qkdR/VH7YXw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73F3A64FE6;
        Mon,  1 Jun 2020 11:45:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C92E364FE5;
        Mon,  1 Jun 2020 11:45:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Christopher Diaz Riveros <christopher.diaz.riv@gmail.com>,
        Emir =?utf-8?Q?Sar=C4=B1?= <bitigchi@me.com>,
        Jan Engelhardt <jengelh@inai.de>,
        =?utf-8?Q?Jean-No?= =?utf-8?Q?=C3=ABl?= Avila 
        <jn.avila@free.fr>, Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Tran Ngoc Quan <vnwildman@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.27.0 round 2
References: <20200531051726.9793-1-worldhello.net@gmail.com>
        <xmqqy2p8ug1c.fsf@gitster.c.googlers.com>
        <CANYiYbH0DzFriPU3AUBfyvADc7OD8r_qjFVp0C2pSVfWk0Zw6Q@mail.gmail.com>
Date:   Mon, 01 Jun 2020 08:45:51 -0700
In-Reply-To: <CANYiYbH0DzFriPU3AUBfyvADc7OD8r_qjFVp0C2pSVfWk0Zw6Q@mail.gmail.com>
        (Jiang Xin's message of "Mon, 1 Jun 2020 15:35:22 +0800")
Message-ID: <xmqqpnaivlg0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F9675CCA-A41E-11EA-AC39-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2020=E5=B9=B46=E6=9C=881=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=882:15=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Jiang Xin <worldhello.net@gmail.com> writes:
>>
>> > Hi Junio,
>> >
>> > Please pull the following l10n updates for Git 2.27.0.
>> >
>> > The following changes since commit 2d5e9f31ac46017895ce6a183467037d2=
9ceb9d3:
>> >
>> >   Git 2.27-rc2 (2020-05-26 09:38:13 -0700)
>> >
>> > are available in the Git repository at:
>> >
>> >   git@github.com:git-l10n/git-po.git tags/l10n-2.27.0-rnd2
>> >
>> > for you to fetch changes up to cb26198ec6b3fa0bc58d210ea0338f4e972f9=
f50:
>> >
>> >   Merge branch 'master' of github.com:ruester/git-po-de (2020-05-30 =
11:26:53 +0800)
>>
>> Thanks.  Swapped GPG key recently?
>
> My pgp key has expired on April 6th, so I generated a new one.  Which
> is the best practice? Edit the old pgp key to extend the expiry time
> or generate a new pgp key?

Either is OK; it's not as if we've met in person and exchanged our
keys (I tend to extend the expiration date, as that key would be
still recognisable by those who have been trusting that key; you can
do the similar chaining of trust by signing the new key with the old
key before starting to use the new one, I suppose).

Thanks.
