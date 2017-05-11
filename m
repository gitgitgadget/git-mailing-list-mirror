Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD116201A0
	for <e@80x24.org>; Thu, 11 May 2017 19:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756348AbdEKTXF (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 15:23:05 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:32875 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756330AbdEKTXE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 15:23:04 -0400
Received: by mail-it0-f67.google.com with SMTP id l145so3206179ita.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 12:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/3lqOEVOqXE8XKq4Xwms45kaBdMLScebcLrpo3uPqqg=;
        b=VUxQlHav/dhEIGxCK/MGEGKSK8dbitcgPRtS+nNgC4/8uMkiw61dMZ6lmlARb0dwBb
         grN1NqV7JRpAloJTPVPm2uCvjL+ZYhkY2+dKOvm096GdZ3PixhXjwX1J7rR49oxrBsaK
         i30NFNNhXUd7rLBazNSuOmfdrW3Ni3dFgYC5sshCk/ZB5HrTfvVDnuZBvhCH7PFXLkO9
         cQT/YjL2tjBeLt6+rC8yJ9hKEqTOtIdsJ10HuuDMoxKJg7Q6UV4KZC8gKrM/uWWF59RH
         Afmzo6Xbj7nH1YA0cIEFfuZCszEexZw3fGsWcjHHXu5rVmHV/j/RUwrylgPLn7Rel7T0
         QrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/3lqOEVOqXE8XKq4Xwms45kaBdMLScebcLrpo3uPqqg=;
        b=YrUkcjswFusQ1r2uxbnQgAQFCOba4SsdoAS/f4UJUIHT7Qug8vWp1sgp1fbljb9kET
         iAMSSlhH+nFwWkeNTDrVs93X6cVsa7M/f5e+YSBdRt+H1vGk9FozCsfRe4ZqxpORaMYo
         AUgzLS3OiSI+gMt7wKTP4o5N91gr93JftzDVOuxQZbv5SCSPi94KOLTX0M8Lea/9NOVg
         9y7gXKWuiRT8AReyga87+kNdTSz+0U6uQCs48KDNzOWmKnNQ+GocrJc0c1Vf0C4HSRRX
         AkqmNxLUG6OxYKmek03LLSgPqxWyfcOdONAr7qDkb0ClkkySr8QfHOG5H/Vad9FAzkam
         8fLQ==
X-Gm-Message-State: AODbwcCR0v6LE9okKq/NY/JNZ7VNAkbSN8DMsxXNaY0N7hfM8S9R11Qt
        xQH1+gyXMChj/652vlAU9cPSCCUbPw==
X-Received: by 10.36.89.207 with SMTP id p198mr422653itb.71.1494530583344;
 Thu, 11 May 2017 12:23:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 11 May 2017 12:22:42 -0700 (PDT)
In-Reply-To: <20170511183640.GD83655@google.com>
References: <20170511091829.5634-1-avarab@gmail.com> <20170511091829.5634-9-avarab@gmail.com>
 <20170511183640.GD83655@google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 11 May 2017 21:22:42 +0200
Message-ID: <CACBZZX5gK__1dGZRkdb=Uj40igHSkpscaNVZvWpuuUFguynLfg@mail.gmail.com>
Subject: Re: [PATCH 08/29] grep: add tests for --threads=N and grep.threads
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

On Thu, May 11, 2017 at 8:36 PM, Brandon Williams <bmwill@google.com> wrote=
:
> On 05/11, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Add tests for --threads=3DN being supplied on the command-line, or when
>> grep.threads=3DN being supplied in the configuration.
>>
>> When the threading support was made run-time configurable in commit
>> 89f09dd34e ("grep: add --threads=3D<num> option and grep.threads
>> configuration", 2015-12-15) no tests were added for it.
>>
>> In developing a change to the grep code I was able to make
>> '--threads=3D1 <pat>` segfault, while the test suite still passed. This
>> change fixes that blind spot in the tests.
>>
>> In addition to asserting that asking for N threads shouldn't segfault,
>> test that the grep output given any N is the same.
>>
>> The choice to test only 1..10 as opposed to 1..8 or 1..16 or whatever
>> is arbitrary. Testing 1..1024 works locally for me (but gets
>> noticeably slower as more threads are spawned). Given the structure of
>> the code there's no reason to test an arbitrary number of threads,
>> only 0, 1 and >=3D2 are special modes of operation.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/t7810-grep.sh | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
>> index daa906b9b0..561709ef6a 100755
>> --- a/t/t7810-grep.sh
>> +++ b/t/t7810-grep.sh
>> @@ -775,6 +775,22 @@ test_expect_success 'grep -W with userdiff' '
>>       test_cmp expected actual
>>  '
>>
>> +for threads in $(test_seq 0 10)
>> +do
>> +     test_expect_success "grep --threads=3D$threads & -c grep.threads=
=3D$threads" "
>> +             git grep --threads=3D$threads . >actual.$threads &&
>> +             if test $threads -ge 1
>> +             then
>> +                     test_cmp actual.\$(($threads - 1)) actual.$threads
>> +             fi &&
>> +             git -c grep.threads=3D$threads grep . >actual.$threads &&
>> +             if test $threads -ge 1
>> +             then
>> +                     test_cmp actual.\$(($threads - 1)) actual.$threads
>> +             fi
>> +     "
>> +done
>> +
>
> Is there a test condition to require PTHREADS?  Otherwise this might
> break if git is compiled with NO_PTHREADS.

Good catch, this test works and I'll leave it like it is in a v2, but
explain it better in the commit message.

We just ignore --threads=3D with NO_PTHREADS, however later in this
series I introduce a warning for --threads when no threads are
supported, see "grep: given --threads with NO_PTHREADS=3DYesPlease,
warn".

But --threads=3DN still works, so this as a side-benefit tests that
--threads=3DN still works with NO_PTHREADS, and tests don't fail if we
spew to stderr.

The commit that adds the warning then tests for --threads getting a
warning with NO_THREADS=3DY.
