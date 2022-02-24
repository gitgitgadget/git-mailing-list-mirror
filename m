Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F73C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiBXJPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiBXJPK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:15:10 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCF11CF0AD
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:14:40 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id c6so1835102edk.12
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=RC8TbzHj7f6lEpQFfydOVlHv3l2BJKkTo8kJ/8YqlU0=;
        b=NzdXyzcEijxFtgtXgt+JsuIeXjRmor3h5s5hSDIVglufOUhix2cQZq6/OQCwkjyIoL
         oQ20StlDkkAgUvuYp0mrzrywM0xVmebkSeRjJKpnxIjK9lne7RuylNMUa+S+ZOcGjClC
         6o9ByF19Km2zzNjN9V9B5SZptdHhSscNyYb2c3UCdOkVtyzXohF4hr7nva94wM1Ltp+R
         G6reaq+KaV1H27qc2ClIQ9/oQDiBKe/U7zzNFW7Uc4aKe2QCiiQC6fvmUF6/9rq8Y2FL
         u195ecxQXr5EoZn8Tw0PmTdp7hfTJKacawRVd8RbnkU+kzHTGtMNc4mvUXfNhnP1xAyG
         cZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=RC8TbzHj7f6lEpQFfydOVlHv3l2BJKkTo8kJ/8YqlU0=;
        b=vsAa9FkZdY0/g+PIgWWIfHH5UjqUvz4MF16dB2yN6q3iFL0m/z/5IR6g8e6hSNggJY
         oQmsxWcuicUPdluu3jQaBkpkUDCWf3fHAIK6it/1X1bkMbe7IGcqF7SYiu2qOSON92Eb
         NdBxpvismVRi7KgamwUfk48lUILTspgRa3CXfs2LVKAYXNVkM6rBUrsaFEpX3VVBjHsL
         P2JBYLkGWEoymxmKcgy39An2XIAvEwEGBiyMORn87GdDX+C+nTsGZbbxYb5KwghfNGdV
         +T4ZYl88/G+B4ZLz7UiE/inQ1M3Hw+ZQU2LoZGACQDcoYoSmHjYiXVoDfCEAn5g7pGpz
         bHbQ==
X-Gm-Message-State: AOAM532Lcp4os8XmsEgGwnJzUepuuFEm+vtwYZOkAHawlInZUULHrS/2
        tBMwniiaU4833O/2RWHD9YvkmQepeY4=
X-Google-Smtp-Source: ABdhPJzEP6YXiOTnskTob9afIiOVARuQHYrLZwwKL9LQVdK9IcHfGsXThknv2ZiqCYaTuWUmz3Vx+g==
X-Received: by 2002:aa7:df86:0:b0:413:2d4a:5358 with SMTP id b6-20020aa7df86000000b004132d4a5358mr1379353edy.21.1645694078950;
        Thu, 24 Feb 2022 01:14:38 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p4sm1057185ejf.113.2022.02.24.01.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:14:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNACs-000DE0-2d;
        Thu, 24 Feb 2022 10:14:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: ab/c99 + ab/hook-tests (was: What's cooking in git.git (Feb 2022,
 #06; Wed, 23))
Date:   Thu, 24 Feb 2022 10:11:01 +0100
References: <xmqq1qztortk.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq1qztortk.fsf@gitster.g>
Message-ID: <220224.86fso8aao1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Junio C Hamano wrote:

Replying to these together, since they're rather trivial:

> * ab/c99 (2022-02-21) 2 commits
>  - C99: remove hardcoded-out !HAVE_VARIADIC_MACROS code
>  - git-compat-util.h: clarify GCC v.s. C99-specific in comment
>
>  source: <cover-v4-0.2-00000000000-20220221T160440Z-avarab@gmail.com>

I think all comments/concerns have been addressed here (thanks to your
reviews), and this should be ready to merge down.

> * ab/hook-tests (2022-02-19) 2 commits
>  - hook tests: use a modern style for "pre-push" tests
>  - hook tests: test for exact "pre-push" hook input
>
>  source: <cover-0.2-00000000000-20220218T204719Z-avarab@gmail.com>

Taylor acked this rather trivial series:
https://lore.kernel.org/git/YhBvBscyDAfndvSB@nand.local/
