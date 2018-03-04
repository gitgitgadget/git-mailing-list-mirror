Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8AC1F404
	for <e@80x24.org>; Sun,  4 Mar 2018 19:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbeCDTIT (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 14:08:19 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:46969 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbeCDTIS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 14:08:18 -0500
Received: by mail-pg0-f47.google.com with SMTP id r26so5950419pgv.13
        for <git@vger.kernel.org>; Sun, 04 Mar 2018 11:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8ztpsica45N4sFrychj6jyyDzJP2a7nTRUqK5nRhxIM=;
        b=Eb3Rdux/M6KXuNW/KBHkvEGDlL6Vx3oNVTZqGlPALRgHB/LbhjGZQlYEFpnBVyuIqx
         wB/oMFxUkrYVjC8ffcXfkVk1DO4dg0plbMjnTjqoWqkdm4K+BFKX1E8WWs+NvFofbKkL
         tqHqjNebAwlyaaBjfRpLLHIeg/qWFpJ6B4i6ce4lPzep9Bn8NfCwoZD8s5ozNuRkxj/1
         qvT+/QSu3bXvqV5NRUSBIVWXXYuJYa2lnQuNAN+f0HPOZ2a3Jr5BaoRi81dzfJ05Y1xY
         wiIBLqYSkXJL++u5QpbuhPJVwbKTyXkINMEBF8Z9pDuOKz6Wkj0TD1owwalqhNbZAgys
         C0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8ztpsica45N4sFrychj6jyyDzJP2a7nTRUqK5nRhxIM=;
        b=NSBFAK5bemT/Cr4pmOaUAXeFaHHtzpNYzjtG4YVLAOG02Nhtupe5MGx3i3+8i+dtby
         /XHoKENhiKGMG96Ed8DkacWnWcBttgutg4j5UWXrlUU+J1cK+I8cFeVgNSdpSiVjMAXJ
         0MKYqkWgfjD5KXvWc0DHTsi8uwP/TOf5j/CB6CrsyMy16NwjvlpyOx4LOZyaVe9zsx54
         d7aA3nR+NIGMH7LkWlP4h4R7es2dd4+CZ9irM9JYlvf9maZbrA8m77k5X2M168CquA9m
         1MGIfKGxgzTVsaiAvRfuC0A5ycp+ZqaMQH5dcg9ysuL6zDY6pllN8cUgmOh4XH0Zetkz
         2rug==
X-Gm-Message-State: APf1xPC/E+Wq8nJ5zw+TqeftpDHDMOHMIHHzqYxPPGX9Psa7pdb71b+3
        yDjNef93QRIKNt2mHUyvc+0=
X-Google-Smtp-Source: AG47ELu5NR8Z6R7ZnrKDUdK5k9M27nWkc65V0EPNgpyFOLIRh/kYMJ2nCthJpoDyg7A1ivgpXoYCSg==
X-Received: by 10.99.109.70 with SMTP id i67mr10282413pgc.190.1520190497334;
        Sun, 04 Mar 2018 11:08:17 -0800 (PST)
Received: from far8gsqyz1.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id m24sm23553402pfj.16.2018.03.04.11.08.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Mar 2018 11:08:16 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 7/7] convert: add round trip check based on 'core.checkRoundtripEncoding'
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAPig+cR81J3fTOtrgAumAs=RC5hqYFfSmeb-ru-Yf_ahFuBiew@mail.gmail.com>
Date:   Sun, 4 Mar 2018 20:08:11 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5955B68D-B6E3-43C0-8C70-47E37F1204E1@gmail.com>
References: <20180224162801.98860-1-lars.schneider@autodesk.com> <20180224162801.98860-8-lars.schneider@autodesk.com> <CAPig+cR81J3fTOtrgAumAs=RC5hqYFfSmeb-ru-Yf_ahFuBiew@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Feb 2018, at 20:50, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> On Sat, Feb 24, 2018 at 11:28 AM,  <lars.schneider@autodesk.com> =
wrote:
>> UTF supports lossless conversion round tripping and conversions =
between
>> UTF and other encodings are mostly round trip safe as Unicode aims to =
be
>> a superset of all other character encodings. However, certain =
encodings
>> (e.g. SHIFT-JIS) are known to have round trip issues [1].
>>=20
>> Add 'core.checkRoundtripEncoding', which contains a comma separated
>> list of encodings, to define for what encodings Git should check the
>> conversion round trip if they are used in the 'working-tree-encoding'
>> attribute.
>>=20
>> Set SHIFT-JIS as default value for 'core.checkRoundtripEncoding'.
>>=20
>> [1] =
https://support.microsoft.com/en-us/help/170559/prb-conversion-problem-bet=
ween-shift-jis-and-unicode
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> diff --git a/convert.c b/convert.c
>> @@ -289,6 +289,39 @@ static void trace_encoding(const char *context, =
const char *path,
>> +static int check_roundtrip(const char* enc_name)
>> +{
>> +       /*
>> +        * check_roundtrip_encoding contains a string of space and/or
>> +        * comma separated encodings (eg. "UTF-16, ASCII, CP1125").
>> +        * Search for the given encoding in that string.
>> +        */
>> +       const char *found =3D strcasestr(check_roundtrip_encoding, =
enc_name);
>> +       const char *next =3D found + strlen(enc_name);
>=20
> Is this pointer arithmetic undefined behavior (according to the C
> standard) if NULL is returned by strcasestr()? If so, how comfortable
> are we with this? Perhaps if you add an 'if' into the mix, you can
> avoid it:
>=20
>    if (found) {
>        const char *next =3D found + strlen(enc_name);
>        return ...long complicated expression...;
>    }
>    return false;

OK. I've fixed it this way:

	if (!found)
		return 0;


[...]
>> +
>> +               if (!re_src || src_len !=3D re_src_len ||
>> +                   memcmp(src, re_src, src_len)) {
>> +                       const char* msg =3D _("encoding '%s' from %s =
to %s and "
>> +                                           "back is not the same");
>> +                       die(msg, path, enc->name, default_encoding);
>=20
> Last two arguments need to be swapped.

Hm. Are you sure? I think it is correct as it is. We are in =
encode_to_git()
here and that means we encode *to* "default encoding", no?


>> +               }
>> +
>> +               free(re_src);
>> +       }
>> +
>>        strbuf_attach(buf, dst, dst_len, dst_len + 1);
>>        return 1;
>> }
>> diff --git a/t/t0028-working-tree-encoding.sh =
b/t/t0028-working-tree-encoding.sh
>> @@ -225,4 +225,45 @@ test_expect_success 'error if encoding garbage =
is already in Git' '
>> +test_expect_success 'check roundtrip encoding' '
>> +       text=3D"hallo there!\nroundtrip test here!" &&
>> +       printf "$text" | iconv -f UTF-8 -t SHIFT-JIS >roundtrip.shift =
&&
>> +       printf "$text" | iconv -f UTF-8 -t UTF-16 >roundtrip.utf16 &&
>> +       echo "*.shift text working-tree-encoding=3DSHIFT-JIS" =
>>.gitattributes &&
>> +
>> +       # SHIFT-JIS encoded files are round-trip checked by =
default...
>> +       GIT_TRACE=3D1 git add .gitattributes roundtrip.shift 2>&1 =
>/dev/null |
>> +               grep "Checking roundtrip encoding for SHIFT-JIS" &&
>=20
> Why redirect to /dev/null? If something does go wrong somewhere, the
> more output available for debugging the problem, the better, so
> throwing it away unnecessarily seems contraindicated.

