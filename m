Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30856C433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 16:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbiDFQev (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237971AbiDFQeV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 12:34:21 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DA820DB2B
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 06:53:06 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id k25so2943965iok.8
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 06:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=CDavmsj7LXqFmEqf+MD8AAZ6S7Vy8ye2Dd7IKBGSnUQ=;
        b=JmmHjOjcn6ZS6+Ek99yM4ez5wtB7zFwKdJ0aFOBgWgR6IhBflgD2D64Is5XM/tC+rf
         J86po6r6tSOv42WZk4Au7xVMN0owvBl9M4G6BDibqUaBafmNtbLjb40UuCSZVk24r8SU
         Iz2pnHMWcA6VV/yPLyohwk7aYONm3Zd4prbFcXwY3lsRCzU612UmO626bb8Ddlg3KIct
         JnUaRoiBjRnh+ONC5q1R+XCqGR0QBAMCupPxj0G10uz8Id2u/jUgBR0sIEgsTqT5GLXE
         G7uNogvpALzsE0NSnMc5mnmNfuAyJXLgUDbFhFHQCS1o/QbFKu0S+K4oiR8o9OPV/m+Q
         TRMA==
X-Gm-Message-State: AOAM533YuNMJnqpBHs3Ft45x7Y6jve1j1bAKF8vR62weUq1C0K5Dm4s9
        ACStAjHmtRBe/z2SE3Z+KowkbcyBNaSFKB5js9iBoWkWqlE=
X-Google-Smtp-Source: ABdhPJweSAwHXn8uZiAFJVlz7+G9ezqAKPfT8ymR8tttN1nzy3y9ImIDPKGYGcWAI5+waV/d4jmnbMTV1M3/eqywM0s=
X-Received: by 2002:a6b:fb17:0:b0:649:b0dd:e381 with SMTP id
 h23-20020a6bfb17000000b00649b0dde381mr4068382iog.95.1649253185074; Wed, 06
 Apr 2022 06:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <CA+JQ7M-Haf3R8xp-sqyJXPZza3VeaRf9uK=tyuviNFVZ0kdBTw@mail.gmail.com>
In-Reply-To: <CA+JQ7M-Haf3R8xp-sqyJXPZza3VeaRf9uK=tyuviNFVZ0kdBTw@mail.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 6 Apr 2022 15:52:28 +0200
Message-ID: <CA+JQ7M-CNYCUAWEi42=0d6LVHZREAm7bFN=BAxA9ZWmqmZ6K7Q@mail.gmail.com>
Subject: Re: BUG: cannot remove new staged files in sparse checkout
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I should add this behavior was seen in
  git version 2.35.1.windows.2
