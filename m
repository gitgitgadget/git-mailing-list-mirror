Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE076C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 18:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiLBSbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 13:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiLBSbL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 13:31:11 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CDCACA40
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 10:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1670005861; bh=Eo469WLowrJEVyOp6T0rHRZBRhxvsSpOf7VJuHEdidI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lVgpDXjLdoGnuhzdd/b+XrXE3ltghkXP1DYYROosfngQta08S+JPrOPj3WoNuUJOL
         VIwAoOIHYVv5WmZEMQgkZhSfcEI3GzmGTVJEk3bZ6Ug7VXT9Uki4+pR93wEvwQ32tZ
         6gdmieUxb0qrehze3KxcRvmZwWzZ6LPdxkE6sCmLc5anhwAjF7DyV4nIn8FW6iMkj1
         QbbUs9KCWyxYhXGBK6o6REjswvHj2MqKugt3G8fUHFCKoLAu5o455AT7yPamG0ucLN
         48YOcOzSmngexOmwafdjFD0KQCHnwikHtBeMzUNW7udWRRNOITLW10AC15mDXYOuHZ
         c+MdRmPWAx0YA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTvrq-1pQzO23fr0-00RQ4R; Fri, 02
 Dec 2022 19:31:00 +0100
Message-ID: <3304ac3c-0d45-7293-bd7f-08f374786dcc@web.de>
Date:   Fri, 2 Dec 2022 19:31:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3 7/8] tests: don't lose "git" exit codes in "! ( git ...
 | grep )"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershause?= =?UTF-8?Q?n?= 
        <tboegi@web.de>
References: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
 <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
 <patch-v3-7.8-307f25db831-20221202T114733Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-v3-7.8-307f25db831-20221202T114733Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TqXI9qTeNcszRvxyLrheBURlQVaTTeMjlwwt5HIzFFIqxpWVZKX
 V3JjKn33JSZb+nGJ2XzG1mFemCWBMUBZ8wQtF0oDAImz4idiKL4WcfYLHodCmgSSHGQkjSX
 Yz3L1tlhO/5Oa51Q8P4TBjNzXF549pfiFHEFn2cMLyCVne/YF9NVsDKm06EYTwWJsqnBYm/
 UnJfut4OdaQCifrpdvifw==
UI-OutboundReport: notjunk:1;M01:P0:hg/Z/wXyLcU=;bCWx5VfkER71nv7/fPKoq2PDWEK
 O9Bu0itSggkXnyM4USC1NyvMrr7+MvDMYstHvxWtVdp8SprGPMO7+4QQV5HoM7vMLGLnEaZJe
 9xynkQMzDvoFDjFmNz5NvmSZy5XbZPC+jDjZ3O9L1bMTv0rfAgYH1ARo6zlOS5b4CzHkHKse/
 gknOlpj4TYHyALQjUnOuNq7DtiAU9ObDokqNxy1pIYE755CuHEDmYdf3nHNN6AkxMN6Vvg6ma
 0kK2mw1rHYoVBMcvS+R83XS4e/d3324NwHNl+TVsAarGfhrrb1yqbwM7ZEWOGR83rViJ5R9lw
 G/wWlJKYYnBs+L02lQBmjZayR5HmgkrAbZvzhbBU93W562eqlO+l0Fpb9o3GOm7qs1Spbh6LL
 Tzsv4Pb3Sa4jJbQUQYT2uo0W3gC6KQ4vE6CJyafIulf8RRe9EDv2D5WVVqcmL6B0nBoml79JH
 cc5nAvtqW530/KV4QRKqiaqERbP7xvtlA2rvV1ZMsnWS28Hkbyop4i1LN3nys+injXhAoaLIJ
 mRzu2tynciZCY4fTOTO15YEa81XYUqjiHE3nCVxVfEc6xWSoFVu1UVtwgo+KrlWUvmfW3KYgr
 7ACxCDHdLJ367qttvV4GzdK3weh2xMjK7uN2aCj8Ib7GRdCRCnpzF3BUV/UyMY85KNauju3g5
 SWnGtSTlb8ditxlrERmzdejRuQmqer40rAZEe5nfXOa/kC9oG89OE2jhKkEV34BMefc8b9DrL
 m224TYca3Yssie2MOswxit94604SNNjVdIop6ykwILFQOoVjlf3TrdgxxDY/ll5sO1VIpjTFw
 G4netarg7Uzv359TJEYvaeCcEWDQsguQW7wG+d7v3bTth7UdybpWuJVmgj3az/nwkTyc+QvEG
 e4XSH0zsw9n81/d+D8T8dTCchpsmtcIEo5QbCTTBmLrGRKnhwohhM4h1J4hvrOeWc1uvhNPqd
 RSO+c4J7Nx3QlH7HFZYBW+W0gpY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.12.22 um 12:52 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Change tests that would lose the "git" exit code via a negation
