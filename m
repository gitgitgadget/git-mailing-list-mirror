Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621F4C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 10:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346916AbiBKKYU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 05:24:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiBKKYS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 05:24:18 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A55E99
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 02:24:18 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id i30so15413291pfk.8
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 02:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bPcVurWwzSIUVJHMhaTleFCMeLUyuuRQ8fIyvlMlhOI=;
        b=GTLilEKDFAY4CYibUcQJ//D5D/tg/kD3RvpkrFG1Wh5ERNtYVMMPz6vvoEADYbwqm1
         oqJ+OMpSklzub146uCVKwNtD/JYI1WB11SmqPiW+4AfDGDcL/2xxkAoqJUVx9aJKE5+Z
         mktqEKVlPQQjxOmq/vBZtSxIP8tIkdj3eCz5HrLDm9ZtPi5FvIKTySk2UKq+43ffzXJX
         sWil+sh2XbEux5gLhjXz3GOv5bZsyzq1vq3w61FOVaW0nNBOZhBQOoDM46fCGMWUCBF0
         g88Bd1gxBtQZVjgEYafku7nI0PkzqhUL01cVmpQb7qrYVhoMoucFs3yGzBsu6gwOSsuE
         Jkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bPcVurWwzSIUVJHMhaTleFCMeLUyuuRQ8fIyvlMlhOI=;
        b=emHH2TLA77fAQDARh0exEN1FcTMFJN89fFBSoZIjd6TSaw070SkgW9W4+rKHFl4lmo
         1hfU9fMSfegFfhQQEarplR8izNUR+sKIrt2SHHscbxGG06DmJK6Wj8XAvGuoVE0VjwhN
         GiDYmBWW810pqIQyU5U7rj56tM++x5yK1z6Lil3uHJAjjwn/B+Ki76zeVusIE3SNgkjA
         OgrUb90I8hkFY71SwKVAQxWA+bwC7j1+f5AWcIz5RAoopkrWG0L8R2kpmuzzwzqfeTAq
         PVJvGtOss0tg/DmdIjP3Oh2lTrFd+b6IFdC/HfwSELlhTZR+jeL12GcmSLSlZWNk1KGi
         ztDg==
X-Gm-Message-State: AOAM530XJO0a3MmDYarE0bqOoXXcrUjQ1GZvy5HtZrzAe8+0vArvlprn
        MN895tf9iaXcJpeU/Mz+Rag5MAf5/rXMPFjFD75xYfjhUq9mDw==
X-Google-Smtp-Source: ABdhPJxIPaPKgCGSp+vcvA8yWP6x5x07BBAT1mjFqZ27jMlFZiFrUZB0VsR+f6prEK+H5/TioSUfCyU5Y/l/pYEBV48=
X-Received: by 2002:a63:e206:: with SMTP id q6mr751045pgh.165.1644575057076;
 Fri, 11 Feb 2022 02:24:17 -0800 (PST)
MIME-Version: 1.0
From:   Joe Brown <joewbrown@gmail.com>
Date:   Fri, 11 Feb 2022 10:24:04 +0000
Message-ID: <CAGsxCrHSif=ZRFT4TnJnMo1-u2=jTcN9FKJECmmFmyAVQhfk5A@mail.gmail.com>
Subject: Bug: git-gui creates unwanted branch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heya folks

When cloning a repo with the git-gui, it creates a branch branch
called master even if there is no such branch on the remote. In fact
it will create a branch according to whatever value init.defaultBranch
is set. Tracking branches are set up correctly. This doesn=E2=80=99t happen
using git cli, so I don=E2=80=99t think it should happen using the gui.

Cheers,
Joe
