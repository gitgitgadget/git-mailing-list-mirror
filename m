Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F995211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 14:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeLEOBM (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 09:01:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41690 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEOBM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 09:01:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so19799862wrs.8
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 06:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zbge4Gm4MOcC2Om5ap4L2lF6UsfCBwHGszOIXlBQEL0=;
        b=JKJ3CGPayT7/6CYLs7NyabMmPJmsnNED0whDGKMm8TPqyuaf8VTAR+yvnDOYFV20fc
         jJf9W8rfYJSlZFL6pWjKjtBDJJx8ip21vh+weR/dSW5PILgfWj2oAHRyumPpPwphU247
         1EPAnTt/tteSBTk4LN82QDSI+oBh3x4LE+Tq6zxQyS8CFVH71MfGuzUTd/19jsh3xPah
         9wsv+BIfohoTxY5C5E+N6ktwhjq7r78D7qocQrN0tNwXL0JMAfLVoKrlrErIiS/Bkuk1
         t1/wGcR1tTDw0DwSbYWpZtBhriNjcy62MyGmc6IZblqXEVdqjC8PDZkSwMcMFr0ALh1e
         TUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zbge4Gm4MOcC2Om5ap4L2lF6UsfCBwHGszOIXlBQEL0=;
        b=h/brD30B8zlU8lMxMlVvct3g0FL1U2bzvbR7qhbTgrTYUPlvG2x5v8jN3trkw5v1ko
         afgl0oC/ku9Kps+4Oegaz9SCtwvYaG1lhxJBIwOJoIPkGUBSDi4ZRuRU34zhhDHpqaXx
         O+p/2suLUAVPAu3CmoRGy1Rp1sTktGQcmF0hIFukbkMY1C+SLL0Lm2mi7ShkAawQ0qLC
         Mf2Rx3cjdsxg2Fz+JamHjEN4eZxPR/Lv5HOfbHLdmcJ4nKk/aLuvpNKFhKw0iECtGehf
         fJh4XdUavviPKb2ubFxcBn5e5aSHDw9C6IGTGCw2ua83iq+n2lMLjGTXg1J2oyIw6pAf
         C0Lw==
X-Gm-Message-State: AA+aEWale4u42AEoKJKwaZGvr+5YwsLQJ3/Ar8bQFfKmFF1n1oaOTjhz
        ztx0DQx3zPaCX1euwZC13Qk=
X-Google-Smtp-Source: AFSGD/XNpnv/WFqAS8V88GgRae3KWC7qADHPhEaW/7RShOCYjoNZJvA0CaEXJbhkOL91YSWwPtHl+w==
X-Received: by 2002:adf:80cf:: with SMTP id 73mr21772856wrl.57.1544018469873;
        Wed, 05 Dec 2018 06:01:09 -0800 (PST)
Received: from szeder.dev (x4dbd715c.dyn.telefonica.de. [77.189.113.92])
        by smtp.gmail.com with ESMTPSA id f66sm15705311wmd.28.2018.12.05.06.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 06:01:08 -0800 (PST)
Date:   Wed, 5 Dec 2018 15:01:06 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a
 test repeatedly under load
Message-ID: <20181205140106.GM30222@szeder.dev>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-4-szeder.dev@gmail.com>
 <20181205054408.GE12284@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181205054408.GE12284@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 05, 2018 at 12:44:09AM -0500, Jeff King wrote:
> On Tue, Dec 04, 2018 at 05:34:57PM +0100, SZEDER Gábor wrote:
> 
> > To prevent the several parallel invocations of the same test from
> > interfering with each other:
> > 
> >   - Include the parallel job's number in the name of the trash
> >     directory and the various output files under 't/test-results/' as
> >     a '.stress-<Nr>' suffix.
> 
> Makes sense.
> 
> >   - Add the parallel job's number to the port number specified by the
> >     user or to the test number, so even tests involving daemons
> >     listening on a TCP socket can be stressed.
> 
> In my script I just use an arbitrary sequence of ports. That means two
> stress runs may stomp on each other, but stress runs tend not to
> interfere with regular runs (whereas with your scheme, a stress run of
> t5561 is going to stomp on t5562). It probably doesn't matter much
> either way, as I tend not to do too much with the machine during a
> stress run.

A custom port can always be set via environment variables, though the
user has to remember to set it (I doubt that I would remember it until
reminded by test failures...)

> >   - Make '--stress' imply '--verbose-log' and discard the test's
> >     standard ouput and error; dumping the output of several parallel
> >     tests to the terminal would create a big ugly mess.
> 
> Makes sense. My script just redirects the output to a file, but it
> predates --verbose-log.
> 
> My script always runs with "-x". I guess it's not that hard to add it if
> you want, but it is annoying to finally get a failure after several
> minutes only to realize that your are missing some important
> information. ;)
> 
> Ditto for "-i", which leaves more readable output (you know the
> interesting part is at the end of the log), and leaves a trash directory
> state that is more likely to be useful for inspecting.

I wanted to imply only the bare minimum of options that are necessary
to prevent the tests from stomping on each other.  Other than that I
agree and wouldn't run '--stress' without '-x -i' myself, and at one
point considered to recommend '-x -i' in the description of
'--stress'.

