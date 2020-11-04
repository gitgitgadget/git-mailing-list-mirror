Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945A3C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 22:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13CC1206FA
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 22:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ODAJ/2kP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgKDW6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 17:58:35 -0500
Received: from mout.gmx.net ([212.227.17.21]:41485 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgKDW6f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 17:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604530702;
        bh=3rlPqrMPou41DHqnTyLCI+r2FlrCEJNTvj8CHlVeWDM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ODAJ/2kPU+lAVpUTUV6S7M3Pwl8ukIDW+r6J2tX2J2ry4os+5sRiCYgqy/YVUPfNi
         PjVTt4WsdJU2qDAPWW7bGwRz8evf1Xjj8JMux2ntDkaF07eYTjrHH+vC4u36aNp3cw
         r/VTWXN1chckRukQ/fAPBsIgbtIftCQ1j9jdS6Zg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.214.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6sit-1kH5dp1egx-018M1q; Wed, 04
 Nov 2020 23:58:22 +0100
Date:   Wed, 4 Nov 2020 23:58:21 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jiang Xin <worldhello.net@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v19 03/10] receive-pack: add new proc-receive hook
In-Reply-To: <nycvar.QRO.7.76.6.2011042236270.18437@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2011042352040.18437@tvgsbejvaqbjf.bet>
References: <20200824174202.11710-1-worldhello.net@gmail.com> <20200827154551.5966-4-worldhello.net@gmail.com> <nycvar.QRO.7.76.6.2011042236270.18437@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-119371923-1604530704=:18437"
X-Provags-ID: V03:K1:GqjSGuUI5mqwFPrg46D4sRosOCLdQBqIoItVaPveEDh0A5A/6qo
 2mcXxdFXqgoKd3R221Bp6k9TaiNnFZqklSQ44feUPzIuoz64OTHrqDteTp/zPOixEWhGJOu
 T/joaz3c2LYEiJG7dfEc4fjmBBvfXR7cVW4yu0Oyjoykm/VeLv541qUOOcAkxyIIFsD128F
 4R3Pi96wabHI/dRdZQwwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WFD5aUL3WuM=:pMOS0g9POPaHUZYdKb+Dld
 cCN06tg2J6nLiUcAkvnmy5jQwquQDVdtmYcM2lNsHUjw0fHoochPXOiHxwdvM8L2sb0FnSWf6
 ccSHPHrdxLiJM/mgQtx6taWCsI/4wKzy69OvXbWpikgl8v2bPDrAM99RuGI2ndGdklcIrROP3
 qTE3d+F4ZvtupkwJDUSp6+Y1rT2XEaskKAZkzSd/Q4wqcie+/STbChpBFiXZnH2TAqY0xtv1b
 MtGeBwNC22rkNiZcGHE0Ts4EPsGXKGwLtEw+a3bSyoigFTimCPS3K6gOk2lsPY/3kqTnqYDBI
 E6bOfI/xath6qiypg9MurYbyG3+o2hxbZN+SWnA0g/25jkwNVnmJw+LfkIdEpO+EAasbL9K8i
 IPB0Cltn/Urw8MXGm3dsgrz9PDjznRRPJ2s4y+j2dUYarQ7VsqvpxGZ11mcinS7i348fh/Z3i
 MzRo5TiJUYMqJ84Rc487S8SfWQNdyek1ToZKnGRMLuNPUuER5An3Lo04Y6HGM2vVpBuxEusYG
 IsLBVR4aOB/k6GFPJ34HOzON5e7uyRZWzQH+rNtQJHMgS7W0YlmPoffyTmjXVRWfuwckbfcoY
 T94PSZBvjuz7o8VEmrWYPVX/p6rK49L+85pA0MedJoUOLTwQ9RpGyJA/MX4YBBH7bbGrBPBUA
 B32uQZtU36CJ67N0+Tl6Vy48QF5ULKKQHbB4j9p9GVZzAzTwWSXnl+3ct9JjBIratwvQeFizs
 z5qxD9ZnIf58vFKTx7jXbHmKnmZCUNlON0CXbwW8YcMc4InLEL5MYld3SddJRJFZULhRVBM3c
 pzvxGidIdknzQ7TUD9vqhCZ7WTDrR6g1hj/bDVUKBfvMoyRIiAhu0j4TjRsBDYJklucvBLnqI
 vvyewXk7ClhmfI+qBfxMAenyiKAY4IksW8cAFeFXk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-119371923-1604530704=:18437
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Me again,

On Wed, 4 Nov 2020, Johannes Schindelin wrote:

> On Thu, 27 Aug 2020, Jiang Xin wrote:
>
> > +test_expect_success "setup proc-receive hook (hook --die-readline, $P=
ROTOCOL)" '
> > +	write_script "$upstream/hooks/proc-receive" <<-EOF
> > +	printf >&2 "# proc-receive hook\n"
> > +	test-tool proc-receive -v --die-readline
> > +	EOF
> > +'
> > +
> > +# Refs of upstream : master(A)
> > +# Refs of workbench: master(A)  tags/v123
> > +# git push         :                       refs/for/master/topic(A)
> > +test_expect_success "proc-receive: bad protocol (hook --die-readline,=
 $PROTOCOL)" '
