Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C39BC00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 14:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbiHLOoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 10:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiHLOoV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 10:44:21 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6507AB418
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 07:44:19 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id f28so1145581pfk.1
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 07:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=6mwq9UFytambkBOPr/0FPGcyCVIPr9eOY2nzN6CaYcY=;
        b=LRudb5zR0ER+FkN4Ejq7/2U9RTY8Zj9ATdFF82WLomLBI7a7R0kwSlZin7X8WBg8uw
         vdZRXMSoJZkIjABuORpYwtqPDSiyaR+jo/sjKX+QJl8sbg/yqC/3G94WWpEc7qgZ0+PY
         roJAgN2IPHA2re98X8iyZILfTUpefFs4rQE2iY0guqx/5/952GRi68LhimBYQEL2/J/l
         iyEdF2VMnHfks6lmqDHT/Lktx6Ih4erla9AIYRyWmG9tIZxe+FJpmrCFs1JWSKwvX/9+
         IPoQy1x684Yk1hB/WTdmj7ehZm5ZhvbhN35+yviCPTzaO37A5wu2SHMbPYEWWLon6ocu
         9jtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=6mwq9UFytambkBOPr/0FPGcyCVIPr9eOY2nzN6CaYcY=;
        b=qrwvqf+uCbT3F6YQy7Bl8uW++mtPK1KWDERvX0vx/7Gq86bc75T1iuvlVbBswevZkm
         WlVOjZm6tlMmBHbMjmx+4twYhygkPvsesVtipBd6GeAe6zn9mullo5f8HCMPKEsnGef0
         MMmczj4f9r9zVLU/zgEuLc0BcNOZUet8oQcrZZ3IrG890KDnHe5qrXLueWWa2vvzFGLQ
         nlWX/CuTWnRHDtwpVnGxp9hBCFxO+g8gzFs0QhCqQl7MkdyqWkDalzC2LOhW989Fkt+v
         bZBryhzHIP3CZCO8AkZrGk4sy2Ci8yBVk4RR+esDPuFuz+AwXZh5FbVLKv9bbKl3krSb
         p9pg==
X-Gm-Message-State: ACgBeo34uyzy9neQUHf0CBxntthltK/P4EzThWqWA50x6c85LJLOpTxS
        g2Yd7l3WStj2TyE48v2SdG24BlTGBbY=
X-Google-Smtp-Source: AA6agR48d2kwDGDnvPQkV/ZoWh8s/hNNEqAI6fqzgcylsvazgSaD4LeTsKoEpd25LdcH86XEODnRFg==
X-Received: by 2002:a65:6290:0:b0:422:4a8f:c687 with SMTP id f16-20020a656290000000b004224a8fc687mr1895999pgv.57.1660315459089;
        Fri, 12 Aug 2022 07:44:19 -0700 (PDT)
Received: from localhost ([113.172.46.62])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e5c600b0016d5626af4fsm1887844plf.21.2022.08.12.07.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 07:44:18 -0700 (PDT)
Date:   Fri, 12 Aug 2022 21:44:16 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Renato Botelho <garga@freebsd.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git maintenance broken on FreeBSD
Message-ID: <YvZnQFVMZZmz9TIX@danh.dev>
References: <226317ba-a78f-216c-764c-52f4e393bd35@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <226317ba-a78f-216c-764c-52f4e393bd35@FreeBSD.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-08-12 10:51:03-0300, Renato Botelho <garga@FreeBSD.org> wrote:
> As reported at [1], git maintenance is not working on FreeBSD.  I didn't
> find the time to dig into it but it seems like it's calling crontab using
> parameters not supported on FreeBSD.
> 
> [1] https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=260746

It seems like FreeBSD's cron is vixie-cron which requires <file>
passed to crontab(1).

     The crontab command conforms to IEEE Std 1003.2 (“POSIX.2”) with the
     exception that the dangerous variant of calling crontab without a file
     name in the first form of the command is not allowed by this
     implementation.  The pseudo-filename ‘-’ must be specified to read from
     standard input.  The new command syntax differs from previous versions of
     Vixie Cron, as well as from the classic SVR3 syntax.

I think other crontab implementation also accept "-" as filename for stdin.
At least cronie, fcron, dcron, and busybox's crontab both supports "-" as stdin.

I think this patch can fix FreeBSD's problem:

---- 8< -----
diff --git a/builtin/gc.c b/builtin/gc.c
index eeff2b760e..45d908def3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2087,6 +2087,7 @@ static int crontab_update_schedule(int run_maintenance, int fd)
 	rewind(cron_list);
 
 	strvec_split(&crontab_edit.args, cmd);
+	strvec_push(&crontab_edit.args, "-");
 	crontab_edit.in = -1;
 	crontab_edit.git_cmd = 0;
 
---- 8< ---------


-- 
Danh
