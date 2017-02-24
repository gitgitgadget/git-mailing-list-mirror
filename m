Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BB25201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 13:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbdBXNRE (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 08:17:04 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35010 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdBXNOg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 08:14:36 -0500
Received: by mail-pg0-f68.google.com with SMTP id 1so3086076pgz.2
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 05:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SwunmTvajuRNKaUQms2LaYYUZvynhLdA6q32RgEiXK4=;
        b=n7WmeU9xS+q4ifX/c86qTdndWBC4RPP8cu1sUzHy/02z+Y8GO5UWI10UkFgL3HjF52
         st54VAysGgfx+aY78pZ+gNf/CFSzAiPGIV6neMxrziEQpaZ+eQgD8AeCkFBat6UFj1gx
         UsfoI8bAmqem3WApr27b+4gFos5rY7Z20K4CsV/+FE+OC53ozgCWCKHW7unIuTko3NcG
         +bMv/+TmpiZGP2m3utl8jde1bS1TVTwT3uvLZ1jfWUjHd+EO4cWvbA6DJiwWNFj+7pX/
         NjVRROQ0wPzD1hKWM2EwVuxrtipaT54gIBu+zVO/2IL/SgZN0cpaV6NnS8JwHKfrA39R
         Xi1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SwunmTvajuRNKaUQms2LaYYUZvynhLdA6q32RgEiXK4=;
        b=e5zJx+dWnwdpyhwfH9FUm9hNmGgT8kJvsNTDW/7bQWpZiJh6qlNVTFwpuuIKfdAX0w
         UOxy7VAiprf0IDQS8ZmC3vCGNcDu0j5qtLAsUjSIDz7uJVFv8HC3YTq0F0PyFJr4HW0m
         S05uU9+oQ8ZaoCRHLQdt9KfNv7MANL8P2Dkrt/azwvh1FJ6gKi5EVW0zf9aIlL2U+LE4
         xEEJwV9TNOk2ZWOmaEDLpo3GhhbgsQvtPFndavhf2SYLB4Sd1PvQ5uZwuUwYyJkJTSBT
         WjxyHyP1zjZTRVUf4M4I4R6ItV+/8FBJ1+ijzOzTYq4cJkm1C3xDmNo9Px7JgyYIwnFy
         JhzA==
X-Gm-Message-State: AMke39nUyI4/MFB8BaNjK+KlicsZBVIYlB5RwP14UawhrHcTgrIBtPNCr0DuQBGpawxL+Q==
X-Received: by 10.99.67.130 with SMTP id q124mr3421474pga.221.1487942074707;
        Fri, 24 Feb 2017 05:14:34 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id s13sm15295061pfk.26.2017.02.24.05.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Feb 2017 05:14:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 24 Feb 2017 20:14:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v6 0/1] Conditional config include
Date:   Fri, 24 Feb 2017 20:14:22 +0700
Message-Id: <20170224131425.32409-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170223122346.12222-1-pclouds@gmail.com>
References: <20170223122346.12222-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v6 has lots of text changes, most of which I shamelessly copied from
Junio's, with some minor edits. The biggest edit is the mention of .git
files, which is probably a good idea since .git files are used by
multi worktrees and submodules.

I could not move the "notes about matching" block into the gitdir
block though. I needed to indent it once (not twice like the "for
convenience" block) but my asciidoc-foo did not manage it so I settled
for "a few more notes on matching _with gitdir_" without moving it.

Code changes include renaming include-if to includeIf, and using
expand_user_path() instead of rolling my own.

Nguyễn Thái Ngọc Duy (1):
  config: add conditional include

 Documentation/config.txt  | 61 +++++++++++++++++++++++++++++
 config.c                  | 97 +++++++++++++++++++++++++++++++++++++++++++++++
 t/t1305-config-include.sh | 56 +++++++++++++++++++++++++++
 3 files changed, 214 insertions(+)

-- 
2.11.0.157.gd943d85
