Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DDFC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 15:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242102AbiBYPbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 10:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbiBYPbN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 10:31:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C3A218CD7
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 07:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645803037;
        bh=dqFosB/OuKN262auf0CJBCGD079USK0b7Htad6T0IfI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d7QM+0ejcLAdbXYqbTa70Th52liQNSWyWcWTfqlBkx5tQ+RJbnnSCkFnsZSqiAcwg
         hjaQGdI7MOYxox47LxLR4H8Xskju2+gVjfM4rMZOL8Oby4TCRpj0qBxslz+d3zpo5h
         Smwmwz+lrLwtwI/MRhywbaqJuv29ehme4d5vAw0w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqs0R-1o1J1g1ULh-00mrJp; Fri, 25
 Feb 2022 16:30:37 +0100
Date:   Fri, 25 Feb 2022 16:30:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] add usage-strings ci check and amend remaining usage
 strings
In-Reply-To: <20220222154700.33928-1-chakrabortyabhradeep79@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202251600210.11118@tvgsbejvaqbjf.bet>
References: <alpine.DEB.2.22.394.2202221436320.2556@hadrien> <20220222154700.33928-1-chakrabortyabhradeep79@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iGa/H1ykDhm6d2OwSnUlsgCI6l+UQJGbTZca/6NF/woUjEDwhB/
 38dsQsmXDpNVZf4IE4ZDwnaSoYIM8O5i97C0BU4m/O46QcwuyCpoJSzHhW2hiF8as84TAst
 K8e1xBzSXCbJs1OKes8kIHURlyurESMiz1229VTaj+TIvaqp4znza8ZWj7bfDCgDrun9GMy
 VKRsG1zUshJF5vJM2HUMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SgWkiV/2EYo=:Q/lIIOmBQ8GqmC1UT9AoYI
 3l89oTXTjuHwtsKAS2XTAGWT5dDCb6GwEJZ/bCoIN/N913mF3MmztU4L/hbZ1e0GrULf805rI
 J8OOeci7qykCHWhsnJmsoT4vh3wKWp//KWJjYSMNrlPT1c1bqk6+KClI18Dt2CQR4bTF+2F5H
 hpAIJz3doqBD19IOLUMJDAjDjVypf6qGHujc3mkf4gRcFV8Sk8IthcmHjmYZCkzRyWEcy/ANL
 OdtEO924Q7lf8FC6WxvGgCAXEVRxwfL1Cy+DI6gkkX9cBXv2MB2p2PhBw9bGoXK4ZvwCTmwLe
 WVMNw9nchrgaWvGJRUhIlMui9nWY1w+HXC4QkBOO6l7IyoUEfejtCzx6lxgHeKxUnSK4ffo0r
 7jFFbnIlOPggpMZDK8QeqFaUUiUT/DFbFzwBtXWceFnskxpsUZ9fCiyVqIvOLdId5QO+D9tT7
 viibh3nTaE/zovVp2RZsoWOQ/fXSG0wDbRA3FzNGZPbMER5TQlC8SCUQa7rMXsFmIx01ceupo
 zOe2/SLqy15rLoJ+Nqz1Lj4M1+rnrmwVi1FxMJjH57AtrJgMpZeUe1isXZN0GG8MXVnkcTSey
 tTep4G+vdMzsKk/Uw7LdLK96Fu+MV8Aun/516FI7X4cI4cJpptCCCbc8BzOyBF4m/m5aslxj4
 LPZxggKW2jIjatkrKNBQyAIpSmlZFcpMdtUXT7YUiiqq1cUh0pMB3yuJGqleAPKMSRpYg4WiE
 SMR4t2F8vk0thpU/i/xRa1YHeoZa1fMKGcqeBi1MZIU6UAkgP6wVby1rGyQG1DuPCL0Q01arq
 rJg08VXEXgLm6p9zY08EoQxnjC/o56V1OqM67sTtyguwbaLL9Qr7vTTf4stohxjZQnMz9YIMq
 tTPRat3oHkNn3NpBLjjj9vJqsflrG6S1PTRaQnu+8qQhY8CMorCOHVIlLwMywg7NM5a3vK/d7
 J3uQpllCF7vbZovWBb9HhJnxDCEuZNQJkWhPEAG0jdvo9gyN9qvAd24YcM8jLM+GLFN2x+ec7
 X/U9Q0Syy1trXQa89CVgpb4XoE2oMg1rExIpYhmBV1rb6YHyMHm6h0jkG0EEfVHKQqNfgXw2h
 +/7xMSMdtoSPas=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 22 Feb 2022, Abhradeep Chakraborty wrote:

