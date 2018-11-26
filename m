Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D2741F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 06:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeKZRoM (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 12:44:12 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59600 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeKZRoL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 12:44:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9AD0F1DD51;
        Mon, 26 Nov 2018 01:51:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rL4ufScAWn2G
        85pOyBFJ++ZRa7w=; b=fKqj4n/QCrzoPqTmWq8LeUqTrcTwLQKSgeY0ay9glmXy
        Bven8r8orTPqZvfXIEy3LdwcbDv/RHA+YwIJZuEjTxhA57A2Xx7JpW2aqWEhjzpG
        SXdJx10qV8yi9jM8EixbkcgspJ7JqkVF/6+UL9BDhB4Y09lfpw7TtQCqHmHPdrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ow6xru
        kWuAPCVp6o1UYa1LqAvAbffqg/s2exZxD5zu8+DDVPW4/Qymhw4HFbsYwcY8pXN0
        ZBSJVrpxaKp4Dyq18cA8rXxQ40w6elVgkPPwp02AY9p0Wv7r3zLS0HIjYBIQs1zo
        pxsKax74Zr8cAXPSSr2pK0sJ0oRkhKLFhCs/Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 940E31DD50;
        Mon, 26 Nov 2018 01:51:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A895D1DD4C;
        Mon, 26 Nov 2018 01:50:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 5/7] test-lib: use pkgsrc provided unzip for NetBSD
References: <cover.1543143503.git.carenas@gmail.com>
        <5fe64afa3d7cf9a46a527c47885e8e60dae2445c.1543143503.git.carenas@gmail.com>
Date:   Mon, 26 Nov 2018 15:50:57 +0900
In-Reply-To: <5fe64afa3d7cf9a46a527c47885e8e60dae2445c.1543143503.git.carenas@gmail.com>
        ("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 25 Nov
 2018 03:06:48
        -0800")
Message-ID: <xmqqd0qsxrfy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A1F608AA-F147-11E8-8D1B-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> d98b2c5fce ("test-lib: on FreeBSD, look for unzip(1) in /usr/local/bin/=
",
> 2016-07-21) added an exception to the test suite for FreeBSD because th=
e
> tests assume functionality not provided by its base unzip tool.
>
> NetBSD shares that limitation and provides a package that could be used
> instead so all tests from t5003 succeed
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  t/test-lib.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 6c6c0af7a1..2acb35f277 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1244,6 +1244,7 @@ test_lazy_prereq SANITY '
>  '
> =20
>  test FreeBSD !=3D $uname_s || GIT_UNZIP=3D${GIT_UNZIP:-/usr/local/bin/=
unzip}
> +test $uname_s =3D NetBSD && GIT_UNZIP=3D${GIT_UNZIP:-/usr/pkg/bin/unzi=
p}

This is OK for now, but I wonder why this is done in test-lib.sh in
the first place, unlike $(TAR) that is set and configurable from the
top level.  The difference is that GIT_UNZIP happens to be used only
in tests, while TAR is used in the primary build procedure.

But I suspect that in the longer run, we should allow UNZIP to be
given next to TAR to the top-level Makefile and export it down.
That would allow the usual mechanism like config.mak.uname,
./configure and "make TAR=3D... UNZIP=3D..." command line override
to be used uniformly, without people having to worry about the
distinction.  The builders should *not* have to care that one is
used in the build and the other is only used in the test.

>  GIT_UNZIP=3D${GIT_UNZIP:-unzip}
>  test_lazy_prereq UNZIP '
>  	"$GIT_UNZIP" -v
