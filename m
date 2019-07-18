Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1F121F461
	for <e@80x24.org>; Thu, 18 Jul 2019 19:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391071AbfGRTIs (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 15:08:48 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:40979 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRTIr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 15:08:47 -0400
Received: by mail-wr1-f54.google.com with SMTP id c2so26648899wrm.8
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 12:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=LBXmoqeuLuBD2N7JnRUQ+0De6igKUmtyKfASIEfqte0=;
        b=SD3DblTUYhPEyf7SxSDpwRbadztdEzYH63qYqzUYaQ2hE1DemGM74tUeLxT4pp2boP
         dmjZVKOsRTWvSFHTMzaaSX2kA76hu4v5w0TVLbftkrRoOi8l+BG9WvKd5NE0vndYMsK0
         J7IJgblQoI0j4JOgN522EJ5g8C++/IBFiRB28nSWMG/nJTZ4y5rLJRrpZjbaSqgXKUEC
         5BAAGrByf+geq74lZ+/hxC9R3ok9y8eXuagXErtiEKeVRs7c0GfMTLvj7pWKoZFLf4NM
         81pv/HsWjanDCaIz7Ns/moU0rO28fKnvl/tArwM5qKPQmcUAga5lDvDaRYz+OoSc3gBG
         jXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LBXmoqeuLuBD2N7JnRUQ+0De6igKUmtyKfASIEfqte0=;
        b=nXYnG42SeZsOzhQQCpu1aYyuzrRGadhUvzIYa8LwrypNYVmXq02Ya+c+cybufR6K1F
         89khtJ47OFu694Jo12LhBoWw71fwgeV0iEwCzFZQ8QG0qjAy4dFIccFG4fEqAh5xzrVg
         IDwU5cqfKEYUarNLeCFDNC0Z/l2/QxDq/ErN2qUtlo8L2qAcbGWjKpn40bpwHFATefQd
         TQgvAcSGnevV9EI5s2iQ9OG2fwNh3ZQMkk4NspqoAljjSCV6t0FLUVfg6ZVk6TT9ILNs
         Pmnnp0E113GUzndwPIa1ndFK4UHVxF2SlAxbHQ7BIVlrGUmAdnrBlafR0w3aAoiQHJ6e
         fs+g==
X-Gm-Message-State: APjAAAVHNjip6vmXs5EpSOjfto9ZXN6dBtvhEp5BABDvzBtdWEPy8zRA
        31F0M8mubqRZNlBfPLYszCVn0da9
X-Google-Smtp-Source: APXvYqyv0nqHIdDX+3lzNnr6GqnZjY+TIYOkAykwY+GNp2psCdiWe95x2kPt27lwifW7mY6MCDqn6w==
X-Received: by 2002:adf:b612:: with SMTP id f18mr39969319wre.97.1563476925422;
        Thu, 18 Jul 2019 12:08:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7sm34808166wrn.11.2019.07.18.12.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 12:08:45 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:08:45 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 19:08:43 GMT
Message-Id: <pull.289.git.gitgitgadget@gmail.com>
From:   "Doug Ilijev via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix rendering of text in angle brackets in README.md
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

Markdown incorrectly interpreted <commandname> as an HTML tag; use backticks
to escape Documentation/git-<commandname>.txt to ensure that it renders the
text as intended.

An alternative would be to HTML-escape the angle-brackets, at the cost of
readability of the markdown in plaintext form. I opted for the backticks to
preserve plaintext readability.

Doug Ilijev (1):
  README: fix rendering of text in angle brackets

 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 9d418600f4d10dcbbfb0b5fdbc71d509e03ba719
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-289%2Fdilijev%2Fpatch-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-289/dilijev/patch-1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/289
-- 
gitgitgadget
