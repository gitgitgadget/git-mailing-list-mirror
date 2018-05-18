Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02B11F51C
	for <e@80x24.org>; Fri, 18 May 2018 19:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeERTsI (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 15:48:08 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:33373 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbeERTsI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 15:48:08 -0400
Received: by mail-wm0-f44.google.com with SMTP id x12-v6so4622939wmc.0
        for <git@vger.kernel.org>; Fri, 18 May 2018 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ePVD0/U2OdkBGGJsl5XvHLABy8FBfigjNzJFs8YfOC0=;
        b=PCS6a0Ve9F7XnAKTDX2fiYWLiCzvaWKIYU+CDRQyLYxUWf/Mk9ACj9yx/Mj81UCc67
         3bWIPoV0yVjP9h8Ez3HxmCwL7FE+Wz9wZMqfBf6BcvDiIN19TeKH1mhecMfn4NtffKoC
         7LmmhAe3PgKJa1WcDPaCsVwW+/ymBJIjqNVTcMy1HrCav/uwrgdVx1EQXBbeX0sY3Vgr
         B4rbvBAx2ckRgzseBmPQ8jYsSFlzktrUNHDxr7N7RQ/Pf6AELfgnfxQflUxuJrtFCmID
         gPsUFD65ajbgdMMySzu3rQT9eqFX12mh4tddZDcD+LGH/Yck9p/nIpc0Yz0u7zYa91C9
         mzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ePVD0/U2OdkBGGJsl5XvHLABy8FBfigjNzJFs8YfOC0=;
        b=O3jwAj7t+CaOAOaXn3H4g+B3BDh2MY5iXsx3c0fLLs/YimLu0v4/mGFydBPnpI6WLx
         KFn/oQ1pcEh8xadJNgANeWYtAcEvSmhyN2LMgGrDXMtYKxJm+4+UUtEpmKZGczfnmJGe
         Tf1eBWO0peEG0V7qh/91J8KjpNYlbD6QHK2xWIvzq7H5GQR4p8d0CZTX5RT+UCabkszk
         QKvmJZEQ+bI8nFOSkYq0D2Qt67OkQFK+GocfEqn6Ig2xwjkfhMFqfwKjTMYAfLjnFLFS
         /XTyFfs9brKwtaUunJhD/tQyc5ythffbQ4dXxuzWn+T+8r0+0oqRR3EMT4j5z9LV/ORO
         4QRQ==
X-Gm-Message-State: ALKqPwdyVfGzlHEsJUY9mRiHwiGWLYzm6qS0wL0Z9MDXTbYPAIkbm/+Z
        eGVuIonSxWjvqtNNPfauHd8=
X-Google-Smtp-Source: AB8JxZr0sCHo4GLaPKaXkZfYvCOZvMiMdaDvVr1YIg+K+7nFp60a6BFmZJ+iZjkzF4bdJvJv8x5wRw==
X-Received: by 2002:a1c:9015:: with SMTP id s21-v6mr5239704wmd.75.1526672886986;
        Fri, 18 May 2018 12:48:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8071:b6aa:7d00:445a:d637:6fb:6000])
        by smtp.gmail.com with ESMTPSA id z63-v6sm12585270wrb.34.2018.05.18.12.48.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 12:48:06 -0700 (PDT)
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        leif.middelschulte@gmail.com,
        Leif Middelschulte <Leif.Middelschulte@gmail.com>
Subject: [PATCH v3 0/1] rebased: inform about auto submodule ff
Date:   Fri, 18 May 2018 21:48:01 +0200
Message-Id: <20180518194802.28355-1-leif.middelschulte@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180517184008.25445-1-sbeller@google.com>
References: <20180517184008.25445-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Leif Middelschulte <Leif.Middelschulte@gmail.com>

This is a follow-up on Junio C Hamano's comments [0] and Stefan Beller's request
[1] for a more explainatory/elaborate commit message.

[0] https://public-inbox.org/git/xmqqk1s474vx.fsf@gitster-ct.c.googlers.com/
[1] https://public-inbox.org/git/20180517184008.25445-1-sbeller@google.com/

Leif Middelschulte (1):
  Inform about fast-forwarding of submodules during merge

 merge-recursive.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.15.1 (Apple Git-101)

