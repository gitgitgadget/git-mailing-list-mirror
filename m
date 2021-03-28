Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F37C433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 06:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B71661971
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 06:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhC1GmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 02:42:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62720 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhC1GmI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 02:42:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81DA4B9891;
        Sun, 28 Mar 2021 02:42:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2g2Yj+dsU7TS
        RV6CV2O2bM66TUw=; b=QkSqonAE2vVbGpUBVIOQuAB8xrtz/ORsLS/XPmVpDRku
        x5K+Oe9XihXz18TVOEhtwcT6gkDQgLSa9vU48CvHexcB3Czvu8w5Uj6W+PdSS2yv
        bJbjv2TCLfudE22L0o4RI2XlJQEPuOz7aebTM1va7+k/oxJdSHXcqhftVnRawLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=k2leWu
        yGJgq1xlabx+QmVYt95ZdyLpxDJTv6ymqUaFhEMnU1Da0aBqC4sh/NdvMAF95rBG
        83RPVfXUgTC8rAqTFwUNYf6krLSa0/IsQ2K2yYV5SJFo6rcS+dKW8lnnHAsSzeZC
        CvM1NdiH3xxPWBzv0Duu3UPULz3Ajjh9pELe8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A959B9890;
        Sun, 28 Mar 2021 02:42:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB098B988F;
        Sun, 28 Mar 2021 02:42:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] doc lint: lint and fix missing "GIT" end sections
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
        <patch-5.6-d4004b6a7cb-20210326T103454Z-avarab@gmail.com>
Date:   Sat, 27 Mar 2021 23:42:06 -0700
In-Reply-To: <patch-5.6-d4004b6a7cb-20210326T103454Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 26 Mar
 2021 11:36:50 +0100")
Message-ID: <xmqqr1jzn5j5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B6B77258-8F90-11EB-98D4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Lint for and fix the three manual pages that were missing the standard
> "Part of the linkgit:git[1] suite" end section.
>
> We only do this for the man[157] section documents (we don't have
> anything outside those sections), not files to be included,
> howto *.txt files etc.

OK.  Alternatively we could drop the footer from all pages.  IIRC,
we used to have another footer section to credit primary authors,
which we dropped years ago.  I doubt "git-foo is part of git suite"
is something worth repeating over and over.

Thanks.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/Makefile           |  2 ++
>  Documentation/git-credential.txt |  4 ++++
>  Documentation/git-p4.txt         |  4 ++++
>  Documentation/gitnamespaces.txt  |  4 ++++
>  Documentation/lint-man-txt.perl  | 24 ++++++++++++++++++++++++
>  5 files changed, 38 insertions(+)
>  create mode 100755 Documentation/lint-man-txt.perl
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 6bfd8c75772..2b6cd0f7be2 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -490,6 +490,8 @@ lint-docs::
>  		--section=3D5 $(MAN5_TXT) \
>  		--section=3D7 $(MAN7_TXT)	\
>  		--to-lint $(ALL_TXT)
> +	$(QUIET_LINT)$(PERL_PATH) lint-man-txt.perl \
> +		$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
> =20
>  ifeq ($(wildcard po/Makefile),po/Makefile)
>  doc-l10n install-l10n::
> diff --git a/Documentation/git-credential.txt b/Documentation/git-crede=
ntial.txt
> index 31c81c4c026..206e3c5f407 100644
> --- a/Documentation/git-credential.txt
> +++ b/Documentation/git-credential.txt
> @@ -159,3 +159,7 @@ empty string.
>  +
>  Components which are missing from the URL (e.g., there is no
>  username in the example above) will be left unset.
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index f89e68b424c..38e5257b2a4 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -762,3 +762,7 @@ IMPLEMENTATION DETAILS
>    message indicating the p4 depot location and change number.  This
>    line is used by later 'git p4 sync' operations to know which p4
>    changes are new.
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Documentation/gitnamespaces.txt b/Documentation/gitnamespa=
ces.txt
> index b614969ad2c..1c8d2ecc358 100644
> --- a/Documentation/gitnamespaces.txt
> +++ b/Documentation/gitnamespaces.txt
> @@ -62,3 +62,7 @@ git clone ext::'git --namespace=3Dfoo %s /tmp/prefixe=
d.git'
>  ----------
> =20
>  include::transfer-data-leaks.txt[]
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite
> diff --git a/Documentation/lint-man-txt.perl b/Documentation/lint-man-t=
xt.perl
> new file mode 100755
> index 00000000000..d69312e5db5
> --- /dev/null
> +++ b/Documentation/lint-man-txt.perl
> @@ -0,0 +1,24 @@
> +#!/usr/bin/perl
> +
> +use strict;
> +use warnings;
> +
> +my $exit_code =3D 0;
> +sub report {
> +	my ($target, $msg) =3D @_;
> +	print "error: $target: $msg\n";
> +	$exit_code =3D 1;
> +}
> +
> +local $/;
> +while (my $slurp =3D <>) {
> +	report($ARGV, "has no 'Part of the linkgit:git[1] suite' end blurb")
> +		unless $slurp =3D~ m[
> +		^GIT\n
> +		 ---\n
> +		\QPart of the linkgit:git[1] suite\E \n
> +		\z
> +	]mx;
> +}
> +
> +exit $exit_code;
