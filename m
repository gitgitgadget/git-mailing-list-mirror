Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCC5ECAAD3
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 23:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiIKXJH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 19:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIKXJF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 19:09:05 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9E423141
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 16:09:04 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g4so6704202pgc.0
        for <git@vger.kernel.org>; Sun, 11 Sep 2022 16:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date;
        bh=SgLeVJmwGRDdevOyC9wHg13MaoEUg0K46uYV7PZR3dA=;
        b=OsRsG0g38URBxa0RdOjkrQB8mQBK/sffavFRarmGS56Bh605bsBpPrRSCrlcLBhwXF
         AYUedn19069EEt0EK4Bci3DxElPtVxnWECc5FtgVEacuG+qVSMldNIWI6rWYZukCBnJQ
         PeapipaPq/4ooaILylOY0S6EmC51iRGBDsbeSjMuJxwOj3o/aQLoy6Soj7fDuarkVF2X
         8dVDFoy4zd2S/m3wVl4+nMN1erWfd0YDfc9w9HQXFtHGgQL1V170jLxnvdtsEuEJ1gb7
         CERBRMzLtAz+odGqtZlEq+tzQZpghPw22tAU4720Ts8kHfoJKszW+xFbxWqtTsLrvLn9
         5Eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SgLeVJmwGRDdevOyC9wHg13MaoEUg0K46uYV7PZR3dA=;
        b=MrAJNj0ZbMzGfrDo9VXDIDJzeVzpX0QwRX7QtWOXT2xRu8w8WSiG6NyhWvrEmbG+b7
         Z3fsuF1kaVvZJT5WmaxIycdCh5Ly/nNWC7xk65JC4dQylhWj2Jw9X5Us5aM33JM6XpS8
         dAIBMET1Zc+1oGbHK5CQyKH5vrnUccuIR5+t0B0HH3owDkq8wNrwIoIXGVerQIvOJ7oH
         WlkJm/DC1BzXqAoINtGY17XuwaE3d00JFVRhyVKmEFhQHHDfl/O+GwjOFYKFT4HRMzo8
         wi1luEccx/vU4bmwnHPmboSW80Q3X2ryfwSwNex6utZmio0UNM5r4eydZ0j2+kM4QUG2
         Z2rw==
X-Gm-Message-State: ACgBeo0dpkFrnC6aNC2flxqCcROOMioE2M2782xqNc9YzpL+NEnBxTp7
        l+Hk8VCXBms1jvSua/4hcsPaGBguQ84nYw==
X-Google-Smtp-Source: AA6agR4xFzvDK0suurnjA4AJYf1sPW8q8lyIuRzD/nhaZXgJCWxrcovgVBlv4FuLqjGtYOkoFR9tqg==
X-Received: by 2002:a63:2bd5:0:b0:434:ea9a:ace2 with SMTP id r204-20020a632bd5000000b00434ea9aace2mr20219455pgr.323.1662937743849;
        Sun, 11 Sep 2022 16:09:03 -0700 (PDT)
Received: from MacBook-Pro-3.local ([2600:8801:9c0a:f300:b5d1:79e9:801c:571f])
        by smtp.gmail.com with ESMTPSA id t4-20020a17090a3e4400b001fb3522d53asm3859833pjm.34.2022.09.11.16.09.02
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 16:09:03 -0700 (PDT)
Date:   Sun, 11 Sep 2022 16:09:00 -0700
From:   Jacob Stopak <jacob@initialcommit.io>
To:     git@vger.kernel.org
Subject: Newbie contribution idea for 'git log --children': input requested
Message-ID: <Yx5qjPhZ5AHkPHr7@MacBook-Pro-3.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello! This is my first idea for a suggested code change, and I'm
seeking some input on whether it makes sense to address, and if
so, a bit of help with how to implement.

I was futzing with "git log --children" and noticed that the
output doesn't display children for the HEAD commit in a
detached HEAD state (or even when HEAD points to a branch tip
that in fact does have a child commit that is ahead of the
branch).

I assume the children of the HEAD commit don't display because
of the way Git starts parsing backward in a parent-wise
direction, so the children of the HEAD commit would never be
found.

But it seems like displaying the children of the HEAD commit
_when they exist_ would be useful for users who have checked out
a commit somewhere in the middle of a long commit history.

In this case, a user might want to be able to easily find and
check out a commit in the "child" direction without having to
go all the way back up to the branch tip (or nearest tag) to
see commits between the detached HEAD and the branch tip.

I'm not sure if this really qualifies as a "bug" per se, or if
there is some way to do this that I'm just missing, or if it goes
against the way Git's rev lists work.

But I'm wondering if it could be addressed by simply adding a
discrete check to see if any commits point to HEAD as a parent,
(only when the --children option is used of course), and if so,
populate those ids into the log message.

It does seem to make sense that ALL commits with children would
show those children in the log when the --children option is
used... The current behavior seems to be that all commits _except_
HEAD will display their children.

Thx for your thoughts!

Best,
Jack
