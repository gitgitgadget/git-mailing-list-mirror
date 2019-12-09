Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE86C43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 17:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3666207FF
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 17:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="MHmOPq2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLIRLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:11:17 -0500
Received: from mout.web.de ([212.227.15.3]:34003 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfLIRLR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 12:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1575911465;
        bh=+ttCo/JrPGFNQaiAW7O+0Wh2Wl3DpEovwoILWFjUpZI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
        b=MHmOPq2LdUIPFwqPz5NftSPGSdRwClYfoePYpFeInPEAGcm3owO6pV4FqV04OnS2O
         aLUyvL/9BlW/6dNNu9IWIESjxHgLqJJ7LLdq66SJHgySlhyymkMoXhujlJtX9a0WG8
         S1JP1lcGtDk/XCKqPiqxC5j2Z4rWjnbNyciEN7+Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.92]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MAdb9-1iT8PT3wM7-00BxQX; Mon, 09
 Dec 2019 18:11:05 +0100
Subject: Re: Git Test Coverage Report (Mon. Dec 9)
To:     Derrick Stolee <stolee@gmail.com>
References: <903fcdea-6f08-caf5-77a4-2e82b8585edf@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Message-ID: <e47b77b4-7b7a-3d59-9e24-934528c5e297@web.de>
Date:   Mon, 9 Dec 2019 18:10:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <903fcdea-6f08-caf5-77a4-2e82b8585edf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a3CIIPv8VHGGGaxzkXFsyAqkMNiSu5xehe1hNWwFB9TUUH4rq3z
 JJdhPRtqJcI87yrAUlmz2E+drsSf2DeyjU0NQk9Dy95f/r//zVWCe3l68QgWvoOrKw4J/cF
 fjRzoC/+UZXAnizj9tjB6zz/C+3MtqnczBmdbf5BSgslTKWtEPTmEzoasna++0gVqywllbJ
 1Okm0eu3Zxq9IaSXitbTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j+7mWO/jVMI=:vhOZ9fSoGMRyki9OsutXcW
 NMu6YyKClQdflXzBtTGLiFCdG0m5V+DUiFDk1jlys7/5/DtKwhnD2zs/nmLn4BzW8MwswoTVv
 rpT8P16Na0MDs3H0IKq/Kiwu+kiwXtuU7X5kwvbVyQmTaeoi0FlXTpC4lLTVF/Bf7Pe1gguj3
 NcAHwTAR+2mHTMveNcrHzrt4pyiEok2pIv0U6iSXMXsgN7xirWhNGjwam8fThG2ZR9gpy1P1T
 IueZ4YGQKImDqXL9WvU/rwnTwp+wx0w++n4lyHzDTIMfWXD1KCxHo37Fd1o7/cHgW+UKVY6Q2
 IgYgsvGApEShYOCjR56kU2I1FLLT5RrVbTHVZRHelwN5SsFHoNNgctQbUeiNBMh5OhyiyBthm
 Gp0Ynpt/3mYy6FmPUR9ZbXq15MwrtG9rGPcyHKd4fOZ1yqmYRUL4WWm+FRLaBrwjteGc7N+2V
 ZcH0FG55ph0OD8sX1D8ohPa8ePSfvAmGjKYC3amRpPN92AWPOjwDHW3juzNFvv/6SEpqqx1ZN
 RSw1JrjfMpS8JS4m5cD8Ut5VgtxutvfjX69zK6KH5mUMgTjlAyIEVnlR3zxERu/WBxGKeuKwA
 1Q5i4xMGx82n1e6R3zThRqTZ0ifcRXeyk4U6h6uW+q9jSqqlMeBMF2b0VimdoqfgPPFDn17cu
 8J8sig59y2Xieh7OG9n7maJdRm+KRqIlMgsYFk9O0KOXzPoo+XvbRaDqmvXtcAvi1/kcZbo3n
 iwSDhwb28IZaOpVJzQzzt+DRT7KvOjSix/S1QMO8EnGeOX4mxMKXrccSA6C7YadnDYnCYVJTV
 q5qIRspeH/+D6NTfPbmpsowOvrEuIS1jWJspMDL7E+THsz/1iH7ck4zDbdgE5qKsF26Udpiap
 Lmt2UiNkQmDr2mYzJyoLyL+iJFq4WKC2nxezi/H1S5PTfxGUdYnKD1Wji56dNIaSSwRSpVn5v
 nbznNe3SQT1nBukeOjOAtGwv3NTr47H93KQ7tf947fEgTl8Ymobg/1izx1ptVhX4qRik6ytV2
 qvJ7HiGzkD1YeuucEe0ZSFvPYTt/UdC72ph7At+ENcjHf7Q3X8ksC3P7derZ7l5N+l3M0vcSj
 LiqLziD+OXSiUJZ8aSZ7UAcCNsjb1Y+gjgQgvhWzGi/oNpOONgtFil4LJFZqXAcKBvl5noExx
 U2F2imHK2JeeJ1SJFAdD8rlVpM1U86STAV2Tbtg2lNFk0IZ3xqZqv1m3z9jNwGL58iemK9HIG
 8j71dwNpaoEjYav9IHm0d/6OvLFkT2G66qPhanw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.12.19 um 16:36 schrieb Derrick Stolee:
> Uncovered code in 'next' not in 'master'
> --------------------------------------------------------

> Ren=C3=A9 Scharfe	0bb313a5 xdiff: unignore changes in function context
> xdiff/xemit.c
> 0bb313a5 223)        xchp->i1 + xchp->chg1 <=3D s1 &&
> 0bb313a5 224)        xchp->i2 + xchp->chg2 <=3D s2)
> 0bb313a5 225) xchp =3D xchp->next;

Hmm, line 223 *is* exercised by t4015.85.

That loop skips ignored changes before function context -- we don't want
those.  t4015.85 only has an ignored change within function context and
0bb313a5 reveals it, as intended.  So for better test coverage we could
do something like this.  Does it help?  (It should, but I'm mystified
why 223 shows up in the report.)

=2D- >8 --
Subject: [PATCH] t4015: improve coverage of function context test

Include an actual function line in the test files to check if context is
expanded to include the whole function, and add an ignored change before
function context to check if that one stays hidden, while the originally
ignored change within function context is shown.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t4015-diff-whitespace.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 5888ae5ed3..7a13e1de62 100755
=2D-- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -2026,19 +2026,24 @@ test_expect_success 'compare mixed whitespace delt=
a across moved blocks' '
 '

 test_expect_success 'combine --ignore-blank-lines with --function-context=
' '
-	test_write_lines 1 "" 2 3 4 5 >a &&
-	test_write_lines 1    2 3 4   >b &&
+	test_write_lines    1 2 3 "" function 1 2 3 4 5 "" 6 7 8 9 >a &&
+	test_write_lines "" 1 2 3 "" function 1 2 3 4 5    6 7 8   >b &&
 	test_must_fail git diff --no-index \
 		--ignore-blank-lines --function-context a b >actual.raw &&
 	sed -n "/@@/,\$p" <actual.raw >actual &&
 	cat <<-\EOF >expect &&
-	@@ -1,6 +1,4 @@
+	@@ -5,11 +6,9 @@
+	 function
 	 1
-	-
 	 2
 	 3
 	 4
-	-5
+	 5
+	-
+	 6
+	 7
+	 8
+	-9
 	EOF
 	test_cmp expect actual
 '
=2D-
2.24.0
