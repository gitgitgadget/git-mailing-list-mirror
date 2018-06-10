Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE6661F403
	for <e@80x24.org>; Sun, 10 Jun 2018 01:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbeFJBOv (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 21:14:51 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:43066 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753488AbeFJBOu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 21:14:50 -0400
Received: by mail-vk0-f68.google.com with SMTP id d74-v6so10095733vke.10
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 18:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SGu+2C+pQhrTBRs0Pnw/rzJfKA+UkjoC4X2hUkVzJuY=;
        b=Fmm/5NbEv/CUWRjeDCMwf9QqQI0DTUVXzBJ926LuhLB/z/0CQxtPNOWrw8gFZ+RcOx
         peBbwvbVJ2XQMP1CdtAvScjOQJsnzJCkyVY1kv+L5gonDcN/yQs+Uf6CROF3bksCq2VH
         whE2ALVHGjib3fu+JcYRKenJOO3JPH4RzX876ATM6ZdYPIjtea87wx+nQpkE3+GecRxy
         Ur/Fjngbmpi3eZX4gqVMKxXq5m8ELjGlPlafzekhn2GMBfonMHjwB6awIHEdZqgyedFY
         Sa80d2fdGqSayYpXOI+DUzkNzeipSoFTmK68aSk3KzkJbSEk3ACVeYeVrJQWeYCt0qvk
         E6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SGu+2C+pQhrTBRs0Pnw/rzJfKA+UkjoC4X2hUkVzJuY=;
        b=mcEA099UxU4p6p3SGHoUdykth/Y40aCANwSa2aV2CDWzv2VF+OzPbzesAJaddubW6p
         xJD+2CR7IxP6/LsRNAxROJypY7i3CrkYqGtzZGvdi4tAICOt48Nc7JDtDNBxwSI5645g
         l+iOYlb/ESBdRkQOJBU0XJjvyZfdGPArhkRYX02YqH9iDOudsCVxoC6KnvSJyP0Q/enJ
         zyt4Q69DU32wy0+EyK9KBCqozm8J/QjFiKwCiRd9nYQm9ZhORKzOo5grdlXK406/Sfvt
         2qvd92bkN331RGVljcS8e75IgIGFe/028YbTQrMJOE8a97Pygu6Y6RvN1BbaWEgbRoFn
         FhJg==
X-Gm-Message-State: APt69E3x7xcC8nRdqkZ8E13c0S6ID2wMy6OyiJ+Po9KMlLCpHddc5e5f
        iHpOknqxq1kNV2IyJzWV5doMDlUrebs2t6VjALU=
X-Google-Smtp-Source: ADUXVKIhHSoYdBBjXtq91VOIfklKCD3Lij+HOzXUWl5LXnh1PJ8kxzHjqhUCXC3hNy1v7uvaSyXG1mr+007XKj8YI8M=
X-Received: by 2002:a1f:82c7:: with SMTP id e190-v6mr7253124vkd.187.1528593289037;
 Sat, 09 Jun 2018 18:14:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 18:14:48 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1806092348390.77@tvgsbejvaqbjf.bet>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607171344.23331-1-newren@gmail.com> <20180607171344.23331-3-newren@gmail.com>
 <nycvar.QRO.7.76.6.1806092348390.77@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Jun 2018 18:14:48 -0700
Message-ID: <CABPp-BG6WFCBm0u+=Jxi2PGYgKHPifEcxpSkrPBoM39-49dKDw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] rebase: Implement --merge via git-rebase--interactive
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Sat, Jun 9, 2018 at 3:04 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 7 Jun 2018, Elijah Newren wrote:
>
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index 451252c173..28d1658d7a 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -275,6 +275,10 @@ branch on top of the <upstream> branch.  Because of this, when a merge
>>  conflict happens, the side reported as 'ours' is the so-far rebased
>>  series, starting with <upstream>, and 'theirs' is the working branch.  In
>>  other words, the sides are swapped.
>> ++
>> +This uses the `--interactive` machinery internally, and as such,
>> +anything that is incompatible with --interactive is incompatible
>> +with this option.
>
> I am not sure I like this change, as it describes an implementation detail
> that users should neither know, nor care about, nor rely on.

