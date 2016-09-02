Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2D51FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 22:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753244AbcIBWGf (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 18:06:35 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33737 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753082AbcIBWGe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 18:06:34 -0400
Received: by mail-pf0-f177.google.com with SMTP id g202so23005079pfb.0
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WIeylHNQTtR59EcUUqf+kd3v4cDx7XOV24jgf/pdUO4=;
        b=OhQDyfZ/tKp21Un5ZAGx9RWgPVof1sr8Y9Ki+4nv+qc3BKyauuuU7IFZ6c4H8SsNAh
         yWkIDPohbpLxhFC4eiHq/Rw+gdEBR9GJy7C7paykxpGGTDy/b6nybG4TZTvstO1sOPKh
         2Ab72PJRNFOAYTgndQATNuktRcPxebFoUpv95C6Xq1tOMsjUUHAJNzFYsPf56If4RaYV
         COYqXqkKSpHGv//9QKL08OSoEONk+xnDBW+dGD1NFccgVq4mqE5u/Ra1quHW5sHy4dFS
         /aHen7uJnlG1NU0uCQM3kCWmbsejAJWoHVYq6H+0zcSIcjvs4jA8vVO8WDLRbDnlCcVV
         CnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WIeylHNQTtR59EcUUqf+kd3v4cDx7XOV24jgf/pdUO4=;
        b=aau3rmTUNWQY9sd9GtLGYq5lgM8lEHaN7o0nqE8FRFRxUHAtA4Vo0EZHSsgR9LUBpK
         Q9Mcm4zk058f9PXqScf9PAvYN/KlY8qe2AuuOJ8kkLW5iyjnSxOl+ibjgG0ty2RZqCQE
         jnM7q4j5Agp5+mWz37zOFvVr0ezeRLPnTu0DTpWS5/XPUjCkUPj8Qwr6Wlesxrpu3Ydr
         CuoiNeTmyVhVKGmobwBxA2aeb7yLNfAM3UpYejLiltvha10XNF8O8xyx2MQHuOSbTE5D
         HyQe52316FQZtuLpSyAUdd4KtLMXaiDOGs/MkKL8bqK6NMkKXm/QjJIT5JcRIsAyRpI5
         +J0g==
X-Gm-Message-State: AE9vXwOmoofdutK1jdk+9DwG/H2WGaOT9dAc5Uqg9DsFtLmkrQwXV2aMEb4i2CsKmRkqXNNC
X-Received: by 10.98.1.137 with SMTP id 131mr39974682pfb.165.1472853993538;
        Fri, 02 Sep 2016 15:06:33 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id h86sm17007557pfh.46.2016.09.02.15.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Sep 2016 15:06:32 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        spearce@spearce.org, sbeller@google.com, peff@peff.net
Subject: [PATCH v2 0/2] handle empty spec-compliant remote repos correctly
Date:   Fri,  2 Sep 2016 15:06:10 -0700
Message-Id: <cover.1472853827.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1472836026.git.jonathantanmy@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks - I've updated the following:
o better patch description as suggested by Jonathan Nieder
o checking for capabilities^{} - all such lines are ignored without any further
  checks, similar to the behavior for .have 
o minor fix to test_lazy_prereq GIT_DAEMON
o test waits for output of `jgit daemon` (instead of sleeping)

Jonathan Tan (2):
  tests: move test_lazy_prereq JGIT to test-lib.sh
  connect: advertized capability is not a ref

 connect.c               |  3 +++
 t/t5310-pack-bitmaps.sh |  4 ----
 t/t5512-ls-remote.sh    | 39 +++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh           |  4 ++++
 4 files changed, 46 insertions(+), 4 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

