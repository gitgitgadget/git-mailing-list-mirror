Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A68CC1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 23:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936488AbeFRXlz (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 19:41:55 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:35757 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935955AbeFRXly (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 19:41:54 -0400
Received: by mail-ua0-f202.google.com with SMTP id t18-v6so6292975uaj.2
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 16:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=EKojsmlqzv5De06BwXao9y/9tt25aR3SHGDCS+WdyKs=;
        b=X7tDu+kSPguHouAUA+gDca9B85kVH3kLbbXbLmezan7CZJi/p+TQALZnjnKBOaVTjJ
         +h8rYVTCaI4CD3rItfYrEaxebyMPqcbyFr3UKyDHjkIrcIEvHcXIbJh//Vej4n+SUhj8
         KAGRJdbJ0+z+gJvz8//soFdhRTcN2JJ5to4JAZltho1/kHRLvclfryIjPBQwIGO7JLW6
         m/tOLAP3KM+ygaQFK1rUuJNE81jQFyjfVuezf8ZRHlP46s/Ch+sVDPk/AyqGy/7arb4n
         kOZKyIHLa33l1lDNhzvHBqr52N4oedxklYQLLkWUmXI3yebSZrjN58+hHDZBghw6wekb
         FOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=EKojsmlqzv5De06BwXao9y/9tt25aR3SHGDCS+WdyKs=;
        b=rDwJSPgNzSk6eawdPcJb7JdR+o8MtjTKQ1DohmyyhwtvcyLfGAYAbnOKKUnRF48OAP
         DQqeFOeeSKw/VFa8f1kDiM/+tw45+0+jy/Z5MXJ7YHy4MGW2/pff6hljcCFT+aAQxBS/
         qdXsr4Q37hj/EePljIEzziSviEwMKF4veXvzgHXmapHzBioCW0Yu/aeNZW+NTwYi8cMi
         lHMe3ry74+7VY8rY36QH7XDROkMSFn55xxeMcPVWGzUxFHGJCPfF6JVPRg1WX28TunDF
         0xlGwBlKAqCl6VwiKo8+FMxdDZsPXtyPmHNpPnkf7qx2COOsO5Kz+MH6+/IsiZNchfWs
         AkhA==
X-Gm-Message-State: APt69E3oeKskIDmmp15Ob5eTZPz+14xxXH3ucHDIDm/JZRHT0eYSGzT5
        7Mg0qrf6Vqztf+nR2lZhJ1TmZgAlFERR
X-Google-Smtp-Source: ADUXVKKJ7E0sKBCG8ejiwHGpgnCv50Iv9Yi4M7SFpD4tQ2y8Cfov1/BE3d8lIDqnbUkn2lOL+MEP7FjASZh+
MIME-Version: 1.0
X-Received: by 2002:ab0:5982:: with SMTP id g2-v6mr6748454uad.102.1529365314016;
 Mon, 18 Jun 2018 16:41:54 -0700 (PDT)
Date:   Mon, 18 Jun 2018 16:41:48 -0700
In-Reply-To: <CAPig+cQM-DXc3sK_Eb7xaaTxNk=0yu9Q3oYtx7M4EinS04AYHA@mail.gmail.com>
Message-Id: <20180618234148.205439-1-sbeller@google.com>
References: <CAPig+cQM-DXc3sK_Eb7xaaTxNk=0yu9Q3oYtx7M4EinS04AYHA@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH] t7400: encapsulate setup code in test_expect_success
From:   Stefan Beller <sbeller@google.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running t7400 in a shell you observe more output than expected:

    ...
    ok 8 - setup - hide init subdirectory
    ok 9 - setup - repository to add submodules to
    ok 10 - submodule add
    [master (root-commit) d79ce16] one
     Author: A U Thor <author@example.com>
     1 file changed, 1 insertion(+)
     create mode 100644 one.t
    ok 11 - redirected submodule add does not show progress
    ok 12 - redirected submodule add --progress does show progress
    ok 13 - submodule add to .gitignored path fails
    ...

Fix the output by encapsulating the setup code in test_expect_success

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7400-submodule-basic.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 2f532529b82..812db137b8d 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -126,8 +126,10 @@ test_expect_success 'submodule add' '
 	test_cmp empty untracked
 '
 
-test_create_repo parent &&
-test_commit -C parent one
+test_expect_success 'setup parent and one repository' '
+	test_create_repo parent &&
+	test_commit -C parent one
+'
 
 test_expect_success 'redirected submodule add does not show progress' '
 	git -C addtest submodule add "file://$submodurl/parent" submod-redirected \
-- 
2.18.0.rc1.244.gcf134e6275-goog

