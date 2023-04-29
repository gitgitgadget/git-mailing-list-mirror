Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AAEC77B61
	for <git@archiver.kernel.org>; Sat, 29 Apr 2023 02:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjD2Cjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 22:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjD2Cjt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 22:39:49 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08EF2701
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 19:39:47 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-552d64d1d2eso8667557b3.1
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 19:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682735985; x=1685327985;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GZRjT0m5CgWh9aHeAN+otdwolkyVbHEzNpMZBbbyO1Q=;
        b=VsRx5M4E6OXQl8jEJT3Aki2wa3CC+f28JiSzryh9TMwvnO9p6nDlSFy2c5JeVE7GWw
         Q+iy8XgHVkW8jIF4QpkeAExNOtKaSvjb85cTQ1XSNq0sI6QUmu51TlUbwfFDcJeNqZA0
         5zbeejtf0U407Dx216kqx4eN7QNdFAZ0OszK2J5k59Et43zdHXCJ74A4Nf9gSgT97GSI
         8U7JPNE4WoOz2eyflnW6CQUKr8NXOEPnH9V3sdsGydYtFvmSkKYwaQ6qkkfcdp01Apv1
         0fXugLk4iDU0C0o/68UHffGnGNLD6iOkoz/LSKdeeeGn/1DZ52ukAipiu00VLTT7ZkAo
         tgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682735985; x=1685327985;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZRjT0m5CgWh9aHeAN+otdwolkyVbHEzNpMZBbbyO1Q=;
        b=FYWTz48jimaoboAtdx5XCl5NF6s32iTOKC7eXP02TvrP2ihESXFh22ms0IRGdMeZlN
         R5sz0yB1dmZ9Y5E+eLwbjUbNjVzWKIAp6IW1/fmeK0TOopzrCnEeJxkHkZEBmIkuY4ZG
         0Dhni+81dYSk/GVF/EuaQKDbB6kkYbj6Z+loUsRRFjrVNz7JHXfvAFxW9npJWt3/HJ8o
         mUfYSa1ppCJY3BsACsPx80lhc4xIvjGO3NzBT/qeSEttiI1BBSlvzeHmj+g9h8+zjPZ3
         0O83nLA/vlw3+qMxYqfJrQQh7MTssVnLphjVIQsl7dkTguKsCPpjnnCpPqhtTvoHfzk+
         tZnQ==
X-Gm-Message-State: AC+VfDz94uC6WMM6Wb47KCD6faY7rT9yKNptLHkLh2Aq48uNfnbzkVZh
        6Umdv+XJ/tYz/OcwzZ6XkfqARVpsUBEyPksdqYq90Q==
X-Google-Smtp-Source: ACHHUZ73OesRF6SYNfeNYJ7F80S36kwvs8WwYE3KBaeAkt0P8tDJJFFRmO3SsqZLEUsrPpcqEs3Mgg==
X-Received: by 2002:a0d:d244:0:b0:552:b9db:f4b7 with SMTP id u65-20020a0dd244000000b00552b9dbf4b7mr5412690ywd.3.1682735985550;
        Fri, 28 Apr 2023 19:39:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k63-20020a0dc842000000b00555ca01b112sm619532ywd.105.2023.04.28.19.39.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 19:39:45 -0700 (PDT)
Date:   Fri, 28 Apr 2023 22:39:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Subject: [POLL] Git Merge 2023 dates
Message-ID: <ZEyDcBcGmLznqKzD@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GitHub is beginning to look at Git Merge dates for 2023. There are a
couple of options being considered, and I'm curious which one would be
preferable to folks.

We are considering either of:

  - The third week of September in Bilbao, Spain, or
  - Mid-October in Raleigh, North Carolina, USA

These dates are centered around Open Source Summit Europe and All Things
Open, respectively [1, 2]. We're thinking that Git Merge would occur
either shortly before or after those conferences, for folks that want to
go to both / maximize their travel / etc.

Let me know which of the above you would be able to attend (ideally
off-list, to avoid this thread becoming too noisy).

Thanks,
Taylor

[1]: https://2023.allthingsopen.org/
[2]: https://events.linuxfoundation.org/open-source-summit-europe/
