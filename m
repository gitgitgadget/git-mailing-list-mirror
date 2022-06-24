Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083DBC43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 15:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiFXP2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 11:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiFXP2N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 11:28:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC0D19012
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 08:28:11 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 165E71AF599;
        Fri, 24 Jun 2022 11:28:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lD8kjkMEoa7Q
        HnkwcIv8d9vEete5jdbVXRbIradXCos=; b=ORpUET+Iq68jL8NslGsUCs6RSZG2
        eYE5Uvz46/+vJRKv8h0vB5rHdPzgQwruMrQPF7j6xJ5tXZ270UTedVwtz0xJzEZk
        +u5vPa91a7K3ax6epjTPy9WKiFkB2ixJC1ijjqYg1s/3TB1T4Sd13ri2Tbj2FmbX
        u69VB8sFIzVpBSo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F0C61AF598;
        Fri, 24 Jun 2022 11:28:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AE0661AF596;
        Fri, 24 Jun 2022 11:28:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v3] ls-files: introduce "--format" option
References: <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
        <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
        <080f65b3-91f5-7b68-4235-4bfb956c8321@gmail.com>
        <xmqqv8sr1iex.fsf@gitster.g>
        <220624.86pmiyi498.gmgdl@evledraar.gmail.com>
Date:   Fri, 24 Jun 2022 08:28:05 -0700
In-Reply-To: <220624.86pmiyi498.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 24 Jun 2022 15:20:31 +0200")
Message-ID: <xmqqy1xmw06y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3F987A1C-F3D2-11EC-8D52-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> We also say that we will "show the full path names" in that
> documentation.

The primary issue is not the presence of "name" there, but the lack
of "path" in the word chosen.

Many things can have "name" (including "object name"), and "path",
not "name", in "path name" is what clarifies what kind of name it
is.  Given that --format placeholders include "objectname", it does
not make a good design to use "name" alone without saying what kind
of "name" it is.

Calling it "pathname", not just "path", is perfectly OK.  But if
there is no other things the word "path" could refer to in this
context, which I think is the case here, "path" would be acceptable.
