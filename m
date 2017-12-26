Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D58F1F424
	for <e@80x24.org>; Tue, 26 Dec 2017 09:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750934AbdLZJKo (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 04:10:44 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35035 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdLZJKn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 04:10:43 -0500
Received: by mail-pl0-f66.google.com with SMTP id b96so17607670pli.2
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 01:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yTs8LrCtJGYHIASkgz1w8xIqHAO+UPOtPx8W/f9cpJY=;
        b=fdmHrMIhZU/ONT0jLi3hpadG/KcJOquFvDXhFmLGCZsUg1xW2uL6J4MLmugwvx3NvI
         IAohRerM9uwP/r1m7h5wJekWcjrYjdVcchUUon4w2/4VLbiQnySyslmihEUh9I1Uc6r1
         DLbClDqzw5V62ZWiPidXeZyXIS4oOXIB29r/3nK3HmVmEebu/xYB1Nqrgr/x5OY1uxT1
         Qfn1oz/Hj3wx9FLs6wTRcBC9eCIqO+IsrER1u+GbO/wGieugi6ceGpSX9OtHzf5dHEoC
         Vc/ZYj2xb0f+LylKlOP/H/o2PhtPyrGPEXMLf2MIXKTdb5/3DSqtsO9gOFNIzrSDDNl1
         Q6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yTs8LrCtJGYHIASkgz1w8xIqHAO+UPOtPx8W/f9cpJY=;
        b=ipuMFRkfyaxxuay0N4wVS3JScHi0Hmzm0aW2rR/kdcQzDWNeDb1gnByt9OFvgKen6S
         HcR+qX0u0SLQkFVdAzSTgiQaMjonrGAmCn/hb1uz+OB0BsRVsx7iS2p0prsZlmJf2aiV
         3ZOzL/wTAC8bBlc3TrLogj9uC48XaXQ2mD+iRnrY6nXXQwmKEh5SqTBPp5hY0RCoxbFa
         5XjUk/0YOHGNA1HvcVW/EALiIKJQ0v+lJyltNHvwQIkiV0+G8V74/ZCNLgV8yK+cmFy+
         LqW6Sos1t2/0ilhuZDKAwdi3PZUanwkT3sq5OdeyNgt+l+Psr9Eww4NyEG9DCQiofwrN
         OH2A==
X-Gm-Message-State: AKGB3mJISe6i7jh3TxMs35sgNtFYezIv28fQxEzIFf/Ne/9liH7pXu3j
        igQZ8TU4tYfR8SWChHtbDrFLyw==
X-Google-Smtp-Source: ACJfBovKwcEjsxG8qxgGB4BhbEcagHti7jQfRR+STA26MGjrY+Ufouz9VXxMiSKstNgQ85HPZjnugw==
X-Received: by 10.124.25.23 with SMTP id c23mr24280562plz.250.1514279442685;
        Tue, 26 Dec 2017 01:10:42 -0800 (PST)
Received: from ash ([116.106.0.190])
        by smtp.gmail.com with ESMTPSA id 67sm55445409pfz.171.2017.12.26.01.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2017 01:10:42 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 26 Dec 2017 16:10:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     alexmv@dropbox.com, igor.d.djordjevic@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 3/7] wt-status.c: coding style fix
Date:   Tue, 26 Dec 2017 16:10:08 +0700
Message-Id: <20171226091012.24315-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.0.320.g0453912d77
In-Reply-To: <20171226091012.24315-1-pclouds@gmail.com>
References: <20171225103718.24443-1-pclouds@gmail.com>
 <20171226091012.24315-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 wt-status.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 59338adb8b..db06fc7c85 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -406,7 +406,8 @@ static void wt_longstatus_print_change_data(struct wt_status *s,
 	strbuf_release(&twobuf);
 }
 
-static char short_submodule_status(struct wt_status_change_data *d) {
+static char short_submodule_status(struct wt_status_change_data *d)
+{
 	if (d->new_submodule_commits)
 		return 'M';
 	if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-- 
2.15.0.320.g0453912d77

