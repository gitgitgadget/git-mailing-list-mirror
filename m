Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 415471F404
	for <e@80x24.org>; Fri, 14 Sep 2018 19:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeIOAYH (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 20:24:07 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:53460 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbeIOAYH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 20:24:07 -0400
Received: by mail-it0-f44.google.com with SMTP id p79-v6so3993303itp.3
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 12:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xRXORvT72eW1MPc4MbKjT56ME3DqgEfvlAtnMYO4mcs=;
        b=IHhUSLWzo+8f2dxgAxlbzJQF7866Uy3juhda4YtBI27y+d3TgeGQkXjPwUuhy3SAcu
         GwqTxrt2s+OY0ydVLHhDmpYqUpsan4WskiX7+htT31KeAmYxibALH8P6vwlNmb9crgaA
         WnwNkdhbJVeexZbU/a9f2efPtCUhEwKvlQy/Y+nBUopC+7TyOCsZLUns07JdhvYaqjCx
         KWbWN+QEzKGLL0uEIcfozt6wKQTwizA6MtSWWR/XHsCRL02pqw0yDB/+spbpD4ldgjIk
         z7tIPKpNsGtjMT+jXWrjqxtkYThxPPeUCHKuDyqlS/wlTWpsmOFmfVty80LWfymasCEu
         no/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xRXORvT72eW1MPc4MbKjT56ME3DqgEfvlAtnMYO4mcs=;
        b=RdU/EsauV8BH6O6y0WLmk/jUdHvnJiA8edcTi99pu0uKPmqAAnLJReRbizx7FKR3lu
         OGEFHMhrIRDLlgmpT8Lmc247t8Q8DBlFDFvzNn9SaH94la6SLyKh9QnnSiZ+uSO2k9vs
         7naD5cZpxtimkONjJzdH00jmDGHUXEOvbg/P1PgIVt3AUSN5Je245aZS5u4ayHEH5Adg
         KPioSeWhiwRIZhzpjz4gfadkmzD5jGtwWT/jAsm35faqzmNmwUAnF6NODQc64+iNbZC2
         gAJSmQhQ3xEYw4rraiWHsZYfVsumouhv8xMR9XdjCL/Nk3kZkkcOdx4s5x2u9n8P/06+
         krow==
X-Gm-Message-State: APzg51AITtaxSX/1jIo/nqozlw4Rw6W6DgmOBFUC14nDjumNu7o90Yzz
        C5g+U/b8bZSZHWo+M58nAIJ6k37OrdwnQLjl0+xXuZFzlR8=
X-Google-Smtp-Source: ANB0VdaeWJ0rMVJ5dP8YK8X/nHZZoATY716mduChTXz4t/un+nLNbIh6Zb2lXzKmL2iTDTsMHpkl8QOuZSHfyPEtGiE=
X-Received: by 2002:a02:3d8f:: with SMTP id n137-v6mr12208801jan.99.1536952098107;
 Fri, 14 Sep 2018 12:08:18 -0700 (PDT)
MIME-Version: 1.0
From:   Niko Dzhus <primenico@gmail.com>
Date:   Fri, 14 Sep 2018 22:08:07 +0300
Message-ID: <CAKd-JgStGb4Ka9Rs6G2e4ADQKZVrsJMsNGz1sRP_4Ej4=FtxtA@mail.gmail.com>
Subject: [Bug report] Git incorrectly selects language in macos
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It doesn't use English when other language is available as a secondary language.

Reproducing:

1. Open "Language & Region" in macos settings
2. In "Preferred languages" box, set English as a primary language.
3. Add another language, that git is translated to, as a secondary
language, for example, French or German.
4. Run any git command - git will use the secondary language, instead
of English.

When the secondary language is removed, then git starts using English again.

I have git 2.19.0, installed from brew, and my OS is macOS 10.13.6 .
