Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D3F51F404
	for <e@80x24.org>; Wed, 15 Aug 2018 14:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbeHOR0I (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 13:26:08 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:44724 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbeHOR0I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 13:26:08 -0400
Received: by mail-pg1-f169.google.com with SMTP id r1-v6so584056pgp.11
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 07:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=3K2F04b78zjh4BA1xaxXRLDUusgYzsKU6lo19W9B8m4=;
        b=sFD9jivEbIWT9kBMPpjZ2tLLumVuOoYEd5RbJJWUy61kpSP+2pEgQiCv2HV0bfkq2r
         Vo75ZS/gwe7Q5q367rNi4YkuznhgLRiuBNqhHwU9hA0rtSlZnSoiXH8LyWwF9wEN7C9x
         jYbt8bCAkIrAytatNqlMalUAvmMENgMH+OzRNN5iNrnjvMRRvdNpTtLTAoyXpgVM2lD2
         hssai+A9ncYfk5To2sLKD1661Y//cFkAA3Z+ZSoc/V0dtsK47MUuL99OlE1nQqk9AWdp
         ph73IfWVqw5PdIp+Lq2UKZAOif89ItrfmHw7g7vg0ghK/KFgIHblK+xOOjEgeSnWOJXJ
         Tl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3K2F04b78zjh4BA1xaxXRLDUusgYzsKU6lo19W9B8m4=;
        b=RLZK5xkkTGwIhADsvj/wE/k9N4r4ddMPhNEf4qRSMay+eKlurQ00EgXquBp1oKdbiQ
         mi+w5pfTIuboJEDhqbOach1TK1I/LBDoiepqVvTA8t+Fx/bX1P3tSFQqwXZ2f4zrAhFQ
         a26WWnxwW75YVnqg09Fy3bO7V7tgST3n1b40Y/fWveyp4odtAfrRZPbNqiZ2Oa9pchZE
         Z309aLzeLcAad5wRepgJWibWrpn/04vVu03jWtJAX0M7rmkYvsk635EvOjhSOeG7eMBV
         MRrWs6kkAN+ndYZXreZwkAja2p+kmfIiAlwPMhg8xWMjBjdJnYKLAF2ntX6sEEBdWtFE
         xd6w==
X-Gm-Message-State: AOUpUlHe1awNBPo0wqMpxikfWH6+Maj0HcSpsn17OzpLXBYDU2J/S6lW
        MRnlrPDG+zlZsEHr9lfrx+TRbUP+
X-Google-Smtp-Source: AA+uWPz09HfYQxzbkUC82NBCYSBYSOf6+NTmHSQzp1BOhPiwCmX0O70S286esYCHV/D+uWuWYlDHCA==
X-Received: by 2002:a65:5b08:: with SMTP id y8-v6mr25036367pgq.297.1534343623893;
        Wed, 15 Aug 2018 07:33:43 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id y3-v6sm56168834pfi.24.2018.08.15.07.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 07:33:43 -0700 (PDT)
Date:   Wed, 15 Aug 2018 07:33:43 -0700 (PDT)
X-Google-Original-Date: Wed, 15 Aug 2018 14:33:39 GMT
Message-Id: <pull.19.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix make -C t chainlint with DOS line endings
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

Historically, nobody paid attention to our own source code having correct
Git attributes
[https://www.edwardthomson.com/blog/git_for_windows_line_endings.html] when
it comes to line endings. Because historically, we had no good way to
specify that ;-)

But now we do, and so we need to use it. Especially when it would break the
build otherwise.

Johannes Schindelin (1):
  chainlint: fix for core.autocrlf=true

 t/.gitattributes | 1 +
 1 file changed, 1 insertion(+)


base-commit: 1d89318c48d233d52f1db230cf622935ac3c69fa
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-19%2Fdscho%2Ffix-chainlint-on-windows-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-19/dscho/fix-chainlint-on-windows-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/19
-- 
gitgitgadget
