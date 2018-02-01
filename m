Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7981F1F404
	for <e@80x24.org>; Thu,  1 Feb 2018 20:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754974AbeBAUYh (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 15:24:37 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36726 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754957AbeBAUYf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 15:24:35 -0500
Received: by mail-yw0-f194.google.com with SMTP id q6so11472613ywg.3
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 12:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Uuwh2CvPzO4zCJycFR4oDsJi4yDYTfnFnknD1H7BdxU=;
        b=eie01OaKOxgCXhNnI9fhY4/EGd+ifm0Uxynoulh4vdQ8U1j+iPGD7jHoYOABT7Ndwj
         svCiS666XQ/nr22WRguGcbvlVMgUK+aaktXAM9grBI2HeeMjHYmP16Me+5qVKrfjaR79
         74tqZtTTwoHXFYB7GvRo1tdAd7DcnkJrXKc+KLl06Z71NPSF6ZGI4vCA5jYJfeGXWs4f
         SQNsklcT59f6Ze6uTr9CS5htUS0BEDbMu+4GtA3WE6qjxszECNZqKy3yHF4YfF3G8J5r
         OltzkhTVHK9wk+PMHzToAJ/2ZCE4kCA/UgGr6/0E8leTYYDcCBdmSDT2dPo/yVEzkfoP
         VRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Uuwh2CvPzO4zCJycFR4oDsJi4yDYTfnFnknD1H7BdxU=;
        b=dZrzyVcuCzWW+2QPxfIs9FKbQwpRpD837Ok+9jBuVVCdG1s0DP1iT6R5qNWlidTDIj
         1Ve4/S/CSX6TnhZa3AMFxmBruuMgz1SASl12uNA6Dy+fS5QsPvkizdArDQ8P4QXtln/n
         CeFQFha11IhEUDKfY5rCPoQx4bUHOgPWW6u99OSDNqeBBECvTx4ehK34WY9r65tq9M91
         N0QtDNvUX4opEkWRxfjb8L/1Xr2c1vk3svO33wjQpZdfS3btGyjitSp5ncm4LkWu0P7z
         o0Hpfsvhe7rWhcSu5sGg2q4zR2vVAq0ZYYv9cExAdBP8RizqAgjQf1gTR7v+tvM/q3/b
         7DnQ==
X-Gm-Message-State: AKwxytca042vQfdlYuZa1JdTFfGtvjdcDlrGE/zapOQaKcACsjVb05xE
        Ahi6Wp4VUIi4/E0aose+MYvLS8/BRunoialY23PjX78aE/0=
X-Google-Smtp-Source: AH8x227a4SjxRrVxShrA9HW5zH6xq+kflqraqU1KTJBn2Yw1UrRotT8LGrGO5yzdQxHlXi2S5a6Z6lbQMDt+JM0jm6g=
X-Received: by 10.129.108.196 with SMTP id h187mr25959007ywc.249.1517516674330;
 Thu, 01 Feb 2018 12:24:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Thu, 1 Feb 2018 12:24:33 -0800 (PST)
In-Reply-To: <87inbgmrug.fsf@evledraar.gmail.com>
References: <20171110011002.10179-1-sbeller@google.com> <20180104224007.214548-1-sbeller@google.com>
 <87inbgmrug.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Feb 2018 12:24:33 -0800
Message-ID: <CAGZ79kZeDZD4pOSv-Bk3AspfMYrcjHEnJrQf9EZ3LevZx9bnGA@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] blame: (dim rep. metadata lines or fields, decay
 date coloring)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 1, 2018 at 11:29 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Jan 04 2018, Stefan Beller jotted:
>
>> Stefan Beller (4):
>>   color.h: document and modernize header
>>   builtin/blame: dim uninteresting metadata
>>   builtin/blame: add option to color metadata fields separately
>>   builtin/blame: highlight recently changed lines
>
> I like this feature in principle, but I can't get it to work. Building
> pu and:

Thanks for testing the feature!
Please use the flag `--color-lines`, `--color-fields` or `--heated-lines`
for experimentation.

In the future we may decide that one of them becomes the default
(which one?) and is triggered by the color.ui=3Dalways setting as well.

>     ./git -c color.ui=3Dalways --exec-path=3D$PWD blame Makefile
>
> Shows no colors. Neither does:
>
>     ./git -c color.ui=3Dalways --exec-path=3D$PWD -c color.blame.highligh=
tRecent=3D"red,12 month ago,blue" blame Makefile
>
> And there's a bug, it segfaults on any custom value to the other config
> option:
>
>     ./git -c color.ui=3Dalways --exec-path=3D$PWD -c color.blame.repeated=
Meta=3Dred blame Makefile
>
>     0x00000000004c312b in color_parse_mem (value=3D0x8f6520 "red", value_=
len=3D3, dst=3D0x1 <Address 0x1 out of bounds>) at color.c:272
>     272                     OUT('\033');
>
> The repeated_meta_color variable is NULL when passed to
> color_parse_mem(). Didn't dig further.

Thanks for noticing.
Fix below (white space mangled)

--- i/builtin/blame.c
+++ w/builtin/blame.c
@@ -48,7 +48,7 @@ static int xdl_opts;
 static int abbrev =3D -1;
 static int no_whole_file_rename;
 static int show_progress;
-static char *repeated_meta_color;
+static char repeated_meta_color[COLOR_MAXLEN];

 static struct date_mode blame_date_mode =3D { DATE_ISO8601 };
 static size_t blame_date_width;
@@ -1099,9 +1099,9 @@ int cmd_blame(int argc, const char **argv, const
char *prefix)

        if (!(output_option & OUTPUT_PORCELAIN)) {
                find_alignment(&sb, &output_option);
-               if (!repeated_meta_color &&
+               if (!*repeated_meta_color &&
                    (output_option & (OUTPUT_COLOR_LINE | OUTPUT_COLOR_FIEL=
DS)))
-                       repeated_meta_color =3D GIT_COLOR_DARK;
+                       strcpy(repeated_meta_color, GIT_COLOR_DARK);
        }
