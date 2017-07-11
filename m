Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACEF32035A
	for <e@80x24.org>; Tue, 11 Jul 2017 22:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755457AbdGKWGN (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 18:06:13 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34266 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754028AbdGKWGM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 18:06:12 -0400
Received: by mail-pg0-f49.google.com with SMTP id t186so2619349pgb.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 15:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qmXXJaM711y+pW7F+fhnsQS/WcCbdixOWtZEh3Hd4iA=;
        b=lkenIbXI8mFdnYUjcxGA/Vg+VXOc/NgjJj2b1P570XEzKBI/JduGLs1tkgL58dukT2
         Ny/YPi1gvbGtYbx13/y/KNh8Af8YhNUC10u+cqyZearVcpmj38ZYZ94EOZWILyTllnG/
         3HXCV2o6VpSeOsNUuWz9FF/0XAkkAjhPylG+dFThy2yI0alH/zqxs1JUU47dVw7O6mkD
         4rsU4z5+P3VUhAlCKDhZeFp7dZP0magEWpDGnWSjzBL+f69blUuXvdTUO9wnPvlCXuxl
         OS9cUQPHcy/8LttCFE2EnbmDQR28XSvZ4wo+5BSnyOmJKCuejteBh+mK9kX3D0mFnaBy
         uXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qmXXJaM711y+pW7F+fhnsQS/WcCbdixOWtZEh3Hd4iA=;
        b=b2dscEo/0xBQrhimGQxQ7kClIfn6IF9d8lsWaXO7i1QM0BHHbHPWortxgQ6bv3SyCG
         X/hOuTBxVNkRRUmweIP1I/aphWymCbK4RjRGUkxiPvt2d8jXJ3mXJMCv8WQy/QIq1MMS
         9DXGcA8C4Qhvi8s2nwu0y+AlFY3A6+3nbxRig3rBLnibVDzOL2NWZiyVQZKMpa9VWKX5
         Lwa+jqQ98bQhzxhDHu+c4ODgZ6YFrq3hgnH+4epNVH0PJo8X9cCaF8a0sy6r5UdhdOUh
         gS17xurDU5gTOHLcSeN+Lm+yD2nF/kkE2FTsizXGr2J9LziW/NfVkZ6E6W3FGOlYPJKp
         rXDQ==
X-Gm-Message-State: AIVw113+XEWui9sUMSuZTcKG9A33j368Umsl8q7T2e8eWkTG31eVhRtr
        VglAuZJ7Y0GieEnSPPnZ1pLpXmxndzlfdhEWag==
X-Received: by 10.84.232.74 with SMTP id f10mr618609pln.154.1499810772200;
 Tue, 11 Jul 2017 15:06:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.129.65 with HTTP; Tue, 11 Jul 2017 15:06:11 -0700 (PDT)
In-Reply-To: <523f64e1395124a02316071329bedf9884757479.1499800530.git.jonathantanmy@google.com>
References: <cover.1499800530.git.jonathantanmy@google.com> <523f64e1395124a02316071329bedf9884757479.1499800530.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Jul 2017 15:06:11 -0700
Message-ID: <CAGZ79kZ9Ewxv=8fnRZZaQjpyAdv8df81a9aLRkJzEt5ZU0VcTA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] sha1-array: support appending unsigned char hash
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 12:48 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> In a subsequent patch, sha1_file will need to append object names in the
> form of "unsigned char *" to oid arrays. Teach sha1-array support for
> that.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

This breaks the oid/sha1 barrier?

I would have expected the caller to do a

  oid_array_append_oid(&array, sha1_to_oid(sha1));

with sha1_to_oid working off some static memory, such that the
call to oid_array_append_oid (which we have as oid_array_append)
is just as cheap?

Could you say more in the commit message on why we collude
sha1 and oids here?

Thanks,
Stefan
