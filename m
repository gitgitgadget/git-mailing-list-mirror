Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FFDE20188
	for <e@80x24.org>; Sat, 13 May 2017 18:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbdEMSDL (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 14:03:11 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34633 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752541AbdEMSDK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 14:03:10 -0400
Received: by mail-it0-f68.google.com with SMTP id c26so8658622itd.1
        for <git@vger.kernel.org>; Sat, 13 May 2017 11:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ob5TXwaMA0NxJiraPGqd/HYBvqIVPNKfj/46snf5/dI=;
        b=FkwXVME6zLwc0TCnmDJvf2QLq8r9r1VX0L/o5T30amNXX9TQncuKFNKUz0oZfffWY2
         +W0eoFwEXik3+zzYiCQEqRlgxg2evcEoQl8XSg4nLRNMwloSFp4W6kxxTgh0REe8td4i
         Jc5OK5pCPqrLskR5IYtyt6u9q0aHsNw/6fvnrJ0H/svxUFWeIMHQtiznZLu5kJxGaQWU
         ufY2p6FAIx8j00pIzQ/KWtVzsGfvblq0a+/CugaIfm24mHZwiHq6GLOgvh5r1CwBgh0t
         1ITg/yAzC82M9wvAK5bujIV4/xdzWTwdzV9RpIzAXttZj3UqHo6J2jaMGLZIp3oVjJVj
         +fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ob5TXwaMA0NxJiraPGqd/HYBvqIVPNKfj/46snf5/dI=;
        b=f/GknAjLWB/7qx5XZFUUJxsk9tCf+eZygKY+OVbgxBlDPMTNuuuMW0MMkOMM0SJpP2
         cTOww88TWZSRbTqGog+uQoNSDWJiejl5fgLfnDSEiolLkf4ukRGm+lcLJqjBlU49gQso
         bqXBfPbWCVPBjNJjHTrmGOvA/ALGRX4cHzz/c37fVEjiQ3m+ppAvbtxX/oFrvKrIqUj8
         Hb/BIP6EOjp2kMRluqcwucJ8n+1Z6V/JMpfciRgrkBXH0jG6IRjg+dlSYiR4Wva0Q966
         bbrAiMovZpvzqNA/E0eZYH3N8/3yuGSv/e75Cmhdi8Jdr44SKHZpc9sYfBKcdUZFpGU8
         duPg==
X-Gm-Message-State: AODbwcApLvSH5q4sQet8d3e3fB32gf3eDl7a12kh5iMqusmriWKnhv0H
        3RQadiukrtfj7uX7x0AqWvsT8K/3s3ak4Es=
X-Received: by 10.36.53.2 with SMTP id k2mr9549673ita.71.1494698589829; Sat,
 13 May 2017 11:03:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sat, 13 May 2017 11:02:49 -0700 (PDT)
In-Reply-To: <xmqqwp9m7k9z.fsf@gitster.mtv.corp.google.com>
References: <20170511091829.5634-1-avarab@gmail.com> <20170511091829.5634-5-avarab@gmail.com>
 <xmqqwp9m7k9z.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 13 May 2017 20:02:49 +0200
Message-ID: <CACBZZX5JDg7Ntpjc-J-jtei7jJthd0+gkSEONsWCx3Mfqeu8mA@mail.gmail.com>
Subject: Re: [PATCH 04/29] log: add exhaustive tests for pattern style options
 & config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 6:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Add exhaustive tests for how the different grep.patternType options &
>> the corresponding command-line options affect git-log.
>> ...
>> The patterns being passed to fixed/basic/extended/PCRE are carefully
>> crafted to return the wrong thing if the grep engine were to pick any
>> other matching method than the one it's told to use.
>
> That is good; it may be even more helpful to the readers if they are
> given a brief in-code comment.  I had to scratch head while reading
> them.
>
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/t4202-log.sh | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++-
>>  1 file changed, 76 insertions(+), 1 deletion(-)
>>
>> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
>> index f577990716..6d1411abea 100755
>> --- a/t/t4202-log.sh
>> +++ b/t/t4202-log.sh
>> @@ -262,7 +262,23 @@ test_expect_success 'log --grep -i' '
>>
>>  test_expect_success 'log -F -E --grep=3D<ere> uses ere' '
>>       echo second >expect &&
>> -     git log -1 --pretty=3D"tformat:%s" -F -E --grep=3Ds.c.nd >actual &=
&
>         # BRE would need \(s\) to do the same.
>> +     git log -1 --pretty=3D"tformat:%s" -F -E --grep=3D"(s).c.nd" >actu=
al &&
>> +     test_cmp expect actual
>> +'
>> +
>> +test_expect_success PCRE 'log -F -E --perl-regexp --grep=3D<pcre> uses =
PCRE' '
>> +     test_when_finished "rm -rf num_commits" &&
>> +     git init num_commits &&
>> +     (
>> +             cd num_commits &&
>> +             test_commit 1d &&
>> +             test_commit 2e
>> +     ) &&
>> +     echo 2e >expect &&
>         # In PCRE \d in [\d] is like saying "0-9", and match '2' in 2e
>> +     git -C num_commits log -1 --pretty=3D"tformat:%s" -F -E --perl-reg=
exp --grep=3D"[\d]" >actual &&
>> +     test_cmp expect actual &&
>> +     echo 1d >expect &&
>         # In ERE [\d] is bs or letter 'd' and would not match '2' in '2e'
>         # but does match 'd' in '1d'
>> +     git -C num_commits log -1 --pretty=3D"tformat:%s" -F -E --grep=3D"=
[\d]" >actual &&
>>       test_cmp expect actual
>>  '
>>
>> @@ -280,6 +296,65 @@ test_expect_success 'log with grep.patternType conf=
iguration and command line' '
>>       test_cmp expect actual
>>  '
>>
>> +test_expect_success 'log with various grep.patternType configurations &=
 command-lines' '
>> +     git init pattern-type &&
>> +     (
>> +             cd pattern-type &&
>> +             test_commit 1 file A &&
>> +             test_commit "(1|2)" file B &&
>> +
>> +             echo "(1|2)" >expect.fixed &&
>> +             cp expect.fixed expect.basic &&
>> +             cp expect.fixed expect.extended &&
>> +             cp expect.fixed expect.perl &&
>> +
>                 # Fixed finds these literally
>> +             git -c grep.patternType=3Dfixed log --pretty=3Dtformat:%s =
\
>> +                     --grep=3D"(1|2)" >actual.fixed &&
>                 # BRE matches (, |, and ) literally
>> +             git -c grep.patternType=3Dbasic log --pretty=3Dtformat:%s =
\
>> +                     --grep=3D"(.|.)" >actual.basic &&
>                 # ERE needs | quoted with bs to match | literally
>> +             git -c grep.patternType=3Dextended log --pretty=3Dtformat:=
%s \
>> +                     --grep=3D"\|2" >actual.extended &&
>
> If we use BRE by mistake, wouldn't this pattern actually find
> "(1|2)" anyway, without skipping it and show "1 file A" instead?

It'll find (1|2) but also 1, i.e.:

$ (echo 1; echo "(1|2)") >/tmp/f; for t in G E; do echo $t: && grep
-$t '\|2' /tmp/f | sed 's/^/  /'; done
G:
  1
  (1|2)
E:
  (1|2)

So the test will fail under basic. I'll add comments about this & the
other things you suggested.

>> +             if test_have_prereq PCRE
>> +             then
>> +                     git -c grep.patternType=3Dperl log --pretty=3Dtfor=
mat:%s \
>> +                             --grep=3D"[\d]\|" >actual.perl
>                         # Only PCRE would match [\d]\| with "(1|2)" due t=
o [\d]
>> +             fi &&
>> +             test_cmp expect.fixed actual.fixed &&
>> +             test_cmp expect.basic actual.basic &&
>> +             test_cmp expect.extended actual.extended &&
>> +             if test_have_prereq PCRE
>> +             then
>> +                     test_cmp expect.perl actual.perl
>> +             fi &&
>
> It could be just a style thing, but I would actually find it easier
> to follow if the above two "only with PCRE" tests, i.e. running test
> and taking its output in actual.perl and comparing it with
> expect.perl, were inside a single "if test_have_prereq PCRE" block.

Sure, will fix.