Let me back up for just a second to see if I can point out the real
problem I'm trying to address here, which you may have a better
solution for.  What should happen if a user runs
   git rebase --merge --whitespace=fix
?

git currently silently ignores the --whitepsace=fix argument, leaving
the whitespace damage present at the end of the rebase.  Same goes for
--interactive combined with any am-specific options  (Fix proposed at
https://public-inbox.org/git/20180607050654.19663-2-newren@gmail.com/).
This silent ignoring of some options depending on which other options
were specified has caused me problems in the past.

So, while I totally agree with you that users shouldn't need to know
implementation details, they do need to know how to use commands and
which options go well together and which are mutually incompatible.
Do you have any suggestions on alternate wording that would convey the
sets of mutually incompatible options without talking about
implementation details?  Would you rather only address that in the
code and not mention it in the documentation?

See also https://public-inbox.org/git/20180607050654.19663-1-newren@gmail.com/,
which proposes testcases for these incompatibility sets.


>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index 1f2401f702..dcc4a26a78 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -885,7 +885,10 @@ init_basic_state () {
>>       mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
>>       rm -f "$(git rev-parse --git-path REBASE_HEAD)"
>>
>> -     : > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
>> +     if test -n "$actually_interactive"
>> +     then
>> +             : > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
>> +     fi
>
> Do we really care at this stage? IOW what breaks if we still write that
> file, even in --merge mode?

Two things will change if we do that:
  * bash prompt will be different for those using git-prompt.sh
(REBASE-m vs. REBASE-i).
  * git-status output is no longer the same ('rebase in progress' vs.
'interactive rebase in progress...last command done:...pick 0dea123 my
wonderful commit')

I don't think the prompt is a big deal.  The status output might not
be either, but showing the "last command done" may be weird to someone
that never saw or edited a list of commands.  (Then again, that same
argument could be made for users of --exec, --rebase-merges, or
--keep-empty without an explicit --interactive)

Opinions on whether these two difference matter?  If others don't
think these differences are significant, I'm happy to update any
necessary testcases and just unconditionally create the
$state_dir/interactive file.


>> @@ -501,17 +502,11 @@ fi
>>
>>  if test -n "$git_am_opt"; then
>>       incompatible_opts=`echo "$git_am_opt" | sed -e 's/ -q//'`
>> -     if test -n "$interactive_rebase"
>> +     if test -n "$incompatible_opts"
>
> Did you not mean to turn this into a test for actually_interactve ||
> do_merge?
>
>>       then
>> -             if test -n "$incompatible_opts"
>> +             if test -n "$actually_interactive" || test "$do_merge"
>
> This could now be combined with the previous if (and the `-n` could be
> added to the latter test):
>
>         if test -n "$actually_interactive" -o -n "$do_merge" &&
>                 test -n "$incompatible_opts"
>
> The indentation would change, but this hunk is already confusing to read,
> anyway, so...

I'm happy to switch the order of the nesting as you suggest and agree
that it would make it easier to read.  However, I hesitate to combine
the two if-lines.  When I read your combined suggested line, I parsed
it as follows (using invalid pseduo-syntax just to convey grouping):

  ( -n "$actually_interactive ) || ( -n "$do_merge" && -n "$incompatible_opts" )

Granted, I parsed it wrong, putting the parentheses in the wrong
places, and bash parses it as you intended.  While you may have
precedence and left- vs. right- associativity rules down pat, I
clearly didn't.  If we combine the lines, I'll probably mis-read them
again when I see them in a year or more.

>> @@ -704,6 +699,22 @@ then
>>       GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
>>  fi
>>
>> +if test -z "$actually_interactive"
>> +then
>> +     # If the $onto is a proper descendant of the tip of the branch, then
>> +     # we just fast-forwarded.
>> +     if test "$mb" = "$orig_head"
>> +     then
>
> Likewise, this would be easier to read as
>
>         if test -z "$actually_interactive" && test "$mb" = "$orig_head"

Good point, I'll fix that up.

> Also: how certain are we that "$mb" does not start with a dash? We may
> have to use the `test a"$mb" = a"$orig_head"` trick here... But I guess
> this is moved code, so if it is buggy, it was buggy before.

From earlier in the file,
mb=$(git merge-base ...)

So, unless we're expecting the output of git-merge-base to change in
the future to include leading dashes, we shouldn't hit any issues.  I
can make the change you suggest if you're worried, though.

>> diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
>> index 0392e36d23..04d6c71899 100755
>> --- a/t/t3406-rebase-message.sh
>> +++ b/t/t3406-rebase-message.sh
>> @@ -17,14 +17,9 @@ test_expect_success 'setup' '
>>       git tag start
>>  '
>>
>> -cat >expect <<\EOF
>> -Already applied: 0001 A
>> -Already applied: 0002 B
>> -Committed: 0003 Z
>> -EOF
>> -
>>  test_expect_success 'rebase -m' '
>>       git rebase -m master >report &&
>> +     >expect &&
>>       sed -n -e "/^Already applied: /p" \
>>               -e "/^Committed: /p" report >actual &&
>>       test_cmp expect actual
>
> This might be called a regression... I don't know any user of `git rebase
> -m`, but I guess if I was one, I would like to keep seeing those messages.
>
> It *should* be relatively easy to tell the sequencer.c to issue these
> messages, I think. But it would be more work.

You may well be right.  Here's where my thinking came from...

am-based, interactive-based, and merge-based rebases have lots of
little ways in which they have differed, this being just one of them.
It was sometimes hard making a judgement call when writing this series
about whether any given deviation was a difference I wanted to smooth
over or a difference I wanted to perpetuate between various flags.
Further, if it was a difference I wanted to smooth over, then I had to
decide which of the current behaviors was 'correct'.

In this particular case, I basically went off perceived usage.
am-based rebases have lots of special flags relevant to it only
(--whitespace, -C, etc.) and is the default, so it clearly has lots of
users.  interactive-based rebases are pretty prominent too, and have
very specific special capabilities the other modes don't.  In
contrast, merge-based rebases can't do a single thing that interactive
can't; and unless you're using a special merge strategy, for the last
10 years merge-based rebases haven't been able to do anything a normal
am-based rebase couldn't.  merge-based rebases were added in mid-2006
to handle renames, but am-based rebases gained that ability at the end
of 2008.  Basically, rebase -m was dormant and useless...until
directory rename detection became a thing this cycle.  (Also, in
config options and documentation merge tends to be overlooked; just a
single example is that pull.rebase can be set to interactive, but not
to merge.)

Anyway, with this in mind, I didn't think those extra messages were
all that important.  If others disagree I can look into adding them --
that'd also make the --quiet mode more useful for interactive, since
there'd be more messages for it to strip out.

>>  test_expect_success "rebase -p is no-op in non-linear history" "
>> diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
>> index 9b2a274c71..145c61251d 100755
>> --- a/t/t5407-post-rewrite-hook.sh
>> +++ b/t/t5407-post-rewrite-hook.sh
>> @@ -120,6 +120,7 @@ test_expect_success 'git rebase -m --skip' '
>>       git rebase --continue &&
>>       echo rebase >expected.args &&
>>       cat >expected.data <<-EOF &&
>> +     $(git rev-parse C) $(git rev-parse HEAD^)
>>       $(git rev-parse D) $(git rev-parse HEAD)
>>       EOF
>>       verify_hook_input
>
> This is a bit sad, because it seems to suggest that we now do more
> unnecessary work here, or is my reading incorrect?

I agree that it's a bit sad.  I spent a while looking at this testcase
and puzzling over what it meant, and my commit message pointed out
that I wasn't quite sure where it came from:

      t5407: different rebase types varied slightly in how many times checkout
             or commit or equivalents were called based on a quick comparison
             of this tests and previous ones which covered different rebase
             flavors.  I think this is just attributable to this difference.

It would be nice to avoid the extra work, but I'm worried tackling
that might cause me to step on toes of folks doing the rewrite of
interactive rebases from shell to C.  Maybe I should just add a TODO
note in the testcase, similar to the one in t3425 near a few lines I
touched in this patch?


Thanks for the detailed feedback and suggestions!

Elijah
