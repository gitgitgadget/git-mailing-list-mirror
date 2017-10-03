Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65956202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 17:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbdJCRXx (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 13:23:53 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:45558 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdJCRXw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 13:23:52 -0400
Received: by mail-qt0-f181.google.com with SMTP id k1so3316752qti.2
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=dlfifxVFwybQFrOllNRhpwXUdkNLml2HF1HF6NWwd8s=;
        b=ItmTk5kVLmd8VL6SYBn/bTik+hDDqAg7LALd4qEgRyRmQYvjAmdv5BQrr9h/2PQMyi
         OI1UOHH4tqrOAploj8+sBXh1/I5+Va1Mvd6uNFd8CatxX2qE1LbDMgXhZ/8gBw4VQnqn
         CVn2PuXdBG1NKEj/6htQe4kf6gRC4U/+3QPkylbEPe0dGqG9CtzvOqy2BeEwcTV/WGw8
         MfHCSoNgrH6ge+AU+Ef2gwFqFtZXzbv0A1ZzMxtnoPgNAYKi318rHLVSwZl/QIwsMtOw
         7SJE0k7qoqE7lED3L0CSe++JgV+s9ymXGUhY5y+sbzfhclNxXuMWQrEOQ91VoORw2U7l
         sfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=dlfifxVFwybQFrOllNRhpwXUdkNLml2HF1HF6NWwd8s=;
        b=JAqWLcXFxnc2KPgv0rNeUYHAzARhaNXRxzqR8/de1RxxcTMlNABSloiczZrwkwb2t4
         9tLuF6EiMUlYsD9o5TlkGd/RLAOKRb9HZPouUtaxrlSvBprfZdPsp1CBhm1UdGGdPS85
         B0BDxa8CCZ65qjm3Bivou4RER9s8enTk7EAbYvStwki+/6MdWlrm2aLNIG58LGCL8yXh
         thgPz0WH4XOsC14C2v4FFOvT/Lhj1soRAjvG+aMuqSVNaV1zDROy01P4z/kWFfLGYLYe
         +IoTy37zhnDps9iP/yc04mT/V5pxz8Zs14P4JMkDV2FQU4bfjBjAM/yCf5wbO5eZgzE7
         EXxQ==
X-Gm-Message-State: AMCzsaUGavjNZlLe8TdRbX0UCk9xlj61cJ9jwcfClhO5dDE6DXmQlNky
        hN9UqUQW0H36WMWF02MT5VBgYSYpZV8mS7/kPzL63jzh
X-Google-Smtp-Source: AOwi7QDllou5UlqEmGG34ObIQe+ZUECoTtQtFtJfvjjsQ2z4R87Zeu4638VF5POMYH1q6K0NVGfNgWHWpFu4DWjHyFQ=
X-Received: by 10.37.85.212 with SMTP id j203mr1883736ybb.81.1507051431865;
 Tue, 03 Oct 2017 10:23:51 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.129.40.214 with HTTP; Tue, 3 Oct 2017 10:23:51 -0700 (PDT)
In-Reply-To: <958c9b03-062c-0bea-3b25-939a36659f32@web.de>
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
 <958c9b03-062c-0bea-3b25-939a36659f32@web.de>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Tue, 3 Oct 2017 12:23:51 -0500
X-Google-Sender-Auth: z_gq7D7_Ch_zgxK0eaXhU1aFLfU
Message-ID: <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
Subject: Re: Line ending normalization doesn't work as expected
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 3, 2017 at 11:26 AM, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
> The short version is, that the instructions on Github are outdated.
> This is the official procedure (since 2016, Git v2.12 or so)
> But it should work even with older version of Git.
>
> $ echo "* text=3Dauto" >.gitattributes
> $ git read-tree --empty   # Clean index, force re-scan of working directo=
ry
> $ git add .
> $ git status        # Show files that will be normalized
> $ git commit -m "Introduce end-of-line normalization"

Is the way I did it that worked also a valid solution? Or did it only
work accidentally? Again the command I ran that worked is:

$ git rm -r --cached . && git add .
