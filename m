Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA881F42D
	for <e@80x24.org>; Thu, 19 Apr 2018 08:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbeDSIVc (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 04:21:32 -0400
Received: from mout.gmx.net ([212.227.15.19]:43497 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750858AbeDSIVb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 04:21:31 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MMShK-1f47oG2Y2g-008Jag; Thu, 19
 Apr 2018 10:21:26 +0200
Date:   Thu, 19 Apr 2018 10:21:10 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 7/7] technical/shallow: describe why shallow cannot use
 replace refs
In-Reply-To: <cover.1524125760.git.johannes.schindelin@gmx.de>
Message-ID: <c041db4e62283e520a29039ddfec24d77d023d70.1524125760.git.johannes.schindelin@gmx.de>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de> <cover.1524125760.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GSVuXS5Tj85IBqBS3+z5Qqpvj4zcrlrLRMofVBoIEhXrRNPlYmC
 KwvnWrwcyZvym6m34kPNvGaMLnh0tsqxYIdVBAi7u2tzZ7hl/pV2oW59fOr/C7d9f9YqF4a
 p+q6nO9zVvlpWOIq5Esl3FQWI/I1BPxi/lho8ifLjuAcGJoxQ03iyj7iv/nGbFfWNlvXSMo
 YoybjWhN/+9PknBuRVu1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K9rqpjP+MG4=:27d7MRlFe3cMXNDignqZty
 /N7GYfFnx0TFRJ9KzF866May4rAUyrlWOKoK/8HQhkMXJSqBOOFpmSRGVy642fJ3ivuJzwI1o
 EbhFPdaaI4DGBBdnhpygR34rUkHAo2fvNTuilolmczgeNz4JNQtsGMrf2vIjRIhCOWimI4k/L
 CM8ZMWfhbynH0gOE7ziQi5BQxiRMGy2IjDW6i5eAowIeq0GtpM5SD9kO5Ejc2DfaR6Ysbi59i
 b7npbR8Ty9EwWJUvvPD8gNlHoGYElU0PGcHeG52qdbZNb9L9MK5ZKGaIgZ9YwT1iLKbt5YhHv
 Mi3MxG1zzE/TEgmjTq7Ta52nMN0ecW1NPY7WruOakUDyHWcelYfL7TBpp0imdQ0t33uTL1VIA
 AeK4blUS79O7a680nD1tX1mDb/jRpzRvmTcNrNhiE1AlnPfU4CI9xhHKaH9POZQhCg6SP88wE
 /fPBkDCXPlX4PDBAiJsb8mf0eO5vZ50H9nJvAXhOqtlBCBCxkpiX19C2HqO6AyURECutDJWIX
 5jl9VSFrKxKzLZh/SrwXeE0pQFcu/Fbs9Vi0VgQmEPBqAe0OOG59M2pVAevD7gS7DRYHy6mNk
 wHK6AOS3CyO+fwaWV1wkGjB2MgKQaLgh3lq81sGAAq14j12J7HOxe6hIj/Gan0vI3wFSc3qJn
 GTW5jphGMLt/K4+hLpq79mxCDRPgMzHRHLbJG6zGFIw5t28HbCpE+WcqYTu43oRngUgSTd3wd
 l/UIJcbgJcsjnx0jOh0ttrQspIeC7qML6K7wna73S5Cv1zytFpcVZG8ReAdT638zSS0G7aSgV
 Z/tCuBZtogXEHdWZKQY6mqHkMrpyKKK2NsuNidsYU+rro+bsZw=
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

	By the way, I did not squash this into the previous patch on
	purpose: in my mind, describing the relationship with replace refs
	is different enough from pointing out from the goal of this here
	patch to merit a separate commit. And that goal is: to describe
	why "shallow" cannot be implemented on top of "replace refs".

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
2.17.0.windows.1.4.g7e4058d72e3
