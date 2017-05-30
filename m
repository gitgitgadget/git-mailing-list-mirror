Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B071C1FD09
	for <e@80x24.org>; Tue, 30 May 2017 12:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbdE3MB4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 08:01:56 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33062 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbdE3MBz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 08:01:55 -0400
Received: by mail-qk0-f174.google.com with SMTP id y201so66310995qka.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 05:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QWSFa+HvAIg/77EsnPihU5MOteCnZI2RIhNkKoaTwcM=;
        b=rQ1aQvqRe+GsrP6OinjtVt5CGn2Nw8LgqYbksmdGJcBnTmHeZLl28XHS/bsikVNFgS
         QOjMbow74u1kTAe0lO+L5qdNFOCnwIEGdmmQynNQah3b0BYhAsr13pwwV8cwloFUz33p
         uPb4fDlkg1msILQo4WzFOIUqi1gQQWgKrCw+9ilqmH8OD05ja67UmJRKv+Hkd/h0tMiD
         W+gh39u+ehQ3C5zmlSnED3XZZC3m/+AYJgybwoKbUpsPzEMs56cepTEosaeRr4DW9T8J
         yKYwF0kV9DnWRxXCGaeIxleS9fdJ2Fj+HLlFVv/fiy7E9YNL8HF8ffH7q5TTyYHMXX4F
         Qo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QWSFa+HvAIg/77EsnPihU5MOteCnZI2RIhNkKoaTwcM=;
        b=KlyrHP5U4N/5LH2JHim4HVecsg07f+J4AiwSCilhlrH/HE5tH/6+0/GW/+ROuUQZgw
         6Mlio6qlbSDJdompfE83CoSx59eCOM9DuxXrxb61p+dSBcJaFnvjMXAN15QQKbey/PVG
         1/ci2EHIEKb2w0z3JCALllhSTdHgowdZyGYyw7kqcPhZzg7+CLGonwsPyvxNTlkmBV5y
         +MVBBDixpgXqlSFHvpEnw9zxSEwDntLwzDRIugL2rovKR44gmL9LM+IYf0Nb7Mx8S958
         4wzL/+FPjT95eVYAvNtngA6XK95N31pMFo6QBx7yhRG+bkUzkjMysyRrDvb5qZG8MCYk
         BRXQ==
X-Gm-Message-State: AODbwcDrqz8LnjqvRAn8vOKY8zpUM8jMrGkmmnW/H9JnNImnGMq3UvP4
        oGTp4QG21G2r2V9qeJ0vMJKyEHKC1w==
X-Received: by 10.55.175.199 with SMTP id y190mr20386486qke.155.1496145713900;
 Tue, 30 May 2017 05:01:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.86.48 with HTTP; Tue, 30 May 2017 05:01:33 -0700 (PDT)
In-Reply-To: <CAGZ79kYHNpsasqhTY2WrCYgNU1if-pK7UznJV9AWEhxVf6_GvQ@mail.gmail.com>
References: <CAE5=+KX57KM+6n9NpePw9KYPXFy7UH-WRgSwaJDnvRofYFXm7Q@mail.gmail.com>
 <xmqqinkk8jqm.fsf@gitster.mtv.corp.google.com> <CAGZ79kYHNpsasqhTY2WrCYgNU1if-pK7UznJV9AWEhxVf6_GvQ@mail.gmail.com>
From:   John Shahid <jvshahid@gmail.com>
Date:   Tue, 30 May 2017 08:01:33 -0400
Message-ID: <CAE5=+KWzhhn3b14WoCXQD4Qb2gLd5soQQAUk7NTZeZnGgV61DA@mail.gmail.com>
Subject: Re: git push recurse.submodules behavior changed in 2.13
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio, sorry for the poor report. I totally forgot to describe the
behavior that i'm currently getting vs what i expect.

Expected behavior:

