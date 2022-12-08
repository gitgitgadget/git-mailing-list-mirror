Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8D3C4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 05:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiLHF3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 00:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiLHF3N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 00:29:13 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5345E3CA
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 21:29:12 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w15so334218wrl.9
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 21:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xmx9tsakjOiox0qONQR0VYdqrPF6oqP0wKOR95rwHZQ=;
        b=LbzfMlzSpGWGBdHX7z4oEs/gOpecQp9lYpXJD6K07N1L+td8Qm7Y/vqPIyewTEtQga
         m60av6tydTI7cvCRH6tT0HQZdXkOo89wXhQra44JLfOT75AMA/BmC1HyhpVqSg7OaLaG
         1qIQNKru2kPbaaE2ULUhQztsVKiq+1zVBdS3PwS/j0RtjlSqM72a9lRzHFd82jT8frmM
         KVNsdpFQInbvaBP4N5WH74N/znlo+G5MPBOEamYXtsGQ6C9whJMJX2yAocxoxNJnIHp4
         VZmigSp3tAtzxSw2QF7YmXKsMxtANss+zEPPDIJmSz03b8RWFnuelxzyqOT5lAFVaFYN
         XemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xmx9tsakjOiox0qONQR0VYdqrPF6oqP0wKOR95rwHZQ=;
        b=OSK9sQZHdP/Va6SOTc7HHppQVsAB2/0pJxJJhNF7NEP85I95SNCW0zJcC03a5OwSvP
         07DUN+71kdfF+fqWSm/sl+70EbTDRTLb6+iHCB6C56KNUbvHWhlawqyonVLIXqFlccS3
         v84KGfGUhf38tPSXRChWeTegsaXrFHcoyT8I2+SHMl1+VqVGE05myvrAb45MIc1hRjo5
         sxdr79xHtU5rFeTI8JzM1bVYEsWwfKVN7+dhgbuG50VtfneExDhFKBoTvPUYoRQfe8ni
         pQIdqbVRokzgoWRVqZdixBJv5A8JDR8/TcjWdLPtYuh+KjNCHxwphidy5dnD6XnTjMs2
         I8vA==
X-Gm-Message-State: ANoB5pk4qntiL0WybQhYcP3UFJp5eyzx2VXhIEOYK3T+qeEnOhQGIATG
        Va9QUX1EjuGhHgNyHT7dPDMzuliQXXUgs2oY+qaAjvG6
X-Google-Smtp-Source: AA0mqf7Gr7YkylQWwWHETeBA87BiQCxERK/KCOjwxGQlRukxl0FTie2sKMZxOC5slzIgqLU5tm9UL0rwtzH155niaDE=
X-Received: by 2002:adf:e58b:0:b0:242:16c3:f1ed with SMTP id
 l11-20020adfe58b000000b0024216c3f1edmr27834383wrm.500.1670477350152; Wed, 07
 Dec 2022 21:29:10 -0800 (PST)
MIME-Version: 1.0
From:   Jensen Bean <jensen.bean@gmail.com>
Date:   Wed, 7 Dec 2022 22:29:01 -0700
Message-ID: <CANqKdC_ZULE4ABFTrRfC2JMkJp=i83MJy+PZ-hdWzWGO97gYHQ@mail.gmail.com>
Subject: Bug Report
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 H e l l o ,   I   d o w n l o a d e d   g i t   b a s h   2   m o n t
h s   a g o .   E v e r   s i n c e   t h e n   m y   C T R L   b u t
t o n   h a s   n o t   w o r k e d   c o r r e c t l y .   I   k n o
w   t h i s   i s   n o t   a   h a r d w a r e   g l i t c h   b e c
a u s e   t h e   o n l y   t h i n g   t h a t   f i x e s   i t   i
s   u n i n s t a l l i n g   G i t   a n d   a l l   o f   i t   s
a s s o c i a t e d   f i l e s .   A n y   h e l p   o n   t h i s
w o u l d   b e   g r e a t l y   a p p r e c i a t e d .
 J e n s e n
