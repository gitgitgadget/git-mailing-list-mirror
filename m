Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A849EC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 17:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiF3RLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbiF3RLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 13:11:16 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711DC3ED0E
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:11:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id d2so28523371ejy.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=dvjhRwJJs23bJJXP0Lxz1WxAJra7m69lNu51vnhhjQg=;
        b=TgxLPsUspfkKEcEgVs0lbvE/bGxhEl95T78C2DaDpS7YoS+2JxYrKm9TbGPMw2sOsT
         la8tbKITOBrdUYCse5v4BNkXLCOJZn7HlT5wrR8I12j3tqSpeeF9B26y28jJC2BNhB6P
         jVdBNMLhN01jFxqtLwkWceKCG5yNUskaW/wjQy79ZbByLI1cophElBiJ1H1D8KkEuCU4
         bAmCefnv51IwhvibFtLlopsjXPUdUmHzls4QlpK0FQ9NDTiRIUCxuJRbRxaSPJBkKASK
         J056npafyb0z6K7CyTaQjhQs+9Ze2z5xDCARpcIlWqm6Ld++pkFLZwxYaB4pDRxn0o1H
         AdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dvjhRwJJs23bJJXP0Lxz1WxAJra7m69lNu51vnhhjQg=;
        b=cxMsCXluv93lDjagHcOvJxM18ZyyE92x0CWcjVI5VONH/nnhxJT1CiQhLvwzWCxgVp
         Y6rUbHrOs76ci5EVFkOsq4iEfF/liuaNytFK+ky9G4qdsswTYLOR1aJzGmHQdvxiimDB
         T9FjXI4beQuYmOsNUkYOx4gCn2+4iZXExFHSiEOALdvmgsFgbaJQAfaVgB1rmfZS7ntP
         aNIJ1pqSRd4U7wTJhVIOEwMlURYi5z8wg649r6E2jYwYpTnkcAao7ers70MF2t5GB+D5
         r5vbULSCIgIO+uPDCFxtHtOt5yyZXHa/EkbrxOVXRFQYG4FS7410Dk9hvK1nwjDKry8h
         JmaA==
X-Gm-Message-State: AJIora/CPfUrjY/YixMQImdQbe/XBpVe9mJ+m20BInEl2t6cwBdB4Y+w
        laMMJzKN+kNJGgup9vFQEkuIAYuiqLg/4e6fb5EMRGz1F+s=
X-Google-Smtp-Source: AGRyM1s/kNcYp1lCa4wEfaySsXDrsfXv9cf6qO05OTGCYVGdq+5XyZ1lAUDZZwaYTi8gpaloxrJ0sLGkwj2ddNTmCmE=
X-Received: by 2002:a17:907:9693:b0:726:372c:2c02 with SMTP id
 hd19-20020a170907969300b00726372c2c02mr10063342ejc.483.1656609073812; Thu, 30
 Jun 2022 10:11:13 -0700 (PDT)
MIME-Version: 1.0
From:   Eric D <eric.decosta@gmail.com>
Date:   Thu, 30 Jun 2022 13:11:02 -0400
Message-ID: <CAMxJVdH+o+H56tJ4UmD8YcsNsLuutiUXpOP=euQbomBe1kLkMw@mail.gmail.com>
Subject: Option to allow fsmonitor to run against repos on network file systems
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I can appreciate the concerns expressed here:
https://github.com/git/git/commit/d989b266c1a7ef47f27cec75e90f3dfefbfa0200

However, in my environment, our file servers are very capable and have
the requisite support. It would be great if there was an option to
override this check and allow fsmonitor to operate against network
filesystems.

-Eric
