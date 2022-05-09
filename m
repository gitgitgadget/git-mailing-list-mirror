Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E98C433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 12:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiEIM4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 08:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiEIM4A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 08:56:00 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FB21EEE04
        for <git@vger.kernel.org>; Mon,  9 May 2022 05:52:04 -0700 (PDT)
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MLRI3-1nWmxp14Pj-00ISAY; Mon, 09 May 2022 14:51:58 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 2E6891E01E7;
        Mon,  9 May 2022 12:51:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BZwiWHIW_R6J; Mon,  9 May 2022 14:51:48 +0200 (CEST)
Received: from pfwvexchange.corp.cetitec.com (unknown [10.10.1.40])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 8AD561E01E6;
        Mon,  9 May 2022 14:51:48 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.8.5.31) by
 pfwvexchange.corp.cetitec.com (10.10.1.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 14:51:48 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from local account)
Date:   Mon, 9 May 2022 14:51:47 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     Taylor Blau <me@ttaylorr.com>, <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Crashes in t/t4058-diff-duplicates.sh
Message-ID: <YnkOYyYkfC1C8c/+@pflmari>
References: <YnOQmVFVRuqnanMi@pflmari>
 <YnSWgDdxgm+XWiLt@nand.local>
 <YnT19KB2XkBrJOLQ@pflmari>
 <xmqqv8uioc7p.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <xmqqv8uioc7p.fsf@gitster.g>
X-Originating-IP: [10.8.5.31]
X-ClientProxiedBy: pfwvexchange.corp.cetitec.com (10.10.1.40) To
 pfwvexchange.corp.cetitec.com (10.10.1.40)
X-EsetResult: clean, is OK
X-EsetId: 37303A29E82A2D51617662
X-Provags-ID: V03:K1:SAqIYGv4VPI6GiFN/TQqTb43twI541j6gd1t4M4WjSfFhBhvW+r
 o/E3JaaOEGcZn8IXwsRlFcp0BCmaSNa75GBzOJ/v2jTbws/lW/cRhsQ/qwjRo31uBtDAZNv
 dt91YVIASfn73zsTyAJ9Xvjtyr4SVAMdVyVENYkHpL9cl4Zk9QcmokFY6/2KEgfxPhUA/hZ
 S7zPNwqwO7b2T2EYx434w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:34M68GX4Epk=:qCEFDLFfOs9hHwSWxRTc8V
 E+r6p1amuAZaz8/vviiSfqlI5JpAb7WhUsl3ZcW4Hoc1J7ZhBtcp4uCej4m7wvr0d7xCEjhtR
 FkzWMl03wRXN/044rZvYW2trfcYFL/b+5dZsvd3JQrDaNhoklVbU9J/I4IJHy7/1QdjwckSci
 LdcFB1UqDWwiNqj7s+kauJkUDCgvfG3rhH8dfWYOoNj5MvkAE9/Y/xv3iEJf6RoTh9gEsTJQE
 NMqLzDGK+l+QXsQBlFEoDjcSsS2oYIaYXS3nB6en9gGi7hTq518uTDKbFzKQGIAafoeTTssGP
 OhHHbIUDd+QPq402Sqbe7A1i7oUl6Mec8SzxRltQc7j191Ih7hZfhj7DfVI/tsc5lI0UvhanD
 fbYEl3I2lyIauEv8iPkvH5aqVao8o5fLuHNrBBVqyIODG+jMmbm40BiI4mHx5Z7soYM2+Riuz
 xFOpJr4KQXcNgXQ++CbWhcn+zk+PSdb6834MxN6twyrW4A36FNpW4Z/ZOtQCzyVrG3BsS1NlZ
 WThWg5KqQGMzE7JFt3xQpJCzsr+Q6xn405VEj285tig6MLhfhUzdjlNk4eztKd6fdqccz46mh
 veJFhjRPCrv+sYNXltW78aLanVTfzjruQFZ1n4MOLx08rlpDLbcA5GEixPXOqWQyo0Jo93jKJ
 ZZKV2YVKvLPi/+zOjzSP3YSEvyUfD9TAUrjKjId3rQ5gz1M8gA7joA9vdMfcj9AjPW3fynr6F
 1A+L7DDT98rirGtB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Fri, May 06, 2022 18:30:34 +0200:
