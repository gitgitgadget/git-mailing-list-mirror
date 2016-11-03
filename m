Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2678E206FB
	for <e@80x24.org>; Thu,  3 Nov 2016 00:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751779AbcKCAlH (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 20:41:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34773 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbcKCAlG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 20:41:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id p190so5479162wmp.1
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 17:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :message-id:cc:from:subject:date:to;
        bh=PK88V+a48/ukrlWe3OdTflDpOPEF7/lpydKSnOTqPhM=;
        b=qbS1hO/r7QR2LDQmQ+mLY3mRbU6XwM6fhHSaYulNfSiyY3urqGdyJZ61lZz6/9+CU+
         JgrkxQfbI9SgJ3af4Xz7GDyyYWnRqTCA7q4aQHbavwt7fmrBGWTmWfN3mFYv3zEbjgTf
         8uJAgL97orAKd4SAYO7N0SSZTAkrTsS6Iw1gNmcU1toVwp7ZxWr8GrvRANQ8E7Oe50iT
         57qsQ9Ehj1t+yvLAnRxZWiEEL4xyL569QKTkW8zL3dmRCGTk7xzLQCp5itbMMGu8cBmU
         2WTeAYrQV4sE9QEciiA5kFC28+OIV+0YcoTsKJPLQ9uCaWHzU5Kptjj/99/ooCaGifnT
         zlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:references:in-reply-to:mime-version
         :content-transfer-encoding:message-id:cc:from:subject:date:to;
        bh=PK88V+a48/ukrlWe3OdTflDpOPEF7/lpydKSnOTqPhM=;
        b=TkGH9UrNIDCsXbMoZ2WDuo7vsjaNNPGHd5H7MsEA94hAxgBp+9Dn+7n5zI2+HtWd+r
         bDyDEgpSyo7KRnFQiDuq6UokFpLIOhZ4ojgIUdWWoxwhXLcfN8vxl8WwPpTbbuEAaue2
         dM9mFByS1fpA5RCHYLyVZEKmdjMFIMAJIrHe5YSOF4x3u7TPWCLt8iLO4mbzljAkyqEG
         LzC/SF0O4e81zN3zTRgiNWNqt9wy8VfAme8vOXbfpS0Nk7x4tWLAgM+XwKj8ZbJE2RJe
         fftb7PSqOl96dLPeRfifz/Ji3jHaGFaGIuJIElqMcRO56e0wLnN1A4EjX3gbsn6bcPAu
         BDfw==
X-Gm-Message-State: ABUngvdyNwWi8ungMxeMEOAB9IuglcV4I3l3hP794C2bOKZKC0JSPPTMdpFQllRmj248Bw==
X-Received: by 10.194.23.67 with SMTP id k3mr4996041wjf.103.1478133665174;
        Wed, 02 Nov 2016 17:41:05 -0700 (PDT)
Received: from [192.168.0.103] ([47.60.176.155])
        by smtp.gmail.com with ESMTPSA id ym3sm5578787wjc.6.2016.11.02.17.41.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Nov 2016 17:41:04 -0700 (PDT)
References: <20161016232038.84951-1-larsxschneider@gmail.com> <20161016232038.84951-14-larsxschneider@gmail.com> <3b09d218-33bd-dc7c-235c-8954a46afc41@kdbg.org>
In-Reply-To: <3b09d218-33bd-dc7c-235c-8954a46afc41@kdbg.org>
Mime-Version: 1.0 (1.0)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
        charset=us-ascii
Message-Id: <3763DDDB-9D53-4877-8399-32DF1780CAB7@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
        peff@peff.net, ramsay@ramsayjones.plus.com, tboegi@web.de
X-Mailer: iPhone Mail (14A456)
From:   Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v11 13/14] convert: add filter.<driver>.process option
Date:   Thu, 3 Nov 2016 00:41:02 +0000
To:     Johannes Sixt <j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 2 Nov 2016, at 18:03, Johannes Sixt <j6t@kdbg.org> wrote:
>=20
>> Am 17.10.2016 um 01:20 schrieb larsxschneider@gmail.com:
>> +# Compare two files and ensure that `clean` and `smudge` respectively ar=
e
>> +# called at least once if specified in the `expect` file. The actual
>> +# invocation count is not relevant because their number can vary.
>> +# c.f. http://public-inbox.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.goo=
gle.com/
>> +test_cmp_count () {
>> +    expect=3D$1
>> +    actual=3D$2
>> +    for FILE in "$expect" "$actual"
>> +    do
>> +        sort "$FILE" | uniq -c | sed "s/^[ ]*//" |
>> +            sed "s/^\([0-9]\) IN: clean/x IN: clean/" |
>> +            sed "s/^\([0-9]\) IN: smudge/x IN: smudge/" >"$FILE.tmp" &&
>=20
> This is not sufficiently portable. Some versions of uniq write the
> count left-adjusted, not right-adjusted. How about this on top:
>=20
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index a20b9f58e3..f60858c517 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -40,10 +40,9 @@ test_cmp_count () {
>    actual=3D$2
>    for FILE in "$expect" "$actual"
>    do
> -        sort "$FILE" | uniq -c | sed "s/^[ ]*//" |
> -            sed "s/^\([0-9]\) IN: clean/x IN: clean/" |
> -            sed "s/^\([0-9]\) IN: smudge/x IN: smudge/" >"$FILE.tmp" &&
> -        mv "$FILE.tmp" "$FILE"
> +        sort "$FILE" | uniq -c |
> +        sed -e "s/^ *[0-9][0-9]* *IN: /x IN: /" >"$FILE.tmp" &&

This looks good (thanks for cleaning up the redundant clean/smudge stuff - t=
hat was a refactoring artifact!). One minor nit: doesn't sed understand '[0-=
9]+' ?

> +        mv "$FILE.tmp" "$FILE" || return

Why '|| return' here?

>    done &&
>    test_cmp "$expect" "$actual"
> }

Thank you,
Lars=
