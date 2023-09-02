Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B5FC83F2C
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 18:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjIBSIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 14:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjIBSIX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 14:08:23 -0400
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Sep 2023 11:08:19 PDT
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3646CDD
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 11:08:19 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1693677791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mxHwfr5oI7cBNoiPFBYDBYVKVa0X7I+MjDlgjOIaqV0=;
        b=b3zNneqze84L5qtu5ryLOHoumDSOBhS4sVgU+1OhJZwET1c89bCXOO587jk3tOk4jNxu6l
        McRjtPA5JbdJ7q4tD6pjmtSYwQ6I3xXJqB9559zD/6BFcaWF7MM4buK6OqhFt0WWh0a6TH
        +HQHZ8aBs8Tri5oyla5E9D0ntuk5jFb3QFEhSZ1LJ7ZaZ2ZgPa8dQWhhxGLySEDy438pZO
        RWlM4FErqiYRiwm8VWyMgvu5JB3VYAgCWAlwDOp1Ye9qOqUuEaya+mwMYQG4yBvc9US4RX
        wLKcheNk2bp+V4fQKTO0CvlddHJ1e7DClMCSRoHwwPXgtPwb1CftoM6XILyR4w==
Date:   Sat, 02 Sep 2023 20:03:11 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     git@vger.kernel.org
Subject: [RFC] New configuration option "diff.statNameWidth"
Message-ID: <eb8f524eca3975f086715ec32a8a1fbb@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'd like to implement support for a new configuration option named 
"diff.statNameWidth" and submit the patch, so I'd like to check first 
would that patch be accepted and merged.

Similarly to the already existing configuration option 
"diff.statGraphWidth",[1][2] "diff.statNameWidth" as a new configuration 
option would limit the width of the filename part in generated diffstat 
outputs, just like the command-line option "--stat-name-width=<n>" 
already does.

Having "diff.statNameWidth" as a new configuration option would be quite 
usable, and it would fit together nicely with the already existing 
"diff.statGraphWidth" configuration option.  For exaple, I have quite a 
few aliases in my ~/.gitconfig that contain "--stat-name-width=<n>", and 
having this new configuration option would allow those aliases to be 
much shorter.  Of course, it would benefit all other uses in which 
diffstats are generated.

Please advise.

Links:
[1] 
https://git-scm.com/docs/git-diff#Documentation/git-diff.txt---statltwidthgtltname-widthgtltcountgt
[2] 
https://git-scm.com/docs/git-config#Documentation/git-config.txt-diffstatGraphWidth
