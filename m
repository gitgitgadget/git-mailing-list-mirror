Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E76C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 00:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7831F6108E
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 00:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhJVA3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 20:29:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52883 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhJVA3s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 20:29:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CAA1A164247;
        Thu, 21 Oct 2021 20:27:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/8rx5jPQTQN9
        r4M35/+ucscX3LV8uovaF0w+EsRbiPM=; b=RhLi/wsk+SyZZqOWn4XRHcZMSRPe
        Do/uSFEEn2Id8QBQDReydw/BDQ67x4kmE50OIVhXco+bsowwU98RZ8FYXYybD/vb
        OacIA37K78KVnrx0xyRX6G02hqsbOWxUQmVOF/r/Rb29kpwJAoo6Z3vU7AAAwWzz
        cNDstoiDePnHlV0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ABF55164246;
        Thu, 21 Oct 2021 20:27:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 736DC164245;
        Thu, 21 Oct 2021 20:27:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] git-sh-setup: remove unused sane_egrep() function
References: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
        <patch-5.6-eacbfd6be0e-20211021T195538Z-avarab@gmail.com>
Date:   Thu, 21 Oct 2021 17:27:27 -0700
In-Reply-To: <patch-5.6-eacbfd6be0e-20211021T195538Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Oct
 2021 21:57:59 +0200")
Message-ID: <xmqq8rylgaz4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D67E0C28-32CE-11EC-85B0-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The is_zero_oid() function in git-submodule.sh has not been used since
> e83e3333b57 (submodule: port submodule subcommand 'summary' from shell
> to C, 2020-08-13), so we can remove it, and the sane_egrep() function,
> dead is_zero_oid() was the only function which still referenced it.
>
> Unlike some other functions in git-sh-setup.sh, this function has not
> been documented in git-sh-setup(1), so per [1] it should be OK to
> remove it. I'm still unclear about the future of some of the other
> functions[2], but any questions in that area should not apply here.
>
> 1. https://lore.kernel.org/git/xmqqr1dtgnn8.fsf@gitster.g/
> 1. https://lore.kernel.org/git/87tuiwjfvi.fsf@evledraar.gmail.com/

Don't force readers to go outside of "git log" stream they are
reading.  Instead, summarize the argument that you base your
decision on for readers of your proposed commit log message.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  git-sh-setup.sh | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index cee053cdc38..758520f5a61 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -177,10 +177,6 @@ sane_grep () {
>  	GREP_OPTIONS=3D LC_ALL=3DC grep @@SANE_TEXT_GREP@@ "$@"
>  }
> =20
> -sane_egrep () {
> -	GREP_OPTIONS=3D LC_ALL=3DC egrep @@SANE_TEXT_GREP@@ "$@"
> -}
> -
>  is_bare_repository () {
>  	git rev-parse --is-bare-repository
>  }
