Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14C00209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 19:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbdFFTFd (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 15:05:33 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33659 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbdFFTFc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 15:05:32 -0400
Received: by mail-pf0-f176.google.com with SMTP id 83so43340822pfr.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 12:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=31R0U0xYgeNojPfAOleeLv37e5bQNW+EiDaO3GoxPLc=;
        b=SDVnPv6BNigfueBTyzRmQLVFGlCqwS8ZsU9A0h3aqUrmPZh9YNxvQoRFaQcRXYU000
         CvYLl4vvsSS5QCt4bh5w5xwaj4Dl/okjQf9IgfZjGXYF2bFRB3tM1sWJQWNrP4PNFlLl
         kmT1oqteWuO4L99AqV97F+25GMhfNVVFXAP6rU9JW0bnF111s5jqhSVayA60JvGNpXXT
         s0Z8+TYFQLkegKMJUu6xc1u8XH11ESZuOi+MXFzK6K7npo6ZQoOkMjiVCc9P84Zpbs81
         vvBgFiYUkXaM8VTRIYds6bXBuxxISs0mUVDrEUHbfjm4F9KySOOa97xxqo0ParZQM0dF
         GzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=31R0U0xYgeNojPfAOleeLv37e5bQNW+EiDaO3GoxPLc=;
        b=skSmx97nhSWlGtwpZXa99saUniiPWhKcbrp+hFjkcuIMrKSMaK9eArm/DkWPPtPD1b
         IYO/8awDBvgA8XHkZsr4QhlK8/09R5xTkAi4V76CzujyU64GNSN28co/1qOYjl2mTmGT
         oM0wt1ZhCj7jNj+rhAhlOLeXJbeJtDZi/8aqF4Qt+PzrCPX1ZatoXwo6yrNMt0SS8Y8X
         nDhAUqKBMqk1BaTduS2+vwOoj/Ng4JWxh//NMIeY58VTDKbRSFHySgc8BVgIGQERhVmK
         lbXuVDliiG0SgbK+gJ9vfjXHcbvwssGTdhPlz2+7Rw/ygC7TaFuDUn0ts5gADobjh0tx
         /JPA==
X-Gm-Message-State: AODbwcB4/bx5xg1NBOspDHtQtSmshW+Xa3SfgjVqd/pzPeYL7/kfCAhD
        iG5vhXwXCuNimFAAiteDLSw95rAuYeZq
X-Received: by 10.84.224.140 with SMTP id s12mr23003802plj.66.1496775931808;
 Tue, 06 Jun 2017 12:05:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 6 Jun 2017 12:05:31 -0700 (PDT)
In-Reply-To: <20170606190111.xm4nzvjhbpsw3qbg@sigill.intra.peff.net>
References: <20170606124323.GD25777@dinwoodie.org> <20170606151231.25172-1-avarab@gmail.com>
 <CAGZ79kaaRsUBAxRKLPxjuk=oRrw2zBdoHWd9iNDmTbY9MpqN-w@mail.gmail.com>
 <CACBZZX485+W99mRspDTf09LjP-C26PaAi+vNSBkW_aVyXAsQJg@mail.gmail.com> <20170606190111.xm4nzvjhbpsw3qbg@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Jun 2017 12:05:31 -0700
Message-ID: <CAGZ79kZ_SiiRzzE0jumsAQcmvb3LAEs9Uz5mQ5AhfOvXRniRag@mail.gmail.com>
Subject: Re: [PATCH] sha1dc: ignore indent-with-non-tab whitespace violations
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Michael Kebe <michael.kebe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: sha1dc: ignore indent-with-non-tab whitespace violations
>
> The upstream sha1dc code indents some lines with spaces.
> While this doesn't match Git's coding guidelines, it's better
> to leave this imported code untouched than to try to make it
> match our style. However, we can use .gitattributes to tell
> "diff --check" and "git am" not to bother us about it.
>
> Signed-off-by: Jeff King <peff@peff.net>

Reviewed-by: Stefan Beller <sbeller@google.com>

> ---
>  sha1dc/.gitattributes | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 sha1dc/.gitattributes
>
> diff --git a/sha1dc/.gitattributes b/sha1dc/.gitattributes
> new file mode 100644
> index 000000000..da53f4054
> --- /dev/null
> +++ b/sha1dc/.gitattributes
> @@ -0,0 +1 @@
> +* whitespace=-indent-with-non-tab
> --
> 2.13.1.664.g1b5a21ec3
>
