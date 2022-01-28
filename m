Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4115AC433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 11:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244318AbiA1Lnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 06:43:50 -0500
Received: from mout.gmx.net ([212.227.17.21]:41197 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237378AbiA1Lnt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 06:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643370227;
        bh=xBfLYhmMe0qUfVFA/hzdIwMM6z9VHyOlredLD6NsFrk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XB9b0fpHp7CBGjzhPw6mHwKcbqmSWq3nqA6fjNcT/okmMlZ/gMZylXlrK41b2M/xP
         IFhl9PlbFvsSnVg0ZJS2xRzl8EIOPZYqkoptAaYMzzQB06EKvGdepPS01+Ftbj4Qo0
         +8aESLPmRiyaEemfrH1u+exQYOvWk3UD5FRlk5II=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.213.181]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAfUe-1n6r9P0wgK-00B5mR; Fri, 28
 Jan 2022 12:43:47 +0100
Date:   Fri, 28 Jan 2022 12:43:44 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] scalar: accept -C and -c options before the subcommand
In-Reply-To: <YfG0ybYOCwDzlbi5@nand.local>
Message-ID: <nycvar.QRO.7.76.6.2201281227330.347@tvgsbejvaqbjf.bet>
References: <pull.1130.git.1643195729608.gitgitgadget@gmail.com> <YfG0ybYOCwDzlbi5@nand.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Dh9RKhEFwKFwHSS6WtZZmlaoQy4ZglA3sde1xNH0mzhBuwqXTYk
 54ZMxmjnbS9ICiExZEhoYufmJYNL/8db61vCq371wdbM7bH6rmcVIudS8y66fGDRPKJbGgS
 eKzfq7xz6D7clbKujk1uBBQXWIyYivPhm5ZbmvMFMOgL2+/EmIzK3jZ+tjZnvmKAkue3E7I
 uRn1qqArlUCKxTiSdgRMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U+TIVX4Mlmo=:+lKn814Fr5G7QUMjIHX1wY
 H9knE4e/fzNvgPkI/oBnMefm/8GThyApUqZuWk1UNjOFe3sAGcqVzk9M4B9nKM7lgdCClEmCb
 Fq6HTBr5opfLwgtewqeSKwnysJSRjGvTngm+JBJ2zWKKjbPwiMxcbfWnNj7rdl3GDrSh9WrLW
 ZFaleL+M4ccTmGdaHMC7RH6hWbinlH9UKbNnRp1f7wtZzeine7wyolbrYhSj/x/EuaToA7ojl
 Tb2i17tVBg3npQH47KvwmKFu495OuvNCmMoDnKCQsq5hsoqGZdY/VrxjJcLBwYUYGVgik/fB1
 nWPdjScIwwAUy/3snqhmsNJ/td7IC1a/RjrIJwyROL54u+b2YRcyhXpHt88H/5pHroNfhpXUf
 oy8rjQ7g7U/rGmKdhI5QEOsXJjV/OAsaxyUPL0wb70e4cLTa8EhvSAJk4stI1Am/Q3me6V1FW
 V+xSzl0Acg34Lcgs5fYmyVBN3XupWGr6gT5UfLc5zF+7Piug/XAyKqQLQHuZbELe9+DQxiLhF
 ZnMQgUMPPUXwvhXUn+4sbIJt1XUEj71mzlI5a3q4yXXVFhRb8taeQd+HMqAqh5ENgf9rY9K9g
 eG0D7bk39g6z+55H98JcOPr1DnMdo0Ihu7DtlhMqUnXFbP9S8Z084jkarIRW4OT39qNbs9a3G
 10ZT/jnohFCPhUd3Rk1nSLld4xb2xUfsdrBkNTl9HG/NQ9eI9ZGDDWqOn6/G6nzvV3wxU0iWH
 sfRxqajEn93DVK76cxTwi4YJ4tQg/s8IdFVzJNL9qjr9LJnjp7zbPBVHiQXgkV+ICQN1B9wae
 vASd/A7h+TW6O2ZgG3a9liEF9mAozM2hHzK7SpFNi25bAU4IPbj7B4WKeCq6Uu13gf1bhy3BH
 0kAGViuNSDB49wAPKXRZWDtcq0QRE20otAN3RQU/AVRdSCBG0Ofjcgq8uA3ThkSdBHRe7f0YB
 0HtqCy2g0MRwd1qr9rCa6TYR3Q+xUnf0IGXmoYUKRhOC2CiHo9glaGJhCWEBsgPj79gE87Fj4
 VMIr1T5tqZZOrZdgQ+hij8I/W5N20V8iA903F3vMels1Bp7vVycCzueywFQFyUUSEVLRPfQcH
 qqfHqZdABIVzEY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Wed, 26 Jan 2022, Taylor Blau wrote:

