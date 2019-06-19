Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 490E81F462
	for <e@80x24.org>; Wed, 19 Jun 2019 18:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfFSST3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 14:19:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:59511 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730294AbfFSST2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 14:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560968361;
        bh=quwDzRklegdlZTt5hPs9rTUl13VvkENjhVomOcPPZfY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ky8JY7dH6odo+quz7KrOGJj+2tuoqbySN5xqGHu3myA19VyWQAFspPRMQPNmPU2v3
         2nZfqnmBwBnmtxEaGZSaUrZd77yn3lKfjEB4oDtLhBba+jF06wAz7qMFlhqbJIvM4E
         X3akH/IUB2LRn4gnWq6rvy3mEY3a9GoRwCCW1l7w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lmazv-1iCj513I5T-00aAhl; Wed, 19
 Jun 2019 20:19:20 +0200
Date:   Wed, 19 Jun 2019 20:19:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Morian Sonnet <moriansonnet@gmail.com>
cc:     sunshine@sunshineco.us, gitgitgadget@gmail.com,
        git@vger.kernel.org, MorianSonnet@googlemail.com, gitster@pobox.com
Subject: Re: [PATCH v2 1/1] submodule foreach: fix recursion of options
In-Reply-To: <201906181515.x5IFF8bg005587@pool-147-74-zam859.wlan.kfa-juelich.de>
Message-ID: <nycvar.QRO.7.76.6.1906191928420.44@tvgsbejvaqbjf.bet>
References: <pull.263.git.gitgitgadget@gmail.com> <pull.263.v2.git.gitgitgadget@gmail.com> <c46e5bd1403b45d25192220ce689fcd55d897981.1560371293.git.gitgitgadget@gmail.com> <201906181515.x5IFF8bg005587@pool-147-74-zam859.wlan.kfa-juelich.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6ALZg4DFGstnqSt1JRvlLiZV+p5m8EVPZ9EFRAOeMmvpKCzS1/q
 QEY1jxnrSCwf3y8rZxylV7LriNmeJJyoFq8vqTB5cFhEGGODr5mzJH76nnZfHrzWS7dpP9Z
 zSMuLRok5H+J8nZT3ZOvNC9r+X0BS9hOQAVd9G97KiVRqULzwVfKCeoZ5pMiAEHrUUwZhh5
 y0y4QNoWNMWmkoR4+6K8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/iThqBN/rxQ=:ChAZ1hxcPjO2yy6GKv13ZF
 vpQtFtAzOPp3wktzmYvrYMnlESqEP9nhChi0wQRJapN7oPpMRG1zZG9wuq1A2cj+hb/XY3SM5
 QyiwQv65Gl41fyyKppeqU9tVlgQru85vv+9xy4Mhnw5CrZJSRWXvH2tZBmZm9BvkUOyhCGi6V
 0wUR52CrJR1CWAY+WDpU6fjVqUJ9J8MqmBCCpp1lGA640RWVegm5+Fo9HTvRgVWPG/NUR9+hb
 dAbPsktj+e4oiUNq4ONilR/EWrNLJdvkouMo8kbOaYP/WnnMijmOY/S0C5xOEmhAsaZ6u+NUo
 vvLtKTlhB9zRrddWiYE9NrVdmmPzYF2PiEYQnERApyhc3Rf6Lojf2EadcP3HP6PTMCerP4sXd
 pNloIyS8zfOhNCDRv3xs5isaLs9KlvuO5IjI/L00DSMNrT1TJ959LhoqY4F/uo/ZDC1bkA+TE
 mUyp6LBcdMjRefdyIKkvfOy+f7uLtoDDjLpfjOuKgm30ognVHxKSW5QkUOX8k69wyGJcsBH4p
 EeGLV7D53Sm7OlRMLnNz4TtMySLcfmRUg9zBDUq4T9OVvzdrDfvbEoExgZAp1WQhJUJXT26Xv
 chhhySXS7pwAltp6dwRZOGgGIZr5altBBI7G8MfEazDGDukmF1P6nTjyGNrqQvKFHbNUj2ooM
 Zd3jpZ3ioVcZ5URcZwdjPtwNV514A9Mu35qsoM/w6QKoSV7m21xUgrGgKsy5LDqibW+EPcFS2
 wHZJ0Yo9scq8dW/0SjxiylwtYbIPCDhGT35AjF2rnQjrTtNlGzacWS2K5uc73rL01OecqPDZd
 8OG4gcImID/MeuHhiA++FKBRp6kGKQHUy5suaX+jJpNkbZlvR3j9pk0FEGNnRfb6mteNwJWno
 nt156wIjOZMKk/DoST/51RF9MLJ1rBABbcdhvBX9mj/OjMtpqYvivzVum6vzdrQ62APIM+pvY
 Sq+nKMAejiv3R+4PiYKBs7L98lyTcBY/i3iaBqNgtCrp/pxFgyb7K
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Morian,

On Tue, 18 Jun 2019, Morian Sonnet wrote:

