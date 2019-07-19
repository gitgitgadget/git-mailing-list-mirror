Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB8B1F461
	for <e@80x24.org>; Fri, 19 Jul 2019 14:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfGSOw0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 10:52:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:35023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfGSOw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 10:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563547937;
        bh=gAf6VCV7PjWBkzjXTBoWiJGevSm7rxxmQJ6QHKD5iaA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GivzAkOoxnN3JF0jNptI+YAJNbYfC3kqWW5O5K5CugafVB6XZVj0v5iswB2Lc08m2
         by55WDL1rJ1QN3sQtl84+geHUew30MyvCFUSw4H5XMbsY01H5Rcq80pMhFb+sNXwJt
         tix6bFHgdSszdji5uJhyb7RWKhQRdJr0ZUfmop2o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lx5hl-1iToM41s8v-016gj3; Fri, 19
 Jul 2019 16:52:17 +0200
Date:   Fri, 19 Jul 2019 16:52:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 23/24] t5505,t5516: create .git/branches/ when needed
In-Reply-To: <xmqqftn3xet7.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907191555180.47@tvgsbejvaqbjf.bet>
References: <pull.287.git.gitgitgadget@gmail.com> <db69b33ff4a583f75e07f15d10dba70bd99fcaf7.1563455939.git.gitgitgadget@gmail.com> <xmqqftn3xet7.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/1/+GZJzzavwJoJN5uchv8sjXMLAa74X7tyUSNcW3pSFBHw2CGO
 WU3YhYIuK2BuExxsOnAvNP5ka3I5Q+gdttZgz84JECi+dYYjN7YNkMvMAN8P7K+jpgLTMUd
 ilrizCMS50GN5hVeE43G6ackfF3h8ArpVD3sLYcUCIaT+PBCnKRQhRoqwGdM14QV0CQUDLc
 FNEsZQiVpSn1BilBZtydA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v5rEKTuJ6sQ=:JlNRRywHUG+f6sHSk8nCB5
 WhyBfVErogD4uF/IRQ82MkyDovPCi1UH0i6ncI+qmrPFYd0Pm1qmdLdXEMesMtglj37L4MlUj
 WVilkPGqg78GsjURo+IrOAHQWf5qMhtGYUS0dxdNojYDwrrCHRa3Sjm3t/zaGZ25yu9BoaH9+
 9Pl2reIC4D6k6hiGkRtr8G9k4p4nQvRuuhCIeB2nyspBlRZpgThgcd4E0Jjq/Cn7f5T/cIfdu
 qHZTN80VoXP/VjRWyfkLPEBg/iW/cdewJXCPnaEolnn0WiJiPGCw+pnNfEBNSlzMHIweDmCUb
 jRu4+ChOx0N6riK2ubzzscFu1rGy5Fhay+27m2x5AU6YZSjDSwBvHWEOJ95W0Ks2DUM5R6LS2
 OGLNwe9Aop1c4TT8h6owPM4wutzR4RQBkP41aPpFGE1qvSEk2PhySKvccTbyUxYEmMkkTpXom
 Ybrjw/e7NCHhTElx5EzAY2o7QDsbe3nYlqCE7YA2aBO6+mmKS5t2VecAvGOCPUMSA0K2438dr
 Z/4xYX3/zd4HnQS4h5CDH9NME4gqw2tPw6P1/4XZ8qO7LEhgaBgL9pblkLbKomOwD4uMUiD1n
 Hy7c8YpZMWWbb94388WUfPki95vt9i53lOCrmatwAZfP5F5GbaDbKWnRMMg5R85XqPRjrQkKk
 TBpGMTECL52fxbLlG4zzdMBkiI0PbhgliF0WVhFIWMxxHcSatoWq2Nwnifs4xPYBzlaG2Lgxo
 1dkjwzg0kNUd/lWw6ulfvVW4Fhlfp7F4A79DnLO22pMM4M7/K14DwpJ+QbGAAi2TLUMC0FjU+
 2QzhgDblM5fTI+Jiagl03GzUHUTV7TJdvsO/GcCSATnU2ssOjzSOgSRhhmjGfrR0nZV8Kp6Yi
 v/mxUQbV8pcd8mHUUTnfFcLJ7LyWpt8IpbyX9X6R1ljCfGZR6EARfQxkUjXkXyv/dwar63ImO
 G/PXTuxaL0aRZ4dZ4EoB4ngk+qsQ+iiHLnkprXjUCP38srYfoMl2PgLSPJCL5zxkJ8IS8oHJn
 JRvHadbJ1bxGVGlhsTG63GSNOpO3Q96BCqp34Ty2CN+MS6EgqVpmRdJSmX1qGkqRu1+ZtHZ3f
 1UjMsqUzNXykUHAPKMwanUlGad6p74uYNR9
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 18 Jul 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > It is a real old anachronism from the Cogito days to have a
> > .git/branches/ directory. And to have tests that ensure that Cogito
> > users can migrate away from using that directory.
> >
> > But so be it, let's continue testing it.
> >
> > Let's make sure, however, that git init does not need to create that
> > directory.
> >
> > This bug was noticed when testing with templates that had been
> > pre-committed, skipping the empty branches/ directory of course becaus=
e
> > Git does not track empty directories.
>
> Many tests assume that the .git/info/ directory exists, and the only
> reason why they can is because we have templates/info--exclude; the
> situation around .git/branches/ is exactly the same.

