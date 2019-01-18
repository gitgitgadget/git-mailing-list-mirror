Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A1D81F453
	for <e@80x24.org>; Fri, 18 Jan 2019 17:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfARRGA (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 12:06:00 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:43146 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbfARRGA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 12:06:00 -0500
Received: by mail-wr1-f44.google.com with SMTP id r10so15881781wrs.10
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 09:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8N/jtIqngKa24GKxN5DV2ZoeqSHuMBsXXdmcwh3m44c=;
        b=fZd02LQUpW0WgaVtfoEXQuKyU7L5PG9sNKpJX8sx05Gwp69fll0mmYEOBVKvPOnlcr
         qpms33bmZLPPRY8Tv8TzX5huMxN49SIf8TpUGtwHcfsu+X9GevrWibi3/8GRY+hyeSoM
         yIyMulMpCxN8dBKHiwDWCDWKcmLW9cp1McCxJ1swAOAjLQgPT0490LGmEBYJ0Zx/qRXQ
         mOfs6cxD7CSa56KvVZcpcw2jikiYdAUiWE5MEycr/FCRJFvMASviWv3pMF8m5ESFiaK/
         AJ+5rPqKT25insxgPqofkdoQ8ExZgZFBkJNInxq/FeOHNaQCMpSAyBkQjEdAAhEu6H0E
         5IeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8N/jtIqngKa24GKxN5DV2ZoeqSHuMBsXXdmcwh3m44c=;
        b=cVMNpueGDloS0qGKEjsvyMo3xH21qmEknSeLYEKLuCoKXhcpJhQ59Vr50DnFwBSM+s
         VJV2wcobB1k0gaWI7b6KHVR1Y35njuYpDYBbp1easFTcwd9sc0T6KJloiM726/tH6RG/
         D3HwrCy+xLgWpwciz/dqrWP8Y6A0y0JUGIbdwHECPWyBhIJiTA//81+jSLXGnkMXHem9
         I6nqiq5cM7YPIEbbVDxWifFysFVb7aSweSHZCq8MOLdt7j/JxxisPhv0GNS6tMxrefxZ
         BBtzs/jiro+56WilBdBYSgrjK8Hsf0Ji8TrkgulLFKCM3Zmq6tXYI7PaIrFiY/UTnbnU
         OA3A==
X-Gm-Message-State: AJcUukezhhkVToloSXAXXzBUCA1WG0ALxnwiF/yEs5btr4dbWPyLzB4U
        r4rjhsmK5+ZFsDz/3G30xVk=
X-Google-Smtp-Source: ALg8bN7kcUN9gyHSYEKFp1fPGkaR6olun5zsxkY4UmgglfbaxxCMkYIFx9jviE78PXijYYT584SoYQ==
X-Received: by 2002:a5d:6907:: with SMTP id t7mr16975503wru.226.1547831158360;
        Fri, 18 Jan 2019 09:05:58 -0800 (PST)
Received: from localhost.localdomain (x4dbd9ead.dyn.telefonica.de. [77.189.158.173])
        by smtp.gmail.com with ESMTPSA id x186sm50476023wmg.41.2019.01.18.09.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Jan 2019 09:05:57 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/2] commit-graph: minor cleanup and optimization
Date:   Fri, 18 Jan 2019 18:05:47 +0100
Message-Id: <20190118170549.30403-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.499.gf60de1223c
In-Reply-To: <a82a2bec-07f5-ccd2-85ab-b9efd406929e@gmail.com>
References: <a82a2bec-07f5-ccd2-85ab-b9efd406929e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 21, 2018 at 06:32:19AM -0500, Derrick Stolee wrote:
> >>I rename these variables to 'num_large_edges', because the commit
> >>graph file format speaks about the 'Large Edge List' chunk.
> >>
> >>However, I do find that the term 'extra' makes much more sense
> >>
> >>Would it make sense to do the rename in the other direction?
> >I tend to agree that "large edge" is a misnomer.
> 
> I agree with you both. "Extra" is better.

OK, so here are the two patches with the rename done in the other
direction.

These should replace the bottom two patches of the topic
'ab/commit-graph-write-progress'.


SZEDER Gábor (2):
  commit-graph: rename "large edges" to "extra edges"
  commit-graph: don't call write_graph_chunk_large_edges() unnecessarily

 .../technical/commit-graph-format.txt         |  4 +--
 builtin/commit-graph.c                        |  4 +--
 commit-graph.c                                | 25 ++++++++++---------
 commit-graph.h                                |  2 +-
 t/t5318-commit-graph.sh                       | 14 +++++------
 5 files changed, 25 insertions(+), 24 deletions(-)

-- 
2.20.1.499.gf60de1223c

