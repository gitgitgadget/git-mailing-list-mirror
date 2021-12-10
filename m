Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22B7C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 22:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243195AbhLJW6z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 17:58:55 -0500
Received: from mout.gmx.net ([212.227.15.15]:48489 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233008AbhLJW6y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 17:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639176912;
        bh=KnrgK5lvvD1bRzm/+/KCpLi/3Q48cDTwacE3/bW6pmY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iuLcS8ynBKLq+d5O4nknA37Ds0iTyTywGw+zXpNB9PhO1W0PZZYl39aI6EULOazNA
         3aZkybkaQQwVDnztXpsMln+iL5UQATTo/UQqhwWhcooH/gJY3s4TPNtZJtS/dEQD4o
         RQjM5Ihk0TViS3MpcCRu2kDD8ZnBhgLOwEIdMO9A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.164.160] ([213.196.212.194]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0G1d-1mZsE32Uxb-00xIFI; Fri, 10
 Dec 2021 23:55:12 +0100
Date:   Fri, 10 Dec 2021 23:55:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Slavica_=C4=90uki=C4=87?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH] fixup! add -i: default to the built-in implementation
In-Reply-To: <xmqqwnketo0a.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2112102352350.90@tvgsbejvaqbjf.bet>
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com> <84824918ae4564a9194a1a55124ee8694f210437.1638281655.git.gitgitgadget@gmail.com> <xmqqwnketo0a.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BOK3wbzFJcOhWtITLqObO1WH39KDmjwGSoplfATv9KWA6TUTcKO
 wvlTrWBnfVIfr4+eNVSRmGHcmFRS5EXzra7lZTNrgQn1eAuLDVPfCyGSWryC8n4mIoHUcC4
 bmcR4JBkVrAaYkqRzEYVbl0YmzU+R+Tjs/3da3C65TPcs/O7hfStfCo4WiLl+19+PHzh1Lg
 eQ4Y/0RbxXoCjv7u23c8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M0dM+PCKzVE=:noDuLDwj7v2mhrqz+xeuTW
 SbMzGlDDaG4TwdbuTJGbDVI5DigZ2VHInbuF6sntgXHUI2fn3s48O1NLKuY5wjWA6EN5VelEJ
 O1+JHm0d8+ovIPRDQhwnp9HuzBtLEqmmWwGyk2QrP5O5JfhAExWiSNww1GpXMRjdnnlabIfV6
 Ii1C1yUOPwHSTVT58OcQho2rx9Bm4Xti1wzhKys2iZblly8dF1QWKgUXuCNm8XDq5ktC7LFY0
 lhOGNbpDeWR7Efz/B9Pm9x1kITNGjHAcHsmL0Ql0gj1wBPagdVnLiyfQmV7zTseFHvJ1/ONye
 hmg9N0WXkseRiHAXYRWuXucwqukWUeyajMlm6RFunij8sUIbuDcDR38yy/CICsAo5ACzBnogo
 DX8FFOFGAm4jjNp1tQpzL+Y1DaZ9QbBZ3yn5ytP1nRscwXDtgfF66/nIx4Ow6lp3TONqBqz/4
 wi5lOmGxafQ2HYojC51BY+XAB3eHUR6AUfaYjBXAv94905yGswpoS46UwE3N5Vqbjt3/98vlJ
 tfA6y83G/pZ30UbtCtI2VIgkJoiTt/VmZZ3LfslE/GwsNlfeuJdMI/pnWh+V4VVFqh5RDqqPk
 GLviMn4mghwaw8RMKXqRzzjj2ZuvI8l3UQulpM2UNy73JXDbDBrRHz8u5ri/WTC9nZCnsoRFi
 7cTC+qnMFhjhvdKlL3aG5c/3op+tCofgNTYDrEsmqjNqVKFUhqn9UQZGj7qvl8oMIEXHWfq+v
 3u8MvpOV0rEARAPxW+j1nIQnWog14ZFORmahlBmp7CBq/vGS9kiNj+lpKdtqMM1p3kUhnZ2kG
 Sd1IehQmi0ZttK5A7TokvhKgeUwW8x7dcx64wRSul66FAUR0bHBigr1hH4OoKHFhmC5WBGtOy
 1wCJ9BCk+WBwSbuYSXibiQdcglmjsKw+QsLZ1XscuSOTaUEGlRBKOzBgxf9HYXDiya7dYAhkp
 ZamOQk9cgEb9g5HZyGMBshzz6Wms2tmIgON2yPWJnvwNZ0vKFmiHAMUewIPmf0Dlx8L3SnuZ2
 /SpS6SCAW0gi10wuSmjUcy0rai7znulCB9+yEimWaoYqNOVdfNRDpL0oWcLO7h6/QdqOJLQN7
 g5yAMRwQaI5UfQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 8 Dec 2021, Junio C Hamano wrote:

> With the reimplementated "git add -i", two test pieces that used to
> expect failure now succeed.  Mark them as such.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Yes, I know this is on hold until some issues in the "add -i"
>    reimplementation on MacOS are resolved, but as I am getting tired
>    of seeing "TODO PASSED" when I rebuild and test 'seen', I'll
>    queue this band-aid at the tip of this topic.

As long as we ship the Perl version as an escape hatch, and as long as
that version does not pass those two test cases, your patch is premature.

I would expect the `linux-gcc` job (or whatever it is called for the next
few hours) to fail with this fixup!, as a consequence of running t3701
with the scripted version of `add -i`.

Ciao,
Dscho

>
>  t/t3701-add-interactive.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 207714655f..1effc3f419 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -500,7 +500,7 @@ test_expect_success 'split hunk "add -p (edit)"' '
>  	! grep "^+15" actual
>  '
>
> -test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
> +test_expect_success 'split hunk "add -p (no, yes, edit)"' '
>  	test_write_lines 5 10 20 21 30 31 40 50 60 >test &&
>  	git reset &&
>  	# test sequence is s(plit), n(o), y(es), e(dit)
> @@ -524,7 +524,7 @@ test_expect_success 'split hunk with incomplete line=
 at end' '
>  	test_must_fail git grep --cached before
>  '
>
> -test_expect_failure 'edit, adding lines to the first hunk' '
> +test_expect_success 'edit, adding lines to the first hunk' '
>  	test_write_lines 10 11 20 30 40 50 51 60 >test &&
>  	git reset &&
>  	tr _ " " >patch <<-EOF &&
> --
> 2.34.1-373-gb739cc97c5
>
>