> > +	test_must_fail git -C workbench push origin \
> > +		HEAD:refs/for/master/topic \
> > +		>out 2>&1 &&
> > +	make_user_friendly_and_stable_output <out >actual &&
> > +
> > +	grep "remote: fatal: protocol error: expected \"old new ref\", got \=
"<ZERO-OID> <COMMIT-A> refs/for/master/topic\"" actual &&
> > +
> > +	git -C "$upstream" show-ref >out &&
> > +	make_user_friendly_and_stable_output <out >actual &&
> > +	cat >expect <<-EOF &&
> > +	<COMMIT-A> refs/heads/master
> > +	EOF
> > +	test_cmp expect actual
> > +'
>
> While investigating a flaky hang in t5411 in the osx-clang job of our
> CI/PR builds, I ran into this issue (with --stress):
>
> -- snip --
> [...]
> +++ test_must_fail git -C workbench push origin HEAD:refs/for/main/topic
> +++ case "$1" in
> +++ _test_ok=3D
> +++ test_must_fail_acceptable git -C workbench push origin HEAD:refs/for=
/main/topic
> +++ test git =3D env
> +++ case "$1" in
> +++ return 0
> +++ git -C workbench push origin HEAD:refs/for/main/topic
> +++ exit_code=3D128
> +++ test 128 -eq 0
> +++ test_match_signal 13 128
> +++ test 128 =3D 141
> +++ test 128 =3D 269
> +++ return 1
> +++ test 128 -gt 129
> +++ test 128 -eq 127
> +++ test 128 -eq 126
> +++ return 0
> +++ make_user_friendly_and_stable_output
> ++++ echo 4844d8acf2fc62b151a29cfb3b916b6778476b9e
> ++++ cut -c1-7
> ++++ echo c208c3bb8a1aeea6d4e40027a17251ccd59a2b1b
> ++++ cut -c1-7
> +++ sed -e 's/  *$//' -e 's/   */ /g' -e 's/'\''/"/g' -e 's/    /    /g'=
 -e 's/4844d8acf2fc62b151a29cfb3b916b6778476b9e/<COMMIT-A>/g' -e 's/c208c3=
bb8a1aeea6d4e40027a17251ccd59a2b1b/<COMMIT-B>/g' -e 's/f7cc02ec1b3393b9a96=
38a0e02a7039c234cffa4/<TAG-v123>/g' -e 's/00000000000000000000000000000000=
00000000/<ZERO-OID>/g' -e 's/4844d8a[0-9a-f]*/<OID-A>/g' -e 's/c208c3b[0-9=
a-f]*/<OID-B>/g' -e 's#To \.\./upstream.git#To <URL/of/upstream.git>#' -e =
'/^error: / d'
> +++ grep 'remote: fatal: protocol error: expected "old new ref", got "<Z=
ERO-OID> <COMMIT-A> refs/for/main/topic"' actual
> error: last command exited with $?=3D1
> not ok 34 - proc-receive: bad protocol (hook --die-readline, builtin pro=
tocol)
> #
> #               test_must_fail git -C workbench push origin \
> #                       HEAD:refs/for/main/topic \
> #                       >out 2>&1 &&
> #               make_user_friendly_and_stable_output <out >actual &&
> #
> #               grep "remote: fatal: protocol error: expected \"old new
> #               ref\", got \"<ZERO-OID> <COMMIT-A> refs/for/main/topic\"=
"
> #               actual &&
> #
> #               git -C "$upstream" show-ref >out &&
> #               make_user_friendly_and_stable_output <out >actual &&
> #               cat >expect <<-EOF &&
> #               <COMMIT-A> refs/heads/main
> #               EOF
> #               test_cmp expect actual
> #
> -- snap --
>
> The output of `actual` reads like this:
>
> -- snip --
> remote: # pre-receive hook
> remote: pre-receive< <ZERO-OID> <COMMIT-A> refs/for/main/topic
> remote: # proc-receive hook
> fatal: unable to write flush packet: Broken pipe
> send-pack: unexpected disconnect while reading sideband packet
> fatal: the remote end hung up unexpectedly
> -- snap --
>
> Applying G=C3=A1bor's patch as obtained from
> https://lore.kernel.org/git/20190830121005.GI8571@szeder.dev/ seemed to
> help this issue at first, but then turned out not to prevent the same
> issue from happening again.
>
> Any ideas?

More puzzles. I was finally able to reproduce the hang in a `--stress`
run. It basically happens in t5411.186, which is stalled at this:

=2D- snip --
[...]
expecting success of 5411.186 'proc-receive: bad protocol (hook --die-read=
line, HTTP protocol)':
        test_must_fail git -C workbench push origin \
                HEAD:refs/for/main/topic \
                >out 2>&1 &&
        make_user_friendly_and_stable_output <out >actual &&

        grep "remote: fatal: protocol error: expected \"old new ref\", got=
 \"<ZERO-OID> <COMMIT-A> refs/for/main/topic\"" actual &&

        git -C "$upstream" show-ref >out &&
        make_user_friendly_and_stable_output <out >actual &&
        cat >expect <<-EOF &&
        <COMMIT-A> refs/heads/main
        EOF
        test_cmp expect actual

+++ test_must_fail git -C workbench push origin HEAD:refs/for/main/topic
+++ case "$1" in
+++ _test_ok=3D
+++ test_must_fail_acceptable git -C workbench push origin HEAD:refs/for/m=
ain/topic
+++ test git =3D env
+++ case "$1" in
+++ return 0
+++ git -C workbench push origin HEAD:refs/for/main/topic
=2D- snap --

That `push` never goes anywhere. And I found something of a clue at
`trash directory.t5411-proc-receive-hook.stress-*/httpd/error.log`:

=2D- snip --
[...]
[Wed Nov 04 22:28:20.838388 2020] [cgi:error] [pid 60577] [client 127.0.0.=
1:52794] AH01215: fatal: unable to write flush packet: Broken pipe: /Users=
/runner/work/git/git/git-http-backend
=2D- snap --

This is once again running _with_ G=C3=A1bor's patch mentioned in the quot=
ed
part above.

Could you please look into this?

Ciao,
Johannes

--8323328-119371923-1604530704=:18437--
