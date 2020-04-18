Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCFBC38A29
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 14:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C41E2072B
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 14:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="h8/97Mol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgDRO5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:57:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:44715 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgDRO5G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Apr 2020 10:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587221819;
        bh=OcYqrppUNtlrLEhDZEDhU9KMrq/4rmg57J0fc+KlDto=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=h8/97MoldT3y69A5Ecwiw9RbYUhPYOUin4ZAMndMy7rjfOg4ax13eThkOSNcfr+A7
         4aRwAYwARoRj7kODYu6vs9u39V3nIpcw/FGWSVovA8svjp3zpa8VK5OyIer65KInbW
         gbRnwDilf5ROE3hXSPK3QBPcJaC03gjH3UwM5bLI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.169]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N2V4J-1jFLHg0XE7-013ygt; Sat, 18 Apr 2020 16:56:59 +0200
Date:   Sat, 18 Apr 2020 16:56:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Matheus Tavares <matheus.bernardino@usp.br>
cc:     gitster@pobox.com, asheiduk@gmail.com, git@vger.kernel.org,
        greg@hurrell.net, l.s.r@web.de
Subject: Re: [PATCH] grep: follow conventions for printing paths w/ unusual
 chars
In-Reply-To: <nycvar.QRO.7.76.6.2004181509350.46@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2004181655300.46@tvgsbejvaqbjf.bet>
References: <xmqq1ronyz1s.fsf@gitster.c.googlers.com> <eaae7214925189f562056b1ee6972c05dcf76a32.1587103366.git.matheus.bernardino@usp.br> <nycvar.QRO.7.76.6.2004181509350.46@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1n7wEbjZRCYTk+PVXQYpAVpMeYRNn/Or+nM/Ia/kvAu3fRFKRQH
 RhXUYMUB2k1j6TVLr2UpLA/yP58o9S6xq/kfYcrv/FrzxAJNbry88HZN/j1P5ostHam0jXm
 QbOI36BpsfBLtKmKsMEzI/2L9Gg8OK/UE5oE7BbWMlEo7lWEDvQEW+KkjLjza57Qi4jq356
 61A/dYvB1D2bxW6pWXpSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mVtpc8Mbflo=://wQqXxMEMFlhd9jel0r9v
 /YnNB1NEqlJO4yzmt0cqCeLWrwZZXMs0hjwK4W1HEPoXVitxfs2as+Mc3+A/LKCNqGu5RNsG0
 mwcocs98G2odXqM06ik0UzATLnOI/HgivgnbHbOLuD+550lpKPsY56unt2u7ZX/+EksuCKLMN
 PCc+d24+J4XTSyKYhJdNR0eLd4tTz+wtXmvz4flAqgiJRDlEFi7F3DJ8q4nM9BBArs8to8FUm
 0NrXSWXeBp/wkrrjjwYEtrNlKkPo6SW1WWxDHZltcb4IbCGpOXXFOKG/GngxvU28LpH7zJhuy
 DMKBElLldBe/5wEHAd4pTgGGR/+PtcChlAuP2bEoDgisC5hvd1HEhOzzNkZleVfvbhLbaT5wj
 59kXVCWhaKAGtP1Dx88ZCTFs/Nh4Td+JEJ1xksR8x5tJEiHneRDJT/RxUxiAVS1gDFvwl+BbU
 rZEiBVQbkzd+asEvr5Bpft2qB8XilGhWTT6ta25w1touxaNy2g4wJ2mr8HWOlIBX4tk4AXRuA
 76atp+Hh2e5IbKbZhbmCbuGxi9VvJuRvfMKybhadudVCmsQw8YMELct7gR0ZTQ3cEnMFTB/0s
 V4OpadNTAJG8MbOKvzwxMgRsk3mmFR0PxiTvdbWEhWPF34rU2GJt1CsBLQ9javMDTf0VXThH2
 XctPC/+jLXmZVrAE27MUjJXsZWFC6GWI3n6dkI5iUZhYnEtWURC/3u9LS+X4slSCZBJyUexe/
 hRNne5VWG6efsDnhgo5WpI28/M2HNJAGcVc4IXACEBOcDMhZPUaDCgxBs0boa4Q7g9QH7aOmS
 s9cSPla61O+Srz3hxigfSo/y1wE1mkV+YshEK+ofbfQvOG/An5FG8d7sfhTVAiznDBeDiK2kC
 fqA4AfsrivVrJqs8GbvX1yeQ2k4rYa34+OqlWFpIIn1qu217cPuiAlSs+I7hTAg8S3aklhaeT
 K+cwMptokENaNcUtxINa0ue5yO0Ab+LZE/78gK62L49tVeGp/GmSWD1woCS82ZcmUoDVoI4pP
 XPaojLRq8dvB0F65dz4FR39QBUQ/7FYsdiwLf5aL5ZIDShTimo58C2IODkV0mUOdm2Z5WP21L
 QRumLUdnzaA5eqAQKNcJ5FvIZ/tr8K7IjCAVaX4Y2pplpcG5hPCB0evjEjLxnntKtpU3Pkgxo
 Xe77nAVOtSJ7hBb6Xb9O6KpFaDFu3YduZIZQ8MBDyTpT6LtNkDgy3wIqpbZnpp01/65psuzR5
 22joo5v3TgxsRmQWg
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Sat, 18 Apr 2020, Johannes Schindelin wrote:

