Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AAD81F404
	for <e@80x24.org>; Mon, 17 Sep 2018 15:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeIQVBj (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 17:01:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45779 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeIQVBj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 17:01:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id 20-v6so17728457wrb.12
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I+3I1kj5qsDGmhS4W1WoGGt7WIaE0SdJwHAbxp9bICA=;
        b=ZMBYs+vQrYWO77Bexc3NRI88hka7jmXtClDlLNnZeV/qJZ+vqk5FcdUzVZKF4jpkPa
         aBIinWatfphiS/nlODEIGdf6Wq86K53xAVxlx8b++/4Yi9KrwIsKhmbKGJLBvIWWbkmQ
         43OaalkpeBehBn3Qj9QXOGsQNIKEKt93A/Bh4W7eBqfVV63k0xYM1B4WL3KW2uj2sc7+
         xDU5vpF616FloftXFGti77heAnKGLzNtFpW12PWHI0GFzl4+pAU+FlF+ewNS4nBcSIs8
         Vv+vAlWZ1UbxKogROV/DvOpzw2OxjTokd5ov7stJGc8ggGPIRoXrb3NaBjzVerYrL7oc
         +vVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I+3I1kj5qsDGmhS4W1WoGGt7WIaE0SdJwHAbxp9bICA=;
        b=uf9zqWeml1V8vBcThewLCrjKtRdaTuToqirKUuxO3Fui09MYTrNYvE0alMmqpkFa6s
         xUslHUxRlLi4Hz3G2CNGoyOjrF2S+cMXKX6WSMv2BKwe97UEEY8w1c6GaKl3Q2H0HyQX
         tBdhiMQdxR8XL37kuvW3miwIWG2L+bRlaybXpEkCrmiIS7LBR/RAAWIS+snaKW1VojfS
         XNebxOg/pmEUtVZpU+d082FUpFO39tnmgOUlvRSXt3UQpvQP/on6eFosa1zD7zz7bpz8
         sEh0OoavxIFJpacLkIPqtQMiYX3oDUpHU4uOjL6TiC8d/smaYLU9/RNIwS7Fa5SO/UdX
         TKxg==
X-Gm-Message-State: APzg51Bt55fiSJzkZiQSYRBUqL+4cyEq2IXgJY2mQyuLYJIUCA6Z3C9I
        cWz8JEW+9EHl2t57g3fULPFz5vAjU50=
X-Google-Smtp-Source: ANB0VdYeUWNCEtb1YIu/8mzVihoc18d4GCQp6LEux+6Kk4tOkGzk1XwYtK+asOjmkY56bxCjwwxSqw==
X-Received: by 2002:adf:9d1c:: with SMTP id k28-v6mr19967498wre.104.1537198426632;
        Mon, 17 Sep 2018 08:33:46 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 144-v6sm10680560wma.19.2018.09.17.08.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 08:33:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/2] commit-graph: add progress output
Date:   Mon, 17 Sep 2018 15:33:34 +0000
Message-Id: <20180917153336.2280-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a
In-Reply-To: <CACsJy8A5tFxAaD-OqNNvMmX+KnbmW=O7JCCBbY-5dZa8Ta7QYg@mail.gmail.com>
References: <CACsJy8A5tFxAaD-OqNNvMmX+KnbmW=O7JCCBbY-5dZa8Ta7QYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Micro change since v2: Missing _() in 2/2 pointed out by Duy.

Ævar Arnfjörð Bjarmason (2):
  commit-graph write: add progress output
  commit-graph verify: add progress output

 builtin/commit-graph.c |  5 ++--
 builtin/gc.c           |  3 +-
 commit-graph.c         | 65 ++++++++++++++++++++++++++++++++++++------
 commit-graph.h         |  5 ++--
 4 files changed, 65 insertions(+), 13 deletions(-)

-- 
2.19.0.rc2.392.g5ba43deb5a

