Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 379211F461
	for <e@80x24.org>; Mon, 13 May 2019 22:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfEMWnS (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 18:43:18 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:46524 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEMWnS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 18:43:18 -0400
Received: by mail-ed1-f41.google.com with SMTP id f37so19798096edb.13
        for <git@vger.kernel.org>; Mon, 13 May 2019 15:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=MtdhK1tJigEt/b+BgcMBDjKqzJlYNjEs43WLqIJ7iac=;
        b=En0PNZ9kWoCjFBiBIVq3F6QsiTMAr7iz9HGwH94nD1KyJ9TA3auVekuHO5oiCHekeP
         3TimtQ156wtL6qEC3mv1/bSpunmWAEklhVo36povcihOK6rioSLVyGvjvYkzmt/czAWz
         CdJuWHmh//e6xpSlX4M5xXTXezZYseSWBf1geS/BiOu43FNXgEK+f24+vTQQzCT4ccwp
         hGthSXknS8pmHxaNmPnHwotihkuWRs8d7IjcBc8dnMBlWpF5kZ2q2ilKgreAlSZEvsLS
         8gBaPnBX31QP5LMim4DqrHvAb5nNMpf/5swvlIZJoeyfMudzcmxgCq9dgF90mkVRR4NE
         T/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MtdhK1tJigEt/b+BgcMBDjKqzJlYNjEs43WLqIJ7iac=;
        b=cZAT9Vs38LftN7RlGQuLAoNxRdXmFKUDh+vNf9scaeuTz6eSDgqN11uwK9ip6Zdiw5
         xd5kjiugVet8ABQVQOA8+xi38IC2r8xZxSMz8b8cUvBHv/+SIkpGLYCy6yabfGtultWN
         bXB14U0b4xSd10Od1q02gcCX0wB0uioEonU5+EMH/hb+t3CHfFZavogQKv4QcM1W2Evw
         GBG29Wy69FjpRHo/SIdeUhToy8h9Y8oSX8pfZwzcWtlAczixxS7wkgjMIf4EFPMoutpO
         eFfv2dW0iRc5rCsFVjDtVs4DkM6XdZA+P4XXkoCyqCcM9D5DZF/RiZY5fXqa0niaqGE+
         L0nQ==
X-Gm-Message-State: APjAAAWFv11RArXXwHKqSf2HeFphYMy30E8a+YKMVuqAaCkRSLFL2w5G
        ZRFPOhhROYxKiKtvXJ9lNc1nXGlR
X-Google-Smtp-Source: APXvYqyzjFzwT04ulp8jXL8XAxGJM70rblZ1yba+dx4MA5MEts8uF8lTJQWxhn3QwOxzvN7sWmhfBw==
X-Received: by 2002:a50:bdc2:: with SMTP id z2mr31766319edh.245.1557787396117;
        Mon, 13 May 2019 15:43:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c26sm4101762ede.32.2019.05.13.15.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 15:43:15 -0700 (PDT)
Date:   Mon, 13 May 2019 15:43:15 -0700 (PDT)
X-Google-Original-Date: Mon, 13 May 2019 22:43:12 GMT
Message-Id: <pull.192.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] pkt-line: fix incorrect function declaration
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

MS Visual C detected a mismatch between the declaration and the definition
of set_packet_header(): it is declared with its second parameter missing the 
const attribute.

It also detected a mismatch between the declaration and the definition of 
parse_opt_unknown_cb().

These problems must have been introduced very recently; I do not recall
seeing them before today in any of Git for Windows' ever-green branches
(i.e. master semi-automatically rebased continously onto pu, next, master 
and maint).

You could not have seen it in git.git's own Azure Pipeline, as Git for
Windows' version already has support to build with MSVC (I plan to submit
this directly after v2.22.0 is out).

Johannes Schindelin (2):
  pkt-line: fix declaration of `set_packet_header()`
  parse-options: adjust `parse_opt_unknown_cb()`s declared return type

 parse-options.h | 4 +++-
 pkt-line.h      | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)


base-commit: ab15ad1a3b4b04a29415aef8c9afa2f64fc194a2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-192%2Fdscho%2Ffix-set_packet_header-signature-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-192/dscho/fix-set_packet_header-signature-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/192
-- 
gitgitgadget
