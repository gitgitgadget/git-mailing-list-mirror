Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 602531F404
	for <e@80x24.org>; Thu,  5 Apr 2018 23:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeDEXhq (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 19:37:46 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36394 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDEXhp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 19:37:45 -0400
Received: by mail-wm0-f47.google.com with SMTP id x82so11738052wmg.1
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 16:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pXehEm6fxlQ9bbK7B708MzCLn/dmVYcPoo8dq/cXiko=;
        b=ij1IQKJlcEcQCUoxhjbvbxclDaBN1VVhOuIQ4OBpjL+rjv87nAShSdvQZExr/6ZHB0
         yD69Nc6O699E8Q4Df5aUsbNFn1wPccZojLTf9SpL0dpQnJueW9URHt25fU9N6OgDrUZg
         ZJffmIU5mjA3tvXLmQlavibSDYGKfVH03CXJg8hSDTW10cIF6c/xTfH52lR4hF1RRaUj
         zOonrkEbSnmdBgR6RCjO6jsuu52K/C10D/+0G2ES/ZwxuVpbewoRHVOWhawqkzTTBlma
         q+j6su7RQyNw8tVTFe/GGGNOHOEee4GJREvOkkKH2GeMa+0wscpp8IAfLa0f1BLmvjKz
         JsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pXehEm6fxlQ9bbK7B708MzCLn/dmVYcPoo8dq/cXiko=;
        b=DWJrDq8448v3ZwRf/QnR06XS1Z+J8b5jVWCp6q0QnJNeZsFHi02WsMZq3JR15VwrV6
         hlVZODkoQITl5WkQD/052VwN3KmReF5wIwzSTIAk50ptJVjFRMyS8vVJ348b0tj/h/+p
         DJySKlfuLwB/bEKlBCKjVo7SzquPORoidnEwJKjrP+qiYk15R/aDkgG2Anf4PtyiGYvY
         Zo4+E62vgX19ofejcBZwQ09Sa+ocH8VuxOLr7laEORZZW9tIEXdPOdxVg3k33iaxVnjm
         U8EwhkNfzyLm0/nsTib0Xfz7FzxhFLFZ1k8MmZDgQwlTFlPIGBcYo0cN31B5xdamFajN
         twxQ==
X-Gm-Message-State: ALQs6tA3kOCDEsUy5jceXaFbhRm2e1t8urSsk7UugElbshXidoDPBQt2
        3t9VkaQVfp1KBhOkaq9VCy8/9/wrZ6GfLVo78pY=
X-Google-Smtp-Source: AIpwx49ptRHiwdXsQfLikUdkKNoqFWvU75gwxHU1CLTAb+1r9A0W2M6nmDTYqQD28WKAXg9m7ptgR16HyDB2eghLQQ0=
X-Received: by 10.80.153.9 with SMTP id k9mr4614681edb.303.1522971464069; Thu,
 05 Apr 2018 16:37:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.201.196 with HTTP; Thu, 5 Apr 2018 16:37:23 -0700 (PDT)
In-Reply-To: <b2771f9d8e441b6f902924a3b4f037b3874e4191.1522968472.git.johannes.schindelin@gmx.de>
References: <cover.1518783709.git.johannes.schindelin@gmx.de>
 <cover.1522968472.git.johannes.schindelin@gmx.de> <b2771f9d8e441b6f902924a3b4f037b3874e4191.1522968472.git.johannes.schindelin@gmx.de>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 5 Apr 2018 16:37:23 -0700
Message-ID: <CA+P7+xp6fDbabGVKDsRFhixkWRKTuUo_A3UqbQscsBbKiOJmmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] push: colorize errors
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git mailing list <git@vger.kernel.org>,
        Ryan Dammrose <ryandammrose@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 3:48 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> From: Ryan Dammrose <ryandammrose@gmail.com>
>
> This is an attempt to resolve an issue I experience with people that are
> new to Git -- especially colleagues in a team setting -- where they miss
> that their push to a remote location failed because the failure and
> success both return a block of white text.
>
> An example is if I push something to a remote repository and then a
> colleague attempts to push to the same remote repository and the push
> fails because it requires them to pull first, but they don't notice
> because a success and failure both return a block of white text. They
> then continue about their business, thinking it has been successfully
> pushed.
>
> This patch colorizes the errors and hints (in red and yellow,
> respectively) so whenever there is a failure when pushing to a remote
> repository that fails, it is more noticeable.
>
> [jes: fixed a couple bugs, added the color.{advice,push,transport}
> settings, refactored to use want_color_stderr().]
>
> Signed-off-by: Ryan Dammrose ryandammrose@gmail.com
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> squash! push: colorize errors
>
> Stop talking about localized errors

Guessing you intended to remove this part after squashing?

Didn't see anything else to comment on in the actual code.

Thanks,
Jake
