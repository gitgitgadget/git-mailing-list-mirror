Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A4F20248
	for <e@80x24.org>; Tue, 26 Feb 2019 00:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfBZA0p (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 19:26:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33807 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbfBZA0p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 19:26:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id f14so11981022wrg.1
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 16:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GZ/R0J9e3hdDwl1zFGPa2ZkxX5NT494RiuPUSULRc0A=;
        b=Yaz6b7xVMIX4oRahkRQIOM1aRyS/mnUyiZMPmi+ic+dGNB/MqOr+9kDMhbyCYu8XNV
         kw3a4SVvwyjDj7bJfBWW6AhRbZ+cW0rsYI6nD3Tg6B2uPZfKx4oss6NrbK0pcj+thO4a
         psiBzxCDj4N64xvpQzcoQU1y1kYJKtYECGK5P25qB+v1eNiEwXbOMX6xkbMbM0di3hnB
         NTfpdc+UwHfEXHegfIzrvrHYiScEGLX6hotxhG8qZ6IjL2OaMkC9G90dULo7KQ8pWKwD
         XeDReT4Mddwiu9h1yScyxHlEKLtJZ3SxgXrxBSvnR448xgjZoEnHiHUajsVPa5SzptdP
         NGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GZ/R0J9e3hdDwl1zFGPa2ZkxX5NT494RiuPUSULRc0A=;
        b=lMda8GPjxE8Gc+BXyRYmoi4rv0bJctGVpOf0YtgkxJjqXxh3oNYmEXoRZaIAptjTd5
         3DxQJmQUXB+oQiwishdHLU1UytyVf/7XQgLmAG5aLp+643/8kQd+Sb142f2oWh0b9qrN
         0xNZ9Qry5ZgAWjdH8MW5XkLZooFA4fMcGTviCA6sM25Z+4w2IuM7Zk303D+/t+iJgDLu
         Yt+SBFSwFdDmqNC8IfTLsGbLJQNalPklj26C41LYQjesx1uMihj0O0AhnJ8Nzi/ODit+
         e90oQOF+4L7b8pT1cLQy7/vHFYiX2oOqEyHBH1sS2iIt0scg/qQagDDnZB23eAkfcayX
         ekgA==
X-Gm-Message-State: AHQUAub10SfG2i0EKm+ehFfYcpQQoguev7JGX82Urpfb5B99OXXkbuLy
        Qt78aQtsskjY/DxzY0SErbzEDy7m
X-Google-Smtp-Source: AHgI3Iai0VEGwCXjCuKB9ecu7E+b4AaXO4UILHZCQvVZBqrac8KgAlFWcUKpamQLieDAJ1LA6lJmvA==
X-Received: by 2002:a5d:668b:: with SMTP id l11mr14025499wru.116.1551140802985;
        Mon, 25 Feb 2019 16:26:42 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e6sm11745708wrt.14.2019.02.25.16.26.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Feb 2019 16:26:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Matheus Tavares <matheus.bernardino@usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [WIP RFC PATCH 0/7] clone: dir iterator refactoring with tests
Date:   Tue, 26 Feb 2019 01:26:18 +0100
Message-Id: <20190226002625.13022-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b
In-Reply-To: <CACsJy8Bw-mXLyT7VaKBjYKLe6uSAQqyLG=_AzjDXykYzSQLkcg@mail.gmail.com>
References: <CACsJy8Bw-mXLyT7VaKBjYKLe6uSAQqyLG=_AzjDXykYzSQLkcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 25 2019, Duy Nguyen wrote:

> On Sun, Feb 24, 2019 at 9:45 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> ..
>> Can't the utility function we're moving to just be made to be
>> bug-compatible with what we're doing now with symlinks?
>
> I haven't really followed closely this thread. But I think the first
> step should be bug-compatible (it really depends if you count the
> current behavior "buggy"). Then add improvements on top if there's
> still time or strong consensus. It's easier to bisect that way at
> least.

Here's an attempt at doing that. This was hastily done and as seen
from the commit messages I don't really know what the intention with
some of this stuff is / didn't have time to dig, e.g. why the API is
now using lstat() instead of stat().

But as far as I can tell this is a series where up to patch 5 we
retain the current behavior 100%. And in 6/7 and 7/7 introduce the
behavior changes in the previous 3/3 which I've been commenting on.

Matheus Tavares (3):
  dir-iterator: add pedantic option to dir_iterator_begin
  clone: extract function from copy_or_link_directory
  clone: use dir-iterator to avoid explicit dir traversal

Ævar Arnfjörð Bjarmason (4):
  dir-iterator: use stat() instead of lstat()
  clone: test for our behavior on odd objects/* content
  clone: stop ignoring dotdirs in --local etc. clone
  clone: break cloning repos that have symlinks in them

 builtin/clone.c            | 72 ++++++++++++++++++++++++--------------
 dir-iterator.c             | 23 ++++++++++--
 dir-iterator.h             | 16 +++++++--
 refs/files-backend.c       |  2 +-
 t/t5604-clone-reference.sh | 40 +++++++++++++++++++++
 5 files changed, 121 insertions(+), 32 deletions(-)

-- 
2.21.0.rc2.1.g2d5e20a900.dirty

