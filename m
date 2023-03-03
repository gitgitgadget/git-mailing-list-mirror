Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726DEC7EE2D
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 18:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjCCSKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 13:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjCCSKb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 13:10:31 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7DB5D88C
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 10:10:21 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so4523523wms.2
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 10:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677867020;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ODoi9URuJ12xmixKVpEo9MRH32CR6sZSM3aEQ2aR83o=;
        b=Q7vvvPaN8N7a0ZAwTGNecZsE+CSmaselbT+vN2BzOXJUYANPKbBnBSFVb1amEldMIj
         ISmaUa2Qe1DcKq/QqlUZX3rQNh9y51TcC2QYi5jESW9w4ioqYVxBh+hbXrHgKMLMzEIn
         z9rEar87exfGYbsvkhurhk4qXHTOuoIemTV2S5aUfryQfgjCLK0WibWOYQUC+H3FVwni
         9P3XrscCnST1xttUPQ+9WAoubU90PbsojSPyEeHLIyjSWSo9O1NTimiCPeMqorXP6LxH
         Uih8Vn91gGfDABuzmO4S9jXH5PXGN3yS0uuBC6zmhMpW8tqzTEzRG/f6o/sn2+SiqLtG
         FcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677867020;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ODoi9URuJ12xmixKVpEo9MRH32CR6sZSM3aEQ2aR83o=;
        b=xlYwY2ewrA3eHnxkot3kz05mlY7j/X/A0O+JDeSo08RzeQ6SjKQ4cBXifv6KHPIZuw
         szwJeAqHNmrgTWk2HSAP/r9k23pPR7RqQB4Z+AN6rCA8Vb499hc+axCp+OgX/qno9nbz
         CmcQi3fGunBj8KcuiU1uoq8q+tMwwRGe3peTzWqfs5xza3N8Tc+mdEqsbs2fBf5Q/dxB
         P1llX/+VNZ8yvVUel9YqpMEvMggdrEjdWeRG41s7Wjj6d4akLDKC8isTB+jdUPkMceWT
         Hu2r3cVP/s3XpWZ2mq8z66XoAkCJ1W0qMywTV4cp4dSVemmTz7QEkjG7v5dgYbARqHaD
         QoPQ==
X-Gm-Message-State: AO0yUKVmT2g5srLx84JrXkDQGdFvYtfWPmL8tBCU4tYSzv1Zrz5uK8q2
        ZNs2m7dchbeN3EFq6m0M6fAf0a1lHp7GNxalvNOD2E8p
X-Google-Smtp-Source: AK7set9viUMBOTz6BVbb3fIIvSTxmk43INsIj8mBnjlyV0HLJesDA/RdX75Rse6DL6vKRXwl28GOtE3CxSk0kQ/lQFI=
X-Received: by 2002:a05:600c:1:b0:3eb:5824:f0ec with SMTP id
 g1-20020a05600c000100b003eb5824f0ecmr639503wmc.2.1677867019853; Fri, 03 Mar
 2023 10:10:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6020:832a:b0:261:fef4:7c90 with HTTP; Fri, 3 Mar 2023
 10:10:19 -0800 (PST)
From:   Magnus Asplund <asplund.magnus@gmail.com>
Date:   Fri, 3 Mar 2023 19:10:19 +0100
Message-ID: <CACw=1eCKN-saQCbOmoyZ1=ydcwoC0FE0KvE5UQ5ttkkv0OeBcg@mail.gmail.com>
Subject: Is xmllint no longer supported in (latest) Portable GIT 2.39.2 ?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a bash script created in RHL environment (Linux). The script
extracts data from a great number (+100000) of XML-files and generates
"row-col" data as output to a CSV file.

Due to limitations in both technical knowledge and
access/authorization restrictions of other persons than myself, I
decided to give Portable GIT a try in Windows 10 environment to hand
over the script execution to those other ppl.

The script works fine using 64-bit Git for Windows Portable version 2.38.1.
However support for 'xmllint' seems to be gone in version 2.39.2....
(this one: https://github.com/git-for-windows/git/releases/download/v2.39.2.windows.1/PortableGit-2.39.2-64-bit.7z.exe)

Any answers to this? Is xmllint not longer supported? Any alternative,
besides using to older version 2.38.1 ?

Best regards.
Magnus

--
Kontaktinfo / Contact info:
Magnus Asplund
asplund.magnus@gmail.com
