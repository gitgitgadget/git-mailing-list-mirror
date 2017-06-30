Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B817201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbdF3UxQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:53:16 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33264 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbdF3UxP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:15 -0400
Received: by mail-pg0-f50.google.com with SMTP id f127so68710788pgc.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EyGu3XU4OKv9o4GAOgEgURZdhCwXRw4nfXZtexAyLUg=;
        b=REW4tUyntkiZRJ2eMdk+CHyHpEd6x3KqFQ5nK5lWlv3HMdPCiSCEvaXDsXGOe590zG
         VSEp2rJ02myB6wW6E1T8CFFB819d8f3C/zHJNcjTpMMKJM/n9YOo3Yr7rlyMDuwpg5lD
         AwEcx1SKOsw5u10EiOuEpB+EYlcNPb425t/Cd5OvH4lheEapBoaqJCEsbslQtFhafIdi
         q5f5R6YjXFDODAo8kLvMA2BgcLThpZMPsqE09evv6s3OSDtd1VxuoyrNyBskJNpTBBtV
         wROkKM/nObpA70I3ti9NZSDeFnZhMMjwkXdUrCzIyypk5dNt0qbySZMDcTbOVgA38kGN
         9D1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EyGu3XU4OKv9o4GAOgEgURZdhCwXRw4nfXZtexAyLUg=;
        b=lMEdndxuyOhSwJzmfW0FlQPQlvXOG6q4Ikx1n2dNuMThKk37slPDj7aK5pVmTXUIG1
         B7uPaYBc1bk7xJvOEE79yLb5cZsqflYC4MtQUGXlg+qT/7DHR2WFa8xG7UOvRfm6kKJG
         pkmT8MDVJhuObtxhxX4Y7Eu/vBAVBuidY+vhLj5hkiuX12pO72GWlHTDzgvr5EUWUL7T
         KSEGzho/7IPmrEyksCRkKFzJqZmZuAZh61IMSRlf9s4DbZ+irACw1TupKOGpWeNmizPx
         WsjqnX59lC3EC1KKuOyr9h1rJ3Ya9FOSQsD1wYBZVdKKWml0ckDdbvA5Q4uJ33BazxJZ
         F22Q==
X-Gm-Message-State: AKS2vOzBDyhp0k4V7j9mtgMFGClVRc2Ao6B4hTszEaGA4UNaGRamwtLv
        0shjQt6Y3bXcmqYhQNlr/A==
X-Received: by 10.99.65.196 with SMTP id o187mr22920389pga.193.1498855994990;
        Fri, 30 Jun 2017 13:53:14 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id o6sm17222389pfb.110.2017.06.30.13.53.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:14 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 00/25] Reroll of sb/diff-color-moved.
Date:   Fri, 30 Jun 2017 13:52:45 -0700
Message-Id: <20170630205310.7380-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630000710.10601-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:

* on top of the new hashmap patches[3]. It compiles when put on older versions
  of the hashmap series, as the hashmap compare function just swapped void pointers
  in the definition.
  
* better documentation, Thanks Simon!
  ... If there
      are fewer than 3 adjacent moved lines, they are not marked up
      as moved, but the regular colors 'color.diff.{old,new}' will be
      used. ...
      
* clarified the compare function (casting the return to unsigned char, such
  that 0-255 is from the string, -1 indicated EOF. Adapted the checks for that.
  
Thanks,
Stefan

[3] https://public-inbox.org/git/20170630191407.5381-1-sbeller@google.com/

v1:

Reroll of sb/diff-color-moved, applies on top of the hashmap patches[1].

* Supports different whitespace modes correctly now (and has a test for trivial
  white space changes)
* The fixups[2] have been squashed.

Thanks,
Stefan

[1] https://public-inbox.org/git/20170629235336.28460-1-sbeller@google.com/
[2] https://public-inbox.org/git/20170628005651.8110-1-sbeller@google.com/

Stefan Beller (25):
  diff.c: readability fix
  diff.c: move line ending check into emit_hunk_header
  diff.c: factor out diff_flush_patch_all_file_pairs
  diff.c: introduce emit_diff_symbol
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_MARKER
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_FRAGINFO
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_NO_LF_EOF
  diff.c: migrate emit_line_checked to use emit_diff_symbol
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_WORDS[_PORCELAIN]
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_INCOMPLETE
  diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR_{PLUS, MINUS}
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

 Documentation/config.txt       |   15 +-
 Documentation/diff-options.txt |   36 ++
 cache.h                        |    2 +
 color.h                        |    2 +
 diff.c                         | 1309 ++++++++++++++++++++++++++++++++--------
 diff.h                         |   39 +-
 submodule.c                    |   84 ++-
 submodule.h                    |   13 +-
 t/t4015-diff-whitespace.sh     |  434 +++++++++++++
 9 files changed, 1618 insertions(+), 316 deletions(-)

-- 
2.13.0.31.g9b732c453e

