Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F520C433E2
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 08:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3197920663
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 08:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgGOIIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:08:31 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:59059 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgGOIIa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 04:08:30 -0400
Received: from [192.168.1.29] ([82.228.182.34]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.184]) with ESMTPSA (Nemesis) id
 1M6m1g-1jw9MB0cpi-008Ij5 for <git@vger.kernel.org>; Wed, 15 Jul 2020 10:08:29
 +0200
To:     git@vger.kernel.org
From:   Jean Abou Samra <jean@abou-samra.fr>
Subject: Git bisect run should check for the existence of the script
Message-ID: <9cea8076-be96-19c5-c368-288193daedd8@abou-samra.fr>
Date:   Wed, 15 Jul 2020 10:08:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K1:6t8x2O7FNE+nQ7HqsJyEm9itGaQgJigf2ZStWpK/G1jqYcI2EYH
 xJbOt8fs/hVufoJCdx89A4wgH9IUtNF7LjV6EgqlivmLacf1lBoGxgzgBaE30R1lBNrEnf5
 NBO014VdUWb2Sepsphl/hDFmXcycEnMIrsZwgQSfOhjp8YWvqoS2heuqFuq9tTY4n6ySac/
 vEJNYjLkRQhn0FrIq0EEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j8QGW52fzlE=:gs7YhEO4R7h2SHz4GYOGmr
 v0NWgOlGcA66w19Kb4ockfMB59Oh/1f8BxCpYnRxSAqlGt1Y/OvMeRzT6IHZyYqUepzd06Vwk
 n92aPmXvXNR79u7yK63FjIbekh7GGM7lXL6QT6nsYZFH6pm6YvKSN5COj9Jx+B1Meu8sstSRM
 CT3+fAo4gql/aU+/lDvikRJx5UWDjTtb8SN4RYRi32rJG+ZxX5gTl4l+KGB+Ffy9Cy1vu9dZS
 zgOGPWtGGJgbfVcsUPjwWVJXPcbw1PWhBlFc6oFTFCwzXLELY/AUEynTey8ZDcSeBwecHh5Tz
 jUm7g1e04hVtmjsjXbapr/6nyckkInWi1eKDjSAzDgHR5jRxAgwYo8/U2Ckyc6ONdEXhS6ZVV
 tMthg4tXs8oJ2tEjiQT4ghk7tONp/j1n5S15Uln0h58rMI3dlitCnG5RnCsXb63yb3g4J01Ck
 Uyd6rzms6DfzxnGaYbJnNuYwELvsCZNwUwI+HWFaf0OkqtV6vXpIbnNZWE77zCFa+7FC8G2w0
 19JF3je5pPsq0a7ldjQhgsnJNGPBqfcgyIO4VibvwxMkToBJLCLqptsXoEtisllkW3Ys8zqgt
 Lb9y77rPVKeUrCyKg6vR+DAKQ0lIZzlY/LYKNCM9fpCOOmXdL5pfRKD2oQb/lI3mpXyfTLdgw
 7sRYgBREigPSnqWm8l4RpckieTqc23pDU65qku4f6AXV/+sRZ5tl3n2YkIxT289Vzq3aNOezx
 97JpF3oL319zJt+efGoLu8SEkityR256EUMgmtxwjVgDvcHJlBNQVmFjeFGZ4FbE/ZDvWsaih
 aMuuWu44PDxqLayfeBPNU4/3RuoSukuSCdLrSKfC8O5fRyq6b0Zp5X1CKrwasJV4NuM6Ot3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When using 'git bisect run', if the name of the script is misspelled or 
if the script was not made executable, 'git bisect' considers it to be a 
failure and stops at the first revision after the one claimed good. It 
would be better in my eyes to error out.

$ git bisect start
$ git bisect bad HEAD
$ git bisect good HEAD~10
Bisecting: 4 revisions left to test after this (roughly 2 steps)
[344dce312a0cf86d5a5772d54843cc179acaf6e3] bpo-41228: Fix /a/are/ in 
monthcalendar() descripton (GH-21372)
$ git bisect run ./non-existent.sh
running ./non-existent.sh
/usr/lib/git-core/git-bisect: 247: ./non-existent.sh: not found
Bisecting: 2 revisions left to test after this (roughly 1 step)
[6fc732a2116e2c42b0431bb7e2a21719351af755] Fix typo in docs: 'created by 
th' -> 'created by the' (GH-21384)
running ./non-existent.sh
/usr/lib/git-core/git-bisect: 247: ./non-existent.sh: not found
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[8182cc2e68a3c6ea5d5342fed3f1c76b0521fbc1] bpo-39573: Use the Py_TYPE() 
macro (GH-21433)
running ./non-existent.sh
/usr/lib/git-core/git-bisect: 247: ./non-existent.sh: not found
8182cc2e68a3c6ea5d5342fed3f1c76b0521fbc1 is the first bad commit
commit 8182cc2e68a3c6ea5d5342fed3f1c76b0521fbc1
Author: Victor Stinner <vstinner@python.org>
Date:   Fri Jul 10 12:40:38 2020 +0200

     bpo-39573: Use the Py_TYPE() macro (GH-21433)

     Replace obj->ob_type with Py_TYPE(obj).

  Modules/_elementtree.c       | 2 +-
  Objects/abstract.c           | 4 ++--
  Objects/genericaliasobject.c | 2 +-
  Objects/unicodeobject.c      | 4 ++--
  PC/_msi.c                    | 6 +++---
  PC/winreg.c                  | 4 ++--
  Tools/scripts/combinerefs.py | 2 +-
  7 files changed, 12 insertions(+), 12 deletions(-)
bisect run success


Best regards,
Jean Abou Samra

