Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F21DC433EF
	for <git@archiver.kernel.org>; Sun, 24 Apr 2022 06:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbiDXGoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Apr 2022 02:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbiDXGoS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Apr 2022 02:44:18 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043632DAB2
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 23:41:19 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q12so10777609pgj.13
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 23:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=/9kYvSw+S8PFcs//IAwG6DhvUoJDNUnkdFL/jfQ0wRA=;
        b=LB1RkQPB2BboM+PxIHNe5EZvPc+J7brHkfmqj1Msj3d7HPuTsjvUhACYCNV4BHCQFn
         VqjQvvGYjRLRGvupzE5PGf452c2Sqs5Yn2JR2m3XwM0D8R9KxYoWAdDTuWu8VDQq+QYS
         oj8jelTIRLGmiQHiG1G3yJnq12TQb5qJX9A+Q13LQgJweXSdbHTYfz/hkpjHqmDZ87f8
         Tn2tfKdVJTw6bSv+bKdg76+wAslRwJMLgNuPC3luxmr3N/yC5Gz9kGHt514dZ4Eldnlw
         yN3S8ZHGaJej5zVtHTdQvrpnHOgwIGvN93Jyc07Jbu+gXKdNrP2GtciAJZ3ztLxoqF9K
         1saQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/9kYvSw+S8PFcs//IAwG6DhvUoJDNUnkdFL/jfQ0wRA=;
        b=JfFKjBaUg6oDGyxqdGc2h7BrHMsCEdPbcYM7G+Cxfl+8uh7d417v8SAZ4T23vdQ89s
         ky1dwv9xg++bQ5L96LJ8+ScP+lROfcoV2HkPJ1DeRA0LOg1CCwH/Tp2ZtOqohpzh7FyY
         mDKTvH8yzz1X+YtGUNgABiYSkh6uivNA1SXylOJr13y8R2l3rBaOckHEJ1raUqmzLWhC
         qRv+OpkE4d6iJoEDFjV6ZsRqZtHW15gDw9NGtyzqz/padYnDBcUAHcJDNjYpz57f3w+K
         LIKNywJjQmhbgUDEptyo1H90GqZk95uw6fplRdSsALYfVI+UWRL8llt2U9vHD1h9Dp2n
         +Jew==
X-Gm-Message-State: AOAM530LqpFEEFd6PWZImXWuWQKEpL3De3PN9L125L6uykYCJPwshrYM
        GHAftyxbsUzxojR1qfxY0m46azs7xpJARKu0bcg=
X-Google-Smtp-Source: ABdhPJzgHzTYJsjhMusoI+ULGa8G1zZnIsq26YyjxJR2NE/uu7UiUOCx9MjxtF6ZrTA4VNyq91Lkdg==
X-Received: by 2002:aa7:88cd:0:b0:50a:9579:a1b with SMTP id k13-20020aa788cd000000b0050a95790a1bmr12891926pff.25.1650782478033;
        Sat, 23 Apr 2022 23:41:18 -0700 (PDT)
Received: from kong-HP (014136220210.static.ctinets.com. [14.136.220.210])
        by smtp.gmail.com with ESMTPSA id n19-20020a62e513000000b005048eef5827sm7818298pff.142.2022.04.23.23.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 23:41:17 -0700 (PDT)
Date:   Sun, 24 Apr 2022 14:41:14 +0800
From:   FanJun Kong <bh1scw@gmail.com>
To:     git@vger.kernel.org
Cc:     FanJun Kong <bh1scw@gmail.com>
Subject: help for git format-patch lost diffstat
Message-ID: <20220424064114.nwzldz5s2bnkrlu5@kong-HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, 

Here are steps of what I am doing:

First, I created two commits to a demo project.

when I use command:
git format-patch --cover-letter -1

cat 0000-cover-letter.patch

From 2e62ef46d5627319c4cb11be81079e3364fca40c Mon Sep 17 00:00:00 2001
From: FanJun Kong <bh1scw@gmail.com>
Date: Sun, 24 Apr 2022 14:31:45 +0800
Subject: [PATCH 0/1] *** SUBJECT HERE ***

*** BLURB HERE ***

FanJun Kong (1):
  Second commit.

   1.c | 4 ++++
   1 file changed, 4 insertions(+)

--
2.32.0 (Apple Git-132)

ok, you can see the cover letter has diffstat, just above "--".

Then I change command to:

git format-patch --cover-letter -2

cat 0000-cover-letter.patch

From 2e62ef46d5627319c4cb11be81079e3364fca40c Mon Sep 17 00:00:00 2001
From: FanJun Kong <bh1scw@gmail.com>
Date: Sun, 24 Apr 2022 14:34:48 +0800
Subject: [PATCH 0/2] *** SUBJECT HERE ***

*** BLURB HERE ***

FanJun Kong (2):
  First commit.
  Second commit.

--
2.32.0 (Apple Git-132)

Comparing with last command, I just want to get 2 patches,
but this time the diffstat is missing.

I am not sure if this is a bug or I miss some options.

I googled this issue, but not got too much.

Thanks for your time.
Fanjun Kong
