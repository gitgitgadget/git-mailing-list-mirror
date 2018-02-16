Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9CB51F404
	for <e@80x24.org>; Fri, 16 Feb 2018 12:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966392AbeBPMZu (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 07:25:50 -0500
Received: from mout.gmx.net ([212.227.15.18]:46717 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966351AbeBPMZt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 07:25:49 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0MfVU3-1fAWf41B99-00P38O; Fri, 16 Feb 2018 13:25:45 +0100
Date:   Fri, 16 Feb 2018 13:25:44 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/1] Colorize some errors on stderr
Message-ID: <cover.1518783709.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iSzyiye2Sss+00E2/IwLcysXaOCu3fZK0V1g3tWJM1EMFf0b0SA
 2acYIZRMtxrlXtMZuSakryAFuA6BnAHAQM7DpxygCMrn/s7lFxNNRMcFoYgHOhPw1/+cCkW
 mS5W/GLAlOihrQzCV7IvZwQufk92P62K0Hqe3PFKoTVTH+mkyDIVVsOziNF9SAXpEVDFVQ3
 LOviU6k7SfMAz0UBMHiOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ttctQEeDUhQ=:/RknMt3hNFTHp7bpEDUmru
 u9sr6P8LPzuhu5S14GfK7lk/tTjsdyUdKAekQnFEC3U7ab9xLiU5bSKIgX8QBjoSPaR/5YVDy
 +04XThDumZeshoOSn4KfrNKSA8cLyRvAr1UxiGUC/alHhbJcMlx/Iafp/RNePWEHJgWFDz4Jo
 tHCNRy7mLPPrOyVOA3yqtutKb4aWloH7Wx0aoTjqFdGiocH2q4g9zZKjCcDyBpyjmQrnpSda3
 Lz6/Ye6Pj6H3KZaBKwX2gNw4m6EOGTfNnrl3v8ObST77DXIfPgiNxJ0veLmrjrxUOMKctrRNh
 r7/yBsQQugJx/zBKtfU+H85aIgBYvlYjfgUjnzU5CNgOy/mdfjKaRkug/BrjuoXFPEwe9pDpd
 D4cde5e+EzAsAOmwpxnsLMpaFMQ+HD/yP21sgc6deiS8y/DBSNVSpix+IVpPfXzR5Aa+SZ4Yb
 Ow39MDkRyv8mOiJatOpZ6r8Y+t4DrUhbBa3zbQ6eEYsGjcdbCZ3twJaMtyveB5+AhO7ruI/1z
 Hfs9duyoPxkxYdToqSlB2gs7BAqxYEG8DdlOfDf93QV0RDo67qJITKhUPRFL3bAKk9/Xi67uB
 BvUT9OaCq63sZtUXadurGUv0XvyzMjY1af+eZNI3tGcvntmT4mxt4Ls2OGQ2Fj4k+m5KSyTHp
 YVxuuFVCbZj8r+QapNd43Rr/5gWMY9oz7rs6QayH9CLOVVNd3RxNO+f2k9W4oWNyZSVjkTOwr
 mb+p0sZ3ljjSpKY0Y/+kn6AeyMukJAZUQHIACA+mFGpk5NyySB0fbLvtNJ8xtFhANgQ4u41l8
 LN0wtpLW+oYE44Onk44sBK/Kh/Nv39s/jfF5QGesGWzuDQQ3sU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an RFC because it tries to introduce a fundamental new color feature:
Coloring messages *on stderr*.

So far, pretty much everything in color.[ch] assumed that you want to color
only stuff on stdout.

However, in this case, a user (who became a contributor!) wanted some messages
that are printed to stderr and were missed by his colleagues to be colored.

The contribution comes via Pull Request from the Git for Windows project:

	https://github.com/git-for-windows/git/pull/1429

Now, what would be possible solutions for this?

- introduce `int fd` in `want_color()` (and callees) so that we can make
  a distinction whether we want to detect whether stdout or stderr is connected
  to a tty

- introduce a separate `want_color_stderr()` (we still would need to decide
  whether we want a config setting for this)

- not color stderr, ever

Also, I did not have too much time to dig into the question how to test this in
Git's test suite. Do we already have tests that generate fake server-side errors
onto which I could piggy-back a new test case?

Thoughts? Suggestions? Help?


Ryan Dammrose (1):
  Colorize push errors

 advice.c       | 42 +++++++++++++++++++++++++++++++++++++++--
 builtin/push.c | 38 +++++++++++++++++++++++++++++++++++++
 transport.c    | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 136 insertions(+), 3 deletions(-)


base-commit: b2e45c695d09f6a31ce09347ae0a5d2cdfe9dd4e
Published-As: https://github.com/dscho/git/releases/tag/colorize-push-errors-v1
Fetch-It-Via: git fetch https://github.com/dscho/git colorize-push-errors-v1
-- 
2.16.1.windows.4

