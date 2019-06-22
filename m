Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FE771F461
	for <e@80x24.org>; Sat, 22 Jun 2019 10:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfFVKy6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jun 2019 06:54:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40576 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfFVKy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jun 2019 06:54:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so8854437wmj.5
        for <git@vger.kernel.org>; Sat, 22 Jun 2019 03:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:date:to:subject:cc:references:in-reply-to
         :user-agent:mime-version:content-transfer-encoding;
        bh=qcKn3iAkTt37v3PI61Rk7XdZcd2Qk2XhF7b4dPjhO80=;
        b=FLxBTIhCnbPmKZ6/u0BDo4aXADyx2BoOnBauWZuHIIF/jVVc9ZtsVd4wuqt7Mzcmm8
         9VVbeowRjtWff9UMwPSFY8KgrYnHkOeHTbZH/1dXiTzRsZtNzZ+s8wtnnoVc29l0udmi
         dQ3zs66cE79c8zQSIG/JVmZIDTlBNCL/8JlAHGjLKsL78Pmdg/Bl/ZoYGc/a/EIMEw5P
         Vus2U90WfVdRPr26N22RBK8ljtqzlgJEwHq/P1uN2PRfynjbkXKynm95AYOIR/gC5sFh
         4IzJ5YrsbSIWx/8tFgQDyrmc3mj79LTIchWrelYFNuWMo0nHwikE/O70A9sa9tRPNNEA
         VRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:date:to:subject:cc:references
         :in-reply-to:user-agent:mime-version:content-transfer-encoding;
        bh=qcKn3iAkTt37v3PI61Rk7XdZcd2Qk2XhF7b4dPjhO80=;
        b=eERWBlwJckmc6ZDt5PLlC/Fft5iA1Hjo37Ac6qJNo1H6qypbLqQ9/40OVhrSYhb4Ls
         FB5o0Rh5EKgsjTmo8YoLyLhpdV4TD9J6XuqGenU2omn5GWT3/IEoP+tz+8mtJIgPwhGC
         JQ7i7Acf79z9a8T7RlBynfsqnRizry2aPck8eeb/iAVLINA4cVM4co90Ac/BEMvObExh
         CVGDfVrI51fSHeboPwA10yfi+5pr3dorZd4X7lbmgTg/3gCrq5Uv920B4ZpqeuzL1BTc
         02ddZL9haihFHHoCMDAoHnYD4w3vglgM+YlyySQAjegLUSx52XWiF7yM+MBcqwyjhagM
         8O4Q==
X-Gm-Message-State: APjAAAX3WHQv5w7ZYMsS1HZwoMUMGyhEtXw21gqXCTdlOFD80YoMPYur
        FWZxynfBG6ogFkcLDW2/Vz/nIBxcqPYh3Q==
X-Google-Smtp-Source: APXvYqwLPQJMvL3/Jf31w9brly8AIqe+GfirYikPYs9xiOqMfQE8PcOGZorwhZRn/L5z8U8cUClFhg==
X-Received: by 2002:a7b:c842:: with SMTP id c2mr7804527wml.28.1561200893698;
        Sat, 22 Jun 2019 03:54:53 -0700 (PDT)
Received: from localhost.localdomain (2a0a-a542-2a07-0-a793-8424-e1d1-435c.ipv6dyn.netcologne.de. [2a0a:a542:2a07:0:a793:8424:e1d1:435c])
        by smtp.gmail.com with ESMTPSA id z76sm3913438wmc.16.2019.06.22.03.54.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 22 Jun 2019 03:54:53 -0700 (PDT)
From:   Morian Sonnet <moriansonnet@gmail.com>
X-Google-Original-From: Morian Sonnet <momo@linux-5.fritz.box>
Received: from linux-5.fritz.box (localhost [127.0.0.1])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTPS id x5MAsqH9003712
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 22 Jun 2019 12:54:52 +0200
Received: (from momo@localhost)
        by linux-5.fritz.box (8.15.2/8.15.2/Submit) id x5MAspEQ003711;
        Sat, 22 Jun 2019 12:54:51 +0200
Message-Id: <201906221054.x5MAspEQ003711@linux-5.fritz.box>
Date:   Sat, 22 Jun 2019 12:54:51 +0200
To:     moriansonnet@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2 1/1] submodule foreach: fix recursion of options
Cc:     sunshine@sunshineco.us, MorianSonnet@googlemail.com,
        gitster@pobox.com, gitgitgadget@gmail.com, git@vger.kernel.org
