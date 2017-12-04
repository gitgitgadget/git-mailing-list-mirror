Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26A6D20A40
	for <e@80x24.org>; Mon,  4 Dec 2017 09:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbdLDJaA (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 04:30:00 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:44831 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbdLDJ36 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 04:29:58 -0500
Received: by mail-wm0-f48.google.com with SMTP id t8so4495231wmc.3
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 01:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=on48o3wvgtnwfS1NICw8QnbE2ZFAizw+ajlUTdhN2qA=;
        b=P3TX98vkgw8pHr2znT8JCUBGW62fuHBlLT0I18/+bvOIIa9nPv8le1ZpDzuIzPhHuP
         JmD5HwT8HgTRMa03zurTcdAz99VB7YhbHb7c/G2IzDJpWOAcYh0b1Kh0Jd+OkDYI1yhf
         UXok1fFtT9NEsbBcodG/B4vnS5YVxMsjN64/Kz7vsxpFXfnHvl5EDnE8ClbvObZFweXO
         94SPA6bfKWRrd7NJGupWXOxS2tRQtx/d46RzuMNSq0HKgSWBMrNWe6cD2YvrrrNXW+Sp
         HGLaDR/4F7odatW8CNsox3LI0BpErp5Xl5VagW2zeiPDQ0rW14VFGMzCZogwCBi3QWU5
         AIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=on48o3wvgtnwfS1NICw8QnbE2ZFAizw+ajlUTdhN2qA=;
        b=orilwM9oawrkDwXQW96r8eEVJdBHMl77lJEyIOsyC66s/mNedB+KygO8NAkSGMmEPY
         T5Z0wlJ7ROhwHD4IUPUk52bu01UcNvR3hrXOf9AlYVWezwE6bt+nA4YQtym9GY3htEnK
         MPgEO8LLlx0gwJRuYSRMrvsgePGOxOVRZjk/5GTXcu7IHAXwiZmCWs9ADzfVoC3FIci0
         qr4T14Dh4ZlYuj6ltXrM6H+N5p/0FztJoks089btuNSh9U9VAWHbUgGChzk9gREl/whL
         1zF/uQfXpnyCA0/N1UwFgg6dCCG/S0Y6aVGpLL8i1Opvieb0rL+/J1UwyVxzWGgAVCqR
         1CQQ==
X-Gm-Message-State: AKGB3mI87Kd2ELBQxVJSlww/vyMZMjJ+KC2wKx1o12A5MARFWnU0ThxZ
        nLu7N1QTYu1bYpkBOtZpseQ=
X-Google-Smtp-Source: AGs4zMYwP8RkppjOeyOzMIn89r95npEbVuo9+Z5UI8N7nA/l6ZQ2J68v38GwA6WuKG26OQFSgJgG5Q==
X-Received: by 10.28.0.199 with SMTP id 190mr6948817wma.143.1512379797864;
        Mon, 04 Dec 2017 01:29:57 -0800 (PST)
Received: from localhost.localdomain (x4db282d3.dyn.telefonica.de. [77.178.130.211])
        by smtp.gmail.com with ESMTPSA id 26sm15535065wrw.19.2017.12.04.01.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 01:29:57 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Amandeep Gautam <amandeepgautam5@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: git-completion.bash: Show list of local branches instead of refs for git checkout
Date:   Mon,  4 Dec 2017 10:29:46 +0100
Message-Id: <20171204092946.6763-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.338.g53352fef7
In-Reply-To: <CAEZzL1CfXn-XXMG-CFNpZL0B-Rq2r1JoD9gWxHOUR25z_zt+VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

>     I am using git-completion.bash and when I try to checkout a branch
> by typing git checkout on the prompt, I get the following:
> 
> FETCH_HEAD FETCH ORIG_FETCH

What is "ORIG_FETCH"?  This string was never present in Git's source
code.

> Will it not be more useful if the list of local branches is populated?

'git checkout <TAB>' should already list branches, and it seems to
work just fine.


Gábor

