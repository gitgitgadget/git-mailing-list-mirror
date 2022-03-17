Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F579C433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 12:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiCQMin (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 08:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiCQMim (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 08:38:42 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031D61EB80F
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 05:37:25 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id bc27so2561138pgb.4
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 05:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vv0aSjS/k0IglFkqUaINE8TvxUKsSX0FG1XyAU6hlNY=;
        b=DEYjIyS+NScN7EN1UXSHvUabN0/tO2uQCtNJo5L4rRvW7O6BIpCIyxL4acmDi91JBi
         xCJ+vRgmBYSfHW8D1aQ9t3HUX6s2wOsoI3WECEgNaop2daqx5d9E66CMK4KSZpAjUXCS
         t6HhIUxfeGLj074QQKnUYGN65bh/8LH1XFFsy0kcmeKlc1ZxAyFNXBL1Mcntt9xjY9kl
         7C9L8mm62A8jSgz9clHa/ZM6PNkHzn8qil8zuvexTJbXV33g+zbkUalm+N2OJ+gLQ02u
         CLTL1Po/vwJeLvVa+QbrTUzfNCYwLMAYJ+NrMvvm7azBlUGJzJ/e4x1aniDaCu6+Qr1d
         +bMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vv0aSjS/k0IglFkqUaINE8TvxUKsSX0FG1XyAU6hlNY=;
        b=ahjgVWOr72+6rkGPcG+T/2zR+yV5bdGLE2EUH9dZti4kvYHGbp7A+h6LjYWkjAXuEa
         hBmh+FhDj6IoUB/Cotxhl2MULtVjaq1VSo7+MM0P1udebVvEjYqX2i6Pv1KApXtJ2gsK
         9hoe+xoxQGYx2J0FseQAyUuyYIlOcbk4BIKo002h7KTIL5NCHaQ6Ct3feWbx9GcFsLkY
         T6oytZsGT/N2hmccjo98LuR7vCn1wiycjh2/MQIBm1B2gGW9XnmGIYBhtkc0QqeGm4uq
         k8Bk99Waasm8kYLUvj8fim2pQMYPXfeJZhvu+I/YuDIwNLd9NMoBpamYRegItjvcmtxX
         +EHg==
X-Gm-Message-State: AOAM531Y1xmySmQabqiQnPuv/P6qSSsLQHf3J9S6BM2QvLxOWOiytTmd
        iNz/G9QJAsOyB71XyvT8LAs=
X-Google-Smtp-Source: ABdhPJyY7DgqT8Cf1sn9a5gj0GOvaY4RGvW+rNu3nptzakym52VCY9ZtGyITUahlsSy6v9BNvCB1wA==
X-Received: by 2002:a63:ea53:0:b0:341:a28e:16b9 with SMTP id l19-20020a63ea53000000b00341a28e16b9mr3631244pgk.259.1647520645463;
        Thu, 17 Mar 2022 05:37:25 -0700 (PDT)
Received: from ffyuanda.localdomain ([119.131.153.254])
        by smtp.gmail.com with ESMTPSA id m7-20020a056a00080700b004f6ff260c9dsm7249020pfk.154.2022.03.17.05.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 05:37:25 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     derrickstolee@github.com
Cc:     vdye@github.com, git@vger.kernel.org, newren@gmail.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v4 0/1] Documentation/git-sparse-checkout.txt: add an OPTIONS section
Date:   Thu, 17 Mar 2022 20:37:17 +0800
Message-Id: <20220317123718.480093-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
References: <20220311132141.1817-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

== Updates Log ==

Changes since v3 (based on v3's single patch):

 * changes according to Derrick [1]

== Overview ==

Add an OPTIONS section to the manual and move the descriptions/explanations for 
these options from below COMMANDS to OPTIONS. 

[1] https://lore.kernel.org/git/307ac60d-b0a1-ea90-8118-a4e02b809102@github.com/


Shaoxuan Yuan (1):
  Documentation/git-sparse-checkout.txt: add an OPTIONS section

 Documentation/git-sparse-checkout.txt | 44 +++++++++------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

base-commit: eb129e532a7c58ea34afeec70b0e2e029c0d5fee
-- 
2.35.1
