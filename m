Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4D3620899
	for <e@80x24.org>; Fri, 11 Aug 2017 20:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753647AbdHKUgU (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 16:36:20 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:38418 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753401AbdHKUgT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 16:36:19 -0400
Received: by mail-pg0-f44.google.com with SMTP id l64so19484253pge.5
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 13:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=og0WMLaLBFHg5Z/cxvwx27XH4ORoG3hAVUAfzATK4s8=;
        b=CWzf7r8m96Gps2xQHyUtKvf/nRiuuqQz0evKzn7Q6DqhnZ6NOzXhbjFTwEXHwKWO88
         ycXYC4upBvq07sO6UqYuMKhv0FTtdsza3nZtxFLzAGwCqYRLgLyMBITvGLQVa+4jhA+W
         tib+LVg4UBHmdFFZsoJE2gy5fYxIGt/T+ZDasYZ261/eFtLD74nujm7RZ5ssgzW647cu
         iTmcQK1QaaFoyGEVFsvM9ZL3xK0IRHSUNPR7gTLvxCYqa0D9/eDtsAD4szCrRZrQ0OOK
         rH0hlH8/1uzvWSAVF94ekFpTS644+5gEt2FOBeYQTyT6DBw/P3aZWbHtbCUls0ASGiu6
         PLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=og0WMLaLBFHg5Z/cxvwx27XH4ORoG3hAVUAfzATK4s8=;
        b=CrLs1QGlL+1ZFnK1o4tdlP7mEG6Q0J+xi7sun7t3kcaJFyYK6Bv6IfD5U7rw4z12rX
         xrwtG3n1FfV93GPeKr7CkX436MhEW5PlKWJ4DLhyltnBV7gRZQ8KzOh0J/5adrEKpK8H
         t64nkznLxZlFX8KyqczfQx5a0WxydVBcEH+NWUsv78NAMvBSxMUx/Q4sr6Kxrt3GwBeZ
         VZr+5G2FAy0ST2f3bXNPdDKzIy9grViS91vyH2rVh8giclJ9+eTQf2HuBoJHapr8i/SC
         vLsOfBKD4hzGaw62tJANOxg494tbTOkdFDkCzSuXdrQ9i6B72hiFSETZAMwG54RsAubJ
         ifGg==
X-Gm-Message-State: AHYfb5iAjgW9xPU84Kpd97d9XaIeBJ5Ls6JsOaYmk/XVmrEGqko90w2j
        6dARTuGOYGFPfcl06QYyog==
X-Received: by 10.84.209.175 with SMTP id y44mr18818643plh.383.1502483778331;
        Fri, 11 Aug 2017 13:36:18 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id z189sm2712139pgb.12.2017.08.11.13.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Aug 2017 13:36:17 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH 0/2] non-move patches in preparation for packfile.c
Date:   Fri, 11 Aug 2017 13:36:13 -0700
Message-Id: <cover.1502483486.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <xmqqfucz11yb.fsf@gitster.mtv.corp.google.com>
References: <xmqqfucz11yb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, I'll work on that.

In the meantime, could these 2 patches be merged in (after review, of
course) first? This will make the remaining set much easier to review,
as you can check most of them with the new --color-moved functionality
of diff.

Incidentally, after rebasing on "pu" and resolving the conflicts, I
noticed some "zebra stripes" (from --color-moved) where I didn't expect
time. I'll try to figure out that issue before I resend the rest of the
patches (which will be after the relevant branches are merged to
"next").

Jonathan Tan (2):
  sha1_file: set whence in storage-specific info fn
  sha1_file: remove read_packed_sha1()

 sha1_file.c | 39 +++++++--------------------------------
 1 file changed, 7 insertions(+), 32 deletions(-)

-- 
2.14.0.434.g98096fd7a8-goog

