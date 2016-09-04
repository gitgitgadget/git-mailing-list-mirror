Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B061FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 09:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753897AbcIDJ6W (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 05:58:22 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34152 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753767AbcIDJ6U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 05:58:20 -0400
Received: by mail-yw0-f180.google.com with SMTP id g192so34894500ywh.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 02:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MMKCZQNT13bz/HAbvKtWUXJOntw6soD/5EMpKLyONY8=;
        b=N6zYSkigp8WeuBIcFnz6AKVswxuTTImRTa8YjP+2HU+QiQMr+mbVEPjk+FsuTFXH5O
         5rme3aEQZ8+dBcYKxBbrZis/m9j3naDkm3IPh3n1LdhY/eVYWV6Lmr+1e8vFtb7X/ohr
         Eyg2Ss6Naf6sChFV8lO2g92mZQMlKG9t8JMt8CSQYuqFvlcQZr0t1fer2rRDFQy57MeH
         W7cZEAB3nnSnPBy2hOhj+D9SDJ/qgpwt9jrk17orlrS5vvIISFcnWd2q056UXRSj6KwC
         1t/dfdnIoLE3SHT6sDValCMpzc8qOl5qh5p43hF8tqMw6feCWcpD45q0P0WTTplPVKls
         pv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MMKCZQNT13bz/HAbvKtWUXJOntw6soD/5EMpKLyONY8=;
        b=etzsvgbtx+h9H6X2De0rpA1ocT+SQIPS3iBp3iVj3ecJ42w31RDaCISQ+7BGf4MLk0
         sN+fGcR9kkx6NkRNJk//Azxmvg9YrBu6D3z8L7BkBF1DfIugSCLMpIQcmGTrF5IV3xWF
         lPA6qBJKYRqxsCDBHtJbSrqjZFWcy92m3jjnisHc2ppcLIJfTJDfBz3bp7fSpNhPtRxS
         p5cCumhkOH0TaEZsU05AfAUwjIWU0+W6wljTehEiiuoGCHlU9ExDPGuVqjydkcNRIuvO
         eee6F6RkSr5DGDokzlCdIzHTvFvAg7YEJDAU1MQTCJDPOtcONy0tXnLglKRqzwsela7o
         CpUA==
X-Gm-Message-State: AE9vXwNzAws3Ap/qSjpxZNbZiKgFT1heHjG2yU75DkK0Ec/D3DqO4LKZK8L+E9rA3CCXAGlBR1+6o7ywMWLJbA==
X-Received: by 10.129.168.9 with SMTP id f9mr24763062ywh.258.1472983100064;
 Sun, 04 Sep 2016 02:58:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Sun, 4 Sep 2016 02:57:59 -0700 (PDT)
In-Reply-To: <20160903033120.20511-1-sbeller@google.com>
References: <20160903033120.20511-1-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 4 Sep 2016 02:57:59 -0700
Message-ID: <CA+P7+xp=s4uOvqTS0wuduE0WmxOsWo_EYT5zW0U_2gfcHT7mGg@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/2] Color moved code differently
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 2, 2016 at 8:31 PM, Stefan Beller <sbeller@google.com> wrote:
> When moving code (e.g. a function is moved to another part of the file or
> to a different file), the review process is different than reviewing new
> code. When reviewing moved code we are only interested in the diff as
> where there are differences in the moved code, e.g. namespace changes.
>
> However the inner part of these moved texts should not change.
> To aid a developer reviewing such code, we'll color pure moved stuff
> differently.
>
> A line is colored differently if that line and the surroundign 2 lines
> appear as-is in the opposite part of the diff.
>
> Example:
> http://i.imgur.com/ay84q0q.png
>

In the example, the first and last lines of duplicate copies don't get
colored differently, and that threw  me off. I feel like that was
maybe not intentional? If it was, can you explain why?

Thanks,
Jake
