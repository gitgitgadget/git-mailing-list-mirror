Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E983EB64DC
	for <git@archiver.kernel.org>; Sun, 25 Jun 2023 18:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjFYSMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jun 2023 14:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjFYSMl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2023 14:12:41 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA75D1B9
        for <git@vger.kernel.org>; Sun, 25 Jun 2023 11:12:40 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-55e1a9ff9d4so2408412eaf.1
        for <git@vger.kernel.org>; Sun, 25 Jun 2023 11:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687716760; x=1690308760;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPbcEB+G/Q124g+8Z25pb4zEtRWt5fONp3HJiAgxqmk=;
        b=MhSpBL5FzQDkno7bXO/p3VijXhyLFkcXfTcQYnrwuZNj1H+CwnNY+4U2tjfqncIH+5
         2WtE7Y1dsNBljBuaI36hNLSserpSC8fspSF0dW7Uc4kdda5Ecd6bNevLzOzXayxf6mWm
         xnE4zEGarRVXWmp4cVE58Hb14lPInq826h25NtZCj7n+9b3cKRfkQHcjA6k1n2VAeVle
         3zhXn+P3O5mP3ZCUtSEMcY3UGt/TtN9Z4VMFHMlHILu636sRqk3ux3b1T0O0iInaVfCd
         n6mptJg7DgKTexteOiHlRYv6nzDfldZKDVKxI4GYb+SbQtDxrX/BFT9rFwdDBlkHJz5l
         bBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687716760; x=1690308760;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPbcEB+G/Q124g+8Z25pb4zEtRWt5fONp3HJiAgxqmk=;
        b=P8xx6EzzLg1WHkxI4CnAaCdY3/3be8UmjK1+ZCrZc/comxz25S2t6Dgyoc0rLADQd0
         0JqczmTRK/H4hFTkLaZ4XsqF8R/R7P9GYlxF1/Y5RjuMfJo0BukRIcJGfFWrYTldWcyB
         xkSdv2Jzft2FOKcqjujwLnBDmSpodzeNx0A36ShAxdUJXIDAi7vMj8pAo5jWIHM8QT4K
         ZB+kZ0bTQg1lcq7Tuqbu9Ce/V6Z2GtjdT7pq8lHkNPCMqoAl916lO3sISxkozzL6FYub
         J4fOAgNH9CaZqZkQjnHXeJCxb7kgqKY5HaLyL7Z7An5r87QU7eyIyEQERw0Z4+R0trRv
         4tuA==
X-Gm-Message-State: AC+VfDxLc4qVeuKdd0gEtqgnStfDqSos14ZVKHbj6nk/aImz+mu25Thl
        yBQeCkftUnWQx+pnG7HzprNdKoQ7drWmE7kfUGJWJESI7rM=
X-Google-Smtp-Source: ACHHUZ54QLLK7bDWu8rIDf0wDv+6OyrQGytSsnvkvbM78whpMk6FdH5txUxGiH9KekI9GUxTAxGso+hjXnsbOcqw8bk=
X-Received: by 2002:a4a:b6c2:0:b0:560:cb1c:1534 with SMTP id
 w2-20020a4ab6c2000000b00560cb1c1534mr6107139ooo.2.1687716759641; Sun, 25 Jun
 2023 11:12:39 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sun, 25 Jun 2023 14:12:28 -0400
Message-ID: <CAH8yC8mwK05URmvCGOkqHgSAsvvoNsDaj5JKfokW1T-d8u3YpA@mail.gmail.com>
Subject: Which tag works with submodules?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyione,

Which tag works with submodules? The manual does not state it,
https://git-scm.com/book/en/v2/Git-Basics-Tagging .

Jeff
