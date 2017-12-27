Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7254F1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 23:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753030AbdL0XBQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 18:01:16 -0500
Received: from mail-ua0-f174.google.com ([209.85.217.174]:44079 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752910AbdL0XAp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 18:00:45 -0500
Received: by mail-ua0-f174.google.com with SMTP id k4so6563582ual.11
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 15:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bOGiLxu25tuX79VZqpP84QROxGm3Q6s6RD/n7GwvD3w=;
        b=YP0fNrqu/poa21WMFK4B0Y9kpBw7CxToh32HyhCHd0nww5+UHJN31g3EFcAuW8KfHC
         wXPFZLV6kj+MGiaPJCMoybBuxleDkCgqVVZ7PcIbp+F4idGj6XRtNZMQdG7e/0lhBp1z
         oqSeNJAIOu0n60dTQgT+2IWf08cw3q1Np8zEKSKNJugkOZmfDMB+EBFKtIOz+hmVi7GN
         7qzrHdOsBSNoStnarzqnYWuK9xB0x+c/rIaamN3VuxUevZZ09r5kGID4gdx0Tj0WXPjx
         7Xrq6HhtekRmuim5i5TSxfvSVFdXYfbKTV8AE5PsqovOYqPeO/wZjrsoNa1emF8NBxBV
         UBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bOGiLxu25tuX79VZqpP84QROxGm3Q6s6RD/n7GwvD3w=;
        b=Oq5UdikWCWaokYfHo+MYVeG+3hOZqfrA3aHBYw8JgpIlACdW5E6oHnWu0p/Zo+N/4g
         Bk+S8z9O8AxQHDDogkQJl5ZV4wnCw6zm4QerbgyPSwRGTkffcHBzx3mprSBPz3u9JljM
         fyW7Iyd4zAenqvJ7QdZj607ZEAYV3idL//OxgkJwUkGVLGvKrbns53/5fdg8wm6UepBL
         /DxOdB/TggT7692lbalJa2HruvgTnC8OrFvWnDG6CiWH0o5p/adKenYFnmu4XaZyKzsw
         1YTFf1s0Rk0VdRDtpxye0A9DG41K+9cEFwXnOUzYy+lrAVWtpFeukXV4dS1hnKG1c9a7
         pNKg==
X-Gm-Message-State: AKGB3mJP57McKRyLGvsh5GyeR6egoooDgHpcauqUgJW98VIIOgAWFkbR
        7GE3mHsxR60uqlaDUf6GtG/H4+jT8ezbOtEJB94=
X-Google-Smtp-Source: ACJfBosnJLkuoLq4pu+886ZXC+bm1GWtnBw/HU3Rvwp5D/N0x6Gl2dClDewLhnOe4mYi1FGcmj8Yomy9eCYIWDIIs2Q=
X-Received: by 10.176.90.202 with SMTP id x10mr26632966uae.83.1514415644315;
 Wed, 27 Dec 2017 15:00:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.83.46 with HTTP; Wed, 27 Dec 2017 15:00:43 -0800 (PST)
In-Reply-To: <35D78E08-1D27-4DDF-BCD3-F6B984D811AF@gmail.com>
References: <20171227164905.13872-1-szeder.dev@gmail.com> <20171227164905.13872-3-szeder.dev@gmail.com>
 <35D78E08-1D27-4DDF-BCD3-F6B984D811AF@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 28 Dec 2017 00:00:43 +0100
Message-ID: <CAM0VKj=U5fSHo=na0FqOJNWZLoN6VVC77vj989L+4PgQqMGzWw@mail.gmail.com>
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

On Wed, Dec 27, 2017 at 8:15 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 27 Dec 2017, at 17:49, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote=
:
>> +# Skip the build job if the same tree has already been built and tested
>> +# successfully before (e.g. because the branch got rebased, changing on=
ly
>> +# the commit messages).
>> +skip_good_tree () {
>> +     if ! good_tree_info=3D"$(grep "^$(git rev-parse $TRAVIS_COMMIT^{tr=
ee}) " "$good_trees_file")"
>> +     then
>> +             # haven't seen this tree yet; continue the build job
>> +             return
>> +     fi
>> +
>> +     echo "$good_tree_info" | {
>> +             read tree prev_good_commit prev_good_job_number prev_good_=
job_id
>> +
>> +             if test "$TRAVIS_JOB_ID" =3D  "$prev_good_job_id"
>
> Under what circumstances would that be true?

When the user hits 'Restart job' on the Travis CI web interface,
$TRAVI_JOB_NUMBER and _ID remain the same in the restarted build job as
they were in the original.
So the condition is true when the user hits 'Restart job' on a build job
that was the first to successfully build and test the current tree.

> Nit: One unintended space after =3D ?!

Ok.

>> +             then
>> +                     cat <<-EOF
>> +                     Skipping build job for commit $TRAVIS_COMMIT.
>> +                     This commit has already been built and tested succ=
essfully by this build job.
>> +                     To force a re-build delete the branch's cache and =
then hit 'Restart job'.
>> +                     EOF
>> +             else
>> +                     cat <<-EOF
>> +                     Skipping build job for commit $TRAVIS_COMMIT.
>> +                     This commit's tree has already been built and test=
ed successfully in build job $prev_good_job_number for commit $prev_good_co=
mmit.
>> +                     The log of that build job is available at https://=
travis-ci.org/$TRAVIS_REPO_SLUG/jobs/$prev_good_job_id
>> +                     To force a re-build delete the branch's cache and =
then hit 'Restart job'.
>> +                     EOF
>
> Maybe add a few newlines before and after EOF to make the text more stand=
 out?
> Or print it in a different color? Maybe red?
>
> See: https://travis-ci.org/szeder/git/jobs/322247836#L622-L625

I considered using color for the first line, but then didn't do it,
because I didn't want to decide the color :)
Anyway, red is the general error/failure color, but this is neither.  It
could either be green, to match the color of the build job's result, or
something neutral like blue or yellow.

G=C3=A1bor
