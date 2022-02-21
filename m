Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE59DC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378474AbiBUOxA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:53:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiBUOw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:52:58 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0712B140B8
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:52:36 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id q11so3263990pln.11
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+bX2linVO3fId1l3q7rhKbQKDeA6oVrlxLVwOwCLyc4=;
        b=l7aID61FDRBrwxjlOnWYPpFCVt7XqtMJGKXT8u0IVkzCPnL66EBolQ5I0B5VNTqdRk
         UGn54Fz9q9MQwf3bXu5IE17qyHHje3Fdl79edWOBNFan1GEARQ+kSGSVpDKRg78i2XXe
         PB/y1VmsLx9Q5hYkh2Pqh28REJLJI+BnvdNDQpRA4LHBl2U5kSeRQCZTrL+gkBeNh1ez
         X4Zw+WwyfLFm3rJGoI2LiTqSIaoIJoP2UT9Fi7+fLwIa102uhXXHHfRCbJ+oKkvziP8B
         ehDj3uNE7gJhZD6us/+Y6V0fvR6onDdg2N+gwvBxqNWXJT7Yt/8zZwv5se5yksnpodeG
         /+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+bX2linVO3fId1l3q7rhKbQKDeA6oVrlxLVwOwCLyc4=;
        b=ACSS0WXxOgIcpG7Qx3zk8Dux9VDbKLg0pXnYln4sRvLWDQ1HspYQvC8WeVmAB4jgAQ
         Xum5AJimb31hSelGsXJTY7SxEblKHM0FPHl7s4/zCNWirvjrpSpjB03QhavC253Op3eN
         ykPU/pi9tHxzGwG0lboT7HLPhOr7wi+idJJZmDiPvZLFR6oCwdHWmQoJE+oPfY09Xl0r
         J/bRfXN5fSJ2+E50sgcRax2LcjcebkW1E1jgSb243px24b/1YYixOtYvCMqNza/Pj5Vg
         H8bAbpB8dx3SRN4QrVNvzlQBr5u1jcv3vIjxOCxxcSbn7WShqUvxDgOoipoCfD22gGXz
         5w4g==
X-Gm-Message-State: AOAM531UXMuvMFOxMMK6SzH+OuHocBgFJzmvchhSZJ+rPNcWcYbXIi4N
        SO9sv5NlgEqYPJdGtKJJoufnZ5IGmVnKdg==
X-Google-Smtp-Source: ABdhPJymFcE6mqD7ryQfVpHKuVbx7rs8VOUqeFuwbGQlWdi+ZfBmgOH+WH/PTvLtPvLvGLi123Yn4g==
X-Received: by 2002:a17:903:248:b0:14d:6aaf:2c22 with SMTP id j8-20020a170903024800b0014d6aaf2c22mr19266605plh.72.1645455155396;
        Mon, 21 Feb 2022 06:52:35 -0800 (PST)
Received: from localhost.localdomain ([202.142.96.14])
        by smtp.gmail.com with ESMTPSA id ls14sm8257081pjb.0.2022.02.21.06.52.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Feb 2022 06:52:34 -0800 (PST)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] add usage-strings ci check and amend remaining usage strings
Date:   Mon, 21 Feb 2022 20:21:46 +0530
Message-Id: <20220221145146.6224-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <pull.1147.git.1645030949730.gitgitgadget@gmail.com>
References: <pull.1147.git.1645030949730.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello reviewers and community members,

This patch request is not reviewed yet (i.e. no response/suggestions came about this patch request; most probably because it was lost in the PR ocean).

So, could you please review my patch request?

thanks :)
