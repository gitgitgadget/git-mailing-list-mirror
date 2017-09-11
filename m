Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4F671FAD6
	for <e@80x24.org>; Mon, 11 Sep 2017 17:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbdIKRMW (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 13:12:22 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:33610 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbdIKRMV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 13:12:21 -0400
Received: by mail-wr0-f173.google.com with SMTP id a43so16059485wrc.0
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 10:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ucJsMeLDcfugv+YIwKVJYcvyjM0ezrMRqSoI//rfPwI=;
        b=GXofsBOUl/cy2RnzRsjGBLDZYxdZbbVYkbPlUXN7C3mU4CfyfTRsnAdFrjT+IjwT2W
         o0Jdcx10lFDm7sYGwhsmy0WtTn7l7jfMDl1Suf979D7W6Bh0j2qZDyoQuQwsvmrAKXIK
         WMyMzEcqpZztiqXBvSuY/GLeNPGnpRReiwh8p6VttobeJbxzKqcYzcyHH+Hy9yom8Yqp
         ijavo+mrUeX89zFfzbQMArcN1EuNbMZMRfhNwJdB2LbXdsI36iNr6QubGo6UD6526Twy
         qTV7GnKErXeoFKPeCNNlYVJv3BsqDccqvZ3Or9kHkkhnlpRyVVZH6TC+IoFzcWBX/pCX
         kz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ucJsMeLDcfugv+YIwKVJYcvyjM0ezrMRqSoI//rfPwI=;
        b=IFtVkvudAwudoPvQsX9/W7kiUpdGJvz2FIDfdfcvMKGQ1KSMIkLYbDSQP74aMfbWXm
         NXszlvAzQA/ffoDN12c7mFqtOZcvDVIgoRGF+08rAvKX091My20BBbwsE5hTXahNV9kK
         j0PEjbItGt0H+oFpOoAoP1aeJmIlIwf7wwBdei5Hu3WKdFZbGhIuumszEN7IDV0iMKmN
         tNLEdEI3n1O6B3hSGzcHBI9rWPx+7WbVG6ANysGz3vSx8tBc4A/FHeMJdtsY/ieJ4E+N
         v8v1XOUmWWKyVkySB4GQxW1TqzpxM+PcCN3YOwMJzhRi2mci8ZRskvOOBeeKeQnB2Ro6
         SLvw==
X-Gm-Message-State: AHPjjUiC5QECUXmCsC50hlRqsCQaXsi6vXnfqJQ8p4CLsyBGJHhL2WFu
        MaB4KSGH17nIdhe0HCR1q0qbIEvAr+lxF2crNg==
X-Google-Smtp-Source: ADKCNb5hy4KwHt5tWD92rslkXND1YlYBLAsCt++t8hJGoVKfnF8bEpkJ/Q3LJ/9J30npJ54+3mfezXpUY7HBiPbXmqo=
X-Received: by 10.223.138.238 with SMTP id z43mr9050388wrz.83.1505149939283;
 Mon, 11 Sep 2017 10:12:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.170.68 with HTTP; Mon, 11 Sep 2017 10:12:18 -0700 (PDT)
In-Reply-To: <xmqqr2vi0z7q.fsf@gitster.mtv.corp.google.com>
References: <xmqqd174bzco.fsf@gitster.mtv.corp.google.com> <20170907220429.31312-1-sbeller@google.com>
 <xmqqr2vi0z7q.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 11 Sep 2017 10:12:18 -0700
Message-ID: <CAGZ79kZCQq8ts6RAN2Qz5vWtUh7swu0UWO_6LTaRhNF5sDbnDg@mail.gmail.com>
Subject: Re: [PATCHv3] builtin/merge: honor commit-msg hook for merges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 7, 2017 at 6:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> .... The --no-verify option however is not remembered across invocations
>> of git-merge. Originally the author assumed an alternative in which the
>> 'git merge --continue' command accepts the --no-verify flag, but that
>> opens up the discussion which flags are allows to the continued merge
>> command and which must be given in the first invocation.
>
> This leaves a reader (me) wondering what the final conclusion was,
> after the author assumed something and thought about alternatives.

I did not draw a conclusion, I was just saying, that this has to be
thought about.
It looks to me as if --continue currently wants to take no extra arguments,
but to remember all flags from the previous invocation of merge.

But that only looks this way as all the command line flags are related
for tree manipulation, not (indirect) commit message manipulation.

So I think having --no-verify be respected (either by restating, or by
remembering, or both) by the `git merge --continue` call would be a
reasonable thing to want.

So that new patch just added the test as a #needswork for the future,
not actually making a decision how to approach it.

> I am guessing that your final decision was not to remember
> "--no-verify" so a user who started "merge --no-verify" that stopped
> in the middle must say "merge --continue --no-verify" or "commit
> --no-verify" to conclude the merge?  Or you added some mechanism to
> remember the fact that no-verify was given so that "merge --continue"
> will read from there, ignoring "merge --continue --verify" from the
> command line?  Not just the above part of the log message confusing,
> but there is no update to the documentation, and we shouldn't expect
> end-users to find out what ought to happen by reading t7504 X-<.

Interestingly the documentation that I read to approach the problem
is already in shape as it would not specify the specific command for the
'--no-verify' option. I missed that we need to add documentation for
the continued merge case.

> The new test in t7504 tells me that you remember --[no-]verify from
> the initial invocation and use the same when --continue is given; it
> is unclear how that remembered one interacts with --[no-]verify that
> is given when --continue is given.  It is not documented, tested and
> explained in the log message.  I would expect that the command line
> trumps what was given in the initial invocation.

I would expect that, too.

>
>
>> +static int verify_msg = 1;
>>
>>  static struct strategy all_strategy[] = {
>>       { "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
>> @@ -236,6 +237,7 @@ static struct option builtin_merge_options[] = {
>>         N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
>>       OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
>>       OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
>> +     OPT_BOOL(0, "verify", &verify_msg, N_("verify commit-msg hook")),
>>       OPT_END()
>>  };
>
> I suspect that the previous iteration gives a much better end-user
> experience when "git merge -h" is used.  This will give the
> impression that the user MUST say "merge --verify" if the user wants
> to verify commit-msg hook (whatever that means), but because the
> option defaults to true, that is not what happens.  The user instead
> must say "merge --no-verify" if the verification is unwanted.

ok, will revert to that in a resend.

>> +test_expect_failure 'merge --continue remembers --no-verify' '
>> +     test_when_finished "git branch -D newbranch" &&
>> +     test_when_finished "git checkout -f master" &&
>> +     git checkout master &&
>> +     echo a >file2 &&
>> +     git add file2 &&
>> +     git commit --no-verify -m "add file2 to master" &&
>> +     git checkout -b newbranch master^ &&
>> +     echo b >file2 &&
>> +     git add file2 &&
>> +     git commit --no-verify file2 -m in-side-branch &&
>> +     git merge --no-verify -m not-rewritten-by-hook master &&
>> +     # resolve conflict:
>> +     echo c >file2 &&
>> +     git add file2 &&
>> +     git merge --continue &&
>> +     commit_msg_is not-rewritten-by-hook
>>  '
>
> OK.  What should happen when the last "merge --continue" was given
> "--verify" at the same time?

Currently not possible, due to --continue requiring that it is the
only argument. In the future where --continue works well with other
arguments, we should override the original.

> A similar test whose title is
> "--no-verify remembered by merge --continue can be overriden" may be
> a good thing to follow this one, perhaps?

Note that this is already test_expect_failure, which I used to mark
that this particular flag is broken across a --continue invocation of git-merge,
so I would not add yet another test that describes the future yet to be
implemented?

Thanks.
