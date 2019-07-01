Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10F121F461
	for <e@80x24.org>; Mon,  1 Jul 2019 20:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfGAUUX (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 16:20:23 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:36582 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAUUX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 16:20:23 -0400
Received: by mail-pf1-f202.google.com with SMTP id b195so9034205pfb.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jj14Fqja7l+FMw//jf/rk04k7ht0B33trxWsTxku1hk=;
        b=lPSuge7dD8WUSA8si+8qqxXYAdBmsnOq0MvvtmjnEORqc+g8P6oTeKfZwn2WodUEFr
         wJ+EuGZz6KwBk5Oeouh1K6QH44UDaowwv2f4qZCNleUcBmU/homr28PEDqn2c+xVI50B
         sOnCgRR8NjvaYbIYZUb6hPEgfndJFj/USIgdmcw8XWBoDSHH+593i3p19U+wRhlI1wbn
         uNHodbd4+UCn2eZUv65qR8OUd9Q+0u7xHVS7VieS2o/TMWuKeMRX86acwbWul5zzD3Pf
         H1ntctEIHRoDJMN22NL+FeyW1KS4XHY9PoD6VBZWrMDgudhfIL4N/+W58xAV3F0AgECD
         hfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jj14Fqja7l+FMw//jf/rk04k7ht0B33trxWsTxku1hk=;
        b=boO8wODsDmn4DLBSfo0hvyqlxi/1YI1e/LeqADzPhLnQvgMBjeJTBcezYpCq1mXOi2
         0DKCgFqH5/X5sYVaPBnDyZnp6JSqpT/yGYOBKGuKSOn8LWPFkeK6rW6CJ5U9jTvs0bLz
         nBgrKE+oaI4s4qxGJqJFrHMriE0hn0/RhIQ2LDXypg329vfcJnpS1Qcw8Ja4jMVbwuiN
         RauiJQqtFIfaXUk+enEIBU0I70iyN5ADlFcy1qEBdsFo5kJQg+ay5i0qDN22gLqLNGih
         bXXMytOHrF7o+3ae0eSIOLjuUVBzOYQ6UOKZJFWGJMd9Cwq0jPcyg/Fz54mm2dJ90xuq
         ADzg==
X-Gm-Message-State: APjAAAVurvDtIMK0oxIa6wfxnrFMVIAaYQZF4GRRnadR+dZqB5lSoDmC
        PvAzbfg/11MsiTy/VsZL1p94gG/nG1k2lKYQFE1ZN29eERusitsamrmgI5NcNBlPzT2vrLP3lhY
        +ukMDKXRU/+Hu0JJ7ehe1FbeTtcuuGj/DeICWeL+AWs/UpZ3yY/Wc2vOph0jrWAf1LgCYiS0Z5w
        ==
X-Google-Smtp-Source: APXvYqzwo2mcE9o/Olq8+99PxP/iHf2WEOukSNVYPDmIplOcD1LEH55JkwojchUdpzvbVO8PYJV/JGVo9oYF8nFA+VY=
X-Received: by 2002:a63:c60b:: with SMTP id w11mr25748193pgg.356.1562012422060;
 Mon, 01 Jul 2019 13:20:22 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:20:01 -0700
In-Reply-To: <20190701201934.30321-1-emilyshaffer@google.com>
Message-Id: <20190701202014.34480-1-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190701201934.30321-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v3 00/13] example implementation of revwalk tutorial
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since v2, mostly reworded comments, plus fixed the issues mentioned in
the tutorial itself. Thanks Eric for the review.

Emily Shaffer (13):
  walken: add infrastructure for revwalk demo
  walken: add usage to enable -h
  walken: add placeholder to initialize defaults
  walken: add handler to git_config
  walken: configure rev_info and prepare for walk
  walken: perform our basic revision walk
  walken: filter for authors from gmail address
  walken: demonstrate various topographical sorts
  walken: demonstrate reversing a revision walk list
  walken: add unfiltered object walk from HEAD
  walken: add filtered object walk
  walken: count omitted objects
  walken: reverse the object walk order

 Makefile         |   1 +
 builtin.h        |   1 +
 builtin/walken.c | 297 +++++++++++++++++++++++++++++++++++++++++++++++
 git.c            |   1 +
 4 files changed, 300 insertions(+)
 create mode 100644 builtin/walken.c

-- 
2.22.0.410.gd8fdbe21b5-goog

