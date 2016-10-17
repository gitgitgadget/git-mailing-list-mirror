Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 996511F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 23:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755069AbcJQXUJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 19:20:09 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34795 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754921AbcJQXUH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 19:20:07 -0400
Received: by mail-qk0-f176.google.com with SMTP id f128so252027617qkb.1
        for <git@vger.kernel.org>; Mon, 17 Oct 2016 16:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FoSQKhttALQX8ePdkuBsrrGTfBU6zHa1u5ph+biIGsg=;
        b=hk0Bxg12E+YCqpOneisCVwNCqrs7pP3J7MALMnCpPZNStVwbzlFAeSaHCyUfGzG/lv
         yonA9u2MI0gGndBPCdf+pScPTjben0Bkw+9vBd+d41/Gt0OBtvUqof5ez+EgJN8D7Ove
         Ujlbsi2K4SlihmOye87/ONPF8KCpqUa6DhYVL7B+9z8pXNrk4TiEqEVqwkv7NemmG4yL
         DOa5YDZSPD1mI5+2Lt/rMfn5JxtTDnsP50Iv35iGV1czS7u2P3xiYP1ChfRPG3KMBlh8
         6eqRwn6Jp1xdGGuuIrp2Svs2lS4q1+svrSAxDRRlCYjxB/dsOJtXjVOy0CTY7046YyhE
         1JJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FoSQKhttALQX8ePdkuBsrrGTfBU6zHa1u5ph+biIGsg=;
        b=RnKDzeFt6+2Xx2Z22QkZtCHUTh5SXAsBZnvV6D6hAH1U0KUs+FrHefb4ZdpoWKeZnq
         zdi0RUkZ2srqnK7o9wa/p0yD62x7Yt5BdQUdvL3slyCc6AsJBtTLiB0NYY+OH8iwabSl
         eT0MM3cbjCwxtk/cAlfo0/CZme07dlHXrYedU9Vlw7YUtpFeJeTNowKea+Mc5ImLqLD1
         4TnmU2of36EC+0Pt4S9wMqvgi+FZ6G0b32NboqrtUID5edXjNCMLtEmXDr0RAe40Ja7p
         Wfxyc4KomKxpf7PWTEyYv2wL1TeULLbjCU2f9nIkDUi2HEMgs5pjPLkvRLf6qLr78hhO
         NhNw==
X-Gm-Message-State: AA6/9RnVjeBvetHRMKGS6VzI8U0LqCSkJjeHNXk/DxBMVUUqKhpGSpMfKdQ7POk1h/XVfbMNpzSal7FWaPiG+SgO
X-Received: by 10.55.184.2 with SMTP id i2mr29775567qkf.47.1476746406126; Mon,
 17 Oct 2016 16:20:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 17 Oct 2016 16:20:05 -0700 (PDT)
In-Reply-To: <2357e9e6418fc5b30a60efe16dd8f72bf7544fef.1476466609.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
 <cover.1476466609.git.jonathantanmy@google.com> <2357e9e6418fc5b30a60efe16dd8f72bf7544fef.1476466609.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 17 Oct 2016 16:20:05 -0700
Message-ID: <CAGZ79kYuaHvO-aXeCocDseTLe13g=PesKxQgOrcOREtM1CsWcg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] trailer: make args have their own struct
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2016 at 10:38 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Improve type safety by making arguments (whether from configuration or
> from the command line) have their own "struct arg_item" type, separate
> from the "struct trailer_item" type used to represent the trailers in
> the buffer being manipulated.
>
> This change also prepares "struct trailer_item" to be further
> differentiated from "struct arg_item" in future patches.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  trailer.c | 135 +++++++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 85 insertions(+), 50 deletions(-)
>
> diff --git a/trailer.c b/trailer.c
> index 54cc930..a9ed3f8 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -29,6 +29,12 @@ struct trailer_item {
>         struct list_head list;
>         char *token;
>         char *value;
> +};
> +
> +struct arg_item {
> +       struct list_head list;
> +       char *token;
> +       char *value;
>         struct conf_info conf;
>  };

(Unrelated side note:) When first seeing this diff, I assumed the diff
heuristic is going wild, because it doesn't add a full struct.
But on a second closer look, I realize this is the only correct diff,
because we do not account for moved lines from one struct to the
other.


>  static void add_arg_to_input_list(struct trailer_item *on_tok,
> -                                 struct trailer_item *arg_tok)
> +                                 struct arg_item *arg_tok)
>  {
> -       if (after_or_end(arg_tok->conf.where))
> -               list_add(&arg_tok->list, &on_tok->list);
> +       int aoe = after_or_end(arg_tok->conf.where);
> +       struct trailer_item *to_add = trailer_from_arg(arg_tok);
> +       if (aoe)

The use of an extra variable here is more readable than my
imagined version of inlining to_add into the list_add calls
just to save aoe.

Looks good to me.

Stefan
