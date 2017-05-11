Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E59FB2018D
	for <e@80x24.org>; Thu, 11 May 2017 18:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756901AbdEKSgU (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 14:36:20 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33973 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756851AbdEKSgT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 14:36:19 -0400
Received: by mail-it0-f67.google.com with SMTP id c26so3936577itd.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 11:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aGW8a7HRETZU6sP9CsbDWY08pnh+mUDfZgQTU6RZpoQ=;
        b=o4Ltr86onDmzs2YMp8UkD3Gq77ZrF/Q+lU9dnLzPdt2Cy7tcz+kYJKYSRVM1pk0sg7
         Nl/F7uYTLgbzWYE5flY3PSRRpxkdvKJGPHC5W+Vu8hE3VKgyKroReCweLrrz0u/ziLs4
         kcMbXZqNP1qfryxOmEyba+uFCBVuQwAY1nWoJFzojhzhG9+gJd3yhmJnQdgkimANPhQ+
         lwsMeOjuuqz9T5J00X+SvMsZhLo+piTqCJ+e3PAmEKCHfyxftViUHY1JjCrBdUPc1W8r
         +IWiynBQdvCL3yImq8HyGufzu2YjMylF5Od90cf7/kiQi2Hhb3Wc7Ek9NTI40K3d+mrh
         P2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aGW8a7HRETZU6sP9CsbDWY08pnh+mUDfZgQTU6RZpoQ=;
        b=lwVJpr+pHySIqnBB6tp7QEEIQqyw9QG2TNy1/rWs8LDXBMop+H5gSJlfseUrbtzXkV
         /qhvR/cWx7rEknNxLSXAsmEKhC3lFJWmv4xMtUe0cegRBdupIsud5jLSxOT1xyTwDD5D
         Cm/UkoKNCWVoYX/u+HEnWJYstecI5Nw5t4O4wiEQnraIAoDxco+dFPhEWS1B6yGKkqE4
         cAHLE8wwxuM0NvLKwCd78Ww5WbmKQ8lTiFX2i083jTEgUTiR8JkyQ8A/m4tB6NJOggt/
         bteQobR9CLCKxCsrbf18VoRu2v+reomCxlIuluLpEopyx7Ss2CQBgr+w7elXuQZb77HK
         o7cQ==
X-Gm-Message-State: AODbwcBByLXxI7J6RVdG2IxzBWDZa9sDoNKjqjnq1HAmGUg78k/+arI0
        ajywkRNbPQT+IDOu48vX+yPNMZC7cOP0ZNk=
X-Received: by 10.36.53.2 with SMTP id k2mr189310ita.71.1494527778674; Thu, 11
 May 2017 11:36:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 11 May 2017 11:35:58 -0700 (PDT)
In-Reply-To: <20170511183109.GC83655@google.com>
References: <20170511091829.5634-1-avarab@gmail.com> <20170511091829.5634-8-avarab@gmail.com>
 <20170511183109.GC83655@google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 11 May 2017 20:35:58 +0200
Message-ID: <CACBZZX4mhhx3i2crQbON-_UEHMBRfw+FHQctiN9gU2pHQrvCng@mail.gmail.com>
Subject: Re: [PATCH 07/29] grep: change non-ASCII -i test to stop using --debug
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 8:31 PM, Brandon Williams <bmwill@google.com> wrote=
:
> On 05/11, =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>> Change a non-ASCII case-insensitive test case to stop using --debug,
>> and instead simply test for the expected results.
>>
>> The test coverage remains the same with this change, but the test
>> won't break due to internal refactoring.
>>
>> This test was added in commit 793dc676e0 ("grep/icase: avoid kwsset
>> when -F is specified", 2016-06-25). It was asserting that the regex
>> must be compiled with compile_fixed_regexp(), instead test for the
>> expected results, allowing the underlying implementation to change.
>>
>> Signed-off-by: =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason <avarab@gmail.com>
>> ---
>>  t/t7812-grep-icase-non-ascii.sh | 25 +++++--------------------
>>  1 file changed, 5 insertions(+), 20 deletions(-)
>>
>> diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-as=
cii.sh
>> index 04a61cb8e0..969e7c0dda 100755
>> --- a/t/t7812-grep-icase-non-ascii.sh
>> +++ b/t/t7812-grep-icase-non-ascii.sh
>> @@ -36,29 +36,14 @@ test_expect_success GETTEXT_LOCALE,PCRE 'grep pcre u=
tf-8 string with "+"' '
>>  '
>>
>>  test_expect_success REGEX_LOCALE 'grep literal string, with -F' '
>> -     git grep --debug -i -F "TILRAUN: Hall=C3=B3 Heimur!"  2>&1 >/dev/n=
ull |
>> -              grep fixed >debug1 &&
>> -     test_write_lines "fixed TILRAUN: Hall=C3=B3 Heimur!" >expect1 &&
>> -     test_cmp expect1 debug1 &&
>> -
>> -     git grep --debug -i -F "TILRAUN: HALL=C3=93 HEIMUR!"  2>&1 >/dev/n=
ull |
>> -              grep fixed >debug2 &&
>> -     test_write_lines "fixed TILRAUN: HALL=C3=93 HEIMUR!" >expect2 &&
>> -     test_cmp expect2 debug2
>> +     git grep -i -F "TILRAUN: Hall=C3=B3 Heimur!" &&
>> +     git grep -i -F "TILRAUN: HALL=C3=93 HEIMUR!"
>>  '
>>
>>  test_expect_success REGEX_LOCALE 'grep string with regex, with -F' '
>> -     test_write_lines "^*TILR^AUN:.* \\Hall=C3=B3 \$He[]imur!\$" >file =
&&
>> -
>> -     git grep --debug -i -F "^*TILR^AUN:.* \\Hall=C3=B3 \$He[]imur!\$" =
2>&1 >/dev/null |
>> -              grep fixed >debug1 &&
>> -     test_write_lines "fixed \\^*TILR^AUN:\\.\\* \\\\Hall=C3=B3 \$He\\[=
]imur!\\\$" >expect1 &&
>> -     test_cmp expect1 debug1 &&
>> -
>> -     git grep --debug -i -F "^*TILR^AUN:.* \\HALL=C3=93 \$HE[]IMUR!\$" =
 2>&1 >/dev/null |
>> -              grep fixed >debug2 &&
>> -     test_write_lines "fixed \\^*TILR^AUN:\\.\\* \\\\HALL=C3=93 \$HE\\[=
]IMUR!\\\$" >expect2 &&
>> -     test_cmp expect2 debug2
>> +     test_write_lines "TILRAUN: Hall=C3=B3 Heimur [abc]!" >file3 &&
>> +     git add file3 &&
>> +     git grep --debug -i -F "TILRAUN: Hall=C3=B3 Heimur [abc]!" file3
>>  '
>
> Your commit message leads me to believe that you are reformatting the
> tests such that you don't use the '--dubug' flag yet this last line uses
> it.  Is this intentional?

Nope, my mistake. Removing it is functionally equivalent (we discard
stderr there). Will queue up a fix locally & send eventually in a v2.

Thanks a lot for looking this giant deluge of patches over.
