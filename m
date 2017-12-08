Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95FC51FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 22:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbdLHWaO (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 17:30:14 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40538 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752631AbdLHWaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 17:30:13 -0500
Received: by mail-wr0-f196.google.com with SMTP id q9so12107132wre.7
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 14:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qyj7aHLyHWpUIo1i5ohgow2qo9V7UuXbu6Q2vJEqzbo=;
        b=igeKko2Si0St2V+VG+i3n6uA0rsAJrHDr654GGdvm0zSlT3ApA+Uc1EMBJFCmOiw9M
         xfJVoWVSfPaXyY+w+g0zaCBoVlDwwEje/vW/z3RRpsmOosmpqRCe+zOIv1WJQGEN4tp1
         Nat927lnzm3v2+6vWGdwi0xUY1ngb7ueqKeXCu0jgYWLtmgylYFpnWs23fwWyNqnDg5Y
         nUaCPFdq1dedyOatrmNcwwynHeggOonI0ET5vxNXnss/0cDO8XEVj0+FkfcxZNiDtHkv
         xmNsI7JpOpuTi24UdNogLlJPMPNODfwAY8Y4O/hh0kf53L7DftkH4NvbU2IqlXO+BG5t
         v8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qyj7aHLyHWpUIo1i5ohgow2qo9V7UuXbu6Q2vJEqzbo=;
        b=mxHjiIw2OKdKk6c8S+7ktVW/CN7lXh22voa8bdKZXZZmsf9EVQiI8e7K79OBGr8p1p
         KxoMg1SLy/rT2y//LLg53RUxv2Td0ozkc6DFOO5UjvwEqmyoq9bINRD7S3xS5woCT7Qw
         hk8zS+Ucledqnw8nbpcU2IM/LgXzcXR5yEFiUG5x9s4IxerIOb+M/UiPKnFAvjPAKmY0
         K0/IP75YyD4CaqahXHh2UdJE35D2sTwSJjqSZ68cCwj3ze12E2yzWiUdy2d9+sgrH13X
         8xtrvj59JuluAgC3O5/0snvaW8m0diwfZwcjvgDI6dwgLiDV6WMLbCVjH4yqIZu33Blh
         GmVQ==
X-Gm-Message-State: AJaThX6H2AFgBTzT8SVsrqNhctSzqr9IfboObHXaWjIDovmE/GbKtixF
        ENJ15FacYTPPbJnHHFdU2/WXVsz2
X-Google-Smtp-Source: AGs4zMbt/7DhaifVSZQeaAcZcqGVXp5yyoBuGyyso4T6N2Iz7xYfHm8Dbs/aR7doswfi5VDnzM3Cig==
X-Received: by 10.223.184.47 with SMTP id h44mr26162290wrf.11.1512772211805;
        Fri, 08 Dec 2017 14:30:11 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o48sm9688661wrf.85.2017.12.08.14.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Dec 2017 14:30:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Takashi Iwai <tiwai@suse.de>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] SHA1DC fixes & fully moving to a git.git submodule
Date:   Fri,  8 Dec 2017 22:29:56 +0000
Message-Id: <20171208223001.556-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171128213214.12477-1-avarab@gmail.com>
References: <20171128213214.12477-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's v2 as promised. Comments per-patch.

Ævar Arnfjörð Bjarmason (5):
  Makefile: don't error out under DC_SHA1_EXTERNAL if
    DC_SHA1_SUBMODULE=auto

Fixed indenting.

  Makefile: under "make dist", include the sha1collisiondetection
    submodule

NEW: Change "make dist" to include the sha1collisiondetection/ dir in
the tarball Junio's going to build when he makes releases, right now
we just ship an empty directory.

  sha1dc_git.h: re-arrange an ifdef chain for a subsequent change

No changes, trivial rewording of commit message.

  Makefile: use the sha1collisiondetection submodule by default

s/NO_DC_SHA1_SUBMODULE=UnfortunatelyYes/NO_DC_SHA1_SUBMODULE=NoThanks/
as requested by Junio.

Fix up wording of comment describing NO_DC_SHA1_SUBMODULE

Fix indenting.

  sha1dc: remove in favor of using sha1collisiondetection as a submodule

Reword & expand commit message.

Don't die if both NO_DC_SHA1_SUBMODULE=Y and DC_SHA1_EXTERNAL=Y are provided.


 Makefile              |   42 +-
 sha1dc/.gitattributes |    1 -
 sha1dc/LICENSE.txt    |   30 -
 sha1dc/sha1.c         | 1900 -------------------------------------------------
 sha1dc/sha1.h         |  110 ---
 sha1dc/ubc_check.c    |  372 ----------
 sha1dc/ubc_check.h    |   52 --
 sha1dc_git.h          |    6 +-
 8 files changed, 27 insertions(+), 2486 deletions(-)
 delete mode 100644 sha1dc/.gitattributes
 delete mode 100644 sha1dc/LICENSE.txt
 delete mode 100644 sha1dc/sha1.c
 delete mode 100644 sha1dc/sha1.h
 delete mode 100644 sha1dc/ubc_check.c
 delete mode 100644 sha1dc/ubc_check.h

-- 
2.15.1.424.g9478a66081

