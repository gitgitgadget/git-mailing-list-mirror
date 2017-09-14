Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A6B620281
	for <e@80x24.org>; Thu, 14 Sep 2017 07:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbdINHC5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 03:02:57 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:46084 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbdINHC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 03:02:56 -0400
Received: by mail-it0-f54.google.com with SMTP id 6so2770352itl.1
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 00:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8L/D5ffAYPRZAx19achj2CUQqXQTtxY7zBxYhNF6MrQ=;
        b=jPzOx4AD1553EwL9V3ItpJXtdDhaX1WmffUSAqVU+X16wDmRjg7mCcvSrOd1PsE9mP
         47M1iDmOSxZO/JCOcUp2fXTbIt3iHlg3xmWCgDI9gJTjWTvSG3IlipsVcvUiCuuDDUX/
         tOnJ4AYzQ5cdw+Gcea2znh7PEF1qHuMZJrQCEsBGoGb/4GB/GKxMipefbXla1KMBqLVc
         QKAZ9GRIP4W4SsWzVeeQXIr3Y0ysn3POFC19h0l/xgdwMlBn2MsnUKR+ZKRAAlTaN750
         ES+R66V6gWHTbXXFpnpEUW5guoUkDdJbCYMqCq0xw2YfPomd59b5JezMDnIpubxYQzlH
         N5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8L/D5ffAYPRZAx19achj2CUQqXQTtxY7zBxYhNF6MrQ=;
        b=DD/Oyo6yM/yysl0K6jqMyOOchgv2IPihfXGbGJJXn1RpoEwO+cs7Pp/yX58Sw57dDl
         4o3xkp8wYApf16lpAVE+Vl+HzojMlzLc9fNO4ecS+gXaWCAV09Wpf6z9XMwZrcOCTc6Y
         G/76qSgNbK1aCGnBaKG4HH7fHq5MRK1QY5z4Ky+KTAPvUA6+lxZMlMLMqM9FXRxE89Bh
         +sKCg2BDS5V577g2gv6tJhHBi4nKIucTdNbKwcPVS0tuSKwvyCMvfnAgVYA4RgTppyBP
         iDA9q7sZkSS4gUQPPr+Qqndgaq8HO7MXcsJ7vs4uhAZrvhMezu06MhC5nwGDPyCLp3cM
         Nd8w==
X-Gm-Message-State: AHPjjUgPU2aLP5+MpbGSAAaiCnuBDvwqMJyTEqMd62Lho2IahAUREaJT
        Ze+lEXDAuqgph4QlpbktP8glyOSGLyhWuk+RfIc=
X-Google-Smtp-Source: AOwi7QDzvW0wi7bt+ey4xAQy/GUID7a+NApuFxoZBHUGThBmyFiDcwxHDH6f0g0B5ek3luz3Dkb9z1UBTldqYLgu7yA=
X-Received: by 10.36.5.84 with SMTP id 81mr1750086itl.96.1505372575447; Thu,
 14 Sep 2017 00:02:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Thu, 14 Sep 2017 00:02:54 -0700 (PDT)
In-Reply-To: <BE9DF8E9-3771-42DD-B1F6-EC77783380F7@gmail.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org> <BE9DF8E9-3771-42DD-B1F6-EC77783380F7@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Sep 2017 09:02:54 +0200
Message-ID: <CAP8UFD3ZV4Ezucn+Tv-roY6vzDyk2j4ypRsNR1YbOqoQK_qr8A@mail.gmail.com>
Subject: Re: [PATCH v5 00/40] Add initial experimental external ODB support
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>, Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 10, 2017 at 2:30 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 03 Aug 2017, at 10:18, Christian Couder <christian.couder@gmail.com> wrote:
>>
>> ...
>>
>> * The "helpers" (registered commands)
>>
>> Each helper manages access to one external ODB.
>>
>> There are 2 different modes for helper:
>>
>>  - Helpers configured using "odb.<odbname>.scriptCommand" are
>>    launched each time Git wants to communicate with the <odbname>
>>    external ODB. This is called "script mode".
>>
>>  - Helpers configured using "odb.<odbname>.subprocessCommand" are
>>    launched launched once as a sub-process (using sub-process.h), and
>>    Git communicates with them using packet lines. This is called
>>    "process mode".
>
> I am curious, why would we support two modes? Wouldn't that increase
> the maintenance cost? Wouldn't the subprocess command be superior?
> I imagine the script mode eases testing, right?!

The script mode makes it much easier to write some helpers. For
example, as shown in t0430 at the end of the patch series, a helper
for a restartable bundle based clone could be something like
basically:

case "$1" in
init)
    ref_hash=$(git rev-parse refs/odbs/magic/bundle) ||
    die "couldn't find refs/odbs/magic/bundle"
    GIT_NO_EXTERNAL_ODB=1 git cat-file blob "$ref_hash" >bundle_info ||
    die "couldn't get blob $ref_hash"
    bundle_url=$(sed -e 's/bundle url: //' bundle_info)
    curl "$bundle_url" -o bundle_file ||
    die "curl '$bundle_url' failed"
    GIT_NO_EXTERNAL_ODB=1 git bundle unbundle bundle_file >unbundling_info ||
    die "unbundling 'bundle_file' failed"
    ;;

>> These odb refs point to a blob that is stored in the Git
>> repository and contain information about the blob stored in the
>> external odb. This information can be specific to the external odb.
>> The repos can then share this information using commands like:
>>
>> `git fetch origin "refs/odbs/<odbname>/*:refs/odbs/<odbname>/*"`
>>
>> At the end of the current patch series, "git clone" is teached a
>> "--initial-refspec" option, that asks it to first fetch some specified
>> refs. This is used in the tests to fetch the odb refs first.
>>
>> This way only one "git clone" command can setup a repo using the
>> external ODB mechanism as long as the right helper is installed on the
>> machine and as long as the following options are used:
>>
>>  - "--initial-refspec <odbrefspec>" to fetch the odb refspec
>>  - "-c odb.<odbname>.command=<helper>" to configure the helper
>
> The "odb" config could, of course, go into the global git config.

Sure.

> The odbrefspec is optional, right?

Using "--initial-refspec <odbrefspec>" is optional. There will be more
information in the documentation about this option in the next version
of the series.

> I have the impression there are a number of topics on the list
> that tackle the "many/big objects in a Git repo" problem. Is
> there a write up about the status of them, how they relate
> to each other, and what the current problems are?
> I found the following but it looks abandoned:
> https://github.com/jrn/git-large-repositories

Yeah, it could be interesting to discuss all these topics together. On
the other hand people working on existing patch series, like me, have
to work on them and post new versions, as just discussing the topics
is not enough to move things forward.
Anyway Junio and Jonathan Tan also asked me questions about how my
work relates to Jonathan's, so I will reply to them hopefully soon...
