Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 032DA1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 19:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbcG1Toc (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 15:44:32 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:36072 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbcG1Tob (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 15:44:31 -0400
Received: by mail-it0-f43.google.com with SMTP id f6so176353606ith.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 12:44:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iqbyKMF3bMwTNXIaRnwsFxeqT/pqyFpqyaKit1Nc3iY=;
        b=a/uuHwmHW5M7PAl14FdR6gbL+wSjWZZo6CGzIwCIKplI3xxkV0Fn0TeHrdUByvS+U/
         ikO6WAzgay0iDAiCTE7WoCunBKYz1VpNaX1oX8rEu54y9FT+NUsYz9PZrXM5zvlEJoi7
         hYFiOhjyH9WL/7wtv4LG7vvCgJwNkgRH0hobWnEaRaEaZxCpbXwjoqgtslkp3BXSZMRm
         7z68lo9qnPKHazYSolANUWzBGpblSG4cO22c7at+oa8/zCJok1XY0DyqRzp0HrqRNCn8
         YS6+NND3Y6kG+S5EH6inl4zPdQTnmprbE6KzrpIaR2XyXARaQAJPayyPyPd88B3Dzz6u
         UAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iqbyKMF3bMwTNXIaRnwsFxeqT/pqyFpqyaKit1Nc3iY=;
        b=eZfCnNseBDaNN5dMQyEh6frUO/C/L8BVf/PS6fUmzzsWYpWMjh1xiFZ4CeJ7ETpZFh
         2H9Kn/F7RggT48wYncf8jA4tVLTJKvEQGZgJ1wQ5c3cr8VWn6/SJLM6+scOObJ7/OwSE
         yljVjOFoKGKK1gQGpIWUPw1Vo3XZbPUmSXTQcP303mbkFdLRN88IQOkuz2NrO1yZyza1
         QVtIjnwPvZwWU5TE4va0dqsU3uhX6r34pR5rhBnOu49gPqBD0aTgd9bd+xn/K3OQlq8k
         gq6z62Ny9iyJTYc/dKmWF68LMLhgumffivhuJh7MfjfFQhNSf/LqsqrFBgeOpYivkiHO
         dlAQ==
X-Gm-Message-State: ALyK8tKgbRt4mya18wiFFQ0o7pFJSoNalpc/NArt2LphQP++ULLgMiJ+aMejw/Wqq7Dosw3bGahvgbUH6UKSIWUW
X-Received: by 10.36.228.138 with SMTP id o132mr102424040ith.49.1469735068751;
 Thu, 28 Jul 2016 12:44:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 28 Jul 2016 12:44:28 -0700 (PDT)
In-Reply-To: <xmqq7fc5shnl.fsf@gitster.mtv.corp.google.com>
References: <20160728172641.8376-3-sbeller@google.com> <20160728182132.25088-1-sbeller@google.com>
 <xmqq7fc5shnl.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 28 Jul 2016 12:44:28 -0700
Message-ID: <CAGZ79kactn4VZ5i+fCrBGa77dzFiTngAgVU3R1orz2=EMAZ1Jg@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] submodule update: allow '.' for branch value
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 12:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Gerrit has a "superproject subscription" feature[1], that triggers a
>> commit in a superproject that is subscribed to its submodules.
>> Conceptually this Gerrit feature can be done on the client side with
>> Git via:
>>
>>     git -C <superproject> submodule update --remote --force
>>     git -C <superproject> commit -a -m "Update submodules"
>>     git -C <superproject> push
>>
>> for each branch in the superproject.
>
> Which I imagine would be useful if you only have one submodule.  If
> you work on submodules A and B and then want to give the updated
> superproject that binds the latest in both A and B as an atomic
> update, the three lines above would not quite work, no?

When using Gerrit you can submit A,B together bound by a "topic"
and that will trigger a superproject update that contains one
atomic commit updating A and B at the same time.

To fully emulate that Gerrit feature you would need to put
the 3 lines above in an infinite loop that polls the remote
submodules all the time.

If you wanted to do that without that Gerrit feature,
this becomes racy as "submodule update --remote"
fetches the submodules racily (by design) and it may end
up putting A and B in the same commit or not.


>
>> To ease the configuration in Gerrit
>> a special value of "." has been introduced for the submodule.<name>.branch
>> to mean the same branch as the superproject[2], such that you can create a
>> new branch on both superproject and the submodule and this feature
>> continues to work on that new branch.
>>
>> Now we have find projects in the wild with such a .gitmodules file.

I'll fix the typo. (delete have or find)

>
> That's annoying.
>
>> To have Git working well with these, we imitate the behavior and
>> look up the superprojects branch name if the submodules branch is
>> configured to ".". In projects that do not use Gerrit, this value
>> whould be never configured as "." is not a valid branch name.
>
> I find that the last sentence is somewhat misleading.  I agree it is
> justifiable that using "." as the name to trigger a new (to us)
> feature is safe, because such a setting wouldn't have meant anything
> useful without this change, but I initially misread it and thought
> you added "are we using Gerrit?  Error out if we are not" logic,
> which is not the case here.

Well I wanted to express:

  The .gitmodules used in these Gerrit projects do not conform
  to Gits understanding of how .gitmodules should look like.
  Let's make Git understand this Gerrit corner case (which you
  would only need when using Gerrit).

  Adding special treatment of the "." value is safe as this is an
  invalid branch name in Git.


