Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 452F2202A7
	for <e@80x24.org>; Sat,  1 Jul 2017 07:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbdGAHjV (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 03:39:21 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38383 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbdGAHjU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 03:39:20 -0400
Received: by mail-wm0-f45.google.com with SMTP id f67so11135042wmh.1
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 00:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=eHDr4TLtxMUGnCTPBWNFdJCCUeyfyqsJu/ui/833VPg=;
        b=EywphCTeNkXVKv/IVK+BOtMQVoSEw7o+RO+Wfd1wSZV8goq+ugzQM6uVqzlU6hk1WH
         yKro2g3AA7AD0sJHrEChEf6v+Hz8w3VnHv/1IrEnzFIRw0e4TIfzvj6qhqstxP9EsWYm
         vss0dL/bkzQN25Z4Ownx+tHdYsWsKX3LyUf1211G8tkiY551FL3vR3tOBl4rS7weAGM3
         WE13ugebD42O0eafOybHUx+6c5neYAjTmJgE9UEQXkFbpVnbQDpvEPI/dioEYYk8zFxR
         j6b2k4i7Ti49rhnKKBvG5u+IG8ijdCKyjEHJ0hID4hSJI+Ct4+DjTXeydWe7/wynY0yH
         h5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=eHDr4TLtxMUGnCTPBWNFdJCCUeyfyqsJu/ui/833VPg=;
        b=JpA/2739ldHs3PCzhPVvQmUosNXsKFwEMiRNSOPsuT+yQdtXmXaRwEzPKi5wCTCl33
         lZWtkabjKVdlEi1YgaqR1PiWg8hOke97o04BuyOCki5+2XqOHlT761J9EE1l9iWTPaOw
         WrWF7C0EwWifeqQg4N+9II0X/V4ZEGyiaygPv248Za7AKV2PFfn9/jbfP5AY5NaM1xj4
         /TY+2XT1C0PaY/XqhCPWiDecOBAPjjSkqOuxUZGnt7jYFHqPDWCwRCAEZeB0crez9juQ
         f1qsiVu2xpDuh5kHMJ45L2cVfrhBK6xKUBziQCekiQOH/wWXhUR/Uixd3GTS34+7FA1I
         QkyA==
X-Gm-Message-State: AIVw110eqwhhpyUh4KIkQDKJgRgkhBo218RYMW37Qqki7KRRKBDZMWqO
        tMYk6j/HnlS3KA==
X-Received: by 10.28.144.6 with SMTP id s6mr2860116wmd.16.1498894758986;
        Sat, 01 Jul 2017 00:39:18 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id a99sm12722682wrc.64.2017.07.01.00.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jul 2017 00:39:16 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dRCzm-0002mC-Ig; Sat, 01 Jul 2017 09:39:10 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, xiaoqiang zhao <zxq_yx_007@163.com>,
        Emily Xie <emilyxxie@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2017, #09; Fri, 30)
References: <xmqqk23tp2jk.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqk23tp2jk.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 01 Jul 2017 09:39:10 +0200
Message-ID: <87podkehcx.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 30 2017, Junio C. Hamano jotted:

> * xz/send-email-batch-size (2017-05-23) 1 commit
>  - send-email: --batch-size to work around some SMTP server limit
>
>  "git send-email" learned to overcome some SMTP server limitation
>  that does not allow many pieces of e-mails to be sent over a single
>  session.
>
>  Waiting for a response.
>  cf. <CACBZZX5GYV50rjg9X602JHqFPaoofH9TwDf_-r_MDu8-rmNV6Q@mail.gmail.com>
>  cf. <xmqqo9tfff2w.fsf@gitster.mtv.corp.google.com>
>
>  """I thought your wish (which I found reasonable) was to record
>  whatever information that would help us in the future in the log
>  message?  I was waiting for that to happen."""

I think it's fine in lieu of xiaoqiang zhao not being responsive to just
merge this as-is. The info that can help us in the future is in the ML
archive, which should be good enough.

> * ab/strbuf-addftime-tzname-boolify (2017-06-24) 3 commits
>  - REWORD ONLY SQUASH
>  - strbuf: change an always NULL/"" strbuf_addftime() param to bool
>  - strbuf.h comment: discuss strbuf_addftime() arguments in order
>
>  strbuf_addftime() is further getting tweaked.
>
>  Waiting for a response.
>  cf. <xmqqk2419rhg.fsf@gitster.mtv.corp.google.com>

Meant to get to this after the last "What's Cooking", will submit
another version soon.

> * ab/wildmatch (2017-06-23) 1 commit
>  - wildmatch: remove unused wildopts parameter
>
>  Prepare the wildmatch API for future enhancements to allow a
>  pattern that is repeatedly matched against many strings to be
>  precompiled.

[...]

> * ex/deprecate-empty-pathspec-as-match-all (2017-06-23) 2 commits
>   (merged to 'next' on 2017-06-26 at d026281517)
>  + pathspec: die on empty strings as pathspec
>  + t0027: do not use an empty string as a pathspec element
>
>  The final step to make an empty string as a pathspec element
>  illegal.  We started this by first deprecating and warning a
>  pathspec that has such an element in 2.11 (Nov 2016).
>
>  Hopefully we can merge this down to the 'master' by the end of the
>  year?  A deprecation warning period that is about 1 year does not
>  sound too bad.
>
>  Will cook in 'next'.

I have a longer patch series involving the "wildmatch: remove unused
wildopts parameter" patch (although not conflicting with it) which
assumes:

 1. We'll merge down my "wildmatch: remove unused wildopts parameter" to
    master (doesn't conflict with #3).

 2. This ex/deprecate-empty-pathspec-as-match-all series will get in

 3. My series, which among other things cleans up the wildmatch tests a
    lot (and adds that new wildmatch pre-compile API that was ejected)
    could be reviewed & merged down.

The reason I'm waiting on #3 is because one of the things I'm doing is
improving the wildmatch tests to not only test via calling raw
wildmatch(), but also roundtripping via git-ls-files, and this will
conflict in a very minor way with #2 (the test will need to be changed
from "this warns + works differently" -> "this dies + doesn't work").

But if #2 is something that's going to cook until the end of the year
I'm going to submit this sooner, and then we can just handle the minor
conflict. Is cooking it for that long really the plan?

Also, here's a minor RFC, as part of that series I need to create files
/ directories for each of the tests now in the wildmatch tests, this
involves creating files like "?a?b", "a[]b", "$" etc. I.e. this won't
work on all platforms.

So my WIP is, and I'd like feedback on the viability of the general approach:

    create_test_file() {
    	file=$1

    	# `touch .` will succeed but obviously not do what we intend
    	# here.
    	test "$file" = "." && return 1
    	# We cannot create a file with an empty filename.
    	test "$file" = "" && return 1
    	# The tests that are testing that e.g. foo//bar is matched by
    	# foo/*/bar can't be tested on filesystems since there's no
    	# way we're getting a double slash.
    	echo "$file" | grep -F '//' && return 1

    	dirs=$(echo "$file" | sed -r 's!/[^/]+$!!')

    	# We touch "./$file" instead of "$file" because even an
    	# escaped "touch -- -" means something different.
    	if test "$file" != "$dirs"
    	then
    		mkdir -p -- "$dirs" 2>/dev/null &&
    		touch -- "./$file" 2>/dev/null &&
    		return 0
    	else
    		touch -- "./$file" 2>/dev/null &&
    		return 0
    	fi
    	return 1
    }

And then later on for the tests I do:

	# The existing test
	test_expect_success "wildmatch:     match '$text' '$pattern'" "
		test-wildmatch wildmatch '$text' '$pattern'
	"

	# My new test
	if create_test_file "$text"
	then
		test_expect_success "wildmatch(ls): match '$pattern' '$text'" "
			test_when_finished \"
				rm -rf -- * &&
				git reset
			\" &&
			git add -A &&
			>expect.err &&
			printf '%s' '$text' >expect &&
			git --glob-pathspecs ls-files -z -- '$pattern' 2>actual.err | tr -d '\0' >actual &&
			test_cmp expect.err actual.err &&
			test_cmp expect actual
		"
	else
		test_expect_failure "wildmatch(ls): match skip '$pattern' '$text'" 'false'
	fi

This still needs to be cleaned up a bit to be parameterized (i.e. the
--glob-pathspecs argument, whether it should error etc.).

It works for me on Linux, but I'm wondering if others see any issues
with the approach, does simply trying to create bizarro filenames on
some OSs cause issues? I don't think so, but let's make sure.

Also this whole if/else with test_expect_success/test_expect_failure
pattern kind of sucks, I'm thinking of adding:

    # Do the create_test_file() test to see if we can create the file then:
    SKIP_TEST=<explanation if create_test_file() returned non-zero, empty string otherwise>
    test_expect_success '...' '...'

I.e. to add a facility to test-lib.sh to be picked up by test_skip to
set a variable to skip individual tests with an explanation, currently
we have no non-hacky way to do this with the test-lib. I.e. the
equivalent of Test::More:

    $ perl -MTest::More=no_plan -wE 'my $test = "Match bizarro glob on fs"; if (shift) { pass $test } else { SKIP: { skip $test } }' 0
    ok 1 # skip Match bizarro glob on fs
    1..1
    $ perl -MTest::More=no_plan -wE 'my $test = "Match bizarro glob on fs"; if (shift) { pass $test } else { SKIP: { skip $test } }' 1
    ok 1 - Match bizarro glob on fs
    1..1

The "# skip" is magical and will be picked up as skip TAP.

We could also as a hack do:

    diff --git a/t/test-lib.sh b/t/test-lib.sh
    index 2306574dc9..0cea1711c2 100644
    --- a/t/test-lib.sh
    +++ b/t/test-lib.sh
    @@ -398,7 +398,12 @@ trap 'exit $?' INT

     test_ok_ () {
            test_success=$(($test_success + 1))
    -       say_color "" "ok $test_count - $@"
    +       if echo "$@" | grep -q '^# skip'
    +       then
    +               say_color "" "ok $test_count $@"
    +       else
    +               say_color "" "ok $test_count - $@"
    +       fi
     }

     test_failure_ () {

This would avoid the caveats of setting a possible persistent shell
variable, but OTOH the code would become quite ugly, you'd need:

    if <skip>
    then
        test_expect_success '# skip <reason>' 'true'
    else
        test_expect_success '<real test>' '<real code>'
    fi

So I'm heavily leaning towards just adding a $SKIP_TEST variable of some
sort.

> * ab/sha1dc (2017-06-27) 3 commits
>  - sha1collisiondetection: automatically enable when submodule is populated
>  - sha1dc: optionally use sha1collisiondetection as a submodule
>  - sha1dc: correct endian detection for Solaris (and others?)
>
>  The "collission-detecting" implementation of SHA-1 hash we borrowed
>  from is replaced by directly binding the upstream project as our
>  submodule.  Glitches on minority platforms are still being worked out.
>
>  Will keep in 'pu'.

The status of this is that we've come to a consensus with upstream /
another reported about what to do about this issue in
https://github.com/cr-marcstevens/sha1collisiondetection/pull/34 but
pull request was a bit of a mess (multiple merges etc). I rebased &
cleaned that up this morning as
https://github.com/cr-marcstevens/sha1collisiondetection/pull/37

I'll wait for that to get into upstream before submitting a new round of
this.
