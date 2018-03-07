Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B4321F404
	for <e@80x24.org>; Wed,  7 Mar 2018 22:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933746AbeCGW4h (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 17:56:37 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38044 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754500AbeCGW4g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 17:56:36 -0500
Received: by mail-wm0-f68.google.com with SMTP id z9so7669963wmb.3
        for <git@vger.kernel.org>; Wed, 07 Mar 2018 14:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=o7IqtBA7JQLbzfpI0BfQphzCBgx66R+oUb8Rzr65Nqk=;
        b=omVrHLJJzPI6Bbv9cwlfFT9YSDR5ey1ewbXiE56boVK6P5V/4Mq+kY4oVODifLTTx/
         9yv06cNq53O4W8MB2MsKEV1rWXOAE5Ac2XxOBd3D+w70urJAQHwDaFTQ9ISyn0HCDS+1
         QuY2iRSP4cqSht/CSFB7gp50WQkUajRAUupRWQ69hacVwrZatj89+pKmDyg0QuztjPu4
         uWwZOwXfJVtKO5Vj981HFUpuVklKWQF17vMInCkji9Fk1FZz9oBsa0BcCWrNb3SiM2oo
         wz3qmLGwcOeuHSQfWAh3xecE01ufPS/cLES1STah6rmTDcoBsn4HQHxuqnW4dUwhGzOv
         iLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=o7IqtBA7JQLbzfpI0BfQphzCBgx66R+oUb8Rzr65Nqk=;
        b=HbbnxlcleUstx9w3Z/W4sYUgZSpiN4zyVc6QxpakTIogV7gNjE+P4ekisGDLv6Zp2w
         ly69MMeKpXkXmupCnH9INqrVW3LTs/L3rxbczlu161vP62RZaFmiOCo02pYMBLXorPAb
         KtSNVce69YdgiW1GMX5CsvuZKxlxYhsWPO0a4qqo6Sxd6UwTYRUN+OQG6fGtLrjq+psO
         XFJnmLrOf6xWRWEC4h5h8aI4guAnwWVcsvQ+wVqFMLqBydwpJKzq3q0W1I2985CfooWz
         NSPRozIIbY4BHe4GhSGkRLP9LMPgq2O+tTWDMTg/3dqM6N+25yfVubvjGtTpXl0Tg5ml
         7JjQ==
X-Gm-Message-State: AElRT7HfMXYpyI18OQHPL9YuuGZs20Az7MBrzvXI7AVOsYSkz9pKNFsk
        oJJNbPFRZR3/AN2Z+vxYd04=
X-Google-Smtp-Source: AG47ELscMIC+0GE1OKEEAdLtrw7d8ziszBkrZAdUbDkNwxs/YE6CrHnTboUUjuUEJVfvC7cshfNJjw==
X-Received: by 10.28.109.195 with SMTP id b64mr14733958wmi.13.1520463395215;
        Wed, 07 Mar 2018 14:56:35 -0800 (PST)
Received: from [10.6.133.146] (135.red-80-28-119.staticip.rima-tde.net. [80.28.119.135])
        by smtp.gmail.com with ESMTPSA id f3sm15141616wre.72.2018.03.07.14.56.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Mar 2018 14:56:34 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v10 6/9] convert: add 'working-tree-encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAPig+cSvC1a5EaDfFZdJU74mZz84M=CkeOJLSDxFdXKcJYyzEw@mail.gmail.com>
Date:   Wed, 7 Mar 2018 23:56:33 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <66370A41-A048-44E7-9BF8-4631C50AAE63@gmail.com>
References: <20180307173026.30058-1-lars.schneider@autodesk.com> <20180307173026.30058-7-lars.schneider@autodesk.com> <CAPig+cSvC1a5EaDfFZdJU74mZz84M=CkeOJLSDxFdXKcJYyzEw@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Mar 2018, at 18:54, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> On Wed, Mar 7, 2018 at 12:30 PM,  <lars.schneider@autodesk.com> wrote:
>> [...]
>> Add an attribute to tell Git what encoding the user has defined for a
>> given file. If the content is added to the index, then Git converts =
the
>> content to a canonical UTF-8 representation. On checkout Git will
>> reverse the conversion.
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> Documentation/gitattributes.txt  |  80 +++++++++++++++++++++++
>> diff --git a/convert.c b/convert.c
>> @@ -265,6 +266,78 @@ static int will_convert_lf_to_crlf(size_t len, =
struct text_stat *stats,
>> +static const char *default_encoding =3D "UTF-8";
>> @@ -978,6 +1051,21 @@ static int ident_to_worktree(const char *path, =
const char *src, size_t len,
>> +static const char *git_path_check_encoding(struct attr_check_item =
*check)
>> +{
>> +       const char *value =3D check->value;
>> +
>> +       if (ATTR_TRUE(value) || ATTR_FALSE(value) || =
ATTR_UNSET(value) ||
>> +           !strlen(value))
>> +               return NULL;
>> +
>> +       /* Don't encode to the default encoding */
>> +       if (!strcasecmp(value, default_encoding))
>> +               return NULL;
>=20
> As of v10, the rest of the code accepts encoding names "UTF-xx" and
> "UTFxx" (case insensitive), however, this check recognizes only
> "UTF-8" (case insensitive). For consistency, one would expect this
> also to recognize "UTF8" (case insensitive).

Nice catch. What do you think about this solution using =
is_encoding_utf8()
from utf.c?
=09
	if (is_encoding_utf8(value) && =
is_encoding_utf8(default_encoding))=20

- Lars=
