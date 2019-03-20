Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF6E620305
	for <e@80x24.org>; Wed, 20 Mar 2019 12:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfCTMWf (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 08:22:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40578 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfCTMWf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 08:22:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so1818746pfc.7
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 05:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Hg7gfEyexZGOXsPPwxZzTZBE8YQrHj8fibUbnsU8sU=;
        b=FOgnn4FI4Inlje+FqAhoOywzezvR0tAzIzIvQ1hQPCKeWOoTCNGRTaRrC3VAw4TOvM
         YKA63Wr2FXQZw2Dsh+IdBbaSkEvyt0W6pJq2Cure4wuLd2rnV8ESOtRA+DCP0UTvP7CQ
         up3ILSrcLIQxEy7YjnUM3cFL7wxpDbDuXg/si3dUKgidFJiHfFAboezxynHfQvAx85g7
         GsOT3zSyFWqp96othzDE3SyQYyyIB47m4Di8hDqu8fdFS6b3NPNcEr42k47MQWAJhU3A
         wsYzRIQ33rZKkhyjjfiaCdsO77WEoDQho9dloBB54b8dpOAJw6+7S5lweRvJqOycLNRK
         bdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Hg7gfEyexZGOXsPPwxZzTZBE8YQrHj8fibUbnsU8sU=;
        b=ZtLP12DuJEApkiL7TuJHyyWN1QVDnqqGTiI2keYSviV/TBYo1QakoDIUfUl5+XLU+U
         DhD2xG8bbgQ2WqiIlNShnZ8rixiTlcJ6Ibtndhrpw4ggRvnPhxV0G6oJ9pcL+TtOGimk
         JssFCb0lg8ysZuZIRYM3ZmNgomGFPykwHaqThT3ET5RZnpMBqOFFv8MJp31Zt1QGFkug
         fsNxqu707xKPVwKZJbj2CAQqe9JT27bKNJWzYVbhgrDpaGBdKR7TgC7rdtbZducidUVN
         cgE/83bes91tnbtIzYIsVKjwbDHgfH0T/SinjR94AiCPv6xa9Vw06VNn2LLbZi04p9cJ
         kEAA==
X-Gm-Message-State: APjAAAX+CM5H0XWQ6lrbMZdJXs9Qm2v0C/D25GP5MeNsL3ihh10zUP7E
        CpwWUpmNBvYAcWioq7607PDptDPwsgKFMhC7mPYkOG2r
X-Google-Smtp-Source: APXvYqx627dDms8kZQ2FkIMAP2vyl+LomFHKfmnwRDlzMuBuGJEWiSmspxYK0cpwsWn1tpHOa1H5Bq9za0KGz+0LFzI=
X-Received: by 2002:a63:f80f:: with SMTP id n15mr7556241pgh.283.1553084554553;
 Wed, 20 Mar 2019 05:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190320081258.GA5621@sigill.intra.peff.net> <20190320081650.GM10403@sigill.intra.peff.net>
In-Reply-To: <20190320081650.GM10403@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 20 Mar 2019 13:22:22 +0100
Message-ID: <CAN0heSrubOaXRbg=NBi0rCuzthUcOEU3HmUKGg+=t+N0CCJcbA@mail.gmail.com>
Subject: Re: [PATCH 13/13] parse_opt_ref_sorting: always use with NONEG flag
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Mar 2019 at 09:17, Jeff King <peff@peff.net> wrote:
>   - since this was cut-and-pasted to four different spots, let's define
>     a single OPT_REF_SORT() macro that we can use everywhere

Indeed, all four are identical. And FWIW I failed to find a fifth caller
anywhere (I looked for "OPT_CALLBACK.*sort").

> -               OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
> -                            N_("field name to sort on"), &parse_opt_ref_sorting),
> +               OPT_REF_SORT(sorting_tail),

> +#define OPT_REF_SORT(var) \
> +       OPT_CALLBACK_F(0, "sort", (var), \
> +                      N_("key"), N_("field name to sort"), \
> +                      PARSE_OPT_NONEG, parse_opt_ref_sorting)

This one is not identical though. ;-) You drop the "on". I trust you to
know which of these is (more) correct, but I was a bit surprised to see
"on" disappear without any mention. Mistake, or intended?

Other than that surprise ending, the whole series was a nice read.

Martin
