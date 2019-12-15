Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2ECC43603
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 09:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C59206DA
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 09:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYM7Z/wR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfLOJIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 04:08:23 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46309 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfLOJIX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Dec 2019 04:08:23 -0500
Received: by mail-oi1-f193.google.com with SMTP id a124so2723951oii.13
        for <git@vger.kernel.org>; Sun, 15 Dec 2019 01:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Io+DF6CwbkW5+mHpKChdFxTgk3SzAsofeWEX3he8vGY=;
        b=BYM7Z/wR7x70j1k7GitB3ebIu3Oe6ER35m2JaAGbIT/XeXlWR9i4g7pxHMyc8l2POr
         /CzuMaQTyrEyHVidmNerONHy+Wxc9HXGXkWW9NP+O9tO3ThqfEJPbEbJ4XPqTI/vsi0P
         fG8GAjJh19b7CY18Ha2gZgNzDEMtic4QIrw3sNtS6/KLdepBe4afHJxSOGuToBq+5Vk8
         FxkWfveYYFjnCJP8/DKHmEaHqXrZS6wsIwUwyNyOZRCz2iB57IBVRNw1hD+V01xyEa/0
         9cQSp/P08QzQQAaRzG/pcIwe5YjSNLNR/0EIqCza7QcK0U4KYEitfuhPD2qntaPIW/5W
         l9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Io+DF6CwbkW5+mHpKChdFxTgk3SzAsofeWEX3he8vGY=;
        b=Kw51o+Ug84+s4ztkNVFhQFe63AV2cDTqLnud7dz/PJxMy+Qd9Pkqy1LrbN5/JAxZ2G
         ZyKgJoZRam6c2UreF/ZiIfL7USKuFnvr57TjFQzeK0zZ6o7cRu2FmkjW96uU2gVgTbxE
         iQwwv7rvnpNlsHzlx4uAv13VuWH8c28irWlc8og4t2lhu66ay7jxH/MGmCHy4dPdLbXM
         p2K6PMyFEY51GOlcN2jPOi74uMncahoy6E4K1prTk5HSMRuQWwDX27zW4ueXR/ZuzzmH
         mIjijOkX3aTgjEH/X8zYdoBAwaew32kSrjksgim+UITRtLiNyJPzRcbrFOXuRFrLTsDr
         6Okw==
X-Gm-Message-State: APjAAAVEuw4rpOTLeL1tvb2u55h/JgVT2JAlBH2j28W+gTD/j2hAGyXD
        hIb0IEsJ6wpz912MZxI77QoDms5ATJcnz3ImVWLolpITOsM=
X-Google-Smtp-Source: APXvYqyUTMw1O4turrlZWxeglTJdx+wbKzcbggFjO/CkzbuZt3rFAuhMHOLBQalhZsHvqf2pjXRByLd7CtXOB7ITIbg=
X-Received: by 2002:aca:5f87:: with SMTP id t129mr9218532oib.36.1576400901777;
 Sun, 15 Dec 2019 01:08:21 -0800 (PST)
MIME-Version: 1.0
From:   Madushan Chathuranga <mchathuranga4@gmail.com>
Date:   Sun, 15 Dec 2019 14:38:10 +0530
Message-ID: <CAN2BwoJf60hqR1DpUFq9e+e0RP7XScjK9RsJmghUpsP5CJfC2Q@mail.gmail.com>
Subject: SVN to GIT Migration update local git branches with new svn commits
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm doing a svn to git migration using git svn. I have now done the
migration from svn to git and I have created local git branches for
each remote ref.

But my problem is if there are commits to svn to a particular branch
(eg: trunk) after the migration I thought I could use git svn fetch.
which actually works fine. but when I do that only the remote refs are
getting updated. As I said I have created local branches using,

for b in $(git for-each-ref --format='%(refname:short)' refs/remotes);
do git branch $b refs/remotes/$b && git branch -D -r $b; done

when i do the fetch my local branches aren't getting updated. Is there
a work around to do that. Also I noticed in the migration svn's trunk
is mapped to git's master branch. So my latest commits to svn trunk
arent getting mapped git's master branch when I do git svn fetch.
instead of it's updating remote ref of trunk branch in git.

https://stackoverflow.com/questions/29161646/incremental-migration-from-svn-to-git
I was following this thread which is where I learned about git svn
fetch.

Appreciate if anyone could help on this
