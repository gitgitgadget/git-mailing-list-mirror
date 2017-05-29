Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1C020D0A
	for <e@80x24.org>; Mon, 29 May 2017 20:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbdE2Ukf (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 16:40:35 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36388 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbdE2Uke (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 16:40:34 -0400
Received: by mail-it0-f66.google.com with SMTP id i206so7998267ita.3
        for <git@vger.kernel.org>; Mon, 29 May 2017 13:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lmVJeS3ih3dSX/826+HbyhMRL6tU9KxVDT8kSg9MxH4=;
        b=KTBgaPxBuB3p6U1kI63d6KPXO4BtikDQtU3R1fwnKsCs4YoBIfKqiZEQU8oK8zJXz4
         7kRQJkrgBSiW4LAQxTLmDHR6xm+xzN8I/Z7pxi5qZ3OyGkiDObHq9u38btuD6WQrTsd3
         eAAep0LxwkO+5HOEiPOKPHjrU2rRjQZql/9zZ7qlbyyl8sdKIpkCSFWDihkVINf5GWM+
         kCnHh1OU56sRFi+L2vnamZv+VktaM/4FQTCsuoBxX27vmKpH3bpqbqHe21fN581dmaxH
         uIga+Vx/ml2D+0IJnJV7JbJajBvjelJqWAMwyQyBEcTOUz9VtIhDTb08wr2CpJiQ/cnd
         xiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lmVJeS3ih3dSX/826+HbyhMRL6tU9KxVDT8kSg9MxH4=;
        b=dt+g/b/AOBcteEpdvREQexfE3x2u9BN3RDiA1TRtuB8+oHIT5+2ZTm+9rCTRyn4GIs
         qM7t6evQFFToaJmluGmoneABIwQyJbhTuAJzzvnzl8T02FPeVjyhuQmDUG3Kbgy0L1+d
         ru/AH8W2lSnLq4POWyUWTJtOkj3ZCfkIqm8g5cd/nhqSur0xrpzpNE4qZyaVtmZp6CEZ
         zDCTmRqniUrbREq5ea7kJwYJYGqxS305/BMkd4EmbiuJufjBcfOV4QOPmb3PQu4pA+M7
         NINdWlnfKjA2/TUbtqq+nlzwVbXkzeYCU7/OEJYIkT42Nf6aTu2IsZS8K4VX0OGxQ3Bs
         s+zw==
X-Gm-Message-State: AODbwcCf4vx+oq/MLQaZIzBLHgUa2LIuKCZCO2DnemlL1NAlkto2NWgg
        tB+IUsfC+eZP2SAeaqCVoHduZ6zPcQ==
X-Received: by 10.36.53.79 with SMTP id k76mr15350854ita.71.1496090433735;
 Mon, 29 May 2017 13:40:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 29 May 2017 13:40:12 -0700 (PDT)
In-Reply-To: <17b3d445-0cc7-2000-dc67-11fb53c7040b@kdbg.org>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com> <20170526033510.1793-14-gitster@pobox.com>
 <17b3d445-0cc7-2000-dc67-11fb53c7040b@kdbg.org>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 29 May 2017 22:40:12 +0200
Message-ID: <CACBZZX5BgVbUFEwQjHqJVfHFUitTJRaCx-Lg+j7q54uErEpqcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mingw: verify that paths are not mistaken for remote nicknames
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 10:25 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 26.05.2017 um 05:35 schrieb Junio C Hamano:
>> When asked to open/fopen a path, e.g. "a/b:/c", which does not exist
>> on the filesystem, Windows (correctly) fails to open it but sets
>> EINVAL to errno because the pathname has characters that cannot be
>> stored in its filesystem.
>>
>> As this is an expected failure, teach is_missing_file_error() helper
>> about this case.
>>
>> This is RFC, as there may be a case where we get EINVAL from
>> open/fopen for reasons other than "the filesystem does not like this
>> pathname" that may be worth reporting to the user, and this change
>> is sweeping such an error under the rug.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>   wrapper.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/wrapper.c b/wrapper.c
>> index f1c87ec7ea..74aa3b7803 100644
>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -434,6 +434,10 @@ static void warn_on_inaccessible(const char *path)
>>    * see if the errno indicates a missing file that we can safely ignore=
.
>>    */
>>   static int is_missing_file_error(int errno_) {
>> +#ifdef GIT_WINDOWS_NATIVE
>> +     if (errno_ =3D=3D EINVAL)
>> +             return 1;
>> +#endif
>>       return (errno_ =3D=3D ENOENT || errno_ =3D=3D ENOTDIR);
>>   }
>
> I would prefer to catch the case in the compatibility layer. Here is
> a two patch series that would replace your 12/13 and 13/13.
>
> ---- 8< ----
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Subject: mingw: verify that paths are not mistaken for remote nicknames
>
> This added test case simply verifies that users will not be bothered
> with bogus complaints =C3=A0 la
>
>         warning: unable to access '.git/remotes/D:\repo': Invalid argumen=
t
>
> when fetching from a Windows path (in this case, D:\repo).
>
> [j6t: mark the new test as test_expect_failure]
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t5580-clone-push-unc.sh | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
> index b195f71ea9..fd719a209e 100755
> --- a/t/t5580-clone-push-unc.sh
> +++ b/t/t5580-clone-push-unc.sh
> @@ -1,13 +1,19 @@
>  #!/bin/sh
>
> -test_description=3D'various UNC path tests (Windows-only)'
> +test_description=3D'various Windows-only path tests'
>  . ./test-lib.sh
>
>  if ! test_have_prereq MINGW; then
> -       skip_all=3D'skipping UNC path tests, requires Windows'
> +       skip_all=3D'skipping Windows-only path tests'
>         test_done
>  fi
>
> +test_expect_failure 'remote nick cannot contain backslashes' '
> +       BACKSLASHED=3D"$(pwd | tr / \\\\)" &&
> +       git ls-remote "$BACKSLASHED" >out 2>err &&
> +       ! grep "unable to access" err
> +'

Doesn't this need test_i18ngrep?:

    wrapper.c:581:  warning_errno(_("unable to access '%s'"), path);
    wrapper.c:602:          die_errno(_("unable to access '%s'"), path);

Or is it one of these, which isn't translated:

    http-push.c:1531:               error("unable to access '%s': %s",
url, curl_errorstr);
    remote-curl.c:319:              die("unable to access '%s': %s",
url.buf, curl_errorstr);


> +
>  UNCPATH=3D"$(pwd)"
>  case "$UNCPATH" in
>  [A-Z]:*)
> --
> 2.13.0.55.g17b7d13330
