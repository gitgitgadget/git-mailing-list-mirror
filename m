Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F41C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 22:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjBIWQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 17:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjBIWQS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 17:16:18 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD1D9747
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 14:16:17 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-15f97c478a8so4414114fac.13
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 14:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FqiZds0tFVHJ2DG7CrtBKb2z8nU7A5zYaSFRARmqHY4=;
        b=SJmYUofxVfzfEyOL75NGUIKGnhbXc68Nx518doPKKeTWoZKroVURA+TGZzFUGtj9Lk
         7AbWsOGibSpQypwe862/YFrV1212+tpUcKgPjp8R9pgQvh/HNXHKW1yJyLX6YmDEYN4H
         hEvQMvjXFcwb3MH8cABau6pNZIuDNFzoIRYZDIe+tBwKWg61lx0wky3rH3N62InAg5eo
         MYhBc9msdjDZOIVFfmwvsXvNXxyC0wO5Wve6CTwyjAsp9ryDrxVcE51ws2zJRpZNAp1d
         YikocBj3yTBNu6yyba54xvfaWti8NUJCb49CpcFvEZ7PSXbGjtH4QHyU9dBZVjhSUp+y
         HNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FqiZds0tFVHJ2DG7CrtBKb2z8nU7A5zYaSFRARmqHY4=;
        b=KcV3Q1N+dYSAxOych+L1BziMWQizLDzSbCPCANSg4zp3S0XyPRNt9ZBvNl2l2h0EjS
         vAVFd9bYoxXk510+kgPI3rHBgo6YsuOq1fh7Vgoh2TA9g/qnY2rTXnMul6eKazuqqEpe
         WHghLGlK9GRycC8sJoYmxMBrQI6XQsvbR27HedC2F4EtIkkbIxlxmpqHWxw0UVGmmdQW
         uT/5CmwFdOWZBN+4bJkVofJcLUlxFzDocOFVHjW6b0T1MmD4DwvFWav77X9gFLlaTdfT
         LcmmYIJ/MC9Jy685BQDhXK9JhJX6EBGnsvlXVrfC2/0uyErmlTVgROxg5VmO0OokQznH
         qcwg==
X-Gm-Message-State: AO0yUKV6Xf0gcn89X6SiSSGRtR9MDKNlcLolNpFo3vGUXKK9Ca8RqOzI
        54xhKtGAYf9cFlD+oiNnH+c37pju5nYdhWksZW9XO8XC1Pk=
X-Google-Smtp-Source: AK7set+o6RV8/+cKgpxqSSAfxprPRiowUxQ8DZcCJEZK1GsyilUUN3i/5ExKEjrRHNbbkF4tSXdr+atOASGv+BIZGUM=
X-Received: by 2002:a05:6870:9688:b0:163:4ba0:fc7c with SMTP id
 o8-20020a056870968800b001634ba0fc7cmr1471681oaq.244.1675980976411; Thu, 09
 Feb 2023 14:16:16 -0800 (PST)
MIME-Version: 1.0
From:   Michael Rienstra <mrienstra@gmail.com>
Date:   Thu, 9 Feb 2023 14:15:59 -0800
Message-ID: <CABBAUF+acoMScQfHFQGooPx9eng2FBeb-Z2619DsnCt5QmhQPQ@mail.gmail.com>
Subject: Markdown release notes
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Release notes are currently plain text files -- and that option should
surely remain for backwards compatibility -- but it would be nice to
have them in a format that facilitates cross-linking.

For example, https://git-scm.com/ currently shows:

> Latest source Release
> 2.39.1
> Release Notes (2022-12-13)


Which links to:

> Git v2.39.1 Release Notes
> =========================
>
>
> This release merges the security fix that appears in v2.30.7; see
>
> the release notes for that version for details.

-- https://raw.github.com/git/git/master/Documentation/RelNotes/2.39.1.txt

Navigating to the release notes for v2.30.7 is not convenient. Some
users will simply modify the URL, which will do the trick. Others may
find their way to
https://github.com/git/git/tree/master/Documentation/RelNotes & search
for "2.39.1", which also works, but isn't particularly friendly.

Markdown alternative POC for the v2.39.1 release notes:
https://github.com/mrienstra/git/blob/markdown-release-notes-poc/Documentation/RelNotes/2.39.1.md

Now "the security fix that appears in v2.30.7" can be easily followed to:
https://github.com/mrienstra/git/blob/markdown-release-notes-poc/Documentation/RelNotes/2.30.7.md

Along the same lines, CVE IDs could be linked out in Markdown release
notes, I did that in a few cases as part of this POC. For example, in
the v2.30.7 release notes (last link above) there is now a link to:
https://nvd.nist.gov/vuln/detail/CVE-2022-41903

(nvd.nist.gov seemed to be preferred over cve.org, based on a search
of http://public-inbox.org/git)

I used regex search & replace to add these links, sundry details are
in commit messages here:
https://github.com/git/git/compare/master...mrienstra:git:markdown-release-notes-poc

This seems like a simple change with no obvious side effects. I
suppose the Markdown files could be placed in a subfolder to prevent a
jump from 464 files to 928 in one directory.

Thoughts?
