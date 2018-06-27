Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1A101F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934593AbeF0SJs (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:09:48 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:32930 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932159AbeF0SJr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:09:47 -0400
Received: by mail-ua0-f201.google.com with SMTP id s6-v6so806754uao.0
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=AcOkuKcFLUDz0Q9GtasjEOa+TsuC/3e3B/zIRlCjIpY=;
        b=mF+AHdbPLkbbiIYlAs47DkkWt6fRZB8S0WbKaPuSPg6x8LUKe1vXInGzK60vsb/xNS
         l0pAjtmYw4wltle11I8RuUKMf9eZ+ZY93y2sHvzAYiwst2CUiGon14ROyAbF8H9yiOR3
         29abBnVhPMcBQaDtSj20OjJ/SAuO64rYrriyDu9DuO5d06VRNsVKDnayqTiwOwR534er
         zTt9clgAnS1OzW3M9y3BrRS47ty2x1qaie1oY+zhN+00ezzMH1SUU7cgJywtCiaXjPeu
         bQb7XyD6nMHYZOAXltAxgaDhuDIYLul2iAUFQ9PxLxnSRTc6fvQfh5+TcRyrG2xpvSL9
         atzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=AcOkuKcFLUDz0Q9GtasjEOa+TsuC/3e3B/zIRlCjIpY=;
        b=aGFJAeDMyMWVuW4Vc8j6Ls9EPAfvQRA5yEuXXDyeRk8wTiv/yfmnR/qAQV2QDDgbjX
         jFbV8t8lO4vPmHagcihwPHcH3CGD6Lh0XpxXCLtKr1JdnEQ+WMZT7eRJ5UKvNh3vbBv1
         TFk94d+7/r3J0B+bgjWitaHIW0TAlKY2cxPaZVaFzDmJ4lv/wWki2bISkmrc8/8pTaJV
         NWdQ0Te0LNaXrAB+7EsdcY5kc8fiUOI7dQiEYu/tdtlNvhbwl/IPVPfzXAeKK3FHotw3
         Vcajcz1csXlIGT6NbsfX5H4SmYDM63GatqDseYY2u8hrfYzwINhi5C1fK2oLFxQlTtqS
         2mMg==
X-Gm-Message-State: APt69E0V5JWKD7oO06CUeThJDly5sXNWYxxXWAxR616N79X+FGfE5NTZ
        7YEVDr76FlU16OQhZo4VXj2Ov+eTgchwUA+W90Lg
X-Google-Smtp-Source: AAOMgpe/wGUG0+dCR8tZfO2hQD3y8qw2adBJFEe+T1p2WoqIcDbQR30DwTO6l3Ux13TwG5ANCeu28/a0AeDZ8YNSyDge
MIME-Version: 1.0
X-Received: by 2002:a1f:454c:: with SMTP id s73-v6mr3083686vka.6.1530122986614;
 Wed, 27 Jun 2018 11:09:46 -0700 (PDT)
Date:   Wed, 27 Jun 2018 11:09:43 -0700
In-Reply-To: <20180626205438.110764-9-bmwill@google.com>
Message-Id: <20180627180943.35472-1-jonathantanmy@google.com>
References: <20180626205438.110764-9-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: Re: [PATCH v5 8/8] fetch-pack: implement ref-in-want
From:   Jonathan Tan <jonathantanmy@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        sbeller@google.com, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +test_expect_success 'setup repos for change-while-negotiating test' '

The tests that follow are basic ref-in-want tests, not tests on a repo
that changes during negotiation - this would be just "setup repos for
fetch tests".

> +test_expect_success 'fetching with exact OID' '
> +	rm -rf local &&
> +	cp -r "$LOCAL_PRISTINE" local &&
> +	git -C local fetch origin $(git -C "$REPO" rev-parse d):refs/heads/actual &&
> +
> +	git -C "$REPO" rev-parse "d" >expected &&
> +	git -C local rev-parse refs/heads/actual >actual &&
> +	test_cmp expected actual
> +'

Also verify that "want-ref refs/tags/d" is being sent over the wire, and
not any "want ...". (If not we can't distinguish these from the usual
non-want-ref behavior.) Same comment for the other tests.

Other than that (and my other comments), this patch series looks good.
