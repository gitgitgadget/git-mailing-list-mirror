Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C1841F406
	for <e@80x24.org>; Thu, 11 Jan 2018 09:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754705AbeAKJZw (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 04:25:52 -0500
Received: from mail-ot0-f169.google.com ([74.125.82.169]:36270 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754475AbeAKJZt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 04:25:49 -0500
Received: by mail-ot0-f169.google.com with SMTP id w4so1580872otg.3
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 01:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PUmNQdh9S/to4AKeZCFT5gacB+J9SV5POgg825zilmQ=;
        b=OKUWWwcCYsnWWqDSlcGRq28O1Dcm3LX+SaOgA5iwueU9roIYYwFsaSFvwCe36N0Ise
         0P5xOwWBOeqLXKt33NKn5o7460wIfom7wgnzN+FB33pEPTBml8LhG0m9cDHZ2PcqCFOk
         kRdevlLixn8TDziuP03PakirkuX8NnJl0kLWiezSDz/cWR6LtHyZnLR5n89NNETcnXRy
         SFV30n3RK8ntG6XDWB8BfVecKVMhYIQBGCAfxKQ+P9jqA87w/woRKFH8zHF+gEqzxih3
         kX+RAlCAC0uy8/Ikarz0iouYAHFbS+K6zssBEaKqgQ9DQeo+w1unIB1hkpQJcHwxBwy4
         1iGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PUmNQdh9S/to4AKeZCFT5gacB+J9SV5POgg825zilmQ=;
        b=WTQxg7jpknviagSF79KK+xtYHrSI+DEtAFcaOEKJca8cAZsdQHbEjK8VDUHS50Nmcz
         yV3FVi5VyGZdMl18hLLa66CW9ka7Kkbewv/x0c7WzJ2wI+YpXtJDV92LWHErd0ImI2fn
         s8ceFkovoa+MFe4LA75IUZXMU2ey0ob/Ga89O9GOAKkuI8o2TA20HCrQFvgZuSobNN23
         NHS0scB1QIjJFFI4iKRobwXjX/VQoIAUmKxhQjN4gk+XwTaeoWZOMhwaBcORUt9JL2HB
         +WFbIuQb4ZVhaUJGOzBEgMlHFuv5Yoq4AYTzCvttQG8BVuXKrjKXm4Fd/0TY3u7AWqBZ
         D+Fw==
X-Gm-Message-State: AKwxytccxNAF7ObPNacJ9eIBCJlm9Qppt7+CiHWlvYiz4zYpnOj8k13G
        /OksTjGSPIGeqIuly6XEG3pfcVkDeMZ9FTsy76Y=
X-Google-Smtp-Source: ACJfBoseT6z/MdKU06u+hYDGqmtmj9bWzTeNr3qo4SUDqULxr8oCPRRFwUuu18X/IL/P4MxlDVXOKJvy/cVy00/EDt8=
X-Received: by 10.157.87.133 with SMTP id q5mr2796785oth.106.1515662749091;
 Thu, 11 Jan 2018 01:25:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Thu, 11 Jan 2018 01:25:18 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1801102057110.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <nycvar.QRO.7.76.6.1801052133380.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
 <20180105221222.28867-1-avarab@gmail.com> <xmqqzi5raogu.fsf@gitster.mtv.corp.google.com>
 <nycvar.QRO.7.76.6.1801061337020.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
 <CACsJy8CDz57RR+VHpaPb5YMhKG5kUgb9rt5TWKL8n+e7Xart3g@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801081319520.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180110090724.GA2893@ash> <nycvar.QRO.7.76.6.1801102057110.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 11 Jan 2018 16:25:18 +0700
Message-ID: <CACsJy8CZY0F2AkBMEQPNkJ+8FTjV4+4PqijiFBHSCJ4Vc1572g@mail.gmail.com>
Subject: Re: [PATCH v4 8/7] wildmatch test: skip file creation tests on
 Windows proper
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 11, 2018 at 3:24 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> diff --git a/Makefile b/Makefile
>> index 2a81ae22e9..567387b558 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -644,6 +644,7 @@ X =3D
>>
>>  PROGRAMS +=3D $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
>>
>> +TEST_PROGRAMS_NEED_X +=3D test-3071-wildmatch
>
> I guess I can always work on unifying those gazillion of test executables
> into a single one later.

Oh yeah. I did notice your remark about disk consumption but this was
a quick hack that I would not bother with it. For the record I'm
slightly bothered with many test programs too, not due to disk size
but because it increases link time (disk i/o probably also plays part
in that). This may help another thing... at the end of the mail

>> +static struct match_input match_tests[] =3D {
>> +     /* Basic wildmatch features */
>> +     { 1, "foo", "foo" },
>> +     { 0, "foo", "bar" },
>> +     { 1, "", "" },
>
> These patterns share the "magic-ness" of =C3=86var's test cases... althou=
gh
> your version is certainly more concise.

Another thing will make me move away from this style is, you can't
mark one test broken. In the end, we may have some macro that issue
one match() call per line, very similar to how t3070 does now. Then we
have more freedom in marking tests.

> BTW IIRC =C3=86var explicitly said that he needs to use `ls-files` in ord=
er to
> test the interaction with the index, so that would probably take a little
> bit more work.

Yeah, run_command() and stuff, not super hard (but then it opens up
another aspect I didn't address in this quick hack: collecting output
log of a test and only showing it when the test fails, could be
tricker to do in C than shell.

>> diff --git a/t/t3071-wildmatch.sh b/t/t3071-wildmatch.sh
>> new file mode 100755
>> index 0000000000..6e83b4d684
>> --- /dev/null
>> +++ b/t/t3071-wildmatch.sh
>> @@ -0,0 +1,3 @@
>> +#!/bin/sh
>> +
>> +exec helper/test-3071-wildmatch t3071-wildmatch "$@"
>
> Should it not be `exec test-3071-wildmatch "${0%.sh}" "$@"`?

No, test-lib.sh is required to set up $PATH properly so you can run
test programs without path. This is another sticky point. Some
integration with test-lib.sh is needed. I would like to have something
like this

-- 8< --
cat >t3071-wildmatch-c.sh <<EOF
#!/bin/sh
. ./test-lib.sh
EOF
-- 8< --

and test-lib.sh will take care of finding the right program, passing
the right test name as argument... (a single test program covering all
test groups, rather than one binary per test group, would simplify
things here). We need something though to let test-lib.sh know this is
C-based not shell to activate this mode. The "-c" suffix in the file
name is for that purpose, but maybe we will figure out something
better later. If it's too magical, this would do

-- 8< --
cat >t3071-wildmatch.sh <<EOF
#!/bin/sh

. ./test-lib.sh

exec_c_tests # new function defined in test-lib.sh
EOF
-- 8< --
--=20
Duy
