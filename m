Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2DFA1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 14:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932698AbdA0OSH (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 09:18:07 -0500
Received: from mout.gmx.net ([212.227.17.21]:64505 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932803AbdA0OR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 09:17:56 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYKGj-1d1afj0m2r-00VB9W; Fri, 27
 Jan 2017 15:17:38 +0100
Date:   Fri, 27 Jan 2017 15:17:36 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Sverre Rabbelier <srabbelier@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [PATCH v3] t/Makefile: add a rule to re-run previously-failed
 tests
In-Reply-To: <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>
Message-ID: <85044791cfcba35c1ad3d8138051f3f075cb0646.1485526641.git.johannes.schindelin@gmx.de>
References: <0dfa96b17edfe84ba19c7e57fe0b017c77943e0c.1472478285.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fA23KqxQEUpz1arqoRWGUMNoY0JhLZYsVGBMNtCeytsc6iHx+sh
 iF6V0cJhplx02vfPDGt60pskaIB2N5quluEnjUYBFcZESygz95VVt+Nn4IEWfWGEpv3U4M4
 mhbhaMLpRQ5Lq8r7Gk/QnphcLqkxDJ+kBn3Fqq0G3ozgIDhcRvNhLMi7vVdHUs9IzesX+7M
 SvMHagmVwzfZ2tPZdBymA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K8zT4fj80aM=:LfVp6iN0TNuCsFXs2zKnS3
 F9fhX2DL4FVsGkTpSocIJ2yR5ZpvITNOH75Rl2p17yhjl5Dyt6HzEr4tM5DRExCLykG9+MsFB
 r8BFXmd+l8/XDzFOqyhR1mUebJZru765IXR1C6KpCuawKu/k0Ms0IwvEU9C8k2jy4hYPhcDPu
 +44HsdnwkgzS+hHbsnE/A5vT0UmNVPRs/GXB17uTJoMKR5HgfsSfRZ0OqLNazWAM6ShwOgYmO
 vSsB/L3CLx2OI/gars1ePJwOBMXFVEOd9RO5jzV+fhHhIcs7DmskwJGYxB2gpq6ozkjnsgQlK
 3IfNVTNhJhcyJqGjnIthS4uaRe/B7Tg7Dti3esL4O06km1yiG0buk6Jx2VFpIcXl6gvyntpyf
 DJLuP1BJa5zhb+7pXurxUjIiBF+mMrg/vTfs8zxCcr5V1tePRS4PbhMydzZ3GBD5vtqi7XJG4
 lD+ZVIH30/I3+1g3+GOj5XXvptaR0BfMFFwciVbKjb0kjqc9CD9o1AWTdyBHKVoI7TmyYV4pE
 Qin7KkB9e411xXHKqdzWXviwvIvKEf+RzjkQUntCM9YYynRxVnM5vUhpRZqfzCdbjE1dsXUgu
 5xHkHoSzHd6mdKekd2pHPux61eP9Tr03JvufWgZvaEvSXYO0n+DHyxpp3RGU7fskYw+5BmbWi
 otg4O7y387nDRqdLNHL6yA6TJ/P63TvYlj1Z1oxaZClLtUyeevnhuL3e4Lxuq/1dxWYzeu4kk
 GCu+U/J+tM7fpv6ejFAszh3MzRQ+hsFT/ZLcmDo28tcD7obweMSMxbsTPITMUL8+A30AIbVQ/
 XgbL21nJESy1Ijhxl1Y8Fs3Dcyu2m54NDhOs6qyzkXMWhktFwx3wKrf9N+DahmJBz7biC9X79
 uVRXHcxXN13LJCgl+0ESaBkOI5UqoW1WcY4j49qeu6h7uC8BpDqiOFkZfxzLJha+okor2YFVJ
 HOfMQEOOHdY//OTu2GHY9Lp19hBWgDznZ3vR5idOKexEpMNJBYUYFQEWce8LYCztLC57tRCPf
 fdVRBuIIn/EFkRuaIB1oltSovr5Vvlr8n/bDIVb0mNySvkDYTTxxtVxDSF4sqVMirQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch automates the process of determinig which tests failed
previously and re-running them.

While developing patch series, it is a good practice to run the test
suite from time to time, just to make sure that obvious bugs are caught
early.  With complex patch series, it is common to run `make -j15 -k
test`, i.e.  run the tests in parallel and *not* stop at the first
failing test but continue. This has the advantage of identifying
possibly multiple problems in one big test run.

It is particularly important to reduce the turn-around time thusly on
Windows, where the test suite spends 45 minutes on the computer on which
this patch was developed.

It is the most convenient way to determine which tests failed after
running the entire test suite, in parallel, to look for left-over "trash
directory.t*" subdirectories in the t/ subdirectory. However, those
directories might live outside t/ when overridden using the
--root=<directory> option, to which the Makefile has no access. The next
best method is to grep explicitly for failed tests in the test-results/
directory, which the Makefile *can* access.

Please note that the often-recommended `prove` tool requires Perl, and
that opens a whole new can of worms on Windows. As no native Windows Perl
comes with Subversion bindings, we have to use a Perl in Git for Windows
that uses the POSIX emulation layer named MSYS2 (which is a portable
version of Cygwin). When using this emulation layer under stress, e.g.
when running massively-parallel tests, unexplicable crashes occur quite
frequently, and instead of having a solution to the original problem, the
developer now has an additional, quite huge problem. For that reason, this
developer rejected `prove` as a solution and went with this patch instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/failing-tests-v3
Fetch-It-Via: git fetch https://github.com/dscho/git failing-tests-v3
Interdiff vs v2:

 diff --git a/t/Makefile b/t/Makefile
 index 8aa6a72a70..1bb06c36f2 100644
 --- a/t/Makefile
 +++ b/t/Makefile
 @@ -37,9 +37,8 @@ test: pre-clean $(TEST_LINT)
  
  failed:
  	@failed=$$(cd '$(TEST_RESULTS_DIRECTORY_SQ)' && \
 -		grep -l '^failed [1-9]' $$(ls -t *.counts | \
 -			sed 'G;h;/^\(t[^.]*\)-[0-9]*\..*\n\1-[0-9]*\./d;P;d') | \
 -		sed -n 's/-[0-9]*\.counts$$/.sh/p') && \
 +		grep -l '^failed [1-9]' *.counts | \
 +		sed -n 's/\.counts$$/.sh/p') && \
  	test -z "$$failed" || $(MAKE) $$failed
  
  prove: pre-clean $(TEST_LINT)


 t/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/Makefile b/t/Makefile
index d613935f14..1bb06c36f2 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -35,6 +35,12 @@ all: $(DEFAULT_TEST_TARGET)
 test: pre-clean $(TEST_LINT)
 	$(MAKE) aggregate-results-and-cleanup
 
+failed:
+	@failed=$$(cd '$(TEST_RESULTS_DIRECTORY_SQ)' && \
+		grep -l '^failed [1-9]' *.counts | \
+		sed -n 's/\.counts$$/.sh/p') && \
+	test -z "$$failed" || $(MAKE) $$failed
+
 prove: pre-clean $(TEST_LINT)
 	@echo "*** prove ***"; $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
 	$(MAKE) clean-except-prove-cache

base-commit: 4e59582ff70d299f5a88449891e78d15b4b3fabe
-- 
2.11.1.windows.prerelease.2.9.g3014b57
