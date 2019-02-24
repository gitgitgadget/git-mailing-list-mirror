Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA77820248
	for <e@80x24.org>; Sun, 24 Feb 2019 14:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfBXOp0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 09:45:26 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40716 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfBXOp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 09:45:26 -0500
Received: by mail-ed1-f66.google.com with SMTP id 10so5487483eds.7
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 06:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=M9Ti7ml5QqvlC+voBjBkRk4/tEy35CRYbBHRuZ8j2sI=;
        b=qs/fjPh1j3RqtjDMUmtI2l7Lt8j5JuAmT3E5jA40hn9fk8rmPafEnVQswYRGvBluZD
         FbQFYUML4N8IC2zM7T+a7ea9rGq+J8f4iEdAhpqxjD0TfakPDrxqKo+Ez/4EE8c3zr2f
         p23r1OluLk0UdznTAujNkpGUKeGGCtFDGYIQubum37Q65X17YUU+XOEEmK384bApmtRQ
         kOHSsZNJaYfdgJ490DECaUvc7vazTplQCvP+hR4+Obb64/uHbVsJevLlCsf67LxQoJQ7
         AUK3tcZ0ZgCZsLfEGhn8koMwNZsX8p5yWlhgq/sDFPT1WStQe3qRgz+KR+oCq+Bzset9
         +/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=M9Ti7ml5QqvlC+voBjBkRk4/tEy35CRYbBHRuZ8j2sI=;
        b=e7ANu5ZcDd49e0qKtT4XH2sNOXt1xANJrP3plRY6bT2nDRZOVsEJE5hU/teXgi1I7S
         G3A4D6yELCd/SgLzAxYqKQ9WKWx0B26QS5hEzFEqMNGg+Nwtfn7r08+QnjJaW8dGbYO9
         j0sGfh9czYKu6FBHLN2IRaE+AcCFQKjXt0aVqdZcEf5YSIz98UOAZLegDXwd0514+225
         Y6VgYe7aG6LfeCQ4dvAzHbrqzLphdYenpkcShEhUcJf1mA0QwGLLuVnztuc4waXLFtIa
         gxNVvN7MLIU5dNwFS0vfCdkvw1PReWUdQjQwWUvW+s0+FJ8Iwv46bIDxJyaog34XTDLt
         8oMQ==
X-Gm-Message-State: AHQUAuZSaopeXMa4JFUinmVqPn/pLkwQpFJJgeNnOrRKobvftFB63S0F
        pXBCLAx4lS6mvPp1lWKHBG0=
X-Google-Smtp-Source: AHgI3IaQwmH2vRJa6zwFJsN0mf2ermVxWjTJy+b6Hf3SIEkKn4tT7Jz1bMJhtZh0UYAm4Ue94i4Chg==
X-Received: by 2002:a50:9125:: with SMTP id e34mr10789612eda.183.1551019523436;
        Sun, 24 Feb 2019 06:45:23 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id x34sm1983163edm.70.2019.02.24.06.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Feb 2019 06:45:22 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [GSoC][PATCH 3/3] clone: use dir-iterator to avoid explicit dir traversal
References: <20190223190309.6728-1-matheus.bernardino@usp.br>
        <20190223190309.6728-4-matheus.bernardino@usp.br>
        <87va1a3z8e.fsf@evledraar.gmail.com>
        <CAP8UFD2LLL+V54k3XmHzmg5t1zanpAvY_=7GqXL43vLPTTmuww@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CAP8UFD2LLL+V54k3XmHzmg5t1zanpAvY_=7GqXL43vLPTTmuww@mail.gmail.com>
Date:   Sun, 24 Feb 2019 15:45:21 +0100
Message-ID: <87tvgt454u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 24 2019, Christian Couder wrote:

