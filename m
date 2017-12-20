Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C390F1F404
	for <e@80x24.org>; Wed, 20 Dec 2017 19:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756025AbdLTTgW (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 14:36:22 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:47015 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755904AbdLTTgV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 14:36:21 -0500
Received: by mail-qt0-f176.google.com with SMTP id r39so29641095qtr.13
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 11:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Od4lkYDgRxMMFmSBf3QbtkXmzg5PX40rAjxMFXeYWU4=;
        b=M42KLJSaQorNzgY9V19e9XFgcxR0w0mHuPrSjmbWFVKGuWAnfkJ90yHrfHro7Uc6gX
         JfYGnKpbQRYbM5RDYFfELuiME9CR3Q62SWHCiFRrcwFli7tbluk+Jp4Z9v7pLO3Ot5ri
         OBvD6ypq72WOel3ao6UW5kVf+Y86VqdshUgTZt67x6aJqnSw0QEEQ82+Q/e/s2//sKvv
         /yzmEYakf1n4nk/3IZnQ/xpr1sI781HXAIocSavXmOqHGl9r55+C3nBomaKJYhgJvaqB
         SsSfnkXw2ntUPmtVK+tuQtRhfmaCMarF4wRSHLntlU+XqgTiY4N5Mil3gftbOinSoUvn
         22Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Od4lkYDgRxMMFmSBf3QbtkXmzg5PX40rAjxMFXeYWU4=;
        b=NSt6BJsaxguzFlpFAT03fDvJxOegA7YTQY2pZYwtrND8kc3OFGgjKHODZ9HWFnL35M
         KqtT0wD4cEwZBOwFtz+mE2VSPlbDgXspkEIsgi2VaHBt6MmwPg/5ye9LYyvziDzD253t
         kv5v4q/pL2Whzdq7iVa3Y8ZpVAGGbV6ys/bqO77reEykesL9KI6RFQ4PUOAfMMofjNWL
         y0XYc2Rc3Op8S/uE4zb8fU+WbfEGEK8qvkfYk/4Vg58/NodxnEPKdv7IpMD8Aylub6z2
         M1LbLR0szSyNSEfo03S3vCaTtoFazVg67zAiwcXQXuhT7MZZuF69/HwzAswI0Bo0vq64
         a+5A==
X-Gm-Message-State: AKGB3mJgIAkXF5OWDRFtd5YyR0jDunfELu/17C13TwpOTYp82qMt3ylo
        YUtrUJiEMwid6kn/oYkJ1gYE5HQG4YSv9gCPh6aIbg==
X-Google-Smtp-Source: ACJfBovlB5b3Fi6Z1DUGR1su16j7Sq+Evk6/3nQPF35OrY/xHe54bemXcBIlYwz7VsMH1GGEcRpVuAIvHNb3N1iOTSU=
X-Received: by 10.237.61.181 with SMTP id i50mr12108488qtf.29.1513798580652;
 Wed, 20 Dec 2017 11:36:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 20 Dec 2017 11:36:19 -0800 (PST)
In-Reply-To: <20171220000148.GJ240141@aiede.mtv.corp.google.com>
References: <20171219222636.216001-1-sbeller@google.com> <20171219222636.216001-6-sbeller@google.com>
 <20171219224431.GG240141@aiede.mtv.corp.google.com> <CAGZ79kake8k2dM=NPwNoqB5Vkxy+k67PACz01-aXx6-njcisgQ@mail.gmail.com>
 <20171220000148.GJ240141@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 20 Dec 2017 11:36:19 -0800
Message-ID: <CAGZ79kZpY8iXhCUOB=KuwGPOr7zvV7z+Q-L43p28=7ydaTvutg@mail.gmail.com>
Subject: Re: [PATCH 5/5] submodule: submodule_move_head omits old argument in
 forced case
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 19, 2017 at 4:01 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>> On Tue, Dec 19, 2017 at 2:44 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>>>   checkout -f
>>>         I think I would expect this not to touch a submodule that
>>>         hasn't changed, since that would be consistent with its
>>>         behavior on files that haven't changed.
> [...]
>> I may have a different understanding of git commands than you do,
>> but a plain "checkout -f" with no further arguments is the same as
>> a hard reset IMHO, and could be used interchangeably?
>
> A kind person pointed out privately that you were talking about
> "git checkout -f" with no further arguments, not "git checkout -f
> <commit>".  In that context, the competing meanings I mentioned in
> https://crbug.com/git/5 don't exist: either a given entry in the
> worktree matches the index or it doesn't.
>
> So plain "git checkout -f" is similar to plain "git reset --hard"
> in that it means "make the worktree (and index, in the reset case)
> look just like this".

with "this" == the argument that was given, if the argument
was omitted, HEAD is assumed.

>  checkout -f makes the worktree look like the index;

No, here is what my installation of git (recent master) does:

  $ git --version
git version 2.15.1.389.g52015aaf9d

  $ cat test.sh

  rm -rf tmp
  git init tmp

  cd tmp
  git commit --allow-empty -m initial
  echo commit >a
  echo commit >b
  echo commit >c
  git add .
  git commit -m commit

  echo index >a
  git add a
  echo worktree >a

  echo index >b
  git add b

  echo worktree>c

  $ sh test.sh
Initialized empty Git repository in /u/tmp/.git/
[master (root-commit) c109fb5] initial
[master fcc21ea] commit
 3 files changed, 3 insertions(+)
 create mode 100644 a
 create mode 100644 b
 create mode 100644 c
  $ cd tmp
  $ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

modified:   a
modified:   b

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

modified:   a
modified:   c

  $ git checkout -f
  $ git status
On branch master
nothing to commit, working tree clean

# Let's test the other commands as well:
  $ cd ..
  $ sh test.sh
   ...
  $ cd tmp
  $ git checkout -f HEAD
  $ git status
On branch master
nothing to commit, working tree clean

  # See, there is no difference between giving HEAD as an argument
  # or not! Try again with reset just for completeness:

  $ cd ..
  $ sh test.sh
   ...
  $ cd tmp
  $ git reset --hard
HEAD is now at b71ae70 commit
  $ git status
On branch master
nothing to commit, working tree clean

  # The only difference between reset and the checkout is that reset
  # tells me where we are.

> reset --hard makes the worktree and index look like HEAD.

I agree.

> In that context, more aggressively making the submodule in the
> worktree get into the defined state sounds to me like a good change.
>
> Hopefully my confusion helps illustrate what a commit message focusing
> on the end user experience might want to mention.

I'll try to come up with a better commit message. Thanks for bearing
with me here.

Stefan


>
> Thanks again,
> Jonathan