> On Wed, Jan 26, 2022 at 11:15:29AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The `git` executable has these two very useful options:
> >
> > -C <directory>:
> > 	switch to the specified directory before performing any actions
> >
> > -c <key>=3D<value>:
> > 	temporarily configure this setting for the duration of the
> > 	specified scalar subcommand
> >
> > With this commit, we teach the `scalar` executable the same trick.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     scalar: accept -C and -c options
> >
> >     This makes the scalar command a bit more handy by offering the sam=
e -c
> >     <key>=3D<value> and -C <directory> options as the git command.
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1130=
%2Fdscho%2Fscalar-c-and-C-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1130/ds=
cho/scalar-c-and-C-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/1130
> >
> >  contrib/scalar/scalar.c   | 22 +++++++++++++++++++++-
> >  contrib/scalar/scalar.txt | 10 ++++++++++
> >  2 files changed, 31 insertions(+), 1 deletion(-)
> >
> > diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
> > index 1ce9c2b00e8..7db2a97416e 100644
> > --- a/contrib/scalar/scalar.c
> > +++ b/contrib/scalar/scalar.c
> > @@ -808,6 +808,25 @@ int cmd_main(int argc, const char **argv)
> >  	struct strbuf scalar_usage =3D STRBUF_INIT;
> >  	int i;
> >
> > +	while (argc > 1 && *argv[1] =3D=3D '-') {
> > +		if (!strcmp(argv[1], "-C")) {
> > +			if (argc < 3)
> > +				die(_("-C requires a <directory>"));
> > +			if (chdir(argv[2]) < 0)
> > +				die_errno(_("could not change to '%s'"),
> > +					  argv[2]);
> > +			argc -=3D 2;
> > +			argv +=3D 2;
> > +		} else if (!strcmp(argv[1], "-c")) {
> > +			if (argc < 3)
> > +				die(_("-c requires a <key>=3D<value> argument"));
> > +			git_config_push_parameter(argv[2]);
> > +			argc -=3D 2;
> > +			argv +=3D 2;
> > +		} else
> > +			break;
> > +	}
> > +
>
> All looks right to me based on a cursory scan. It's too bad that we have
> to copy this code from git.c::handle_options().

It's only a dozen lines, though, and they are pretty stable, so I doubt
that we risk divergent copied code.

> Could we call handle_options() (assuming that it was available to
> Scalar's compilation unit) instead? I'm not sure if that's a naive
> question or not, but it might be nice to explain it out in the commit
> message in case other reviewers have the same question that I did.

I just responded to Stolee elsewhere in this thread with a lengthy
analysis of the options, and the conclusion that it would not be worth the
effort to refactor `handle_options()`.

> On a more practical note: is there an easy way to test this?

It would be pretty easy to test `-C`:

	git init sub &&
	scalar -C sub register &&
	[... verify that `sub/` is now a Scalar repository ...]

For `-c`, we would need to configure something parsed by
`git_default_config()` that would influence what `scalar register` does,
then verify that. Or even better, use a config setting that is in the
"Optional" section of `set_recommended_config()`, i.e. it will refuse to
override an already-configured value. Something like `status.aheadBehind`.

I added this:

=2D- snip --
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-sca=
lar.sh
index 2e1502ad45e..89781568f43 100755
=2D-- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -85,4 +85,12 @@ test_expect_success 'scalar delete with enlistment' '
 	test_path_is_missing cloned
 '

+test_expect_success 'scalar supports -c/-C' '
+	test_when_finished "scalar delete sub" &&
+	git init sub &&
+	scalar -C sub -c status.aheadBehind=3Dbogus register &&
+	test -z "$(git -C sub config --local status.aheadBehind)" &&
+	test true =3D "$(git -C sub config core.preloadIndex)"
+'
+
 test_done
=2D- snap --

Ciao,
Dscho
