Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B18021F404
	for <e@80x24.org>; Mon, 29 Jan 2018 20:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932547AbeA2UTg (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 15:19:36 -0500
Received: from mout.web.de ([212.227.15.14]:55342 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754247AbeA2UTM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 15:19:12 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0McFcd-1eMo1y0kR5-00JdZf; Mon, 29
 Jan 2018 21:19:01 +0100
From:   tboegi@web.de
To:     lars.schneider@autodesk.com, git@vger.kernel.org, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        --to=larsxschneider@gmail.com
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v5 1/7] strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
Date:   Mon, 29 Jan 2018 21:18:59 +0100
Message-Id: <20180129201859.9226-1-tboegi@web.de>
X-Mailer: git-send-email 2.16.0.rc0.2.g64d3e4d0cc.dirty
In-Reply-To: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:kNLD68YREnj6NoYCLcXt0Hfbt2IhvOAGpfP/kW5TOI3I+6lkGIV
 Yx2zwYgbm3ILdN+RCq0jONHfvR5GJ6CawXo23kNIar12L4ZpzL7oErY/XqbV+p/CDkfDr56
 3QZmwDgOvyzYtWWGm/UETijrRV6pSLnEUCSLCZPMp2TeSez95L3l6QT3Q6y+AGAPiwna6s3
 /e6RtFIdzpfD6UMrvB7og==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tLlSnYxHd4A=:OzEG2faEPzmwFCLcFq48s0
 KdJMwwZId9j7YNyvykiTB4nTBURXy6e0Z/FAo/dWKHY6FqRjGRRsmR+gD8DtCeOydPVfPJmjG
 WMChqYfqrxNIAApaYj27xTSIs8Omg4F4ZwiOLpnvL4GEk05arunQi9UYER3bZU0ypytyyKvhI
 YOlpuV8iWWif3Vzkk04QhxxQO9qkA1vIoDxkqTlLbKOwahFMLYH5o6UWKAQ7Ux9ibK9Cxvvsb
 9t5VIPAO4WmQgOI/KIWPf9l/00bEY/WzUz1o4xgPnkuzvw3UEDIkQEBVcmmx/E5U0luhEldX4
 9GjRJ/nfTc1hDeGAplDAXkFuSAMYk8NzX/fBP0umAlhEh5pHxPv/lRxxkAj3aMc3Okv7lNqjh
 AywyY+NDJFdWfFkNZ/0x/Dqwae+MFI7QfHF8uu7WXl0XOA386GLFhYjBjcunMDe43swyhaAls
 QFL207MUUCa2o+Kd/iQCmbXoihVKlJ01ZnnjqAqgFZx+HRSaywx0iJZpON5p8T1+TRuvDNpRd
 5sfWhcV9XsjajdNca8Sxmn8wPDf3Krq1e/NdC+9H+vaTCfca+cyTWkTG9MGaEfdNqSt3Q2pXK
 YNOzF3UT9CQ0j7yrEsyeUT7CCUUNEjJ/EgHGqBbWbYeV1j5t/vSvQM9qiC0KlaC1dPrUVUbqm
 Gb9MCW6VIULID5tstkDXlOAmmFo4jthJ9DxFqV4sNxWbL1dej0YlaXPbeczjeniiFG4d7bzjg
 xCTBo8TZFkuxNyAptXCBTuJJajuz55G/jchGwb4Xgc6wzffyQAkCnIfU4DqK9bhgG5FYNIiRc
 y1ZXm3azJvoF/U5XeSuq6OmDlfCi0avizcCqQWYTu6rCmZahAQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Since 3733e69464 (use xmallocz to avoid size arithmetic, 2016-02-22) we
allocate the buffer for the lower case string with xmallocz(). This
already ensures a NUL at the end of the allocated buffer.

Remove the unnecessary assignment.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 strbuf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 8007be8fb..490f7850e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -781,7 +781,6 @@ char *xstrdup_tolower(const char *string)
 	result = xmallocz(len);
 	for (i = 0; i < len; i++)
 		result[i] = tolower(string[i]);
-	result[i] = '\0';
 	return result;
 }
 
-- 
2.16.0.rc0.2.g64d3e4d0cc.dirty

