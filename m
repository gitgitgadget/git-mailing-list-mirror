Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6206CC352A3
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 20:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC9C2073A
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 20:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWrAy92M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgBOUEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 15:04:16 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:42019 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgBOUEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 15:04:16 -0500
Received: by mail-oi1-f179.google.com with SMTP id j132so12993581oih.9
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 12:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+dHjJNht3d2KrLfjsh5tWi0msbdt9L6ROBhG2E9svsk=;
        b=nWrAy92MEFo40kbZKiy9IKVCLYbAppEMv9G1wdB/DmmtGRCLA4RyvOF9nwUOIfKVvi
         3W+hGgJq0XGiQ+7eqBBMhtKyXbSe3cz2tmMPwcb8f7z+02XvZB1orA0ZMt3ozJIIbppN
         FYl98Cu/ogy8Enpvy2SqOSnCGZZcGWn16EMZOOAIsj1WpkztrksgnzRWg0euNZZjfOpG
         vbERfL0s3HLhGo2SsNzSiHs8eZlu4IX+ppRmtDlCd/82vMnIW8UTwxv75zK+MCD8nNOK
         YsL2d5i+WSn5SyNnBL4x3Xzk378mKhNtbIwfdPnKbB4b4j9nnBfAhdNlaFOJYqAt926q
         tvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+dHjJNht3d2KrLfjsh5tWi0msbdt9L6ROBhG2E9svsk=;
        b=bmgGhII+ZAUmVtocL92TPmwEhyeq9zABx/VeonNPWVgKDuiUtgLJ07J6FoQlFh6V1r
         bsG+ypD42jdL+HnOtQV5EqyLbiNIhZLRMuyqfQqUHj4g2uMOB/59c7xaxyiEt4L3gVg4
         RnVnnAIwk7sw6JmmB8O9PQx/dF70aakq1XZbp5jT73hZdv6MmDL6KvKCqz6nchgv86Lz
         8zrFDXJD5E/+7NGJ614FFl6uIx2n76qTHHANS7xHAGj6yjY60Gjcgm6ByZ6ZzCqrMtnZ
         6UcDxDtvTUhCheL12PQ3Cxg/Gpc2EpK+nAm/TT3ajaQ1cPDLUM5WQbSAu2PlyQURx6T0
         hBZA==
X-Gm-Message-State: APjAAAX8PgOZYpKyeIc5OmpK5jWlz0mP/PicTFQKb2gNr6qX2DRbjnRt
        30zw5/o37s6vsvRZJEOw3LgdGMI7lsjD2ipfwJKI/0mB
X-Google-Smtp-Source: APXvYqxeCNjTNCLLq9At/CqoA7Q7RrPQkdSUKljR9zBl5NAzeS+LLwTmTgdzZilJM91FCbrbGH9n5eFPU9T1mJrw/PU=
X-Received: by 2002:aca:afd8:: with SMTP id y207mr5529600oie.96.1581797055527;
 Sat, 15 Feb 2020 12:04:15 -0800 (PST)
MIME-Version: 1.0
From:   Insane Sharpness <insane.sharpness@gmail.com>
Date:   Sat, 15 Feb 2020 20:04:04 +0000
Message-ID: <CAMNO-BY=-1yqUuiNg_ggRfUyhodmbwxg5AcaZNhu+F+JwmSy1A@mail.gmail.com>
Subject: [ANNOUNCE] GitVine v3.2 is now released.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

GitVine is Git client with a simpler visualisation of Git Commits +
now also supports common git write/modification operations.

What's New (since last announced v1.0):
(Thanks to all who tried it & gave me valuable feedback.)

Features/Improvements:
- Added Open Folder/Repository (Previously was File only)
- Added Stage, Unstage, Discard, Commit, Push etc.
- Added Integrated Terminal via Tools Menu. Recommended Terminal App
is Hyper. (Only)
- Commit Nodes/Staged/Modified also show list of files changed. (tooltip)
- Added Pending Pull Indicator.
- Added Mechanism to Locate From/To Commit - from an Arrow's Context Menu.
- Improved performance/caching of additional search items"Contained
in"/File List/Messages functionality. (Background thread)
- Commit Nodes are now moveable by user.
- Added "Remotes", Branch Info on Status Bar Panel - Info in its tooltip.
- Added Support for Gravatar User Icons.
- Added Options Dialog for Configuration (Tools Menu)
- Added File Editing. (Tools Menu)
- Added Git Blame/Annotate. (Tools Menu)

Fixes
- Workaround fix for Very Slow Performance on git/git-gui repos.
- Workaround fix for Head (arrow) not pointing to actual HEAD.
- Fix for missing Signed-off-by" trailers are missing the email addresses.
- Arrows getting corrupted/incorrect after dragging.
- Temporary workaround for crash with "cherry -v" on some bare repos.

Project Page & downloads for Windows/Linux/MacOS here:

https://insanesharpness.gitlab.io/GitVine/

Thanks & Regards to all,
Prashant Sharma
