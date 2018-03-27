Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EA921F404
	for <e@80x24.org>; Tue, 27 Mar 2018 22:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeC0WES (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 18:04:18 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:40328 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeC0WER (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 18:04:17 -0400
Received: by mail-lf0-f43.google.com with SMTP id e5-v6so579891lfb.7
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 15:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sgLAGu8p0dNJ0hKzZOqDtWjKelIZERCUMUk1Ku9sULs=;
        b=RyoOo9xN1ykhSQ2Cvk2wBG1sgqywMEviRVmdPu0dfJnREvRv6D6V4beEaKiTeAWoOf
         XeUhcFoo4tcSosPtHkGz+FW0OamTs8PnW+bYLHQSbk2ddpjdy3Ml1ITaiUSJCBHyCmlK
         UTLsPGKwp/OsQL9ynM8jtMMu3ekiELBLEpGEDt2V440lFrhaw7x4fpQ9QnJoQII38YS3
         mVAOlqmEG5nt90zV4E+uyVAqeJullom0ruweKxHkMsmNuy6rh489LR42b34is/AdIszf
         tkEKt1rrvvxWRvrM+A0DJYQAJNvjSf35U1J/zXkq/6WrX7ZNqqFszVTxiuHHLLcSf/gF
         T5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sgLAGu8p0dNJ0hKzZOqDtWjKelIZERCUMUk1Ku9sULs=;
        b=XEX7qC/HGgG/CXuSEjDF6YEwCr4XhtJXlVnNNsnj6ZaI9ZkUsxsxuQ8cg5GumLU+pJ
         DWXxCmMc2D2ODaKirSRlXHuzIaOEYZ6ntpJpMqBfeQpFpPR7Vh4tlCvi1AJpEUVBCTT7
         7xwcigw0I6uEDRe3RtfwLDyWHPmpmtcml3gIaUkCrlZ2KeJDNnxY63qHj+g5bv1im4Nt
         LsjYgHCUz1ooRXtJSs/AvNSjFPoOcD19sZYTYZ4vbO9T9IQJlIM1GYF+0PgoI9WVyxRQ
         vTcTPvueuynJLViulXXWzWgSyMTaGC+q35EdFqrKFb7VPPae8z3XAGBL7QR9fOGJWcOI
         Y1bQ==
X-Gm-Message-State: AElRT7HJBMPtVE9zpnDp4U+OvC7w39kRU1LzVkyKodEHp5nPRUmCwxoO
        DY4t3g6SWJZ/OsypGdvuq7SQudDdQ8SeEgnE9yh29g==
X-Google-Smtp-Source: AIpwx49DFNKRNRDd6Hl1Eq4FqZkbgxsEI5RtEbU34CKgmqSwQkbtuYpmDmzjsS73JAv+u2RJ4Gve7fzkYZYjBbfd994=
X-Received: by 10.46.85.196 with SMTP id g65mr639808lje.10.1522188255671; Tue,
 27 Mar 2018 15:04:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Tue, 27 Mar 2018 15:03:54
 -0700 (PDT)
In-Reply-To: <20180327210233.29076-2-git@jeffhostetler.com>
References: <20180327210233.29076-1-git@jeffhostetler.com> <20180327210233.29076-2-git@jeffhostetler.com>
From:   Wink Saville <wink@saville.com>
Date:   Tue, 27 Mar 2018 15:03:54 -0700
Message-ID: <CAKk8ispn6kYQUqPbMc74HfdZ6hj6BwtgytgD5guLLfauspDKuA@mail.gmail.com>
Subject: Re: [PATCH v5] json_writer: new routines to create data in JSON format
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        peff@peff.net, l.s.r@web.de,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 2:02 PM <git@jeffhostetler.com> wrote:
>
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Add a series of jw_ routines and "struct json_writer" structure to compose
> JSON data.  The resulting string data can then be output by commands wanting
> to support a JSON output format.

<snip>

>
>
>
>  void jw_object_intmax(struct json_writer *jw, const char *key, intmax_t value)
> +{
> +       object_common(jw, key);
> +       strbuf_addf(&jw->json, "%"PRIdMAX, (intmax_t)value);

Cast is not necessary.

> +}
> +

<snip>

>
> +void jw_array_intmax(struct json_writer *jw, intmax_t value)
> +{
> +       array_common(jw);
> +       strbuf_addf(&jw->json, "%"PRIdMAX, (intmax_t)value);

Cast is not necessary

>
> +}
> +

<snip>

-- Wink
