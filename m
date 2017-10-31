Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 354E320281
	for <e@80x24.org>; Tue, 31 Oct 2017 05:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbdJaFYR (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 01:24:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63151 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753155AbdJaFYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 01:24:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E0A8AB0B0;
        Tue, 31 Oct 2017 01:24:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=+Kpag588SCgCz0Kcvz1YxoVuK
        mI=; b=XJ3e9B9dH9WudtQl2AZZN0mzAcWMs66bo3KAByjAVNnYxRUx195ZWCRbg
        jK3UOIJeeg8WfoPlRrfMwVoUcKInqb//wfe2gF5x8BQ5of2SRC/p6n6NzZo43BsA
        CH8r0/cQK7/VvqskKqbYz/9G9ayaoQwJyMVxoAIWT/mC/aES5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=qaI+uYzHdnSF7TrUlCU
        qUAuVsT+ygC+MArTqg6VajWh02VwKB4Q/9V2rmqjIdaTSN+pOSbQvSnf+lHxZF8Z
        BgKGUvLS2x2qelwLFxBn2avr+UYn1COzDcO2hOGnSWjrr6TNJmAdJ0XmaW9nW3ie
        z/2zXV6tkVJSUrsdmPyxapAk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06914AB0AF;
        Tue, 31 Oct 2017 01:24:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 787C4AB0AE;
        Tue, 31 Oct 2017 01:24:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] diff: --indent-heuristic is no longer experimental
References: <20171029151228.607834-1-cmn@dwim.me>
Date:   Tue, 31 Oct 2017 14:24:14 +0900
Message-ID: <xmqq375z28ld.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BC80D2F2-BDFB-11E7-93AC-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlos Mart=C3=ADn Nieto <cmn@dwim.me> writes:

> This heuristic has been the default since 2.14 so we should not confuse=
 our
> users by saying that it's experimental and off by default.
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
> ---

Good eyes.  Nobody raised noises since this happened at 2.14 until
now, so this could wait until the next cycle, though ;-)

>  Documentation/diff-heuristic-options.txt | 5 -----
>  Documentation/diff-options.txt           | 7 ++++++-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>  delete mode 100644 Documentation/diff-heuristic-options.txt
>
> diff --git a/Documentation/diff-heuristic-options.txt b/Documentation/d=
iff-heuristic-options.txt
> deleted file mode 100644
> index d4f3d95505..0000000000
> --- a/Documentation/diff-heuristic-options.txt
> +++ /dev/null
> @@ -1,5 +0,0 @@
> ---indent-heuristic::
> ---no-indent-heuristic::
> -	These are to help debugging and tuning experimental heuristics
> -	(which are off by default) that shift diff hunk boundaries to
> -	make patches easier to read.
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
> index a88c76741e..dd0dba5b1d 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -63,7 +63,12 @@ ifndef::git-format-patch[]
>  	Synonym for `-p --raw`.
>  endif::git-format-patch[]
> =20
> -include::diff-heuristic-options.txt[]
> +--indent-heuristic::
> +	Enable the heuristic that shift diff hunk boundaries to make patches
> +	easier to read. This is the default.
> +
> +--no-indent-heuristic::
> +	Disable the indent heuristic.
> =20
>  --minimal::
>  	Spend extra time to make sure the smallest possible
