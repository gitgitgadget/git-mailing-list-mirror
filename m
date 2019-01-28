Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D9AC1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 10:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfA1KHG (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 05:07:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41924 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfA1KHF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 05:07:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so7010678pgq.8
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 02:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SJ1UR8poXiwPSDTuTVodONPMTqWf41mi6A6TUTK+3ao=;
        b=OxbXeCJKoFKB/DxXEcZ1kKQ6ebqZlmH1X6V5p0ipGjzq0bUWoKBHECZPttB7J8+2d9
         xl1uk7DIycYoZKJ4TLHWN7Rp7UQa6lkL4ivUyAmttgkV1ezkKvs3U4zim3OS4tn6fGO2
         jJCDYGeK2JMZJuTwVEdklYdXlw7RkrTsEB5epds9od2bJQsQlqQ+K8JLDmwACKCoRe9I
         rzUc3spl2eK74szg5tcUlf5dMHU/DRrN4Zea6NwF4W+WDEEi7RtikyLqwBELAk9fie/v
         lfnQEtkwpFNp3uM/xcdFjKPtV1MQiYbXW+365rRa10iTugiuN4bpGdq5MspqE84kzcGa
         0/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SJ1UR8poXiwPSDTuTVodONPMTqWf41mi6A6TUTK+3ao=;
        b=ryp+np005e9CHOnD5pDLmOdkwFOxd1CEpgyldy7/cVHaXJb2Nh1iVHYcUjsTTtNYCQ
         oYwmyvNaa3ILYGwXIclZLHnsyl8OsQLtDC9WdDpWrIrUHKAAr8gjwHuwjJcfoTl140XN
         NBXt4KwyezNKzf4n/N9FwgCAnL/Wmx82ZAgWju2dezQfzKagWwD1B9j8fgGp6Jx6cFe9
         mbGJ88EDwt9JrQBEo3FD1oxXllvBn9vEg689SGx9mfcsNw0Cz1Med425xDNinjkJUpRv
         hXRU32CuUTXx6s9cthpMg/FdW8hIzBH0pq+2kLL2hMdQhEN93hQQjgpIWS3KmV5Hjnt9
         Yqig==
X-Gm-Message-State: AJcUukdGCTsdnBXK/n8ntTULrSb9hHzBFpWP0tp5EBs7t4p+Iziv8U8p
        S/3ny8k+r1NuM+EKPiD9WvA=
X-Google-Smtp-Source: ALg8bN5eVOLeycPrW/EJQ0V5cHKJ+hIRXtom+FEJV0ilxypY3IYxcGPf/qSOyTZZ8qb7uJF9459nKQ==
X-Received: by 2002:a63:a401:: with SMTP id c1mr19404740pgf.403.1548670024720;
        Mon, 28 Jan 2019 02:07:04 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id t24sm60262688pfm.127.2019.01.28.02.07.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 02:07:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 28 Jan 2019 17:06:59 +0700
Date:   Mon, 28 Jan 2019 17:06:59 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Sebastian Staudt <koraktor@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] Add tests for describe with --work-tree
Message-ID: <20190128100659.GA6257@ash>
References: <20190126204951.42455-1-koraktor@gmail.com>
 <CACsJy8A6hF+Sxitpt3J9EmDEXjGb2e+AeMtJDaE7Y32fg4NEKA@mail.gmail.com>
 <CA+xP2SbLwmeWpqmjCiqojra5Mwrbok7sjvUsvCsaAo6XsWBbtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+xP2SbLwmeWpqmjCiqojra5Mwrbok7sjvUsvCsaAo6XsWBbtA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 27, 2019 at 08:13:51AM +0100, Sebastian Staudt wrote:
> Am So., 27. Jan. 2019 um 01:07 Uhr schrieb Duy Nguyen <pclouds@gmail.com>:
> >
> > On Sun, Jan 27, 2019 at 3:51 AM Sebastian Staudt <koraktor@gmail.com> wrote:
> > >
> > > The dirty ones are already passing, but just because describe is comparing
> > > with the wrong working tree.
> > >
> > > Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> > > ---
> > >  t/t6120-describe.sh | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >
> > > diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> > > index d639d94696..9a6bd1541f 100755
> > > --- a/t/t6120-describe.sh
> > > +++ b/t/t6120-describe.sh
> > > @@ -28,6 +28,24 @@ check_describe () {
> > >         '
> > >  }
> > >
> > > +check_describe_worktree () {
> > > +  cd "$TEST_DIRECTORY"
> >
> > Strange alignment. We normally do it in a subshell...
> 
> Sure, will fix this.
> 
> >
> > > +       expect="$1"
> > > +       shift
> > > +       R=$(git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe "$@" 2>err.actual)
> >
> > These commands should be executed inside test_expect_success, not
> > outside. And you need to chain commands with && to make sure if
> > something breaks, then the whole test will fai.
> >
> > If it's too ugly to generate test_expect_success with a shell
> > function, then just write a shell function that "describe" and compare
> > (i.e. the test body). Then you can write something like this later
> >
> > test_expect_sucesss 'describe with --worktree foo' '
> >         check_describe_worktree foo
> > '
> >
> > and check_describe_worktree can now do
> >
> > ( cd "$TEST_DIRECTORY" && .... )
> >
> >
> 
> My function is a modified version of check_describe().

Whoa. That function is 12 years old! I think our style has evolved a
bit since then.

> Which does the same thing. I‘m not really experienced in Shell
> programming, so I didn‘t see a cleaner way.
>
> But having the cd commands in the && chain looks broken as it would
> break the following tests when one test fails and the code was executed
> in the wrong directory afterwards.

I mean chaining within a test. This is to make sure any failure
triggers the test failure (as it should, if some command is expected
to fail, we have other ways to catch it).

I would start with something simple, not using shell function at
all. Something like this as an example (I added run_describe() because
that "git" command becomes too long). Have a look at the "do's and
don'ts" in t/README too.

-- 8< --
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index d639d94696..646bedf4e9 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -28,6 +28,10 @@ check_describe () {
 	'
 }
 
+run_describe() {
+	git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe "$@"
+}
+
 test_expect_success setup '
 
 	test_tick &&
@@ -145,6 +149,14 @@ check_describe A-* HEAD
 
 check_describe "A-*[0-9a-f]" --dirty
 
+test_expect_success 'describe with --work-tree --dirty' '
+	(
+		cd "$TEST_DIRECTORY" &&
+		run_describe --dirty 2>err.actual >actual &&
+		grep "^A-.*[0-9a-f]$" actual
+	)
+'
+
 test_expect_success 'set-up dirty work tree' '
 	echo >>file
 '
-- 8< --

BTW, careful about _success or _failure. You need to make sure bisect
is not broken. If you add a test to confirm a broken case then it
should be test_expect_failure (and the test suite will pass). Then
when you fix it you can flip it to test_expect_success.
--
Duy
