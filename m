Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E49CC1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 23:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeA3XRe (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 18:17:34 -0500
Received: from mail-yw0-f174.google.com ([209.85.161.174]:42923 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbeA3XRd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 18:17:33 -0500
Received: by mail-yw0-f174.google.com with SMTP id u17so6101579ywg.9
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 15:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RF2zaEOl9bHiF60FnK3Kbm+f+t9Mywr2/XhfeY26Ptg=;
        b=KpYUi5KkJklOSKyNLVefgWWVWLX4GTngXLSAN2uxU2AZjzhde/HGwiABSkJr0KmyLz
         NlOarmF7HeSUoG5DIi5hWBctQ3GopFFSjzzMcezmOWvIhGwymryGevIE729+CYapS32F
         PU0IQB1s+1lQbTnVC48gWjYymldIGqEzE7yNkr79h0+dS+R+ngfONtAzckwkrlGLbh9p
         BhRNVzL5mz0U6RvkjofoBy9h+R+v6tQl7i6rVCKRb1XGRo/ItxWzthpKQkOYR6zzdoqF
         6vEnkseFE1AaH4FFgVFXBWzALspQySYO2X7JqroxlxMY+a8lVXY3Ozn69VcjRDJbC2fD
         kBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RF2zaEOl9bHiF60FnK3Kbm+f+t9Mywr2/XhfeY26Ptg=;
        b=jCoW5bYuIBFekEE0/wGgouZgSr/i6XrOrlGLxPoXXfj0mBPd2M0rWBccZniohyU/ZU
         G9ZH3WxSdOGTdL5gxR6RUxpR8iHPtAJprK4J/2Kx54OI7tC+ucPOLmMb4SwWU/8ayO6g
         bAAsXPKm19Nkscsj/ywMoHE6W29EChKG/OtsC+kml+KGBplazC8PajY5JY4GeRoobfyr
         Y1sFrv3aQzsKB2Y0JsSmk4QDavD66rGStgBoh9rBgHaLkese4Y6Qfqk3LiQAnfjHq50d
         QLlYR+4M44+5D/ONTzWEwBT8wWe2shOTpGVzhdi4rd/dv1vXLbWikVuqUY1yMgJq/tLq
         FrkA==
X-Gm-Message-State: AKwxytdUde3ZOK1M7HuPrOlUkIZjSyDYcHizAyYQ6Atgf0KyL+Ij02o5
        HX+eJUnipt4rc1zGnHshpasz2WQg3elIlVcJWyk07Q==
X-Google-Smtp-Source: AH8x225A8ZFYoEmgDEc+h6UuPbpcino9UaZqJaUheZNfhnzWjE3vTe9FdT0usDHHfjwI95yh1GBYdFbJXfzRBKQFPMQ=
X-Received: by 10.37.33.67 with SMTP id h64mr7808194ybh.39.1517354252113; Tue,
 30 Jan 2018 15:17:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 30 Jan 2018 15:17:31 -0800 (PST)
In-Reply-To: <CADfK3RVJdk3zK7+eE45-PSkb=_v86wrC0TzY+hUmAkfO0Dea=w@mail.gmail.com>
References: <CADfK3RWXDuE=hYD==4sHXO1iJeOiVDOp7hBqhBtSn7gnQ+x7Qg@mail.gmail.com>
 <CADfK3RU4WJLV9EtieWYQzzRBoJkpyE+w178WQk+wj6soFwKW7g@mail.gmail.com> <CADfK3RVJdk3zK7+eE45-PSkb=_v86wrC0TzY+hUmAkfO0Dea=w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 Jan 2018 15:17:31 -0800
Message-ID: <CAGZ79kafgyOujDM4BsXdDUnP+iFk5mp2bYnX-Q65khW-weEhUg@mail.gmail.com>
Subject: Re: Bug Report: Subtrees and GPG Signed Commits
To:     Stephen R Guglielmo <srguglielmo@gmail.com>,
        Avery Pennarun <apenwarr@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 11:15 AM, Stephen R Guglielmo
<srguglielmo@gmail.com> wrote:
> Hi, just following up on this bug report. I have not heard back. Is
> there additional information that's needed? Is there a better place to
> file bug reports?
>
> Additionally, I have confirmed that this bug still exists with git
> version 2.16.1.
>
> Thanks
>
> On Thu, Jan 18, 2018 at 11:19 AM, Stephen R Guglielmo
> <srguglielmo@gmail.com> wrote:
>> Hi, just following up on this bug report. I have not heard back. Is
>> there additional information that's needed? Is there a better place to
>> file bug reports?
>>
>> Thanks
>>
>> On Sat, Jan 6, 2018 at 5:45 PM, Stephen R Guglielmo
>> <srguglielmo@gmail.com> wrote:
>>> Hi all,
>>>
>>> I've noticed an issue regarding the use of `git subtree add` and `git
>>> subtree pull` when the subtree repository's commit (either HEAD or
>>> whatever commit specified by the subtree command) is signed with GPG.
>>> It seems to work properly if the commit is not signed but previous
>>> commits are.
>>>
>>> The gist of the issue is that `git subtree add` does not add the
>>> subree properly and a "fatal: Not a valid object name" error is
>>> thrown. Running `git subtree pull` does not pull any upstream changes
>>> after that ("'subtree' was never added").
>>>
>>> I have not done extensive testing, however, below are instructions to
>>> reproduce the issue. This was tested using git version 2.15.1
>>> installed via Homebrew on MacOS. I did not test with the built-in
>>> version of git on MacOS.
>>>
>>> Thanks,
>>> Steve
>>>
>>> # Create a new repository
>>> mkdir repoA && cd repoA
>>> git init
>>> echo "Test File in Repo A" > FileA
>>> git add -A && git commit -m 'Initial commit in repo A'
>>>
>>> # Create a second repository
>>> cd .. && mkdir repoB && cd repoB
>>> git init
>>> echo "Test File in Repo B" > FileB
>>> git add -A && git commit -m 'Initial commit in repo B'
>>>
>>> # Create a signed commit in repo B
>>> echo "Signed Commit" >> FileB
>>> git commit -a -S  -m 'Signed commit in repo B'
>>>
>>> # Now, add repoB as a subtree of RepoA
>>> cd ../repoA
>>> git subtree add --prefix repoB_subtree/ ../repoB/ master --squash
>>> # Output:
>>> git fetch ../repoB/ master
>>> warning: no common commits
>>> remote: Counting objects: 6, done.
>>> remote: Compressing objects: 100% (2/2), done.
>>> remote: Total 6 (delta 0), reused 0 (delta 0)
>>> Unpacking objects: 100% (6/6), done.
>>> From ../repoB
>>>  * branch            master     -> FETCH_HEAD
>>> fatal: Not a valid object name gpg: Signature made Sat Jan  6 17:38:31 2018 EST
>>> gpg:                using RSA key 6900E9CFDD39B6A741D601F50999759F2DCF3E7C
>>> gpg: Good signature from "Stephen Robert Guglielmo (Temple University
>>> Computer Services) <srg@temple.edu>" [ultimate]
>>> Primary key fingerprint: 6900 E9CF DD39 B6A7 41D6  01F5 0999 759F 2DCF 3E7C
>>> 4b700b1a4ebb9e2c1011aafd6b0f720b38f059a4
>>> # Note, git exits with status 128 at this point.
>>>
>>> # FileB was in fact added and staged to repoA, despite the "fatal"
>>> above. Commit it:
>>> git commit -m 'Add repoB subtree'
>>>
>>> # Ok, let's make another commit in repoB and try a `subtree pull`
>>> instead of `subtree add`
>>> cd ../repoB
>>> echo "Another Line" >> FileB
>>> git commit -a -S -m 'Another signed commit'
>>> cd ../repoA
>>> git subtree pull --prefix repoB_subtree/ ../repoB master --squash
>>> # Output:
>>> warning: no common commits
>>> remote: Counting objects: 9, done.
>>> remote: Compressing objects: 100% (3/3), done.
>>> remote: Total 9 (delta 0), reused 0 (delta 0)
>>> Unpacking objects: 100% (9/9), done.
>>> From ../repoB
>>>  * branch            master     -> FETCH_HEAD
>>> Can't squash-merge: 'repoB_subtree' was never added.
>>> # Note, git exits with status 1 at this point.
>>>
>>> # RepoB's third commit ('Another signed commit') is not pulled into
>>> the subree in repo A.
>>> # This can be verified by running a diff:
>>> diff -qr --exclude ".git" repoB_subtree ../repoB
>>> # Output:
>>> Files repoB_subtree/FileB and ../repoB/FileB differ

There has not been feedback for a while on this thread.
I think that is because subtrees are not in anyone's hot
interest area currently.

This is definitely the right place to submit&discuss bugs.
Looking through "git log --format="%ae %s" -S subtree",
it seems as if Avery (apenwarr@gmail.com) was mostly
interested in developing subtrees, though I think he has
moved on. Originally it was invented by Junio, who is
the active maintainer of the project in 68faf68938
(A new merge stragety 'subtree'., 2007-02-15)

Thanks,
Stefan
