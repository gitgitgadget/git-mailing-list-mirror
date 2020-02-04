Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE17C3524D
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE0D21741
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 21:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="SivzZHQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgBDVPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:15:25 -0500
Received: from mout.web.de ([212.227.15.14]:49111 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbgBDVPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 16:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580850919;
        bh=1+cqlKfCF5Bd2AYUM+HFWu3EYPEXWSspXtdMJw2VRQc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=SivzZHQ1WZIq4vX7jQDsNLQ9KGeg6cjoV/Ok16Q15PxnApJa/ZI/RtaoGuVq9hBe1
         2I1MzgT1ZTeEM8c3mTFwgGCybp0fzbwqSwZpisTsYgT6sQ5502hKdc1YZJGTCZEFjs
         3SrxEpDrUZv1JqHk0+zzhLfx0oAlhSMsHVEe/4BQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.145.153]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMmwZ-1itpgO35jz-008elc; Tue, 04
 Feb 2020 22:15:19 +0100
Subject: [PATCH 02/10] name-rev: remove unused typedef
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Message-ID: <ea4b51f7-46c4-bd70-1fb7-464512a84aae@web.de>
Date:   Tue, 4 Feb 2020 22:15:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ETwL/66/LAlLcitN1y6xd/o3c6wmLb8D85KS11qLo0jL1w98ovi
 clpDBSkfJFp35Asrk89QGY+U8FBteS0XqPOkWv7ZfXTF65xcQgdKYJuV/PG3TIn12iyCb8V
 MiuUkTxErSlF4863rhvnk39Nbq9hTpBaUg8ogdiP6wVa2igNpe1fFSchH1Dn5UCyN0k2fyd
 Ar95n1f9ZhHy1i4cLUzyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qsI8pFFhIr0=:Fyi1vq+FFfgHS8rbJMardt
 hNN546SLf5bI5BX7jPA1cpKjsx+ircUzuZwVWcXi1c07oIbr2OYGfYfxlzCvzfGU7ZsatmV6x
 Cej1E/YJN6JgF1zR2olnzYHNxI5Fq3L0Yu8sDOw9qpkzs5g71UNFkxkkDd55YuNGHH67HeEtY
 uBBI2yvbSlMnkN4WXGFzj2QCUw0HlvOstqfBLbQHCvLKYrHJxW+pj38yLyEsPAVWm+0Okjmd2
 Wk09TkJooVsJ3Yd2wLyYLyiqQv57W7inBMV6GqQa7To6ELAUjhDc+iVKEjt7cnsb1nRS9oNXd
 GgNXn8I2gZSGAW2QdTy/OiBZxdxROxyzQrd1mOIUoU950T1Bz5hj7cl9exkM/nMeGtbqz56ci
 DSZJ0wEfB9Sjtmr0QsONoyPoayAh/xN9E+6eY48C+aIk68Hw2NnWwm9eEHHfMZHJF1DgbHf9d
 o/OihpRPjxD9jwiloiUR74Pkam0uXIdrgm0/GGPowbNfzJylZersNQ7nDYsR1VTrcDiesJmOO
 xV7P9SGu4sOBIjFBHDTEQKbIa/5XLM6kkk9Er0XobI27SHiW0GMk3TtlorroBXcfZ2OtDZLsG
 ml9+UzcHuM+caYscJM2wO+1TbbDFIs1V+5Euu2bjIh6SrGHkS/i35NTUiSWR3JkLGalJmsyh1
 9iaRh2mknSL++oL2ECMjcZ9/UFm14e/uR+/adHiBg2U0fcSFdJzIn4ufS3qzRtvSw21dh6Ow7
 w6gtaA38QuCMe2VfTpfLRUcTSHR/sza7bri6MoYLdpQJfGCYWujgMZgY7d58pn45hAA2/pC2V
 x69FsO/56ePgCxEHf0a0C2A/GyYawbTAxo6puyadvN53kXNSmHlBzsCDYvlolTZKfW2BoerYD
 Lf+Sz3lZ0+9tYdOzLw8Jv9xQdVVvByMIQDSSb/fiH3/q/UFeh1jlqbEYJNlSVxDoUXfu0R3oj
 mKcnE5R4cDFrWMvBi+hZFPgAIdQTw8HM15hMKQDgueUdjdGLOPNvucqhISNLNjeER4ex2qRDf
 rquMRYK8a7JQS1OKICRHbwGYc1D4ZXVwLAiLrcyg3QVFD0utBQFrVBe1p8r+K3wZN1+Xke4kC
 RO0vd1uG7XH6T93Jl8aaRqAwTEGRtcSRnvyxi02TAab/lUzCEaK9u9vzLEGGW9/0W6Pl9jL7H
 COG0RTMJxHMRV1vy7uJLAJCs1hATiRR3ypmM0C5ZlN363BontTcXJb6Nz8d8+xlMP41+heOFK
 QxNfkl9uEbaJ9FSkF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The type alias became unused with bf43abc6e6 (name-rev: use sizeof(*ptr)
instead of sizeof(type) in allocation, 2019-11-12); remove it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/name-rev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index c2239ac3f7..a8de9cc561 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -16,13 +16,13 @@
  */
 #define CUTOFF_DATE_SLOP 86400

-typedef struct rev_name {
+struct rev_name {
 	const char *tip_name;
 	timestamp_t taggerdate;
 	int generation;
 	int distance;
 	int from_tag;
-} rev_name;
+};

 define_commit_slab(commit_rev_name, struct rev_name *);

=2D-
2.25.0
