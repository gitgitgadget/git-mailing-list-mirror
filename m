Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EBFC433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 09:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354118AbiBHJX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 04:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354130AbiBHJX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 04:23:56 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E3EC03FED2
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 01:23:54 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so2063056pjh.3
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 01:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eo2uPGoBe88nXWHdHBgH5wL9D+LpW39X1DaRDS+DnHM=;
        b=R+G8pLQtcUspxUPOcr8jOrrbuIEvaAHXCabLP/vPKUKSWEkwd5KI+ngEzzt2d7ZqQm
         2EWGMJSzK0cboJ5qi8M+LZXIGP1JoTvNVLeW3SeFqKcZAqGhxiX63znwemphSKGeEns5
         xl5JuoGtXmT2fEb6GFfc6ZPLaYX8QmL+SbIC147qPOMVTWVm1/PhOD511WYVt+zpcuLr
         GQilGYBP+ZvzkgW8+KE2p20LzzXpmuEPPivImN5ZY1oCg0Ym/sKM5uZGvQwjsVIQgaJr
         xETUY7csb3xvajQ2g5EvLkN0UivmzkkyE4lTyg+qblbf/1Q9wCQ0ZrbPzS+3v+E2j5jx
         23rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eo2uPGoBe88nXWHdHBgH5wL9D+LpW39X1DaRDS+DnHM=;
        b=c3JemTw3kI6t2Fk8kWF6aPHIqqo0A4udPIdQm5IM3WB0oJ4n5OFNHd6QFHsNef8jWU
         6Gu3bq6+PHl6UV26lvtU00oRO0AklhsLiZ1EgQk0WdABq1Geen6UYVl4xT40k6OJgmRk
         OkHPXCwzzJhLNSoFAwpZ68tduspxYg0EoSzrwUv8gwSrzZoXltGKEjtstBQxUf5gYsJF
         y7YCDbDXixn156TFQfC31Q0/UJ5seJtbG731nb3Bf+FCsFdW1S4jGX3nSlb4wfqlTDMx
         J0dCbSnwqeAb0ytmBq/3AE18aNs8LP0crX/BlXds2dN4GZE1hSnbikP5XeD0xLroy4o2
         f5eg==
X-Gm-Message-State: AOAM530NwhTBH4FynedI+V2hPaHwgm5VRqGbdXhO5w0LjLW9G6Yn+sR9
        9wnJjVa2ZZn4aGPL8WWVBCN7h2kZSqJKgXjj
X-Google-Smtp-Source: ABdhPJxb9deF/5we4dTZDPTOSHOGh+I3FI04EnxpgXK3XwPeLLlkTaDvoNoOFUkHOUOKOlE8lIjOUQ==
X-Received: by 2002:a17:90b:4c06:: with SMTP id na6mr323874pjb.37.1644312234093;
        Tue, 08 Feb 2022 01:23:54 -0800 (PST)
Received: from localhost.localdomain ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id e8sm2074173pja.9.2022.02.08.01.23.52
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 01:23:53 -0800 (PST)
From:   Jaydeep P Das <jaydeepjd.8914@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] t/t0015-hash.sh: removed unnecessary '\' at line end
Date:   Tue,  8 Feb 2022 14:53:38 +0530
Message-Id: <20220208092339.651761-1-jaydeepjd.8914@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixed code as per coding style guide.

Since `|` already implies that the statement is not over, therefore
adding a `\` in the end is not necessary.

