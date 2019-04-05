Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB67720248
	for <e@80x24.org>; Fri,  5 Apr 2019 20:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfDEUUH (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 16:20:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:56735 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfDEUUH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 16:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554495599;
        bh=3zOODVZyaopRPXNWMH89bEyGf0rC5GhJMiEkjLWzTUc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Y1+V3y5aRXsJ6gaHrRKtEtaI7WazS5j9b6c5TC6sUghTwNOJwXxsRzGHCu9hcnj8o
         epDsbZu6hQ2LOOtJfP1I0vYX+9/g43Fpe2rBkCq8zC676wXlvFpzTITBuAtSx85h36
         jt5r8tsKl96z4cRNubnavXhmlU9pRXgpMqE6ujf8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjZn2-1gfMQB1XOy-00befj; Fri, 05
 Apr 2019 22:19:59 +0200
Date:   Fri, 5 Apr 2019 22:19:59 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 1/4] t3431: add rebase --fork-point tests
In-Reply-To: <nycvar.QRO.7.76.6.1904052047240.41@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1904052218200.41@tvgsbejvaqbjf.bet>
References: <20190328221745.GA3941@dev-l> <cover.1554151449.git.liu.denton@gmail.com> <234ac9f024bf4e6b4944fd8f3912cf6367cf828b.1554151449.git.liu.denton@gmail.com> <nycvar.QRO.7.76.6.1904051653360.41@tvgsbejvaqbjf.bet> <20190405172536.GA11212@dev-l>
 <34af9bf5-4031-63ed-c34b-9f2c7ff76c51@kdbg.org> <nycvar.QRO.7.76.6.1904052047240.41@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ph8zbu2ropQPJsZpbJZpY6UqOlcaoyH0gmimZ3owloI+7X4X+sV
 0yGOl7nhX6eJS0Wfgk7Kx4rv1PSpI//ge5kcIodaFR671Hg2I7vgfd3Uuh1bz6501gu1OUS
 rGTSZKfOmyi9InhtJM7PLV6YpseAGWRKzAV+YAF66QHAXe5k/rwa/DHuMbfL7PsHoNfk5qM
 izHUSqpLWJ9y/mkK/s67g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7Crp/b4r3H8=:lV7WUwbj+uc/oh6TpbawN7
 T5gc6uzY3NZ7p9C7Dqqj6RjM/RiiIV3aVrRhhzjARbmp7GLkNI/tia7RfhDFOk08Axwmf0APx
 KzBOcNN2HqM50kWs/T7uDUAFHDZTQTaGwlGV6AXwSnTGfsR02QlMb4VrJqLP2JXVyz6MhOvyQ
 Pq5gaG5CpMXLDQgaqn9pgeB4XWqrUjCxXScgIOLVLtlS0DElECkyhrzqu6ZofTeKRgC335KDS
 by1kfx/bDJYyCGKFFOgme/5ofyqbUStaTZ6+kOHSu6QW+VTROxsYDLz6YCZiGLJmAZ4aQiRWi
 aFPOpvOf3q8fiO3saX02NA4FjPMIbFeyPRB0M6+2ZnnkDSerNVTGx315e22qpUi1jvb2e09TS
 EMdh8/HfpCeHpN4YAXGzZBp6+O7DiWfG08th9MFwu2mrHKKr7ECGne7CE58FVgiUotUhBrXVE
 N/JljLLog+1Yuym95Y7Bn/OtqkjGTb9heEGMBGWpE2JV0dpzI41ZyrtOOxD1Hc5URJROCJqKl
 +vkuGtx3vAQg8feQ0ZlkdXBLA4Oly1VJb5ZLOAR4JrbUIRdgua7kMnb4cP4zL6wtviKaeWsRC
 lw2MusfiCWbrQM24svQ1ZTj9ZfdPeZYItU6w3mzZ9a+DdXrf7RHg5UztH8+iH27rj/FE2+Wkc
 qXOLykZoI2/mW2rLT59e3kh4C29dW9EFlsgVNWHBgUk1U9jWN9i4KsLB4ywiRiUaeLQBDuS1j
 CiqDM0PYrO17hbVBa2cVvkwKFWgqfsEtOE2Oh0NzVCvWqmZOueP27JkRBLwpYkVCnWOywOiAc
 ReaYLkKUEtI7FwTTsPvl/TOkfN501cg9WIb632iBN9VrNh6MRyAxcjqgmjqEz4rHn9d/Xtq6C
 AFILEBPk9TVH2SxPr7cE32ziQq4Ma1S3xLmiEucXaLwE8DvPFUcUtCKVhAAv6RzVqQGkqMDS9
 bPoZOqn6lOQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 5 Apr 2019, Johannes Schindelin wrote:

