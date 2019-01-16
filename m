Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F23021F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 22:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387496AbfAPWma (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 17:42:30 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:46590 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733288AbfAPWma (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 17:42:30 -0500
Received: by mail-vs1-f74.google.com with SMTP id n87so3392888vsi.13
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 14:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v5ncvF0/tMxmsjbrRb4qeq3WPVkNRAUgsE/fIVkGHIM=;
        b=Zanj5d2a1GNGCX4UhFZ8xtMrnCTKy2L6l+WqG0YTi00TkSy+OQ+vFMFnHxCCiZPgZu
         SVTiBoUSJy/g2SAnz/Z8kfw+0E23LJer66mUUUxlOH2f+ze8wVX2GETV30HCpzG7N2cj
         XEMu+WtCoEByKhNKOpJBVXh3iK7f+nvGnKEizkpSIMprKzYYUh6SoeGiuAfwB/SOzXkP
         uofup7ts+d7p9Miak1SDh2NooZGREvbdHD+EmXjxhsghRnFHbPFvPX7HsAN3JPenZQl/
         tLhu+Sz3Y/uR7+Jk4U6D9a64atKCvsroVfds2t0ZEQ5lK8gchLyHA3LYkTlhTgXFBzyN
         61VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v5ncvF0/tMxmsjbrRb4qeq3WPVkNRAUgsE/fIVkGHIM=;
        b=LY96ZURh7od7xeKzb5IZDZkLkyXry6oURFptC49iQlYdDSBeG7s8j/zUmjmgQ5fI0o
         +PEYp3fVjAioOg5idmbD52JMv56Ir6aq4O2j6kp0HpSA0J+m3hyHgNrgzjba+KSjhnwO
         R2e+0pgEX6xUJD5jeloQtao4uMz03FnUmyiK3mxNIm493srZZE+sisLFPGgy3GszCP09
         krKTKmSj6suqZbVhD4MCCsR85yotAMc27l0HM4kQWIgmOToe9fv6K+gDwGmYfXyowHNW
         guyC95NcD/1rcFZOBYV1nOUMjma8HQFq3UvWHK/SUHDZY7kLLM6TN1OYksJZjKUCpnQD
         GH+Q==
X-Gm-Message-State: AJcUukcn0xCTHMxjyLDa53Fz57HRw5flF3i3BSxYOqiSF76P05vq7mbW
        PyvddQqhshN5unVL6qMd24IDuWkLk8GBkc+RVaUp1s/AEa1Sx8TP4ysoW7kH184nSwIp0afDFIe
        BNLkHeISr/bo9oYQwIC33H8Fji3DbLPTIz5mYIDIwtbm3hQD9Bg4xHfM5G5oc5nRMtiuIAaIn46
        0g
X-Google-Smtp-Source: ALg8bN6Kc0cCAg+d1LYWli/sTAJwixJ8h/O4I5kCgSEICGNkqAGxy/IY59jMVSFRDJk9IVBpzvNU2wMOc8llT3Vg1ICE
X-Received: by 2002:a1f:f8e:: with SMTP id 136mr6935787vkp.4.1547678549619;
 Wed, 16 Jan 2019 14:42:29 -0800 (PST)
Date:   Wed, 16 Jan 2019 14:42:11 -0800
In-Reply-To: <cover.1547677183.git.jonathantanmy@google.com>
Message-Id: <0820b3411cf217fd3fe0ecf40edafd7adec4851e.1547677183.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547677183.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 3/8] t5503: fix overspecification of trace expectation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to extract the wants from a trace, a loop in t5503 currently
breaks if "0000" is found. This works for protocol v0 and v1, but not
v2. Instead, teach t5503 to look specifically for the "want" string,
which is compatible with all protocols.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 t/t5503-tagfollow.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 4ca48f0276..6041a4dd32 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -47,7 +47,7 @@ get_needs () {
 	test -s "$1" &&
 	perl -alne '
 		next unless $F[1] eq "upload-pack<";
-		last if $F[2] eq "0000";
+		next unless $F[2] eq "want";
 		print $F[2], " ", $F[3];
 	' "$1"
 }
-- 
2.19.0.271.gfe8321ec05.dirty