> On Sat, Feb 23, 2019 at 11:48 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Sat, Feb 23 2019, Matheus Tavares wrote:
>>
>> > Replace usage of opendir/readdir/closedir API to traverse directories
>> > recursively, at copy_or_link_directory function, by the dir-iterator
>> > API. This simplifies the code and avoid recursive calls to
>> > copy_or_link_directory.
>>
>> Sounds good in principle.
>>
>> > This process also brings some safe behaviour changes to
>> > copy_or_link_directory:
>>
>> I ad-hoc tested some of these, and could spot behavior changes. We
>> should have tests for these.
>
> I agree that ideally we should have a few tests for these, but this is
> a grey area (see below) and there are areas that are not grey for
> which we don't have any test...
>
> And then adding tests would make this series become larger than a
> typical GSoC micro-project...
>
>> >  - It will no longer follows symbolic links. This is not a problem,
>> >    since the function is only used to copy .git/objects directory, and
>> >    symbolic links are not expected there.
>>
>> I don't think we should make that assumption, and I don't know of
>> anything else in git that does.
>
> I think Git itself doesn't create symlinks in ".git/objects/" and we
> don't recommend people manually tweaking what's inside ".git/". That's
> why I think it's a grey area.
>
>> I've certainly symlinked individual objects or packs into a repo for
>> debugging / recovery, and it would be unexpected to clone that and miss
>> something.
>
> If people tweak what's inside ".git" by hand, they are expected to
> know what they doing and be able to debug it.
>
>> So in the general case we should be strict in what we generate, but
>> permissive in what we accept. We don't want a "clone" of an existing
>> repo to fail, or "fsck" to fail after clone...
>
> Yeah, but realistically I don't think we are going to foolproof Git
> from everything that someone could do by tweaking random things
> manually in ".git/".
>
> I am not saying that it should be ok to make things much worse than
> they are now in case some things have been tweaked in ".git/", but if
> things in general don't look worse in this grey area, and a patch
> otherwise improves things, then I think the patch should be ok.
>
>> When trying to test this I made e.g. objects/c4 a symlink to /tmp/c4,
>> and a specific object in objects/4d/ a symlink to /tmp too.
>>
>> Without this patch the individual object is still a symlink, but the
>> object under the directory gets resolved, and "un-symlinked", also with
>> --dissociate, which seems like an existing bug.
>>
>> With your patch that symlink structure is copied as-is. That's more
>> faithful under --local, but a regression for --dissociate (which didn't
>> work fully to begin with...).
>
> I think that I use --local (which is the default if the repository is
> specified as a local path) much more often than --dissociate, so for
> me the patch would be very positive, especially since --dissociate is
> already buggy anyway in this case.
>
>> I was paranoid that "no longer follows symbolic links" could also mean
>> "will ignore those objects", but it seems to more faithfully copy things
>> as-is for *that* case.
>
> Nice!
>
>> But then I try with --no-hardlinks and stock git dereferences my symlink
>> structure, but with your patches fails completely:
>>
>>     Cloning into bare repository 'repo2'...
>>     error: copy-fd: read returned: Is a directory
>>     fatal: failed to copy file to 'repo2/objects/c4': Is a directory
>>     fatal: the remote end hung up unexpectedly
>>     fatal: cannot change to 'repo2': No such file or directory
>
> Maybe this could be fixed. Anyway I don't use --no-hardlinks very
> often, so I still think the patch is a positive even with this
> failure.
>
>> So there's at least one case in a few minutes of prodding this where we
>> can't clone a working repo now, however obscure the setup.
>>
>> >  - Hidden directories won't be skipped anymore. In fact, it is odd that
>> >    the function currently skip hidden directories but not hidden files.
>> >    The reason for that could be unintentional: probably the intention
>> >    was to skip '.' and '..' only, but it ended up accidentally skipping
>> >    all directories starting with '.'. Again, it must not be a problem
>> >    not to skip hidden dirs since hidden dirs/files are not expected at
>> >    .git/objects.
>>
>> I reproduce this with --local. A ".foo" isn't copied before, now it
>> is. Good, I guess. We'd have already copied a "foo".
>>
>> >  - Now, copy_or_link_directory will call die() in case of an error on
>> >    openddir, readdir or lstat, inside dir_iterator_advance. That means
>> >    it will abort in case of an error trying to fetch any iteration
>> >    entry.
>
> It would be nice if the above paragraph in the commit message would
> say what was the previous behavior and why it's better to die() .
>
>> Good, but really IMNSHO this series is tweaking some critical core code
>> and desperately needs tests.
>
> It's critical that this code works well in the usual case, yes. (And
> there are already a lot of tests that test that.) But when people have
> manually tweaked things in their ".git/objects/", it's not critical
> what happens. Many systems have "undefined behaviors" at some point
> and that's ok.
>
> And no, I am not saying that we should consider it completely
> "undefined behavior" as soon as something is manually tweaked in
> ".git/", and yes, tests would be nice, and your comments and manual
> tests on this are very much appreciated. It's just that I don't think
> we should require too much when a patch, especially from a first time
> contributor, is already improving things, though it also changes a few
> things in a grey area.
>
>> Unfortunately, in this as in so many edge case we have no existing
>> tests.
>>
>> This would be much easier to review and would give reviewers more
>> confidence if the parts of this that changed behavior started with a
>> patch or patches that just manually objects/ dirs with various
>
> I think "created" is missing between "manually" and  "objects/" in the
> above sentence.
>
>> combinations of symlinks, hardlinks etc., and asserted that the various
>> options did exactly what they're doing now, and made sure the
>> source/target repos were the same after/both passed "fsck".
>>
>> Then followed by some version of this patch which changes the behavior,
>> and would be forced to tweak those tests. To make it clear e.g. that
>> some cases where we have a working "clone" are now a hard error.
>
> Unfortunately this would be a lot of work and not appropriate for a
> GSoC micro-project.
>
> Thanks,
> Christian.

