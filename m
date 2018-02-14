Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAC731F404
	for <e@80x24.org>; Wed, 14 Feb 2018 17:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161564AbeBNR6l (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 12:58:41 -0500
Received: from mail-yw0-f177.google.com ([209.85.161.177]:44673 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161247AbeBNR6k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 12:58:40 -0500
Received: by mail-yw0-f177.google.com with SMTP id y65so4151453ywg.11
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 09:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W5P3pk7VDhDG836RriGki9Gpgs0rtQQvj73lQbaBxZE=;
        b=N0QCSg7Vq0BPk5f2S9JBw6XdNI2fqlsj1ebIqFZNYucUi1Ifpv19w+yxWD0eU+LrNf
         4/vqUvVi9FDz0RtU1GY5YQuvTTZNK+pHD95XV5h6M5IKE1xgdQMwOkPTKcrw9aUZu6i1
         Kd53t+hOuYGI2Hv2q5VsrRXNgTwJV9+D8IzeJu/xWlPY/jnBBLEzgLJsUiKHhGZ7pkk6
         WpqyaTdMje28pXnOAYEKRvsyyLVUSoC1h8RLIajZrk08c5Yu/D6ryAiogx5rlTrpOtQG
         9xUaJd4LPLom9Phfdf4uXEL4iEqL6riLLF4Hnhy07NQPgBytWk4V9eIspoW0pUmHIaiE
         beZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W5P3pk7VDhDG836RriGki9Gpgs0rtQQvj73lQbaBxZE=;
        b=iuC+0vSWmoJNS0Di8W0I2LqhLds40Nw4JdsksajaOYgIxKTsTo36XEYVALlcuIlZfk
         gTFpnfpGGJOeB2AcjujfXngEpCCFIn1/790P9JhPFosqj0wOTSL0AuO7CfTpQHW6FMdq
         XSCtQBFC5BuK3If/XO1eSDHEXB6tvAsiMobY6AdwRC7QDGaSUdVaLKX0zrtlNlj8xeDD
         iu2TmYmjlPf/MxwEyfhZcn+cjggeF3yLxGYv8arQKokdDW4USNqrok+z+eqcPSpKJXei
         hIxqLtsLMx4M+pMCUFy/DpwAf+8fwlTU7eAzZJzxiwGDQPXqFu0zkorw7eCHGRUQPTZ7
         85fg==
X-Gm-Message-State: APf1xPAZ13MWn26Ei++bT1jQosfrcJi3+QRyhFElVt8fFTs2RhFXTU85
        ryPzfNZJXy1iqlfr8PJSBgzjU38zb0fWshPDslod2A==
X-Google-Smtp-Source: AH8x225lcTtCUoAWx80mPd1+IQKXuw1Jx1ucfI9ZQ3OHQlwYs9QfBR4i9J6aoKpqiSx/UG2scmsxG2k7ATwQT2avgB4=
X-Received: by 10.37.180.65 with SMTP id c1mr35948ybg.438.1518631119842; Wed,
 14 Feb 2018 09:58:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 14 Feb 2018 09:58:39
 -0800 (PST)
In-Reply-To: <CAPig+cQwzSVkapkRxFOn7DSVJ8hCXnuCciPQdFaZnFEq=VKCuA@mail.gmail.com>
References: <CAPig+cRUr=dJgaG2-aRArswQXXZEExQah4k17+HkiB+sZHORYQ@mail.gmail.com>
 <20180213014130.190374-1-sbeller@google.com> <CAPig+cSQecUr5+QkSWNHbzUeViTA7KjLdcjLZmfhK5hT-fuKfA@mail.gmail.com>
 <CAPig+cQwzSVkapkRxFOn7DSVJ8hCXnuCciPQdFaZnFEq=VKCuA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Feb 2018 09:58:39 -0800
Message-ID: <CAGZ79kZRJcEH8XGXSqWRZn7GHr6w-ep7V=WK9SytAFNro=d5PQ@mail.gmail.com>
Subject: Re: [PATCH] color.h: document and modernize header
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 13, 2018 at 11:23 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Feb 12, 2018 at 10:55 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Mon, Feb 12, 2018 at 8:41 PM, Stefan Beller <sbeller@google.com> wrote:
>>> + * Output the formatted string in the specified color (and then reset to normal
>>> + * color so subsequent output is uncolored). Omits the color encapsulation if
>>> + * `color` is NULL. The `color_fprintf_ln` prints a new line after resetting
>>> + * the color.  BUG: The `color_print_strbuf` prints the given pre-formatted
>>> + * strbuf instead, up to its first NUL character.
>>
>> "`color_print_strbuf` prints the given pre-formatted strbuf (BUG: but
>> only up to the first NUL character)."
>>
>> Probably not worth a re-roll is Junio can amend it locally.
>
> By the way, thanks for the patience in the face of the nit-picking
> this patch has undergone.

In retrospect it is clear why we have so much nitpicking here
as it adds documentation to a part of git that is rather non-essential. ;-)

Thanks for bearing with my inability to write perfect code on the first try.
