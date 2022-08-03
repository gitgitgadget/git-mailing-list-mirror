Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8446C19F28
	for <git@archiver.kernel.org>; Wed,  3 Aug 2022 15:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbiHCPsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Aug 2022 11:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238122AbiHCPsT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Aug 2022 11:48:19 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C360DF57
        for <git@vger.kernel.org>; Wed,  3 Aug 2022 08:48:17 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C1EE1B61EE;
        Wed,  3 Aug 2022 11:48:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bSiyjqdBvtOA
        tz2DbSqtOUaA02SyA4FzAigLxLJh8o0=; b=cLtBbkLozCjLRJV+lHch/dGvuMOQ
        OL9C8R1K3F1jjWzFoVzUmDlvk6gzXEOJAy9FrXW/swrftGKBh4BsVg0eA8TPTEoA
        kXigWBZFG0CbKuEl9TUyfOYjFj40L6MQlGjO5OVMu2ojH1vcDf6UPnVx5A3aEz/t
        jFi4kFivAuNYi48=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 841901B61ED;
        Wed,  3 Aug 2022 11:48:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 370111B61EC;
        Wed,  3 Aug 2022 11:48:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v7 06/10] docs: move commit-graph format docs to man
 section 5
References: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
        <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
        <patch-v7-06.10-5adabbb3a26-20220802T125258Z-avarab@gmail.com>
Date:   Wed, 03 Aug 2022 08:48:11 -0700
In-Reply-To: <patch-v7-06.10-5adabbb3a26-20220802T125258Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 2 Aug
 2022 14:56:55
        +0200")
Message-ID: <xmqqfsidcoqs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AEA90E22-1343-11ED-8082-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Continue the move of existing Documentation/technical/* protocol and
> file-format documentation into our main documentation space.
>
> By moving the documentation for the commit-graph format into man
> section 5 and the new "developerinterfaces" category. This change is
> split from subsequent commits due to the relatively large amount of
> ASCIIDOC formatting changes that are required.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/Makefile                        |  1 +
>  Documentation/git-commit-graph.txt            |  5 ++
>  ...-format.txt =3D> gitformat-commit-graph.txt} | 47 +++++++++++++----=
--
>  Documentation/technical/chunk-format.txt      |  4 +-
>  command-list.txt                              |  2 +
>  5 files changed, 42 insertions(+), 17 deletions(-)

OK.  Rename of a single document with a bit of mark-up updates, plus
adjusting the links that refer to the original location to its new
location.  Nothing unexpected, other than a single curious bit.

> diff --git a/command-list.txt b/command-list.txt
> index 1950c4ccd9c..44e244a76f6 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -210,6 +210,8 @@ gitdiffcore                             guide
>  giteveryday                             guide
>  gitfaq                                  guide
>  gitformat-bundle                        developerinterfaces
> +gitformat-bundle                        developerinterfaces
> +gitformat-commit-graph                  developerinterfaces
>  gitglossary                             guide
>  githooks                                userinterfaces
>  gitignore                               userinterfaces

I do not think we want or need duplicate entries for "bundle",
and it has nothing to do with the "commit-graph" doc.



