Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C851F404
	for <e@80x24.org>; Mon, 26 Mar 2018 18:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeCZS1c (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 14:27:32 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35354 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeCZS1a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 14:27:30 -0400
Received: by mail-wr0-f196.google.com with SMTP id 80so18804471wrb.2
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YCpIx7KwVnXADw3HYwWV9uS2MnJKtEfVN3G1Ioa2/XY=;
        b=bZlYRD6hCYlrQi3f9otqxuJa4DV0ueCiyjfJiWzdNjJ7q6139/UE7a1PGUoLSAobtU
         ejEIvBWqQB5dNaMxkyvLhX1jAim3RjGBxZtt13SpEBFoI8jZ7mtONU04CC6KyCinwcY5
         LIwpwapvLqPdxTPa85tgcCYc68ZxMaIvT6CAOmnHYiJHa873lBIhwn79XESUz30t8al2
         KonNt1vhQmg39gNrhU36agrQjkiGslOMy8NkkxgSUszt5lIGiOk5ve76HZTHCjQqqIEw
         NGwis9MqiRrpL1c5PjQl+UGrUVZf8vROhO/fkSs3nwovb/XUUu+Yb1HGzDfa2ReEvKg7
         TofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YCpIx7KwVnXADw3HYwWV9uS2MnJKtEfVN3G1Ioa2/XY=;
        b=Tk76lJLGoiDpXQpPsvoF3ti1DSzBT0hh1CK+nwmKfz89E24qu9j9C7yyhB8lnlG/Be
         ZjfOLls5WGxEGfVkUwGeY+PXjEqj/Zbm+/AI3DhtEOAlYtxyhSgxeA2q6AOJnO0/5rGI
         X0Er7mOx2s04cZBBlmspq78hgiR7I/Cd1FcWleMl9n7W6PfZof2BKbXg4rBn+5+gaJL5
         Gn/DUKqTUPLiw9856dGpznOwEhKPw40qZWNq9XRdAJ7z2CZBpPRKQyThwA5IsPF+Oowh
         1aJQMbP2FPYTqjUDeViCeCdU+Ijoh81xfpQioWfYIkxLLqDPUszwgWPwilkNOd/8GWmi
         8sjw==
X-Gm-Message-State: AElRT7GKN5M5esT9+SZzplVKy7Wl+qvhjAllStjyZpq0qnsP8o+xk40C
        tV5F8rNmt/WcFzldosFLSFOzoI6c
X-Google-Smtp-Source: AG47ELsppLhk6xxBsu7awfUVCj6yS3YBCMIzZPRsS63YaOWoOKOkLf9u2NR+1yBG4W1ye839RVzfIQ==
X-Received: by 10.223.144.195 with SMTP id i61mr24115833wri.227.1522088848749;
        Mon, 26 Mar 2018 11:27:28 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b13sm19085852wmi.42.2018.03.26.11.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Mar 2018 11:27:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Marc Stevens <marc@marc-stevens.nl>,
        Dan Shumow <shumow@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] doc hash-function-transition: clarify what SHAttered means
Date:   Mon, 26 Mar 2018 18:27:08 +0000
Message-Id: <20180326182708.26551-3-avarab@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118
In-Reply-To: <20180326182708.26551-1-avarab@gmail.com>
References: <20180326182708.26551-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Attempt to clarify what the SHAttered attack means in practice for
Git. The previous version of the text made no mention whatsoever of
Git already having a mitigation for this specific attack, which the
SHAttered researchers claim will detect cryptanalytic collision
attacks.

I may have gotten some of the nuances wrong, but as far as I know this
new text accurately summarizes the current situation with SHA-1 in
git. I.e. git doesn't really use SHA-1 anymore, it uses
Hardened-SHA-1 (they just so happen to produce the same outputs
99.99999999999...% of the time).

Thus the previous text was incorrect in asserting that:

    [...]As a result [of SHAttered], SHA-1 cannot be considered
    cryptographically secure any more[...]

That's not the case. We have a mitigation against SHAttered, *however*
we consider it prudent to move to work towards a NewHash should future
vulnerabilities in either SHA-1 or Hardened-SHA-1 emerge.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .../technical/hash-function-transition.txt    | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 34396f13ec..34b8b83a34 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -28,11 +28,30 @@ advantages:
   address stored content.
 
 Over time some flaws in SHA-1 have been discovered by security
-researchers. https://shattered.io demonstrated a practical SHA-1 hash
-collision. As a result, SHA-1 cannot be considered cryptographically
-secure any more. This impacts the communication of hash values because
-we cannot trust that a given hash value represents the known good
-version of content that the speaker intended.
+researchers. On 23 February 2017 the SHAttered attack
+(https://shattered.io) demonstrated a practical SHA-1 hash collision.
+
+Git v2.13.0 and later subsequently moved to a hardened SHA-1
+implementation by default, which isn't vulnerable to the SHAttered
+attack.
+
+Thus Git has in effect already migrated to a new hash that isn't SHA-1
+and doesn't share its vulnerabilities, its new hash function just
+happens to produce exactly the same output for all known inputs,
+except two PDFs published by the SHAttered researchers, and the new
+implementation (written by those researchers) claims to detect future
+cryptanalytic collision attacks.
+
+Regardless, it's considered prudent to move past any variant of SHA-1
+to a new hash. There's no guarantee that future attacks on SHA-1 won't
+be published in the future, and those attacks may not have viable
+mitigations.
+
+If SHA-1 and its variants were to be truly broken Git's hash function
+could not be considered cryptographically secure any more. This would
+impact the communication of hash values because we could not trust
+that a given hash value represented the known good version of content
+that the speaker intended.
 
 SHA-1 still possesses the other properties such as fast object lookup
 and safe error checking, but other hash functions are equally suitable
-- 
2.16.2.804.g6dcf76e118

