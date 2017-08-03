Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E9981F991
	for <e@80x24.org>; Thu,  3 Aug 2017 22:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbdHCWcF (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 18:32:05 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36137 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbdHCWcE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 18:32:04 -0400
Received: by mail-lf0-f54.google.com with SMTP id o85so208811lff.3
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 15:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YMYm69vU4GFBT/Z5UInxROlp3lXJQI0+qC7A8znYX5w=;
        b=RWIgEP2QrXL645TCiQz9tA7yegwS191cxe0oVktMvUO50zkDcYeLRx2qvsdRT3XOlC
         poJvSSdRaiQxWGvsD/2qsY4wn8A9TDaHybkSd5EOgWBs5nyfdA+gfFV2EttGfDprSM1c
         xlEaVCYonn/pdKcSYIAcs8gDw6UjfASdxZbKsuM734aNoDNCoAHpsPNIj5YBNneQ3HKd
         z9mro34dVqBvKVVorzgcPEP+Q/CJYfd/j+TWidkycZkKB8neFb3u8KgYfLE50xag4fXR
         HXne2pshtwtgBhUSQqlkap9DSBmaDybDqbAkAQSR6Le+T6ApuN4H2COPqErRgbu/kYMm
         3CdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YMYm69vU4GFBT/Z5UInxROlp3lXJQI0+qC7A8znYX5w=;
        b=g8s5zb94NcsKkMMQMGZnVKPjgGNtuqpKDXG1zzilfb6w7Wa8JnlZuhP3CoH2jhpcMX
         oiz/QRmLQtdnw3hATM0dpAbN9tnEGYEo3fps9EYjG3QQdOi9KncFWRkHYecrKBeH1w9m
         3sOfZHzNcZINrTs9GCyVHXd93B7ahcyTJjmRq6JZW9mW6RzavH3Lg2NpO3KpPRe3ZCmB
         qWkYdl+mlihsB51Y9O32c5ylJAHk9TzYPVrzOr6OUThY3sip7iKOMSzPtjHDR+4jznCv
         QrcLUmRpsmgZyrSaZqtRA/Ce1MMDlNCUuw0kCMhHn34xhaI/K3CuX8nUZjiY+XWA6Ajy
         NUbQ==
X-Gm-Message-State: AHYfb5jT1VnmEr8q5U9MXMdTeQtZvYOc9YblZWFN+1WO96JJxs8MFOnP
        zdTMMWQvSCF6N/3aPCTWbnO5S2+S3OLmlYA=
X-Received: by 10.25.15.221 with SMTP id 90mr92980lfp.220.1501799523086; Thu,
 03 Aug 2017 15:32:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Thu, 3 Aug 2017 15:32:02 -0700 (PDT)
In-Reply-To: <20170803222544.17216-1-bmwill@google.com>
References: <20170803222544.17216-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 Aug 2017 15:32:02 -0700
Message-ID: <CAGZ79kYc8FOhQmez2Hk0rtNhhWHMTMBOQkwhj-wwfuOmcVZZjw@mail.gmail.com>
Subject: Re: [PATCH] clone: teach recursive clones to respect -q
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 3, 2017 at 3:25 PM, Brandon Williams <bmwill@google.com> wrote:
> Teach 'git clone --recurse-submodules' to respect the '-q' option by
> passing down the quiet flag to the process which handles cloning of
> submodules.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---

Yay! Thanks for this.
Looks good to me.
