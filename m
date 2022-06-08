Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B8EC433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 17:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiFHRWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 13:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiFHRWW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 13:22:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016024B09A1
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 10:13:10 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s14so18178359plk.8
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 10:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ECn5bBBOn1ZOmaHbu9NJwmhsf+Zr2Uc6Hx2CDyjgRA=;
        b=pVWpQsUyrqTW5MZ9aXL9x2y8uZHkOTm04uUXYHxhY7yB23ftOOTJlDS4cZKiAVKuS+
         XSq7rAmfrr0mxjfHVaDYg30dWXjgRDBkZ2lQ4jpYi/YWqIecLhnfKgIXkPY5GWXF5+tt
         vIbp8a4/fGCn4rdtXNvPrmTPHJVmE/MibYxFRkJXhImqOx95xqE7jYEX764aRihXv8uC
         1kGStW1w+9lyyEcb7NTJ8J7tl1aAoF08ao9jHNbyiNcD/pK0ka1SkzBtS0DzztQaRwSR
         a1rhyuNvZpOVjS5QPZOEb9OHoca29m90M7rnOVLSCQQ3OLYdU5mEyOlDBVsvO6gPXCu4
         OYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ECn5bBBOn1ZOmaHbu9NJwmhsf+Zr2Uc6Hx2CDyjgRA=;
        b=VQmX+KFS2KdssCDUBandPDB7esrdPoVAv5aRa2zxNfwSDgGf0232r0SlmLdZw7aq2A
         gmJFRUdl13MvNct6MpYA6bAnSe8ApLElTGlCRzcRQh2vCuFjbSHyMWnZ9h/2LJjHfBaI
         N0xR+ANZrH338xA0fps+sQVHB644S0H+lg5tZsBXYcZ9bPWtiFfao9jhRWB7MvzCtkLh
         QhybbXJu78rACQfCNqqYlb2B0l9YnbDaIDMJLiGGs60cedcN6UuR51CsXhWWNltRJ4nr
         bwRPFp7ISGLtxM0PjplR8NSorLi0zy6BnFUZcKw7x5IAIswtV+35CG3U/lW4GPXIrXzS
         dvWg==
X-Gm-Message-State: AOAM530rkiRKj/18wB9OtacgIi+BoqhrdH7q68IvgDfSnHrNHvNNPtYZ
        YW2Cf+W0f5nyyJG9SkYDTcY=
X-Google-Smtp-Source: ABdhPJytp/Bny9eKGP+sKaAolF9HxJHnmGGWyT2pjaI3e2fidelVnPzQ98itHVDlngmMHOJuHQO+zA==
X-Received: by 2002:a17:902:e845:b0:163:ebca:a025 with SMTP id t5-20020a170902e84500b00163ebcaa025mr35278586plg.81.1654708390442;
        Wed, 08 Jun 2022 10:13:10 -0700 (PDT)
Received: from localhost.localdomain ([2409:4061:2d90:e070:30c2:fb1b:2653:5119])
        by smtp.gmail.com with ESMTPSA id e23-20020a170902ed9700b001679a4711d9sm3647801plj.162.2022.06.08.10.13.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jun 2022 10:13:09 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/3] bitmap-format.txt: fix some formatting issues and include checksum info
Date:   Wed,  8 Jun 2022 22:42:57 +0530
Message-Id: <20220608171257.10455-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqo7z4ur2i.fsf@gitster.g>
References: <xmqqo7z4ur2i.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> No, this is not quite ready for production.
>
> Almost all the "indented" material are shown in fixed-width
> typewriter format in the resulting HTML output.
>
> Look how ugly the output from it is.  Not your fault; it is mostly
> because when the original text was written, it was not even meant to
> be given to AsciiDoc.

Actually, I am wondering how git-scm.com is able to produce a html page
for bitmap-format.txt (if it is not passing to asciidoc). The design of
asciidoc generated html pages in `make docs` are not same as the design
of production html page designs. Probably, production uses some extra
css code to beautify the asciidoc generated html files.

So, the generated html file (production version) is not as bad as the
locally built generated html. I need some understanding of the working
of git-scm though (to verify it).

If you see other locally built html pages - they would look similar to
the bitmap-format html page. But in production, they are beautiful enough.

By the way, I forgot to inform that https://git-scm.com/docs/pack-format#_original_version_1_pack_idx_files_have_the_following_format also has
some weird formatting issues. See the <pre> block after the pack-idx structure
drawing. There are other issues also which you can find (like having
unnecessary indentations e.g. here[1] the second block under the "The header
is followed by number of object entries....").

Thanks :)

[1] https://git-scm.com/docs/pack-format#_pack_pack_files_have_the_following_format
