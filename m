Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51B941F424
	for <e@80x24.org>; Sat, 21 Apr 2018 09:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeDUJ4q (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 05:56:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:35377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751282AbeDUJ4o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 05:56:44 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNuwp-1f2POu48XT-007T1Y; Sat, 21
 Apr 2018 11:56:40 +0200
Date:   Sat, 21 Apr 2018 11:56:16 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 10/11] technical/shallow: describe why shallow cannot use
 replace refs
In-Reply-To: <cover.1524303776.git.johannes.schindelin@gmx.de>
Message-ID: <f8a93d3ff6ab598d4f47811b638a85ffbb3d3ba2.1524303776.git.johannes.schindelin@gmx.de>
References: <cover.1524262793.git.johannes.schindelin@gmx.de> <cover.1524303776.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VUFXtQYe4MbzM1osiQPmASdDmWV0bVbHxJWtfgSkJO443LVvH8Z
 OwuAQSrS1MCEmex4qbiWyhWquJsjfj/qgFZYKkbU1azUmHnAMLG4iuJC1062mV4MuFqWHPF
 ancq7ZH+FtscdpPmunVUe2AVRQ9zJ+aMzGmFocLxiFnmLcU2ehQwQLAIDqLUo9FUS+WElR2
 rqjOYMktyEoCGsLe8MGlA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:30HU0ZLMwrM=:ZoovkPZPpiN9YPj4tNlm+E
 5PZBd5OKcLf12pO0YVmBp9Q7Kjw60IgTuzfMGZZi2UHJXha5b0ImzeHSGGKduw+N8kQMu3kp5
 xBSnSXLNDsfsvYPs4qvtJ3pzQz35Q/lKUfp4/jkh8qSrkzhb3QLUQuboNS0cFvHFkjhlPZWva
 NN+jrzFKcINJvkBp9QAGXIUysABucoUq4wXC0eaFxHx9Pgn5NTiDI22LbsIGZsUji2ZRxpk3g
 Fqextia28XaskU3P4DmGGQ4VGc4BH3WAt3TPEktjCPoMnjjmoeND9c/fME1X+JLT+ekZ0ZZvU
 CeHB7GkB0u0mH0kH7rVh7KNFRwcwFn4yf7mkrhJAZGc6Z13A653+lsD+rIbmUf+iIFp6BFLnx
 RsipY9Gy6G56G5M4QVFqzn2FOniOsw8p3rpJuTV8RQhWT9C1ftenz+3NnYeCaiVoF51ynUN6j
 yL1g9Fptn6psvDbch4Zzhj3JBhYwAZ+GZ2TnkDj2Kq+8dD1HoInPOjNY40UocdVOFvbPk6WgW
 vUvbrbzmq3Z+DODeVtK7v0Yp+pCbRdLz/rRipg6g+ugBGY+iBDYqXtWgeRPHH9h2+LSbsfQRz
 qoJ1FdlRss2jSpV4RuQS8GhZavbb/B14+2zEjlfMxXS3DvpEvhvW/DDsNcy9+vI7T1l2kSg5h
 ccfa5pehGkhd6KirNYTgC3XFgUdjDlTOaznc+3iEVvEcBN9m08aEjMlM7uUs6EJ6ESoJrD0t1
 tAd0cMZJyntE7CDDtnln4UvYsao4hOnGIBOXeBw2a32qIEWyAozemEPJGW9Halz0edGBali8p
 lX3Aw2ebCG/O/p4qCUB9DKcZ0B5/WODT5xmoM44z4KTvZ3YPP4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is tempting to do away with commit_graft altogether (in the long
haul), now that grafts are deprecated.

However, the shallow feature needs a couple of things that the replace
refs cannot fulfill. Let's point that out in the documentation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/shallow.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/technical/shallow.txt b/Documentation/technical/shallow.txt
index b3ff23c25f6..cb79181c2bb 100644
--- a/Documentation/technical/shallow.txt
+++ b/Documentation/technical/shallow.txt
@@ -25,6 +25,13 @@ Each line contains exactly one SHA-1. When read, a commit_graft
 will be constructed, which has nr_parent < 0 to make it easier
 to discern from user provided grafts.
 
+Note that the shallow feature could not be changed easily to
+use replace refs: a commit containing a `mergetag` is not allowed
+to be replaced, not even by a root commit. Such a commit can be
+made shallow, though. Also, having a `shallow` file explicitly
+listing all the commits made shallow makes it a *lot* easier to
+do shallow-specific things such as to deepen the history.
+
 Since fsck-objects relies on the library to read the objects,
 it honours shallow commits automatically.
 
-- 
2.17.0.windows.1.15.gaa56ade3205


