Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9349201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 19:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932421AbdKOTFg (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 14:05:36 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:47019 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753579AbdKOTFe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 14:05:34 -0500
Received: by mail-yw0-f176.google.com with SMTP id a4so2256350ywh.3
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 11:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=toLr4dl49sGzIE28UHXqzmTA3uyRGV9VclcWxMeOjZw=;
        b=k/O3Frx7896Xoxl3PaA6mCG85CrY6U6CeP7zJ64f5NWiDQH2lg/sttLDuMKKKmEvxd
         FDmjJmLI9ZwD02AXZ4vZrlqmPiS6Bs1t5oiMuTP7/tDc4WdMw86elt9IcOdU/cSqlmhE
         5DdX18feIqc3x+WeMQw/Jogfyq1agrTlnvEMf0TlCBUkx+c0NtjNaUA7HW1WrZuKolkJ
         NPqLuLQ/21cze2jKfRXFliEf6ZALSskGa/60W/04NLNQh58rEJOAsgL/SCiclyOiiRnG
         nAoWXphFoRowUwCatUrRItbqpax8rDpr/b32o0hbqLwqeyXcBanYmQZk7aGY4JsP3/tC
         CNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=toLr4dl49sGzIE28UHXqzmTA3uyRGV9VclcWxMeOjZw=;
        b=Y62sAsSbUhVIM8Dvs1QNo2TnAkSEZHYSZmwLwPnUl+NMvyMA5+yojjc8l8ILJEAXno
         TDotj1u6ZHdGn7Wu1hxZoTAtYHcnERnjqMkiRSfFdCDffZrOJdF+Eits+iIjCvQSO5sM
         FkpSgIMFlnYWJqsa0hpq8rPGx3PMv0M+3E/ADDt4ePWCFKPC1DN4pS8X+jP6rG/zLDsz
         1+trbsJ+8cIzRMWITZ4mn0xxEkF0+7bFaLmoI6NQn06PUyKLRBhJzwUTZ10GDnw/Qa6e
         Ja49jLwi+sJ2DRM/R44mrPLL7ihQ+bT2wvd+IOWumxdcGNWRE43TrqK1MjAyLk7MqVzj
         FfiQ==
X-Gm-Message-State: AJaThX4D++YnS3Fwt2LJgXYgjFR5vYR20NZ/ecDADIhFbCsC9rD0pCdc
        4XssTgWocYU+6Nz6y0JtWlrHm0+36hNE2eqchVw=
X-Google-Smtp-Source: AGs4zMbZFgeoCTPPesPqLjDF6jxDnE9BsxIP01KV0LZZu+/fdzdCy63NCX7zIZjkLEQZUrE2dPhDrRV07gMpDuddsTo=
X-Received: by 10.129.39.200 with SMTP id n191mr11425707ywn.388.1510772734051;
 Wed, 15 Nov 2017 11:05:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.203.85 with HTTP; Wed, 15 Nov 2017 11:05:33 -0800 (PST)
In-Reply-To: <20171115171258.GA12963@tor.lan>
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
 <8b3225ce-a4aa-56ee-5296-6cc7528556d1@web.de> <CAJ_+vJ5J250CtzVg4QwEusddviDSYuJhubsbTJyv5Nc2conAfA@mail.gmail.com>
 <CAJ_+vJ7Yfcpz5252M4XJnDmEDCANp+eJ7RLJJF8TCcTxexZEUA@mail.gmail.com>
 <f9dc6482-587d-50a9-d649-aed63be18fad@web.de> <CAJ_+vJ6SxLOmZfG79Sa-vskBR-XG=C97--PB-vpijjUKym=jYw@mail.gmail.com>
 <20171115171258.GA12963@tor.lan>
From:   Ashish Negi <ashishnegi33@gmail.com>
Date:   Thu, 16 Nov 2017 00:35:33 +0530
Message-ID: <CAJ_+vJ7am7dU9B0qTYVtxpkHoZdV45ciZN5ifbv9W8xRO2o=EQ@mail.gmail.com>
Subject: Re: Changing encoding of a file : What should happen to CRLF in file ?
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On windows :
> git --version
git version 2.14.2.windows.2

On linux :
> git --version
git version 2.7.4

I would like to understand the solution :
If i understood it correctly : it removes file_name.txt from index, so
git forgets about it.
we then add the file again after changing encoding. This time, git
takes it as utf-8 file and converts crlf to lf when storing it
internally.
Right ?

Thank you for the support.


On Wed, Nov 15, 2017 at 10:42 PM, Torsten B=C3=B6gershausen <tboegi@web.de>=
 wrote:
> On Wed, Nov 15, 2017 at 01:41:42PM +0530, Ashish Negi wrote:
>> > If you commit the file, it will be stored with LF in the index,
>> This is what i believe is not happening.
>>
>> Lets do this with a public repository and steps which are reproducible.
>> I have created a repo : https://github.com/ashishnegi/git_encoding
>>
>> If you clone this repo in linux and run `git status`, you will find
>> that file is modified.
>
> This is what what I get:
>
>  git ls-files --eol
> i/lf    w/lf    attr/text=3Dauto          .gitattributes
> i/crlf  w/crlf  attr/text=3Dauto          file_name.txt
>
> (And you get the same, I think)
> Newer versions of Git (>=3D2.10) will -not- treat file_name.txt as change=
d,
> older versions do.
> What does "git --version" say on your Linux machine ?
>
> However, if you want to fix it, you want to either end up with
>
> A)
> git ls-files --eol
> i/lf    w/lf    attr/text=3Dauto          .gitattributes
> i/lf    w/crlf  attr/text=3Dauto          file_name.txt
>
> or
> B)
> git ls-files --eol
> i/lf    w/lf    attr/text=3Dauto          .gitattributes
> i/crlf  w/crlf  attr/-text              file_name.txt
>
> (The "attr/-text" means "don't change the line endings")
>
> Both A) or B) will work, typically A) is preferred.
>
> You should be able to achive A) :
>  git rm --cached file_name.txt  && git add file_name.txt
> rm 'file_name.txt'
> warning: CRLF will be replaced by LF in file_name.txt.
> The file will have its original line endings in your working directory.
>
> git ls-files --eol
> i/lf    w/lf    attr/text=3Dauto          .gitattributes
> i/lf    w/crlf  attr/text=3Dauto          file_name.txt
>
> [snip the rest]
