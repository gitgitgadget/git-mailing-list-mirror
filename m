Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06D5A1F462
	for <e@80x24.org>; Mon, 20 May 2019 21:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfETVxX (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 17:53:23 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:43485 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfETVxW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 17:53:22 -0400
Received: by mail-wr1-f51.google.com with SMTP id r4so16198424wro.10
        for <git@vger.kernel.org>; Mon, 20 May 2019 14:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=haxnGUpsJ+BswOlloHnFoVZfv826s65qjaZcfIPULBE=;
        b=uwyi24lxBVcCqcU9fEY9/sKMUaYI7E4COY+QsUY5ZP/cWSho2dFGnc3DjfDKu0Pug5
         yDG3sDuW0l2wAG0Hb6WXyqzd0KYgxtzgf1v+GX3m4kMn5FhZsD6JqxEZQPCCadT1OpXa
         NrgHtacqEJBoMlH5OMXxbbmTiSR2W5EzDQLn4oUWlR1bvianf+VWTm14q909TkRu/83i
         V4zytE2FB9nCFsajNHA+bnxZWVaCncUAgegZ68r+oCW383gljHtgG9oPOa/p7OpUXX6n
         zRkOQyzMHtuMXNDRNOwJrFEbnpVgK2Iifw4CaeZ/uKUidtasrvGzERibgtN/eOGLCq/u
         CzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=haxnGUpsJ+BswOlloHnFoVZfv826s65qjaZcfIPULBE=;
        b=kZKOIKv2q/6mZE31Ao9PKmG5lpi9MCCTwa+HpFjwPHbHO4UHgEIjteOE4003pu3H39
         uuf/ep42xCi2snZaHA9OnbXvVqI7t5yuv+W7SvLxEY57fmJVWAUSFRTfSKqb673jU9G+
         ACOCtzGEh3RNYctfZ8RORc8fhIkPLcaAWXUCnMP46Iudh/wKh0DjfwwT+Rp45CYhmYxt
         sqQcF0Uz0SNGcH9t3ZGrUYT9sNiejUVqZNSna9inmo3/VP9h0aS3xADL/zW1RxsLlutG
         X/n/4HHxGncBs2LlyKb2rLS7TqlW9+Bf+NF4e0eEAAnf+1b1cmrelwSme5Q+oYtAV2wl
         v39g==
X-Gm-Message-State: APjAAAVR7/6Mkd8VZGmNS/cWto2Qh66TkEDgT3DsOL1GTjVulAjKiK6j
        /tN5WasXCJkB8a7fPma8WfdKWQTT
X-Google-Smtp-Source: APXvYqx/4Ap0+wzE1CBsBZdNGbF0KFHY2tVof2wI6VMo18SJErUTMgQ4cZ9Kdr7OXouIROVzgi3wAg==
X-Received: by 2002:a5d:658b:: with SMTP id q11mr28520094wru.130.1558389201158;
        Mon, 20 May 2019 14:53:21 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n63sm600249wmn.38.2019.05.20.14.53.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 14:53:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Adam Roben <aroben@apple.com>,
        Bryan Larsen <bryan.larsen@gmail.com>,
        Matthias Urlichs <smurf@smurf.noris.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] hash-object doc: small fixes
Date:   Mon, 20 May 2019 23:53:09 +0200
Message-Id: <20190520215312.10363-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Small doc fixes. Maybe trivial enough to land in 2.22, but there's no
rush.

A pair of #leftoverbits I noticed is that we've implemented the
"--stdin-paths" option via unquote_c_style() from day one, so our
current docs lie (and still do with this series) about wanting
\n-delimited files, you can't hash a file called '"foo"' as you'd
expect, you need to pass '"\"foo\""'.

I wonder if we should document this at this point, or just change it
and add a "-z" option. None of our tests fail if I remove this
unquote_c_style() codepath, and it's never been documented, but
someone in the wild may have organically depended on it.

Ævar Arnfjörð Bjarmason (3):
  hash-object doc: stop mentioning git-cvsimport
  hash-object doc: elaborate on -w and --literally promises
  hash-object doc: point to ls-files and rev-parse

 Documentation/git-hash-object.txt | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

-- 
2.21.0.1020.gf2820cf01a

