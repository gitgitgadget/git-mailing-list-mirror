Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C45331F404
	for <e@80x24.org>; Fri,  2 Feb 2018 00:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751632AbeBBAXb (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 19:23:31 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35995 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeBBAX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 19:23:26 -0500
Received: by mail-pl0-f65.google.com with SMTP id v3so4822233plg.3
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 16:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J9XeJm5PJGo++84MdOolBZQOhIJZD8koOoD20Zbu6wk=;
        b=DtUF2RViw9InSXdZZcGDXH8ahplyxj/tC0SqZc4i5KRbEvWta3MUNbAoMk+6xxafuK
         89jupkyg2bO5bT/rgorWlNX7WvjK+AEFtmB0EPpS996ti6oMSri4icQSUsLLxgaFkhgx
         rHvv4pJJjzsjtzLLfQEHoYak+f7QbUnW+vjrAr9Tz+QE+dxAzBBuoY7KgdjpbAVzWhvq
         PRH/z2TD9nJeE4GUk4z8f+pVp5B3Wea4nbje7CLDKbABUNFwOlQFDx6PB1YfMq3PnMH/
         iSrDgd2o3Hq0ZSn7zcvLazj900TMyZveT/HL1afDqQWeDBZwX5CQCnQFR5kHgMnVFsoa
         MJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J9XeJm5PJGo++84MdOolBZQOhIJZD8koOoD20Zbu6wk=;
        b=EBz7M1O9Q6GuVj4kLAfeA+g2l3RPACaSARgwbuyV1ldwn5HjO/3BPQQwN44C3rUAmb
         iEcc4Ru8WNamtagz9DSWuNtT2MgOlfy4X9jbbF1iGLoeC4cyA7F9DnjQmR1vDiHH3+J0
         dWY6XVvFIp/l5HVUdLoRwwWFNxAbRIDl6aonJ/Sbe+Av/hYG/acpVkwjYRBV2X1GJYK1
         4rHKSkIa8kDqnPjoANyDoz8komq1vXAjdNPV2OrrZUZuBxB/DkXoRc8dJWZTD9M5rITv
         ZANToeZ51zPBchtN7G0oPH3wuiBweN2hNf2hl9ESdYtx2e+ht8S4HhtXO2+eaPRTKLQD
         iQfA==
X-Gm-Message-State: AKwxyteqV6+2DBH1eUiI36KLB81OO9ReIR28MQAvqX8a8ARfKnnNk1TI
        DGBbWj4yYzDMcBJ9/K9R6hTiHQ==
X-Google-Smtp-Source: AH8x225TTwTpYLVfJsD+UukNfY9g7rTW0LYYKB+MocBeoevn11xs5N592GJLsTf60XOyxaqa1fOfdQ==
X-Received: by 2002:a17:902:9a97:: with SMTP id w23-v6mr34029906plp.100.1517531005434;
        Thu, 01 Feb 2018 16:23:25 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id a24sm748894pff.160.2018.02.01.16.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Feb 2018 16:23:24 -0800 (PST)
Date:   Thu, 1 Feb 2018 16:23:24 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH v2 06/14] commit-graph: implement git-commit-graph
 --read
Message-Id: <20180201162324.fa8b38531955ee5378e5c5ff@google.com>
In-Reply-To: <1517348383-112294-7-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1517348383-112294-7-git-send-email-dstolee@microsoft.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 30 Jan 2018 16:39:35 -0500
Derrick Stolee <stolee@gmail.com> wrote:

> Teach git-commit-graph to read commit graph files and summarize their contents.

One overall question - is the "read" command meant to be a command used
by the end user, or is it here just to test that some aspects of reading
works? If the former, I'm not sure how useful it is. And if the latter,
I think that it is more useful to just implementing something that reads
it, then make the 11/14 change (modifying parse_commit_gently) and
include a perf test to show that your commit graph reading is both
correct and (performance-)effective.
