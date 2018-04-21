Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA90A1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 11:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeDULOa (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 07:14:30 -0400
Received: from mout.gmx.net ([212.227.17.22]:35821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752480AbeDULO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 07:14:29 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M7DVi-1eFO2L3Ud4-00x2pP; Sat, 21
 Apr 2018 13:14:23 +0200
Date:   Sat, 21 Apr 2018 13:14:08 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Dan Jacques <dnj@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] gettext: avoid initialization if the locale dir is
 not present
In-Reply-To: <cover.1524309209.git.johannes.schindelin@gmx.de>
Message-ID: <4ac5d3b9ace6ea8a41e97c036c8122f0d26d3c5a.1524309209.git.johannes.schindelin@gmx.de>
References: <cover.1524211375.git.johannes.schindelin@gmx.de> <cover.1524309209.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+SmX3YNLi+wu1Qeq8/2Mv9B50TMnjgndsS4eabweeNFnina574k
 NDc7j0mTwjK0LB3YxT8ZBLmH4LAV03Xy9WZXefiQpso5CVJrR1tGmOafduijdFSFM1/MNrd
 AeLpRPOwaHkdHTLBu6gOX2yAOrQIvnMR+w3hw320XO6CCHl6xYk5lX7nL70f9IbuC18RMVm
 eCOq3DxDso3AQCQfavQGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g8lzmjDFRFM=:o8v7uKzwLJRn+BImTS6itP
 byBSVxV7LfkCo3MRUr4nPHaD7aO+AGYvuYoFikV6gL0sGLhvzXos0fcK/VC5tIIfzEG0W4qYL
 uA2PRzcX4XYXRPZjrdW+WlX4lajRCIxoAq+sLYQHMYgt6McSt7wR96PExZGAQfmhsJD7NkZ/6
 WWtqZGRfwXNlMFiabNQgcjeRkDbQtcKB1d3K4aMvkhf9byxq6th4il4gFFQ1+d1Xk78ZWQddM
 9OEUrcU0nKxe1EGm4SL9XIxXkfYN0DrQXf4AYUBAFT3+xZudnWOsjdYhpISsQqWZifiPklm4I
 WJo3tSjO5BxvUC3KSeT+A1/icnPQbxlxaXTgQFNAjiZ1iG7ws2QvBpFokr6/tKA4zUZMpDFKK
 u6ipq18m7/ug4oQIrRxhQsPdYsI2KQckHSxkrVw64vSnKgJa3H2azs8Mtssf0qByGC/FDYm/T
 pWO89P0GMJZV2YoKXISDLpDwDGhu46dCbBqXWcPeAVXSFbN+k71q7qsjJMMFIESJHj1O1tIeI
 Aj5zpPs24gkUqI23Y2LYh0yKm8FFpzDflhJgyh6spyhEbgFRsx5/07QsBWdRQLeTnQ0liy0BQ
 FvErQoMTM8U1vUnkoK21q1V8o53ku1RHH+ka6aqs/F/NxVwFov2h+KJUFUDUihMdSP9ZexqGZ
 SNBi2dGVgKq66IQCs7Fiuzbwf3nDZR/+YVDjHH4jbEXbY+y6gtETpXYOk4GdKylZ5yhrYde1e
 Dhyxx/KSyuXPJTCEciRvEWVrOiCQyd/bGuPbms1CrWTsg/vTKsgXgfyM599OTZ5u0RDThsgm6
 B2r4QRVxyrPxlQnEeIu+mw1M5tXwwewEZVpYIDeKnXkd0VjoGw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The runtime of a simple `git.exe version` call on Windows is currently
dominated by the gettext setup, adding a whopping ~150ms to the ~210ms
total.

Given that this cost is added to each and every git.exe invocation goes
through common-main's invocation of git_setup_gettext(), and given that
scripts have to call git.exe dozens, if not hundreds, of times, this is
a substantial performance penalty.

This is particularly pointless when considering that Git for Windows
ships without localization (to keep the installer's size to a bearable
~34MB): all that time setting up gettext is for naught.

To be clear, Git for Windows *needs* to be compiled with localization,
for the following reasons:

- to allow users to copy add-on localization in case they want it, and

- to fix the nasty error message

	BUG: your vsnprintf is broken (returned -1)

  by using libgettext's override of vsnprintf() that does not share the
  behavior of msvcrt.dll's version of vsnprintf().

So let's be smart about it and skip setting up gettext if the locale
directory is not even present.

Since localization might be missing for not-yet-supported locales, this
will not break anything.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 gettext.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/gettext.c b/gettext.c
index baba28343c3..701355d66e7 100644
--- a/gettext.c
+++ b/gettext.c
@@ -163,6 +163,9 @@ void git_setup_gettext(void)
 	if (!podir)
 		podir = system_path(GIT_LOCALE_PATH);
 
+	if (!is_directory(podir))
+		return;
+
 	bindtextdomain("git", podir);
 	setlocale(LC_MESSAGES, "");
 	setlocale(LC_TIME, "");
-- 
2.17.0.windows.1.15.gaa56ade3205