We have a parent repo on a branch called "develop" and a submodule on
a branch called "master". Prior to git version 2.13 if we had an
unpushed commit in the submodule and ran "git push origin develop
--recurse-submodules=on-demand" git would happily push the develop
branch of the parent repo and the master branch of the submodule,
e.g.:

> Pushing submodule 'sub'
> Counting objects: 2, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (2/2), done.
> Writing objects: 100% (2/2), 242 bytes | 0 bytes/s, done.
> Total 2 (delta 0), reused 0 (delta 0)
> To /home/jvshahid/codez/git/t/trash directory.t9904-diff-branch-submodule-push/sub.git
>    3cd2129..69cbc06  master -> master
> Counting objects: 2, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (2/2), done.
> Writing objects: 100% (2/2), 283 bytes | 0 bytes/s, done.
> Total 2 (delta 0), reused 0 (delta 0)
> To ../pub.git
>    7ff6fca..945bc12  develop -> develop
> ok 2 - push if submodule has is on a different branch

Actual behavior:

After the change mentioned in my previous email, git would propagate
the refspec from the parent repo to the submodule, i.e. it would try
to push a branch called "develop" in the submodule which would error
since no branch with that name exist in the submodule. Here is a
sample output with git v2.13.0:

> pushing to ref refs/heads/develop:refs/heads/develop
> pushging to remote origin
> fatal: src refspec 'refs/heads/develop' must name a ref
> fatal: process for submodule 'sub' failed
> fatal: The remote end hung up unexpectedly

I hope this clarifies my bug report.

Stefan, one little correction. I don't think the commit called out
this behavior. The commit message was talking about unconfigured
remotes (i.e. pushing to a url or local path) to not propagate the
refspec and preserve the current behavior. Judging from the code and a
test case that I wrote, this behavior is working as expected. That is,
git won't propagate the refspec.

Cheers,

JS

On Mon, May 29, 2017 at 12:20 AM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, May 28, 2017 at 7:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> John Shahid <jvshahid@gmail.com> writes:
>>
>>> It looks like the git push recurse-submodules behavior has changed.
>>> Currently with 2.13 you cannot run "git push
>>> --recurse-submodules=on-demand" if the parent repo is on a different
>>> branch than the sub repos, e.g. parent repo is on "develop" and
>>> sub-repo on "master". I created a test that can be found here [1].
>>>
>>> A bisect shows that the change to propagate refspec [2] to the
>>> submodules is the culprit. imho this is an undesired change in
>>> behavior. I looked at the code but couldn't see an easy way to fix
>>> this issue without breaking the feature mentioned above. The only
>>> option I can think of is to control the refspec propagation behavior
>>> using a flag, e.g. "--propagate-refspecs" or add another
>>> recurse-submodules option, e.g. "--recurse-submodules=propagate"
>>>
>>> What do you all think ?
>>>
>>> [1] https://gist.github.com/jvshahid/b778702cc3d825c6887d2707e866a9c8
>>> [2] https://github.com/git/git/commit/06bf4ad1db92c32af38e16d9b7f928edbd647780
>>
>> Brandon?  I cannot quite tell from the report what "has changed"
>> refers to, what failures "you cannot run" gets, and if that is a
>> desirable thing to do (i.e. if letting the user run it in such a
>> configuration would somehow break things, actively erroring out may
>> be a deliberate change) or not (i.e. an unintended regression).
>>
>
> Before the refspec was passed down into the submodules,
> we'd just invoke "git push" in the submodule assuming the user
> setup a remote tracking branch and a push strategy such that
> "git push" would do the right thing.
> And because the submodule is configured independently, it
> doesn't matter which branch you're on in the superproject.
>
> Looking at the test[1], you run "git push --recurse-submodules"
> without any remote/branch that was called out in the commit
> message[2] to not have changed. Is that understanding correct?
>
> Looking at the test cases of [2] we did not test for explicit
> "still works with no args given", though one could have expected
> we'd have a test for that already. :/
>
> Thanks,
> Stefan
