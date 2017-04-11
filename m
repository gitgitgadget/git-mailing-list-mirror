Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2992D1FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 11:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbdDKLoY (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 07:44:24 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35066 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbdDKLoW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 07:44:22 -0400
Received: by mail-wm0-f46.google.com with SMTP id w64so61275214wma.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 04:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OT5l8guvDjA1mHexLG+FrKKDYytlOOpRPhznf/iTHjs=;
        b=HDCcvZC7VvgzPASR1o9uY+zKiTgTljwRjHuLCFFiCUkuu0e9TmJ03Zz3gbAYcxLXvP
         7cFlwBwwRWssfRsMGg1i489F+R5aB4gnXKYZbyEPT/6Esjs7Y34uEe+4jDyB7sqioM6/
         DPw2HNC8DWB303WXtt23yymzNefXFyaJilunuh8g5CEKMvtDt4y4SMxhalymxYs4cvAV
         fAvhW2UXtFbOXQqqkOcDUsGTsu7ZA/iAhvD47IkQu+zOFG/1s2uZU82hNEDLtNjDuQyl
         Wlcgo9uC3SmoUewRstCnmBS/yrsmAS3FHm6xGg+BZLXJwoosjFx1SaUZs15Hjrqg5SnC
         B9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OT5l8guvDjA1mHexLG+FrKKDYytlOOpRPhznf/iTHjs=;
        b=P926iGX/JB9f0aCauAb8QsekYcQORMusJZo+rkQ6DbzXdVZ+UIUfpBrV9BJ7huUL89
         22So7h1g21n0D0mEFxh9HmjSd1WX0Gtwt9A79nTDoHe7e5DnRJ0uOdFTaqja3MNJkPC9
         Z7/e14FFLsGBOKL1xZ/tTojWdM9ZhdBYY/SpRubB5xcj2UoRXDMz1cHdVZHgb0SzDvAJ
         SO2Y/8BTdcrSw8xQ7lGoJAS5lmO7J3tAkDJHOVjp5jJjCqcPjbGVEBNLjK6yZ/cp6N6D
         AtaE4/Gjm50YAfmOyOt/HL387hThikZNipTSsBiVmFhHOxJygQNOJGU6w8TWYid2wovA
         Zknw==
X-Gm-Message-State: AN3rC/6RvIwh4btVPEzEJs4qHVUpCk5T+FgZ9oE8iO9FuHG01iJyJiJq
        LZLcub/eMALpAg==
X-Received: by 10.28.55.3 with SMTP id e3mr12016278wma.15.1491911061478;
        Tue, 11 Apr 2017 04:44:21 -0700 (PDT)
Received: from [10.146.248.54] ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id x1sm21093901wrd.63.2017.04.11.04.44.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 04:44:20 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5] http.postbuffer: allow full range of ssize_t values
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <3d351f90-af4f-1ddb-c8a0-3e7926fd722d@ramsayjones.plus.com>
Date:   Tue, 11 Apr 2017 13:44:19 +0200
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <62969B9F-F79E-4CBA-A343-BC8D9CDBADB6@gmail.com>
References: <20170403235308.30102-1-dturner@twosigma.com> <3d351f90-af4f-1ddb-c8a0-3e7926fd722d@ramsayjones.plus.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        David Turner <dturner@twosigma.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Apr 2017, at 17:20, Ramsay Jones <ramsay@ramsayjones.plus.com> =
wrote:
>=20
>=20
>=20
> On 04/04/17 00:53, David Turner wrote:
>> Unfortunately, in order to push some large repos, the http postbuffer
>> must sometimes exceed two gigabytes.  On a 64-bit system, this is OK:
>> we just malloc a larger buffer.
>>=20
>> This means that we need to use CURLOPT_POSTFIELDSIZE_LARGE to set the
>> buffer size.
>>=20
>> Signed-off-by: David Turner <dturner@twosigma.com>
>> ---
>>=20
>> V5 addresses comments from Torsten Boegershausen and Ramsay Jones.  =
Since
>> I don't have a 32-bit machine handy, it's difficult for me to check
>> for compiler warnings on 32-bit machines.  Hopefully my guess as
>> to the solution to Ramsay's issue will be correct.
>=20
> Yep, this compiles without complaint.


Hi David,

You can test the 32-bit build on your machine by ...

1. Pulling this Docker image:
=
https://github.com/git/git/blob/cf11a67975b057a144618badf16dc4e3d25b9407/.=
travis.yml#L58

2. Starting the Docker image:
=
https://github.com/git/git/blob/cf11a67975b057a144618badf16dc4e3d25b9407/.=
travis.yml#L72

3. Running the linux32 build:
=
https://github.com/git/git/blob/cf11a67975b057a144618badf16dc4e3d25b9407/.=
travis.yml#L73


Cheers,
Lars=
