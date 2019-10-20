Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF78B1F4C0
	for <e@80x24.org>; Sun, 20 Oct 2019 00:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfJTA04 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 20:26:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52546 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfJTA04 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 20:26:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B63891D0B;
        Sat, 19 Oct 2019 20:26:54 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=gUp3lMbjOAkU8
        ZkmGped/Oz6YlI=; b=LkLei8AjkCm3cWgoD1f6QbTn03mFu6vzoNIKlX1oezQuY
        DpbipcqpmnmuFLK/Zae1v0EaQWdbwctD7PuzYMi2Ca59HAFBvP3vPHOP+xUuuPWd
        Oria/0CCJZdWUAM6AxZUPZi1a81adOuCWMKIQ6L+BePQVVwUibS74k+jrpfBYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=RGTfxoL
        /jdKbkJIY/OmMqKq9evFk7dnWilnjsejsjHlZ2v8EnMy3hjqDbnCfr2fGj4x8HtQ
        zdsY/o83Ni00KKxEt/rYhuBhrPiYm4fumdPwgUJk1c319lD3RaPc/ktx0mxtLYe0
        rK5tvwRhTNDsbctI3P2q0TCxJT8R4UhUOzcw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83AB691D0A;
        Sat, 19 Oct 2019 20:26:54 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 616A491D09;
        Sat, 19 Oct 2019 20:26:51 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Sat, 19 Oct 2019 20:26:48 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [BUG]: Testsuite failures on big-endian targets
Message-ID: <20191020002648.GZ10893@pobox.com>
References: <b0bec82e-ad0a-32f6-e2e6-e1f0e6920639@physik.fu-berlin.de>
 <20190731071755.GF4545@pobox.com>
 <f1ce445e-6954-8e7b-2dca-3a566ce689a5@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f1ce445e-6954-8e7b-2dca-3a566ce689a5@physik.fu-berlin.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 4FB9AC3C-F2D0-11E9-843F-B0405B776F7B-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

[+cc: =C6var]

John Paul Adrian Glaubitz wrote:
> The testsuite is failing again on s390x and all other big-endian target=
s in
> Debian. For a full build log on s390x see [1].
>=20
> Adrian
>=20
>> [1] https://buildd.debian.org/status/fetch.php?pkg=3Dgit&arch=3Ds390x&=
ver=3D1%3A2.24.0%7Erc0-1&stamp=3D1571440098&raw=3D0

With t0500 resolved by <20191019233706.GM29845@szeder.dev>,
that just leaves the one failure in t7812.

    Test Summary Report
    -------------------
    t7812-grep-icase-non-ascii.sh                    (Wstat: 256 Tests: 1=
1 Failed: 1)
      Failed test:  11
      Non-zero exit status: 1
    Files=3D879, Tests=3D21880, 404 wallclock secs ( 3.38 usr  1.15 sys +=
 440.87 cusr 729.29 csys =3D 1174.69 CPU)
    Result: FAIL

The failing test output:

    expecting success of 7812.11 'PCRE v2: grep non-ASCII from invalid UT=
F-8 data with -i':=20
        test_might_fail git grep -hi "=C6" invalid-0x80 >actual &&
        test_cmp expected actual &&
        test_must_fail git grep -hi "(*NO_JIT)=C6" invalid-0x80 &&
        test_cmp expected actual
    ++ test_might_fail git grep -hi =C6 invalid-0x80
    ++ test_must_fail ok=3Dsuccess git grep -hi =C6 invalid-0x80
    ++ case "$1" in
    ++ _test_ok=3Dsuccess
    ++ shift
    ++ git grep -hi =C6 invalid-0x80
    fatal: pcre2_match failed with error code -22: UTF-8 error: isolated =
byte with 0x80 bit set
    ++ exit_code=3D128
    ++ test 128 -eq 0
    ++ test_match_signal 13 128
    ++ test 128 =3D 141
    ++ test 128 =3D 269
    ++ return 1
    ++ test 128 -gt 129
    ++ test 128 -eq 127
    ++ test 128 -eq 126
    ++ return 0
    ++ test_cmp expected actual
    ++ diff -u expected actual
    --- expected    2019-10-19 21:56:08.634252012 +0000
    +++ actual      2019-10-19 21:56:08.714252012 +0000
    @@ -1 +0,0 @@
    -=E6var
    error: last command exited with $?=3D1
    not ok 11 - PCRE v2: grep non-ASCII from invalid UTF-8 data with -i
    #      =20
    #               test_might_fail git grep -hi "=C6" invalid-0x80 >actu=
al &&
    #               test_cmp expected actual &&
    #               test_must_fail git grep -hi "(*NO_JIT)=C6" invalid-0x=
80 &&
    #               test_cmp expected actual
    #      =20
    # failed 1 among 11 test(s)

I'm not flush on time to even try to look much; but I'd be
kidding myself if I said I was likely to find the issue
quickly. ;)

But I'm pretty sure it will be obvious to someone here.

--=20
Todd
