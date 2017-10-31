Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E24520437
	for <e@80x24.org>; Tue, 31 Oct 2017 21:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbdJaVS4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 17:18:56 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:52737 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbdJaVSz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 17:18:55 -0400
Received: by mail-io0-f171.google.com with SMTP id f20so1871432ioj.9
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jldlhEnAsGMqtRUIBfnKsRnF/4stn0kbz77OlmSi49c=;
        b=dxBeAMeY4aKTUrR1GX8nPvan1L6006OCWH9cpa62N508+xJAi+oM/R5YrIXpuMcEV2
         PtZY2lFiDPwpA31vjEIRMQnyIpcyBQ6FKyiRHuh3j1p1LH9AhKkRCi56TliSSXyKPZJf
         1asfh+EjmQ3BSWEyI+i/DAueav9oHiMPBTGPJUCHr46wCnbONdVSTP3tD8TO4YfVFiwr
         9QQg/awnj9lPcEdwDwe55dZZBwlMn8t+V8h7rjrdVe0u54K5mQ1W4pnb5A1aCaO+yCUF
         WLM89N8IGsPhXnOUe4WXps7lkVCNTJNpsmYQiwRFJX3kf9iLflhYJj6BCBlqogpEOLQR
         4LkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jldlhEnAsGMqtRUIBfnKsRnF/4stn0kbz77OlmSi49c=;
        b=YjVLLv5hR/7jxPpvVC9RWPAsBzK7NXXJhHcnVMqL0dRNGOatMnpnq7L9St8q682Dny
         Ia+vdUj7GhQ8OlPdtHZSAviC30e2tl3FCYkQcOufJ3k/KXAXPp4LQ0nLKDwZGvGSd4Xi
         cdvh20HwJxXJPThGEsUu3y4QF7QPJMu1RUlLIj9A7fuSmOt/65TwjIvMy8HVNYhYGocq
         Hnw5fodoyVTvXYBBeYIF0QcCzDwNTK6eogILxOp0DbkH5BmnlJ0XmUSmMADOPWRYOGpL
         mezDNQjFqxtP1O7c4j9Fi3CmGOadDik9CHV+EVACQUXFxXe/8W/yDMW5bDAO8lkgqCNh
         lHZw==
X-Gm-Message-State: AMCzsaWESRGScYaVGzq7XHN/rlMLtwtUjCutp89Lh3gCZjY5EmOm9TH3
        4dlpT/nV1J01EYqsP+bkEXpk4Q==
X-Google-Smtp-Source: ABhQp+SOTGDm5DDLlCwPPc9xHQSRMHGnS9u3fh3GWSWAzIA43AilSwh1cYaTz20i57Nlrr8rC89CFw==
X-Received: by 10.107.136.68 with SMTP id k65mr4117402iod.143.1509484734547;
        Tue, 31 Oct 2017 14:18:54 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:55a5:57f1:5248:2d32])
        by smtp.gmail.com with ESMTPSA id e89sm4570366itd.3.2017.10.31.14.18.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Oct 2017 14:18:53 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info
Subject: [PATCHv2 0/7] git describe blob
Date:   Tue, 31 Oct 2017 14:18:45 -0700
Message-Id: <20171031211852.13001-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171031003351.22341-1-sbeller@google.com>
References: <20171031003351.22341-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:

* other variable names in patch v1, the commit message explains the
  unusual strategy for the scratch pad variable, + assert
* less ugly test in p2
* typofix in p3 commit msg
* patch 4 (debug printing) unchanged, awaiting discussion to start/settle.
* rephrased the man page in p6.

Thanks,
Stefan

v1:
This is not an RFC any more, but a serious series.

Occasionally a user is given an object hash from a blob as an error message
or other output (e.g. [1]).

It would be useful to get a further description of such a blob, such as
the (commit, path) tuple where this blob was introduced.

This implements the answer in builtin/describe,
however the heuristics are weak. See patch 6 for details.

Any feedback welcome,

Thanks,
Stefan

Stefan Beller (7):
  list-objects.c: factor out traverse_trees_and_blobs
  revision.h: introduce blob/tree walking in order of the commits
  builtin/describe.c: rename `oid` to avoid variable shadowing
  builtin/describe.c: print debug statements earlier
  builtin/describe.c: factor out describe_commit
  builtin/describe.c: describe a blob
  t6120: fix typo in test name

 Documentation/git-describe.txt     |  13 +++-
 Documentation/rev-list-options.txt |   5 ++
 builtin/describe.c                 | 125 ++++++++++++++++++++++++++++---------
 list-objects.c                     |  52 +++++++++------
 revision.c                         |   2 +
 revision.h                         |   3 +-
 t/t6100-rev-list-in-order.sh       |  46 ++++++++++++++
 t/t6120-describe.sh                |  17 ++++-
 8 files changed, 213 insertions(+), 50 deletions(-)
 create mode 100755 t/t6100-rev-list-in-order.sh

-- 
2.15.0.rc2.443.gfcc3b81c0a

