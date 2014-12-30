From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] git-rebase documentation: explain the exit code of custom commands
Date: Tue, 30 Dec 2014 10:25:31 -0800
Message-ID: <CAGZ79kZsQpvNzGPYuS64Cx2hFoozcb2HxU9Chd1__5=kkE-WjQ@mail.gmail.com>
References: <1419892207-26687-1-git-send-email-sbeller@google.com>
	<xmqqr3vhrqjn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 19:25:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y61UA-0007C1-3q
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 19:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbaL3SZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 13:25:33 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:62377 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbaL3SZc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 13:25:32 -0500
Received: by mail-ie0-f181.google.com with SMTP id rl12so11737495iec.26
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 10:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pEcXkCd4+idNHmf+XH8UdHbqufT38RyVQazfPyXEoZc=;
        b=b9XZUrC7n1CpeiCDc3TOJNaKMzwmrByaF/zw1JKjwGD+Zgs6qblz4X/jQG5R+iQaH5
         RGu8uLOTh4jNSs4H8RB+aBs5KqjIeO6HgprRxVOXnjlYjTggw5g1IZHBXNfa7zEjxvSV
         wjFuJKa7c0A0bzhQIZN1LzQtMmcNeGe5/lVnNHizUDvKVcf3jucAqQBGKUnGdRaS/mtP
         p49RwKOiE4pIfTLpbSp4egjKsZcnqIlDmI6xdID+wvePsyc2yBOMCKNC5csC1HUStGae
         pTqN+BexjEPIk/rBxw66snJzSxann9ja1d6VucE1+9uGqSYafxNJ/u3Oe57Uy0SJtjXk
         W0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pEcXkCd4+idNHmf+XH8UdHbqufT38RyVQazfPyXEoZc=;
        b=E3wOST1PgBZeK7cVtsSRl8rPxuZR73Vi1iJ5nSg1/6cKSp+9EGY6Riy65HAZ10q7YD
         LNjTqT07xUKz2/eTda0dUu93Hka6o7o8hN9XQgPUdUuRmW6lQLWruE9crmMCtdBWR5ke
         9kFO52y8+SSdeY8Mxsgko3nTeind9xKblNr0c8sMq6nUE+n/Uxwf1Sx0ptKEQUzKKfoS
         /AvuogY4TEqMj3af1qHXdipXf7f0HbphFjEBLynqMWjfs2uXbw3X8wu7vmn67aZFg322
         DwzIpi7hIXtImeNBdE4aUAMbyOhYfPFuuRO51VYPapN8gT+KVzCnxkGeOGQpNsZQH+2c
         lYeg==
X-Gm-Message-State: ALoCoQm//6NsMRI8RZpptmRGFOBXz1dgFEx08K/ssxMWXYmwsN8QvXdmm8XBBJ99wi4ni5O0KjFH
X-Received: by 10.43.82.72 with SMTP id ab8mr48678531icc.76.1419963931428;
 Tue, 30 Dec 2014 10:25:31 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Tue, 30 Dec 2014 10:25:31 -0800 (PST)
In-Reply-To: <xmqqr3vhrqjn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261932>

On Tue, Dec 30, 2014 at 9:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  Documentation/git-rebase.txt | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index 924827d..ffadb0b 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -372,7 +372,8 @@ idea unless you know what you are doing (see BUGS below).
>>  --exec <cmd>::
>>       Append "exec <cmd>" after each line creating a commit in the
>>       final history. <cmd> will be interpreted as one or more shell
>> -     commands.
>> +     commands. Rebasing will stop for manual inspection if the command
>> +     returns a non zero exit code.
>>  +
>>  This option can only be used with the `--interactive` option
>>  (see INTERACTIVE MODE below).
>
> This is not wrong per-se, but I wonder if it belongs here, or
> "INTERACTIVE MODE below" may be a better place for it.

I asked around in office yesterday for the --exec command and Jonathan
thought it was documented, but both him and me skimming over the man page
not find it. Maybe we stopped reading as we'd not expect it deep down
there any more?

Thanks for pointing out the place where it is documented actually.

>
> In fact, I notice that "INTERACTIVE MODE below" already touches it,
> like this:
>
>     Reordering and editing commits usually creates untested intermediate
>     steps.  You may want to check that your history editing did not break
>     anything by running a test, or at least recompiling at intermediate
>     points in history by using the "exec" command (shortcut "x").  You may
>     do so by creating a todo list like this one:
>
>     -------------------------------------------
>     pick deadbee Implement feature XXX
>     fixup f1a5c00 Fix to feature XXX
>     exec make
>     pick c0ffeee The oneline of the next commit
>     edit deadbab The oneline of the commit after
>     exec cd subdir; make test
>     ...
>     -------------------------------------------
>
>     The interactive rebase will stop when a command fails (i.e. exits with
>     non-0 status) to give you an opportunity to fix the problem. You can
>     continue with `git rebase --continue`.
>
> I further notice that this section mentions various insns you can
> use in prose, but does not have a list of vocabulary.  A new user,
> when using "rebase -i" for the first time, will only see a series of
> "pick"s; there needs to be a short list of the available insns and
> what each of them do somewhere in the documentation, organized in a
> way similar to how command line options are listed and explained.
>
> As a starting point, here is what I came up with.  I am not
> committing this to anywhere in my tree yet---this is primarily for
> discussion.
>
> One thing that I find a bit troublesome is that we overuse the word
> "command" to mean three different things.  In general, when we say
> "The command does X" in a documentation for individual subcommand,
> we mean that subcommand (i.e. "git rebase" in this case).  "Replace
> the command 'pick' with Y" here however refers to an instruction
> taken from the vocabulary the new list presents here with the word.

