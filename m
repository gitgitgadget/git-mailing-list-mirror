Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDB661F404
	for <e@80x24.org>; Wed, 25 Apr 2018 09:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbeDYJyO (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 05:54:14 -0400
Received: from mout.gmx.net ([212.227.17.22]:38641 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751648AbeDYJyK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 05:54:10 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LjquD-1eehSX04EL-00bttp; Wed, 25 Apr 2018 11:54:04 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v5 01/11] argv_array: offer to split a string by whitespace
Date:   Wed, 25 Apr 2018 11:53:57 +0200
Message-Id: <178058d887281fc87e5008367bbee5677a619320.1524650028.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524650028.git.johannes.schindelin@gmx.de>
References: <cover.1524303776.git.johannes.schindelin@gmx.de> <cover.1524650028.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:ysvpbfzG1LO4zrlckfJwhMZqaabZfeMizGOnJz+FXLkxoz2XM/w
 gKD8mbAncpT5AB/vK42a8BY4SJxAgmnGbIptA2U2d0NowJuYqLw7+1CG4M20WK8qRVk1RAT
 ZgxJl5TE1h/wumofGBXQPiD0wE5Vj8IBKwoDq0ktkXRF63xdTbMVWNi+ln9XojMu2LVAfco
 nPqsCplM673R5C/1XMYKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ggNE8NRg73c=:rOHF0KiZTq7nc+dysB95wL
 GRaBEVSxo571pjh+wBrc3OysrFnQUD/mlI+YdDt6M4YCbC0rK6Qng2AOYBvl3A7lqS1c7MqQZ
 /8ZwRfuQdouSmu1/I5T6fx99GCR27MIZXfE2EjWlp0qumNKyC9z5Gz/SkojFyX+c5pp9yTnCn
 SN12QurYtiwnPwhGDPrDlI1tSxpiUHCnbU06zMA4XQI71niH9yWgo9aOO7UPplw9m/tsOayM0
 ctv9HIQeONXL1uBN2PLaYaZKnh9oEXX82HXtrMkKxMpVoV1mg9xhoW4nD+LKcOVd4Ih6+/MdM
 8hVFtqB3QBInF+51V8pz2EIaujgBuAkwwqISjbWiJ2dVPyJKzmei0AoZtvrf4e3fvBx3DxCTe
 MuXvAgvy6Rf6DV/SqTOZouKi2VhtLCHGFMN1qOpgfp0v634xnhsSD2dv90VHMsHERDgBxpLox
 361nxHjukBP0FDlkUAv02YP3dBEBO5eSrlpto4LiNkUZ8sXaam00tLyakLmFWd34VXjv+ANrA
 4Dv7U97fWeqUN0N5vIHzWVHDY+SnXkCvba4kpvUXpjAFy9nmX6ooaTx68w9gIrXWYu0iKDVWz
 VJ27bH9/mw56Zg8s2C0O0HiCADkq0OiVUSrCHUGlkoBskbEeVz863AsIjP+NRFwPfgau3xggZ
 scUdZwEaImUeVBII+bJ0Dc6V9pCThzGBL57lOpi/5agFNMmn85ZZNSW89INwhCSJ3YHgvssr6
 +aAMgEGl8itlRBlTRlTM0qLIPOv/Sj/+FQwNQE+4GQDIURrHrJEnyr0ywoacBPx7wJ+WoLI/v
 N69C5lHxDl93Wzl8juXGbZUYLeqLe787iYTp4aj7rWIHSgLNVQC+m9hFlyIPGygR6daEJ+8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a simple function that will interpret a string as a whitespace
delimited list of values, and add those values into the array.

Note: this function does not (yet) offer to split by arbitrary delimiters,
or keep empty values in case of runs of whitespace, or de-quote Unix shell
style. All fo this functionality can be added later, when and if needed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 argv-array.c | 20 ++++++++++++++++++++
 argv-array.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/argv-array.c b/argv-array.c
index 5d370fa3366..cb5bcd2c064 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -64,6 +64,26 @@ void argv_array_pop(struct argv_array *array)
 	array->argc--;
 }
 
+void argv_array_split(struct argv_array *array, const char *to_split)
+{
+	while (isspace(*to_split))
+		to_split++;
+	for (;;) {
+		const char *p = to_split;
+
+		if (!*p)
+			break;
+
+		while (*p && !isspace(*p))
+			p++;
+		argv_array_push_nodup(array, xstrndup(to_split, p - to_split));
+
+		while (isspace(*p))
+			p++;
+		to_split = p;
+	}
+}
+
 void argv_array_clear(struct argv_array *array)
 {
 	if (array->argv != empty_argv) {
diff --git a/argv-array.h b/argv-array.h
index 29056e49a12..750c30d2f2c 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -19,6 +19,8 @@ LAST_ARG_MUST_BE_NULL
 void argv_array_pushl(struct argv_array *, ...);
 void argv_array_pushv(struct argv_array *, const char **);
 void argv_array_pop(struct argv_array *);
+/* Splits by whitespace; does not handle quoted arguments! */
+void argv_array_split(struct argv_array *, const char *);
 void argv_array_clear(struct argv_array *);
 const char **argv_array_detach(struct argv_array *);
 
-- 
2.17.0.windows.1.33.gfcbb1fa0445


