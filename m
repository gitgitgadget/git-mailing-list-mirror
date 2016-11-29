Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C65231FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 19:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753367AbcK2TPo (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 14:15:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60312 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754265AbcK2TPi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 14:15:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 154454E249;
        Tue, 29 Nov 2016 14:15:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1iH4aRS50Juj
        nZOAP6qSVlYZRPE=; b=i3NgoC2NylTMdh1KYhQ3Ll3h+/bLjlMoVYf+qwuZRpUb
        9Uur4DBcQf0bAi43wHCrkeb08TjkPCT2mCC9pu2wunpMowp/yme+0mBvUF8+PbBQ
        DRKg6yVFxWqjfm9jwco6gaSgAX3lsLh7IGe8Ascx/lgT222+rkM8Xfrz95wTkuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kNyoYU
        6Ew/jtpdQDRES35XBCHhLEIvJyRmicXwfWhG23gkIz4Oe8ZmkrNjp16ILxsHE9cw
        qR6iftCQqVwW3B0Nz1mMg4nSwFgipJDuyiLowxlkEcHcABmnB0JMFnR15n2RBOEL
        04R0nkwZUnnCPgadvOhWrmmTVFUaz/J+xFsFM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF26D4E248;
        Tue, 29 Nov 2016 14:15:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64A094E247;
        Tue, 29 Nov 2016 14:15:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC v1 1/1] New way to normalize the line endings
References: <5502e894-bb22-e8b9-ab7a-49346d238283@web.de>
        <20161127162245.11757-1-tboegi@web.de>
Date:   Tue, 29 Nov 2016 11:15:35 -0800
In-Reply-To: <20161127162245.11757-1-tboegi@web.de> (tboegi@web.de's message
        of "Sun, 27 Nov 2016 17:22:45 +0100")
Message-ID: <xmqqshqaf67c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 350D1B78-B668-11E6-9C57-E98412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Sincec commit 6523728499e7 'convert: unify the "auto" handling of CRLF'
> the normalization instruction in Documentation/gitattributes.txt
> doesn't work any more.

Aside from s/Sincec/Since/, the above made it sound as if the named
commit was a regression that wants to be reverted, at least to my
first reading.  I think you want to be a bit more clear that we
updated the world order and made it a better place with that commit,
and examples in the doc need to be updated.  To convince readers
that, I think you would need to explain things like why the old way
illustrated in the example was bad, and why the new way is better.

> Update the documentation and add a test case.
>
> Reported by Kristian Adrup
> https://github.com/git-for-windows/git/issues/954
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  Documentation/gitattributes.txt |  7 +++----
>  t/t0025-crlf-auto.sh            | 29 +++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
> index 976243a..1f7529a 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -227,11 +227,10 @@ From a clean working directory:
> =20
>  -------------------------------------------------
>  $ echo "* text=3Dauto" >.gitattributes
> -$ rm .git/index     # Remove the index to force Git to
> -$ git reset         # re-scan the working directory
> +$ git ls-files --eol | egrep "i/(crlf|mixed)" # find not normalized fi=
les

Does this step help anything?  I do not see anything in the later
steps that the user uses the finding from the output of this step to
affect the end result.

> +$ rm .git/index     # Remove the index to re-scan the working director=
y
> +$ git add .

"A clean working directory" usually means all paths in the index
match what's in the working tree but this requires a bit more than
that, as this step ends up adding untracked and unignored paths.

>  $ git status        # Show files that will be normalized
> -$ git add -u
> -$ git add .gitattributes
>  $ git commit -m "Introduce end-of-line normalization"
>  -------------------------------------------------
> =20
> diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
> index d0bee08..4ad4d02 100755
> --- a/t/t0025-crlf-auto.sh
> +++ b/t/t0025-crlf-auto.sh
> @@ -152,4 +152,33 @@ test_expect_success 'eol=3Dcrlf _does_ normalize b=
inary files' '
>  	test -z "$LFwithNULdiff"
>  '
> =20
> +test_expect_success 'prepare unnormalized' '
> +
> +	> .gitattributes &&

Lose SP before ".gitattributes".

> +	git config core.autocrlf false &&
> +	printf "LINEONE\nLINETWO\r\n"     >mixed &&
> +	git add mixed .gitattributes &&
> +	git commit -m "Add mixed" &&
> +	git ls-files --eol | egrep "i/crlf" &&
> +	git ls-files --eol | egrep "i/mixed"
> +
> +'

Any particular reason why we must use egrep not grep here?

> +
> +test_expect_success 'normalize unnormalized' '
> +	echo "* text=3Dauto" >.gitattributes &&
> +	rm .git/index &&
> +	git add . &&
> +	git commit -m "Introduce end-of-line normalization" &&
> +	git ls-files --eol | tr "\\t" " " | sort >act &&
> +cat >exp <<EOF &&
> +i/-text w/-text attr/text=3Dauto         LFwithNUL
> +i/lf    w/crlf  attr/text=3Dauto         CRLFonly
> +i/lf    w/crlf  attr/text=3Dauto         LFonly
> +i/lf    w/lf    attr/text=3Dauto         .gitattributes
> +i/lf    w/mixed attr/text=3Dauto         mixed
> +EOF

Use <<-EOF to indent the above 7 lines?

> +	test_cmp exp act
> +
> +'
> +
>  test_done
