Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 664721F576
	for <e@80x24.org>; Tue,  6 Mar 2018 10:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753393AbeCFKmU (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 05:42:20 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38087 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeCFKmT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 05:42:19 -0500
Received: by mail-pl0-f66.google.com with SMTP id m22-v6so8099471pls.5
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 02:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+5ReWo4J9ZwpWjfLTP9BQKLMr4M48OjCw44BI94gFYo=;
        b=hqgfskiFpc0eSFeZA1piGtRQQmzefOCEim6/LZnNWypE+k7vmMVcmV9FE1xjs9njzr
         XU5T0jj5RHpolh4pVjZ8YN4RHD2SHQSVWtIvp/2HFltpApts49o7b/oEanSbYKzYp2vu
         Xva3TyftB47uOtzMMsmIJMmPVDmv2NoWxGrVrhyWUs0QzcksyZ/RuXDGM2bS+jxnmsTb
         pppVtuvGgwfE9XzcRl0hjViqSD64HXFeBc9KnWWN+jN+LnXCI2e4AK+4fFmyOTfFaDWU
         CVPmx6EcyimWc8vXWRCwlhUYAmaXq+m6VnMPrrtbTx8X6acav0/F6TbgnW5aOkiLyxwp
         WfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+5ReWo4J9ZwpWjfLTP9BQKLMr4M48OjCw44BI94gFYo=;
        b=StgAlgn1e+iPIJQ7juNwTcdkp7pBjbisn4IgV3pZ/MI1ToDM6BGUEG67YHkLEtqkzU
         0pRmDw/fxso43Uny0ZTPKHdi79kWq1u78D3wOpqKQslz953q2VmMi+7gNnE+DTP77565
         kOzlaXDJ7vpqfxpCao4+Auu9c2T/KZx0opSKD3sxaDiRYkxDGRIuenzzTfsJDYl+0Rrz
         43FV75MwNPjtTXdTVlB5D5Wyl/qXrlEadhdgeveVvwpLr8kkOGorhnEAOUeld1GaV9J1
         4fWIqbIwH12x45kc/CIcMF1KKaQKSCUQhORcHdDxxZt+nUdYDXm6vzdOBwJP59Q/3xZm
         OQYQ==
X-Gm-Message-State: APf1xPC7VR+dTOKHIFexd8n0rXo9CmBA9ecKtRSjvJA05yXODiaLStYZ
        MGuidda4DeZyc/sSNHmiv7I=
X-Google-Smtp-Source: AG47ELtGFiyJtes27+12/kWG8oCR0sxDdN54iSPIxoigRn1iAY7we0TkgjGV1fg00NWZUFItwcynMQ==
X-Received: by 2002:a17:902:28c4:: with SMTP id f62-v6mr16148057plb.411.1520332939090;
        Tue, 06 Mar 2018 02:42:19 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id i1sm33572901pfi.116.2018.03.06.02.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 02:42:18 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 06 Mar 2018 17:42:14 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     e@80x24.org, git@vger.kernel.org, peff@peff.net,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/5] Avoid expensive 'repack -ad' in gc --auto
Date:   Tue,  6 Mar 2018 17:41:53 +0700
Message-Id: <20180306104158.6541-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.784.gb291bd247e
In-Reply-To: <20180301092046.2769-1-pclouds@gmail.com>
References: <20180301092046.2769-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm pretty happy with this now. Like v1, this is about not touching
the giant base pack when doing background gc. This saves about 2/3 of
memory, which in turn should improve performance if you're under
memory pressure.

v2 changes:

- the core idea remains the same, mem_have is increased to half total
  memory though. I figure including the whole mmap'd pack in the
  memory estimation may be a bit much, which is why I make this
  change.
- no creating .keep files temporarily
- the config key is renamed gc.bigBasePackThreshold (named after
  core.bigFileThreshold)
- note that if you set gc.bigFileThreshold, then normal gc (without
  --auto) can trigger this mode too.
- you can also control this with --[no-]keep-base-pack
- documents and tests
- some more progress output improvements

I'm _not_ doing external rev-list in this series though. I found out
that we have added more and more stuff in the internal rev-list code
path over the year and simply running

    git rev-list .... | git pack-objects

will break stuff (the test suite first for example). I will do it
because it does help. But it will take some time.

PS. This conflicts with sb/packfiles-in-repository on 'pu' because I
introduced new references to the global variable "packed_git" and
prepare_packed_git(). Resolving this should be simple though:

- drop prepare_packed_git()
- replace packed_git with get_packed_git(the_repository)

Nguyễn Thái Ngọc Duy (5):
  fixup! Add a test showing that 'git repack' throws away grafted-away
    parents
  repack: add --keep-pack option
  gc --auto: exclude base pack if not enough mem to "repack -ad"
  pack-objects: show some progress when counting kept objects
  pack-objects: display progress in get_object_details()

 Documentation/config.txt           |   7 ++
 Documentation/git-gc.txt           |  13 +++
 Documentation/git-pack-objects.txt |   4 +
 Documentation/git-repack.txt       |   4 +
 builtin/gc.c                       | 153 +++++++++++++++++++++++++++--
 builtin/pack-objects.c             |  51 ++++++++--
 builtin/repack.c                   |  23 ++++-
 config.mak.uname                   |   1 +
 git-compat-util.h                  |   4 +
 pack-objects.h                     |   2 +
 t/t6500-gc.sh                      |  29 ++++++
 t/t7700-repack.sh                  |  21 +++-
 12 files changed, 295 insertions(+), 17 deletions(-)

-- 
2.16.2.784.gb291bd247e

