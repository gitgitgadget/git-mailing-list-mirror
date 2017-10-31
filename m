Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0A1B20437
	for <e@80x24.org>; Tue, 31 Oct 2017 10:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754201AbdJaJ61 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 05:58:27 -0400
Received: from mout.web.de ([212.227.17.12]:59808 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754193AbdJaJ6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 05:58:24 -0400
Received: from [192.168.178.36] ([91.20.50.251]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LcPSk-1dTIrN1h8I-00juIj; Tue, 31
 Oct 2017 10:58:19 +0100
Subject: [PATCH 2/2] sequencer: use O_TRUNC to truncate files
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6b8e2a79-302e-7e69-00bd-f4643d5195af@web.de>
Date:   Tue, 31 Oct 2017 10:58:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:iFHhYTqLxfem+bJyi8wd8P5q3RpWNRMaTSCS12u52P+R8qGZurm
 KrOrk5eJ5Kd5H790DaAuDw5mzjUUeT7pFp4LJiRskYSGOTB2j6Qxm5yy1yxlx2xrXZmxyg1
 185QTxn7IdkhpIkv9t4GSNpygl338cNGM/e2cNzkpOAcNJRzplfi3Mu6J6C4EXWCHt34d/b
 Z0Yuw49N5kKndIO6w6/dw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NY/xjOXTETQ=:2VQpo6wyqjCsQXKK7A+SaJ
 jYCEYtJF6AVRXwBvt4hE1QeYAJy83P8Wo5VmPjpcQFlag5Kv/vcCd3QBj2pYbux8Dknxwm6kL
 sayHjoJ3F9axDf2YfR2ODIcSBqc9kvymlWlgMUf8MGziNO2riy3GlwvcuT99rAW/wahmI6DDo
 Eiw1FKB5xoc7vy4XpVFQ+CGcEBm/8NAsIsMuNieeyg079iaNWXiBLPpXHaTGtuVrMXnA8x8lU
 mVZItYlqF8UzHSPvXBv+zsbp/Upx6Jgu/bXHaPBViF92e7Ba3NnH6xjOJY1P8fIQo4Auo/WMX
 aaocKW0ymkL3smOA7/HhsAvjYwbJDDk5wlSgOsjPoqyefUtnGg5vpa744zMY53rcybY7sOvIj
 lx0HnoJKOapJYIX3vTktJFulSbDZHTlSMKT3sGmk2BRyv2PyptP+TZlzjUHqbUjZxwdT892iC
 2SPxXV4/4F6Tftda1W7X1aXNEllelUFKNL2NC7GSoajZQA46mvvpJjd+bmTzIHHybx1LorL44
 84k5SkAsP6TlDuNeFHZhg3os141ga27mATxjKjy2Wh/iNzCMyHBMd/oGAfQwcXRKBg7tM6uXn
 6/ZwJLss1rZKJmuxe8bMKu9ntiJ6bpJbYl3YRM4jdBeHmvtI/7scQQrSOnGtqzRfsuKlj5NU5
 9S0wGJu+c0T2C0GanLB/xuf7cRtx4uy+KzRXUCtqq7o8CwH9qmk6j60WPOjIiDdEmoS3vl/9Y
 7FFS/x14v+tq+U+J7/IPvTGDYAEAk3WUbl48n9eU2XCiiR13ZcLiBDi9SaYpi5uIsfzdst+bT
 /Fu7s+DWF9c44OmDnzPJRmDzu5ICsvCoEmf//VQz4DvhBMDYtM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cut off any previous content of the file to be rewritten by passing the
flag O_TRUNC to open(2) instead of calling ftruncate(2) at the end.
That's easier and shorter.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 sequencer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 17360eb38a..f93b60f615 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2668,13 +2668,11 @@ int check_todo_list(void)
 static int rewrite_file(const char *path, const char *buf, size_t len)
 {
 	int rc = 0;
-	int fd = open(path, O_WRONLY);
+	int fd = open(path, O_WRONLY | O_TRUNC);
 	if (fd < 0)
 		return error_errno(_("could not open '%s' for writing"), path);
 	if (write_in_full(fd, buf, len) < 0)
 		rc = error_errno(_("could not write to '%s'"), path);
-	if (!rc && ftruncate(fd, len) < 0)
-		rc = error_errno(_("could not truncate '%s'"), path);
 	close(fd);
 	return rc;
 }
-- 
2.15.0
