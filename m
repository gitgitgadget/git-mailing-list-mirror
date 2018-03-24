Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2BFC1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 04:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750785AbeCXEXP (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 00:23:15 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43816 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbeCXEXP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 00:23:15 -0400
Received: by mail-ot0-f194.google.com with SMTP id m22-v6so15436490otf.10
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 21:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hackers-mu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CCJlzpoMliAtdWKcwTV81Ux4joz7L8fp0h91jiYo7vc=;
        b=gSKkfAhi+wXVWP1vsISJj+R5f0scO6gJ/eis+VrmWkAPbul/zstARhvXudLTBllphd
         cAb1etsdHa8Yx6qt1rfqPaLAiv34EQ/JeW1xPGEZTQYf1LJ96cUbCUPoQTG8J9VvBVKR
         SVokjB9lbhpxJxlX+pdaG/wxvKadZWo+DOlxEIm7ANenDvfAl3P70QvU5orJTRHjeXVF
         5GWDOo+18GmcLk2U0z/AvbnFvWMXTgxhQFlTCdQUhQb7mtdguz6LUtH88Xu7eOVtCjQi
         T+DdLG25lvIe8oOQKqZJVT6rvTwhahMHfiRDTri8b9VlcLU6igl1ArDFNo5ASjiGU/79
         39Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CCJlzpoMliAtdWKcwTV81Ux4joz7L8fp0h91jiYo7vc=;
        b=TGqvjKOIHfNRX509RlYouPgzF3RKeM0tvZvIMf34aaQ6W74hpIFV82YYdIyuk5iiGh
         9L8QRLyuKDRnGeN0cARRLu6/G4r7V2rva5eYbTfYgmc4Cr4Ye5bm8HBWv18f1HtEJnMw
         wdLSjj3kQACMN89SfbVt7fBnGSYsx6p+fBcsHJeOBtyS/62zv/ABTRoLUuNB5p/tTqef
         v9gYs/NSHzuUyzD3JWPs4cMPhjQBQCgRv6c9PLWEDEgc/d21lwHGWb+v4DCmukRpHQA9
         xkYIO4GUfXaKhpF/KtUdxldRdDo3555Afyn+r9jDIBNRWjtL0kYdofm5TJmlOloXQjsW
         8f8A==
X-Gm-Message-State: AElRT7EBia+lZI4NjXvgYAchPH+O/SDQlYmyZpy/rDT9Xdhe7FPJKXDM
        hW1zEozdcNa76bH9HSDz5SPJJbr4Vglta9TUeY6sNw==
X-Google-Smtp-Source: AG47ELun1KwcdDdhjVYJ1B7iBYd3t4tRaeb5GqK4wJznEEuFZj+3s088aDeQi2YH4DOjreSXL+rLCadeYXqGnTCqILE=
X-Received: by 2002:a9d:2fac:: with SMTP id r41-v6mr15476639otb.314.1521865394482;
 Fri, 23 Mar 2018 21:23:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.197.137 with HTTP; Fri, 23 Mar 2018 21:23:14 -0700 (PDT)
In-Reply-To: <xmqqy3iih2xi.fsf@gitster-ct.c.googlers.com>
References: <20180323193435.GA21971@voidlinux> <xmqqy3iih2xi.fsf@gitster-ct.c.googlers.com>
From:   Loganaden Velvindron <logan@hackers.mu>
Date:   Sat, 24 Mar 2018 08:23:14 +0400
Message-ID: <CAFDEUTfMk+9mfJoX+116eW-e2o_rBiVeDZ1dfEbxaLGLign1AQ@mail.gmail.com>
Subject: Re: [PATCH v2] Allow use of TLS 1.3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 1:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Loganaden Velvindron <logan@hackers.mu> writes:
>
>> Subject: Re: [PATCH v2] Allow use of TLS 1.3
>
> Let's retitle it to something like
>
>         Subject: [PATCH v2] http: allow use of TLS 1.3
>
>> Add a tlsv1.3 option to http.sslVersion in addition to the existing
>> tlsv1.[012] options. libcurl has supported this since 7.52.0.
>
> Good.
>
>>
>> Done during IETF 101 Hackathon
>
> I am on the fence wrt the value of this line, especially because I
> would strongly suspect that this version is not what you wrote and
> tested during your Hackathon.  Even if it were, would it give value
> to future "git log" readers by supplying extra context?
>

Will remove this line.

>> Signed-off-by: Loganaden Velvindron <logan@hackers.mu>
>> ---
>>  Documentation/config.txt | 2 +-
>>  http.c                   | 3 +++
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index ce9102cea..b18cb9104 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1957,7 +1957,7 @@ http.sslVersion::
>>       - tlsv1.0
>>       - tlsv1.1
>>       - tlsv1.2
>> -
>> +     - tlsv1.3
>>  +
>
> Before this change, the block that shows the list of versions had
> one blank line before and after it.  Now we lost the blank line
> after the block.  Is it intended?  Possibilities that come to my
> mind as a reviewer are:
>
>  A. There is no difference in the rendered output if we have zero
>     blank line (i.e. with the patch), or one blank line (i.e. before
>     the patch applied).
>
>     A.1) the submitter made this change on purpose, because it will
>     make the source shorter without affecting the output, as a
>     "clean-up while at it" change.
>
>     A.2) this was an accidental change, which did not break the
>     output merely because the submitter was lucky.
>
>  B. The rendered output changes due to the lack of the blank line.
>
>     B.1) And it changes in a good way.  The submitter made this
>     change on purpose.
>
>     B.2) And it changes in a bad way, but the submitter did not
>     notice it.
>
> Please do not make reviewers wonder.  Either avoid making
> unnecessary changes (e.g. you could have just added a new line with
> tlsv1.3 on it without touching the blank line), or make the change
> and explain why you made that change that is not essential for the
> purpose of adding tls1.3 which is the main focus of this patch.

Alright.

>
>>  Can be overridden by the `GIT_SSL_VERSION` environment variable.
>>  To force git to use libcurl's default ssl version and ignore any
>> diff --git a/http.c b/http.c
>> index a5bd5d62c..25eb84c11 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -62,6 +62,9 @@ static struct {
>>       { "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
>>       { "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
>>  #endif
>> +#ifdef CURL_SSLVERSION_TLSv1_3
>> +     { "tlsv1.3", CURL_SSLVERSION_TLSv1_3 }
>> +#endif
>>  };
>
> It seems to me that
>
>     https://github.com/curl/curl/blob/master/include/curl/curl.h#L1956
>
> tells me that this #ifdef would not work.  Did you test it with the
> "test not version but feature" change you made at the last minute?

I compiled it.

>
> I know it is not your fault but is =C3=86var's, but you're responsible
> for double-checking what you are told on the internet ;-)

Yes, my fault, not =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason .


>
> Thanks.
