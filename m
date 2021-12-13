Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4AAC433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 21:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243125AbhLMVgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 16:36:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58261 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbhLMVgn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 16:36:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7B34FCEDA;
        Mon, 13 Dec 2021 16:36:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7TDCBF/7l+E7
        sDK3ilttn8qyMT8JyyV9p2Rrc/dgrTQ=; b=TOI37MwVPS1mzJssarX+0ijIA/P/
        w4lwPB7bFCTrGq3nCYGl50HcEQzJ2TE6SAlEEDsF4mzKCWr7zmRVZz40DLhauS8f
        Mzku9W+PHwAYmWVvDs+JGH3zu7SOpRlYYAwoUOxirRjEEfCznvKPtOwuA5pIcuvs
        87282jF9G/kj2X8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF3A7FCED9;
        Mon, 13 Dec 2021 16:36:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3F49EFCED5;
        Mon, 13 Dec 2021 16:36:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] checkout: introduce "--to-branch" option
References: <pull.1095.git.1639117329.gitgitgadget@gmail.com>
        <254b352e31029d8151eb6a974fdf8c127340cf79.1639117329.git.gitgitgadget@gmail.com>
        <xmqq5yrwm7km.fsf@gitster.g>
        <CAOLTT8Rx9M9=a5M8UeDrJqMayTXo=dvdanVDLi7QLdPX8W_Tzw@mail.gmail.com>
        <xmqqy24pk6f4.fsf@gitster.g>
        <211213.86r1ag6ztx.gmgdl@evledraar.gmail.com>
Date:   Mon, 13 Dec 2021 13:36:40 -0800
In-Reply-To: <211213.86r1ag6ztx.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 13 Dec 2021 20:55:00 +0100")
Message-ID: <xmqqr1agb313.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C32B82CE-5C5C-11EC-91FF-C48D900A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I don't see how it's fundimentally different than the DWIM logic of
> taking "<name>" and seeing that there's only one "refs/heads/<name>",
> and giving up in other cases where we get ambiguous reference names tha=
t
> we can't resolve.

In that example, once you obtained a local branch whose name is
<name>, it is obvious how you would work with that.  Your next "git
checkout <name>" would work on the local one, and only the initial
one does something magical.

Which makes quite a lot of sense.

There is no similarity in it with "--to-branch <tag>" that is being
discussed here.



