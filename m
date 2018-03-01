Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EF8B1F404
	for <e@80x24.org>; Thu,  1 Mar 2018 14:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031516AbeCAOZZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 09:25:25 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:37767 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031397AbeCAOZY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 09:25:24 -0500
Received: by mail-wr0-f175.google.com with SMTP id z12so6510158wrg.4
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 06:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=aW9DUx2vuwrpdSPba+NxPx+NpBgsFW+VCymywOtu9/Y=;
        b=RHBDJBCeMlx7hRkTwjfxEJg4pXdCYWG423Cf6q/ckE+KDwcDKVllZK5q/pZN1bhV0i
         3oaNifoyO0keKOeXKgefMpouhC1p70vy0S1QPQ9M5U/YTZs8eI9LIASHwsDtj3rvdNTP
         jBpWIFTFyaaSTuTYe1FDns0bI7+dI8jzSljROJROV6+dpDsiQGLPRcM56JOToVRhzIX/
         mNbZ7YK6QFd+Cs+Hmui0xR2oke69Wuq2K9ga1UCr1F9AuM5ok/oPnTYmTQkSWKdoyWI7
         nXHT/gSzjkYB2EGljyr1tsmx5FpgFU1QUhVd4EU2BmRPymBwqkaPqvHRBzjo0AX1RBdh
         gNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=aW9DUx2vuwrpdSPba+NxPx+NpBgsFW+VCymywOtu9/Y=;
        b=D0vzcsL0lSdwbNVUHCiziwOZPPO0TTdZusXFpUJL/sUHdE8GkQCKI0oEuKXQeRGryk
         /V+clyr2gDXJl3495TJSuXvLXLh18aF8tJFbJ0/CKkNhV3N/puUTZ0j3NkELXI2Vn8iU
         4tYuPb/BdIm+8wnkOU6mSj6Ih61ry3H4hegJKWVP1QuTsU/wqFFsEc9BMN6HgGw7CM6B
         CCLpGpyEPgzVHcNLe2OLm6kNvljbVDOsBmd5nlO20c32Tq/5E2oTW7QJb2NK4tiZAfsS
         h9Bae7LXEwXSUONGKmWp6pnFD8DNyXQeR+gFkdNT4upwW+PoesHdaZ6hxWGpzs0dGnsr
         6HSA==
X-Gm-Message-State: AElRT7HiesmmJNqOImigaA7iW7tU4t+u89lHbk5xCDvAOO0WpkQPoET8
        yzfuQFJEBmm0cGjn20Y5gMGTcdRZMep9U/Cpy1w4tw==
X-Google-Smtp-Source: AG47ELtZd20Yz6hLQWMc8UskzmQfIuuJlbG5ExO+uDJyGMZjjU3BP/oEXkvAiWTzZ9LSx9ZY56BocCu8xcex5lOGNY8=
X-Received: by 10.25.78.79 with SMTP id c76mr1489131lfb.98.1519914322843; Thu,
 01 Mar 2018 06:25:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.80.67 with HTTP; Thu, 1 Mar 2018 06:25:22 -0800 (PST)
From:   Birger Skogeng Pedersen <birgersp@gmail.com>
Date:   Thu, 1 Mar 2018 15:25:22 +0100
X-Google-Sender-Auth: lz53ZgKbEqkRcRHQb_WKDsww0Nk
Message-ID: <CAGr--=LxMtz5RRP4742u3VsrADRsWARE2SitCSOWATySOn2LcQ@mail.gmail.com>
Subject: git-gui: CTRL/CMD + numpad ENTER does not invoke same command as
 "regular" ENTER
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-gui, we can hit CTRL/CMD+ENTER to create a commit. However,
using the numpad ENTER does not invoke the same command.

I propose that both numpad ENTER and "regular" ENTER should invoke the
same command.
