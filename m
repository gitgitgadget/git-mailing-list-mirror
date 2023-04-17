Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708A8C77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 20:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjDQUIP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 16:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjDQUIN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 16:08:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B56F0
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:08:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-506714f2c33so5760a12.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681762089; x=1684354089;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ASpIotCeARsindZMZgus1fgy+QULDrJ+6JymhFeRbsA=;
        b=a5qP7O1nfhs1XgujirGFb9/9gy+4kkyR1JggTvIO2MkEXqU9VcXU+3OPKMyMTIpkL7
         y5Gb0b8F4Zc/TpmtpIUfKMQWUsQVLta7jrwr70y3pxPuTRzSc/CVrkpXY8YsMMa7y/h0
         wDy08zJXnWcChNGOOp1Y148LKUfVcsYUrdSJE8vV8i4XH/ODqWIAfd352vMrtyxOoN90
         bFRX+8nB0ILw8soxtXBktShMdiVWQCvgTlxhdhp2v/n3cUpcxXJyQV4JsNkpgU6szyJK
         sSyXJfVO/Zw9uxvGTfICWJwQA6oGnyPWmZq8oCk3t5nM7BgXmWr1X2LJi7OGDwspqyNW
         0NGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681762089; x=1684354089;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ASpIotCeARsindZMZgus1fgy+QULDrJ+6JymhFeRbsA=;
        b=d2eXJfs4gfKvsh1sqKi/qYQBYo/wHb9pwTcP0Q8+0n1unRnKcL+v3+Ar/yDSEDyDBa
         DCX1Mnfp1BB4yJNpCTa6R6X9OyCnVXB9dTaItfN3ju3Uy7USI/Qz3BvH/YUfMcN93jjq
         JyS1t6nFx9DgQ0Ct8btTXD4NWsKKQtRdYunnfcjOPa0IiFmhR5K/65WkyNbsovC/78Uv
         G4tPNJtWqs1PhA76RM22RusD5zftfOqd05IqeydkC01NG+7T3uCw7fmtq4jWE9DTzOd2
         yUI8iA/+gIC6wSzabCOSrBIRSCPH6cUsCeu4K2QidVgHq/Krl7NbIcpIYPQM5hoRFBmv
         wbRg==
X-Gm-Message-State: AAQBX9dACugL0p8xtqSIc+uo2Y/pKhBO55adleDA6JnjIaIYk47ju6Ei
        jBNSLumhbdQ9kLYCzdMRCqseRmXUsL7tFB6uK0EkJ/6FWNzDhpN/QjLJNg==
X-Google-Smtp-Source: AKy350Ze2fSLHkF9WSDPINXFghP48I69OzzFQGZIjbV7fx/0CmQssC+FLhNPflAsZ0XIBA/IaTTPKIFw6UHxmHQvQ9c=
X-Received: by 2002:a05:6402:2484:b0:502:7e99:a1a7 with SMTP id
 q4-20020a056402248400b005027e99a1a7mr12985eda.1.1681762088951; Mon, 17 Apr
 2023 13:08:08 -0700 (PDT)
MIME-Version: 1.0
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Mon, 17 Apr 2023 13:07:57 -0700
Message-ID: <CAJoAoZ=FHmY=-xvdscFOXiuJmkZidZWDvFia-VH3Zoac+zhNwQ@mail.gmail.com>
Subject: Planned maintenance for crbug.com/git tomorrow
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

Heads up that tomorrow the crbug.com/git (Monorail) bug tracker will
be placed into read-only mode so that we can move it to a new stack
with equivalent functionality and ongoing maintenance and support. We
expect this maintenance to take a few hours. I'll send another mail
when it's completed.

 - Emily