> My script also implies "--root". That's not strictly necessary, though I
> suspect it is much more likely to catch races when it's run on a ram
> disk (simply because it leaves the CPU as the main bottleneck).
> 
> > 'wait' for all parallel jobs before exiting (either because a failure
> > was found or because the user lost patience and aborted the stress
> > test), allowing the still running tests to finish.  Otherwise the "OK
> > X.Y" progress output from the last iteration would likely arrive after
> > the user got back the shell prompt, interfering with typing in the
> > next command.  OTOH, this waiting might induce a considerable delay
> > between hitting ctrl-C and the test actually exiting; I'm not sure
> > this is the right tradeoff.
> 
> If there is a delay, it's actually quite annoying to _not_ wait; you
> start doing something in the terminal, and then a bunch of extra test
> statuses print at a random time.

At least the INT/TERM/etc. handler should say something like "Waiting
for background jobs to finish", to let the user know why it doesn't
exit right away.

An alternative would be to exit right away, and make the background
loops a tad bit smarter to not print these progress lines when
aborting.

> > +	job_nr=0
> > +	while test $job_nr -lt "$job_count"
> > +	do
> > +		(
> > +			GIT_TEST_STRESS_STARTED=done
> > +			GIT_TEST_STRESS_JOB_NR=$job_nr
> > +			export GIT_TEST_STRESS_STARTED GIT_TEST_STRESS_JOB_NR
> > +
> > +			cnt=0
> > +			while ! test -e "$stressfail"
> > +			do
> > +				if $TEST_SHELL_PATH "$0" "$@" >/dev/null 2>&1
> > +				then
> > +					printf >&2 "OK   %2d.%d\n" $GIT_TEST_STRESS_JOB_NR $cnt
> 
> OK, this adds a counter for each job number (compared to my script).
> Seems helpful.
> 
> > +				elif test -f "$stressfail" &&
> > +				     test "$(cat "$stressfail")" = "aborted"
> > +				then
> > +					printf >&2 "ABORTED %2d.%d\n" $GIT_TEST_STRESS_JOB_NR $cnt
> > +				else
> > +					printf >&2 "FAIL %2d.%d\n" $GIT_TEST_STRESS_JOB_NR $cnt
> > +					echo $GIT_TEST_STRESS_JOB_NR >>"$stressfail"
> > +				fi
> 
> Hmm. What happens if we see a failure _and_ there's an abort? That's
> actually pretty plausible if you see a failure whiz by, and you want to
> abort the remaining scripts because they take a long time to run.
> 
> If the abort happens first, then the goal is to assume any errors are
> due to the abort.

Yeah, that's why I added this ABORTED case.  When I hit ctrl-C, a
couple of the tests tend to fail, but that's not the rare failure we
are hoping to find when stress testing, so printing FAIL would be
misleading.  The test script exits with 1 all the same, so we can't
tell the difference, but since rare failures are, well, rare, this
failure is most likely due to the abort.

> But there's a race between the individual jobs reading
> $stressfail and the parent signal handler writing it. So you may end up
> with "aborted\n5" or similar (after which any other jobs would fail to
> match "aborted" and declare themselves failures, as well).  I think my
> script probably also has this race, too (it doesn't check the abort case
> explicitly, but it would race in checking "test -e fail").
>
> If the fail happens first (which I think is the more likely case), then
> the abort handler will overwrite the file with "aborted", and we'll
> forget that there was a real failure. This works in my script because of
> the symlinking (if a real failure symlinked $fail to a directory, then
> the attempt to write "aborted" will just be a noop).

OK, I think the abort handler should append, not overwrite, and then
the file's contents should be checked e.g. with a case statement
looking for *aborted*.

Or use two separate files for signaling abort and test failure.

In any case, you could always grab the job number from the "FAIL X.Y"
line, and then look at its logs and trash direcory.

> > +	job_nr=0
> > +	while test $job_nr -lt "$job_count"
> > +	do
> > +		wait
> > +		job_nr=$(($job_nr + 1))
> > +	done
> 
> Do we need to loop? Calling "wait" with no arguments should wait for all
> children.
> 
> > +	if test -f "$stressfail" && test "$(cat "$stressfail")" != "aborted"
> > +	then
> > +		echo "Log(s) of failed test run(s) be found in:"
> > +		for f in $(cat "$stressfail")
> > +		do
> > +			echo "  $TEST_RESULTS_BASE.stress-$f.out"
> > +		done
> > +	fi
> 
> In my experience, outputting the failed log saves a step (especially
> with "-i"), since seeing the failed test and its output is often
> sufficient.

I just don't like when test output, especially with '-x', is dumped on
my terminal :)

> I'm also sad to lose the symlink to the failed trash directory, which
> saves cutting and pasting when you have to inspect it. But I guess we
> can't rely on symlinks everywhere.

You can tab-complete most of the trash directory, and then there are
only those 1-2-3 digits of the job number that you have to type.  That
worked out well enough for me so far (but I've only used it for a few
days, so...).

We could rename the trash directory of the failed test to something
short, sweet, and common, but that could be racy in the unlikely case
that two tests fail at the same time.  And I like the 'trash
directory.' prefix, because then 'make clean' will delete that one,
too, without modifying 't/Makefile' (which is also the reason for
adding the 'stress-N' suffix instead of a prefix, and putting the fail
file into the 'test-results' directory).

