Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D95C202A5
	for <e@80x24.org>; Sun, 24 Sep 2017 11:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbdIXLbX (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 07:31:23 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:52471 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbdIXLbV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 07:31:21 -0400
Received: by mail-pg0-f47.google.com with SMTP id i195so2614736pgd.9
        for <git@vger.kernel.org>; Sun, 24 Sep 2017 04:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=Z6foBbBk6MhtnzK6aOcexzp72i8/J0hHRDwSV9VLd3o=;
        b=AAc3ECXa/p1SNahr3p1/QaU8zXTeG19JwoXFR0EPAZT44De2sUtuKlkdeTP3e67dbf
         3TPZCKl1p15MXjO19wtC3RbKpFjflFtav4v+Iij17Ovg+4zitc8dDcFe8XPlf5ML6LPc
         TrSwrsaFwP0Xe01+qTDvkJ27iIdpFOJVsDOEpmPTQMmIDiZN1jyETJpWlA1AzUpxeRx/
         yu4DVWE3qdBX4mlyRhlPnzj82OeZFXJtZ2h9FfC0lyAlql/6tHCa4Trw8vpeVALzxOLM
         KOSR+nyIZ5gV6j5QcthLv1v/xoxGyYSDmYWEMcw+Ch2kiTA8/93MSIkJ04+LFsSuy9lI
         BUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=Z6foBbBk6MhtnzK6aOcexzp72i8/J0hHRDwSV9VLd3o=;
        b=V1hgyQB6zVcQkEcu9i6v6BkLXeeXw2CyguOnazd3HbnBRIRTbXKZHP0EsZlP3/EGlX
         Gx45BpibQ9jLYsS6a1qoEORriv9Uk2lG51DHj7coIIXaM9MrFjfNDxWjD5UObaNWshMu
         4mx6E/sMIM+8Od+mWY9gcS/sBM3Ibw7E7vJLX7JbV1Jj622Z5xD9CVzqq62fmqcJW1Dx
         UBsBIZhA45ws7E9Y2p9T1UZ9n9Z+dKmKSti7LEZq8Prt8ft1EpjlykPMP1yP8Xug/NyJ
         T7DQfn/xBl1brWUvW2ghyEFS/y9sXUMRp8bxuO7isyMZuMEU4ON6z7XlnZNGbuymHV0b
         tvPA==
X-Gm-Message-State: AHPjjUhLSqi8Gy29QOsO4h+QgukAJkSyQ5HyiHCD9Gc0W1R66PsrNsOv
        itXuau1JR60coZfkNAqt01c=
X-Google-Smtp-Source: AOwi7QCSfZiQl+FM/BuHiSjvnTmEdXNWAiVpapVSnObK/JAUi27aylDOu+Z2aJOP9XKht6v1ANzgbg==
X-Received: by 10.99.98.131 with SMTP id w125mr4532756pgb.214.1506252681281;
        Sun, 24 Sep 2017 04:31:21 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id 28sm7325388pfl.14.2017.09.24.04.31.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Sep 2017 04:31:20 -0700 (PDT)
Message-ID: <1506252671.8678.3.camel@gmail.com>
Subject: Re: [PATCH] git: add --no-optional-locks option
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
In-Reply-To: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sun, 24 Sep 2017 17:01:11 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 21 September 2017 10:02 AM, Jeff King wrote:
> Some tools like IDEs or fancy editors may periodically run
> commands like "git status" in the background to keep track
> of the state of the repository.

I might be missing something, shouldn't the IDEs be encouraged to use
libgit2 instead? I thought it was meant for these use cases.

Note: I assume getting the status through libgit2 doesn't create an 
index.lock file.

>    3. Ask "status" not to lock or write the index.
> 
>       This is easy to implement. The big downside is that any
>       work done in refreshing the index for such a call is
>       lost when the process exits. So a background process
>       may end up re-hashing a changed file multiple times
>       until the user runs a command that does an index
>       refresh themselves.
> 
> This patch implements the option 3.

So, if I get that correctly "git status --no-optional-locks" is a way
to get the "current" status without updating the on disk index file?

> +`GIT_OPTIONAL_LOCKS`::
> +	If set to `0`, Git will avoid performing any operations which
> +	require taking a lock and which are not required to complete the
> +	requested operation.

The above sentence seems to be a little hard to interpret. How about,

    If set to `0`, Git will complete the requested operation without
    performing the optional sub-operations that require taking a lock.


---
Kaartic
