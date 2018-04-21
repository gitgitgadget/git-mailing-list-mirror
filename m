Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 033BC1F424
	for <e@80x24.org>; Sat, 21 Apr 2018 09:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbeDUJqi (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 05:46:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:33871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751008AbeDUJqg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 05:46:36 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MF9WR-1fBFCH2fyV-00GEWi; Sat, 21
 Apr 2018 11:46:30 +0200
Date:   Sat, 21 Apr 2018 11:46:12 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 01/11] argv_array: offer to split a string by whitespace
In-Reply-To: <cover.1524303776.git.johannes.schindelin@gmx.de>
Message-ID: <6ec155b834768f38765c63907a48b1bd7ab6bafc.1524303776.git.johannes.schindelin@gmx.de>
References: <cover.1524262793.git.johannes.schindelin@gmx.de> <cover.1524303776.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:g3RptgvhZ+g0oTgcpvZGJ8bWaeCPvij0BYJACucBe3G/ETa551E
 KWG2PrNLFtpFjAi2xi8N1+0mxevASU+mNrK4fZud5d9vxskYpSO3ARdu7xOGYkaUFVVY2PU
 KtcPZAd8B30/9Moil94kyDk+lyH3QNVjBhVEJrQAUVeTUmQ3mSUXmyFNZqIwmpU6Of/Iwag
 fYR+JvN2zwLXlhb+gjp4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zP4E8DH8Tsw=:+P5+COENz9VfEFj/PXZQQ9
 M8rSHQz8Oiz6Stk181TWJZi372nmVJf9qOOPDiYyc86o6CR6CLjBT53wYpuOWagXCEc20M6Q4
 H5TuWsKMVJuzPiO7MGnF/UxrnJpJVuYfvFoHxt0iPnUrTR24uIG+79SrYQC9zMLox9QVpm2lB
 n61itXuXqVS7AwUMUxlGeAXvP81fcq64lZ4J7Nzq2uyiWqklIafVkJVc76bSSlmpBs/MJu0HA
 kZnaAZxwHmJPDpPMzq+ewZSGtoAk4Y1L7evH+WW/IE4K21pBvoWC7rtNx/dv4gM0azWZOrjes
 Lwro22W8nc+fhgMs3qjjZUEU+3oHNxbkxw6l8QSDYOxO9bGK0te2WomHU6oDcWDx8EXTVQPGu
 BVMqimezobElaq0W4SrBfE1dPhMDcOXSmpFnG/aC8PrkCOVhxYd1FyKWTcK3E48infm+R4tmc
 fiP2g7p+VWXxQ8noTYU382tHY1WYpmskaeeohIJQBGxrJrsMZ4HitvMYOggx7SdiTZ2c/9Nph
 IxTaP+4rKHGtAPeRTAjI+bHh9biNYZZOM9cEoTeDqs2JSYhJGHhfWyI6t93J8F4PVzRnntJzc
 fLM7yC10NISLZoJjEperoFuywDi1Utc/PNzTV4+SC4zEE7aK6CQ8SiY6aeEOWNYvVlgVw2Smp
 UVoB0Ai6y0rO2B07r/nNKZ09EYjIb98/jaHi5ZDhXySPeuzfJT2CNIZI70PJjtgYppxETbTGf
 yPUzV+sedwPzxGAqB4N2qz5+5uhiKkuwJ9/RbbsvDvwcpVHDBraS044k/XAX2ICaS3LpvihxA
 rY5U4wUaQQiuVe0Wk0ar5pnaoo2niW8OzYRH60axtXiVbcIocs=
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
2.17.0.windows.1.15.gaa56ade3205


