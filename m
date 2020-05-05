Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497E8C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 18:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1419020663
	for <git@archiver.kernel.org>; Tue,  5 May 2020 18:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MD+5URzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgEES7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 14:59:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57778 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgEES7U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 14:59:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78072653C7;
        Tue,  5 May 2020 14:59:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=v6A3NctJrgf6
        4q68GgTyBcZkBqQ=; b=MD+5URzvNOnaIKau2w3MeXZipei4NBO+VMtjcu6RL6Xn
        niZXFg0veqHBtGJIs2ozJYtHs0ysVuByheIDdwHeUiAyAJLkLAzKl89Ef3g/TBXx
        I2CGhg24JuxKRXbXIRIt0egS1GCUAerllNH1WlWGrvRrdDAkYg4PEeRhu6pk+UM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ReK5ww
        RfKvcnCweGshQaIRm/28DYqQQO3sYTdApj3GwQYtSkrxXdtgL+hix2fEPSoO6syl
        RZa9q9xukY6i8i8KyF4zqpEbCvxLBmkH+ZTU4GuHoEU+bfzTEbfzbZc/ssWcOkP3
        UAibIAsc1E6HEp4MPnbe02WJkZmO6Xg3ZM9bI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D73A653C6;
        Tue,  5 May 2020 14:59:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB3FD653C4;
        Tue,  5 May 2020 14:59:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 3/3] fixup! CI: limit GitHub Actions to designated branches
References: <cover.1588607262.git.congdanhqx@gmail.com>
        <cover.1588695295.git.congdanhqx@gmail.com>
        <a2e548b683cd584fd686a44e1d7f3473943fc73f.1588695295.git.congdanhqx@gmail.com>
Date:   Tue, 05 May 2020 11:59:17 -0700
In-Reply-To: <a2e548b683cd584fd686a44e1d7f3473943fc73f.1588695295.git.congdanhqx@gmail.com>
        (=?utf-8?B?IsSQb8OgbiBUcuG6p24gQ8O0bmc=?= Danh"'s message of "Tue, 5 May
 2020 23:26:41 +0700")
Message-ID: <xmqqzham9piy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 856939BE-8F02-11EA-80F1-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Should we want to enable GitHub Action for all repo-s, except git/git
> and gitster/git. We'll want to have this patch fix-up to the previous
> one.

Just to get everybody on the same page,

	git/git has only the primary integration branches and tags
	gitster/git has broken out individual topics

We do want to build everything in git/git repository.

I do not have Actions enabled for gitster/git repository.

I expect general contributors to fork from the former, push their
work on their own branches (not the copies of the public integration
branches like 'master', 'next', etc.) so that they can throw a pull
request at git/git.

>  jobs:
>    windows-build:
> +    if: >-
> +      ${{
> +      (github.repository_owner !=3D 'git' && github.repository_owner !=
=3D 'gitster') ||
> +      github.ref =3D=3D 'refs/heads/maint' ||
> +      github.ref =3D=3D 'refs/heads/master' ||
> +      github.ref =3D=3D 'refs/heads/next' ||
> +      github.ref =3D=3D 'refs/heads/jch' ||
> +      github.ref =3D=3D 'refs/heads/pu'
> +      }}

Ialready asked not to make this about me.  You do not want to search
and replace 'gitster' with 'peff' or 'dscho' or whatever string,
only because/when I chose to retire.  Such an occasion shouldn't be
a significant event to the project's codebase.

Thanks.


