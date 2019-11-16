Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B75851F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 21:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfKPV64 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 16:58:56 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40701 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfKPV64 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 16:58:56 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep1so445899pjb.7
        for <git@vger.kernel.org>; Sat, 16 Nov 2019 13:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oc5ctFPF/fiCOxBg4l5o3BDV94DwGq58nyIOlmoSgaY=;
        b=v6B8d90dfyd9iruxkvxp2y3ZEUYf9K217ZyHTh+19q7Q1rfUowHmpGPOdxlSZ6vWwZ
         iyY5IZe25ZAzJ9wVK3Yr2Ktf25rkIfrorI1JmPIaR2XBNHhPkjIsWsMjfhOeJxcePe9j
         jfzbS9YBy/TPWT0SXrHrs1aVGVTOs9ubHueYI1p44g1G/hxe9bq3ls0E7v6ksHpvAE8K
         6m0hWpk3rXpWlTcAqVP9FuT7klrcX+utAcvpz1ppLBfoEuyZTwHCCiHm9HRoawirNdi2
         d0Fx3JW1ijitMEXh1vitnvkbQZoGfK6rfvnq/9DwjokcIepvtmPcuoZ2BuAfkg7unVPB
         z6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oc5ctFPF/fiCOxBg4l5o3BDV94DwGq58nyIOlmoSgaY=;
        b=hepy2deY6Q+8MRTDOSqB3zvCtWsqI/uH6Oq9ZdbjLw4zFNZZWlnpgyFUbh1ittXR2V
         CgyX7OCS5MxNljcswLoTjkK0gz51Zc4NDU8ZUD41GRTqpJGwvRTjBoiTeRDoi23c1dY6
         2ARPjOe22BT9IjwXYb87m2hMviOdlm9Uhg5fGLzLSkyyweqH7WufrjRmfB/XCS0HnCpl
         CU1FVfdgRNir91I5JpU/Shu/dcGfoQ2AzHd3xkGhWKKyf/hD7XIpg8g7Hn8xi63XW5c2
         8GIzyoz/HaSkNBxf4s5+mI+AWXxM+LA1T0HSGBUHSrj26yPF5vwBYpycBEbMa8x3pDKJ
         tjMA==
X-Gm-Message-State: APjAAAWOhMcGIlMephqj2qA+T70fhBRnphWcl0HROls9X4/n2C9rP4c4
        /qqrmRyhfj6EXuuoatdzucHxZ8Avc0g=
X-Google-Smtp-Source: APXvYqyIav71guwUVDkHxkbKXw6mLFiNCteM1PxwIbnoM5HzhYOVV5qBRMpqJFc/4hNBvYTRIzuI1g==
X-Received: by 2002:a17:90a:d102:: with SMTP id l2mr30103699pju.132.1573941534007;
        Sat, 16 Nov 2019 13:58:54 -0800 (PST)
Received: from localhost ([49.230.7.85])
        by smtp.gmail.com with ESMTPSA id y4sm14369002pgy.27.2019.11.16.13.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 13:58:53 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH v2 0/1] Limit search for primary key fingerprint
Date:   Sat, 16 Nov 2019 21:58:49 +0000
Message-Id: <20191116215850.3919-1-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116194945.GA244853@google.com>
References: <20191116194945.GA244853@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of implementing signature verification for git clone, I decided
to refactor/unify the code for commit and merge verification to make it
reusable during clones.

This lead me to discover that git requires merge signatures to be
trusted (as opposed to TRUST_UNKNOWN or TRUST_NEVER).  This is unlike
the behavior of verify-tag and verify-commit.

So, I figured that I'd make the minimum trust level configurable to make
the behavior of merge/commit/tag consistent.  And while doing so, I
noticed that parse_gpg_output() in gpg-interface.c assumes that the
VALIDSIG status line has a field with a fingerprint for the primary key;
but that is only the case for OpenPGP signatures [1].

The consequence of that assumption is that the subsequent status line is
interpreted as the primary fingerprint for X509 signatures.  I'm not
sure if the order is hardcoded in GnuPG, but in my testing the TRUST_
status line always came after VALIDSIG -- and that breaks the config
option to set a minimum trust level (not part of this patch):

,----
| $ git log -n1 --format="primary key: %GP" signed-x509
| gpgsm: Signature made 2019-11-16 14:13:09 using certificate ID 0xFA23FD65
| gpgsm: Good signature from "/CN=C O Mitter/O=Example/SN=C O/GN=Mitter"
| gpgsm:                 aka "committer@example.com"
| primary key: TRUST_FULLY 0 shell
`----

[1]: https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob;f=doc/DETAILS


Hans Jerry Illikainen (1):
  gpg-interface: limit search for primary key fingerprint

 gpg-interface.c | 20 +++++++++++++++-----
 t/t4202-log.sh  |  6 ++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

--
2.24.GIT
