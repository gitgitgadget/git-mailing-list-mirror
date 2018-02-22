Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E9641F404
	for <e@80x24.org>; Thu, 22 Feb 2018 00:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751590AbeBVAoO (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 19:44:14 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41050 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbeBVAoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 19:44:09 -0500
Received: by mail-pl0-f66.google.com with SMTP id k8so1937654pli.8
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 16:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=le1Jfye+CnC1M0UR3K+P9ilHXfr4P0kohqBJC3i3pr0=;
        b=mEvvXC5ahmFbBZqgrHU6xEjXQTcflPlFD9RHLN74AGJiM6/sPAc+YgcyPzOlNvKA3e
         xmd91CvK1LXzVr8GygnNO3ysieJjADMZsEEufDTDptLX77hQTlw3oZwAzHRzE7V+1BjO
         Da2uSu8MDV2omZ0SIX1V4qIxdz8bf7INGE1NiIpkTh8csSsN5xKyIwlTe4ZKoLfWni0X
         6dBKlaigenXAAnP+S00bIwewz3XGEKjDbS1CqV1sFlUYhVwMD0jrwlSuqJZVHGaAeBv/
         MN7NYtH0rYsGy7ipZwhprR9csZl2pWGbT5NvCHrDlue8PgzRvIz5IJrpMazwRfxHdpBA
         zeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=le1Jfye+CnC1M0UR3K+P9ilHXfr4P0kohqBJC3i3pr0=;
        b=O5TENFzNF7Lk/xLnwJ9QMmXBwFWmzlYCLZlq6TIZS3hQquqzKqShA8s5/KfQ+x1Hxk
         qlByC7vvIVIsGD+ZyeeXVWRxaE4w6G/nv1GUPbC0qdcDEH3/LDWZEBevBu50WHbbXE8k
         9ODqavGxc9ys/6Yjc5XbknuXjFJU5vPpWzCyn/DOlv2qlWxAGNLtbMPLns2t/iJ1Xzmo
         4EKPllYUpjRKAffX2WRzkwvaKKyWfz7GeVd56wFE1/yjWJ6ak0M1jRbKCqcIeRm/Av/S
         G3x6uKEuOQ2XQE/rI6sl7dCHr6vlukSIIreAb5sgb5L5BoRtYHc3hgjTxOf6FTJ1hHFH
         PCvw==
X-Gm-Message-State: APf1xPAc+2MXvp3FFWyfjUPyERLhf1Yrvxxw4IqnxXLQGDwfAUkZGsG/
        pB6oatBVQG5667u2ZaCx/yskKEtjIiQ=
X-Google-Smtp-Source: AH8x227HfS1r4Vm/7hlJYpahcYw148trj8Y0l84WDv6+Lrg8yt3d0fCbvxVhLpuLtsdk2qEiLR7XKQ==
X-Received: by 2002:a17:902:6a0f:: with SMTP id m15-v6mr4748418plk.379.1519260248925;
        Wed, 21 Feb 2018 16:44:08 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id m22sm73560562pfg.188.2018.02.21.16.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 16:44:07 -0800 (PST)
Date:   Wed, 21 Feb 2018 16:44:06 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        sunshine@sunshineco.com, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 22/27] sha1_file: allow sha1_file_name to handle
 arbitrary repositories
Message-Id: <20180221164406.c98170765e454b51de80c680@google.com>
In-Reply-To: <20180221015430.96054-23-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
        <20180221015430.96054-1-sbeller@google.com>
        <20180221015430.96054-23-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Feb 2018 17:54:25 -0800
Stefan Beller <sbeller@google.com> wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>

> -void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1)
> +void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned char *sha1)
>  {
> -	strbuf_addstr(buf, get_object_directory());
> +	strbuf_addstr(buf, r->objects.objectdir);
>  	strbuf_addch(buf, '/');
>  	fill_sha1_path(buf, sha1);
>  }

In the future, we should probably have:
 - a function to get the object store out of a repo (so that it can
   lazily initialize the object store struct if necessary)
 - when the object store is obtained, its objectdir field is guaranteed
   to be populated
 - sha1_file_name should take the object store struct, not the repo
   struct

but this is outside the scope of this patch.
