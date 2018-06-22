Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 822CC1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 08:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeFVIdK (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 04:33:10 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35592 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbeFVIdI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 04:33:08 -0400
Received: by mail-wr0-f195.google.com with SMTP id y12-v6so831937wrs.2
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 01:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FrhVNEt1dw6IP23Nj90ft5AKt5AHgu2BnRWizlWfqr8=;
        b=J08u2wG+lPE7zA1zHIt2K1APV8BElZWdKcRRX0asA/Elp0vc0yqcIM29mGKvjXVO5G
         xolTSkN1HzS9mBtJklJIaOMVZ+UwBw/PdgyUxKkUcr1qOcKULT2h9NLsjBWmf+zU+aGh
         aagW2wrqY9Mox/yyBqOKUXDa3bzOcEkoLzCUQcQ4TMERPQ2+EU6oPrvmbpQQ5COL+v/L
         G9+WSB3KWBC2eX0jNs0z5xx5Zc11RUrlxZg3IaSYtu/16OI0x04GUFX6SX/wUfOTjNHj
         KG74OSWeFmZohLDlSXX/UraCiI4BWYvKRTgIrEQ09CmPGGikJI5FJ0B++46FFqTzdknp
         cawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FrhVNEt1dw6IP23Nj90ft5AKt5AHgu2BnRWizlWfqr8=;
        b=mnN3j0nq1DxzC3TNbuu4Hl4tsPopb9X1JR+2qRAXPsh+OomcIdigfMLLEj37c8mWna
         0SNy8uoK62wULTmaM6uf97m1mleJKxvfpi+bV9ifn7sqkfQ2RYtfdsEmxM1vYJL2S21q
         uaBcygjsvRUSXyBS/g71Tg/B/DCO/yUGWQ+QWa4VEfNnSkMHbLQ3OSXzTI4j0oVyGURS
         BLuX1MXn6e4RoczNe9oIzPNRdjEnt0nRiBWiTUoOqdDyEOYghcFLDd626g5kBiUm98TK
         k1NMf9Z3aFxUJWUTBnj5VA2rg5cKCqI8EVTPlbzoDjhyRIWpUmKEJmkil3v1PHjwsGuZ
         JxeA==
X-Gm-Message-State: APt69E3Yw684dW/fk8DwkOEF9z4BSU+M5FcUq3bZk6Dzhew0juAZgarG
        s/Mjf863ZkcVdiowDm4gbmw=
X-Google-Smtp-Source: AAOMgpe5p1nWMpxOImbteJoQk/BSb8m6ccxWA6yE/Rb4zMSB6EeZ61aJIQTqMlIY8/ljQoKWQqbsaw==
X-Received: by 2002:a5d:4b4b:: with SMTP id w11-v6mr726708wrs.87.1529656387033;
        Fri, 22 Jun 2018 01:33:07 -0700 (PDT)
Received: from localhost.localdomain (x590cf49f.dyn.telefonica.de. [89.12.244.159])
        by smtp.gmail.com with ESMTPSA id y3-v6sm7705945wro.21.2018.06.22.01.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Jun 2018 01:33:06 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com
Subject: Re: [PATCH v3 1/7] git-rebase.txt: document incompatible options
Date:   Fri, 22 Jun 2018 10:32:54 +0200
Message-Id: <20180622083254.7311-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.171.g58aaabc06c
In-Reply-To: <20180621150023.23533-2-newren@gmail.com>
References: <20180617055856.22838-1-newren@gmail.com> <20180621150023.23533-1-newren@gmail.com> <20180621150023.23533-2-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> @@ -487,6 +510,52 @@ recreates the topic branch with fresh commits so it can be remerged
>  successfully without needing to "revert the reversion" (see the
>  link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for details).
>  
> +INCOMPATIBLE OPTIONS
> +--------------------
> +
> +git-rebase has many flags that are incompatible with each other,
> +predominantly due to the fact that it has three different underlying
> +implementations:
> +
> + * one based on linkgit:git-am[1] (the default)
> + * one based on linkgit:git-merge-recursive[1] (merge backend)

Referencing a non-existing man page via the 'linkgit' macro causes
'make check-docs' to complain:

      LINT lint-docs
  ./git-rebase.txt:511: no such source: git-merge-recursive[1]

