Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62DD1F576
	for <e@80x24.org>; Sat, 10 Feb 2018 09:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbeBJJmR (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 04:42:17 -0500
Received: from mail-oi0-f54.google.com ([209.85.218.54]:37978 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeBJJmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 04:42:16 -0500
Received: by mail-oi0-f54.google.com with SMTP id j15so7890345oii.5
        for <git@vger.kernel.org>; Sat, 10 Feb 2018 01:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=dDa9ZqbTyrvIuTf944g/Yw54HB+QbJ3DMiOXcPNATaQ=;
        b=AnbmBV5RgmsI5x2HPmCOT6sP+pbIUn+UiFxjiYD5mbMYrWEM2dsRXRFWmJSYRTzSU9
         eRVyHYzfzssRhOcm6x30Tjdtl7CuA4yzlbhyPwOPzjxAmp+d8DeOIVKg+K81dFsDW/hD
         DNEpJt+bySNRte1j/LILr34AAuj2uvo8G0BoSqV2yfj+w3JaWySaHmS1jtRriNFQfLQr
         jx/I8UHQa9u48v1Iutql7pItEOnqzWMlP3ddZi0j8j4kDzDe71v2idH/SnjEnLlxNQWv
         9vBhT/B5WyD1Aa+qq0gG2ewJUR6vGdtiabDtHA68p62UiLGfEvz42lEqnu+qGz6rezOB
         EfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=dDa9ZqbTyrvIuTf944g/Yw54HB+QbJ3DMiOXcPNATaQ=;
        b=hb5W7Yo12Ga01qHxCV6K0mrJCiJjCchkIXHua9+V9dcW5i1BebbdS6CnHWF1Hiyspf
         GqfrjM4JfzMd9JO3ehfNJA9ugnNHzLgc+KoQSZNUoc8bZMnrp0iph+9vDtlVYM+H/V9A
         krcddHufCG6UkgbsEuSJO1qqpHpwfC+LawCwUJSpF1snLF41l2oA5IVhnp/ToHMVf2KC
         wcDMpR26lkQ7xPnnphobvVUNuQpUpsX6HFrZqqk0345eKlE8OxMl044aMes7pQLDf4nt
         UpBp4Xy25dbzs53KSwStNX6/aU8rK3cbJ34IR7h5EwT4ktSy8Yjl97rFTo3Xt0Bnvgjb
         +ISQ==
X-Gm-Message-State: APf1xPAnAeoziMpz4qLhxXis5Hw640LOmqJvfzivU6/b9oe88Bw6C8TE
        k2i5VFXcpE6yQSzRmtZYlyOfGn8z+ha4oVWwwOHQqA==
X-Google-Smtp-Source: AH8x227FYdRThTnH4Nt0O1DbaoqCSeVQAgVu71G3Plais6798VT8VlhU87Wj7L/y5fmm5JFVSoZwqcEpYowXDP6NvWo=
X-Received: by 10.202.199.130 with SMTP id x124mr3617447oif.85.1518255736110;
 Sat, 10 Feb 2018 01:42:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.57.24 with HTTP; Sat, 10 Feb 2018 01:42:15 -0800 (PST)
Reply-To: noloader@gmail.com
In-Reply-To: <20180210093140.GA11525@tor.lan>
References: <CAH8yC8nodewYm-J3ye5Lnq-Zf9JziejL8L3TxTEwVoq8hD--HA@mail.gmail.com>
 <20180210093140.GA11525@tor.lan>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 10 Feb 2018 04:42:15 -0500
Message-ID: <CAH8yC8n2=DtWim0V9Ziiaua8wfZS-NWQ9XQUqcdGceOpN82A0w@mail.gmail.com>
Subject: Re: Crash when clone includes magic filenames on Windows
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 10, 2018 at 4:31 AM, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
> On Sat, Feb 10, 2018 at 03:55:58AM -0500, Jeffrey Walton wrote:
>> Hi Everyone,
>>
>> I'm seeing this issue on Windows: https://pastebin.com/YfB25E4T . It
>> seems the filename AUX is the culprit. Also see
>> https://blogs.msdn.microsoft.com/oldnewthing/20031022-00/?p=3D42073 .
>> (Thanks to Milleneumbug on Stack Overflow).
>>
>> I did not name the file, someone else did. I doubt the filename will be =
changed.
>>
>> Searching is not turning up much information:
>> https://www.google.com/search?q=3Dgit+"magic+filenames"+windows
>>
>> Does anyone know how to sidestep the issue on Windows?
>>
>> Jeff
>
> Thanks for the report.
>
> (Typically nobody (tm) here on the list opens a web-browser to look at ex=
ternal
>  material, so here is a shortened version of the pastebin:)
>
> error: unable to create file crypto_stream/lexv2/e/v2/schwabe/sparc-2/e/a=
ux.c: No such file or directory
> error: unable to create file crypto_stream/lexv2/e/v2/schwabe/sparc-2/e/a=
ux.s: No such file or directory
> Segmentation fault:  99% (26526/26793)
>
> There are actually 2 problems:
> - The filenames named aux.c
>   It could be that git -c core.longpaths=3Dtrue clone xxx
>   works, but I don't have a Windows box to test at the moment-

Thanks. This did not help.

> - The crash
>   Which Git version do you use?
>   It may be a good idea to report it here
>   https://github.com/git-for-windows/git

2.16.1-2

Thanks again.

Jeff
