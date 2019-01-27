Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26AD81F453
	for <e@80x24.org>; Sun, 27 Jan 2019 00:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfA0AgD (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 19:36:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37219 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfA0AgD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 19:36:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so5686632pgb.4
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 16:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q95vhREOvsfIHWSshfSz7H02Ey19+t4ll/N620K4A4o=;
        b=UGgaR219e7qvScg6X1ioGf6j5XjUzXMSUqVqPJSbjXDFii9+GPO32QILN1bMibROgk
         lQlFM1YFncBsMb3xXpNz9qCC5Zkkxmav1fMIVd3GrYBzOQ13S+M15pzOMRODUjHbZR82
         ZAiNrS51Nw0guIOo1GokjUDaG6uqWZjbx45LXZ5Jht792cg7NNd3S5U09/oFXrQHDRRN
         sibxaAlHXrL6fLEvjcMScBOcYf+vVbZ3BfB3VCDKYJEKQvzJ5cTwU8vio38VVFUr/8+t
         /sofbcgXyWFXgFI7Zrz3Xw20BT+sGIHRlHXRRihNIs1iNZGvy1yi6gLPuaTJ4p/laCDy
         Ehzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q95vhREOvsfIHWSshfSz7H02Ey19+t4ll/N620K4A4o=;
        b=Tp61+S6HPnCOWVvYoA5TPxzE1Fh2clF3ptPEud5Qk2+eKZo7tJmjGcRCpqcjYGrCEp
         0AbRK9xeekqbKtjAYh8UqfQIaLitpvdRZdgcVtd8kyaJWRYEHP+2t9MnlQhpbkTG8LAk
         p+HZZMDhLtLd3GMkQPJ2vwg77FMzbZWQbKj4aN2eincLkIVuLaLiklV7vH3/QereXWqg
         Pwvd578duaH73BrjjJHagXBaL6kaaF+9X+SoKW84xLK/eKaRm9sIVcbv2IjEM3O+XATB
         Vrfc6chhgSsYqWYzjF2M2kZZSloqFrF/QbXCx64m2APZADjKWn+g4fK/cx5CeFlINYSS
         mm4Q==
X-Gm-Message-State: AJcUukciDoEWbZGBAmDyzCsG04nj9nbvxDyA66eJNJlMH/oQjnI1oxZy
        9ntXNd+jH4odvZsU0W/DgiTGamgO
X-Google-Smtp-Source: ALg8bN4e87W9eTod+wEgUaHNP++hMVv9KpJ0A26Uvm2l4yIqz8NmI4cTGVxqHgGGA1mFevgScStLjw==
X-Received: by 2002:a63:111c:: with SMTP id g28mr14787392pgl.85.1548549362272;
        Sat, 26 Jan 2019 16:36:02 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id a15sm31660222pgb.1.2019.01.26.16.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 16:36:01 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 27 Jan 2019 07:35:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 00/14] nd/diff-parseopt part 1
Date:   Sun, 27 Jan 2019 07:35:21 +0700
Message-Id: <20190127003535.28341-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first part of converting diff_opt_parse() to use
parse_options(). Compared to the full series [1] I sent earlier, 03/76
is dropped and 02/14 is updated to allow KEEP_UNKNOWN and
STOP_AT_NON_OPTION combination, but only for one shot mode.

[1] https://public-inbox.org/git/20190117130615.18732-1-pclouds@gmail.com/

Nguyễn Thái Ngọc Duy (14):
  parse-options.h: remove extern on function prototypes
  parse-options: add one-shot mode
  parse-options: disable option abbreviation with PARSE_OPT_KEEP_UNKNOWN
  parse-options: add OPT_BITOP()
  parse-options: stop abusing 'callback' for lowlevel callbacks
  parse-options: avoid magic return codes
  parse-options: allow ll_callback with OPTION_CALLBACK
  diff.h: keep forward struct declarations sorted
  diff.h: avoid bit fields in struct diff_flags
  diff.c: prepare to use parse_options() for parsing
  diff.c: convert -u|-p|--patch
  diff.c: convert -U|--unified
  diff.c: convert -W|--[no-]function-context
  diff.c: convert --raw

 Documentation/diff-options.txt |   2 +-
 builtin/blame.c                |   2 +-
 builtin/merge.c                |   9 +-
 builtin/update-index.c         |  41 +++++----
 diff.c                         |  71 ++++++++++++---
 diff.h                         |  80 ++++++++---------
 parse-options-cb.c             |   7 +-
 parse-options.c                | 152 ++++++++++++++++++++++++---------
 parse-options.h                | 108 +++++++++++++----------
 t/t7800-difftool.sh            |   4 +-
 10 files changed, 318 insertions(+), 158 deletions(-)

-- 
2.20.1.560.g70ca8b83ee

