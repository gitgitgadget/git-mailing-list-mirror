Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A371F428
	for <e@80x24.org>; Sat, 28 Apr 2018 17:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751181AbeD1Ryx (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 13:54:53 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:47098 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeD1Ryw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 13:54:52 -0400
Received: by mail-wr0-f195.google.com with SMTP id o2-v6so1606158wrj.13
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 10:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ifIiZ7f6ui7L1iI5WRNXKSnlS3kI6UB27J8uX9a7bLI=;
        b=LUeLf8vSZqA7R4wkJowq05EkHkyZLpjm7Z9G3/OjiDfs+mjC6k8IAp+TvnoLl++nB4
         OPScoyUsvWHNdcqzT5XOyRI/2WFnwDmbc+nGBDblOrV02MIML/U0afN0UCBa42SBMvnf
         12ZZ7Q2gHG0KtG0dJrXh7E/Z6VmCiIGuaXJR2s6QxT/Zo/pyepwlZLfZ4e8HSVkw1bwa
         iQ0GsmT1rm4nOZFaNqgc/tnI1XIg04hYznN+qdPeBEpexdcOHrhhB3ar6yk8fhBt8idA
         /zSlcOte0n2e98J4FAgKX52CQpVWB6CY/6BadxyWrtpKupio4Vwwbgd8r/WzD/Xw222G
         kX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=ifIiZ7f6ui7L1iI5WRNXKSnlS3kI6UB27J8uX9a7bLI=;
        b=dl75hdrB4e8NGfYvA91tIseVnDZJSheZeX095HsofdD60gz3RmqoOumIj1ZRICki3k
         T0Aqe2//JSVAi7FoPOObyQPijHJpqKiUskuBBWtOU4Dz3AaUcvtIy0r0ThvCVhvHe8j/
         q6yFXqK4oUAivlWH243T0DmuqwrNf1YohFRWJxaaL/xQAku3Tp5kJTDVMW/Bt123xfZ1
         IbTeCS3UqDV8NudaojIbndKkqqBB71an9WZVKNP0GrXRiAvsgpHndfp8bAVe7ogGN1tq
         AsFkO5ICLw5XUitnNL1g7U1UhvujUpXV4y9rdhYvvOU2jGFHbwLDDlkpLMMBx1ctWr2D
         FCtg==
X-Gm-Message-State: ALQs6tCaJyMhE61LzMKvOD3uZKVOeH3Z0xgjp0qeHV/Kc9IeQSUvnl0D
        snUHLqQ+sv6Hg0d88Em9uH4eUQRW
X-Google-Smtp-Source: AB8JxZpbosOU7wRbkWm96EaJWn/3/83gycutdrJM88rs400N3gUprl143GFid+PgntMRG9GEe6s6ng==
X-Received: by 2002:adf:e312:: with SMTP id b18-v6mr4562005wrj.247.1524938091709;
        Sat, 28 Apr 2018 10:54:51 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abps22.neoplus.adsl.tpnet.pl. [83.8.60.22])
        by smtp.gmail.com with ESMTPSA id 90-v6sm4000411wrl.79.2018.04.28.10.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Apr 2018 10:54:50 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "peff\@peff.net" <peff@peff.net>,
        "avarab\@gmail.com" <avarab@gmail.com>
Subject: Re: [PATCH v4 01/10] ref-filter: fix outdated comment on in_commit_list
References: <20180417170001.138464-1-dstolee@microsoft.com>
        <20180425143735.240183-1-dstolee@microsoft.com>
        <20180425143735.240183-2-dstolee@microsoft.com>
Date:   Sat, 28 Apr 2018 19:54:48 +0200
In-Reply-To: <20180425143735.240183-2-dstolee@microsoft.com> (Derrick Stolee's
        message of "Wed, 25 Apr 2018 14:37:54 +0000")
Message-ID: <86d0yjjjx3.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The in_commit_list() method does not check the parents of
> the candidate for containment in the list. Fix the comment
> that incorrectly states that it does.
>
> Reported-by: Jakub Narebski <jnareb@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  ref-filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index cffd8bf3ce..aff24d93be 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1582,7 +1582,7 @@ static int in_commit_list(const struct commit_list =
*want, struct commit *c)
>  }
>=20=20
>  /*
> - * Test whether the candidate or one of its parents is contained in the =
list.
> + * Test whether the candidate is contained in the list.
>   * Do not recurse to find out, though, but return -1 if inconclusive.
>   */
>  static enum contains_result contains_test(struct commit *candidate,

All right. Always good to have comment and code match.


FYI: the contains_test() function described in this comment only checks
the candidate, and never access candidate commit parents.  All
recursion, which naturally includes checking parents, is in the
contains_tag_algo().

I guess that the code was refactored, but comment had not been changed.

--=20
Jakub Nar=C4=99bski
