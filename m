Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6417E202A3
	for <e@80x24.org>; Wed, 18 Oct 2017 17:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbdJRRAz (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 13:00:55 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:58670 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbdJRRAw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 13:00:52 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20171018170048epoutp03c87e967fd134bfd12457669314aafcf5~uuL1U-QvU2862628626epoutp03h;
        Wed, 18 Oct 2017 17:00:48 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20171018170048epcas2p44aff40ae92f07aa81c77ab370a847beb~uuL0_vzVd0174701747epcas2p4U;
        Wed, 18 Oct 2017 17:00:48 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.E7.04101.0C887E95; Thu, 19 Oct 2017 02:00:48 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3~uuL0wQVt10408304083epcas2p4O;
        Wed, 18 Oct 2017 17:00:47 +0000 (GMT)
X-AuditID: b6c32a48-c27ff70000001005-1b-59e788c0e451
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 21.8C.06856.FB887E95; Thu, 19 Oct
        2017 02:00:47 +0900 (KST)
Received: from [106.109.129.81] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0OY100BHE3973S30@mmp2.samsung.com>; Thu, 19 Oct 2017 02:00:47 +0900 (KST)
To:     git@vger.kernel.org
Cc:     peff@peff.net, pclouds@gmail.com, gitster@pobox.com, l.s.r@web.de,
        avarab@gmail.com, krh@redhat.com, rctay89@gmail.com,
        Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
From:   Andrey Okoshkin <a.okoshkin@samsung.com>
Subject: [PATCH] commit: check result of resolve_ref_unsafe
Organization: Samsung RnD Institute Russia
Message-id: <0e396c24-167f-901e-9122-cdc17164ec1e@samsung.com>
Date:   Wed, 18 Oct 2017 20:00:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7bCmqe6BjueRBqtaWCzWPrvDZNF1pZvJ
        oqH3CrPF5tu3GC2azp9hsjiztZ/Z4uPsEywW3VPeMlr8aOlhtpi2bwe7A5fHzll32T2e9e5h
        9Lh4Sdnj/b6rbB59W1YxenzeJOdx+9k2lgD2KC6blNSczLLUIn27BK6MDV/WshRMFKmY8WkX
        YwPjYsEuRk4OCQETiVWvmlm7GLk4hAR2MErcmbySCcL5zijx9cxGVpiqRYeaWSASGxgltm1d
        ygjh3GeU+L7gLiNIlYiAuMTb4zPZQRLMApcYJd5f3c8EkmAT0JM4/2sCO4gtLGAtsfj5f7Cx
        /AJaEpd/zGMGsXkF7CQuPrsPZrMIqEqc+doBVi8qECFx/PByRogaQYkfk++xgNjMApoSL75M
        grLFJY7dv8kIYctLbF7zlhnkCAmB52wSk8/0Ay3jAHJcJHa8CYN4R1ji1fEt7BC2tMSzVRsZ
        Iex6idaOJ2wQvR2MEp9nLYUqspfY0rWdDWIBn0TH4b/sEDN5JTrahCBKPCQurrnGDGE7Sqxu
        PAv2o5BArMSn9lVsExjlZiF5YRaSF2YheWEWkhcWMLKsYhRLLSjOTU8tNiow0StOzC0uzUvX
        S87P3cQITkNaHjsYD5zzOcQowMGoxMP7Q/FZpBBrYllxZe4hRgkOZiURXrO255FCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeeu2XYsQEkhPLEnNTk0tSC2CyTJxcEo1MPamf2TTcdxTtTmlVPyY
        442IzFrrHbzrp1cLHM+ZE/w6ljOCOXk697S/Nr6qfX9+/JTbZZrodLiwYfJHkxxrjvLuV5d7
        xfUMv/8vdT299sf1lzPv5CeKn+n4k63y0rCf36i1/KR8q6Smrdhlv//JsckX0t7dqzinb8mg
        MUdancPtylZXY7GVSizFGYmGWsxFxYkATAlx3j8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsVy+t9jQd39Hc8jDb52GFmsfXaHyaLrSjeT
        RUPvFWaLzbdvMVo0nT/DZHFmaz+zxcfZJ1gsuqe8ZbT40dLDbDFt3w52By6PnbPusns8693D
        6HHxkrLH+31X2Tz6tqxi9Pi8Sc7j9rNtLAHsUVw2Kak5mWWpRfp2CVwZG76sZSmYKFIx49Mu
        xgbGxYJdjJwcEgImEosONbN0MXJxCAmsY5T4t3sGI4TzkFFi2+6z7CBVIgLiEm+Pz2QHSTAL
        XAFKzJnCDJJgE9CTOP9rAliRsIC1xOLn/1lBbH4BLYnLP+aB1fAK2ElcfHYfzGYRUJU487UD
        rF5UIELiefN7VogaQYkfk+8BncEBtEBdYsqUXJAwM9DeY/dvMkLY8hKb17xlnsDIPwtJxyyE
        jllIOmYh6VjAyLKKUTK1oDg3PbfYqMAoL7Vcrzgxt7g0L10vOT93EyMwOrYd1urfwfh4Sfwh
        RgEORiUe3h+KzyKFWBPLiitzDzFKcDArifDebH8eKcSbklhZlVqUH19UmpNafIhRmoNFSZyX
        P/9YpJBAemJJanZqakFqEUyWiYNTqoHR/+KkTEPPLBfbO9tPtEp+PvLZ/G6tl4f/nZuTZn9t
        8Vt8xD6H739VrsXpJaoaElsFLbZbPHbqqHxn+8pTRKvo0tGG8hU8RXoWVgX2jh+PlU34kb3F
        LaLznup39iXX2HmWTJuQbnyeQ9VCNX/5b3upI2GuvxNPmOUpMcewzGFi/11fZT+V77ESS3FG
        oqEWc1FxIgChNmtKigIAAA==
X-CMS-MailID: 20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3
X-Msg-Generator: CA
X-Sender-IP: 182.195.42.143
X-Local-Sender: =?UTF-8?B?QW5kcmV5IE9rb3Noa2luG1NSUi1TVyBUb29scyBMYWIb?=
        =?UTF-8?B?7IK87ISx7KCE7J6QG0xlYWRpbmcgRW5naW5lZXI=?=
X-Global-Sender: =?UTF-8?B?QW5kcmV5IE9rb3Noa2luG1NSUi1TVyBUb29scyBMYWIbU2Ft?=
        =?UTF-8?B?c3VuZyBFbGVjdHJvbmljcxtMZWFkaW5nIEVuZ2luZWVy?=
X-Sender-Code: =?UTF-8?B?QzEwG0NJU0hRG0MxMEdEMDFHRDAxMDE1Nw==?=
CMS-TYPE: 102P
X-CMS-RootMailID: 20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3
X-RootMTR: 20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3
References: <CGME20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3@epcas2p4.samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add check of the resolved HEAD reference while printing of a commit summary.
resolve_ref_unsafe() may return NULL pointer if underlying calls of lstat() or
open() fail in files_read_raw_ref().
Such situation can be caused by race: file becomes inaccessible to this moment.

Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
---
Hello,
I've injected a fault to git binary with the internal tool for fault tolerance
evaluation.

lstat() or open() calls return '-1', errno is set to 'EACCES':
#0 0x6559a4 in files_read_raw_ref refs/files-backend.c:686
#1 0x642816 in refs_read_raw_ref /home/tesla/devel/repos/git/refs.c:1392
#2 0x642a69 in refs_resolve_ref_unsafe /home/tesla/devel/repos/git/refs.c:1431
#3 0x6443ce in resolve_ref_unsafe /home/tesla/devel/repos/git/refs.c:1483
#4 0x44822e in print_summary builtin/commit.c:1485
#5 0x44822e in cmd_commit builtin/commit.c:1817
#6 0x4084f5 in run_builtin /home/tesla/devel/repos/git/git.c:342
#7 0x4084f5 in handle_builtin /home/tesla/devel/repos/git/git.c:550
#8 0x40997b in run_argv /home/tesla/devel/repos/git/git.c:602
#9 0x40997b in cmd_main /home/tesla/devel/repos/git/git.c:679
#10 0x408087 in main /home/tesla/devel/repos/git/common-main.c:43

As a result git crashes silently with SIGSEGV at 'strcmp(head, "HEAD")':
#0 0x447c16 in print_summary builtin/commit.c:1486
#1 0x447c16 in cmd_commit builtin/commit.c:1817
#2 0x4084f5 in run_builtin /home/tesla/devel/repos/git/git.c:342
#3 0x4084f5 in handle_builtin /home/tesla/devel/repos/git/git.c:550
#4 0x40997b in run_argv /home/tesla/devel/repos/git/git.c:602
#5 0x40997b in cmd_main /home/tesla/devel/repos/git/git.c:679
#6 0x408087 in main /home/tesla/devel/repos/git/common-main.c:43

It seems that in a real life it's very difficult to reproduce such behaviour
because the readability of '.git' directory is checked before. But still the
NULL pointer result returned by resolve_ref_unsafe() is not checked anyhow.
That's why I'm not sure whether it's a bug or not.

Best regards,
Andrey

 builtin/commit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1a0da71a4..71a58dea3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1483,6 +1483,8 @@ static void print_summary(const char *prefix, const struct object_id *oid,
 	diff_setup_done(&rev.diffopt);
 
 	head = resolve_ref_unsafe("HEAD", 0, junk_oid.hash, NULL);
+	if (!head)
+		BUG("unable to resolve HEAD reference");
 	if (!strcmp(head, "HEAD"))
 		head = _("detached HEAD");
 	else
-- 
2.14.2
