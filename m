Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2779C46467
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 13:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiK2NI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 08:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiK2NI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 08:08:58 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC5559140
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:08:48 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b21so13335610plc.9
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 05:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIlcIgXGBjFV2kMHEMzJBkT3pC6erC3EZ30MXaLrfuk=;
        b=b4GNVbnMmRpsXwITLqf49dEN7SNqBirhqEyM6lx2FRR3HSfEA1oKMClNRZsGBXjU1W
         kupN79ysn76ZxBCIf7p82bqvRFT908Psp3FdKn2YYcfgcLR/P5OAxZOBhjU4nRcuksaR
         k1uAa4+30J/pqwd/YHEC3n3fH48oyMvxlTDZfXlefZ/JbthOLtmG2d86xlk+GrvJ2kcT
         U5N4VxtcxLil+/OsG/ULAK7HMcwHuqp7uqEIizYmAbNoK2qxIcmLOVzBzwzykabs5a6H
         uY4r1W5JUSxDd4Ce00obV0rSeBwHiaZXDfLzunpQ3HBB+VPnlSszPkkLAVuF32sCYiao
         6qhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIlcIgXGBjFV2kMHEMzJBkT3pC6erC3EZ30MXaLrfuk=;
        b=6JX0r/9KxrwnxsK1WEVJzefB5pfiCOtmltlvrN0YEnuTgOTWsYsMrA83Dcczp3IbvI
         2TnuBufxjsyh5uKIF/IrX0L3xjmC0NUyhbRZ0dE3ornW4WmcKwTTW+h2eZQWgHooxmkX
         rqRLxl3UiKLmDgGmvGoVsvLSv0BQqch2B3wtvaChyQBf8fqWX4rj61xm/RfKkG29tYut
         lmPxo66ZNeE7ZYytldjTUILHKnRydo9dwa4djo55ZBi31QJxdC8BnmdNFlynZSGzEj2Q
         QxL5ilxdWzWmtsPxtW0peJh716ig4AJYlGtwXRzf4xuF5cu3pyLGkt+vN/UWjQ7wzgk/
         6+qA==
X-Gm-Message-State: ANoB5pk9RvGJDIs5gpREfpxnjNmEV6MdCm1UZTjJRhWhVLeFD0h6cgUv
        Q+CuJrgUZaKGfRZRb7JtdGc=
X-Google-Smtp-Source: AA0mqf46ZJgniej0AMcWP1XP6VSmGQSK/yhimfD0+M8I6AOj49jq6wMWr2zBYtwhRmXYEhhx+W7mAw==
X-Received: by 2002:a17:902:d711:b0:188:c7b2:2dd with SMTP id w17-20020a170902d71100b00188c7b202ddmr38541011ply.88.1669727328311;
        Tue, 29 Nov 2022 05:08:48 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.61])
        by smtp.gmail.com with ESMTPSA id k5-20020aa79985000000b0056ba6952e40sm9895581pfh.181.2022.11.29.05.08.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2022 05:08:47 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     git-packagers@googlegroups.com, git@vger.kernel.org, lwn@lwn.net
Subject: What's cooking in git.git (Nov 2022, #07; Tue, 29)
Date:   Tue, 29 Nov 2022 21:08:41 +0800
Message-Id: <20221129130841.82302-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.385.g28306b7e8d5
In-Reply-To: <xmqqr0xum8tn.fsf@gitster.g>
References: <xmqqr0xum8tn.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> * tl/pack-bitmap-absolute-paths (2022-11-29) 4 commits
>  - pack-bitmap.c: trace bitmap ignore logs when midx-bitmap is found
>  - pack-bitmap.c: break out of the bitmap loop early if not tracing
>   (merged to 'next' on 2022-11-14 at 34eb0ea05a)

Will the two commits which merged to 'next' on 2022-11-14 at 34eb0ea05a
be taken into 2.39.0-rc0 (or v2.39.0 is frozen already)? 

>  + pack-bitmap.c: avoid exposing absolute paths
>  + pack-bitmap.c: remove unnecessary "open_pack_index()" calls
> 
>  The pack-bitmap machinery is taught to log the paths of redundant
>  bitmap(s) to trace2 instead of stderr.
> 
>  Will merge to 'next'.
>  source: <cover.1669644101.git.dyroneteng@gmail.com>

Thanks.
