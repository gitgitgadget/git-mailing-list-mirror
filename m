Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646CDC19F2C
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 16:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbiHCQcs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 12:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238387AbiHCQcX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 12:32:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA12F54658
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 09:31:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F09581A8BBD;
        Wed,  3 Aug 2022 12:31:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=F7Xd601occb4
        ALJOo39imCfl7fXBHD6co+qP/tnJ96M=; b=j5hZ0XIvFe+xVT2v7997jko4iFg9
        qYBdW1hjoK3wmSeTAnq+YY3GEpkddQId5Gv/YC9qu5Lc55hBNqRFresJ/nRN+lpb
        0UM6z6FPJoXwt3bNNUo54HCINALg0+lE5TVba7zN5m/j/GcR1D8ocN7WC0aG/IJz
        BdvLigr67JVvYa4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D4EFA1A8BBC;
        Wed,  3 Aug 2022 12:31:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6F7EC1A8BBB;
        Wed,  3 Aug 2022 12:31:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v7 09/10] docs: move http-protocol docs to man section 5
References: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
        <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
        <patch-v7-09.10-c4a7fe9d439-20220802T125258Z-avarab@gmail.com>
Date:   Wed, 03 Aug 2022 09:31:26 -0700
In-Reply-To: <patch-v7-09.10-c4a7fe9d439-20220802T125258Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 2 Aug
 2022 14:56:58
        +0200")
Message-ID: <xmqqr11xb869.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B8F19902-1349-11ED-98EC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Continue the move of existing Documentation/technical/* protocol and
> file-format documentation into our main documentation space by moving
> the http-protocol.txt documentation over. I'm renaming it to
> "protocol-http" to be consistent with other things in the new
> gitformat-protocol-* namespace.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/Makefile                        |  2 +-
>  Documentation/git-upload-pack.txt             |  6 ++--
>  ...http-protocol.txt =3D> gitprotocol-http.txt} | 29 ++++++++++++++++-=
--
>  Documentation/gitprotocol-pack.txt            |  2 +-
>  Documentation/gitprotocol-v2.txt              |  4 +--
>  command-list.txt                              |  1 +
>  6 files changed, 33 insertions(+), 11 deletions(-)
>  rename Documentation/{technical/http-protocol.txt =3D> gitprotocol-htt=
p.txt} (98%)

OK.
