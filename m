Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ABB41FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751019AbdFTCs1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:48:27 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33058 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbdFTCs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:26 -0400
Received: by mail-pf0-f173.google.com with SMTP id 83so62781551pfr.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tkvd4e+WhGTc65ypjOcnC4E+FbQFvi3/sKJE95l3mek=;
        b=Z8oOFRoO2TuQE2JQlhIpqZVRpB2EsrHmyc8SIwdo/fdyxVULk8mkpp3TXvexsVFAkP
         BKS0Sb8pFLOKlibF6Ahmds9szIpYahViuXfJ2h6MFPtMmNjlXwrwQ4TBo3ahXJ3fEtdd
         HWZs+6MHpk5lx9dBBIclcrR8tvf0h9nNw3uTyVTgghHxNRLfYh2P3uWoSrb585oj5dwF
         gv6htyzVPkzp5M/Y8RfqiN8JBYTOGuUBXTfq1e66dmFvnsw6bP4q4NC/bwIfEoBTpYuS
         kh6wicaWlxARSnL3EcxlPuPKwBzNPV4d+rqB0FOLi6l3v7cKbrnUSDVHB4PgsZCzEqvc
         hRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tkvd4e+WhGTc65ypjOcnC4E+FbQFvi3/sKJE95l3mek=;
        b=jFZ2yrOVN/HUjOg/k91LHNZXo6jxhROMKW8XA44xGnpFBiZm/onCC+709rjU88tXQk
         dkeOG9iKDrl96KqoPlEYiY0jAYTh8DmXEr0NqFmE6w66+iRL56oFbgsE7EtIp1kz8KIW
         SAMFehdHjz3880fumfE9EHW/+oOssbUPYA9nHYPAMnw0FaBlaFdF02RrQoYZa+1adJPf
         tk/Xso/nGYfXAcfwBZuDNd6z4XUxKRkBGDZ9rkuZashyGqSH9IRflZxPyfVnRPa14TK7
         kStOLWHVJptBu/hoQZOjC4zfKF7rCAVjwRF9XssOJH35rZvQ4M+YeOTjQoM1QolHw5dB
         z81A==
X-Gm-Message-State: AKS2vOxUY/HlD4Rp9VfXuXSEPOB16Ywtvwtu131hwwyy9c8mON9CNMR1
        PUiNuX6jqJUSzhXL60JSwg==
X-Received: by 10.98.92.3 with SMTP id q3mr8185603pfb.65.1497926905506;
        Mon, 19 Jun 2017 19:48:25 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id i2sm24180186pfe.89.2017.06.19.19.48.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:24 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 00/26] reroll of sb/diff-color-moved
Date:   Mon, 19 Jun 2017 19:47:50 -0700
Message-Id: <20170620024816.20021-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a complete rewrite of the series. Highlights:
* instead of buffering partial lines, we'll pretend all diff output
  follows a well defined grammar, and we emit symbols thereof.
  (The difference is mostly mental, though by this trick we reduce
  the memory footprint for storing one of these symbols from 7 variables
  (3 pointers, 3 ints, one state (also int) down to 4 variables
  (one pointer, 2 ints, one state).
* The algorithm for color painting was detangled:
  -> different functions for block detection and dimming
  -> The last patch (not to be applied) is an RFC that shows
     how we would approach non-colored, but machine parseable highlighting
     of moved lines.

Thanks,
Stefan

Stefan Beller (26):
  diff.c: readability fix
  diff.c: move line ending check into emit_hunk_header
  diff.c: factor out diff_flush_patch_all_file_pairs
  diff.c: introduce emit_diff_symbol
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_MARKER
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_FRAGINFO
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_NO_LF_EOF
  diff.c: migrate emit_line_checked to use emit_diff_symbol
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_WORDS{_PORCELAIN}
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_INCOMPLETE
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_HEADER
  diff.c: emit_diff_symbol learns about DIFF_SYMBOL_BINARY_FILES
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_REWRITE_DIFF
  submodule.c: migrate diff output to use emit_diff_symbol
  diff.c: convert emit_binary_diff_body to use emit_diff_symbol
  diff.c: convert show_stats to use emit_diff_symbol
  diff.c: convert word diffing to use emit_diff_symbol
  diff.c: emit_diff_symbol learns about DIFF_SYMBOL_STAT_SEP
  diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY
  diff.c: buffer all output if asked to
  diff.c: color moved lines differently
  diff.c: color moved lines differently, plain mode
  diff.c: add dimming to moved line detection
  diff: document the new --color-moved setting
  WIP/RFC: diff.c: have a "machine parseable" move coloring

 Documentation/config.txt       |   12 +-
 Documentation/diff-options.txt |   27 +
 cache.h                        |    1 +
 color.h                        |    2 +
 diff.c                         | 1283 ++++++++++++++++++++++++++++++++--------
 diff.h                         |   39 +-
 submodule.c                    |   85 ++-
 submodule.h                    |   13 +-
 t/t4015-diff-whitespace.sh     |  369 ++++++++++++
 9 files changed, 1515 insertions(+), 316 deletions(-)

-- 
2.12.2.575.gb14f27f917

