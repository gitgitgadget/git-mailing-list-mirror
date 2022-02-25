Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3963C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 23:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239375AbiBYXbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 18:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiBYXbB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 18:31:01 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E360519E73E
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 15:30:27 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FBAA18DE38;
        Fri, 25 Feb 2022 18:30:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/Ee9gAWCJd5k
        mmxvXMdUt+5FUdLEQGzwNnerfta5Jlw=; b=Ge0cTMiQZMzKasxnrrymp0cTCWUr
        rETAKtzsvCPCMUTYAXwH6PDuWCtB515M2VP7QKBdNH+4WE5G56hiwLyJChfIYNU2
        DnWk4gDjEqHqcPA+ypJz7UxBr3vpQH0I7tv+tJ0EWsdGN9mqD+vlhl7oeb3J+bOe
        aKZ8ruH83d2Uw6w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4841D18DE37;
        Fri, 25 Feb 2022 18:30:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B5A8C18DE36;
        Fri, 25 Feb 2022 18:30:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 8/9] Makefile: use $(wspfx) for $(QUIET...) in
 shared.mak
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
        <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
        <patch-v3-8.9-510306d2219-20220225T090127Z-avarab@gmail.com>
Date:   Fri, 25 Feb 2022 15:30:23 -0800
In-Reply-To: <patch-v3-8.9-510306d2219-20220225T090127Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 25 Feb
 2022 10:04:34
        +0100")
Message-ID: <xmqq35k68qy8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E841294A-9692-11EC-B6F5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the mostly move-only change in the preceding commit to use the
> $(wspfx) variable for defining the QUIET padding, to guarantee that
> it's consistent with the "TRACK_template" template.
>
>     $ make CFLAGS=3D-I$RANDOM grep.o wspfx=3D'$(space)->'
>      -> GIT-CFLAGS PARAMETERS (changed)
>      -> CC grep.o

What is a TRACK_template?  Is this some "rebase -i" gone bad?
