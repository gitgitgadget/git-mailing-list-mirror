Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44B131F453
	for <e@80x24.org>; Mon, 15 Oct 2018 10:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeJOR7T (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:59:19 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:41783 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJOR7S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:59:18 -0400
Received: by mail-pg1-f176.google.com with SMTP id 23-v6so8938532pgc.8
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 03:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kLE8v2pVXTx4zT7E35/HvvVPjiqKfTNDbRzF4hO/aWU=;
        b=UvkxadR1ZgTLI0ivj2iWKNXdwaLEbkAQZkWEN1T0epD4EwEd2jQEiPoxWxCLebxlVj
         DxWngAYwU5j5KNoJJZgsXyJzBzm/idZei69vNAqNfUoPkfhiePvJQLSFeby/8lUn0/mV
         AksnVKU12qysJ2z3rkWtZ9STvYRbrptcphEQKcjh5BjHLzrsP6fLEpMTM8JjePJLRMoY
         Zf2lESLOS1c30rJWDEozZCabOkLm6I54pJ5NPwbDYNEBUO8MLumfwmC38P/TfWpv5VVk
         0D7rXeC/EAaM1ZO9CE0qe2/kdHO+xdmQ1Sytkrny8BiSScZZLYNjsRNPWo6RvCOAFizQ
         l04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=kLE8v2pVXTx4zT7E35/HvvVPjiqKfTNDbRzF4hO/aWU=;
        b=KY5+IwHwjySirnnZuUCQaz1hwhsYu0vKTwMUcIp+RUx6sOz6U4yhk1Q7PZNUf0f8ai
         xGnnyT2mXS8DcVx1EeL0FPstr3b+mNsF/07wIxERV1X6x9b8dNYt/H7rjYE9yBfBn7kR
         cuqK/5Ut/Ih8QwfppqHIqYVWX/sNYNSKwpTxheRLcfH1O9Ge2fmT6bJuf1iP0kcpUU7/
         iAk5lqZoMcNwVcCNH4TsRcfRCuYjsGx2RDSCj/ti7F4lKJgWJur/D6fpXbeM67qKfNDS
         3+SIuHeggRFY7GxsZdN/gb8r+j+XJqx1o3xZbZPW8aPimHmUDuplNvDzTjn3JcZdn9KO
         ZxEg==
X-Gm-Message-State: ABuFfojfrr0seiRf0AWtwF3YOX42W2pq6lKEUUkfVMy6wU90Kel2mWBZ
        I0+MTMBxYRIBwxR2mq4ZUL4ht8GJ
X-Google-Smtp-Source: ACcGV60iKv5jb0qUyGgKMrXo/W0O+6G1dA/WxMUhTtPFOFFtiaFuN4VV30RcR402lipQeE0BVu/okg==
X-Received: by 2002:a63:4a0e:: with SMTP id x14-v6mr15206148pga.34.1539598483099;
        Mon, 15 Oct 2018 03:14:43 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id h87-v6sm19354236pfj.78.2018.10.15.03.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:14:42 -0700 (PDT)
Date:   Mon, 15 Oct 2018 03:14:42 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 10:14:37 GMT
Message-Id: <pull.46.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/3] Allow choosing the SSL backend cURL uses (plus related patches)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

This topic branch brings support for choosing cURL's SSL backend (a feature
developed in Git for Windows' context) at runtime via http.sslBackend, and
two more patches that are related (and only of interest for Windows users).

Brendan Forster (1):
  http: add support for disabling SSL revocation checks in cURL

Johannes Schindelin (2):
  http: add support for selecting SSL backends at runtime
  http: when using Secure Channel, ignore sslCAInfo by default

 Documentation/config.txt | 21 ++++++++++++
 http.c                   | 71 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 1 deletion(-)


base-commit: 5a0cc8aca797dbd7d2be3b67458ff880ed45cddf
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-46%2Fdscho%2Fhttp-ssl-backend-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-46/dscho/http-ssl-backend-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/46
-- 
gitgitgadget
