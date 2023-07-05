Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53323EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 20:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjGEUCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 16:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjGEUBd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 16:01:33 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963A4A9
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 13:01:32 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5577905ef38so3917a12.0
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 13:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688587292; x=1691179292;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQk/gNrrhJbg6z/h8WoPJBApbIlZQlViHHL1KjcLuuE=;
        b=JgcJipiQepajgrPt5CSdnI5b9sa1gdQFKo15nj4LulrbCU4gHls/jge2shLA0kOGvU
         JSdznR3t9p2kEujYqOoiLF59amNcPKuGDqc6GMJQVopxHalFO3Hgl4qfAybLpNjpxF2x
         0xy34xEhYpbyuP2+fsG8BPRkqQWCVPtKsV1CZUnvJqsa2c3m1PgZH9U+mm0o0xyTtTE3
         WR3N53WbZnucCJaYkFBtcNL3hducRCwzrArj1dZEpFXfKMLxNKiZr0r5JnllmSEug75A
         18AO9sgLPPELTqVLNLZ7JtWuZKoGz2jBkslFmKj20ZIHhBoP7pBx6J+UY1BWCFYPz2v1
         5M2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688587292; x=1691179292;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQk/gNrrhJbg6z/h8WoPJBApbIlZQlViHHL1KjcLuuE=;
        b=VLACT/orb0u25fc2qZ3e263EtclihrQx6KQtMy8NytaOQO0tg7HSU1vksLghRZFLr1
         HPdH9bUwytY/XjN//0vKDXB1EBneN13e6qiWK4pKn5uB8L2m4wYGjaPmThhx6jbla/Ok
         ESSSg4OSW3hl19YfEA9DSONfa3WzUlfql/qqpbVmo2jDiQ2rjKOFv4k7uFLqY0x/hXIV
         DpIEN0+OSZwKZPLtWYh+r6HB94m1cA2Rt8LAc82HW9I/4hZ1eOk04Dy0imR0c2oCF6e+
         BIuXj2Mr0t9bjW3F32TbPXXUG56yYq6r4wMzrKfyhkt2dmBtp96KR2rTec9YWCncQ5NL
         Oo7Q==
X-Gm-Message-State: AC+VfDzeVJz/0qZ6XF4ADPbVgEbbJ4D0dVLQMjBtnLLwTk+tiZothx+/
        WDOPio5a5P/tgyIZcJ/R7M885YauXLc=
X-Google-Smtp-Source: ACHHUZ6oPlgTe/dnYSLszGSOBAB/r5EfxRBPJfpgE4O0X5E0A3KGIYrcYlfqVZKun6gXzn3XiACLqg==
X-Received: by 2002:a05:6a20:9494:b0:125:7a4e:ade6 with SMTP id hs20-20020a056a20949400b001257a4eade6mr14748537pzb.17.1688587291690;
        Wed, 05 Jul 2023 13:01:31 -0700 (PDT)
Received: from five231003 ([49.37.156.238])
        by smtp.gmail.com with ESMTPSA id u10-20020a63140a000000b0055bc3b97f34sm2978794pgl.19.2023.07.05.13.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 13:01:31 -0700 (PDT)
Date:   Thu, 6 Jul 2023 01:31:16 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [GSoC] Blog
Message-ID: <ZKXMDNfVSOEMrot3@five231003>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIdrQybUsjEcxMrb@five231003>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Week 6 post is here

	Week 6: https://five-sh.github.io/2023/07/05/week6

Feel free to suggest any changes or comment on or off list.

Thanks
