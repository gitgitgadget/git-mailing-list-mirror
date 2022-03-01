Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078D6C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 20:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiCAUZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238344AbiCAUZd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 15:25:33 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DABF85BCE
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 12:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646166258;
        bh=pkc9nnK8zus49s/yApNtfeKuPrRjBKmzrRHsuLjxLnc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Q5OvHg3DzJUarFRGcxgV8L+aykmlgP1Af6CBXI0K5uENdnxl16TIEePDYJteov1pb
         vu/U16EfVgCWwKbjJ2aoghXvNbQdpqabk6Tqef6jIX1UwQXy4R9joKpGCi3w7dSeBD
         u5d3a0phgTiQu0F2VbyDaFkFk0MSKwwF2tJ8osUY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.214.47]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzBp-1nh5X630cb-00HxQt; Tue, 01
 Mar 2022 21:24:17 +0100
Date:   Tue, 1 Mar 2022 21:24:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 09/10] fetch: fetch unpopulated, changed submodules
In-Reply-To: <xmqqr17p5ujf.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2203012039080.11118@tvgsbejvaqbjf.bet>
References: <20220215172318.73533-1-chooglen@google.com> <20220224100842.95827-1-chooglen@google.com> <20220224100842.95827-10-chooglen@google.com> <xmqqr17p5ujf.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0Utv/0cFeJ8p7pPs5H7cogFlwn/tYlPOjbtVLgiKnafNVNLjO0u
 m7uYYpXp4u6k1bnpo5ozWdYdtlkhxGqcL+DcIACQk5ILD+RifdyD5eJxWlseWR52j+qudBI
 JaWqiVIH9OrctSN3PPlDqOSYIXAve0x/jnKliEoXrwRUmv8gwxGG+7lfHuK4MVeIP2gpXxT
 CgDF8x6anu1CWY6K1KNoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+DjQvILWydI=:Woi0jnP3L4vzSGg+pjKYBF
 u1WO0Py8gzcmmLFyFZdAqWegjs/kb7FA2uR28zvAs5lcb/k3Vn5QczKc4ONGuF6y2pJ4kLLJ0
 ecoHD73c19QMYA2XTw/qelilFwchK0rZog/ab3V3Q6lmInCvTKc2ptHFidEminf5nkz8Zjeh7
 KHKaXWvMrF+w9oJ0z++PMCzD3GuDfND1jWYDzEPpNKv780FD70BqFrPosOmuK1EmW1qPCKqRp
 w8H5gp8sPGvDBOVL+RJlMvE65tB0iJU0ZURprUaWAps+9WwxIzxErPqRiwcDBj4Ckmnhqecvf
 hJSw7ErKIsuYC6omZt4+21uC1cQpmKfEoVibkd4G8qO1CvGCVAUk+Cm5oa9Jconuc0YQkfe4H
 FyClYf+vlvjbGGWQkVUKIkNDzqaLxzjYKccwVBUyiwIzFzumkub5RHINK9RE06hfcfUVRjaBJ
 nbx+8H/L9PS+EIG/ep9cA0uB6KlDe1OCXafcCUKtms/EYTP3Y6Gr7p5OrHp/DI7gmgIwSRqP2
 QGpvxl8h5fiR1cBVXZ7N8dxOo+1i9vVpIdJR9yPTZ6pUKQ6SqxLM05tZmyCffb0LO2K64xD4o
 5u/GV43x4vucSqvLchb3PkJJUOv86Em6UFutntRBWlLgQnCBk3gqi/ZIey+VdhRAOcvx7xSgo
 7BwjnyoyuetZOTrYwYtNTqK82fot8VY7/CClPAFWNFOjVjLfeRX+C2nmAVNHog1OarPR7C8BX
 og5WH/GJf6EWOUrpgz9krTfo6Z7fWfuZF9HYO7e0L3iTtX4Tocnk7cRKjDIVpi4t3ksv9HYt8
 H8kLncwhEr0jxR5536MLMTlfp+B+HGhP7bSFJ/nNrHnbqks+fBG6j+NcDqPYEm/g/KwSZrSMR
 KXs0xcWVS1eZx33UWqmMm8fdogZ/XO2AcM7j+wy+ocRuf0lulKzrGDRen+/ScKLJRneo1hdHh
 LwwhTJeTNBZM0I7EP2OmUNWSyR5+JDkWsRSGQfcUMY6hzxG9aoDjeATo3dg3abO23lQFcLEQi
 2E7+/jaELOclKaZRnPwBc3XUut/ZhbtOIymyudLjXMjcnt8BqjS6KrtpjmsE7GU60Bc5LMFic
 JWyMVJMaFe0ijo=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 26 Feb 2022, Junio C Hamano wrote:

