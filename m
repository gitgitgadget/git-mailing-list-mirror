Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30E04211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 02:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbeLDC0Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 21:26:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64974 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLDC0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 21:26:24 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CDBBD10D7D9;
        Mon,  3 Dec 2018 21:26:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qeTUnbss0ZXM
        tlrF3A9klhxQpU8=; b=Kcx1k7avY+AAt041b74PdI4aatAONYyCvKZnP+5AefkT
        QJYK5L9Q8HaPwBa4s38pBPYcLzSBfhFj1MylTHY6Ta4wVyJBLEC+bH0TSd+o+GuJ
        D2aH5fDbnAZ3zHw8IalSzp2BHtlL8s1uVxvKFqiscrlS03F22QMGVmCUDtaTvgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Sj/e/q
        as64xNlTW1SHBnEMNXdJBcX5N3Q3ifE8Qrn7eoQ7mBEM74TK9uLJnnDrWPeRufpu
        iaQ9JZe63neQDYKk5M51nfjeuhI9MLaFkFFzDusnYJ8bSsLfQWEcjSyC4jSOk8ym
        tDUGapbzKQiK6+et8fyJ2+JpmYKcfX9b1R104=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4C6210D7D8;
        Mon,  3 Dec 2018 21:26:22 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 358B110D7D7;
        Mon,  3 Dec 2018 21:26:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] RelNotes 2.20: drop spurious double quote
References: <xmqq36rhjnts.fsf@gitster-ct.c.googlers.com>
        <cover.1543868120.git.martin.agren@gmail.com>
        <78f3043b6589f7e3b1872d940ae2ee1315553373.1543868120.git.martin.agren@gmail.com>
Date:   Tue, 04 Dec 2018 11:26:21 +0900
In-Reply-To: <78f3043b6589f7e3b1872d940ae2ee1315553373.1543868120.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 3 Dec 2018 21:21:51
 +0100")
Message-ID: <xmqqtvjuf2nm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FD8E31E0-F76B-11E8-8858-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> We have three double-quote characters, which is one too many or too few=
.
> Dropping the last one seems to match the original intention best.

Thanks for spotting.  The actual original intention was that the
user says two things:

	first saying "add only what does not match '*' out of all
	branches" and then saying "add all branches, without any
	exclusion this time".

But letting the user first say one thing and then doing another
thing without saying it is also fine, which is what your version is.



>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  Documentation/RelNotes/2.20.0.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/RelNotes/2.20.0.txt b/Documentation/RelNotes=
/2.20.0.txt
> index 201135d80c..e71fe3dee1 100644
> --- a/Documentation/RelNotes/2.20.0.txt
> +++ b/Documentation/RelNotes/2.20.0.txt
> @@ -578,7 +578,7 @@ Fixes since v2.19
> =20
>   * "git rev-parse --exclude=3D* --branches --branches"  (i.e. first
>     saying "add only things that do not match '*' out of all branches"
> -   and then adding all branches, without any exclusion this time")
> +   and then adding all branches, without any exclusion this time)
>     worked as expected, but "--exclude=3D* --all --all" did not work th=
e
>     same way, which has been fixed.
>     (merge 5221048092 ag/rev-parse-all-exclude-fix later to maint).