OK!


>> +       git reset &&
>> +
>> +       # ... unless we overwrite the Git config!
>> +       test_config core.checkRoundtripEncoding "garbage" &&
>> +       ! GIT_TRACE=3D1 git add .gitattributes roundtrip.shift 2>&1 =
>/dev/null |
>> +               grep "Checking roundtrip encoding for SHIFT-JIS" &&
>> +       test_unconfig core.checkRoundtripEncoding &&
>=20
> The "unconfig" won't take place if the test fails. Instead of
> test_config/test_unconfig, you could use '-c' to set the config
> transiently for the git-add operation:
>=20
>    ! GIT_TRACE=3D1 git -c core.checkRoundtripEncoding=3Dgarbage add =
...

Agreed. Although test_config (in t/test-lib-functions.sh) automatically=20=

unsets itself after the test is over.=20


>> +       git reset &&
>> +
>> +       # UTF-16 encoded files should not be round-trip checked by =
default...
>> +       ! GIT_TRACE=3D1 git add roundtrip.utf16 2>&1 >/dev/null |
>> +               grep "Checking roundtrip encoding for UTF-16" &&
>> +       git reset &&
>> +
>> +       # ... unless we tell Git to check it!
>> +       test_config_global core.checkRoundtripEncoding "UTF-16, =
UTF-32" &&
>> +       GIT_TRACE=3D1 git add roundtrip.utf16 2>&1 >/dev/null |
>> +               grep "Checking roundtrip encoding for UTF-16" &&
>> +       git reset &&
>> +
>> +       # ... unless we tell Git to check it!
>> +       # (here we also check that the casing of the encoding is =
irrelevant)
>> +       test_config_global core.checkRoundtripEncoding "UTF-32, =
utf-16" &&
>> +       GIT_TRACE=3D1 git add roundtrip.utf16 2>&1 >/dev/null |
>> +               grep "Checking roundtrip encoding for UTF-16" &&
>> +       git reset &&
>> +
>> +       # cleanup
>> +       rm roundtrip.shift roundtrip.utf16 &&
>> +       git reset --hard HEAD
>> +'
>=20
> Same comment as for patch 5/7: This cleanup won't happen if the test
> fails. Instead, use test_when_finished() earlier in the test:
>=20
>    test_expect_success 'check roundtrip encoding' '
>        test_when_finished "rm -f roundtrip.shift roundtrip.utf16; git
> reset --hard HEAD" &&
>        ...

Agreed!

Thanks you,
Lars

