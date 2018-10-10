Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9764C1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 19:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJKC07 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 22:26:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41532 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeJKC07 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 22:26:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id m77-v6so3087966pfi.8
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 12:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=IEvUUr1hMoUhlNQzr40S1ltj8Hapd+bFRdMRlnbBNe8=;
        b=IpZRzxAtDj/JtUz+FaOZqt2MBs7bRiyuZKFrUMx3dGcP+0C5dqSIclFhBA7Va13TqR
         5WCa3hDGp017Ks0H0vpoSDqVKlMf+w7FPApHYCEXHyr8Rhh6glrxWqBiwf87SKgG5zC1
         icEE/MWWHIuYl4h4TFYcTS8tKXex04YmRhyOhUSr63LkZHYa+HjFLICqr/pcqxLy7T9a
         dMMriYeWJhEqIEl0S00OgMofd3cdpcByFGmZRrMTqy/5L6l0ku45+0xYgklOBaq1uuPh
         sFFWwSVWLJrUKgb2YCw/0rI4t/VyBTBsVz+LA6NoJVf5P1f7WK+lwwWfgcxtejw56uTa
         JhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:from:to:cc:message-id:in-reply-to
         :references;
        bh=IEvUUr1hMoUhlNQzr40S1ltj8Hapd+bFRdMRlnbBNe8=;
        b=cITA3fTqAwtQUZu/Yxs9kaOs85nuFzbpoJVNmAF1EmzW0LDGE5QwVm/3wh8BHfh9JU
         ra+Q/pQ1fJaFjXJmVizbZKV1k1WQeLAmlvkaFiaQ42nGXYSte3y1Oyv82/sXPTJZCqnE
         yYo8f5bEXoS/4ZVhoqilhRFTDAn1oV3KS+sP2pybpf0WdLIKSeUwGLPVcuo1Nwp+lNul
         Yp8gUGK1g/mBQKmL9W5YzrLozYu9/ZzV+iQGF5AuKSX317+hWHQW9MocXRfOAfNaherc
         kx5I8YSn+YXFWoBGILHwrmcmJj8oqdyIA8hymqp9rj79FqbC9uU3mHooFOl7DIQqz4wz
         BuYw==
X-Gm-Message-State: ABuFfojahgiLja2U6TCFFbNnAWlPEw3uAjVDINwNG22nmSgHXxlbAzcy
        VND5/0duoWxMncCprNlDXtU=
X-Google-Smtp-Source: ACcGV62j4gMWZPkC1Lv4GCoR7NHvz132lzw080ZPWucTXHGYwEwmD56hCUpzo4+l/FVnoaOTeQxo1w==
X-Received: by 2002:a62:3942:: with SMTP id g63-v6mr37004087pfa.170.1539198210457;
        Wed, 10 Oct 2018 12:03:30 -0700 (PDT)
Received: from gmail.com (host-185-193-125-115.njalla.net. [185.193.125.115])
        by smtp.gmail.com with ESMTPSA id f22-v6sm36064847pff.29.2018.10.10.12.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 12:03:29 -0700 (PDT)
Subject: Re: `--rebase-merges' still failing badly
Date:   Wed, 10 Oct 2018 19:00:17 -0000
From:   Michael Witten <mfwitten@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Pratik Karki <predatoramigo@gmail.com>, git@vger.kernel.org
Message-ID: <eba7b565c9d248d1aa930fef4e245a83-mfwitten@gmail.com>
In-Reply-To: <645452fda0ae411d86487b76aaac8151-mfwitten@gmail.com>
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
            <645452fda0ae411d86487b76aaac8151-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 10 Oct 2018 18:51:17 -0000, Michael Witten wrote:

>         merge -    # Same as merge -C abcde r1

That should be:

          merge -    # Same as `merge r1'
