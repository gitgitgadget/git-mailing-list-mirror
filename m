Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41A3C83F12
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 23:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbjH2XTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 19:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241176AbjH2XSr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 19:18:47 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8343B11B
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 16:18:44 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40a47e8e38dso71301cf.1
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 16:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693351123; x=1693955923; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GmCJEQC78HII8M5qBqA5eiGyKaEGj/0/5F+LR7Gn30A=;
        b=PaBiFEYBPz1kLEycO35tDWsNwri5ItI5CmdlZ6qOzKtFXp0DcAS44r9GR2eqjVyjFO
         yu5hg2XzRuyflc9zXne6OMxATq2S/QlCAN8OEaDbHNlwDw7WwXGZXSFHnoaEjy1pQ7eR
         1gyqzXT8kxc5UyISoo4li0SYPh4pO62RJXjiiy0QFL5WOycj23s2FLWGN/Tl/dur4G4a
         mk8nk1TT57kXQEaEGKPXxPaGq+o7xvZ0WKm1xRRxYOrf/6llI2f1JN2Fg2GkZiMlvPeS
         WbzrDbbGGnHm1opPmy58NeKRI8+k37JaCuMQLPc3xPHe3ir2tuZhIGf31jizqwipIdPK
         7jgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693351123; x=1693955923;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GmCJEQC78HII8M5qBqA5eiGyKaEGj/0/5F+LR7Gn30A=;
        b=IgKZsaKnwHQ5gcVLT7dCdUF29mdwppgN+3hTvICaA5TA0+yN9eeKK0Z70SwIfs/bL/
         e2CQaItiAeuu4y1P+0Shrd9GwV3W9QMix3E5blaO+Q1Nlqyd4AhCx7g/rLRNuuYcrCa0
         jpSLbhvQeTdmeRQ+jbYVeZq8WcieKZOVQWKMvK2fJDyIMNxr8Ow9czqKFNZP42oswWeg
         4r52uJjnBJUtGpa8+hg9K7OZPELOuUpSzQuhAeQ3nHHgDMlPYgPN+bSlhxAaor1srczg
         Hj4YjrYOFvAs9GqquSSNlUt5sTY4x77kBXeLr+rZ1o8bCQ+kM7VzCoxC+YKM/MXyUQLW
         0ASA==
X-Gm-Message-State: AOJu0YyQ3sNXQt6I4ncZEDYzKiuW5uF6cQBpAx3OCvwKbxJk5vGzqLuN
        +araYTNXZm5okZevmt3Xai6sc8kIq5GG18HsEWeQOM0WM6PrSh2mk+lOFA==
X-Google-Smtp-Source: AGHT+IFZxQXSB4G2VC/eK1ckto53/YzDe/bpyDHSiUrXdIZ9oZVTGrC4cup5RFx66moT8l6zFhtPMHShzU+bZ9tgmyc=
X-Received: by 2002:a05:622a:1827:b0:40f:d3db:f328 with SMTP id
 t39-20020a05622a182700b0040fd3dbf328mr422930qtc.2.1693351123452; Tue, 29 Aug
 2023 16:18:43 -0700 (PDT)
MIME-Version: 1.0
From:   Calvin Wan <calvinwan@google.com>
Date:   Tue, 29 Aug 2023 16:18:32 -0700
Message-ID: <CAFySSZBgG3QyqEXSs3t4LzGYw1VJrHPx4gomT0zSsWcvQLezAQ@mail.gmail.com>
Subject: Retiring Review Club
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When Josh first started running Review Club, his primary goal was to
train reviewers, a goal that Glen and I shared when we joined the team
later on. We've also seen other added benefits from the format, such
as improved community interactions, longer-term design discussions,
and a tendency to review patches that were getting less attention. For
these reasons we continued to run Review Club even though we felt we
were getting less training benefit. However, over the last couple of
months, we've noticed attendance in Review Club decline and felt like
we weren't accomplishing as much as we would like with it.

Therefore, we are retiring Review Club in its current form.

However, we are looking for new ideas for community driven events or
other practices that meet those same goals: training the community to
be better reviewers, providing a forum to discuss longer term design
and direction within Git, and improving our sense of community through
social interactions. I'm very interested in hearing any ideas or
suggestions you may have.

Calvin Wan
