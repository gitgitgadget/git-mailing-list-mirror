Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C607C38BFA
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 22:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC86421927
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 22:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Up103iwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgBXWUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:20:42 -0500
Received: from mout.gmx.net ([212.227.17.20]:36711 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgBXWUl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 17:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582582834;
        bh=sYBpN8fbBLwUAU9Sf5SXEPJ5PQ9emACugpgttzwmf6M=;
        h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date;
        b=Up103iwgrbBEmX53ujUQr+9cLh2jSsl72iWQJKap9oJzbAvnIj8Dabby7GLDCSpp2
         wCreYG5dSwaTSYEUpaWtwze4lFQznW8YGJxCsyIrCe0eTgCQOWtGM9YG0jiMzbPv7B
         LbmDRnoDQgelNiRisHnYey5cUL+7o3hJE+KLwZYE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from PCMarkus ([82.207.236.6]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72sJ-1j3t7717XD-008c4j; Mon, 24
 Feb 2020 23:20:34 +0100
From:   <masmiseim@gmx.de>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Markus Klein via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>
References: <pull.695.git.git.1580505092071.gitgitgadget@gmail.com>     <pull.695.v2.git.git.1580851963616.gitgitgadget@gmail.com> <xmqq1rr7fsh3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1rr7fsh3.fsf@gitster-ct.c.googlers.com>
Subject: AW: [PATCH v2] clone: use submodules.recurse option for automatically clone submodules
Date:   Mon, 24 Feb 2020 23:19:09 +0100
Message-ID: <011f01d5eb60$6fdf9890$4f9ec9b0$@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQC+b765Vx0L6eSzRXNqX30Es25hHQDq1rPuAhzqS3uqQaI3EA==
Content-Language: de
X-Provags-ID: V03:K1:HZb/Ip3DPfJCdiHQPnqa0ajeb0kBO3TgqePEDmBJ9CPfdH9H2FL
 wLNfV1CfQQfUWCbN7Pg9iemVaYKk7cwq5sfdAG/A/qCw9D1S5BTqsTf8ao1XW42CyDJ1rIf
 452CtEVDfh5wXIyEPrPBf397ZsfJI7JYPP0ALBYe2zp3tQL1K3w/lX2kwLi75US/Zqt/FRe
 egiv6bwCPoZ0YsAqz7SYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oimrhA7iNak=:4kAcBPK18oixOojC7UN3tj
 N1F1zuFgsHGL05bHsq9EF3Nzm8LVLA8pyLqtCmYZTIb4/ydeD3tOFn+c0VhaLv7QqKuJcByUs
 NWoYBu1exrrYcuTO92f952cR27Jg3CbXCVNibWlLehaBhzDpUlEoioRaFYxUKgzhiufYeY/Ek
 teVWGZs8cg9RWIwmpY9kSbtO7RyofCS5fD3jvyTurEiFLK9UQQv0l8r0pROYjfufB39qMS2A1
 v/I0APeLM/Ncrwp7gB+cn15GqUGEr89erZFsbGvQbGb1IfKX65ZWR7MWble/g6AgFXMqhSRRM
 zmYWEEvzIes/Td4YU4biuIXFN56/9CNQZEtsUs9a/s0dSju75mYU9u9zrqcwp6DrH8PLsJGE7
 nsh7NWRsZWoWvOWxjWOzT4wegkMKkXPSf+KG3vw/kwDNbYd0oJaMSFtnx6gy0dskcIv+qwF44
 juXBls4czs/agaCkc/XV1knOLc05t7m7h45LVlvZ0Rw8R2UzCh5c+bmgZybAfcMbw082Lrg82
 Q7+57HVzN7qziHz0s0gPyFD3Rr47lh+dXbZZJyaUpHEqBViividcz7CNAYczggWwS+4Q6r9xY
 /VgGWxqtn9L38upyHqQQj9RypdAVQsfcTbp6ED9OABp2E14CXAeUEcjDGA0JfDgmgkNykPgqj
 NRFlyU5TWjwQG5rws6qvt1DT/hX1/AAsxfWIW4T6Q39amFdW9IWXvVV2p3rkcqCpa531ut/lH
 4Flts2kN6x0Vj0F2eGnL9RSUfxipgFp0y19uJl74yjDNekNba4dyRhiO4lsBoVzfsg941DEaT
 GajX6kmO37Kzybg2lcHmJXqXamfNP7ef6GMtSIx5Zmib4X0PpmThYDa2a6Ry/ohBThatj9d6l
 aKcQndG2ScBksaeg7y+QhZnR+B8vb+eAmGnYRgh66XLuzm/bikkmimP+KgbMYrdW1VkSBoX14
 TbjnKZ9Iyxknni2w4yfGSlfbUuoDl4SduCtwA1uTOvy3A8sv91lYrIiiAQ7p60ZvNB6ms/0ij
 MjWqTUSyIto00jO5mNbYLsjA0hsWF80l2QuECknzWyJGNXhneUYah3I6PZ5Ysr7sB3IZzvCXv
 NY6RZNZWVdTcE+A7JVEJxoUiLno4YKAKXa14SA9CeYnsAP4awAkAsAB4Wq71uOHe/e1i/kcnz
 apsALCuuhMr1CNgLP3mLPVUlIVnMKeD/jimKTAxjU2L7hrTi1W8Nv28HSPr+YVJoHiLl9WgjW
 q9OCY+HHjxW/zU210
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> "Markus Klein via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > From: Markus Klein <masmiseim@gmx.de>
> >
> > Simplify cloning repositories with submodules when the option=20
> > submodules.recurse is set by the user. This makes it transparent to=20
> > the user if submodules are used. The user doesn=E2=80=99t have to =
know if he=20
> > has to add an extra parameter to get the full project including the =
used submodules.
> > This makes clone behave identical to other commands like fetch, =
pull,=20
> > checkout, ... which include the submodules automatically if this=20
> > option is set.
>=20
> I am not sure if it is even a good idea to make clone behave =
identically to fetch and pull.=20
> We cannot escape from the fact that the initial cloning of the =
top-level superproject is a special
> event---we do not even have a place to put the configuration specific =
to that superproject
> (e.g. which submodules are good ones to clone by default) before that =
happens.

It behaves only identical if the option "submodule.recurse" is set in =
the global .gitconfig. So, it is optional for people who know what they =
do. For people which use submodules heavily, this is very useful.

For the case where you don't like to get all submodules but have this =
option set, you can disable it via --no-recurse-submodules

>=20
> You misspelt "submodule.recurse" everywhere in the log message, by the =
way, even though the code seems
> to react to the right variable.
>=20
> > It is implemented analog to the pull command by using an own config=20
> > function instead of using just the default config.
>=20
> I am not sure if this is worth saying, but it is not incorrect per-se.
>=20
> > In contrast to the pull
> > command, the submodule.recurse state is saved as an array of strings =

> > as it can take an optionally pathspec argument which describes which =

> > submodules should be recursively initialized and cloned.
>=20
> Sorry, but I do not think I get this part at all.  Your callback seems =
to add a fixed string "true"
> to option_recurse_submodules string list as many times as =
submodule.recurse variable is defined in
> various configuration files.  Does anybody count how many and react =
differently?  You mention "pathspec"
> here, but how does one specify a pathspec beforehand (remember, this =
is clone and there is no superproject
> repository or its per-repository configuration file yet before we =
clone it)?

I'm so sorry for the confusing with the true. This is definitely wrong. =
Johannes already pointed this out to me and I had already fixed it. =
Shame on me, as I had uploaded an old version :-(

>=20
> > To recursively initialize and
> > clone all submodules a pathspec of "." has to be used.
> > The regression test is simplified compared to the test for "git =
clone=20
> > --recursive" as the general functionality is already checked there.
>=20
> Documentation/config/submodule.txt says submodule.recurse says
>=20
>     Specifies if commands recurse into submodules by default. This
>     applies to all commands that have a `--recurse-submodules`
>     option, except `clone`.  Defaults to false.
>=20
> so I take that the value must be a boolean.  So I am lost what =
pathspec you are talking about here.
>=20
> > +/**
> > + * Read config variables.
> > + */
>=20
> That's a fairly useless comment that does not say more than what the =
name of the function already tells us X-<.

True, this was copy'pasted from the pull implementation. So it should be =
useless there also.

>=20
> > +static int git_clone_config(const char *var, const char *value, =
void=20
> > +*cb) {
> > +	if (!strcmp(var, "submodule.recurse") && git_config_bool(var, =
value)) {
> > +		string_list_append(&option_recurse_submodules, "true");
> > +		return 0;
>=20
> The breakage of this is not apparent, but this is misleading.  If =
submodule.recurse is set to a value
> that git_config_bool() would say "false", the if statement is skipped, =
and you end up calling
> git_default_config() with "submodule.recurse", even though you are =
supposed to have already dealt with
> the setting.
>=20
> 	if (!strcmp(var, "submodule.recurse")) {
> 		if (git_config_bool(var, value))
> 			...
> 		return 0; /* done with the variable either way */
> 	}
>=20
> is more appropriate.  I still do not know what this code is trying to =
do by appending "true" as many
> times as submodule.recurse appears in the configuration file(s), =
though.
>=20
> When given from the command line, i.e.
>=20
> 	git clone --no-recurse-submodules ...
> 	git clone --recurse-submodules    ...
> 	git clone --recurse-submodules=3D<something> ...
>=20
> recurse_submodules_cb() reacts to them by
>=20
>  (1) clearing what have been accumulated so far,
>  (2) appending the match-all "." pathspec, and
>  (3) appending the <something> string=20
>=20
> to option_recurse_submodules string list.  But given that =
submodule.recurse is not (and will not be without
> an involved transition plan) a pathspec but merely a boolean, I would =
think appending hardcoded string
> constant "true" makes little sense.
> After sorting the list, these values become values of the =
submodule.active configuration variable whose
> values are pathspec elements in cmd_clone(); see the part of the code =
before it makes a call to init_db().
>=20
> So, I would sort-of understand if you pretend --recurse-submodules was =
given from the command line when
> submodule.recurse is set to true (which would mean that you'd append =
"." to the string list).
> But I do not understand why appending "true" is a good thing at all =
here.
>=20
> Another thing I noticed.
>=20
> If you have "[submodule] recurse" in your $HOME/.gitconfig, you'd want =
to be able to countermand
> from the command line with
>=20
>     git clone --no-recurse-submodules ...
>=20
> so that the clone would not go recursive.  And that should be tested.  =

>=20
> You'd also want the opposite, i.e. with "[submodule] recurse=3Dno" in =
your $HOME/.gitconfig and running
>=20
>     git clone --recurse-submodules ...
>=20
> should countermand the configuration.

Thanks for the hint. I added this tests, and it was very helpful, as it =
pointed out, that the disabling via --no-recurse-submodules was not =
working.

>=20
> Thanks.
>=20
> > +test_expect_success 'use "git clone" with submodule.recurse=3Dtrue =
to checkout all submodules' '
> > +	git clone -c submodule.recurse=3Dtrue super clone7 &&
> > +	(
> > +		git -C clone7 rev-parse --resolve-git-dir .git --resolve-git-dir =
nested1/nested2/nested3/submodule/.git >actual &&
> > +		cat >expect <<-EOF &&
> > +		.git
> > +		=
$(pwd)/clone7/.git/modules/nested1/modules/nested2/modules/nested3/module=
s/submodule
> > +		EOF
> > +		test_cmp expect actual
> > +	)
> > +'

Thanks for the feedback


