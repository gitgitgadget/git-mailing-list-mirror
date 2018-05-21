Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53D6E1F51C
	for <e@80x24.org>; Mon, 21 May 2018 19:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751184AbeEUTAe (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 15:00:34 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44956 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbeEUTAd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 15:00:33 -0400
Received: by mail-yb0-f196.google.com with SMTP id s8-v6so4197105ybp.11
        for <git@vger.kernel.org>; Mon, 21 May 2018 12:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZWaGELPWjVSyCzAmdTikB6HvWNWEOif9R4w7/mtgX0E=;
        b=sy6YYMTYtoJD6m2Q0Nc5LLx/UfU4z67Be/l1pu0uwlemgy9d42edr6o1wj9WmtWAOP
         53XPpBHQCQdQRQGj5/xTZOiX1VVGVFLK8AAXVKFjImCdnQD8z6jl//JiPFXmBxCwK1Jp
         Pe7HLzU4mQXyj2ab4P99umvMZhFnnlw4sG953waqhfky/aYnq/WVF2PE2X/DA0+0KyCp
         TLy7nfsRMM5u2HrbPwO8myCBhgT6pgTrrznwNtWBxGZSOxzrBK2YzoPQcP0/ecwvgqHL
         ZbiP0yhihekbI9tn+STWexg3GRtOzsgZV0migTh/22Xn3EzvNGEloUAkJFk+fXyHkhrN
         emZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZWaGELPWjVSyCzAmdTikB6HvWNWEOif9R4w7/mtgX0E=;
        b=argHbYO34HUFlq5GgFj0RAnjN182n9yWL7MxhvyamIPzqhFQTHALxPfo9D498P9lTq
         wtQWeDIJdkhQn+WpDmpTJuhTZ5sce+BBrJvkNFKb0jabjOfXqaxiIv/jas/lvbVJpWs/
         4hOIHGujpj3WmsgEIEQlSFGWRO2MBv/I65fhie7PsY5Tp6vPEAhyDzEYVhGMADef0ZOV
         K9znabFl3burPl6FwkBCsIotQ974j/THA+wJ4iMR8CuLxsYLCWRDVPJH1lu7zPrKtfFo
         M2/00qi7K0eFNoVFeav1nBMPSksOjjUlt9zKAarFleKEyE303MVsrCmMZWdlLtqUXDq4
         7DBQ==
X-Gm-Message-State: ALKqPwe22qqWkUkQOoowbUjwxkj8NvGZGleGydbr9y29t7QuxUkQYNGW
        NChnuy+tb2XvPQ1aM1ygp1L5NfM0ETaKlMCE8ZOen0VQ
X-Google-Smtp-Source: AB8JxZoQYTnwfSYAX5OZ1alhxvh+EnaOFHuwoYJRbjCjtV5rzlxZYPov7tcs9toOEs4wNpExZ6XJhggrMW1xdWXFFrA=
X-Received: by 2002:a25:6cc2:: with SMTP id h185-v6mr12264355ybc.307.1526929232583;
 Mon, 21 May 2018 12:00:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Mon, 21 May 2018 12:00:31 -0700 (PDT)
In-Reply-To: <20180520211210.1248-2-t.gummerer@gmail.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com> <20180520211210.1248-2-t.gummerer@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 May 2018 12:00:31 -0700
Message-ID: <CAGZ79kZnMnG_88YC8bfopfw8o9qwTggC01HPSPddL+LU-QVjFQ@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/7] rerere: unify error message when read_cache fails
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 20, 2018 at 2:12 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> We have multiple different variants of the error message we show to
> the user if 'read_cache' fails.  The "Could not read index" variant we
> are using in 'rerere.c' is currently not used anywhere in translated
> form.
>
> As a subsequent commit will mark all output that comes from 'rerere.c'
> for translation, make the life of the translators a little bit easier
> by using a string that is used elsewhere, and marked for translation
> there, and thus most likely already translated.
>
> "index file corrupt" seems to be the most common error message we show
> when 'read_cache' fails, so use that here as well.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>
> "index file corrupt" is also what Stefan chose for his series unifying
> these error messages (and 'die'ing, which I'm not sure is the right
> thing to do here as also mentioned in my reply to [1]).  I'm happy to
> drop this if we decide to go with that series.

Acked-by: <me>

I'd happily have this patch instead of the one in my series.

I was about to ask for translation, but the commit message hints
at a follow up patch marking this for translation, so I'll read on.

Stefan
