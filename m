Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 720C620248
	for <e@80x24.org>; Fri, 22 Feb 2019 18:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfBVSgA (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 13:36:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59952 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfBVSgA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 13:36:00 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 933BA13A00F;
        Fri, 22 Feb 2019 13:35:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=FRJIz6T2yBp2X
        3Y/7WLyrEDTswI=; b=LpnawfuHS8ZrqLWL5eiVCQ8/IwBv3jA08XlAgFP3THSkU
        i1huHm2G/9SKL7WLJZQBcQwq8SZnEH6gd6luqw2CMwzuRdulgOC7qVm2Ep3qiTN4
        XNzat0rE4h/DdwoqINofh8aXZngjlXdPoIZeYDIpsCJ7aKw+ay7g3ROnZECTTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=heEhFWG
        DoakaCNRhYVpB0kFwjwNkvD0UavKzbV71CLDgAzh4YB1VME3zAAgR17saTGoO35S
        8zsVHhwNXIUKkGF9wIb1IwE+x4U654vanbzUQ1VkB0zgHH8U7Vn63kTZM34FJnt+
        PNZW4/I8zrHuSBGljSRkBhU23fg3fPOr3bcY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 884AB13A00E;
        Fri, 22 Feb 2019 13:35:55 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 09E9713A00D;
        Fri, 22 Feb 2019 13:35:55 -0500 (EST)
Date:   Fri, 22 Feb 2019 13:35:53 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Sebastian Staudt <koraktor@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] commit-graph tests: fix cryptic unportable "dd"
 invocation
Message-ID: <20190222183553.GA16125@zaya.teonanacatl.net>
References: <xmqq8sybz7b2.fsf@gitster-ct.c.googlers.com>
 <20190221192849.6581-3-avarab@gmail.com>
 <20190221204310.GS1622@szeder.dev>
 <878sy86anh.fsf@evledraar.gmail.com>
 <20190222105053.GU1622@szeder.dev>
 <8736of6gej.fsf@evledraar.gmail.com>
 <xmqqbm33r7zl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <xmqqbm33r7zl.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: B05DAF1E-36D0-11E9-9190-DF19F34BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>=20
>> It was my reading of the seek=3D* section ("the implementation shall s=
eek
>> to the specified offset"). I didn't spot that bit covered in of=3D*. Y=
eah,
>> I see that's defined & safe after reading that.
>=20
> OK, so...
>=20
> -- >8 --
> From: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
> Date: Thu, 21 Feb 2019 20:28:49 +0100
> Subject: [PATCH] commit-graph tests: fix cryptic unportable "dd" invoca=
tion
>=20
> Change an unportable invocation of "dd" with count=3D0, that wanted to
> truncate the commit-graph file.  In POSIX it is unspecified what
> happens when count=3D0 is provided[1]. The NetBSD "dd" behavior
> differs from GNU (and seemingly other BSDs), which as left this test

s/ as/ has/ ?

> broken since d2b86fbaa1 ("commit-graph: fix buffer read-overflow",
> 2019-01-15).
>=20
> Copying from /dev/null would seek/truncate to seek=3D$zero_pos and
> stop immediately after that (without being able to copy anything),
> which is the right way to truncate the file.
>=20
> 1. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/dd.html
>=20
> Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
> Helped-by: SZEDER G=E1bor <szeder.dev@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t5318-commit-graph.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index d4bd1522fe..561796f280 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -382,7 +382,7 @@ corrupt_graph_and_verify() {
>  	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &=
&
>  	cp $objdir/info/commit-graph commit-graph-backup &&
>  	printf "$data" | dd of=3D"$objdir/info/commit-graph" bs=3D1 seek=3D"$=
pos" conv=3Dnotrunc &&
> -	dd of=3D"$objdir/info/commit-graph" bs=3D1 seek=3D"$zero_pos" count=3D=
0 &&
> +	dd of=3D"$objdir/info/commit-graph" bs=3D1 seek=3D"$zero_pos" if=3D/d=
ev/null &&
>  	generate_zero_bytes $(($orig_size - $zero_pos)) >>"$objdir/info/commi=
t-graph" &&
>  	test_must_fail git commit-graph verify 2>test_err &&
>  	grep -v "^+" test_err >err &&

--=20
Todd
