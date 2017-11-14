Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED35D201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 01:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752456AbdKNBVw (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 20:21:52 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:53964 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752386AbdKNBVv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 20:21:51 -0500
Received: by mail-qt0-f172.google.com with SMTP id n61so22010434qte.10
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 17:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JJy+DFNGR+GPXzy5XnjGmZDURUu5K8/KLPB1ujvxU/4=;
        b=oaiE1q1L9qNTuq2FGwP/jz7oqCEJOGzOe+GJ1V2A/PNcknhgOgVQR3Xy5JhE01EASm
         cAaJcMJBEqm+//YVWcr4PzOVIAEIVql2I/UmWXuyGV1H0ZrIZ/GWYZbq+Ega42TTDtV8
         w6UEVop4alU7GzLuhOhLds+xjDeHxCwlNL17+PPGWGtsfAcyl7QJehTnz2FYXdT3Ke0A
         0jupXPlTjdKWU8/+ACPSh6hRZ5NnNRD1sDKgUtUL1GzejiQcO3Ll1etmbPdtDxqpKosF
         QqHfzo7k+CMZYOxNdcgFjEqLzCIvRJJefTQs/4fTAZCZvqsT3tarX66oFBmLrby9fIvH
         apXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JJy+DFNGR+GPXzy5XnjGmZDURUu5K8/KLPB1ujvxU/4=;
        b=mTzlYeQtj2Bw+mA1rveUa4W52aUFXVUDlhmFreUxW3wkE8eNe/WrBdV2EwaK25vE/E
         EJpOjx2MnR4bP1VevPpaTnzXkMqLyINM4EG1IojvOuIc704U5P/e89N7JN/Y95Jr9dfB
         HphCskIWPY72sLH1PTJBfiZQVpdn0iGVbi+gTzwYLb0Qy0tH7KndSLsHRzB5wSpteIXs
         ixIcZPLznfpgqeirC5YspX4mYwCAnN7bYEl6kqobZstU2z/v/Yk39enYra8Vfyj465io
         mKuKcQlpOqVtZ5WRybJpXvpEtQtBbDbFPXv1g71y/lCEAiyqOzITVjoAHzLPHkavtERI
         I15g==
X-Gm-Message-State: AJaThX7iWU0edexdFzD7TpWJknUnDsrIwBo5Po8tWD7opAGJyGFDz/ov
        U4dMheenuLsD+MO1tfi1NqddPIv3TQ8nKPmU4xz3Bc5mQTg=
X-Google-Smtp-Source: AGs4zMYJTPaNqiio2aULHKTtizZhlBqA/eX6j7B2woBFDKfd84e0i4mrKz9V5QL/Bs8ulJIlZptWyAZBVfBRU4TNj1w=
X-Received: by 10.200.54.86 with SMTP id n22mr16250433qtb.224.1510622510337;
 Mon, 13 Nov 2017 17:21:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 13 Nov 2017 17:21:49 -0800 (PST)
In-Reply-To: <CABPp-BFKiam6AK-Gg_RzaLuLur-jz0kvv3TqsHNHg5+HTv_uzA@mail.gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-5-newren@gmail.com>
 <CAGZ79kbmt7jt13D-HY90+LBaCHsqvDOYnrmJ41hR3YsgEceirg@mail.gmail.com> <CABPp-BFKiam6AK-Gg_RzaLuLur-jz0kvv3TqsHNHg5+HTv_uzA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Nov 2017 17:21:49 -0800
Message-ID: <CAGZ79kbK-deKq4KR-G5nq8MoCNK77hbr_B32W6Uo4i5Kq4_ojg@mail.gmail.com>
Subject: Re: [PATCH 04/30] directory rename detection: basic testcases
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 4:57 PM, Elijah Newren <newren@gmail.com> wrote:
> On Mon, Nov 13, 2017 at 2:04 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:
>> (minor thought:)
>> After rereading the docs above this is clear; I wonder if instead of A, B, C
>> a notation of Base, ours, theirs would be easier to understand?
>
> Sure, that'd be an easy change.
>
>>> +test_expect_success '1a-setup: Simple directory rename detection' '
>>> +test_expect_failure '1a-check: Simple directory rename detection' '
>>
>> Thanks for splitting the setup and the check into two different test cases!
>>
>>
>>> +       git checkout B^0 &&
>>
>> Any reason for ^0 ? (to make clear it is a branch?)
>
> Partially force-of-habit (did the same with t6036 and t6042), but it
> seemed to have the nice feature of making debugging easier through
> improved reproducability.  In particular, if I had checked out B
> rather than B^0 in the testcase and a merge succeeded when I didn't
> expect it, then attempting to run the same commands gives me a
> different starting point for the merge.  By instead explicitly
> checking out B^0, then even if the merge succeeds, someone who again
> runs checkout B^0 will have the same starting point.

Thanks for enlightening me. Makes sense.

>
>>> +test_expect_success '1b-setup: Merge a directory with another' '
>>> +       git rm -rf . &&
>>> +       git clean -fdqx &&
>>> +       rm -rf .git &&
>>> +       git init &&
>>
>> This is quite a strong statement to start a test with.
>
> It was actually copy-paste from t6036, and achieved two purposes:
>   1) Even if one test fails, subsequent ones continue running.  (Had
> lots of problems with this in t6036 years ago and just ended up with
> those four steps)
>   2) Someone who runs into a failing testcase has a _much_ easier time
> figuring out what is going on with the testcase.  I find it takes a
> fair amount of time to figure out what's going on with other tests in
> git's testsuite because of the presence of so many files completely
> unrelated to the given test, which have simply accumulated from
> previous tests.  For many tests, that may be fine, but in particular
> for t6036, t6042, and now t6043, since these are mostly about corner
> cases that are hard enough to reason about, I didn't want the extra
> distractions.