References: <pull.263.git.gitgitgadget@gmail.com>
 <pull.263.v2.git.gitgitgadget@gmail.com>
 <c46e5bd1403b45d25192220ce689fcd55d897981.1560371293.git.gitgitgadget@gmail.com>
 <201906181515.x5IFF8bg005587@pool-147-74-zam859.wlan.kfa-juelich.de>
 <nycvar.QRO.7.76.6.1906191928420.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1906191928420.44@tvgsbejvaqbjf.bet>
User-Agent: Heirloom mailx 12.5 7/5/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

Hello Johannes,

thank your for the review. Sorry for the spam, I messed up with the
replytoall command.

> Hi Morian,
>
> On Tue, 18 Jun 2019, Morian Sonnet wrote:
>
> > "Morian Sonnet via GitGitGadget" <gitgitgadget@gmail.com> wrote:
> >
> > > Calling
> > >
> > >     git submodule foreach --recursive git reset --hard
> > >
> > > leads to an error stating that the option --hard is unknown to
> > > submodule--helper.
> > >
> > > Reasons:
> > >
> > > . Above call is internally translated into
> > >
> > >     git submodule--helper foreach --recursive -- git reset --hard
> > >
> > > . After calling
> > >
> > >     git reset --hard
> > >
> > >   inside the first first level submodule,
> > >
> > >     git --super-prefix <submodulepath> submodule--helper \
> > >       foreach --recursive git reset --hard
> > >
> > >   is called. Note the missing --.
> > >
> > > . Due to the removal of PARSE_OPT_KEEP_UNKNOWN in commit a282f5a906 the
> > >   option --hard is not passed to
> > >
> > >     git reset
> > >
> > >   anymore, but leads to git submodule--helper complaining about an
> > >   unknown option.
> > >
> > > Fix:
> > >
> > > . Add -- before the command to execute, such that now correctly
> > >
> > >     git --super-prefix <submodulepath> submodule--helper \
> > >       foreach --recursive -- git reset --hard
> > >
> > >   is called.
>
> This is a good explanation, even if the format is not exactly close to the
> existing commit messages ;-) If you look e.g. at
> https://github.com/git/git/commit/e5a329a279c7, you will see what I mean:
> there is much more "prose" (and less bullet points) going on.

Ok, I see the differences. Shall I adapt the commit description?

>
> > > Signed-off-by: Morian Sonnet <moriansonnet@googlemail.com>
> > > ---
> > >  builtin/submodule--helper.c  | 1 +
> > >  t/t7407-submodule-foreach.sh | 7 +++++++
> > >  2 files changed, 8 insertions(+)
> > >
> > > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > > index 0bf4aa088e..afaf0819c9 100644
> > > --- a/builtin/submodule--helper.c
> > > +++ b/builtin/submodule--helper.c
> > > @@ -540,6 +540,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
> > >  		if (info->quiet)
> > >  			argv_array_push(&cpr.args, "--quiet");
> > >
> > > +		argv_array_push(&cpr.args, "--");
>
> This is obviously correct.
>
> > >  		argv_array_pushv(&cpr.args, info->argv);
> > >
> > >  		if (run_command(&cpr))
> > > diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> > > index 706ae762e0..c554589e6f 100755
> > > --- a/t/t7407-submodule-foreach.sh
> > > +++ b/t/t7407-submodule-foreach.sh
> > > @@ -421,4 +421,11 @@ test_expect_success 'option-like arguments passed to foreach commands are not lo
> > >  	test_cmp expected actual
> > >  '
> > >
> > > +test_expect_success 'option-like arguments passed to foreach recurse correctly' '
> > > +  (
> > > +    cd super &&
> > > +    git submodule foreach --recursive git reset --hard
> > > +  )
>
> I am terribly sorry that I did not catch this in the first round. I would
> find it even easier to read if it used the `-C` option, like so:
>
> 	git -C super submodule foreach --recursive git reset --hard
>
> Then you do not need the subshell, and neither the `cd`. It would become a
> one-liner.

Alright, I have to admit I wasn't aware of that option.

>
> However, what is less obvious to me is that this would catch the
> regression, as I do not see from the context whether the current submodule
> structure is deep enough to trigger the reported problem. If I understand
> the commit message correctly, `super` would have to contain a submodule
> that itself contains a submodule.
>
> If there was only one level of submodules (and from the context of this
> diff, it is not clear whether that is the case), the test case would pass
> even without the code change to `submodule.c`.

