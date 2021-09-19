Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD6DC433FE
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 23:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F7756101B
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 23:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhISXwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 19:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhISXwm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 19:52:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DB3C061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 16:51:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id bx4so9112044edb.4
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 16:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=n5a5372LcNZgsDE0R4J9pI8Cyy/nNUOGBaGRyKPHQFw=;
        b=KZAg9XQ8KB84qAcLtm3s8/RKimWou+nO9xmhrrZ1DkVqaSFtv8E5OLGg9y3fRXDESp
         U4IICdj3P2XLNskab9G9LinKIxuaSVw3cHFPO4tRdop0H/sAV/9DFgpU7yO6uA3kqfJ6
         j49V+5Cilgtygkw1SYs1+Rgf1QVyvrdFAHpvg+sPcuxriBcI42t5MESxOL96gTrN5Azk
         nJwj42l0DFGKjYwCanaXkvQydI6H1Vp0Ffuk/6VHsZoKzUV4OgCHU1Cz/iSXCTAGjbJ8
         K5fSlbCV6hf8rrg+wakjZQijrqQdZV2YRDHlPwTtA3RgOfuypRrEfCTEOBrD//ZnI5Hf
         7vkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=n5a5372LcNZgsDE0R4J9pI8Cyy/nNUOGBaGRyKPHQFw=;
        b=XAtGNaSosAXXGVrsPojHdFp8Gn2jDgNEO9BSVgGXOfBhoQRVjtF4soSPsdQ2WQZPFt
         WybJ94Nwq0POKRcNmbSERqbhgrKNRaiHxGwqZTtnaM57YkKFrQW/iQQVQhXUdhrWnJs2
         89HRbDkKrKk20w0D0lHgOOQpudxc8jfQs8OjIYijSEroKmSY56Hku9XoSIuMvrIRJW2W
         3u6u1igCPRem6x0Iw7TTn+i6+jvUmx7EbWUaVHSi8ePQEBEfgdVfaOFpOjha9cGfbKqr
         FYTW/lUrzVVOa0RgJE3ICZ1fva5BxSK7J7tEQQnmXsyodTkDgdBtyyzDsaOv+ckxI4g+
         7t4Q==
X-Gm-Message-State: AOAM532UMQnwgjpyHE4hVob4Jhc19M1QkjzsKp3vTDmp8TzqM4cTni72
        tiHXlvicDLI3Q8qTfb+v+jiWgPG+MF572fuhUWoxmF0A
X-Google-Smtp-Source: ABdhPJyJVm/C/EnKbknKdkklSZJeFFVuyEFqmfQPbp4IXbPNODeJf+isecWYAeodSZWKjYhkpC1WnzcGcepIvWjI64A=
X-Received: by 2002:a17:906:fcad:: with SMTP id qw13mr25096426ejb.127.1632095474197;
 Sun, 19 Sep 2021 16:51:14 -0700 (PDT)
MIME-Version: 1.0
From:   Aaron Gray <aaronngray.lists@gmail.com>
Date:   Mon, 20 Sep 2021 00:50:56 +0100
Message-ID: <CANkmNDf5KVn7Afj9xtvMGC0Ua7G6O3EOjBRtAfBOKOnaYgqVXA@mail.gmail.com>
Subject: git diff --git-ignore
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Is it possible to add a --git-ignore flag to git diff so I only see
the diffs for what I really want to be looking at, and not what I
don't ;)

Regards,

Aaron
-- 
Aaron Gray

Independent Open Source Software Engineer, Computer Language
Researcher, Information Theorist, and amateur computer scientist.
