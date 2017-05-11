Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C985201A4
	for <e@80x24.org>; Thu, 11 May 2017 20:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932730AbdEKUd0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 16:33:26 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35045 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932574AbdEKUdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 16:33:25 -0400
Received: by mail-it0-f67.google.com with SMTP id 67so4218070itx.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 13:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yC2K/PzSXzTCHWN+uQr3kfROI5NeLSs1t05uy0BDbbI=;
        b=Hf2/5BCI8tVGdF1w5Hk2lCdV4zG+5QCva5GvGp2nZiJyUqA87Fx9qJ+cD6lKq2q5tj
         X4HKlP79Q+pmxR3I5CQukAdc6iQnGuWZqysQyRaqKOhiio6jA1/OGx5howY2FAo9EKD8
         eVUIOa9gdXMYMNwCG2XJR74Lmi/8SMY6iQATfSJmUnx40OLEEMxIjCd157TU7LzNI39d
         yPrRrr6sZ5+6xbSFgMNYpddUR/eXJoei0JGbDpbX/SBeDd0VV3DlD87EcAdDYW17vsXk
         W3aJaKQD7A27uB5K0Pj/BZsreQCBJGMORY4xT71GlUewzDX/JZbLa9QXh8Qoe+JnKGUC
         AY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yC2K/PzSXzTCHWN+uQr3kfROI5NeLSs1t05uy0BDbbI=;
        b=Pvl9q/VQWlzknFHOigqWxQn7fYsLp15q+IO7ouwY3+e2ihoEXgc25heChTYijfZmYz
         KdEbOo3tMuRFBIMTTFmejpEXMk5TTVnNtfUidQwXvTBie+w+617VAaMqPuY/XjbpDq9w
         8hjKsmnTYaZJ3qsXd4HmfUtG9jAcee/9pMuY6zq6/OlJJXiDTYW5KAHneQnh4txPjkE8
         cTP8lxvypADNCGk9kHiUwgyyk+eTXH88/PgzfTaYGS4Vrulu6ROLA80PAlvDvQHq7W4v
         iDUxKFGATzB/sL2TRk4qZRBbbswL85NCN6YkwPkSX9od5QcyB3iXUC0JpL3wGALsobuP
         d4SA==
X-Gm-Message-State: AODbwcAiot8NHUV7UYJ83wu90tGOUuqogrY0P4fdUpFYYi4L2Icp62qB
        M7La+GRIE/p5QZytWu8GuSjO01vhLg==
X-Received: by 10.36.37.78 with SMTP id g75mr432954itg.94.1494534804775; Thu,
 11 May 2017 13:33:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 11 May 2017 13:33:04 -0700 (PDT)
In-Reply-To: <20170511202131.GK83655@google.com>
References: <20170511091829.5634-1-avarab@gmail.com> <20170511091829.5634-29-avarab@gmail.com>
 <20170511202131.GK83655@google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 11 May 2017 22:33:04 +0200
Message-ID: <CACBZZX5-oDsMh08KNiEp8mDbCH06ROozc7sekts4BRsm-dTOwg@mail.gmail.com>
Subject: Re: [PATCH 28/29] grep: given --threads with NO_PTHREADS=YesPlease, warn
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

On Thu, May 11, 2017 at 10:21 PM, Brandon Williams <bmwill@google.com> wrot=
e:
> On 05/11, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Add a warning about missing thread support when grep.threads or
>> --threads is set to a non 0 (default) or 1 (no parallelism) value
>> under NO_PTHREADS=3DYesPlease.
>>
>> This is for consistency with the index-pack & pack-objects commands,
>> which also take a --threads option & are configurable via
>> pack.threads, and have long warned about the same under
>> NO_PTHREADS=3DYesPlease.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/grep.c  | 11 +++++++++++
>>  t/t7810-grep.sh | 18 ++++++++++++++++++
>>  2 files changed, 29 insertions(+)
>>
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index 1c0adb30f3..f4e08dd2b6 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -289,6 +289,15 @@ static int grep_cmd_config(const char *var, const c=
har *value, void *cb)
>>               if (num_threads < 0)
>>                       die(_("invalid number of threads specified (%d) fo=
r %s"),
>>                           num_threads, var);
>> +#ifdef NO_PTHREADS
>> +             else if (num_threads && num_threads !=3D 1) {
>> +                     /* TRANSLATORS: %s is the configuration
>> +                        variable for tweaking threads, currently
>> +                        grep.threads */
>
> nit: this comment isn't formatted properly:
>   /*
>    * ... comment ...
>    */

Comments for translators use a different style, see cbcfd4e3ea ("i18n:
mention "TRANSLATORS:" marker in Documentation/CodingGuidelines",
2014-04-18). Otherwise the "*" gets interpolated into the string the
translators see in their UI.

>> +                     warning(_("no threads support, ignoring %s"), var)=
;
>> +                     num_threads =3D 0;
>> +             }
>> +#endif
>>       }
>>
>>       return st;
>> @@ -1233,6 +1242,8 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
>>       else if (num_threads < 0)
>>               die(_("invalid number of threads specified (%d)"), num_thr=
eads);
>>  #else
>> +     if (num_threads)
>> +             warning(_("no threads support, ignoring --threads"));
>>       num_threads =3D 0;
>>  #endif
>>
>> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
>> index 561709ef6a..f106387820 100755
>> --- a/t/t7810-grep.sh
>> +++ b/t/t7810-grep.sh
>> @@ -791,6 +791,24 @@ do
>>       "
>>  done
>>
>> +test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'grep --threads=3DN or pa=
ck.threads=3DN warns when no pthreads' '
>> +     git grep --threads=3D2 Hello hello_world 2>err &&
>> +     grep ^warning: err >warnings &&
>> +     test_line_count =3D 1 warnings &&
>> +     grep -F "no threads support, ignoring --threads" err &&
>> +     git -c grep.threads=3D2 grep Hello hello_world 2>err &&
>> +     grep ^warning: err >warnings &&
>> +     test_line_count =3D 1 warnings &&
>> +     grep -F "no threads support, ignoring grep.threads" err &&
>> +     git -c grep.threads=3D2 grep --threads=3D4 Hello hello_world 2>err=
 &&
>> +     grep ^warning: err >warnings &&
>> +     test_line_count =3D 2 warnings &&
>> +     grep -F "no threads support, ignoring --threads" err &&
>> +     grep -F "no threads support, ignoring grep.threads" err &&
>> +     git -c grep.threads=3D0 grep --threads=3D0 Hello hello_world 2>err=
 &&
>> +     test_line_count =3D 0 err
>> +'
>> +
>
> Same bit about doing the correct checks on the error strings to account
> for translation.

Do you mean why not use test_i18ngrep? The test is guarded by
C_LOCALE_OUTPUT which does the same thing, the whole thing is testing
output so no point in doing just parts of it IMO, unlike some other
tests that just end in "let's compare the output" but actually test
other stuff.

I could e.g. test that there's something on stderr under poison, but
no point in doing so.

>>  test_expect_success 'grep from a subdirectory to search wider area (1)'=
 '
>>       mkdir -p s &&
>>       (
>> --
>> 2.11.0
>>
>
> --
> Brandon Williams
