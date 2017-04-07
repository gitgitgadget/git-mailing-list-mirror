Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8986220966
	for <e@80x24.org>; Fri,  7 Apr 2017 15:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933013AbdDGPZe (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 11:25:34 -0400
Received: from mout.web.de ([212.227.15.3]:58788 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752433AbdDGPZc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 11:25:32 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MYviN-1cZjgb3bnP-00VfeD; Fri, 07
 Apr 2017 17:25:19 +0200
Subject: [PATCH 1/2] add MOVE_ARRAY
To:     =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>, git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <295981e7-d2e9-d3db-e32d-8dd80ca47136@suse.cz>
 <20170406083425.7psdmrploxar3h6v@sigill.intra.peff.net>
 <998bf391-7fc5-8329-db58-ef0f24517707@suse.cz>
 <33c63fb9-281c-8fd2-66e7-b85f62f4f447@web.de>
 <8555c61f-2617-eec8-6dbe-87c79c6ca302@suse.cz>
 <587b0cb9-bd66-ddf7-5cca-023df3470883@kdbg.org>
 <e392e05c-2815-8cfa-eed0-bd990f8ce954@web.de>
 <357d045a-b1c5-1a73-2256-839efb543fe3@kdbg.org>
 <96beb4c6-0569-0c12-8151-462c20be6a2a@suse.cz>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c4c60ec9-641d-fb2e-046a-91e08615c8f7@web.de>
Date:   Fri, 7 Apr 2017 17:25:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <96beb4c6-0569-0c12-8151-462c20be6a2a@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:hYtIdmzxLcHJ7yWQeIBy0IT+0xfVIYp2CSvoZB789xhXf3nJdh0
 MQNhsmLdbt4F1y8w+V1iJ0W43Ob5MI+7XPGX4KX7Ys+83H9TlvjTyHZxjUok5ma04upGiHD
 ZFXqwlw67ErHe0b9FmRqxHLSpV7e4G0kB4/uMzXSK7C3pdVlVbLsTRCNXj+kik6Cfl9lHLm
 Z7VM0bwwVbx3ESgIfWiJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/4QRPkrhK2E=:csbkjNbol78mF/dQVrff9h
 4SMKObU2AmcHXGKp+/D/L65bph9qsyzNQrXhyMhjw1dZnxHKIav6S5KGa1j+h4y88Q/qupbyf
 CNoX+20Qr85vTl3fLk1cZSPyxlgWqNriaFjZIzitQdjtu0bKWBTPhJ36Dkg0qQv+/v3LNBDnh
 dChPts6ilnOx75TUMFXbdY1QMioqog6+jX1NobXBN4thW2GnvUDVwx1mPL8Ki5qH9f0+Ayh5t
 FsGyDZKul+hwGJhRdsLGr9t/dK1TjRd5h8t2j51LMkP0waidNdlBZM4jNiLINLxe6QPmPF7vH
 FmSUUYhAAyJzG7ENpL7DzmwZtgPyU8+RtqCu4YHrxdCw6fCq/k5mBfIn/V1FFu/wpJGNGBF6L
 ivpgbQfQdg4kcmzwDxrWzdjXN3kIDyIea6hEiU8ioku7AnUo73Fq4KsvUMGZoMW4Xb8F+cwGv
 fBr/SH6fTci0eJiDWwmcVcyLuntYMA3LAwOeZuaZgPtKFeojkDomZnqX4ivPWMHAwVxCycDGO
 kRCgohJJGkeGYEW0xMprPFZl4sL5iaW6ZH6MG+y6muJm7XTZkp/dE+1FSP5evKMe/kKnVtVet
 l7ashyWrLNMOuppUVWcbY/B23P2Qf2CiN+vWBkFnkgco8s2e/XzkKhpbQvMA07PLkVAQNZ/8h
 dn3sw/RTeVRoLM1zp1SizlbG/s1pI/CgrNdAhUHdFphLj/IzJQeQdzagVxmo2ob12qa2dJCBp
 p55rmOWBw8Hb4BjMiK2lRo/202vDDbx+Pt+dz0KIv4BhHsKysVWj+pB3Uo7ZRyqRFYYTT78MH
 utR5COp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add MOVE_ARRAY to complement COPY_ARRAY, which was added in 60566cbb.
It provides the same convenience, safety and support for NULL pointers
as representations of empty arrays, just as a wrapper for memmove(3)
instead of memcpy(3).

Inspired-by: Martin Liska <mliska@suse.cz>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 git-compat-util.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8a4a3f85e7..3266a71fb4 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -812,6 +812,14 @@ static inline void copy_array(void *dst, const void *src, size_t n, size_t size)
 		memcpy(dst, src, st_mult(size, n));
 }
 
+#define MOVE_ARRAY(dst, src, n) move_array((dst), (src), (n), sizeof(*(dst)) + \
+	BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) == sizeof(*(src))))
+static inline void move_array(void *dst, const void *src, size_t n, size_t size)
+{
+	if (n)
+		memmove(dst, src, st_mult(size, n));
+}
+
 /*
  * These functions help you allocate structs with flex arrays, and copy
  * the data directly into the array. For example, if you had:
-- 
2.12.2

