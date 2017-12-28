Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 752121F404
	for <e@80x24.org>; Thu, 28 Dec 2017 11:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753354AbdL1LQS (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 06:16:18 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:41634 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbdL1LQR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 06:16:17 -0500
Received: by mail-wm0-f53.google.com with SMTP id g75so43653218wme.0
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 03:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=e74nD0WF9LeWzIHH/hHILb4N91SsC7W6XrE380/lppY=;
        b=qBCAPNVnCYS6lRox+SEsAlIlDgdcFWAOvWGe4pQAmWopF0hP0+3lqhp/OW+R9Oveu+
         grM+ZODsO9FjKkLGy2sWvWxRVPorcl1P1lzX9jsdGf175DvjMXYA6YgtXAEjGdf3yXbc
         R/hofgKVy2WyoLKzcgHq/6o9xOb2zvpeqbkAp8HfR+AcHXpaWV2aEFafFqumFOg3l0A+
         P5TNJiTZ1bWN5mxKfLEA5wjlUB5TZ0XvY7Dr8YVjqmvwzw5J2BqS9uiTEI6RBv01Olfo
         MZXmpf1Tf+asSxP5XVp5eKLYHZBFEodK6CfTsaHcWx7fJ2bgd7XJYa2bIX6xF3zVEIZe
         BjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=e74nD0WF9LeWzIHH/hHILb4N91SsC7W6XrE380/lppY=;
        b=gDK+gCpNwoJNq8akJdRqFHQB4Cwa1Jg6EZT54lHPlzR9DE9DsDh1OG6OVkhT/xhItZ
         AgxA56Sn63c4vd8GfO0X4ZHAFhhUvLeXI6b4G4nNM8kVsTVsfCa+TMlxVYjipVNEpyPy
         UK1J26N9+A2Yqcu9urp0wLFKhKvFHoc9JfwsUCRCPHU39Z3ZapchuRsVuM+pUMsaB8bq
         kU4K2Eu+qXRTkJM/3J7L/XkeVyrTKoLooMIvICDwSMsTO13dPZzGkG2syehz0sZDtdxQ
         nRZZGxzrRR6H6kksLQVe85vIcykL5Fpt1AhEPNArkVf6j93D6LdKM7zSOmc0mW0RLC/f
         Yf/w==
X-Gm-Message-State: AKGB3mKTlwIoViaQJN0xP46+0xvP1LLSNsxQqRQHy3yYpeuzAGqcxUlw
        +hclrj2nU64ri8/Sd9+mABc=
X-Google-Smtp-Source: ACJfBos7q8P6SEzaa+C1IuyIyLz76Gf5ExX+UQRpd9mkAD0gihKlqGjAZTMhx+ihjac9vE0wOgx02Q==
X-Received: by 10.28.105.14 with SMTP id e14mr24075911wmc.74.1514459776403;
        Thu, 28 Dec 2017 03:16:16 -0800 (PST)
Received: from [10.32.248.174] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id b18sm34410293wra.44.2017.12.28.03.16.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Dec 2017 03:16:15 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/2] travis-ci: record and skip successfully built trees
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAM0VKj=U5fSHo=na0FqOJNWZLoN6VVC77vj989L+4PgQqMGzWw@mail.gmail.com>
Date:   Thu, 28 Dec 2017 12:16:14 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EFD040CE-E88C-4893-A304-4514BF221AC5@gmail.com>
References: <20171227164905.13872-1-szeder.dev@gmail.com> <20171227164905.13872-3-szeder.dev@gmail.com> <35D78E08-1D27-4DDF-BCD3-F6B984D811AF@gmail.com> <CAM0VKj=U5fSHo=na0FqOJNWZLoN6VVC77vj989L+4PgQqMGzWw@mail.gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 28 Dec 2017, at 00:00, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> On Wed, Dec 27, 2017 at 8:15 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>>=20
>>> On 27 Dec 2017, at 17:49, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>>> +# Skip the build job if the same tree has already been built and =
tested
>>> +# successfully before (e.g. because the branch got rebased, =
changing only
>>> +# the commit messages).
>>> +skip_good_tree () {
>>> +     if ! good_tree_info=3D"$(grep "^$(git rev-parse =
$TRAVIS_COMMIT^{tree}) " "$good_trees_file")"
>>> +     then
>>> +             # haven't seen this tree yet; continue the build job
>>> +             return
>>> +     fi
>>> +
>>> +     echo "$good_tree_info" | {
>>> +             read tree prev_good_commit prev_good_job_number =
prev_good_job_id
>>> +
>>> +             if test "$TRAVIS_JOB_ID" =3D  "$prev_good_job_id"
>>=20
>> Under what circumstances would that be true?
>=20
> When the user hits 'Restart job' on the Travis CI web interface,
> $TRAVI_JOB_NUMBER and _ID remain the same in the restarted build job =
as
> they were in the original.
> So the condition is true when the user hits 'Restart job' on a build =
job
> that was the first to successfully build and test the current tree.

I think I would prefer it if Travis would rerun all jobs if I hit the
"refresh" button. What is your intention here?


>=20
>>> +             then
>>> +                     cat <<-EOF
>>> +                     Skipping build job for commit $TRAVIS_COMMIT.
>>> +                     This commit has already been built and tested =
successfully by this build job.
>>> +                     To force a re-build delete the branch's cache =
and then hit 'Restart job'.
>>> +                     EOF
>>> +             else
>>> +                     cat <<-EOF
>>> +                     Skipping build job for commit $TRAVIS_COMMIT.
>>> +                     This commit's tree has already been built and =
tested successfully in build job $prev_good_job_number for commit =
$prev_good_commit.
>>> +                     The log of that build job is available at =
https://travis-ci.org/$TRAVIS_REPO_SLUG/jobs/$prev_good_job_id
>>> +                     To force a re-build delete the branch's cache =
and then hit 'Restart job'.
>>> +                     EOF
>>=20
>> Maybe add a few newlines before and after EOF to make the text more =
stand out?
>> Or print it in a different color? Maybe red?
>>=20
>> See: https://travis-ci.org/szeder/git/jobs/322247836#L622-L625
>=20
> I considered using color for the first line, but then didn't do it,
> because I didn't want to decide the color :)
> Anyway, red is the general error/failure color, but this is neither.  =
It
> could either be green, to match the color of the build job's result, =
or
> something neutral like blue or yellow.

You are right about red. I think I like yellow to express "warning".
But this is just a nit.

"skip_branch_tip_with_tag" could print its output yellow, too.

- Lars=
