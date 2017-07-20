Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 038D31F600
	for <e@80x24.org>; Thu, 20 Jul 2017 19:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934668AbdGTTLF (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 15:11:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57836 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753659AbdGTTLE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 15:11:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E9038BEB5;
        Thu, 20 Jul 2017 15:11:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=28t8rFEy2FSv
        895lEy9J5u8hVeM=; b=hJojNZWJFJOy0/L+PHTEFl9x4D32Fxbg9EcuizJEThvs
        tmKUpOibpGrsg2PpZRREMfTi1/XGoJjH2+q0TIh6OVc18JiV6kZFSznbcfRDPnoc
        np2gM+BmEOh+DShY2mv+nhH86/HVU4y7JsCbhWAG1CGYYn35SkJ02Zp6ZfiCG58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oo7aRP
        2rMtEw07CmQ/12YCTPExFdWY9ciknnHnnA4Q9Hsbuep755XUFaNP899mF6w8gEgc
        zBrz4Kg94kZve+B1HquhjbBjOM+KoOftdqZYzDQlS+Q0g+RihteBuc+MxGVK6JBh
        H4Xl/MMxojKS5+Lrr0DhGVd32YjIg77Q/rxuU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16EEA8BEB3;
        Thu, 20 Jul 2017 15:11:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6734A8BEB2;
        Thu, 20 Jul 2017 15:11:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] RelNotes: add more notes about PCRE in 2.14
References: <20170720141927.18274-1-avarab@gmail.com>
        <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com>
        <20170720141927.18274-7-avarab@gmail.com>
Date:   Thu, 20 Jul 2017 12:11:02 -0700
In-Reply-To: <20170720141927.18274-7-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 20 Jul 2017 14:19:27 +0000")
Message-ID: <xmqqbmoely9l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2C95AD42-6D7F-11E7-9FF4-EFB41968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> We were missing any mention that:
>
>  - PCRE is now faster with JIT
>  - That it's now faster than the other regex backends
>  - That therefore you might want to use it by default, but beware of
>    the incompatible syntax.

Hmph.  All of that has been more or less deliberate, as I want the
release notes to be more like table of contents, one bullet per item
with short description, not a novelette with one paragraph per item.

These should already be in the documentation when they do want to
decide if they want to use JIT; somebody who downloads 2.15 or later
and wants to decide if they want JIT shouldn't have to dig down to
earlier release notes that introduced the option for the first time.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/RelNotes/2.14.0.txt | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/RelNotes/2.14.0.txt b/Documentation/RelNotes=
/2.14.0.txt
> index fb6a3dba31..a6a1cb963b 100644
> --- a/Documentation/RelNotes/2.14.0.txt
> +++ b/Documentation/RelNotes/2.14.0.txt
> @@ -88,7 +88,16 @@ UI, Workflows & Features
>     learned to say "it's a pathspec" a bit more often when the syntax
>     looks like so.
> =20
> - * Update "perl-compatible regular expression" support to enable JIT.
> + * Update "perl-compatible regular expression" support to enable
> +   JIT.
> +
> +   This makes grep.patternType=3Dperl (and -P and --perl-regexp) much
> +   faster for "git grep" and "git log", and is generally faster than
> +   the system's POSIX regular expression implementation. Users
> +   concerned with "git grep" performance or "git log --grep"
> +   performance might want to try setting grep.patternType=3Dperl. Note
> +   that the syntax isn't compatible with git's default of
> +   grep.patternType=3Dbasic.
> =20
>   * "filter-branch" learned a pseudo filter "--setup" that can be used
>     to define common functions/variables that can be used by other
