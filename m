Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE9BA1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 14:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754336AbcJEOYC (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 10:24:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35442 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754283AbcJEOYC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 10:24:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id f193so20217303wmg.2
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 07:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=0rlGOsfVyr/OKmb7/TMUO2XCE78jrBPC0m8FiRNZ8Yo=;
        b=BueMLGYw+FaYtWPNvIhdz/iz9xrM/X9wr5NMK2a8RBLl9AclSlA04in2mrkx9VfWOT
         cPHtP7mOfpbXAltDFZapt08wW8XC+y+DeWirvWc06Ij7rg7NAwiCEmIid76YQY7HVCUh
         aRMWYDNOI+MBKaTW1M1Chrl/HyeC5DB+K5xGqgUNY9KYbhWPa7gqnbUJDCiWnKr7XCE9
         gUiC1AfHpo90EvGG9Mv4UMI1rhlxPyGlW3WpOHg5LjoBCvQe7HeLHQ1RFNeibsfU6UPL
         tqZueIo1PUoBns20b7xbhIJwe7z7D1maVFaaCH6vck/eV+6+nubgbIgkhgumEvcbiVGU
         Jr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0rlGOsfVyr/OKmb7/TMUO2XCE78jrBPC0m8FiRNZ8Yo=;
        b=TR5AsVW00LpOPXkAdolgeuH/S0DIVcJCSvYbtxG64DrcrzK0sbd/nUtcZdAaFyd9iV
         mId5A0RJRnFj/4LqFCBhORBav9WmQ915Ca6MAzI69GS7NMr8ioqwr0qJeUkUJyd1T4x+
         nCFB+/ViMcwRN9pZd89WdEG8He6O6oXZfCPkSltHyoaw11HYZB3POBqSvDE+ilQY9cBl
         gEBjIZi/t0D73WUd1G+KpKX/PzJkitio3IKe3wfMg2AJ/gGKmqbBz75zaYZBJxS4XtCr
         vcHOc2SufeqC5Ymu992GokjLmOA715BY8ifYnANF3dASmbYOsJcgH/6CYF9IWdMLNigV
         gdnQ==
X-Gm-Message-State: AA6/9RkfdRRTTP71HNkLTncqbnBIXG0qTqcGR99zmjB+aq1CxUZljMLvPLvBUV9N78ubaw==
X-Received: by 10.28.168.203 with SMTP id r194mr9418000wme.103.1475677440736;
        Wed, 05 Oct 2016 07:24:00 -0700 (PDT)
Received: from [192.168.1.26] (acte13.neoplus.adsl.tpnet.pl. [83.11.58.13])
        by smtp.googlemail.com with ESMTPSA id k2sm29969697wmg.23.2016.10.05.07.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2016 07:23:59 -0700 (PDT)
Subject: Re: [PATCH 16/18] count-objects: report alternates via verbose mode
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203618.m6kxd3b6h74jbmqz@sigill.intra.peff.net>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <f664a03d-838c-4062-c31b-5bd8fe7f2328@gmail.com>
Date:   Wed, 5 Oct 2016 16:23:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161003203618.m6kxd3b6h74jbmqz@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 03.10.2016 o 22:36, Jeff King pisze:

> +test_expect_success 'count-objects shows the alternates' '
> +	cat >expect <<-EOF &&
> +	alternate: $(pwd)/B/.git/objects
> +	alternate: $(pwd)/A/.git/objects
> +	EOF
> +	git -C C count-objects -v >actual &&
> +	grep ^alternate: actual >actual.alternates &&
> +	test_cmp expect actual.alternates
> +'

This was bit hard to grok for me without quotes around
regular expression in grep (should it be sane_grep, BTW?):

  +	grep "^alternate:" actual >actual.alternates &&

But it might be just me... It's certainly not necessary.

-- 
Jakub Narębski