>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 4ec7546..1eb33ad 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -590,7 +590,6 @@ cmd_update()
>>
>>               name=$(git submodule--helper name "$sm_path") || exit
>>               url=$(git config submodule."$name".url)
>> -             branch=$(get_submodule_config "$name" branch master)
>>               if ! test -z "$update"
>>               then
>>                       update_module=$update
>> @@ -616,6 +615,14 @@ cmd_update()
>>
>>               if test -n "$remote"
>>               then
>> +                     branch=$(get_submodule_config "$name" branch master)
>> +                     if test "$branch" = "."
>> +                     then
>> +                             if ! branch=$(git symbolic-ref --short -q HEAD)
>> +                             then
>> +                                     die "$(eval_gettext "submodule branch configured to inherit branch from superproject, but it's not on any branch")"
>> +                             fi
>> +                     fi
>
> I see that you narrowed the scope of "$branch" (which is only used
> when $remote exists), but it is a bit annoying to see that change
> mixed with "now a dot means something different" change.
>
> I wonder if the above 8-line block wants to be encapsulated to
> become a part of "git submodule--helper" interface, though.  IOW,
> branch=$(git submodule--helper branch "$name") or something?

There is already get_submodule_config that we implement in shell,
which is also used in cmd_summary for reading the .ignore
field.

So having the "." check in that method (whether in shell or in C)
doesn't make sense to me.

We could of course have our own method specific for branches,
that take the "." into account. I think we can go with that.

>
>> +test_expect_success 'submodule update --remote should fetch upstream changes with .' '
>> +     (cd super &&
>> +      git config -f .gitmodules submodule."submodule".branch "." &&
>> +      git add .gitmodules &&
>> +      git commit -m "submodules: update from the respective superproject branch"
>> +     ) &&
>>       (cd submodule &&
>> +      echo line4a >> file &&
>> +      git add file &&
>> +      test_tick &&
>> +      git commit -m "upstream line4a" &&
>> +      git checkout -b test-branch &&
>> +      test_commit on-test-branch
>> +     ) &&
>> +     (cd super &&
>> +      git submodule update --remote --force submodule &&
>> +      (cd submodule &&
>> +       test "$(git log -1 --oneline)" = "$(GIT_DIR=../../submodule/.git git log -1 --oneline master)"
>
> A few issues:
>
>   * A crash in "git log" would not be noticed with this.  Perhaps
>
>         git log -1 --oneline $one_way_to_invoke >expect &&
>         git log -1 --oneline $the_other_way >actual &&
>         test_cmp expect actual
>
>     would be better?

Of course. I tried to blend in with the code after looking at the surrounding
code. Maybe I need to modernize that whole test file as a preparatory step.

>
>   * What exactly is this testing?  The current branch (in submodule)
>     pointing at the same commit as the tip of 'master'?  Or the
>     current branch _is_ 'master'?
>
>   * What exactly is the reason why one has GIT_DIR=... and the other
>     does not?  I do not think this a place to test that "gitdir: "
>     in .git points at the right place, so it must be testing
>     something else, but I cannot guess.

It is testing that the local state is at the same commit as the
master branch on the remote side.
(GIT_DIR=../../submodule/.git is saying to be "remote", and "master"
to check that branch. We need to have master here as we configured
"." and have the master branch checked out in the superproject.)

At least that is my understanding from the existing tests for
the  "--remote" flag

>> +     (cd super &&
>> +      git checkout --detach &&
>> +      # update is not confused by branch="." even if the the superproject
>> +      # is not on any branch currently
>> +      git submodule update &&
>> +      git revert HEAD &&
>
> "revert" is rather unusual thing to see in the test.

The tests are so long that I tried to get back in a state that is as least
different from before to not break the following tests.
(And except for the depth this worked well)

> Also I am not
> sure why cmd_update that now has an explicit check to die when
> branch is set to "." and the head is detached is expected "not" to
> be confused.  Perhaps I misread the main part of the patch?

Well you *only* explicitly die(..) when you ask for --remote.
If the superproject is on a detached HEAD and just wants the
sha1s as recorded (--no-remote), it doesn't care about the recorded
branch value and should *not* die.
