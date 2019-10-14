Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A3351F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 22:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbfJNWCM (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 18:02:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44154 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbfJNWCM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 18:02:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id e10so6841549pgd.11
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 15:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePGzaa4aPCqZWT7KObo8HuG58RUOB5ElK1ZJzLglmyk=;
        b=DmAu9YYYwmO3IERpb4frzYD6jz/ehSh21W2QWTwnQP6LGLvSq8BSGbIgrHSpcZCnP6
         0ChQtu8uiqONHseQudZNKcOWTEVzLUyO8Vt4Nk7qAX0VVKciz5Cfk8M1syeba373HQgy
         erbf0VZGxTbutM16kV/dc5qhzj8LeKjkZ0OYmwLsPQPI8rsdGIsm/aLvRkiDyosbIUy8
         PWk4OZJkj0vvqHTMiHvP1nPdt3mKj+ALaVjZnQdN3BgBjkz9dfM0r9yBo01zSFUrvT2w
         cANdhAENt6F9L3DunYpYsrATxo8k8IT2puptvJizkcFoN7VMUfg7RXq7e+hDoSK8/d8c
         533A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ePGzaa4aPCqZWT7KObo8HuG58RUOB5ElK1ZJzLglmyk=;
        b=o97uJQrqGv0bRJnUDoCI+0me8RLqKuxjXiN/xw+UtsVWPy0Grl2LKgnIvXG/bhhp+y
         /4PJxeNc3DfSeXb4AZoRa3JoaQd3J4SzbarX8Rp+c0g5OFqo6XsP5M+THJBQ4mjw+zaO
         3L9GDnE4rFjgLlwb/LY3+6iuq5OKEP2+b0ThbopvE4auIbHgZzVVf7fobfFv27GVlJfb
         WpfmhT3U8GCPU09lDoAkv2rqx3OD9XjoXs54F3iNsq/Wd8xdy1gIwLh6VxXT5bkU7kEv
         SCw0bCc1iQoDL5v122L5AjIvRHWXgHqyRqlzOrypAPM6jRnaB9MQy1X3ZwUHZ56489er
         e5rA==
X-Gm-Message-State: APjAAAXwIUBT1Ybqp4ve6hwKNal2r48OZvANQMOerLwOJyranem2jdMB
        qKxpvYyRJqsuSASXANXdxWBLDwXvNp0=
X-Google-Smtp-Source: APXvYqxM5HEy5fnitxq4JODP+Dnn1bwuEAnWzJrkY7iGaBEdrpWOWfAONm0r9CqW6ggb8smaj71tWw==
X-Received: by 2002:aa7:8b02:: with SMTP id f2mr35600964pfd.31.1571090530866;
        Mon, 14 Oct 2019 15:02:10 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb00:1b0::c0a9])
        by smtp.gmail.com with ESMTPSA id p11sm20518895pgb.1.2019.10.14.15.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 15:02:09 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: [RFC PATCH 0/1] Teach remote add a --prefix-tags option
Date:   Mon, 14 Oct 2019 15:00:59 -0700
Message-Id: <cover.1571089481.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2.7164.g7daebe18fb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This patch was originally created as a pull request on github [1] and
then languisheh as I forgot about it. Recently I was asked to revive it
and have done so. I've rebased on top of master and validated it still
works.

Please review.

-- Wink

[1]: https://github.com/git/git/pull/486

Wink Saville (1):
  Teach remote add the --prefix-tags option

 Documentation/git-remote.txt |  8 +++++--
 builtin/remote.c             | 42 ++++++++++++++++++++++++++++++++----
 remote.c                     |  2 ++
 3 files changed, 46 insertions(+), 6 deletions(-)

-- 
2.16.2.7164.g7daebe18fb