> Alex Riesen <alexander.riesen@cetitec.com> writes:
> 
> > Taylor Blau, Fri, May 06, 2022 05:31:12 +0200:
> 
> >> t4058.16, which blames back to ac14de13b2 (t4058: explore duplicate tree
> 
> That commit talks about "trees with duplicate entries".  Does it
> mean a bad history where a tree object has two or more entries under
> the same name?  We should of course be catching these things at fsck
> time and rejecting at network transfer time, but I agree it is not a
> good excuse for us to segfault.  We should diagnose it as a broken
> tree object and actively refuse to proceed by calling die().

There seem to be multiple places (according to the the commit above, and these
tests on my machine find two) where something crashes, and while one is easy to
plug with a simple if-NULL check:

Program terminated with signal SIGSEGV, Segmentation fault.
#0  0x000055786ef58a00 in traverse_by_cache_tree (info=0x7fff87d1f400,
    info=0x7fff87d1f400, nr_names=1, nr_entries=4, pos=0)
    at unpack-trees.c:807
807                     len = ce_namelen(src[0]); <--- src[0] is NULL


the other case seems to be more involved:

#0  verify_one (r=r@entry=0x5555e70aeaa0 <the_repo>,
    istate=istate@entry=0x5555e70ae980 <the_index>, it=0x5555e839ab90,
    path=path@entry=0x7ffedea66570) at cache-tree.c:929
929                     if (ce->ce_flags & (CE_STAGEMASK | CE_INTENT_TO_ADD | CE_REMOVE))
(ce cannot be resolved) ----^

Threads:
  Id   Target Id                         Frame
* 1    Thread 0x7f26de550740 (LWP 19565) verify_one (r=r@entry=0x5555e70aeaa0 <the_repo>, istate=istate@entry=0x5555e70ae980 <the_index>, it=0x5555e839ab90, path=path@entry=0x7ffedea66570) at cache-tree.c:929
Stack:
ce = 0x5a5a5a5a5a5a5a5a <--- Poisoned pointer?
sub = 0x0
i = 1
pos = 0
len = 6
tree_buf = {
  alloc = 65,
  len = 33,
  buf = 0x5555e839b530 "100644 inner"
}
new_oid = {
  hash = '\000' <repeats 31 times>,
  algo = 0
}
#0  verify_one (r=r@entry=0x5555e70aeaa0 <the_repo>, istate=istate@entry=0x5555e70ae980 <the_index>, it=0x5555e839ab90, path=path@entry=0x7ffedea66570) at cache-tree.c:929
#1  0x00005555e6e43720 in verify_one (r=r@entry=0x5555e70aeaa0 <the_repo>, istate=istate@entry=0x5555e70ae980 <the_index>, it=0x5555e83777b0, path=path@entry=0x7ffedea66570) at cache-tree.c:888
#2  0x00005555e6e44398 in cache_tree_verify (r=0x5555e70aeaa0 <the_repo>, istate=istate@entry=0x5555e70ae980 <the_index>) at cache-tree.c:968
#3  0x00005555e6f10807 in write_locked_index (istate=0x5555e70ae980 <the_index>, lock=lock@entry=0x7ffedea66740, flags=flags@entry=1) at read-cache.c:3332
#4  0x00005555e6df7456 in cmd_reset (argc=<optimized out>, argv=<optimized out>, prefix=<optimized out>) at builtin/reset.c:551
#5  0x00005555e6d5b21b in run_builtin (argv=0x7ffedea67260, argc=2, p=0x5555e707d0a8 <commands+2472>) at git.c:465
...

Ideas?