> On Fri, 5 Apr 2019, Johannes Sixt wrote:
>
> > Am 05.04.19 um 19:25 schrieb Denton Liu:
> > > On Fri, Apr 05, 2019 at 04:55:37PM +0200, Johannes Schindelin wrote:
> > >> On Mon, 1 Apr 2019, Denton Liu wrote:
> > >>> +test_rebase() {
> > >>> +	expected=3D"$1" &&
> > >>> +	shift &&
> > >>> +	test_expect_success "git rebase $@" "
> > >>> +		git checkout master &&
> > >>> +		git reset --hard E &&
> > >>> +		git checkout side &&
> > >>> +		git reset --hard G &&
> > >>> +		git rebase $@ &&
>
> > Using $@ in these expansions is wrong. You do not want to forward an
> > argument list, but you want to construct a command line. $* is correct
> > here. Then you can remove the single-quotes at the invocation, like so=
:
> >
> > 	test_rebase_same_head success
> > 	test_rebase_same_head success --onto B B
> >
> > Function test_rebase() could be done in the same way, but the first
> > argument, expected, still needs quotes at the call site, of course.
>
> That's a good idea, let me run with it.

Indeed, this patch fixes it (see e.g.
https://dev.azure.com/Git-for-Windows/git/_build/results?buildId=3D34370):

=2D- snipsnap --
Subject: [PATCH] fixup??? t3431: add rebase --fork-point tests

Try to fix the Mac build, which currently fails thusly:

	++ git reset --hard G
	HEAD is now at d8775ba G
	++ git rebase $'\177'
	fatal: invalid upstream '?'
	error: last command exited with $?=3D128

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 t/t3431-rebase-fork-point.sh | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 4607e65de6..daa0c77467 100755
=2D-- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -29,29 +29,29 @@ test_expect_success setup '
 test_rebase() {
 	expected=3D"$1" &&
 	shift &&
-	test_expect_success "git rebase $@" "
+	test_expect_success "git rebase $*" "
 		git checkout master &&
 		git reset --hard E &&
 		git checkout side &&
 		git reset --hard G &&
-		git rebase $@ &&
+		eval git rebase $* &&
 		test_write_lines $expected >expect &&
 		git log --pretty=3D%s >actual &&
 		test_cmp expect actual
 	"
 }

-test_rebase 'G F E D B A' ''
-test_rebase 'G F D B A' '--onto D'
-test_rebase 'G F B A' '--keep-base'
-test_rebase 'G F C E D B A' '--no-fork-point'
-test_rebase 'G F C D B A' '--no-fork-point --onto D'
-test_rebase 'G F C B A' '--no-fork-point --keep-base'
-test_rebase 'G F E D B A' '--fork-point refs/heads/master'
-test_rebase 'G F D B A' '--fork-point --onto D refs/heads/master'
-test_rebase 'G F B A' '--fork-point --keep-base refs/heads/master'
-test_rebase 'G F C E D B A' 'refs/heads/master'
-test_rebase 'G F C D B A' '--onto D refs/heads/master'
-test_rebase 'G F C B A' '--keep-base refs/heads/master'
+test_rebase 'G F E D B A'
+test_rebase 'G F D B A' --onto D
+test_rebase 'G F B A' --keep-base
+test_rebase 'G F C E D B A' --no-fork-point
+test_rebase 'G F C D B A' --no-fork-point --onto D
+test_rebase 'G F C B A' --no-fork-point --keep-base
+test_rebase 'G F E D B A' --fork-point refs/heads/master
+test_rebase 'G F D B A' --fork-point --onto D refs/heads/master
+test_rebase 'G F B A' --fork-point --keep-base refs/heads/master
+test_rebase 'G F C E D B A' refs/heads/master
+test_rebase 'G F C D B A' --onto D refs/heads/master
+test_rebase 'G F C B A' --keep-base refs/heads/master

 test_done
=2D-
2.21.0.windows.1.152.g5895f170b6

