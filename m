Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877F51F6BD
	for <e@80x24.org>; Fri,  3 Feb 2017 18:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbdBCSUc (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 13:20:32 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37772 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbdBCSUa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 13:20:30 -0500
Received: by mail-wm0-f42.google.com with SMTP id v77so40570449wmv.0
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 10:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=known.net; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=R7FCHxBryBk5pEZh79KBbqUJx5foU9ZOkIctsYxBLa4=;
        b=fnapAJiyTPFTdPom6N+9UX0MJZe2ae0UDw7PwcErlHNMZNHN76dssWew6cpLpHA3ns
         EPXW4pSTcsN7Aq5YsFFR60g3JZlxKEiU41r7gWORkcAMRGzT7OierIoPoYOZ45Mx8rGx
         MSv7wh0nta4I23yW9d7MOsmioPaMFMjdWSb4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=R7FCHxBryBk5pEZh79KBbqUJx5foU9ZOkIctsYxBLa4=;
        b=k8/H4hJHmKV8XgIgWrCphcyYf0UobCatMu8kQysd5vlNKFnqhdkr/XyCoPEpg5QTSE
         1hiMbaKdALDp4PfEMs4ag6Xpt/tO+82fa7133kqCL1CJXrkkRif+VIvNmrO79RmUPwOF
         K55ERtCQE8DnMf+M7zEDwZNFKOrz7/Yctxt24QtsePBHZY8sHC9ZvabXukPvNQJiQ2Q/
         9h3H0nNRYxv3n2hQk6BCDVnWqpzApT4ayJqc4t9o5yHCBJJmyJrbHPIdJoTSNuhNo7e2
         hxSO2Yac+VGVAbAvqd33pgfV5jVlFlfFVsAMxIThJnun43vnoEmu/KAxWFkcl3Pjcxml
         nEgA==
X-Gm-Message-State: AMke39lR+ckfClJ6uepVZDTLiSSA5bVhCaD7Zz2JDX1I6ML6O1ZeMLNrhQi/k2InIh4hS0cyhyKSgq2af3qbFo2w
X-Received: by 10.28.139.74 with SMTP id n71mr2704328wmd.139.1486146023737;
 Fri, 03 Feb 2017 10:20:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.194.76.1 with HTTP; Fri, 3 Feb 2017 10:20:23 -0800 (PST)
From:   Kevin Layer <layer@known.net>
Date:   Fri, 3 Feb 2017 10:20:23 -0800
Message-ID: <CAGSZTjKywt28Pq7S+Hidi0XeseDxUAMEorrspZQ6jb50yic3+g@mail.gmail.com>
Subject: BUG: "git checkout -q -b foo origin/foo" is not quiet
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$ git checkout -q -b foo origin/foo
Branch foo set up to track remote branch foo from origin.

I said -q because I didn't want *any* output.

I looked at the git sources, on the maint branch, and it appears to
still be the case.
I see this behavior on 1.7.1.

Kevin
