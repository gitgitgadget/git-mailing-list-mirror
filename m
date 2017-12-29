Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21C061F404
	for <e@80x24.org>; Fri, 29 Dec 2017 20:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbdL2UD4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 15:03:56 -0500
Received: from mail-ua0-f178.google.com ([209.85.217.178]:41795 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbdL2UDz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 15:03:55 -0500
Received: by mail-ua0-f178.google.com with SMTP id x10so7133025ual.8
        for <git@vger.kernel.org>; Fri, 29 Dec 2017 12:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RUfP3qQ4IM24Gr5rmICTyAH5LMtJEFwDJMPo+GTOxbE=;
        b=NEbahYRgZu5552w3l48quxVMmccE4bNeG9lBBDBExLKVpW/sfV0Ji4twVo7dkYoK/r
         /WRwAa/ihSk9Q7coFmounyjZJ3dl5FdKjAM6xs5R+7XJNOSEh2X5E7jxFftAIPByP/9F
         t4AZIYLYDlMSKyLZo85MlIyhqoo6ddWoBLeVyJQPHYAhcGlm0xjOBUbDb+B50VG0rNm/
         dhmrUOq01uBNzRsvKenGiV/iM2SncqtMtUFCcTnvFJmSztnulBckbLEIRYKk9WrswTRL
         CuibCXJcFNh1FfINEAUllCX2je3QXNn6o15YBeoeGnKUonFaLe+qhI+tbw/IRTGna4Ch
         POnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RUfP3qQ4IM24Gr5rmICTyAH5LMtJEFwDJMPo+GTOxbE=;
        b=jc/A7Q6DdVklj/0JuKgsb2Fz8lF7LNHKj0fR4xmu43utf60csK6dcndNq6F2OJ8t2L
         VNu2b+2LnQbmwE+vMS+2GJeUOeSBTD5CeAhgcckxM5NJKILVn1fqBEP9wZmyYqeveX4u
         jz9iQTqjXvjG79r65mM4ztR5MYuWbJ5FJI2h/wggKmm5IX6Na4K1/VLJkywqdm3u+PBv
         b6lCgg6I93MXUufAJ1L6swKMxE/kYI8O3cjhWVUSFDYfwVykj6LrvnaGdktBxXJnMnBe
         uqbpKzJNYAXj94Wdb7otUVlohPHmf5km8jtrQZ8sp9dWZiqL8/2noWZdKLj50ApDIw6z
         Qp5w==
X-Gm-Message-State: AKGB3mIb+7Lrbjzqpf89onXWkkgLygIiCnckR8dnY9zLEKyyAaZItEqw
        Ka5u7fEEqFZ1/ctqlJSo4aDTbAsQnhg08GCQAF4=
X-Google-Smtp-Source: ACJfBou5pkmVTapk73u7FhFk+IkKE1B90jqehVB5951nWUqMMzlWhoR6AQkoskxsvosuF5S1YsrCEF2UczXd/PqzmRU=
X-Received: by 10.176.81.57 with SMTP id e54mr38302150uaa.120.1514577834448;
 Fri, 29 Dec 2017 12:03:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.83.46 with HTTP; Fri, 29 Dec 2017 12:03:54 -0800 (PST)
In-Reply-To: <EFD040CE-E88C-4893-A304-4514BF221AC5@gmail.com>
References: <20171227164905.13872-1-szeder.dev@gmail.com> <20171227164905.13872-3-szeder.dev@gmail.com>
 <35D78E08-1D27-4DDF-BCD3-F6B984D811AF@gmail.com> <CAM0VKj=U5fSHo=na0FqOJNWZLoN6VVC77vj989L+4PgQqMGzWw@mail.gmail.com>
 <EFD040CE-E88C-4893-A304-4514BF221AC5@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 29 Dec 2017 21:03:54 +0100
Message-ID: <CAM0VKjk+LtW4dCuwsZ8ffXrN4HGL=ZC1budCOd53_w-20gwNag@mail.gmail.com>
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

On Thu, Dec 28, 2017 at 12:16 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 28 Dec 2017, at 00:00, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote=
:
>>
>> On Wed, Dec 27, 2017 at 8:15 PM, Lars Schneider
>> <larsxschneider@gmail.com> wrote:
>>>
>>>> On 27 Dec 2017, at 17:49, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
>>>> +# Skip the build job if the same tree has already been built and test=
ed
>>>> +# successfully before (e.g. because the branch got rebased, changing =
only
>>>> +# the commit messages).
>>>> +skip_good_tree () {
>>>> +     if ! good_tree_info=3D"$(grep "^$(git rev-parse $TRAVIS_COMMIT^{=
tree}) " "$good_trees_file")"
>>>> +     then
>>>> +             # haven't seen this tree yet; continue the build job
>>>> +             return
>>>> +     fi
>>>> +
>>>> +     echo "$good_tree_info" | {
>>>> +             read tree prev_good_commit prev_good_job_number prev_goo=
d_job_id
>>>> +
>>>> +             if test "$TRAVIS_JOB_ID" =3D  "$prev_good_job_id"
>>>
>>> Under what circumstances would that be true?
>>
>> When the user hits 'Restart job' on the Travis CI web interface,
>> $TRAVI_JOB_NUMBER and _ID remain the same in the restarted build job as
>> they were in the original.
>> So the condition is true when the user hits 'Restart job' on a build job
>> that was the first to successfully build and test the current tree.
>
> I think I would prefer it if Travis would rerun all jobs if I hit the
> "refresh" button. What is your intention here?

I considered that and don't think it's worth the effort.

First, I think it's a rather rare use case.  I don't know what others
are doing, but I only hit 'Restart job' to restart timeouted OSX build
jobs (and to test this patch :), and that already works with this patch.
I don't really see any reason to restart old successful build jobs,
except perhaps when a new version of one of the dependencies becomes
available (e.g. P4 and Git LFS versions are not hardcoded on OSX, we use
whatever homebrew delivers), to see that an older version still works
with the new dependencies.  Has anyone ever done something like that? :)

Second, we need to know when a build job is run after the user hit
'Restart job'.  Unless I overlooked something, Travis CI doesn't
indicate this.  I'm not sure this is documented explicitly, but it seems
that a restarted build job gets the same $TRAVIS_JOB_{NUMBER,ID}
variables as the original.  We could use this to identify restarted
build jobs, but to do that we would have to save this information at the
end of every successful build, too, and add additional checks to this
function, of course.

>>>> +             then
>>>> +                     cat <<-EOF
>>>> +                     Skipping build job for commit $TRAVIS_COMMIT.
>>>> +                     This commit has already been built and tested su=
ccessfully by this build job.
>>>> +                     To force a re-build delete the branch's cache an=
d then hit 'Restart job'.
>>>> +                     EOF
>>>> +             else
>>>> +                     cat <<-EOF
>>>> +                     Skipping build job for commit $TRAVIS_COMMIT.
>>>> +                     This commit's tree has already been built and te=
sted successfully in build job $prev_good_job_number for commit $prev_good_=
commit.
>>>> +                     The log of that build job is available at https:=
//travis-ci.org/$TRAVIS_REPO_SLUG/jobs/$prev_good_job_id
>>>> +                     To force a re-build delete the branch's cache an=
d then hit 'Restart job'.
>>>> +                     EOF
>>>
>>> Maybe add a few newlines before and after EOF to make the text more sta=
nd out?
>>> Or print it in a different color? Maybe red?
>>>
>>> See: https://travis-ci.org/szeder/git/jobs/322247836#L622-L625
>>
>> I considered using color for the first line, but then didn't do it,
>> because I didn't want to decide the color :)
>> Anyway, red is the general error/failure color, but this is neither.  It
>> could either be green, to match the color of the build job's result, or
>> something neutral like blue or yellow.
>
> You are right about red. I think I like yellow to express "warning".
> But this is just a nit.

OK, yellow it will be then.


> "skip_branch_tip_with_tag" could print its output yellow, too.
>
> - Lars
