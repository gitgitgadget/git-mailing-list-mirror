Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 453791F406
	for <e@80x24.org>; Sat,  6 Jan 2018 14:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753682AbeAFO1R (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 09:27:17 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:34646 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753358AbeAFO1P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 09:27:15 -0500
Received: by mail-wr0-f171.google.com with SMTP id 36so6691603wrh.1
        for <git@vger.kernel.org>; Sat, 06 Jan 2018 06:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=06V1gqe/71Oa8XT/8+UNW2AWbEPEZHvafSLTeYg9N+k=;
        b=PO5tbb6rsLRJ+J/u5u2Gn9U6kz+B6phlgSLLVIFLhVDwM4R6xqpYytvGFRC5CtQTrd
         iZ2FKBaMnygjBAz5juSqP3LYhVXM/3FSKkOOEsV48VZ7GyB+qz83qm1ICPyG1YIvLd8a
         q0COCYMH5raDai4BONywqmr+aSX1hDErNCsf6xJsp0w1+j6DuL6j+BPQi8fu9kkYYdx+
         7TkTfOqJQ1pl5WPR1SjGGUZ0eUdFzh1ehWmvcdvufTVKBCLAR+QtBtRGldyhc6MuByFb
         rY3SexbQE5jzL2Wzorsqww0vQxlden8mMEX10gg0xeeBOnF9jBzleoB00JVUFqboh2Wm
         wx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=06V1gqe/71Oa8XT/8+UNW2AWbEPEZHvafSLTeYg9N+k=;
        b=mDq8NT7maRuDjHuq9JYr5jEx1du2koBbwqMZJacgEW3R7L9q3ogoHFxLbgRp6VEwdk
         K3tCWdAX6LzdN8bZcdAr63H+ZOcMvGfA10KsUGxW/Y3S9rr55WqFcdzQ/7V8HhC+hH56
         X6N9D4gMmLK1JGO22XiIZsYqEzClV2s43ko+puMkTfO0d3Cp4vMpUGIB8UzVxzZjY6KB
         soiVfJSPw5lI0CDydhVEtuJLWsbr9dHexQcRK32dBBkmTwkVsg7uU5WkC+pOk4GbFTkU
         YZrN4fnrP1a/9xdiV4pefS1r2B5xZhPZL6tmtU24bsrxQlcwFhdQk4pqNyC0NBw8o42W
         uOcA==
X-Gm-Message-State: AKGB3mKMF8DJUZxtEX6KMYoGQEkKzRF9lUuIw14IDmntMM6NLaFtRjZ0
        C4sKdOvPvhsq4KLHqW6sRi7sIsgii13i9XcK9kA=
X-Google-Smtp-Source: ACJfBoslwfWOb5JHpehkAfIh8q7UywMs5ebO0o+iyMzseYVW6eQBoBem25EZfm6BqnfBfNyqTBn7DXjcKoQ48VImxPE=
X-Received: by 10.223.197.11 with SMTP id q11mr5575598wrf.186.1515248833975;
 Sat, 06 Jan 2018 06:27:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.197.193 with HTTP; Sat, 6 Jan 2018 06:27:13 -0800 (PST)
In-Reply-To: <20180106082116.11057-1-martin.agren@gmail.com>
References: <CAELBRWLyZ5s2Wvk2U5Ks2adx23Z+51dbEs3QbAq+5nGLe21srQ@mail.gmail.com>
 <20180106082116.11057-1-martin.agren@gmail.com>
From:   Yasushi SHOJI <yasushi.shoji@gmail.com>
Date:   Sat, 6 Jan 2018 23:27:13 +0900
Message-ID: <CAELBRWJJYfRUxkzoeFfHQbSL5xzPQKt4srdoge=4K4n=ChN-TA@mail.gmail.com>
Subject: Re: [BUG] v2.16.0-rc0 seg faults when git bisect skip
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

Thank you for your comment.
I haven't have time to read the code carefully so bare with me.

On Sat, Jan 6, 2018 at 5:21 PM, Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
>> On Fri, Jan 5, 2018 at 11:45 AM, Yasushi SHOJI <yasushi.shoji@gmail.com>=
 wrote:
>>> When does the list allowed to contain NULLs?
>
> Short answer: there are no commits left to test.
>
> The list is built in the for-loop in `find_bisection()`. So the
> technical answer is: if all commits in the initial list `commit_list`
> are UNINTERESTING (including if `commit_list` is empty to begin with).
>
> It's also helpful to study where we should end up from there. We should
> take the `if (!revs.commits)` branch in `bisect_next_all()`. That is, we
> should print either "There are only 'skip'ped commits left to test. The
> first bad commit could be any of:" or "<commit> was both good and bad".

best_bisection_sorted() seems to do

 - get the commit list along with the number of elements in the list
 - walk the list one by one to check whether a element have TREESAME or not
 - if TREESAME, skip
 - if not, add it to array
 - sort the array by distance
 - put elements back to the list

so, if you find TREESAME, you get less elements than given, right?
Also, if you sort, the last commit, which has NULL in the ->next,
might get in the middle of the array??

# BTW, is it really fast to use QSORT even if you have to convert to
# an array from list?

>>> Since nobody noticed it since 7c117184d7, it must be a rare case, right=
?
>
> Right, you marked a commit both good and bad. That's probably not very
> common. But it obviously happens. :-)
>
> On 5 January 2018 at 06:28, Yasushi SHOJI <yasushi.shoji@gmail.com> wrote=
:
>> OK, here is the step to reproduce on git.git
>
> Thank you for providing a script for reproducing this. It helped me come
> up with the attached patch. The patch is based on ma/bisect-leakfix,
> which includes =C3=86var's patch.
>
> I think this patch could be useful, either as a final "let's test
> something previously non-tested; this would have caught the segfault",
> or simply squashed into =C3=86var's patch as a "let's add a test that wou=
ld
> have caught this, and which also tests a previously non-tested code
> path."

Do we really need that?  What is a practical use of a commit having
both good and bad?

Regards,
--=20
            yashi
