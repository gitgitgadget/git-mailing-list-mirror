Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEBC91F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeHVTbj (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:31:39 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:45542 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeHVTbj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:31:39 -0400
Received: by mail-lf1-f47.google.com with SMTP id r4-v6so1775346lff.12
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hnYU954yAjjc17JYNrwJK3q0L5aNyakcOMT79lpLgj4=;
        b=Vto1vRMI1MObf1YtAE5EFuCgz1MvBnE0i/Let4Eagr5o1ekbFACbQRvU6gOrH+x73U
         Sp4keOseZCUBGQ94vNeQvTVXKvIaIoOACif1Y0BVCs33v3X+9Vu4IsJNgU3yYE9l+Auu
         WNqLHG1z6fR0sXOKtxbyn8GueiFjEGOZI5zi7Gl4PiSInfBf1nFeu6uPzCOz7OuJSUsy
         C8IPPcIGoPuZRBrXFZ/ofuwkE2sOqaSyK4T6y/0AXDupd4HPple3YE9Y/0ufnmxeJb2C
         bbsTgnozsjPH5wos8eXwcGOR3ir2Daf1SK9qst0RfoOfRBTBEOr0CEkqQHBtyFW3he1x
         Eo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hnYU954yAjjc17JYNrwJK3q0L5aNyakcOMT79lpLgj4=;
        b=ByRRk8sJk0Z1goAVGhoEacWyt2AniRiuvjEJD4gox0RHnwY9y005xSBi7a6ye0CzlZ
         ntXkJLgrAUjVDE+u/7C91N/jAG4WGuHKiHLoG0pV0XGnKhfTb8A8Pb4cpXjV7kDntOeR
         GHCVGMYTYxKpA9Gk6l5OHHCV2eghOm4RZK3bZCwrDtkBwRtCqRL99tlYikKj5P9n8FjR
         2uwsPIBF1c+mjtC/Qh9kKU/7jMMGmPCOWhVEhXqpXy8T3Rr9krs87kTCdCn50ZUWFRYr
         mOxv98Ux03Ifo6rQWH7+DJZjgm0ekX6eRa49fSCujSqei8b8nNrrpaVIWBMxx6OIv1MT
         0C9A==
X-Gm-Message-State: AOUpUlG3gBCcuCEPJy2xWBWAYFt4CEPvRb++Sd9fdFCrU+S4ycWBwaHy
        qt+4S9XF/bmRmgf7pMxsKpD3j+7S
X-Google-Smtp-Source: AA+uWPwYLy2l1CqmYrtibjYeL+OqWEasBuqwdcCusBlWKUCe+xm3h/nBLTiTXSjgOXBtMM0FO4nRPw==
X-Received: by 2002:a19:2a51:: with SMTP id f78-v6mr9943210lfl.97.1534953968637;
        Wed, 22 Aug 2018 09:06:08 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u86-v6sm375213lfi.90.2018.08.22.09.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 09:06:07 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC 00/11] Break down Documentation/config.txt
Date:   Wed, 22 Aug 2018 18:05:54 +0200
Message-Id: <20180822160605.21864-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.335.ga73d156e9c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I notice a couple times lately that people added new config keys in
the wrong place, which is understandable since this file has become so
big, it's hard to see the structure of anything.

Since we have broken down some parts of it into separate files
already, this continues in that direction and moves even more parts
out of config.txt.

I don't have a well defined criteria to decide which part should be
moved out. I just did it when I see a section is getting too big, or
becomes less relevant today, or not move to avoid conflicts on 'pu'.
But if this is a good move, we can discuss this further.

I group by section, but I think in some cases we can even do better
and group multiple sections in one file (which also means they are
rendered close together). This again is up to discussion.

Nguyễn Thái Ngọc Duy (11):
  config.txt: follow camelCase naming
  config.txt: move fetch part out to a separate file
  config.txt: move format part out to a separate file
  config.txt: move gitcvs part out to a separate file
  config.txt: move gui part out to a separate file
  config.txt: move pull part out to a separate file
  config.txt: move push part out to a separate file
  config.txt: move receive part out to a separate file
  config.txt: move sendemail part out to a separate file
  config.txt: move sequence.editor out of "core" part
  config.txt: move submodule part out to a separate file

 Documentation/config.txt           | 720 +----------------------------
 Documentation/fetch-config.txt     |  65 +++
 Documentation/format-config.txt    |  87 ++++
 Documentation/gitcvs-config.txt    |  67 +++
 Documentation/gui-config.txt       |  57 +++
 Documentation/pull-config.txt      |  36 ++
 Documentation/push-config.txt      | 113 +++++
 Documentation/receive-config.txt   | 123 +++++
 Documentation/sendemail-config.txt |  63 +++
 Documentation/submodule-config.txt |  82 ++++
 10 files changed, 711 insertions(+), 702 deletions(-)
 create mode 100644 Documentation/fetch-config.txt
 create mode 100644 Documentation/format-config.txt
 create mode 100644 Documentation/gitcvs-config.txt
 create mode 100644 Documentation/gui-config.txt
 create mode 100644 Documentation/pull-config.txt
 create mode 100644 Documentation/push-config.txt
 create mode 100644 Documentation/receive-config.txt
 create mode 100644 Documentation/sendemail-config.txt
 create mode 100644 Documentation/submodule-config.txt

-- 
2.19.0.rc0.335.ga73d156e9c

