Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7E041F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeDPWKA (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:10:00 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:43854 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeDPWJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:09:59 -0400
Received: by mail-pg0-f44.google.com with SMTP id f132so3316933pgc.10
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LvijCstzbiNNsGbLlWqRxkQWDoIBATe77azhk6UJVgU=;
        b=JBglfMhAs31P7rdTpjtqIvWELFi3RXhuYtU0Yn/TiCo/G1/UofFieHEsS6SkfhYw3l
         BCTzafps55TFHZ4TY/Av1mrmjWiuWQcoloPU5zmlNCjGaEfC5a8rSjvt9EJ4jRqWDn6X
         MBtJ0dAB++hBo024qxLv1AIOY6Y204stW8WkSDg10xSn44rTDmaJwlkpUGRsaiWGaKjc
         nl1RELo1eoqXe7PCCkBHO0hNWIsz1OmQhL0nLdrXeBcBK7m3h6mbFBTjcBXaEOWoleXi
         2ebJSCQXWGauocJK1ChWEKM/C61zkic+tw5SeN+sHQ9qtzKLga8SNk7FaJLwGMYQUlEr
         aw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LvijCstzbiNNsGbLlWqRxkQWDoIBATe77azhk6UJVgU=;
        b=rQmF+3mh6U+lnClR65OVM9AfP8bNmuGfEY8Q0PiEYX9i6nZ4U2eWWhjVrcykOwq3a5
         a5eW+wup14Jsv8BY7bBgErTVGLxZ7yNp6Fh5HFmw/htyt4wdgG70oRwUpAqFQvJkA7I2
         Y3zspIGYoC+mSJVdhzff6LW0BxvlgLwCSiDK0V4RU9C/gllli85lmjOCNhT4uyvyLqvQ
         yyzaA6absjXgVXm86zccZVR7jFl6G8sZ4kGlRnaoDKRJolViSjbs/geoWN0KyXcy41ER
         85SI7uCU+826l1YlhozBWYBP02uT52/Wlwqi8FO5x61kM8EUr1bI6nUpKkanBh9Fll/s
         ZLOQ==
X-Gm-Message-State: ALQs6tBQLk06dNVyvZQzAVTGVmMpUjOqM5FYMn+1Dgam8N3BlsssZhSR
        hsedwNURlflWEscAU7shrrDq+WBqwSY=
X-Google-Smtp-Source: AIpwx49SAevzHZT1GtUCWzs9a7oe4/TPlTuiDPGnGJOuEr2EiQ0Ehpd6tKs17/eNVPTCsuIIkshBIw==
X-Received: by 10.101.82.197 with SMTP id z5mr14425096pgp.45.1523916598430;
        Mon, 16 Apr 2018 15:09:58 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id v187sm7940009pfv.21.2018.04.16.15.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Apr 2018 15:09:57 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] blame: color line by commit
Date:   Mon, 16 Apr 2018 15:09:53 -0700
Message-Id: <20180416220955.46163-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a resend of sb/blame-color, dropping the patch
"add option to color metadata fields separately" as I think it is not needed.

> Expecting a reroll.
> cf. https://public-inbox.org/git/20171110011002.10179-1-sbeller@google.com/#t
> error messages are funny, can segfault, ...

The error messages have been addressed. However a default mode that is enabled
by color.ui has not been added yet.

Thanks,
Stefan

Stefan Beller (2):
  builtin/blame: dim uninteresting metadata lines
  builtin/blame: highlight recently changed lines

 Documentation/config.txt |  23 ++++++++
 builtin/blame.c          | 118 +++++++++++++++++++++++++++++++++++++--
 color.h                  |   1 +
 t/t8012-blame-colors.sh  |  54 ++++++++++++++++++
 4 files changed, 192 insertions(+), 4 deletions(-)
 create mode 100755 t/t8012-blame-colors.sh

-- 
2.17.0.484.g0c8726318c-goog

