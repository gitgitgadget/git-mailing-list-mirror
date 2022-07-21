Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E2CC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 16:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiGUQuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiGUQuF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 12:50:05 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBDD89EA4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:50:03 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id j3so2600938oif.8
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ostif-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=HEXlHXubCZwGuOrvGczC0nm+d9eapl7iV4h8gjkWCio=;
        b=w99iQkQApNBixG2acunL3c5Hlzhty4W7/FyitGeZtJVQfwiUK3T++PhT9lHT1y8m7r
         yGypajrsvFTBHJFyDkC+5ghrrpDRpJkDqL0yVhSL1kRBPkWQ6vEVKKLf0SPxNF+bAG4G
         DipJtVFRDI60NSRW0robTvKsXdWPJjWkKlaPIFxWnAPAUiB9ZXXNb0HP8yzvVBM0XEX8
         66i4+rg1tFZ5HHkiSKLrimvze+iHCbTcQVwKqoeQcVaea+5FQMYjYWmd15MUC3iXitUt
         2bHHabicPkRUcBQA990CJmCfyUA78AvXpAM5Gclzpsj51lmgVAsqdxyompSeiaRKefir
         tDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HEXlHXubCZwGuOrvGczC0nm+d9eapl7iV4h8gjkWCio=;
        b=cSmgTOQfKqnzxF0BmwZrOBPQhd7Mn+8O/GBYpqH06fiHSIh/hOeCSPRh2FPHYls/0/
         wbiGcY7Jjty5i7asshZaH5lTnL00irwSf3P3zrjKY2H8qfi8/HKVAIyqfHH7+0Fg8QwU
         MrjYhuOgvPZu7tJFATCKqH/TGoAq1sQ+4RQlTmpdE1SOyM8FHrTAOEUOo/MUMkRyEJs2
         +0oOWQjCnWMly4mQ0yO8XrHdtu55tT2rnN+CxDkq1gjbV+QgOBw1EbLMfayxAIBeF7Vm
         6KetgtdZKkLd02a8FaDDvmi9QNRu5Z+aN5ovdYZnY5gPAYzsh3NXRRqXZefPSRPc6LPm
         DpEw==
X-Gm-Message-State: AJIora9cZxwTOOPPifYHIRxoKyfMApyxBcPkMx5zcaxKf22AKQbMLAoQ
        aqa/FoMpihIQopth0DD+qIL0kYsRh0NvX5diPT47PwNX/5PuZQ==
X-Google-Smtp-Source: AGRyM1urZpXDFz9qNK9brZeFKqeIimdu02J19cnOyiAouuJLOcLfRejdpc+AP2JAc57ewj7um3rCpuP/z+a93ldl1WM=
X-Received: by 2002:a05:6808:20f:b0:33a:73c7:8ea1 with SMTP id
 l15-20020a056808020f00b0033a73c78ea1mr5162887oie.137.1658422202448; Thu, 21
 Jul 2022 09:50:02 -0700 (PDT)
MIME-Version: 1.0
From:   Amir Montazery <amir@ostif.org>
Date:   Thu, 21 Jul 2022 11:49:51 -0500
Message-ID: <CADKuG0uzh3syzgfiPLepiTLXNzkoYhLFX1h-DE3C7c8j6HXALQ@mail.gmail.com>
Subject: Coordinated Security Audit for git. Contacts needed
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello git maintainers,

The Open Source Technology Improvement Fund, Inc (https://ostif.org)
has put together a coalition of 18 security professionals and
researchers to conduct a holistic security review of git. The
objective of this email is to inform you of the effort and seek
collaboration.  We feel that the more we can engage and collaborate
with git maintainers, the more effective and impactful our security
review can be. An overview of the teams and work packages is as
follows:

Git Security Audit Work Packages:

Git source code review and threat modeling: This will be done by the
team at x41 d-sec with support from Gitlab reps.

Supply chain security / CI infrastructure review with Chainguard and
support from Gitlab.

A new setup of CodeQL for git with Xavier, Turbo and their team from Github.


We would love to collaborate to establish communication channels with
key maintainers. Would it be possible for one of us to join one of
your community meetings for 5 minutes? Or is there a key person we
should be engaging?


We thank you for maintaining a key and critical piece of software for
the open source community and beyond.

Thanks again,
Amir

-- 
Amir Montazery
Managing Director
Open Source Technology Improvement Fund
https://ostif.org/
https://calendly.com/ostif
