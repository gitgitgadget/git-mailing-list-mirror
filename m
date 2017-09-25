Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C762202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 16:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935426AbdIYQGS (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 12:06:18 -0400
Received: from mout.gmx.net ([212.227.15.18]:49259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934503AbdIYQGR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 12:06:17 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LpbJm-1dTWjM1fb4-00fOed; Mon, 25
 Sep 2017 18:06:10 +0200
Date:   Mon, 25 Sep 2017 18:06:08 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/1] Simplify loading of DLL functions on Windows
In-Reply-To: <f5a3add27206df3e7f39efeac8a3c3b47f2b79f2.1505834586.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1506355545.git.johannes.schindelin@gmx.de>
References: <f5a3add27206df3e7f39efeac8a3c3b47f2b79f2.1505834586.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eQPl0L2N0DHUuLkp/gaMiZtYH4MUwyEQWhs/eCTwQv7OAr4JGTm
 okkLwjxYYNQI3l0ZPQPQxvYIxaBO/KJIkHbMFujt2mzxZI4ETNKVE3wwR9RVp1zAKZAQA2+
 pV+rFkvHJBJGjiiWlLPNE0rBhTSpJeiA/zUYhNw21DkGMqTDdExfBqUNS/d8BKxOAYYZ4Dh
 0E38g+0m7yLDY4kdDJCSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pRxe0bIF13U=:47Sc2q1eRvouVvhpBs12DL
 75b6AnSPq2SJCK58yiJnKE37gufbd914T6DLdYLRCCjnbGANT50XV+5pYJNP8rYMV9O8YFibs
 CG3zN1xpxwyf2SXEcLbVnkwPRp1KXdEaGVEk70pJ5DGC7DpWJDxHeZYBN6e8Pme6MSSTs6RAT
 rMlIYMmRMgumd7Pp/9SYmecCf0xJNREX1SrvSXAzAzWJYXR8HO1msOidKt2p5aIYwTDLWKvbl
 aHXm3NG/i/Q4xAO7Z3FDiuKw3zP77m2Nwa/GCldLERsglYZe+nG1QN3Wodu2QnsVg+nizgj8F
 IuaLHroVZDpFX/6c6gd675oUKetpRJWNiWWtxnmPXMByrRtRzfLwf9VigvqIKlqosUedLJh0y
 rsGF7yoSVR92vF8yL5Tm0OAA7LB+a5AvgZg7HTbqsCdYf/UnIbzlP6H7gcEk7IU/jB+ul6p2a
 Ujda2nbvLPuidDAzS/AalntA/7X/q70viza4dUZZooQmtDKOWlM2vyhRwX5sbAwfuOkPFayrU
 9o8VopJh2Y69iyLG+6NsCDaRibwEQ7QvfncABBLzWfDBtWOiKVjotWI8pol90igiuKzGT12NG
 g6ZmR1ApIZ1b46NhQWVaoz/9mjukj3TPomWeTSmqQhfqurUQJIcgkmwotVz2zqNh6/O0I2LGl
 MURdfOh4ySmRKeOQ5dZA8mvIagjMq7Rvg8uh7PsalD3aOQ3zU5QYi3G0id+fYS8HoDqhcu5EJ
 mHt852W8sO4UaUGzzQiCGbMjS20iM4Q3XSIO0Fwsjrhfw+P/AjaPSapwBCjkgRxFa0G/gHa/V
 PEBdB32ZxmXf9bLBPqGGTukDrIArsqgXR7L34IGUZgn4dTn2+k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1:

- repeated the example from the commit message in the .h file

- mentioned that the function is not thread-safe.

- added Jonathan's Reviewed-by: footer


Johannes Schindelin (1):
  Win32: simplify loading of DLL functions

 compat/win32/lazyload.h | 57 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 compat/win32/lazyload.h


base-commit: 28996cec80690d2322359d3650a57e8de6e01eb6
Published-As: https://github.com/dscho/git/releases/tag/lazyload-v2
Fetch-It-Via: git fetch https://github.com/dscho/git lazyload-v2

Interdiff vs v1:
 diff --git a/compat/win32/lazyload.h b/compat/win32/lazyload.h
 index 91c10dad2fb..9e631c8593f 100644
 --- a/compat/win32/lazyload.h
 +++ b/compat/win32/lazyload.h
 @@ -1,7 +1,19 @@
  #ifndef LAZYLOAD_H
  #define LAZYLOAD_H
  
 -/* simplify loading of DLL functions */
 +/*
 + * A pair of macros to simplify loading of DLL functions. Example:
 + *
 + *   DECLARE_PROC_ADDR(kernel32.dll, BOOL, CreateHardLinkW,
 + *                     LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);
 + *
 + *   if (!INIT_PROC_ADDR(CreateHardLinkW))
 + *           return error("Could not find CreateHardLinkW() function";
 + *
 + *   if (!CreateHardLinkW(source, target, NULL))
 + *           return error("could not create hardlink from %S to %S",
 + *                        source, target);
 + */
  
  struct proc_addr {
  	const char *const dll;
 @@ -20,6 +32,7 @@ struct proc_addr {
   * Loads a function from a DLL (once-only).
   * Returns non-NULL function pointer on success.
   * Returns NULL + errno == ENOSYS on failure.
 + * This function is not thread-safe.
   */
  #define INIT_PROC_ADDR(function) \
  	(function = get_proc_addr(&proc_addr_##function))
-- 
2.14.1.windows.1.1024.gf2dea585d74.dirty

