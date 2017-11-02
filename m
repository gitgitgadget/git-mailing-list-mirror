Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139E820450
	for <e@80x24.org>; Thu,  2 Nov 2017 06:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755008AbdKBGzN (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 02:55:13 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46782 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbdKBGzK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 02:55:10 -0400
Received: by mail-io0-f196.google.com with SMTP id 101so11581739ioj.3
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 23:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:in-reply-to:references:date:mime-version
         :content-transfer-encoding;
        bh=gCTZCAY5xbd2H0A5jBnHfK6/KxOljr5jZmElaukM1+o=;
        b=kbVSvF6PGzTFQUF/wlcRMmENRMe7brlPEXnq6RkEYONS89pLfgD320qiMc/ZQwcVrq
         uVUosOAhCJCy8rUWdm+r5Gy0coA+TiD9rMibp2IXVvgvEWP81yq3VDPkzJnRnMIarcR+
         cIT54BFq8mn0cfmCvUZnI5uiawkNgvQw5G4GwTPT2AG4dR4AtAq8JZnbuxtnwyx6d5vj
         tflPrAFXVSs9HvlQhEES3QoMBUUzMvr8iggfOQ+S4wsnr6SCwwFqOfyM0iGyvuroAkOV
         sAIVQmKC360gAmhsR/i1Qmoit0K2qcf/peE6s/qJZhgGtCOH8iBzDacXy+JuRPDOWpfC
         fNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=gCTZCAY5xbd2H0A5jBnHfK6/KxOljr5jZmElaukM1+o=;
        b=qZT5oNgAjT+iCIJYQAWXKmeQuCbQUZFxq3SqShvHPPd4X5gysXuGK9jkH4o7HVGNqs
         jvhZBVYw6cDyfKiDUyLYtqUpJ8cqIQtK3Q6apGed5kC3VsdNCQlKvnXu45ezVhW+GKCO
         z5NIQtToH3mj2MTDVY/7H8YEygM9Bc57w2A/KOpcWzdJgGDQrLbtLNm0e2172T8tWPSu
         et8jc4CIU18FfIx+dqxEdcSpZXfHoOyUGAqZuXtBAbYfEKH8rY0pOL0Xz0/xUGFNUGDr
         Zc/ASpT3g2v438F715PFr6B81eILiTWcU9bCXQzYjEiKkLVveym7vRUObITwOPDiCJE8
         hwwg==
X-Gm-Message-State: AMCzsaUuIAsyWD/pUyyRDbTsG9RSj6H/iEd5QbOJ5MlUC7ErcYZCVjPH
        4VQryhxU9UGoRSIpuZDU6amUbv7EDyg=
X-Google-Smtp-Source: ABhQp+TXASnD873pkxDT8vJfA7Me9hzQHkEvO5G7veef+DE1gYC2vYMiv1PsVoPTddIsw/66gSDNnA==
X-Received: by 10.36.68.13 with SMTP id o13mr1219823ita.56.1509605710004;
        Wed, 01 Nov 2017 23:55:10 -0700 (PDT)
Received: from unique-pc ([117.245.109.9])
        by smtp.gmail.com with ESMTPSA id t69sm1468827itt.37.2017.11.01.23.55.07
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Nov 2017 23:55:09 -0700 (PDT)
Message-ID: <1509605703.9254.13.camel@gmail.com>
Subject: Re: [RFC PATCH v3 0/4] give more useful error messages while
 renaming branch
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     git@vger.kernel.org
In-Reply-To: <20171102065242.25299-1-kaartic.sivaraam@gmail.com>
References: <20171102065242.25299-1-kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Thu, 02 Nov 2017 12:25:03 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, ignore this mails. I actually have re-sent it to the correct
thread.
 
-- 
Kaartic
