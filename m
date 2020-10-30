Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068A0C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 15:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8581B2075E
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 15:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EkJfVcoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgJ3PEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 11:04:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:52967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgJ3PEU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 11:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604070255;
        bh=6BJBH2akQVaPaGVzuhZUrCxdnu/3pbiPVykz+Vyc7k0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EkJfVcoF+TtXVxNquQELEn7SCeM2xEAicykH1RY3L99HWMSqia0sJydaf/YGLAGUG
         PArIJCOZnOVqvBQlzKTB031wsdMhIavOFHvRvYyZlnuzXqt5yxmxtUesP3U5zLaq+z
         8tZqpSwDjtqL4bbzW89eT/PTl3FiO/j+I2HYuWQ8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.214.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1jy4Ga0miZ-00cMy3; Fri, 30
 Oct 2020 16:04:15 +0100
Date:   Fri, 30 Oct 2020 16:04:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/4] t5411: start using the default branch name "main"
In-Reply-To: <xmqq5z6u9kkv.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010301559540.18437@tvgsbejvaqbjf.bet>
References: <pull.760.git.1603839487.gitgitgadget@gmail.com> <f997166db4c29d971a2343f70c9d9a0505a8cc4b.1603839487.git.gitgitgadget@gmail.com> <xmqqa6w69l3j.fsf@gitster.c.googlers.com> <xmqq5z6u9kkv.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WmAhCKjH6pe5y2DTDcxsBtQPTUUrnxUcir/Vk4pfs1qAV11rUwv
 B+3ud2T0AaW2goQBhJULHuJ0IC6SCWo7mZav3t40miw/bcy6rVA3ZjHl/P+lk40eqlCjpjr
 oj68akL6RlECsIp6ZYvJpXqnh5178q4wNk0JdKT3hNeU7oJdDiSUILWNHeRgxk0n0Vjho51
 X9cVumdETBSkImgEidQ6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S03QisglaWw=:Wuk1mKnE030JqGwJgMhTUl
 d1jHeGII/Befce13v8i2KfAajOqZzhqBpU33jyK2QdaTAZM6nHwOopuF3zgObZdNmDv+ZbmcI
 SF6xsSct44WokbELWhq0so8UKGcJ49a0Vhno/1vEr39HChmiFBl70KPSWxhMQ7mONRDjnzEdw
 RQwx5myEp6viPIAgwnLTEDO3BvSNdcfxQYfz8QdN37/LOUs6F4Rk/f66nzMqTUpL9oqSSBgn8
 mOYEmNWmh7zm5N26c/QJ+YGKrFBhdNORgZ3pmZCLH9VFNnNN4xHtIaeW2/Kit5/EbXvOcCXrq
 NCflJNqflSXxfX2Gfhm+VZVtYd+AFLrLhrYc46Kab/pfUJuLW1fJKauYmhcJd879vIh+KiTwO
 qg/0EYQNYhtGt5Y5WNmCbOkJXHA8aO9eQJv+C8CBiLx+HhxQjnDabhAP2lHr++K4+abaNVA8e
 egD2+IsYoB1cYPxR97nGEZHA0Hahnyt6S8p0LEU9HqewWvuk65zX5oSZpPOa+ld5q7UPnd9tL
 3aj8LPXEr0PmFcUqCZlZHPeBOjQ30G8bbADGk4VTHwJPcbdkAWoe/pEvXQniYz9tng7H0s4K4
 t0j76GsjzTNYvvkUVMQXZamMFiQS4vxqN3xFebGiAbZTua2QuOBHdeQMwFMAq4tTq4DeWAPTL
 C89jgssJ+1paCTlB9xCHvzn8jF/CL6Y1ht3MmgcFSl8fcU+2hyVK7jUiTYeCOpaQOnv/irTP9
 Umznna405QYXP8GB6p7Us+GKaohNBZeWZA1UV4lpy4gf7d70ypuhW8/Jcw4CHFnTJXpW129b+
 oQJUAnX6OZLelADYYzG/08zdh1sTxEwRcrsitIorf2FRmog+e1veeICFlfAf8lLFSI76Lt2e4
 gkCg9keAGnDQmow3d2pbH4UgKpVNUVgY8oJeVzwJI=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 28 Oct 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> >> +test_have_prereq PREPARE_FOR_MAIN_BRANCH || {
> >> +	test_skip=3D"In transit for the default branch name 'main'"
> >> +	test_done
> >> +}
> >> +
> >
> > IOW, I do not see the point in _conditionally_ skipping the rest of
> > the test in this step.  I'd however understand it if we always skip
> > the rest in 1/4 and then enable the rest only when testing with
> > 'main' as the default in 4/4, when all the necessary pieces in
> > t/t5411 have been converted.
>
> Another way to protect the test well would be to keep the "unless
> testing with master, skip all" prerequisite check you wrote above,
> but add
>
>     GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmaster
>
> immediately before that.  We can flip it to use 'master' at the
> final step in the series.
>
> That way, we will not be affected by the GIT_TEST_* environment
> variable that is passed to these scripts by the tester.  I think
> I'd prefer to do it that way, instead of unconditionally skipping,
> as the result would be more self explanatory.

Do you mean that this patch, squashed into 1/4:

=2D- snip --
diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index 06bbb02ed22..6da6f597a50 100755
=2D-- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -5,6 +5,9 @@

 test_description=3D'Test proc-receive hook'

+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmaster
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh

 test_have_prereq PREPARE_FOR_MAIN_BRANCH || {

=2D- snap --

so that 4/4 starts with:

=2D- snip --
diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index 6da6f597a50..98b0e812082 100755
=2D-- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -5,16 +5,11 @@

 test_description=3D'Test proc-receive hook'

-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmaster
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

 . ./test-lib.sh

-test_have_prereq PREPARE_FOR_MAIN_BRANCH || {
-	test_skip=3D"In transit for the default branch name 'main'"
-	test_done
-}
-
 . "$TEST_DIRECTORY"/t5411/common-functions.sh

 setup_upstream_and_workbench () {
=2D- snap --

would be much more understandable?

If so, I agree, and I will gladly send off the next iteration with that
change.

If I misunderstood, can I please ask you to give it another try to explain
it to me?

Thanks,
Dscho