I agree with these reasons to strongly want a clean slate.

>> Nowadays we rather do
>>
>>     test_when_finished "some command" &&
>>
>> than polluting the follow up tests. But as you split up the previous test
>> into 2 tests, it is not clear if this would bring any good.
>
> test_when_finished looks pretty cool; I didn't know about it.  Thanks
> for the pointer.  Not sure if we want to use it here (if we do, we'd
> only do so in the check tests rather than the setup ones).
>
>> Also these are four cleanup commands, I'd have expected fewer.
>> Maybe just "rm -rf ." ? Or as we make a new repo for each test case,
>>
>>     test_create_repo 1a &&
>>     cd 1a
>>
>> in the first setup, and here we do
>>     test_create_repo 1b &&
>>     cd 1b
>>
>> relying on test_done to cleanup everything afterwards?
>
> rm aborts for me with 'rm -rf .', but I could possibly make it 'rm -rf
> * .* && git init .'
>
> The test_create_repo might not be so bad as long as every test used it
> and put all files under it's own little repo.

That is my current favorite, I would think.


>  It does create some
> clutter, but it's at least somewhat managed.

But the clutter is outside the repository under test, which
may help with the situation.

> I'm still a bit partial
> to just totally cleaning it out, but if others would prefer, I can
> switch.

(slightly dreaming:)
I wonder if we could teach our test suite to accept multiple test_done
or restart_tests or such to resurrect the clean slate.

>
>>> +       test 3 -eq $(git ls-files -s | wc -l) &&
>>
>>     git ls-files >out &&
>>     test_line_count = 3 out &&
>>
>> maybe? Piping output of git commands somewhere is an
>> anti-pattern as we cannot examine the return code of ls-files in this case.
>
> Um...I guess that makes sense, if you assumed that I cared about the
> return code of ls-files.

As this is the test suite, we care about the return code of any git
command, for current git as well as future-gits.

>  But it seems to make the tests with multiple
> calls to ls-files in a row (of which there are many) considerably
> uglier, so I'd personally prefer to avoid that.  Also, why would I
> care about the return code of ls-files?

While I understand the rationale here and your examination of ls-files
seems to indicate that we are ok doing it here, a lot of (test) code
is taken for inspiration (copied, adapted) to other test cases.
And most of the time we actually care if the return code is correct
additionally to the actions performed, so I was shooting from the hip
here.