I like "instruction" being part of the vocabulary here.

> And "exec stops when the command fails" refers to whatever shell
> scriptlet you give 'exec' insn with the same word.  This (not just
> the new text I am introducing, which follows the usage of the words
> in the existing text, but the way we refer to "command" and mean
> three different things in the entire text) needs to be cleaned up.
>
>
>
>  Documentation/git-rebase.txt | 56 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 44 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 924827d..718300c 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -509,20 +509,52 @@ By replacing the command "pick" with the command "edit", you can tell
>  the files and/or the commit message, amend the commit, and continue
>  rebasing.
>
> -If you just want to edit the commit message for a commit, replace the
> -command "pick" with the command "reword".
> -
> +Here are the commands that can appear in the instruction sheet and
> +their explanations.
> +
> +pick <commit> <subject>::
> +       Replay the named commit on top of the current state.

I remember using git for the very first time (in 2010 to give you some
perspective)
and I had trouble with the rebase command in particular. If the
instruction sheet pops
up, there is a lot of text and as a novice user I was very unsure what
I was allowed to
touch, such that it doesn't break horribly.

In one of the moments I did not think properly through what I was doing,
I made the following change to the instruction sheet:

-pick deadbee Implement feature XXX
+pick deadbee file-xyz.c: implement feature XXX/

Notice I did not change the instruction nor the "named
commit"(deadbee) as you put it.
I tried to rename the subject line of the commit in place. This did
not work of course, but still
picked up the commit the way it was.

I am telling this story now as I am a bit troubled with "named
commit". It actually means
the commit with the given sha1 value (side question: Could I also use
the full git language to
describe commits like: "pick topicbranch^2~3" ?) The text after the
abbreviated sha1 seems
only commentary to me.

So as another thought we may want to introduce a "reword subject
line", which replaces the
subject line of the "named commit" by the comment in the rest of the
line of the instruction sheet.

> +
> +edit <commit> <subject>::
> +       Replay the named commit and then stop, so that the user can
> +       edit the working tree files and "git rebase --continue" to
> +       record the modified changes made to the working tree files
> +       while tweaking the log message.

This is not complete. If I edit the working tree files and then "git
rebase --continue",
I am told
    Documentation/SubmittingPatches: needs update
    You must edit all merge conflicts and then
    mark them as resolved using git add

The way I see the edit instruction is more like a "stop", so mentally
I translate
     pick c0ffeee The oneline of the next commit
     edit deadbab The oneline of the commit after
     pick c0ffaaa Another commit
to:
     pick c0ffeee The oneline of the next commit
     pick deadbab The oneline of the commit after
     stop # change files and amend changes to the previous commit or
hack&commit new stuff
     pick c0ffaaa Another commit

How about:
    Replay the named commit and then stop, such that the user can
    modify the commit by ammending changes or add new commits in between.

> +
> +reword <commit> <subject>::
> +       Replay the named commit and then open the editor to tweak
> +       the log message (i.e. without modifying the changes made to
> +       the working tree contents).
> +
> +squash <commit> <subject>::
> +       Modify the current commit by squashing the change made by
> +       the named commit, and then open the editor to modify the log
> +       message using existing messages from the current commit and
> +       the named commit.  The authorship of the resulting commit is
> +       taken from the current commit.
> +       See `--autosquash`.

Should this be s/current/previous/. Technically the current commit seems
correct to me, but it was crafted in the previous lines of the instruction sheet
so it feels like it's a commit which is already done and we're
currently looking at the
commit which should be squashed into the HEAD.

> +
> +fixup <commit> <subject>::
> +       Modify the current commit by squashing the change made by
> +       the named commit, without updating the log message.  The
> +       authorship of the resulting commit is taken from the
> +       current commit.
> +       See `--autosquash`.
> +
> +exec <command>::
> +       Run named command under a shell and stop if it exited with a
> +       non-zero status.
> +       See `--exec`.
> +
> +For example, if you just want to edit the commit message for a
> +commit, replace the command "pick" with the command "reword".
>  If you want to fold two or more commits into one, replace the command
>  "pick" for the second and subsequent commits with "squash" or "fixup".
> -If the commits had different authors, the folded commit will be
> -attributed to the author of the first commit.  The suggested commit
> -message for the folded commit is the concatenation of the commit
> -messages of the first commit and of those with the "squash" command,
> -but omits the commit messages of commits with the "fixup" command.
> -
> -'git rebase' will stop when "pick" has been replaced with "edit" or
> -when a command fails due to merge errors. When you are done editing
> -and/or resolving conflicts you can continue with `git rebase --continue`.
> +
> +In addition to the cases where the list above says the command will
> +stop, it will stop when a merge conflict needs to be resolved
> +manually.  When you are done editing and/or resolving conflicts,
> +continue with `git rebase --continue`.
>
>  For example, if you want to reorder the last 5 commits, such that what
>  was HEAD~4 becomes the new HEAD. To achieve that, you would call

Overall I like that change as it would help finding the behavior for
exec easier.

Thanks,
Stefan
