Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D454C3F6B0
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 00:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbiHQAgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 20:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbiHQAgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 20:36:25 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DD9895D2
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 17:36:24 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id y18so9419229qtv.5
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 17:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NZf+2uIcBCQhACRA6F8pVYHxgJ5QPup67jig1DDTkMs=;
        b=GQqIzai3CDkglEP6pTOd8Xd3KV/rkmOp02u1aRs/Wc2hEBcY24bx2GcSUpNjC410kl
         iL9ZAw0dbUIG7WadQ551g143/gAYsgWX6UsPS3Dgb8dTaXd137v1CO8AEHctgG4xHcG5
         b2nqpfx1iKnxyWZcfraPN6nj+QUDcl+anLrKe+/ZRpg9074dD3MinMazMilv0SxEHUp3
         y5NCS6b7oDOA5e3eyXmcnpOiIH4wOPa7slrgH5mRismGxlLmEDtBnhz2w1qa5KWYB1pl
         QtPPFYI7hYUURdbUoXd1pq2XIl9m72K5bo+4pQ+8lvcYybjgQtdjgsSU2zaUj/eIcNcq
         ZL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NZf+2uIcBCQhACRA6F8pVYHxgJ5QPup67jig1DDTkMs=;
        b=Lkx7zMum/hH5GoL2V08x7MxIQgwFpITl9DJthpFN/0Rfw5tTHNHpsDsmhV1FqLj6eD
         fTbNedSwrVUDpjcpSwzsHVrFYu3XCfUrruMbD7XMm9Dy9wp6VLMBnIQFDYDmtbdC79ka
         dRg3j6Z3yW29yw9Bl0tMMBUfZZb8Cx+yWI1fKUY4VZYFKzLg8C+zffC4oeycs4pHt3Q5
         a0GZY3EIug1erQ+fGPm/RHEBpnidMFznpPi2OSdqn2f5LvJ7OGru8B6o6nzVeWCSGJOS
         bwrwtJLNhOnd1+KtxKUzJHeCsHvzlrf6AJ2Z4oIJUZ7KV3+BhMLgHpfNZbwXcj8Nv3Vq
         LqfQ==
X-Gm-Message-State: ACgBeo2w7k2spROeWda59/bXKaxKumSh0sr7cNCfwwvbXGIP+AX3mP+W
        FAVG4aQOs+2DUn5nAYYDCWYn3GrY5r+BOphHN6E=
X-Google-Smtp-Source: AA6agR5DvjA9jFR0V3UdqmGTa1C+uFJ7XHSUL9Z8hdOBuyDySdi4XHwz1ufDX/kB+0yJxEMo/gPKVi4shNtaPqWqziQ=
X-Received: by 2002:ac8:5b06:0:b0:344:6481:86cb with SMTP id
 m6-20020ac85b06000000b00344648186cbmr9078043qtw.523.1660696583286; Tue, 16
 Aug 2022 17:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq5yityzcu.fsf@gitster.g>
In-Reply-To: <xmqq5yityzcu.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 16 Aug 2022 17:36:12 -0700
Message-ID: <CABPp-BFUSPWhx5GN0KrMzPiLWq+djhfaZQTz0y=r2MeASVrMRw@mail.gmail.com>
Subject: cw/submodule-merge-messages (Was: Re: What's cooking in git.git (Aug
 2022, #05; Mon, 15))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 15, 2022 at 6:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * cw/submodule-merge-messages (2022-08-04) 1 commit
>   (merged to 'next' on 2022-08-12 at ede0890319)
>  + submodule merge: update conflict error message
>
>  Update the message given when "git merge" sees conflicts at a path
>  with a submodule while merging a superproject.
>
>  Will merge to 'master'.
>  source: <20220804195105.1303455-1-calvinwan@google.com>

I apologize for being away and not reviewing again before this merged
to next (vacation followed by coming down with Covid).  I noticed a
few issues with v8, so I submitted a few patches meant to go on top:
   https://lore.kernel.org/git/pull.1325.git.1660696081.gitgitgadget@gmail.com/