> Your suggestion made me curious, so I went looking.  As far as I can
> tell, the return code of ls-files is always 0 unless you both specify
> both --error-unmatch and one or more paths, neither of which I did.
> Am I missing something?

I am not saying it was a cargo-culting reaction, but rather relaying
a well discussed style issue to you. ;)


> If you feel the return code of ls-files is important, perhaps I could
> just have a separate
>    git ls-files -s >/dev/null &&
> call before the others?

I would prefer to not add any further calls; also (speaking generically)
this would bring in potential racing issues (what if the second ls-files
behaves differently than the first?)

>>> +       test $(git rev-parse HEAD:y/b) = $(git rev-parse A:z/b) &&
>>> +       test $(git rev-parse HEAD:y/c) = $(git rev-parse A:z/c) &&
>>> +       test $(git rev-parse HEAD:y/d) = $(git rev-parse A:x/d) &&
>>
>> Speaking of these, there are quite a lot of invocations of rev-parse,
>> though it looks clean; recently Junio had some good ideas regarding a
>> similar test[1].
>> So maybe
>>
>>   git rev-parse >actual \
>>     HEAD:y/b  HEAD:y/c HEAD:y/d &&
>>   git rev-parse >expect \
>>     A:z/b    A:z/c    A:x/d &&
>>   test_cmp expect actual
>>
>> Not sure if that is any nicer, but has fewer calls.
>
> Sure, I can switch it over.

Well, that was also just a quick suggestion, maybe we'll find an
even nicer way that has also very few invocations.

>>> +
>>> +# Testcase 1e, Renamed directory, with all filenames being renamed too
>>> +#   Commit A: z/{oldb,oldc}
>>> +#   Commit B: y/{newb,newc}
>>> +#   Commit C: z/{oldb,oldc,d}
>>
>> What about oldd ?
>> (expecting a pattern across many files of s/old/new/ isn't unreasonable,
>> but maybe too much for now?)
>> By having no "old" prefix there is only one thing to do, which is y/d
>
> I'm not following.  The "old" and "new" in the filenames were just
> there so a human reading the testcase could easily tell which
> filenames were related and involved in renames.  There is no rename
> associated with d, so why would I have called it "old" or "new"?

because a user may be impressed by gits pattern matching in the
rename detection:

 A: z/{oldb,oldc}
 B: z/{newb,newc}
 C: z/{oldb, oldc, oldd}

Obviously A->B is z/{old->new}-* (not a directory rename,
but just patterns), so one might be tempted to expect newd
as the expectation. But that is nonsense(!?)

>
>   * Users sometimes rename directories on one side of history and add
> files to the original directory on the other side.
>   * We would like to "detect" the directory rename, and move the new
> files into the correct directory.
>   * We don't really have any hints for detecting directory renames
> other by comparing content, i.e. basing it on the file rename
> detection we already have.
>   * There is a possibility that not all files in a certain directory
> went to the same location.  It's possible that a few may have gone
> elsewhere.
>   * Only in weird corner cases would I expect renamed-file location to
> be split nearly 50-50 (as in this contrived testcase) -- although for
> such cases, as you point out, there is a much higher chance of us
> getting the merge "wrong".  Thus, our rule should be simple so people
> can understand and expect what we did and have an easy time fixing it.

Makes sense

>
> So, what to do?  There are a few options:
>   1) Don't do directory rename detection at all.  Just declare it to
> be an anti-feature.
>   2) Try to guess why the user moved different files to different
> directories and try to mimic that somehow.
>   3) Only allow directory rename detection to happen when ALL renamed
> files in the directory went to the same directory.
>   4) Use a simple predictable rule like majority wins.

I wonder if eventually (down the road, not now) we would want to
also teach custom merge/diff drivers about potential dir renaming.
(Well not these drivers itself, but rather a method by which a custom diff
driver can tell us to use another custom rule for thees rename detections)

>
> I think 2 is insanity.

or the place where hooks/custom code shines. :)

> Choices 1 and 3 don't have much appeal to me;
> I'm strongly against them.  I'm unware of any remaining choices other
> than 4, but 4 seems pretty reasonable to me.  It won't always be
> right, but neither is simple content merging.

That makes sense, thanks!
Stefan
