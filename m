Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40462206A4
	for <e@80x24.org>; Thu,  3 Nov 2016 05:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbcKCFgy (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 01:36:54 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33925 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbcKCFgx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 01:36:53 -0400
Received: by mail-yw0-f193.google.com with SMTP id l124so1250398ywb.1
        for <git@vger.kernel.org>; Wed, 02 Nov 2016 22:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+UKSm1fypgaEgne5inv7unsmwPRx7YwPk/gSJUrDDKQ=;
        b=kGNB/VcSpqVWEAGLkBGJezgXUXOMl3LaBW/2c/fDDfPRbDNkuUBjN74+gv+TwWN0BA
         BVan+WYqLKX5SA7MkbxFxYhS77lDoz3K5QIP043KXWRkrGV27X+6i3rjN5eBjZ9KSIcf
         xvkmezSks9HS26XcuRbZYrGXP0ayO5WDu7IjDQQQbw3OSQ04I3tUzBWLKJ1aSI5X6j2R
         Xj0y1OQZxAQ1eh9B0w2yMeQUKQAdMZ0UJJw3ltW6evyp+xywTpEqhR6hgoRq9bqH8Oz3
         dL4cBggOntdduIWGdNu6z0ErtBBOQojA01DFu/VEkM1M/HOPlchn9z0oy4PJlZgDsQF4
         JlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+UKSm1fypgaEgne5inv7unsmwPRx7YwPk/gSJUrDDKQ=;
        b=a3so89h1CrHqn1YHuq1u5llZ2c3wbsmoVKn9mBo4FzRo1hwHZZxre3efUQLRgvpwll
         soh8YXHNR4CKFEYXl38wQLh3DhTwGngawS8e/vd6NqEwwZXmSNp/hdvqQIbfiExfK9Fc
         asYq3EXH6OL2OSDBvBLAkCNaBca59wEj/BnsxyB+lfmXbU/2PGA/VtPPbXEZNioS2c9+
         pQYAaWtMRHL2uEM4fvBm2eUGOIRGwFOWuBFPEy9K/tuar11HLzVkuAfrlAZV4nN1L9RA
         8t1dvuToiMlsFg3NXgp/l3n3OCaQhMETITe7g3NjskkppzRd39MakjjK8NkoYmtXGvCQ
         pgKg==
X-Gm-Message-State: ABUngvctmwzbxrkdfXSf8tBh4KxPymuR4K81I4KJanXurmi5HCWCieK8gTp2rB/Ntt7bgKeczodC/K3KWcX22g==
X-Received: by 10.13.221.12 with SMTP id g12mr6757649ywe.257.1478151412141;
 Wed, 02 Nov 2016 22:36:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Wed, 2 Nov 2016 22:36:31 -0700 (PDT)
In-Reply-To: <20161102231722.15787-3-sbeller@google.com>
References: <20161102231722.15787-1-sbeller@google.com> <20161102231722.15787-3-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 2 Nov 2016 22:36:31 -0700
Message-ID: <CA+P7+xo_2AHx8c7iCkaGeMCH4WynM=6eTOG0arfcBdex-AahCw@mail.gmail.com>
Subject: Re: [PATCH 2/3] submodule-config: rename commit_sha1 to commit_or_tree
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, bmwill@google.com,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 2, 2016 at 4:17 PM, Stefan Beller <sbeller@google.com> wrote:
> -`const struct submodule *submodule_from_path(const unsigned char *commit_sha1, const char *path)`::
> +`const struct submodule *submodule_from_path(const unsigned char *commit_or_tree, const char *path)`::
>
>         Lookup values for one submodule by its commit_sha1 and path.
>

Update the doc text here as well?

Thanks,
Jake