> Julia Lawall wrote:
>
> > Of there are some cases that are useful to do statically, with only lo=
cal
> > information, then using Coccinelle could be useful to get the problem =
out
> > of the way once and for all.  Coccinelle doesn't support much processi=
ng
> > of strings directly, but you can always write some python code to test=
 the
> > contents of a string and to create a new one.
> >
> > Let me know if you want to try this.  You can also check, eg the demo
> > demos/pythontococci.cocci to see how to create code in a python script=
 and
> > then use it in a normal SmPL rule.
> > ...
> > If the context that you are interested in is in a called function or i=
s in
> > the calling context, then Coccinelle might not be the ideal choice.
> > Coccinelle works on one function at a time, so to do anything
> > interprocedural, you have to do some hacks.
>
> Though in this case, `parse-options.c check` method is better [...]

I fear that this is incorrect.

In general, it is my experience that it is a mistake any time a static
check is replaced by a runtime check.

I was ready to let it slide in this instance, but in this case I now have
proof that the `parse-options.c` check is worse than the originally
suggested `sed` chain.

That concrete proof is in the output of
https://github.com/git/git/actions/runs/1890665968, where the combination
of `ac/usage-string-fixups` and `jh/builtin-fsmonitor-part2` causes many,
many failures, but all of those failures have the same root cause: the
runtime check.

With the original `check-usage-strings.sh`, the user inspecting any
failure would see precisely what the issue is, in the `static-analysis`
job's logs. It would display something like this:

	HEAD:builtin/fsmonitor--daemon.c:1507:          N_("Max seconds to wait f=
or background daemon startup")),

With v4 of the patch series, it does not spell out anything in
`static-analysis`. Instead, it causes 8 separate jobs to fail,
it causes failures not only in `t0012-help.sh` but also in
`t7519-status-fsmonitor.sh` and in `t7527-builtin-fsmonitor.sh`.

The purpose of t7519 and t7527 is _not_ to verify those usage strings,
though.

The worst part? Look at the relevant output of t0012 (see
https://github.com/git/git/runs/5312844492?check_suite_focus=3Dtrue#step:5=
:4902):

	[...]
	++ git -C sub fsmonitor--daemon -h
	++ exit_code=3D128
	++ test 128 =3D 129
	++ echo 'test_expect_code: command exited with 128, we wanted 129 git -C =
sub fsmonitor--daemon -h'
	test_expect_code: command exited with 128, we wanted 129 git -C sub fsmon=
itor--daemon -h
	++ return 1
	error: last command exited with $?=3D1
	not ok 81 - fsmonitor--daemon can handle -h
	[...]

Do you see what usage string caused the failure? You can't. And that's
even by design:

	(
		GIT_CEILING_DIRECTORIES=3D$(pwd) &&
		export GIT_CEILING_DIRECTORIES &&
		test_expect_code 129 git -C sub $builtin -h >output 2>&1
	) &&
	test_i18ngrep usage output

The output is redirected, and since the runtime check added to
`parse-options.c` causes the exit code to be different from the expected
one, the output is never shown.

Arguably the most important job of a regression test is to help software
engineers to diagnose and fix the regression. As quickly and as
conveniently as possible. That means that it is not enough to point out
that there is a regression, the output should be as helpful and concise as
possible to facilitate fixing the problem.

In the above-mentioned case, it was neither as helpful nor as concise as
possible because in the test case that was supposed to identify the
problem, the actual error message was swallowed, and instead of causing
one test failure, it caused a whopping 42 test cases to fail (some of
which even show the error message, but that's not even the purpose of
those test cases).

Since the entire point of this here patch series is to help enforce Git's
rules regarding usage strings, it should expect things like the issue with
`fsmonitor--daemon` _and_ make it as painless to address such an issue.

I am afraid that I have to NAK the `parse-options.c` approach because v1
of this patch series did so much better a job.

Ciao,
Dscho
