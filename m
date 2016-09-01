Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2459A1FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 07:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752817AbcIAHUf (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 03:20:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34952 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbcIAHUe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 03:20:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id c133so2361756wmd.2
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 00:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FjH63+PXfSXrgGcRRm2djV4JR0wNgh+LkwSIsLc/Q0A=;
        b=J/0GpsjQF5NqCELPJiqIqwbW2tVIZ7B/Gta45wX8fAYC+zswPdVKYr6gDsMesWhXeR
         rk3EqTTffklHmL7Ih0KMSG3Y4K4Zs/o0cmx2hl1Y4AUkTpuh767IwT2jTvqIXtTwYAH2
         hGXvIbJWj7EYVyDX7O1sw1iZCaGFtgMRR4nFyzmvtpW1kWk7ROrQMqSZ1FpmCo8zY+oZ
         LlPO2FowMI31T/hsJzP1eiB59ktatfqV2Q53nN9qdn4HHvYE0gC12SIMbINGKVPTLjoC
         7ptGZ133VQ7KaBaG/uqddWp6JFlrB5HImz1YSSZeZItQTyMY0hi5OPNwowViVStmGDll
         c5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FjH63+PXfSXrgGcRRm2djV4JR0wNgh+LkwSIsLc/Q0A=;
        b=jkfjEZC8+05M3plx81iQmFeFIPZqlF72EjazNy90rvp2yVVuU2SiEXP90918dlD5GX
         b8FNUAlUIYp+hpRiOQjAMnJT+YOyprGKU8fG7FF6xRgwIjBXSf1zKDNVEf0kMx1r7BXz
         UdKyDv8Iw50+pt07gRqPamWjx4sLWnlgi7Dy78vS9Ld1TnsiBEJ8VTOW4oe/TRmT3R+O
         Mde9d91ctwHsflAU7Eow4K2ivWoZzapnJzyavSiWvTV80negYBcKetX+o758FGzZIxs2
         neUhYiaXQ4pGZ5qdF7MdDXCKtM6vPYG0Cai+kILdJz8fXWz/0c/0FcGhtjjM9DxylRij
         RxCg==
X-Gm-Message-State: AE9vXwOAeTdSe351lFChPsjZbYw7RATa6r2xYlF64vDGtN98C1MuOGdIcLCQpnijaeWllg==
X-Received: by 10.28.29.215 with SMTP id d206mr24059224wmd.75.1472714433110;
        Thu, 01 Sep 2016 00:20:33 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id e5sm27535453wma.13.2016.09.01.00.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 00:20:32 -0700 (PDT)
Message-ID: <1472714431.4680.1.camel@kaarsemaker.net>
Subject: Re: [PATCH 20/34] sequencer (rebase -i): copy commit notes at end
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Thu, 01 Sep 2016 09:20:31 +0200
In-Reply-To: <7427d5a9e76264252540c72c5a70e71c3d470667.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
         <7427d5a9e76264252540c72c5a70e71c3d470667.1472633606.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On wo, 2016-08-31 at 10:55 +0200, Johannes Schindelin wrote:
> +               if (!stat(rebase_path_rewritten_list(), &st) &&
> +                               st.st_size > 0) {
> +                       struct child_process child = CHILD_PROCESS_INIT;
> +
> +                       child.in = open(rebase_path_rewritten_list(), O_RDONLY);
> +                       child.git_cmd = 1;
> +                       argv_array_push(&child.args, "notes");
> +                       argv_array_push(&child.args, "copy");
> +                       argv_array_push(&child.args, "--for-rewrite=rebase");
> +                       /* we don't care if this copying failed */
> +                       run_command(&child);
> +               }

I know this is a strict port of git-rebase--interactive.sh, but
shouldn't we at least warn the user that the copy failed?

D.
