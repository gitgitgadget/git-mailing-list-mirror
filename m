Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 702E01F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbeHJTYu (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:24:50 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35629 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729822AbeHJTYt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:24:49 -0400
Received: by mail-it0-f68.google.com with SMTP id 139-v6so3544851itf.0
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrtsETl+u61/nBx9fzS/0hC8VX6zNfpOoTs0APBxtAY=;
        b=sBBnfwAitkOuZWZ2kj/gwoBZxOC6z5I9XFsMAGDZHPam5PXpcf9FLH4AC0UUE2Ueru
         un5xuniv1OYILPPF/QNeP2V66QD+Y7MsYlVrPwInKsvrDu/Tvo6k/ILOa3UOVygJfZA+
         l1p9gTv9Koklm4d6W9eGk+3MJ+kyqkJpmVneyNJdcj7wPE4SVtmo7C60Dx1E8V4Y6ZuC
         BWyVR0K6MW3Q4nLd9qM76+UzR9/wuanilQG7hH3VXCBz/6cS0j+2pH8jRDFibupm8sgL
         JFlIv30/xtY+hyG9zgv34x6ZU5mNFXVR7ZALQdJzv5K/+Yganooshzdj6z4DtyUbUavu
         G/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrtsETl+u61/nBx9fzS/0hC8VX6zNfpOoTs0APBxtAY=;
        b=sIEph7WzCFCtVgCEZ5xLYQWD8CeE74hbWtrZH2E6GURpoJCw+UeqPhc2NFnoF9BPa1
         3eplwZYNxzldWwtCLvY3Dh0Zkkoy0zGf8cKE/x9O5isd9PsiMKyZBqBtuRGHU+fX+8uc
         dn7pRz2VSg9h07JxE/nUF3iq9G1ejdAKQ3LQDVPekfktx5KWtbDZtML9gm0YOdlUBo7B
         9jMTeGBgWAtknc9iJfkQOHnemelBizGMwkFZw+9fb8e16VUs8HL7Wo8glnzG8XJ/JM6h
         7JIFrcaWJAMXbEbtrtvz+Dd3GS+54ZydjxOFuSLY61ehJzLO1nImrvBNzM00i60EOTXK
         qi8g==
X-Gm-Message-State: AOUpUlHSQl2Zk2T2pCrQ7U87A+W5s2MvEYSq8+K1LSB4hy0NVZyOMml0
        ttH/D1kwuM9HC+S91C0MWYRQfDaDpxJGiTuVRFo=
X-Google-Smtp-Source: AA+uWPxCJqcVN1VaksmrV1qBlXBVHYsxJc9Km3L0AwPntM9uxp3Fw1oLFRoAgtyqWMuOQJVNIv9IChbb6eMGvZywfPM=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr2928795itc.68.1533920050437;
 Fri, 10 Aug 2018 09:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180729103306.16403-1-pclouds@gmail.com> <20180804053723.4695-1-pclouds@gmail.com>
 <xmqq7el3qywq.fsf@gitster-ct.c.googlers.com> <CACsJy8CzuxjjLyf637dtTHc1wK-UFVnNjwa0O300kYOWehz1vA@mail.gmail.com>
 <xmqqpnyshhtt.fsf@gitster-ct.c.googlers.com> <xmqqin4khgm5.fsf@gitster-ct.c.googlers.com>
 <xmqqeff8hfdg.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqeff8hfdg.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 10 Aug 2018 18:53:43 +0200
Message-ID: <CACsJy8Ag3N6-A7YLOxBkE-aEUwB+PwNQr63GhiYoxjAsuRmQ5w@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Speed up unpack_trees()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 8, 2018 at 8:39 PM Junio C Hamano <gitster@pobox.com> wrote:
> One more, and hopefully the final, note.
>
> ..

Much appreciated. I don't think I could figure all this out no matter
how long I stare at those commits and current code.
-- 
Duy