This is not entirely correct, I think. In the case where we found the
error, no nested submodules were present. The buildkite agent however,
due to the mere presence of submodules, still calls git submodule with
the recursive flag.
Inside submodule-helper the next level of the submodule-helper is called
again, without checking for the presence of nested submodules.
Hence, one level of submodules should be enough for now.

However, in sight of making the test more robust, one should actually
use at least a two level deep git for checking, so that in future no
potential false positives are created. That is, if the submodule-helper
suddenly starts checking for the presence of nested submodules, before
calling its next iteration.

>
> Of course, I can always dig deeper and find out myself (and of course I
> did exactly that). But in my mind, that points to something we can
> improve.
>
> What I found is that the test case indeed fails without the fixed
> `builtin/submodule.c`, but that the nested submodule does not even need to
> be checked out, contrary to what I expected after reading the commit
> message.
>
> And in fact, the nested submodule is not even checked out in the test
> script!

The reasons for these points are explained by the text above, as the
submodule-helper does not check for the presence of nested submodules
before calling its next iteration.

>
> To make this test case more obvious, and at the same time to test a little
> more thoroughly, maybe it would make sense to initialize that "inner"
> submodule (in this test script, `super/nested1/nested2`), then make it
> dirty by changing a file before the `reset --hard`, and afterwards verify
> that the file in question was successfully reset.
>
> That way, the test case would start to fail if anybody changed the script
> in a way where the submodule nesting was all of a sudden no longer deep
> enough to verify what the test case wants to verify.
>
> Otherwise we would risk that this test case would start passing for the
> wrong reasons at some stage.
>
> What I have in mind would look somewhat like this:
>
> 	: make sure that nested2 is initialized &&
> 	git -C super/nested1 submodule update --init nested2 &&
>
> 	: make sure that nested2 is dirty &&
> 	echo dirty >super/nested1/nested2/file &&
> 	test_must_fail git -C super/nested1/nested2 update-index --refresh &&
>
> 	git -C super submodule foreach --recursive git reset --hard &&
> 	: now nested2 is clean &&
> 	git -C super/nested1/nested2 update-index --refresh
>
>
> I might be overthinking this, though. Maybe it would be enough to make
> sure that nested1/nested2 is a nested submodule, e.g. by something like
> this:
>
> 	is_submodule () {
> 		case "$(git -C "${1%/*}" ls-files --stage "${1##*/}")" in
> 		160000*) return 0;;
> 		*) return 1;;
> 		esac
> 	} &&
> 	is_submodule super/nested1 &&
> 	is_submodule super/nested1/nested2 &&
> 	git -C super submodule foreach --recursive git reset --hard
>
> which has the advantage of looking shorter, but it does not really verify
> that `git reset --hard` *has* been working correctly in nested2: it did
> not, as that nested submodule was not even initialized at that point.
>
> So I dunno... What do you think? How can we make this test case both more
> understandable and more robust against future edits at the same time?

My test so far was designed to not actually check whether git reset
--hard has shown any effect. I think other tests in the test suite exist
already, testing for the correct execution of the command in each
submodule. See for example "test messages from "foreach --recursive" from
subdirectory'" and following.

This is why I think the second test of yours would be totally sufficient
to test the introduced changes. That is of course only in combination
with the already existing tests, whose testing functionality will
remain. (I think that is a safe assumption.)

However, I think that your test might be a little bit too much,
comparing it to the other tests of the suite.

Taking the test "test "foreach --quiet --recursive"" and the test
"option-like arguments passed to foreach commands are not lost" for
example, I suggest the following:

	git -C clone2 submodule foreach --recursive "echo be --hard" > expected &&
	git -C clone2 submodule foreach --recursive echo be --hard > actual &&
	grep -sq -e "--hard" expected &&
	test_cmp expected actual

By using clone2 we can be sure that we have a fully initalized git setup
with at least two levels of submodules, as it is also used by several
previous tests. By grepping the expected we can also be sure that the
echo command was correctly executed as reference. Finally, comparing the
actual output with the expected output then shows that the option is
also correctly passed without using the "".

As final comment: One could change the flag --hard to something which
will definetely never be an option flag for both, echo and git submodule
foreach, e.g.  --this-will-never-be-an-option.

Please tell me what you think about the proposed test.

Best regards,
    Morian

>
> Ciao,
> Johannes
>
> > > +'
> > > +
> > >  test_done
> > > --
> > > gitgitgadget
> >