> "Morian Sonnet via GitGitGadget" <gitgitgadget@gmail.com> wrote:
>
> > Calling
> >
> >     git submodule foreach --recursive git reset --hard
> >
> > leads to an error stating that the option --hard is unknown to
> > submodule--helper.
> >
> > Reasons:
> >
> > . Above call is internally translated into
> >
> >     git submodule--helper foreach --recursive -- git reset --hard
> >
> > . After calling
> >
> >     git reset --hard
> >
> >   inside the first first level submodule,
> >
> >     git --super-prefix <submodulepath> submodule--helper \
> >       foreach --recursive git reset --hard
> >
> >   is called. Note the missing --.
> >
> > . Due to the removal of PARSE_OPT_KEEP_UNKNOWN in commit a282f5a906 th=
e
> >   option --hard is not passed to
> >
> >     git reset
> >
> >   anymore, but leads to git submodule--helper complaining about an
> >   unknown option.
> >
> > Fix:
> >
> > . Add -- before the command to execute, such that now correctly
> >
> >     git --super-prefix <submodulepath> submodule--helper \
> >       foreach --recursive -- git reset --hard
> >
> >   is called.

This is a good explanation, even if the format is not exactly close to the
existing commit messages ;-) If you look e.g. at
https://github.com/git/git/commit/e5a329a279c7, you will see what I mean:
there is much more "prose" (and less bullet points) going on.

> > Signed-off-by: Morian Sonnet <moriansonnet@googlemail.com>
> > ---
> >  builtin/submodule--helper.c  | 1 +
> >  t/t7407-submodule-foreach.sh | 7 +++++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index 0bf4aa088e..afaf0819c9 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -540,6 +540,7 @@ static void runcommand_in_submodule_cb(const struc=
t cache_entry *list_item,
> >  		if (info->quiet)
> >  			argv_array_push(&cpr.args, "--quiet");
> >
> > +		argv_array_push(&cpr.args, "--");

This is obviously correct.

> >  		argv_array_pushv(&cpr.args, info->argv);
> >
> >  		if (run_command(&cpr))
> > diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.=
sh
> > index 706ae762e0..c554589e6f 100755
> > --- a/t/t7407-submodule-foreach.sh
> > +++ b/t/t7407-submodule-foreach.sh
> > @@ -421,4 +421,11 @@ test_expect_success 'option-like arguments passed=
 to foreach commands are not lo
> >  	test_cmp expected actual
> >  '
> >
> > +test_expect_success 'option-like arguments passed to foreach recurse =
correctly' '
> > +  (
> > +    cd super &&
> > +    git submodule foreach --recursive git reset --hard
> > +  )

I am terribly sorry that I did not catch this in the first round. I would
find it even easier to read if it used the `-C` option, like so:

	git -C super submodule foreach --recursive git reset --hard

Then you do not need the subshell, and neither the `cd`. It would become a
one-liner.

However, what is less obvious to me is that this would catch the
regression, as I do not see from the context whether the current submodule
structure is deep enough to trigger the reported problem. If I understand
the commit message correctly, `super` would have to contain a submodule
that itself contains a submodule.

If there was only one level of submodules (and from the context of this
diff, it is not clear whether that is the case), the test case would pass
even without the code change to `submodule.c`.

Of course, I can always dig deeper and find out myself (and of course I
did exactly that). But in my mind, that points to something we can
improve.

What I found is that the test case indeed fails without the fixed
`builtin/submodule.c`, but that the nested submodule does not even need to
be checked out, contrary to what I expected after reading the commit
message.

And in fact, the nested submodule is not even checked out in the test
script!

To make this test case more obvious, and at the same time to test a little
more thoroughly, maybe it would make sense to initialize that "inner"
submodule (in this test script, `super/nested1/nested2`), then make it
dirty by changing a file before the `reset --hard`, and afterwards verify
that the file in question was successfully reset.

That way, the test case would start to fail if anybody changed the script
in a way where the submodule nesting was all of a sudden no longer deep
enough to verify what the test case wants to verify.

Otherwise we would risk that this test case would start passing for the
wrong reasons at some stage.

What I have in mind would look somewhat like this:

	: make sure that nested2 is initialized &&
	git -C super/nested1 submodule update --init nested2 &&

	: make sure that nested2 is dirty &&
	echo dirty >super/nested1/nested2/file &&
	test_must_fail git -C super/nested1/nested2 update-index --refresh &&

	git -C super submodule foreach --recursive git reset --hard &&
	: now nested2 is clean &&
	git -C super/nested1/nested2 update-index --refresh


I might be overthinking this, though. Maybe it would be enough to make
sure that nested1/nested2 is a nested submodule, e.g. by something like
this:

	is_submodule () {
		case "$(git -C "${1%/*}" ls-files --stage "${1##*/}")" in
		160000*) return 0;;
		*) return 1;;
		esac
	} &&
	is_submodule super/nested1 &&
	is_submodule super/nested1/nested2 &&
	git -C super submodule foreach --recursive git reset --hard

which has the advantage of looking shorter, but it does not really verify
that `git reset --hard` *has* been working correctly in nested2: it did
not, as that nested submodule was not even initialized at that point.

So I dunno... What do you think? How can we make this test case both more
understandable and more robust against future edits at the same time?

Ciao,
Johannes

> > +'
> > +
> >  test_done
> > --
> > gitgitgadget
>