Here's a test that works before 3/3 and fails after, can be used with my SO=
B:

    diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
    index 4320082b1b..80c0a4a19b 100755
    --- a/t/t5604-clone-reference.sh
    +++ b/t/t5604-clone-reference.sh
    @@ -221,4 +221,37 @@ test_expect_success 'clone, dissociate from altern=
ates' '
     	( cd C && git fsck )
     '

    +test_expect_success SHA1,SYMLINKS 'setup repo with manually symlinked =
objects/*' '
    +	git init S &&
    +	(
    +		cd S &&
    +		test_commit A &&
    +		git gc &&
    +		test_commit B &&
    +		(
    +			cd .git/objects &&
    +			mv 22/3b7836fb19fdf64ba2d3cd6173c6a283141f78 . &&
    +			ln -s ../3b7836fb19fdf64ba2d3cd6173c6a283141f78 22/ &&
    +			mv 40 forty &&
    +			ln -s forty 40 &&
    +			mv pack packs &&
    +			ln -s packs pack
    +		)
    +	)
    +'
    +
    +test_expect_success SHA1,SYMLINKS 'clone repo with manually symlinked =
objects/*' '
    +	for option in --local --no-hardlinks --shared --dissociate
    +	do
    +		git clone $option S S$option || return 1 &&
    +		git -C S$option fsck || return 1
    +	done &&
    +	find S-* -type l | sort >actual &&
    +	cat >expected <<-EOF &&
    +	S--dissociate/.git/objects/22/3b7836fb19fdf64ba2d3cd6173c6a283141f78
    +	S--local/.git/objects/22/3b7836fb19fdf64ba2d3cd6173c6a283141f78
    +	EOF
    +	test_cmp expected actual
    +'
    +
     test_done

Obviously not ideal, there's a way to do this without relying on the
SHA1 prereq, but in this case I don't see much point. Also similar to
the test_cmp there it would make senses to create
.git/objects/{foo,.foo} and see if they show up in the clone.

The GSOC project is basically "replace existing thing with identical
utility function", but software can always be more/less complex when it
gets to writing the code, so now it's become "we no longer uniformly
accept the same repository formats across fsck/clone as a side-effect".

To me that's not a grey area. Yes we don't produce that ourselves, but
it's the on-disk format we've always supported, and can expect e.g. that
someone's symlinking objects/?? to different partitions etc. in some
advanced setups.

Can't the utility function we're moving to just be made to be
bug-compatible with what we're doing now with symlinks?
