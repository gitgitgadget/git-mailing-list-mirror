Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88572C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 17:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F3F206D7
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 17:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wl4uGvwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfLRR74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:59:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64937 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfLRR7z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 12:59:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92D542639B;
        Wed, 18 Dec 2019 12:59:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8i73X78F565I
        /JvFpPxwBMhGtrc=; b=wl4uGvwkmElMUSCQELNV6D6ogIdjusmRaZ8pi/KHvy+s
        /6al7sKx6Ptj3zBnoSii/CiEg2FsqUMN1RUYhEd9W9KfIGW34H4z8LwuoE0ocXXZ
        44iZvbVZcNR88phkwCC2ph92VGs7Ymc6/OfJtay5oxuZPawGSzUtwOjqEKoubpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=UagjBs
        QkgmPnc9L48C8/FNsogQR82+/Nkn3Jfa6VdTRFlF+SpUmlQ66s7RRGYGddiIpnTJ
        0xN7xKhyW7KzqFwivZScaWr+82+qGZ0QNc4LFnhI+xxpCpYwFnzU5gkj9voYSevb
        /U6buTChnfzF9l0vwVwxFOfd5F5uVHvPI5NmU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B2F42639A;
        Wed, 18 Dec 2019 12:59:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E78A126398;
        Wed, 18 Dec 2019 12:59:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 2/2] Documentation/git-log: mention that line-log regex must match in starting revision
References: <pull.494.git.1576559263.gitgitgadget@gmail.com>
        <4ea4eeae0c1e23221012855168bf6640be93fd4f.1576559263.git.gitgitgadget@gmail.com>
        <1d033204-80fd-25f8-3a80-0cb641953139@gmail.com>
        <xmqq5zieizrb.fsf@gitster-ct.c.googlers.com>
        <147443E8-EA04-45D2-B3BC-D879A5FFECDC@gmail.com>
        <d8e753ec-2835-331f-99de-35a4a5369b48@gmail.com>
Date:   Wed, 18 Dec 2019 09:59:51 -0800
In-Reply-To: <d8e753ec-2835-331f-99de-35a4a5369b48@gmail.com> (Derrick
        Stolee's message of "Wed, 18 Dec 2019 05:55:25 -0500")
Message-ID: <xmqqwoatecq0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 311CFC9C-21C0-11EA-A28E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 12/17/2019 10:28 PM, Philippe Blain wrote:
>>=20
>>> Le 17 d=C3=A9c. 2019 =C3=A0 13:16, Junio C Hamano <gitster@pobox.com>=
 a =C3=A9crit :
>>> Even when you specify <start> or <end> as a line number, they must
>>> exist in the starting revision or it would be a fatal error.  If we
>>> are clarifying with this patch for completeness, I think we should
>>> also mention it together. =20
> ...
>>     git log -L 300,2000000085:Documentation/git-log.txt=20
>> errors out:
>>     fatal: file Documentation/git-log.txt has only 239 lines
>
> This case seems important enough to include what it means to "match".

Yup, that is why I suggested not to focus too much on regexp and
"match"-ing, but express it in terms of the lines that are specified
by given arguments to "exist".  The word "match" gives an incorrect
connotation that the description in the paragraph that uses the verb
applies only to regexp.



