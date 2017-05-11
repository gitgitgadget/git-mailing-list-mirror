Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADA46201A0
	for <e@80x24.org>; Thu, 11 May 2017 20:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932761AbdEKUeb (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:34:31 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36729 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932594AbdEKUea (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:34:30 -0400
Received: by mail-io0-f194.google.com with SMTP id f102so4098555ioi.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 13:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8JQR44taMia7oxA0uKwndbeARQCSTzm52W2IuqW+a2Q=;
        b=ah2wTTBIySL3HgHRmZNsSQ5EB6eii4xLVcO8vynrFBnfnqP8OGxRuyohhs58XIZxZD
         NWdSDa0F3Pv70aZ2etr0rfi6IAJmm641MlRUKQrg8EFgdDOOtTZz9rsGnCiwik7k0Yw1
         ucJneiT9vS2l/JFBRZAwMkzEFDfI+9ylxvXKL635lQ5CaSTbxXWb6Ec10bfx2zM7QVIl
         w2NO18VDtV5sOqX9Kw30QGFa74jIdspXE9MIWm709c7IQ5viUsxNbQZ3SQbE1fN/1NPz
         MXFVO6n460PvJg5+RHRclUdhv+wN2ZKY0IGFRcU7Aux9CRUIjfef7RwSpg3UPeLcIrUQ
         gs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8JQR44taMia7oxA0uKwndbeARQCSTzm52W2IuqW+a2Q=;
        b=bOpcOv0GXjQ0rrnyRdnurErRI4bFX2bGwj9OiIGKaNgST7JtUstgMhJ+drxxeRWbaE
         oqBj7+9LypMKPfv0pTU4jhKPlY3AZKBqUZAG9w+yTGgxWLr34rYR3XebH523XCq462nB
         xHXxfGDndBgiuckKWC1gqaOWamUAN7oyND4c4bYQnq7LH7BgQVSiiDT+F/8z6gbZCfNj
         9OJ55cxAP47wFhIjQeBL0JIYLOrvfqSVweN8SadD0vEcsOSG5fB+11NvfvOCoYT9ICn2
         aik8oZGdurljCXV3BLA17amiw9zcgapheOM83R+oRWtpDL2jpnUuwn/eSR8GREfKOTx9
         luXg==
X-Gm-Message-State: AODbwcBaJV4ZgO+WDPD80UJOi0HwTEpgVMSUL0GksvBLREtrxrzOg3/q
        LGDOxbVpe8Hu3nGywWT8waJsX97Uug==
X-Received: by 10.107.201.131 with SMTP id z125mr417111iof.160.1494534869245;
 Thu, 11 May 2017 13:34:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 11 May 2017 13:34:08 -0700 (PDT)
In-Reply-To: <20170511201742.GJ83655@google.com>
References: <20170511091829.5634-1-avarab@gmail.com> <20170511091829.5634-27-avarab@gmail.com>
 <20170511201742.GJ83655@google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 11 May 2017 22:34:08 +0200
Message-ID: <CACBZZX5CPyo0yLUU+bGJyMNn1Ei2+B_MV8OxmVfa+=F=xdtGhQ@mail.gmail.com>
Subject: Re: [PATCH 26/29] pack-objects & index-pack: add test for --threads warning
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 10:17 PM, Brandon Williams <bmwill@google.com> wrot=
e:
> On 05/11, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Add a test for the warning that's emitted when --threads or
>> pack.threads is provided under NO_PTHREADS=3DYesPlease. This uses the
>> new PTHREADS prerequisite.
>>
>> The assertion for C_LOCALE_OUTPUT in the latter test is currently
>> redundant, since unlike index-pack the pack-objects warnings aren't
>> i18n'd. However they might be changed to be i18n'd in the future, and
>> there's no harm in future-proofing the test.
>>
>> There's an existing bug in the implementation of pack-objects which
>> this test currently tests for as-is. Details about the bug & the fix
>> are included in a follow-up change.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/t5300-pack-object.sh | 34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
>> index 43a672c345..1629fa80b0 100755
>> --- a/t/t5300-pack-object.sh
>> +++ b/t/t5300-pack-object.sh
>> @@ -421,6 +421,40 @@ test_expect_success 'index-pack <pack> works in non=
-repo' '
>>       test_path_is_file foo.idx
>>  '
>>
>> +test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'index-pack --threads=3DN=
 or pack.threads=3DN warns when no pthreads' '
>> +     test_must_fail git index-pack --threads=3D2 2>err &&
>> +     grep ^warning: err >warnings &&
>> +     test_line_count =3D 1 warnings &&
>> +     grep -F "no threads support, ignoring --threads=3D2" err &&
>> +     test_must_fail git -c pack.threads=3D2 index-pack 2>err &&
>> +     grep ^warning: err >warnings &&
>> +     test_line_count =3D 1 warnings &&
>> +     grep -F "no threads support, ignoring pack.threads" err &&
>> +     test_must_fail git -c pack.threads=3D2 index-pack --threads=3D4 2>=
err &&
>> +     grep ^warning: err >warnings &&
>> +     test_line_count =3D 2 warnings &&
>> +     grep -F "no threads support, ignoring --threads=3D4" err &&
>> +     grep -F "no threads support, ignoring pack.threads" err
>> +'
>> +
>> +test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'pack-objects --threads=
=3DN or pack.threads=3DN warns when no pthreads' '
>> +     git pack-objects --threads=3D2 --stdout --all </dev/null >/dev/nul=
l 2>err &&
>> +     grep ^warning: err >warnings &&
>> +     test_line_count =3D 1 warnings &&
>> +     grep -F "no threads support, ignoring --threads" err &&
>> +     git -c pack.threads=3D2 pack-objects --stdout --all </dev/null >/d=
ev/null 2>err &&
>> +     cat err &&
>> +     grep ^warning: err >warnings &&
>> +     test_line_count =3D 2 warnings &&
>> +     grep -F "no threads support, ignoring --threads" err &&
>> +     grep -F "no threads support, ignoring pack.threads" err &&
>> +     git -c pack.threads=3D2 pack-objects --threads=3D4 --stdout --all =
</dev/null >/dev/null 2>err &&
>> +     grep ^warning: err >warnings &&
>> +     test_line_count =3D 2 warnings &&
>> +     grep -F "no threads support, ignoring --threads" err &&
>> +     grep -F "no threads support, ignoring pack.threads" err
>> +'
>> +
>
> Some of these tests you might want to rewrite using test_i18ncmp to
> ensure that the messages match in other languages.  That is assuming
> this error message is translated (which it should be).

[Mostly for my own notes so I see I covered this]

Covered in a side-thread, the test is guarded by C_LOCALE_OUTPUT which
does the same thing.

>>  #
>>  # WARNING!
>>  #
>> --
>> 2.11.0
>>
>
> --
> Brandon Williams
