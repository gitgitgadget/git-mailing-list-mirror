Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC90C433F5
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 02:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345961AbhLWCol (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 21:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhLWCol (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 21:44:41 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B2DC061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 18:44:41 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id kd9so3956567qvb.11
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 18:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DXogSIaBVpBNmmkFpwpnypUtudFE9B4CUFqUw8/sRc4=;
        b=N3GUgKHBzy7DFukPXT2HQ4pyiAV5HfILD0yvhY6OhEijbyBVVw4QJ7F0DrGhDqFaVX
         zsbRSqdqIYduBoH8x/1434bwK1drRHuY1sJ9T94WyUwSZ0YE2mWBvUaA04B51n+YSND1
         HgSv1ywHK8MTJ1OuUNCamKdwwdqsbYhIISKmkAU0RhV6ITmAk0pphJpOl8MIaYuEFzAa
         yiL+lDftxjLlNRjhgCVmCcdy8mQlQCYzfzZe76nzXFlcyNbIE4LI0/S4AWZ9WUs2pk/z
         Ws/V3w9mqvaPtkWbA2bQmOkD0iWUtS+9/mjUoddLbXp5YPLbzs2hOL3sFmc8Tr5o/u+W
         56Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DXogSIaBVpBNmmkFpwpnypUtudFE9B4CUFqUw8/sRc4=;
        b=zb0gan4G1nkKH3uJCqW9V0nKhD6Fccchrr70gY/OO8RuogIshK3MJH3xFhKXCb5SQL
         7ylmKRJsSgII5T7fTLY/h2juDKaTE6IV9Xk0yFTMpncVKvBxM+ykz6ZtzDWiENyvv8bS
         nHjtXsj3pKtsBuDDGYvnpqfFze7LRTKWLXFWsEl1uWbVf/mGwv9NgQTMXMajjCGcdFu8
         whRQpBEEkCeVd0CBWcHmP675Fkl6Q7Oh0jUyCueqkcAwLwc0Dl33rISISzhNqBfFJEm3
         VRGib45XMJ9gJ6jqZ7d+k2ItU9eEI7GWXbl1sN/csQ0b8Yww/8WzuuIsWrdiDmOw2sIZ
         ryjw==
X-Gm-Message-State: AOAM533jrd+RgatlbQwM43IAfEMQUi17o/Y13mm+wdFfD4aRzeUcjRC+
        B7S5Lu4mNTsiOvJBECEXEj1u3CCcDZbDoSndauo=
X-Google-Smtp-Source: ABdhPJw6UeJTIYIxB2XpVjsRA7rGP8+S5uwoPDrBIdGlJ0N5Y238XAxSYSqpU3fafHyxRe8HsrmASZzTMomJq/f1lGw=
X-Received: by 2002:a05:6214:2343:: with SMTP id hu3mr422135qvb.22.1640227480291;
 Wed, 22 Dec 2021 18:44:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:20ca:0:0:0:0 with HTTP; Wed, 22 Dec 2021 18:44:39
 -0800 (PST)
From:   =?UTF-8?B?2LHYttinINi02YXYsyDYp9mE2K/bjNmG?= <rshms3748@gmail.com>
Date:   Thu, 23 Dec 2021 06:14:39 +0330
Message-ID: <CANv3_vr66AjKZ4=DcNptQpo2T++OmDJeBP+WLDgWwcyusyTBbw@mail.gmail.com>
Subject: =?UTF-8?B?2LDYrtuM2LHZhw==?=
To:     11898207+NAQ1S@tickets.livechatinc.com,
        =?UTF-8?B?2LHYttinINi02YXYsyDYp9mE2K/bjNmG?= <rshms3748@gmail.com>,
        Cmail@gmail.com, freesupervpn@mail.com,
        "GearBest.com" <newsletter@edm.gearbest.com>, git@vger.kernel.org,
        info@bischoff-guss.com, M@gmail.com,
        Mapbox <newsletter@mapbox.com>, maskvpn@hotmail.com,
        media@campaign.who.int, opencovidpledge@gmail.com,
        support@alohabrowser.com, support@zendesk.com,
        ytandroid-support@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2K3Ys9in2KjZhSDYqNmHINin2LTYqtix2KfaqSDZiNmH2YUg2LHYs9in2YbbjCDZiNiq24zYsdmH
INi02YjYrw0K