> On Fri, 17 Apr 2020, Matheus Tavares wrote:
>
> > grep does not follow the conventions used by other Git commands when
> > printing paths that contain unusual characters (as double-quotes or
> > newlines). Commands such as ls-files, commit, status and diff will:
> >
> > - Quote and escape unusual pathnames, by default.
> > - Print names verbatim and unquoted when "-z" is used.
> >
> > But grep *never* quotes/escapes absolute paths with unusual chars and
> > *always* quotes/escapes relative ones, even with "-z". Besides being
> > inconsistent in its own output, the deviation from other Git commands
> > can be confusing. So let's make it follow the two rules above and add
> > some tests for this new behavior. Note that, making grep quote/escape
> > all unusual paths by default, also make it fully compliant with the
> > core.quotePath configuration, which is currently ignored for absolute
> > paths.
> >
> > Reported-by: Greg Hurrell <greg@hurrell.net>
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> >  Documentation/git-grep.txt |  6 +++--
> >  builtin/grep.c             | 46 ++++++++++++++++++++++++++++---------=
-
> >  t/t7810-grep.sh            | 44 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 82 insertions(+), 14 deletions(-)
>
> Unfortunately, this causes eight test failures on Windows:
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D38023&vi=
ew=3Dms.vss-test-web.build-test-results-tab
>
> Could you please have a look? I suspect that this has something to do wi=
th
> those new tests needing the `FUNNYNAMES` prereq.

I need this commit to fix it:
https://github.com/git-for-windows/git/commit/7ca815e1ab89d6ffdb1a17b3cbac=
df22a508d33c

I'll paste it here, for your convenience:

=2D- snipsnap --
=46rom 7ca815e1ab89d6ffdb1a17b3cbacdf22a508d33c Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Sat, 18 Apr 2020 16:49:43 +0200
Subject: [PATCH] fixup??? grep: follow conventions for printing paths w/
 unusual chars

It is easy to be fooled by the Bash included in Git for Windows, which
leads you to believe that quotes are valid parts of file names.

On Windows, they are not. But Cygwin (which is the base of MSYS2, which
is the POSIX emulation layer used by that Bash) only _pretends_ that it
is a valid file name character. In reality, it will map the character
into the private Unicode page. Cygwin knows about this. The rest of
Windows applications (including Git for Windows), however, does not.

As a consequence, `>\"with\ quotes\"` will claim to succeed, but the
file on disk will have Unicode characters in place of those quotes that
literally no application but Cygwin ones can handle, and this leads to
those beautiful new tests to fail.

Let's just use the prereq we introduced to guard precisely against this
problem: `FUNNYNAMES`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 t/t7810-grep.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index ab495dba28a7..991d5bd9c03f 100755
=2D-- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -72,8 +72,11 @@ test_expect_success setup '
 	# Still a no-op.
 	function dummy() {}
 	EOF
-	echo unusual >"\"unusual\" pathname" &&
-	echo unusual >"t/nested \"unusual\" pathname" &&
+	if test_have_prereq FUNNYNAMES
+	then
+		echo unusual >"\"unusual\" pathname" &&
+		echo unusual >"t/nested \"unusual\" pathname"
+	fi &&
 	git add . &&
 	test_tick &&
 	git commit -m initial
@@ -484,7 +487,7 @@ do
 		test_cmp expected actual
 	'

-	test_expect_success "grep $L should quote unusual pathnames" '
+	test_expect_success FUNNYNAMES "grep $L should quote unusual pathnames" =
'
 		cat >expected <<-EOF &&
 		${HC}"\"unusual\" pathname":unusual
 		${HC}"t/nested \"unusual\" pathname":unusual
@@ -493,7 +496,7 @@ do
 		test_cmp expected actual
 	'

-	test_expect_success "grep $L in subdir should quote unusual relative pat=
hnames" '
+	test_expect_success FUNNYNAMES "grep $L in subdir should quote unusual r=
elative pathnames" '
 		cat >expected <<-EOF &&
 		${HC}"nested \"unusual\" pathname":unusual
 		EOF
@@ -504,7 +507,7 @@ do
 		test_cmp expected actual
 	'

-	test_expect_success "grep -z $L with unusual pathnames" '
+	test_expect_success FUNNYNAMES "grep -z $L with unusual pathnames" '
 		cat >expected <<-EOF &&
 		${HC}"unusual" pathname:unusual
 		${HC}t/nested "unusual" pathname:unusual
@@ -514,7 +517,7 @@ do
 		test_cmp expected actual-replace-null
 	'

-	test_expect_success "grep -z $L in subdir with unusual relative pathname=
s" '
+	test_expect_success FUNNYNAMES "grep -z $L in subdir with unusual relati=
ve pathnames" '
 		cat >expected <<-EOF &&
 		${HC}nested "unusual" pathname:unusual
 		EOF
=2D-
2.26.1.windows.1

