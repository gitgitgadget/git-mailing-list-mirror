Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25104C433E6
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E499464FF9
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhCEAER (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 19:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhCEAEN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 19:04:13 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE09C061756
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 16:04:12 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id i8so85447iog.7
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 16:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=graphe-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=va/g+eGCN+hCANwcmOMIbwX1P/LFUiPMOSfypVIsbHk=;
        b=q2EOPZrqRG7No+NQ9mgI8kGucdXiPy901j4BTg+G9kioW28+4RIh2IVehaiqJiDAd+
         zWw9+fVgfxBn6vBvmY+cJf4H107b3FZ6CD0w586d8KjlLtvcnWO7bxRy36FASrgwVgJE
         hzZU/kQURrWGYTa2+y0RfYyhMsNKlJfosbqpx5uxMshmpGY6+V4002dxUitolbk5u1YQ
         Vata1xa/duI8Sde8EFAtSgbN070Cu3eiX0GvMvCIv3I/tjvuvjSqP3x7885QqRxdJmD1
         u8kMhg37IiA6IVlGTExKXSMyQgYKDPkhGqZXQIneuuUl+gu2GUK8OtIBSKCai6KDsg3y
         AuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=va/g+eGCN+hCANwcmOMIbwX1P/LFUiPMOSfypVIsbHk=;
        b=QRMVCJHYvqX8kO6qhqrlS/zfN2II292IUcnMxg2d0KQXTOqkG8GoZltjSErG06n9lF
         /OG8bqh2zAWKLH8A2mOlbvgaLtYEmFYiQHoWh7VxANo40n5Cd/PEw8D01KqPrFYPTa6s
         c+jmTC7MxkJIG6R1r9OOSjX4UHupYqgrjDxxUsEoyXmkVkz/HkKmrMbW+2TkCtBK9QOF
         hMv2Fy3DR6b5SoYxZVXfkgEuNylRbFk+gWKCfPvFs8Pm78xHcQNk3IFn286fFLx2bVyQ
         OXGcJ3PZfN8gt4O0wW1TM23DqdVKnAfv4eVRu/GJrViAnev5z9ToFrJguhkIIgOLAQh/
         vv5w==
X-Gm-Message-State: AOAM5331Q/tCYIURNz5K4GyGcxK1oA9HsLuh991rXdQl1hE7JH1Aw9lV
        JV/HxVImrVb4uYWtB9FfTwR2U9gTbNBCVuFhLIhDL/+ujBYfOA==
X-Google-Smtp-Source: ABdhPJwiL4YWaf6iqhV9IvqAwqSJoUlYT5Afkkt+3v1PvZRYDT8w+cWoTT58TjD5djLPfOwxQMA4cXgjxj3vSyg+PEc=
X-Received: by 2002:a6b:4109:: with SMTP id n9mr5533566ioa.43.1614902651818;
 Thu, 04 Mar 2021 16:04:11 -0800 (PST)
MIME-Version: 1.0
From:   Dominik Lameter <dominik@graphe.net>
Date:   Thu, 4 Mar 2021 18:04:01 -0600
Message-ID: <CAPhpCMJ-u+W5+6ckazo7JkeaPhkpGP_6hOSJcggor0CcYgU95Q@mail.gmail.com>
Subject: Found error in documentation, looking for advice on how to start contributing
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I don't know if this is the place for this question, let me know if I
should send it elsewhere.

I was reading a portion of the documentation today and found a
paragraph out of place in my local documentation, as well as on
https://git-scm.com/docs/git-log and in the git/git GitHub repository.
I have never contributed to an open source project before and I think
this would be a simple place to start. I've read through the readme
and Documentation/SubmittingPatches document, however with the
https://github.com/git/git repository being publish only, what git
repository do I base my changes on for documentation patches?

Thanks in advance,
Dominik

p.s. sorry if this email is a duplicate, this one should be plain text
