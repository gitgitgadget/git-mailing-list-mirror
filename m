Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F334C1FF72
	for <e@80x24.org>; Fri, 20 Oct 2017 11:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbdJTLDf (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 07:03:35 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:13258 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbdJTLDd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 07:03:33 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20171020110332epoutp04b676b42f8183408817350e7f0ff58a8c~vQmdrRyrZ0269102691epoutp04O;
        Fri, 20 Oct 2017 11:03:32 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20171020110331epcas1p4a3bb3afe19d6b6d223a22e1de91571f4~vQmc1Kjp70632406324epcas1p4Q;
        Fri, 20 Oct 2017 11:03:31 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.D2.04388.308D9E95; Fri, 20 Oct 2017 20:03:31 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20171020110330epcas1p20ce56b13897b7a74358946346048457a~vQmcgEZhQ2228922289epcas1p2F;
        Fri, 20 Oct 2017 11:03:30 +0000 (GMT)
X-AuditID: b6c32a38-d89ff70000001124-8e-59e9d8038e71
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 99.07.06995.208D9E95; Fri, 20 Oct
        2017 20:03:30 +0900 (KST)
Received: from [106.109.129.81] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0OY400GPRC1SMZC0@mmp2.samsung.com>; Fri, 20 Oct 2017 20:03:30 +0900 (KST)
Subject: [PATCH v3] commit: check result of resolve_ref_unsafe
To:     Jeff King <peff@peff.net>, gitster@pobox.com
Cc:     git@vger.kernel.org, Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
From:   Andrey Okoshkin <a.okoshkin@samsung.com>
Organization: Samsung RnD Institute Russia
Message-id: <c5f72436-df4e-5c51-d58b-8699dfcfd70c@samsung.com>
Date:   Fri, 20 Oct 2017 14:03:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.4.0
MIME-version: 1.0
In-reply-to: <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZdlhTX5f5xstIg3WTeSy6rnQzWTT0XmG2
        2Hz7FqPFx9knWCx+tPQwO7B6POvdw+hx8ZKyR9+WVYwenzfJBbBEcdmkpOZklqUW6dslcGW8
        +cteMImj4s5yxwbGB2xdjJwcEgImEp+3NjKC2EICOxgljrY7dzFyAdnfGSX+HDzPDlN06+Ur
        VoiiDYwSC//WQBTdZ5SYff8sWEJYwE7idf85FhBbRMBA4sVDiGZmgVyJV63vwWrYBPQkzv+a
        ABbnF9CSuPxjHjOIzQvUO/HOf7AaFgFViRVzToJdJyoQIXH88HJGiBpBiR+T74HN5xRwkThz
        dzHUfE2JF18msUDY4hLH7t9khLDlJTavecsMcqiEwAE2idUb+4AcDiDHReJ3VzXEY8ISr45v
        YYcIS0tcOmoLEa6XaO14wgbR2sEo8XnWUmhA2Ets6drOBjGfT+Ld1x5WiF5eiY42IYgSD4mL
        a64xQ9iOEqsbQcEDCqtGJol/K2+zTGCUn4XknVlIXpiF5IVZSF5YwMiyilEstaA4Nz212LDA
        RK84Mbe4NC9dLzk/dxMjOIloWexg3HPO5xCjAAejEg/vhgsvIoVYE8uKK3MPMUpwMCuJ8Bru
        fxkpxJuSWFmVWpQfX1Sak1p8iFGag0VJnFd0/bUIIYH0xJLU7NTUgtQimCwTB6dUA+OGz4/X
        1qwvqdda/YxJfXOaoIJGz4Kjv0+cbr2YJWnbH6z+KO3J/H65fKNz926nebItmB5pdrfQXM29
        7KKxxpaAok+WV5UTZK3FxPduniTmd3h5XG9m1cvNke//TV6u9TvFOD333xu5lpX7T7zaPDWo
        VUhg5qZPxrEly4/pz7fYc3vpUYXEvZ1KLMUZiYZazEXFiQBOvLlzHgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t9jQV2mGy8jDWa8NLboutLNZNHQe4XZ
        YvPtW4wWH2efYLH40dLD7MDq8ax3D6PHxUvKHn1bVjF6fN4kF8ASxWWTkpqTWZZapG+XwJXx
        5i97wSSOijvLHRsYH7B1MXJySAiYSNx6+Yq1i5GLQ0hgHaPE5OVbWCCch4wS56bvZQapEhaw
        k3jdf44FxBYRMJB48fA8O4jNLJArcXzvByaIhmYmiRdXVrGCJNgE9CTO/5oAVsQvoCVx+cc8
        sEG8QIMm3vkPVsMioCqxYs5JsDNEBSIknje/Z4WoEZT4Mfke2DJOAReJM3cXA83hAFqmLjFl
        Si7EXnGJY/dvMkLY8hKb17xlnsAoOAtJ9yyEjllIOmYh6VjAyLKKUTK1oDg3PbfYqMAwL7Vc
        rzgxt7g0L10vOT93EyMw8Lcd1urbwXh/SfwhRgEORiUe3ohzLyKFWBPLiitzDzFKcDArifAa
        7n8ZKcSbklhZlVqUH19UmpNafIhRmoNFSZz3dt6xSCGB9MSS1OzU1ILUIpgsEwenVAOjwxFF
        w8vWlelh95etPmv9dLux79/tHh9e7/PPMBT2ljVZ6rl46Q7mlYmaKgcb7k+q3J6+ncVyLXNZ
        mvKhL7F3V2WcFjf547ntd/UUoXixC8rbvp0V6lh6Inkvv83S4Jmtz65INplvO8gr5nJi+/n8
        H/7Lph77Zfv1jodinllX2hTxsGMKj32mKbEUZyQaajEXFScCAP9vQrl4AgAA
X-CMS-MailID: 20171020110330epcas1p20ce56b13897b7a74358946346048457a
X-Msg-Generator: CA
X-Sender-IP: 182.195.42.142
X-Local-Sender: =?UTF-8?B?QW5kcmV5IE9rb3Noa2luG1NSUi1TVyBUb29scyBMYWIb?=
        =?UTF-8?B?7IK87ISx7KCE7J6QG0xlYWRpbmcgRW5naW5lZXI=?=
X-Global-Sender: =?UTF-8?B?QW5kcmV5IE9rb3Noa2luG1NSUi1TVyBUb29scyBMYWIbU2Ft?=
        =?UTF-8?B?c3VuZyBFbGVjdHJvbmljcxtMZWFkaW5nIEVuZ2luZWVy?=
X-Sender-Code: =?UTF-8?B?QzEwG0NJU0hRG0MxMEdEMDFHRDAxMDE1Nw==?=
CMS-TYPE: 101P
X-CMS-RootMailID: 20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3
X-RootMTR: 20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3
References: <CGME20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3@epcas2p4.samsung.com>
        <0e396c24-167f-901e-9122-cdc17164ec1e@samsung.com>
        <5fa1f5c6-249e-2aa9-5e9f-c00ebe2c0d9d@samsung.com>
        <20171019174452.hd3c47ocducddvgr@sigill.intra.peff.net>
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
die_errno fits better here as resolve_ref_unsafe preserves errno value.

Changes since the previous patch:
* die is replaced with die_errno.
 builtin/commit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1a0da71a4..b52829090 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1483,6 +1483,8 @@ static void print_summary(const char *prefix, const struct object_id *oid,
 	diff_setup_done(&rev.diffopt);
 
 	head = resolve_ref_unsafe("HEAD", 0, junk_oid.hash, NULL);
+	if (!head)
+		die_errno(_("unable to resolve HEAD after creating commit"));
 	if (!strcmp(head, "HEAD"))
 		head = _("detached HEAD");
 	else
-- 
2.14.2

