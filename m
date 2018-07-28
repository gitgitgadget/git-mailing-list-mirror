Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2793B1F597
	for <e@80x24.org>; Sat, 28 Jul 2018 06:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeG1Hx1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 03:53:27 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:44458 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeG1Hx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 03:53:27 -0400
Received: by mail-yb0-f195.google.com with SMTP id l16-v6so2871339ybk.11
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 23:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tc9Egs9QeLHmfo0NbnwXPWm7lgPoylVVXM+coEO+lD4=;
        b=XYKg00+xfgDKHZOq4PoYr1aJaDlD6K5noXMKTzOCtomo66+FBJC7oY0AOTriYRUeIR
         pmzqhWVIUg64jOiEZtZ+UWWoLfB4++iTLSyjcgRcvAFqmvrF42QmhFoVyPrVmbJ0/Spd
         oDZzOpz/ZQ+xhgNvDXRnSJicIlzzsxieUXUcBmR5PYtOnX10JSGcRSYJcgyG+d748+BJ
         XzuwLj1LqvSe5Wt4ryfd58fF+SNRFPZLgwE7WmnJv4mgBFFz3mqrzlCt7Zt1R8G4bcwf
         Igv3+6v5F+WpaoI19pqeSMTU4a+D6eS490vrrcoyqHUAvQXVdVHdVGXc+1XAeERhCW6z
         adlQ==
X-Gm-Message-State: AOUpUlG+jfczb0TTgtih7qETRQX1p5D3I+Z8ShWVQGBAojD54hcxeL/g
        2EpA3WIeXLfYUT/4NAjPOxi04kofDDjQb2sBYro=
X-Google-Smtp-Source: AAOMgpe4XsPdUVAQ4gBmnoWisfhQQLxIL3UbNdZnfYh+Bwkgkn+6Y5EMr54ZVl5fibMv4sebU9v2X8jFLkvnZKiSjz0=
X-Received: by 2002:a5b:601:: with SMTP id d1-v6mr4923811ybq.295.1532759287459;
 Fri, 27 Jul 2018 23:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180728030448.192177-1-sbeller@google.com> <20180728030448.192177-3-sbeller@google.com>
In-Reply-To: <20180728030448.192177-3-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 28 Jul 2018 02:27:55 -0400
Message-ID: <CAPig+cRgfeSTFLdGpUkzH5PuKE39W9CFxx--yarF_27q1c=yCw@mail.gmail.com>
Subject: Re: [PATCH 2/8] t3206: add color test for range-diff --dual-color
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 27, 2018 at 11:05 PM Stefan Beller <sbeller@google.com> wrote:
> The 'expect'ed outcome is taken by running the 'range-diff |decode';
> it is not meant as guidance, rather as a documentation of the current
> situation.

I'm not really sure what this is trying to say. It seems _too_ brief.

Did you want a space after the vertical bar before "decode"?

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> +test_expect_success 'simple coloring' '
> +       q_to_tab >expect <<-EOF &&

Why 'q_to_tab'? I don't see any "q"'s in the body.

I also don't see any variable interpolation in the body, so maybe you
want -\EOF instead?