No, the situation with `info/` is that it includes a file called
`exclude`, which means that the `templates/` directory can be "tracked".
This is important because we want to commit all those generated files
that cannot be generated inside Visual Studio without Git for Windows'
SDK (which weighs in with several hundred megabytes to download, a
gigabyte on disk).

The `branches/` subdirectory, in contrast, is totally useless for at
least 99.999% of the users, and hence it is understandable that it does
not even contain a single file. Which means that it is *not* "tracked".

So when checking out, e.g. the `vs/master` branch at
https://github.com/git-for-windows/git, which is auto-generated using
this here patch series from Git for Windows' `master`, to allow building
in Visual Studio without having to download the full Git for Windows
SDK, there will be the `info/` directory (by virtue of containing a
trackable file) exists, and the `branches/` subdirectory won't exist.

As a consequence, the test scripts indicated in the commit message,
which _can_ be run in a regular Git for Windows (no Git for Windows SDK
required), will fail without this patch.

> Deprecating .git/branches/ directory and dropping the parts of tests
> that wants to make sure the support still works (t5516 is not about
> migration but about working with .git/branches configuration) would
> be a different matter.

Indeed.

You probably forgot that I already proposed that, long time ago:
https://public-inbox.org/git/cover.1494509599.git.johannes.schindelin@gmx.=
de/

I haven't forgotten, because you shot it down unceremoniously:

	The last time I thought about trying this several years ago, I found
	that people who need to grab things from many places still do use
	.git/branches/ and their use case is hard to migrate to .git/config,
	primarily because the former is "one per file" and it is easy to
	add/remove/tweak without affecting others.  Ask akpm@ if he still
	prefers to use .git/branches/ for example.

Of course, with such a kind of argument, there is no way how I could
possibly prove that it is no longer advisable to have `.git/branches/`.

"Someone, somewhere _probably_ finds this still useful, so we won't
remove it."

> Until that happens, let's not do this patch;

Well, that's another of these type of arguments.

Without this patch, and without removing support for `.git/branches/`,
you force the Visual Studio build to _not_ pass the test suite. It's as
simple as that.

So basically, by this statement you decided that there will not be a
fully-functional way to build Git in Visual Studio and to pass the test
suite with that.

Which is a shame.

> otherwise it would force us to sprinkle "mkdir -p .git/info/" all
> over the place for the same rationale.

You may have assumed that I did not carefully verify that the test suite
passes with these patches. But I did. And I would not have submitted
this patch series if such a patch was necessary, at least not without
said patch.

> A directory in .git/ created by hardcoded mkdir in "git init" (like
> .git/refs/) and created by copying templates by "git init" (like
> .git/info/ and .git/branches) are both "created by 'git init'".
> Special casing the latter is just silly.

The thing that _really_ is silly is that we have that directory in
Git's templates, still.

Git itself does not populate it. Git does not need it, ever. Git works
Just Fine without it, and it is really by design that it does not
require the presence of that subdirectory.

Only those two test cases insist, for some reason that escapes me, on
the presence of those subdirectories.

As I said, Git does not populate that subdirectory. It even lacks all
facilities to populate it. You have to write the files inside it
yourself, you have to figure out the syntax of the files in that
directory, and the only place where we document this is buried deeply in
`Documentation/gitrepository-layout.txt`.

It is a bit silly, too, that we say there, in that very documentation
for that very feature, that this feature is "slightly deprecated".

Either it is deprecated, or it isn't.

Further, it is a bit silly that this "slight deprecation" has been there
since a1d4aa74241 (Add repository-layout document., 2005-09-01).

In other words, that feature was "slightly deprecated" already a mere
five months after Git was made public. Yet we still shlep it around,
fourteen (!) years later.

In yet other words, the support for `.git/branches` has been "slightly
deprecated" more than 33x longer than it hasn't been.

I just wish that my patches to remove the support for `.git/branches`
would have gone somewhere useful instead of into this ugly impasse.

Ciao,
Dscho
