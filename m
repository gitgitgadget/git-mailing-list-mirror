Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A57D1F4F8
	for <e@80x24.org>; Sat, 24 Sep 2016 11:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754815AbcIXLaq (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 07:30:46 -0400
Received: from mout.web.de ([212.227.15.3]:55010 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbcIXLap (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 07:30:45 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MT8cQ-1bLbuB1JXa-00S9Wg; Sat, 24 Sep 2016 13:30:25
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:     Git List <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] git-gui: stop using deprecated merge syntax
Message-ID: <cbb1815e-0ebc-e103-927e-14d7d038245a@web.de>
Date:   Sat, 24 Sep 2016 13:30:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Hv3NcmtqnYX0ggfb/3Md4lQ+ZxeAB45iWZm32uBswd5GuLF9ptD
 TJYPJN2dZFoPQdbwfnQCMEbO6C5unhQjV5JflqTLh8St5ytdMALkLhfEY5Esa5dpv/gFoi8
 TSToyG2RUbC+O2gwB2nLqNU64a3cx87eFSWHmy7//tKwliPKOPyaobsls2byYE6RNA6tQTu
 oDoZFJym1VDmnatYAEH9A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lTWXJNRF2TI=:YBdjwBCVxW2Co0i3SnmeLm
 cHGV7q4uan3MkVGcDoTQK9ECvEf861t80e/YZ2NUI6kx218MwlaVoAPzIzqyJ0K5tjiUR37UH
 PV+6u0Nzx7dSVOnUKBLyjvXKqxHqyNDtKspVmk4WPwK20uy01sDIjrPQ1Gf1YITUf4XTHJjBz
 tlZu48NDPFOyrfLCNKtKNgMKgY5EcNFWzHn+0gXa9/YiFTqfvAaP3TVj2w17OtXvz6PbFxSxl
 S/Gu46Ehywrv96oGVQAvCo7I0gbRx8OwKbuRjLE3KZHkgZecVY7X/4S5cBSSpD69oTRRCBQqp
 UQLqxZCahdjxlwLKiPzQ+f43hFk/h9vpFdKZyg2UnFMEs9z32Vb4R3Bf8pHOYpEoFUiIyYC7f
 O+ob5t9/GqS3E4aZS4owRb5wx3gsge7QQnZ3+t5lFQK8/7msu75paLmGqN9ELXj/eqbefBkot
 SSsbbcv6wzzpjGRZEntN/gyv4crDLIDW5xjSc0jmfn+JKYQUhzokGp73Vo7DH8WVKFbMqrmEV
 fp2jSOXMc+emHe80lDN1zF1Fm1jxqPE26KTmuHb7pnIOyTWS8PAG8yiMBmcAmsWeSX+b0tzsr
 EyhDW232SecIvn+2hNrjeVLkSADpP8j/eiEFK9aCgDAP9B25zQd3O1agwYjNXU6iyvzv+joH6
 qEcwZvHiaS07YYS1jH2SlVicZWi1fQcwgCcvNAfz9+yY3eUhpGo6kS2kDyJDqDW38R5yJ7/CT
 bdtI3nEftJgDxoeUQWum0quaVIYraKP+UMdGL6WgzZ+NERQboyv1wHx/FCmaZE5L2EYCAlrht
 sXeEpCp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Starting with v2.5.0 git merge can handle FETCH_HEAD internally and
warns when it's called like 'git merge <message> HEAD <commit>' because
that syntax is deprecated.  Use this feature in git-gui and get rid of
that warning.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Tested only _very_ lightly!

 git-gui/lib/merge.tcl | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/git-gui/lib/merge.tcl b/git-gui/lib/merge.tcl
index 460d32f..5ab6f8f 100644
--- a/git-gui/lib/merge.tcl
+++ b/git-gui/lib/merge.tcl
@@ -112,12 +112,7 @@ method _start {} {
 	close $fh
 	set _last_merged_branch $branch
 
-	set cmd [list git]
-	lappend cmd merge
-	lappend cmd --strategy=recursive
-	lappend cmd [git fmt-merge-msg <[gitdir FETCH_HEAD]]
-	lappend cmd HEAD
-	lappend cmd $name
+	set cmd [list git merge --strategy=recursive FETCH_HEAD]
 
 	ui_status [mc "Merging %s and %s..." $current_branch $stitle]
 	set cons [console::new [mc "Merge"] "merge $stitle"]
-- 
2.10.0

