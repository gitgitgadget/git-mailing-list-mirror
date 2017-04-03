Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD4B61FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 22:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751944AbdDCWsm (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 18:48:42 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35123 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbdDCWsl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 18:48:41 -0400
Received: by mail-pg0-f47.google.com with SMTP id 81so133846584pgh.2
        for <git@vger.kernel.org>; Mon, 03 Apr 2017 15:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t5M1gQQXvBlJowJO8dV18LTXj5EzPGwYPqAidumakQM=;
        b=L7m3apqEbPOHE4K1GdR40JrcEYAq5wM/iyQPGVtTuGeMwFrGR/eGRVhFbGRAWby7Gr
         p5amaALVgGXtNGC1Iz+RXK73JSQmKNdD9Mw6W/OorRBbLZiY/3OPxh58+OvMZXfMIHlG
         4+RBVxBAEgwLveDLreWial8degbQEjVennKSDAwSSngD2i16mzD2bBx/Zgum4YOU7b+T
         v/ms44aZXQ0/qK/i0G05iqusAR2/ghTqt/4nDZeuuj532ygYLOecfnifOXX2EsYa6vtR
         uQGPRf2iU9TrZ7CUzUuWss4ahKw+jUpjRIUyA3NnmMjeqiW9fL0Qvhu56jEdfp52uYta
         kFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t5M1gQQXvBlJowJO8dV18LTXj5EzPGwYPqAidumakQM=;
        b=t+3/jTAGxB9VDpOvKcue/TuRvF7SNBNkqE+OOgoGzHQATiO+rJKtYHbvVy0HZ2Gnam
         lSiEszFC7GpGZ4jyPUNIzpa/2Eu8PzsWaxL/9z2Qeh7ZJzRAntbyLPMBM9Wb+TGp9ROt
         yFSGJyhsPdeCEF5PzDGlMnWojySkVIKDmomTJ0ZKhUxAtbM7ZUJJopdZLsoEEvW+M8nJ
         zApMLgps6d32kCSaxaAzxqBSm6bAdzYTjx3ZvnCqTIW+wrznjLj808BrjUHu49ts+9ag
         BYA2mBYv6Zd8ueAfMbuJ/PCPgHKdCQh6mn4+EeIbNw0CPUe1nit5up9B7RtXQxEu4C+X
         HDRw==
X-Gm-Message-State: AFeK/H0qUVhkF1pqsbDkCYoeGnAGshfUO+H1cLdPsDdFFfsaWvZke96B6VVYhVGhNL4Mw35W+15kDiwshGT1vub+
X-Received: by 10.98.137.68 with SMTP id v65mr5845079pfd.125.1491259720927;
 Mon, 03 Apr 2017 15:48:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Mon, 3 Apr 2017 15:48:40 -0700 (PDT)
In-Reply-To: <1491163388-41255-4-git-send-email-bnmvco@gmail.com>
References: <1491163388-41255-1-git-send-email-bnmvco@gmail.com> <1491163388-41255-4-git-send-email-bnmvco@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 3 Apr 2017 15:48:40 -0700
Message-ID: <CAGZ79kYrH73WrXyw+JypdSVfgpvduL-mUVZ3yyEUuib4BTZ9uw@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] dir_iterator: add helpers to dir_iterator_advance
To:     Daniel Ferreira <bnmvco@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 2, 2017 at 1:03 PM, Daniel Ferreira <bnmvco@gmail.com> wrote:
> Create inline helpers to dir_iterator_advance(). Make
> dir_iterator_advance()'s code more legible and allow some behavior to
> be reusable.
>
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
> ---


> +static inline void push_dir_level(struct dir_iterator_int *iter, struct dir_iterator_level *level)

Sometimes we use inline, sometimes we do not:
$ git grep "static inline" -- *.c |wc -l
84
$ git grep "static inline" -- *.h |wc -l
130
# approximate a function definition:
$ git grep -e "static" -- *.c  |grep "("|wc -l
2971

So I think we'd want to have the inline keyword in
the header only (when the code is actually to be inlined).
As a C file is one translation unit, the compiler can figure
out best whether to inline a particular static function on
its own.

The rest looks good to me,

Thanks,
Stefan
