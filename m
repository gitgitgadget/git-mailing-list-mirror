Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CD1A1F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 11:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437940AbfJRLmK (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 07:42:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41085 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389063AbfJRLmK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 07:42:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id p4so5898193wrm.8
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 04:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=USU6VcmYeKqXr3pUI4TGK+5LnJeNOl2Xir1mjWt9KmQ=;
        b=svNSLW+gzXcsBMTYrj53cxc63U4G4TQVddNWAtwCS2evmkhl8gQHUWO+M1hP/wgdl6
         7gORF2QZU+BXhqsWBcO8nJtTY2LUHufv4dQ5EMbE8L2Xc1t+Hp6iKfb0eSAESkC1Ohtf
         9H6Lz73q/LcBG81hsE3HmJ22CbOC6gU7yP0xZ9ceZVS9B1SmGJsTGIYkQkl2S7a0002v
         U0vSYGLrkoR02wNWqZQqPy8DzN3453HEwj4/Fo4m+UddJyKpow7qa1NStNCHZV7LSWLR
         1xZBpwqIMO0c3Et+/Osd/lA3z7YfR+upeYOVfXSiJyQBmxn0cKIXYHfBecVWgzT7kTl1
         FzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=USU6VcmYeKqXr3pUI4TGK+5LnJeNOl2Xir1mjWt9KmQ=;
        b=Wa7gSs/j2zP6QSF22jI1GXWzVVNqfUo1pGm7k/F4Lmu6FKk74gc6zMEEqelTBlKXDn
         3DgMgWKxMJ+HTu0KUmD2gc/p3/tPSTIjOypeRJI6qZKkzkrcQJh3yT47FNmhYVZPAxSC
         ILtgL+Eav9OphOTHoebvhCNULXEIsjReceEs7bLFDtBpvtlOJt6Z2qw7WFYQB/wi7xWg
         OBlphjYJAIJEcjUNSZDkIWbhr6phif3NKDD4rEi2dzp+hWqMl23+kF8ULBWf9l2B/PbU
         l07EWX4BS4SHIBmPFLiSH8A+qaAAdAjLRGnUKLAzNdamdRQDsysQf1DPUvBbsgygVxn/
         rIQw==
X-Gm-Message-State: APjAAAWlLeaVxYqUZIEEhT2zMYR4s/yy4TsZ47hbG9WnEL9chucqJRrZ
        4Pef5R/YSWntowNyg2Sd3eA=
X-Google-Smtp-Source: APXvYqyot8v1B0x/MRvK03agB+IzVaXAqf992TgbAnMGoVNvXseag98YyM/nWUUSuGTEL3SxHkNvcg==
X-Received: by 2002:adf:ef0f:: with SMTP id e15mr7773177wro.312.1571398926321;
        Fri, 18 Oct 2019 04:42:06 -0700 (PDT)
Received: from localhost.localdomain (x4dbd7267.dyn.telefonica.de. [77.189.114.103])
        by smtp.gmail.com with ESMTPSA id e9sm14611523wme.3.2019.10.18.04.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 04:42:05 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/2] path.c: minor common_list fixes
Date:   Fri, 18 Oct 2019 13:42:00 +0200
Message-Id: <20191018114202.5452-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.1084.gae250eaa40
In-Reply-To: <20191018110618.GZ29845@szeder.dev>
References: <20191018110618.GZ29845@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 18, 2019 at 01:06:18PM +0200, SZEDER Gábor wrote:
> I didn't look yesterday at all, but now I did, and, unfortunately, see
> two more bugs

The second patch is kind of a bugfix, though luckily the bug doesn't
actually manifest in undesired behavior.
The first is a minor cleanup, so future readers won't have a 'Huh?'
moment like I just did.

SZEDER Gábor (2):
  path.c: fix field name in 'struct common_dir'
  path.c: mark 'logs/HEAD' in 'common_list' as file

 path.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.23.0.1084.gae250eaa40