> A few tests added by this patch have been failing on one specific
> job (linux-gcc ubuntu-latest) at GitHub CI.
>
> https://github.com/git/git/runs/5341052811?check_suite_focus=3Dtrue#step=
:5:3968
> https://github.com/git/git/runs/5343133021?check_suite_focus=3Dtrue#step=
:4:5520
>
>     Side note: you may need to be logged in to GitHub to view them.
>     These two use different versions of CI to show the test traces;
>     in the latter you may have to click on right-facing rectangle on
>     the line with label "5520" to see the breakage.
>
> I think there is some baked-in assumption in the failing test what
> the name of the initial branch by default is, which may be the reason
> why this particular job fails while others don't.
>
> Can you take a look at it?

The log says this:

=2D- snip --
[...]
  + git commit -m super-b2
  [main 00b85ba] super-b2
   Author: A U Thor <author@example.com>
   1 file changed, 1 insertion(+), 1 deletion(-)
  + cd same-name-downstream
  + git checkout same-name-2/master
  error: pathspec 'same-name-2/master' did not match any file(s) known to =
git
  error: last command exited with $?=3D1
  + git -C same-name-downstream checkout master
  error: pathspec 'master' did not match any file(s) known to git
  + eval_ret=3D1
  + :
  not ok 49 - fetch --recurse-submodules updates name-conflicted, populate=
d submodule

  #
  #		test_when_finished "git -C same-name-downstream checkout master" &&
  #		(
  #			cd same-name-1 &&
  #			test_commit -C submodule --no-tag b1 &&
  #			git add submodule &&
  #			git commit -m "super-b1"
  #		) &&
  #		(
  #			cd same-name-2 &&
  #			test_commit -C submodule --no-tag b2 &&
  #			git add submodule &&
  #			git commit -m "super-b2"
  #		) &&
  #		(
  #			cd same-name-downstream &&
  #			# even though the .gitmodules is correct, we
  #			cannot
  #			# fetch from same-name-2
  #			git checkout same-name-2/master &&
  #			git fetch --recurse-submodules same-name-1 &&
  #			test_must_fail git fetch --recurse-submodules
  #			same-name-2
  #		) &&
  #		super_head1=3D$(git -C same-name-1 rev-parse HEAD) &&
  #		git -C same-name-downstream cat-file -e $super_head1 &&
  #
  #		super_head2=3D$(git -C same-name-2 rev-parse HEAD) &&
  #		git -C same-name-downstream cat-file -e $super_head2 &&
  #
  #		sub_head1=3D$(git -C same-name-1/submodule rev-parse HEAD)
  #		&&
  #		git -C same-name-downstream/submodule cat-file -e
  #		$sub_head1 &&
  #
  #		sub_head2=3D$(git -C same-name-2/submodule rev-parse HEAD)
  #		&&
  #		test_must_fail git -C same-name-downstream/submodule
  #		cat-file -e $sub_head2
  #
=2D- snap --

So yes, there is a lot of `master`ing going on.

I _think_ the remedy will be to use the `-b <branch-name>` option of `git
init` in
https://github.com/git/git/blob/82dd0cbc7fcf2985a3dcfbd99caa9f80626b00df/t=
/t5526-fetch-submodules.sh#L1015
in
https://github.com/git/git/blob/82dd0cbc7fcf2985a3dcfbd99caa9f80626b00df/t=
/t5526-fetch-submodules.sh#L1024
and in
https://github.com/git/git/blob/82dd0cbc7fcf2985a3dcfbd99caa9f80626b00df/t=
/t5526-fetch-submodules.sh#L1033
e.g.

	git -C submodule init -b main

At least that's how _I_ tried to address similar issues in the test suite
in the past.

Ciao,
Dscho
