Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4953D1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 23:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbdL0XYC (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 18:24:02 -0500
Received: from mail-ua0-f181.google.com ([209.85.217.181]:43228 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbdL0XYB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 18:24:01 -0500
Received: by mail-ua0-f181.google.com with SMTP id g4so19850505ual.10
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 15:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8v2fv1ghUFiNuGt1650JB/7vZVa9Q4hxl64JfWYPvtY=;
        b=gxF0Fp6PTPmpcvSd3xzMK8dZQnkqvUNTY93FXerWiy+D4Q+BH4kLDiw2vabOUFSZ8u
         KgRWjaT1POc8asX2J/VVn3gULYXabANbUqpNvuxgCLUdSCLLivf2qJS9RNfuVsank8ws
         aidnBEls4BuuzCqsc10ODNwadTR0hjIBAlw3GiGnicRRnaZvLwzPeuddhfOJ1nYAlWIR
         OpV3EHledET9rmniQF6y59H7VcLs/xt1A6NNQgxvPR3gSQrwqYR41p1BULS8gNCJkZVR
         2ZnX42jVPTCJ+Uezd7FfSGLDvq2GHzBNwn/9ejHL7VKptc05wMp6wAiiL3YRRh9Y9QLh
         t4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8v2fv1ghUFiNuGt1650JB/7vZVa9Q4hxl64JfWYPvtY=;
        b=DteR2M+Fqc1oMWqRspdANFL81DtqeX24j27hEy4dM2tVyNhrAwhbNQ05WZc9zoFqNm
         xLp/laiMASlBbvwR9TMZw+LWsaHceAgLTs/y+I1SaZTi84yRkyeRlbAmKMienSQEbisa
         VBmXOXvLRKDqkBiZOvvAoPtkANsV8rAJlOuVCHSjWtKM7Btrpu4If50NyxQPUtkagG9c
         pfEaOFOZogN/buvN4etNFtHXIS0hkPWg+XgAUvcadC5CQsklyfvcFUdeB9RcbrxtTS4J
         tb7gOeQkYYF6d9yvjFyYlnUfGyzu7rqtJIYWpFnBmbCdE414uwsAjQUO3HYsJtelBoN0
         YPgQ==
X-Gm-Message-State: AKGB3mJQvx+l4JG6YJQDN4g/DHDuWVWXrFTOP/+o3/rXUlgWFzgHMZKv
        9icDTK2DknMkOFD/xGS7CckVFdnZVsKwjMZq6n4=
X-Google-Smtp-Source: ACJfBovf6ekYuKlMCLcvop0yfUiyaG0OEGv4HMx/6k7PKVfTx/Hybs44ywhQeLeRrK+PCmQJ1XAvLJS0cmC7VhxFgZc=
X-Received: by 10.159.38.98 with SMTP id 89mr30470195uag.37.1514417040848;
 Wed, 27 Dec 2017 15:24:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.83.46 with HTTP; Wed, 27 Dec 2017 15:24:00 -0800 (PST)
In-Reply-To: <CAM0VKj=U5fSHo=na0FqOJNWZLoN6VVC77vj989L+4PgQqMGzWw@mail.gmail.com>
References: <20171227164905.13872-1-szeder.dev@gmail.com> <20171227164905.13872-3-szeder.dev@gmail.com>
 <35D78E08-1D27-4DDF-BCD3-F6B984D811AF@gmail.com> <CAM0VKj=U5fSHo=na0FqOJNWZLoN6VVC77vj989L+4PgQqMGzWw@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 28 Dec 2017 00:24:00 +0100
Message-ID: <CAM0VKj=sqOzjNRxdqCa4Nwg0B=3sxzbG-WhVC_n+anjDwD2J-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] travis-ci: record and skip successfully built trees
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 28, 2017 at 12:00 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
> On Wed, Dec 27, 2017 at 8:15 PM, Lars Schneider <larsxschneider@gmail.com=
> wrote:
>>> +             then
>>> +                     cat <<-EOF
>>> +                     Skipping build job for commit $TRAVIS_COMMIT.
>>> +                     This commit has already been built and tested suc=
cessfully by this build job.
>>> +                     To force a re-build delete the branch's cache and=
 then hit 'Restart job'.
>>> +                     EOF
>>> +             else
>>> +                     cat <<-EOF
>>> +                     Skipping build job for commit $TRAVIS_COMMIT.
>>> +                     This commit's tree has already been built and tes=
ted successfully in build job $prev_good_job_number for commit $prev_good_c=
ommit.
>>> +                     The log of that build job is available at https:/=
/travis-ci.org/$TRAVIS_REPO_SLUG/jobs/$prev_good_job_id
>>> +                     To force a re-build delete the branch's cache and=
 then hit 'Restart job'.
>>> +                     EOF
>>
>> Maybe add a few newlines before and after EOF to make the text more stan=
d out?
>> Or print it in a different color? Maybe red?
>>
>> See: https://travis-ci.org/szeder/git/jobs/322247836#L622-L625
>
> I considered using color for the first line, but then didn't do it,
> because I didn't want to decide the color :)
> Anyway, red is the general error/failure color, but this is neither.  It
> could either be green, to match the color of the build job's result, or
> something neutral like blue or yellow.

OTOH, the message printed in skip_branch_tip_with_tag() is not
colorized, either.
