Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08E6E1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 09:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeGKJwd (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 05:52:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33047 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeGKJwd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 05:52:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so15067136edr.0
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 02:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NUi+A0xGFNZjZD1DFlH0wwsn6V2Zv055KEpAf59HlUU=;
        b=tMW6uWeLm8J8mqUPiiOmhuSfhkk/yz9tRKmRy325ADgmc/7iQ9zJPsG87qi4HCJqjV
         yLUUizaWFqYytHEr3I+/xUAin7cHaXPPxe6nyuQSnxJJ4pIezxaWdDL+SFVj1Hlvv/W2
         kb2Q+30XxzMyoZZ+CEiyOlejqnSo/QzRXY6AWj1kbFuM7r9OI0It5z+/1vAre0HFZecM
         5VSe6lAHRzfJjf1amJOagAPDBZ9w5/QRUB5NZXkq/fK3QQYVtryM7Uzx/HyoqIHX4QUt
         Pkbi+1T40h9jL4o6D081/QoCwzW8SVTwqjMThhjFJplomORev1z446r03EQC0n7CfBck
         O0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NUi+A0xGFNZjZD1DFlH0wwsn6V2Zv055KEpAf59HlUU=;
        b=JRLc5a3QBen4mZboDi4R2FVWMqsF0+E18P5hPJITmmdeO0TOKtTpXA5fX5Pn2/Ez6/
         3nE0FS783gTSbdJvUV/e1G/BAXUmdIbw7W8NiUJDjsS4SV3EBN7JtSLQVlCYAEo7dNs+
         XFI3CppZH2169X7Ct/vhVvYpAUluQgMU83SG65MUmCtVj+J9KqF+8wtBot4jgxui4KhF
         pL4XVZlcvkieEQak80lQRQU0TuG7sexB3UR+f7yT6xlsZjJsVSDs8zENZngsjYMKAmYB
         3cBP8UshCsqF+RmbL2qa/NH/VsKs1TX50iguubml9F5HWWa2WbDpWkZPeFXX6TKwlwAD
         1zOw==
X-Gm-Message-State: APt69E10oy3lrR3rgRdjkq3VEDa2aq26MzM5xP8Q0wuqvgUARKMTXoh2
        uR/QI9Z9AEjKmNlzvBz5vQo=
X-Google-Smtp-Source: AAOMgpcPDjKftGwhgWL7DrGclAdL/zfIzrHVphEWop0ASfwLo8le39b4/vg3ss3FFyqlQIe9Z9r0Tw==
X-Received: by 2002:a50:89aa:: with SMTP id g39-v6mr29082008edg.25.1531302542906;
        Wed, 11 Jul 2018 02:49:02 -0700 (PDT)
Received: from localhost.localdomain (x4db1cc71.dyn.telefonica.de. [77.177.204.113])
        by smtp.gmail.com with ESMTPSA id j7-v6sm9563416edh.76.2018.07.11.02.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 02:49:01 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        pclouds@gmail.com, avarab@gmail.com, dstolee@microsoft.com
Subject: Re: [PATCH v3 16/24] config: create core.multiPackIndex setting
Date:   Wed, 11 Jul 2018 11:48:58 +0200
Message-Id: <20180711094858.3230-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.273.g57f1ecce9c
In-Reply-To: <20180706005321.124643-17-dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com> <20180706005321.124643-1-dstolee@microsoft.com> <20180706005321.124643-17-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ab641bf5a9..ab895ebb32 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -908,6 +908,10 @@ core.commitGraph::
>  	Enable git commit graph feature. Allows reading from the
>  	commit-graph file.
>  
> +core.multiPackIndex::
> +	Use the multi-pack-index file to track multiple packfiles using a
> +	single index. See linkgit:technical/multi-pack-index[1].

The 'linkgit' macro should be used to create links to other man pages,
but 'technical/multi-pack-index' is not a man page and this causes
'make check-docs' to complain:

      LINT lint-docs
  ./config.txt:929: nongit link: technical/multi-pack-index[1]
  Makefile:456: recipe for target 'lint-docs' failed
  make[1]: *** [lint-docs] Error 1


> +
>  core.sparseCheckout::
>  	Enable "sparse checkout" feature. See section "Sparse checkout" in
>  	linkgit:git-read-tree[1] for more information.
