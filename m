Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EE2C20248
	for <e@80x24.org>; Wed,  3 Apr 2019 22:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfDCWAL (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 18:00:11 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:33344 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbfDCWAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 18:00:09 -0400
Received: by mail-pf1-f177.google.com with SMTP id i19so266686pfd.0
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 15:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+OQrPPXAV2h4lAFwy0fm56E+XzdI5UXo33CV/ZPd/Q0=;
        b=az0QJVf7dkZhsWhCHX0IpMAud4qVEaJ9WMdBradQoKiQPzgnYvKU0y3EtXjfNN/emC
         T2Yvp5cg8uO+SVDJSzvk9r3B/410FLbYVBNVHzAMWAKbq8Kfv5gI95yQ1M3WCPEqJEHp
         5LTFKe/Y3KeBexsu/48/7us94EZcczHYqENrKiIS2dVJDhF8SYRa7vL5siS0C4Gvcuq7
         OkcutyDWybR3tFmh5+uMYvxKtcwr/sq6zPuFyA6FYCG0/AAvcZFN3yGfXpTPIFNoO9xV
         wFpYxGZ8Q8gAZ+15d4+DUjE11M1b6HPxTrgPhjEzvvt8BDoFUsU0nc4CdTDLzdo0YbUX
         XH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+OQrPPXAV2h4lAFwy0fm56E+XzdI5UXo33CV/ZPd/Q0=;
        b=M12KChO6s4s5NLby3yEkD1TFc0ugEPtXBpzJYSfyBMbLbo+0psNpXqwrSR7sGTMAjd
         7r3kWKOzKFHpJr2Nd09XyrCjWcp8dXybUiuWYGK7YH+yTKQC5XBmELEGe7+H/EkIsfVn
         6euZgvChQIU3tKDAvxU/bXvTaHyFpRdMxJRhl3GhHkHPe2CMtUFpnAkKXBUHKtU7tPEg
         S+hPTn/2c/UTnCk1LWYW+wU5ONqz35KCfDh0ayeUnXmUjZ2vxKnyq+aT2mo+mwtjbFtr
         5T1j6gcwLclgPwqJlITQHXfPwHkyom1Exs743y28RguQbrPV1yI0pvA/B9Yy6LdAO+wg
         ZvPg==
X-Gm-Message-State: APjAAAUYJq7tds7uKCbu260I8Gm/OrCpKX2v49B3/NKmiQ6/xYIKVSh9
        eW+9y3tPFWjYp+7i5AHAWUG+y1aY
X-Google-Smtp-Source: APXvYqxBN04tp9vWGs8+p77Y47L+LoUblF1bRUI6j2g9rj4EvavrnTdjqp60rZ4YjJJ+W+WX35BjtQ==
X-Received: by 2002:a65:5ac3:: with SMTP id d3mr2175709pgt.168.1554328808113;
        Wed, 03 Apr 2019 15:00:08 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id c11sm26474929pgd.24.2019.04.03.15.00.07
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:00:07 -0700 (PDT)
Date:   Wed, 3 Apr 2019 15:00:06 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/2] cocci: FLEX_ALLOC_MEM to FLEX_ALLOC_STR
Message-ID: <78b6d3f58dc409477e801aa3d83e83ccee3841cb.1554328261.git.liu.denton@gmail.com>
References: <cover.1554328261.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554328261.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ensure that a FLEX_MALLOC_MEM that uses 'strlen' for its 'len' uses
FLEX_ALLOC_STR instead, since these are equivalent forms.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/coccinelle/flex_alloc.cocci | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 contrib/coccinelle/flex_alloc.cocci

diff --git a/contrib/coccinelle/flex_alloc.cocci b/contrib/coccinelle/flex_alloc.cocci
new file mode 100644
index 0000000000..e9f7f6d861
--- /dev/null
+++ b/contrib/coccinelle/flex_alloc.cocci
@@ -0,0 +1,13 @@
+@@
+expression str;
+identifier x, flexname;
+@@
+- FLEX_ALLOC_MEM(x, flexname, str, strlen(str));
++ FLEX_ALLOC_STR(x, flexname, str);
+
+@@
+expression str;
+identifier x, ptrname;
+@@
+- FLEXPTR_ALLOC_MEM(x, ptrname, str, strlen(str));
++ FLEXPTR_ALLOC_STR(x, ptrname, str);
-- 
2.21.0.834.geaa57a21fa

