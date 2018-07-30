Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCBF01F597
	for <e@80x24.org>; Mon, 30 Jul 2018 18:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbeG3UZJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 16:25:09 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45866 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730400AbeG3UZI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 16:25:08 -0400
Received: by mail-qk0-f196.google.com with SMTP id c192-v6so8534901qkg.12
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 11:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QfZ8rhceLpisJ0TZlFnwj3Aq3hjgVclOvyOCNGIm9c8=;
        b=D/E9X5tdnf6v4J/9FcbOwj55tKaTEMIHF2gu2pCNr28nI2P6+1kx56t8EDFALMPrZG
         qqrZAWY7uqbMWKu4oDrJYefgaljdahxZsa94dDsPGVWbypwc0ajdFqVbDSy3G6oVEaa7
         MkXslvHq/sfHbc3o+g/MP1Jy3QawY7tfuZaI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QfZ8rhceLpisJ0TZlFnwj3Aq3hjgVclOvyOCNGIm9c8=;
        b=IeI+EG34S8IBQhV4V3UEHfmZ/VOsB2+Y5WmhE0zsPpzcF+2u6d03dzi8HW/l6orG/x
         AyLROM0VsXcU1CBL2i6rx/g7Q6FR1CYyZNkWT6HLp7miWFMPA9TAx8X2VPj5lPJL2UqR
         yIJ7GSGXH3mhcpRCXY9ZTjWiDCaAZ8Bp07oBCK4QBYno9jMhV1F5aWofmksqYrQESm6O
         XbeOLfUUnHJt8GtyxUYneJva/0QgHoNkUOi1OMiCh1tz9/Gm0j6fy4HukqUoraI+iK7t
         inSEXkr/Qz6Wg1pxTCnLWQbrDdLswtcCZkLr3vis6H0379KDnZnV+kN5HdepXCpi+Psz
         P/Dg==
X-Gm-Message-State: AOUpUlHqFZLFoZNZYxGQBrP7cQIFeHPRXR6i4fHarhxzO0MnHN74BVv8
        9uzbf9j24U1WQB5jmOPsBKuuChgAdiXqMyuxaWvSJw==
X-Google-Smtp-Source: AAOMgpee/OhwLane0iCS28U2d6BbLBimT3TY63utVTLX90jAcE5jif9aUPT24nOv7B+rj8XRHNCZu6U/YDpCwlOKKL8=
X-Received: by 2002:a37:7304:: with SMTP id o4-v6mr16723898qkc.356.1532976528730;
 Mon, 30 Jul 2018 11:48:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:3763:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 11:48:48
 -0700 (PDT)
In-Reply-To: <xmqqlg9sfvgr.fsf@gitster-ct.c.googlers.com>
References: <xmqq36w6rlh7.fsf@gitster-ct.c.googlers.com> <20180727112222.19061-1-chenbin.sh@gmail.com>
 <xmqqlg9sfvgr.fsf@gitster-ct.c.googlers.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 30 Jul 2018 20:48:48 +0200
Message-ID: <CAE5ih7_-Bd6fUhTL-Yxopc-kaUq0jY9ydx_COqDdN02aXz69Sg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add the `p4-pre-submit` hook
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>, Chen Bin <chenbin.sh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30 July 2018 at 20:07, Junio C Hamano <gitster@pobox.com> wrote:
> Chen Bin <chenbin.sh@gmail.com> writes:
>
>> The `p4-pre-submit` hook is executed before git-p4 submits code.
>> If the hook exits with non-zero value, submit process not start.
>>
>> Signed-off-by: Chen Bin <chenbin.sh@gmail.com>
>> ---
>
> Luke, does this version look good to you?
>

Yes, I think so, We might find in the future that we do need an
additional hook *after* the change has been applied, but as per Chen's
comment, it sounds like that's not what is needed here; it can easily
be added in the future if necessary.

And there's no directly equivalent existing git-hook which could be
used instead, so this seems like a useful addition.

Possibly it should say "it takes no parameters" rather than "it takes
no parameter"; it is confusing that in English, zero takes the plural
rather than the singular. There's a PhD in linguistics there for
someone!

Luke


