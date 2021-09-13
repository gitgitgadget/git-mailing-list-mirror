Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2155C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E286108B
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 11:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbhIMLZ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 07:25:56 -0400
Received: from mout.gmx.net ([212.227.17.21]:60931 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238684AbhIMLZz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 07:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631532272;
        bh=VqPBhWMUJDIDjGn5j/xtFlRjqnbn5AOHlyxoSLhAgiw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=a24SMMWVPMsY4m3zDNWuClFO+wflPZkB1dC5dDNpvQfvc93RtImz9ssAXSi3Zn6+1
         LRhU0gD1onDeqGWfphDffdMZpTgfgdOAFPmw84hy3cBYUuKp8ZcrHb3O37/kF+Gj04
         qAYg8Agxj1ktyr19N1z8MaZiDpVlnYWg9WQt1ngY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.116.95] ([89.1.214.165]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9UK-1nFdjw2BZk-00s50h; Mon, 13
 Sep 2021 13:24:32 +0200
Date:   Mon, 13 Sep 2021 13:24:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Subject: merge-ort and --rebase-merges, was Re: [PATCH v2 0/7] Drop support
 for git rebase --preserve-merges
In-Reply-To: <CABPp-BHWVO5VRhr1-Ou60F1wjKzJZ1e_dC01Mmzs+qB9kGayww@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109131319020.55@tvgsbejvaqbjf.bet>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com> <pull.195.v2.git.1630497435.gitgitgadget@gmail.com> <xmqqk0k0ndbq.fsf@gitster.g> <nycvar.QRO.7.76.6.2109021616300.55@tvgsbejvaqbjf.bet> <4e998676-4975-8ac2-35a0-34416938b62e@kdbg.org>
 <nycvar.QRO.7.76.6.2109071930080.55@tvgsbejvaqbjf.bet> <CABPp-BFZfa7cchRTycdyMbnwb_f=vHxQYLA5QswuM0ExfxeMAQ@mail.gmail.com> <nycvar.QRO.7.76.6.2109101325410.59@tvgsbejvaqbjf.bet> <CABPp-BHWVO5VRhr1-Ou60F1wjKzJZ1e_dC01Mmzs+qB9kGayww@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EQ240b+DLbniyQFmUX9uMnrnG4kkjlaVV9SK92gssoRs5xQiPwF
 ehlzqLew8/nZjOc4PKSvVt0ClE0Fc7scsVazvCuLEd9ZqVLsmeQ9EPzHOmgLg6i2sbv9axa
 QjlK9nfkcVnGIn1e8Uf01Rx+FmyB6hy2VvVlsLa781fd2X/CV+l1Rz7RJ0l35nd4eHiyWeo
 nXJUiM+kTvPFIvczXxWHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MU+KbJwVOQA=:6FhavG0FozHBZVqhPaysve
 SW1N/AllYi2HhX6l7yQvUqxtr+o5kR7l3UzC0eS5IayTMZUG+zOvkT7/klwnNnfxcNzuyQf4S
 7E89FtaXqtFxl2iCXYGvQCE/B8Zr0+hZigo3OwBohe8k9OB+DQcGeNzMaEq5IDmtAmSRL6EU0
 4nPd0AizoRrqbx1WDaKceIif5W75c6Hw6tGI3YgHNIqQii1E307Wc7Cwc3cF/s/LrLo2Ulm0r
 B0eEEM+YJZoRLOX5JRGKZX767QaKo43n6QIttn3DiX1VY9XVbBZOojwEjVLS8ZY2jNb7wyzAs
 J7seDx21hs+w8y1fLujVqM7J8ZFAuJrU5vOPQOutyhWbEmQ/f0J0RNPWy/vcpyCxGDBC0xReP
 g87QWcGPzohQNRbjy9gy88wuJzImoaO0r7DPLzBX+G521zHEfL4nunflgtLAE8BUgJMC5liK0
 lhGYOCA7BR9uoXF4Rk7wOs7xP17JBaCVjzWSweH1KYRj6weikKk3nNYIhIPDFmjXK1ZlhB9Mv
 Cw2oqHw28lOebgsLh0IVnj/zt707mXKsTSPI4P6uHA+dLCWSkCBttzMCqcIIl0wbOWvfZIQNw
 2MNWn6TVpyLeW9DIlndQbogr686RMtmdF6ffAySkU8alxaaOqV52/GHO7aU49+IqnwR0KUpci
 70q/6CfhmPfSVIie+R195Z6u5e0C7nMf8zJJei91Rd6kTD30qpgoIRRZBMGK9Q6I8RAVN/2Xi
 zp30OoZl3XneAuXUz6EGsZB/2YvRxQZ232SVrH7ipbVhlvMek32NT71F7Ev1dpEHTaYdyMaNL
 vZquf/CYowl+ilsA7wK9Q+dNxIzvIfhC+LzISiLSWc8K3eDtm0sO3NX1RkXZwnAvkvnYLPW4y
 Lp+WKg94AU2c9fdlWT1LlyF94cTXejNN4rfdEvJH4LfT8W0ok3yYJDRQXAQ7Ci4pLMP4WJnFX
 axzjtVJcdIG3QD38TvMmS45+9tL8JhYW7IYn6/Msh/9g5TDogXZ+tHiHPdeythyknOVxXXqeG
 hMlMXY6X8dq1LxvbMX7kpdptgp8hWzyBVDGfI/omjavl0Ar0HH94aUp62ipKPTDmtpx5pr2vu
 x98/45oJzLPRUM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 10 Sep 2021, Elijah Newren wrote:

> On Fri, Sep 10, 2021 at 5:08 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 7 Sep 2021, Elijah Newren wrote:
> >
> > > On Tue, Sep 7, 2021 at 11:51 AM Johannes Schindelin
> > > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > [... talk about re-resolving merge conflicts when recreating merges
> > >  in a `git rebase --rebase-merges` run ...]
> ...
> >
> > While I agree that `merge-ort` makes a lot of things much better, I th=
ink
> > in this context we need to keep in mind that those nested merge confli=
cts
> > can really hurt.
>
> Yes, and I'm not sure you fully appreciate how much either.

*grin*

> [... a lot of insight that I totally agree with ...]
>
> I believe the commit graph you were describing was this:
>
> * rebase-of-original-merge
> |\
> | * rebase-of-local-add-caller-of-core
> * | rebase-of-local-rename-to-hi
> |/
> * upstream
> |
> |
> |
> | * original-merge
> | |\
> | | * local-add-caller-of-core
> | |/
> |/|
> | * local-rename-to-hi
> |/
> * initial-version
>
>
> Further, the versions of main.c in each of those are as follows:
>
> =3D=3D> initial-version:
> int core(void) {
>     printf("Hello, world!\n");
> }
>
>
> =3D=3D> local-rename-to-hi:
> int hi(void) {
>     printf("Hello, world!\n");
> }
>
>
> =3D=3D> local-add-caller-of-core:
> int core(void) {
>     printf("Hello, world!\n");
> }
> /* caller */
> void caller(void) {
>     core();
> }
>
>
> =3D=3D> what an automatic merge of the two local-* branches would give:
> int hi(void) {
>     printf("Hello, world!\n");
> }
> /* caller */
> void caller(void) {
>     core();
> }
>
>
> =3D=3D> original-merge (amended from above by s/core/hi/ in caller()):
> int hi(void) {
>     printf("Hello, world!\n");
> }
> /* caller */
> void caller(void) {
>     hi();
> }
>
>
> =3D=3D> upstream:
> int greeting(void) {
>     printf("Hello, world!\n");
> }
> /* main event loop */
> void event_loop(void) {
>     /* TODO: place holder for now */
> }
>
>
> =3D=3D> rebase-of-local-rename-to-hi (kept 'hi' over 'greeting'):
> int hi(void) {
>     printf("Hello, world!\n");
> }
> /* main event loop */
> void event_loop(void) {
>     /* TODO: place holder for now */
> }
>
>
> =3D=3D> rebase-of-local-add-caller-of-core (kept both new functions,
> updated caller):
> int greeting(void) {
>     printf("Hello, world!\n");
> }
> /* main event loop */
> void event_loop(void) {
>     /* TODO: place holder for now */
> }
> /* caller */
> void caller(void) {
>     greeting();
> }

That all matches my recollection of what I wanted to drive at.

> If I've understood that all correctly, then my idea will give you the
> following conflict to resolve:
>
> =3D=3D> rebase-of-original-merge, before conflict resolution:
> int hi(void) {
>     printf("Hello, world!\n");
> }
> /* main event loop */
> void event_loop(void) {
>     /* TODO: place holder for now */
> }
> /* caller */
> void caller(void) {
> <<<<<<< HEAD
>     greeting();
> ||||||| auto-remerge of original-merge
>     core();
> =3D=3D=3D=3D=3D=3D=3D
>     hi();
> >>>>>>> original-merge
> }

That looks very intriguing! I would _love_ to play with this a bit, and I
think you provided enough guidance to get going. I am currently preparing
to go mostly offline for the second half of September, read: I won't be
able to play with this before October. But I am definitely interested,
this sounds very exciting.

Ciao,
Dscho