> pattern to:
>
> - In the case of "t0055-beyond-symlinks.sh" compare against the
>   expected output instead.
>
> - For "t3700-add.sh" use "sed -n" to print the expected "bad" part,
>   and use "test_must_be_empty" to assert that it's not there.
>
>   We can also remove a repeated invocation of "git ls-files" for the
>   last test that's being modified in that file, and search the
>   existing "files" output instead.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  t/t0055-beyond-symlinks.sh | 14 ++++++++++++--
>  t/t3700-add.sh             | 18 +++++++++++++-----
>  2 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/t/t0055-beyond-symlinks.sh b/t/t0055-beyond-symlinks.sh
> index 6bada370225..c3eb1158ef9 100755
> --- a/t/t0055-beyond-symlinks.sh
> +++ b/t/t0055-beyond-symlinks.sh
> @@ -15,12 +15,22 @@ test_expect_success SYMLINKS setup '
>
>  test_expect_success SYMLINKS 'update-index --add beyond symlinks' '
>  	test_must_fail git update-index --add c/d &&
> -	! ( git ls-files | grep c/d )
> +	cat >expect <<-\EOF &&
> +	a
> +	b/d
> +	EOF
> +	git ls-files >actual &&
> +	test_cmp expect actual
>  '

Hmm, this makes the test depend on the other files.  Adding more of them
for a different test now requires updating this test as well.  Why not
handle it like you did in t3700 below?

>
>  test_expect_success SYMLINKS 'add beyond symlinks' '
>  	test_must_fail git add c/d &&
> -	! ( git ls-files | grep c/d )
> +	cat >expect <<-\EOF &&
> +	a
> +	b/d
> +	EOF
> +	git ls-files >actual &&
> +	test_cmp expect actual
>  '

Same here.

>
>  test_done
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index 51afbd7b24a..82dd768944f 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -106,24 +106,32 @@ test_expect_success '.gitignore test setup' '
>
>  test_expect_success '.gitignore is honored' '
>  	git add . &&
> -	! (git ls-files | grep "\\.ig")
> +	git ls-files >files &&
> +	sed -n "/\\.ig/p" <files >actual &&
> +	test_must_be_empty actual
>  '

You use sed instead of grep because no match is expected and sed returns
0 even then, while grep would exit with code 1, correct?  OK.

Can we use that, though?  I.e. how about this?

	git ls-files >files &&
	test_expect_code 1 grep "\\.ig" files

It would print the unexpected lines in verbose mode like this:

	expecting success of 3700.12 '.gitignore is honored':
		git add . &&
		git ls-files >files &&
		echo foo.ig >files &&	# inject bogus value
		test_expect_code 1 grep "\\.ig" files

	foo.ig
	test_expect_code: command exited with 0, we wanted 1 grep \.ig files

Or can we trust ls-files' own filtering?

	git ls-files "*.ig" >actual &&
	test_must_be_empty actual

Both variants are shorter and should be slightly faster, which can
matter if we use that pattern more widely.

(Didn't measure here, but from a recent foray into t3920 on Windows I
took home that removing commands has a small, but measurable impact there:
https://lore.kernel.org/git/203cb627-2423-8a35-d280-9f9ffc66e072@web.de/T/=
#u)

>
>  test_expect_success 'error out when attempting to add ignored ones with=
out -f' '
>  	test_must_fail git add a.?? &&
> -	! (git ls-files | grep "\\.ig")
> +	git ls-files >files &&
> +	sed -n "/\\.ig/p" <files >actual &&
> +	test_must_be_empty actual
>  '
>
>  test_expect_success 'error out when attempting to add ignored ones with=
out -f' '
>  	test_must_fail git add d.?? &&
> -	! (git ls-files | grep "\\.ig")
> +	git ls-files >files &&
> +	sed -n "/\\.ig/p" <files >actual &&
> +	test_must_be_empty actual
>  '
>
>  test_expect_success 'error out when attempting to add ignored ones but =
add others' '
>  	touch a.if &&
>  	test_must_fail git add a.?? &&
> -	! (git ls-files | grep "\\.ig") &&
> -	(git ls-files | grep a.if)
> +	git ls-files >files &&
> +	sed -n "/\\.ig/p" <files >actual &&
> +	test_must_be_empty actual &&
> +	grep a.if files
>  '
>
>  test_expect_success 'add ignored ones with -f' '