> I still think the addition to self.description is a bit too much but
> other than that the incremental since the last one looked sensible
> to my untrained eyes ;-)
>
> Thanks, both.
>
>>  Documentation/git-p4.txt   |  8 ++++++++
>>  Documentation/githooks.txt |  7 +++++++
>>  git-p4.py                  | 16 +++++++++++++++-
>>  t/t9800-git-p4-basic.sh    | 29 +++++++++++++++++++++++++++++
>>  4 files changed, 59 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
>> index f0de3b891..a7aac1b92 100644
>> --- a/Documentation/git-p4.txt
>> +++ b/Documentation/git-p4.txt
>> @@ -374,6 +374,14 @@ These options can be used to modify 'git p4 submit' behavior.
>>      been submitted. Implies --disable-rebase. Can also be set with
>>      git-p4.disableP4Sync. Sync with origin/master still goes ahead if possible.
>>
>> +Hook for submit
>> +~~~~~~~~~~~~~~~
>> +The `p4-pre-submit` hook is executed if it exists and is executable.
>> +The hook takes no parameter and nothing from standard input. Exiting with
>> +non-zero status from this script prevents `git-p4 submit` from launching.
>> +
>> +One usage scenario is to run unit tests in the hook.
>> +
>>  Rebase options
>>  ~~~~~~~~~~~~~~
>>  These options can be used to modify 'git p4 rebase' behavior.
>> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
>> index e3c283a17..22fcabbe2 100644
>> --- a/Documentation/githooks.txt
>> +++ b/Documentation/githooks.txt
>> @@ -485,6 +485,13 @@ The exit status determines whether git will use the data from the
>>  hook to limit its search.  On error, it will fall back to verifying
>>  all files and folders.
>>
>> +p4-pre-submit
>> +~~~~~~~~~~~~~
>> +
>> +This hook is invoked by `git-p4 submit`. It takes no parameter and nothing
>> +from standard input. Exiting with non-zero status from this script prevent
>> +`git-p4 submit` from launching. Run `git-p4 submit --help` for details.
>> +
>>  GIT
>>  ---
>>  Part of the linkgit:git[1] suite
>> diff --git a/git-p4.py b/git-p4.py
>> index b449db1cc..879abfd2b 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -1494,7 +1494,13 @@ def __init__(self):
>>                  optparse.make_option("--disable-p4sync", dest="disable_p4sync", action="store_true",
>>                                       help="Skip Perforce sync of p4/master after submit or shelve"),
>>          ]
>> -        self.description = "Submit changes from git to the perforce depot."
>> +        self.description = """Submit changes from git to the perforce depot.\n
>> +    The `p4-pre-submit` hook is executed if it exists and is executable.
>> +    The hook takes no parameter and nothing from standard input. Exiting with
>> +    non-zero status from this script prevents `git-p4 submit` from launching.
>> +
>> +    One usage scenario is to run unit tests in the hook."""
>> +
>>          self.usage += " [name of git branch to submit into perforce depot]"
>>          self.origin = ""
>>          self.detectRenames = False
>> @@ -2303,6 +2309,14 @@ def run(self, args):
>>              sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
>>                       (len(commits), num_shelves))
>>
>> +        hooks_path = gitConfig("core.hooksPath")
>> +        if len(hooks_path) <= 0:
>> +            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
>> +
>> +        hook_file = os.path.join(hooks_path, "p4-pre-submit")
>> +        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
>> +            sys.exit(1)
>> +
>>          #
>>          # Apply the commits, one at a time.  On failure, ask if should
>>          # continue to try the rest of the patches, or quit.
>> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
>> index 4849edc4e..2b7baa95d 100755
>> --- a/t/t9800-git-p4-basic.sh
>> +++ b/t/t9800-git-p4-basic.sh
>> @@ -261,6 +261,35 @@ test_expect_success 'unresolvable host in P4PORT should display error' '
>>       )
>>  '
>>
>> +# Test following scenarios:
>> +#   - Without ".git/hooks/p4-pre-submit" , submit should continue
>> +#   - With the hook returning 0, submit should continue
>> +#   - With the hook returning 1, submit should abort
>> +test_expect_success 'run hook p4-pre-submit before submit' '
>> +     test_when_finished cleanup_git &&
>> +     git p4 clone --dest="$git" //depot &&
>> +     (
>> +             cd "$git" &&
>> +             echo "hello world" >hello.txt &&
>> +             git add hello.txt &&
>> +             git commit -m "add hello.txt" &&
>> +             git config git-p4.skipSubmitEdit true &&
>> +             git-p4 submit --dry-run >out &&
>> +             grep "Would apply" out &&
>> +             mkdir -p .git/hooks &&
>> +             write_script .git/hooks/p4-pre-submit <<-\EOF &&
>> +             exit 0
>> +             EOF
>> +             git-p4 submit --dry-run >out &&
>> +             grep "Would apply" out &&
>> +             write_script .git/hooks/p4-pre-submit <<-\EOF &&
>> +             exit 1
>> +             EOF
>> +             test_must_fail git-p4 submit --dry-run >errs 2>&1 &&
>> +             ! grep "Would apply" err
>> +     )
>> +'
>> +
>>  test_expect_success 'submit from detached head' '
>>       test_when_finished cleanup_git &&
>>       git p4 clone --dest="$git" //depot &&
