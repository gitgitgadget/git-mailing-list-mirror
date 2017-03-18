Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75382095B
	for <e@80x24.org>; Sat, 18 Mar 2017 18:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbdCRSAa (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 14:00:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65478 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751754AbdCRSA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 14:00:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33A21875F6;
        Sat, 18 Mar 2017 14:00:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vIuE7roV4kbW
        b5eSB+X5JEK4gp4=; b=IMt25gXGvbkgIeexPneOD39MM0SjwTHGYSRU/lguBLeS
        AT9bKO3K+Xx1zCthYjzr87JYMpLvHr+YVcxE7y1QE4HvxPBZX6+I7E42V3CextpQ
        b06CD7g3qgY+CjjaeqCyxNiUG3kSYKp2wzQlSvkLRrnYbgh/FGk0Z8eO3xJct3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=orGTAQ
        bzi5iULxV7UV+g8WuXra9ImYzEmpzg8TkkCt0qvkNM8TwHA5QYxJ4LX8igOHtxeH
        CR6+VOQDWuol+RDO5lJlVkcBKAGLWWTOoskkO0Dt4coGTycAuT5LbQ3VbkikiI22
        D7lfJOA/IxFg6sYgisuivIygzbiBVpg1gWjBQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B7EC875F5;
        Sat, 18 Mar 2017 14:00:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8AE25875F4;
        Sat, 18 Mar 2017 14:00:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 12/12] rev-list: expose and document --single-worktree
References: <20170217141908.18012-1-pclouds@gmail.com>
        <20170318101153.6901-1-pclouds@gmail.com>
        <20170318101153.6901-13-pclouds@gmail.com>
Date:   Sat, 18 Mar 2017 11:00:25 -0700
In-Reply-To: <20170318101153.6901-13-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 18 Mar 2017 17:11:53 +0700")
Message-ID: <xmqq4lyq4g92.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C40A2FAE-0C04-11E7-B751-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> ---

Missing sign-off.

>  Documentation/rev-list-options.txt | 8 ++++++++
>  revision.c                         | 2 ++
>  2 files changed, 10 insertions(+)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
> index a02f7324c0..c71e94b2d0 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -179,6 +179,14 @@ explicitly.
>  	Pretend as if all objects mentioned by reflogs are listed on the
>  	command line as `<commit>`.
> =20
> +--single-worktree::
> +	By default, all working trees will be examined by the

s/working tree/worktree/?

> +	following options when there are more than one (see
> +	linkgit:git-worktree[1]): `--all`, `--reflog` and
> +	`--indexed-objects`.
> +	This option forces them to examine the current working tree
> +	only.
> +
>  --ignore-missing::
>  	Upon seeing an invalid object name in the input, pretend as if
>  	the bad input was not given.
> diff --git a/revision.c b/revision.c
> index fcf165bd76..dc32e99c54 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2222,6 +2222,8 @@ static int handle_revision_pseudo_opt(const char =
*submodule,
>  			return error("invalid argument to --no-walk");
>  	} else if (!strcmp(arg, "--do-walk")) {
>  		revs->no_walk =3D 0;
> +	} else if (!strcmp(arg, "--single-worktree")) {
> +		revs->single_worktree =3D 1;
>  	} else {
>  		return 0;
>  	}
