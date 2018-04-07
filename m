Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31121F404
	for <e@80x24.org>; Sat,  7 Apr 2018 00:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751802AbeDGAmp (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 20:42:45 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46266 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbeDGAmp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 20:42:45 -0400
Received: by mail-pl0-f68.google.com with SMTP id 59-v6so1605224plc.13
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 17:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9gCN4/FNsj64oa3yXeHXUr677LMLByFtwMIZQRyWFZw=;
        b=nRvKQYSWRDnbxtu+pfKmDXawl3ODANm7r10lvDWkz1iQuk1xJ5fbDj7+7roJjMv1jf
         CToiNymW/SjHltKvuztcfpZun9wdafCFIM/sFZ0Th9IgOeSc9jN1AzXaw+f5UkhDf0za
         bYxJmeX5J/xKvYpox1vHtRt2xCKSyIi+SZMkifWrwrekxR07RpJXHn+k+S9l+sMC2iNv
         zQGFfmZ7LAs7plRsWvM+bbvRPPzc+ENslMgoPwIZ7v73lSg/B2QkLSlg82Id2wa2bPT/
         bwwthMY4Gzf79mGGo01mBzwajdsv7SMaWlTm0FDlLeYRSvfKKK5sqlxSfMLNDIxebvYe
         F7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9gCN4/FNsj64oa3yXeHXUr677LMLByFtwMIZQRyWFZw=;
        b=mbv+bmVqZmfC8hRXTr4E0y02f9AX3YXlmgvGYUzd7KrxIZOInGjsKoqsg9yM9dImAN
         OZqMcKO6C3grsxzzA7WFk0wLQ4pE0HJLyusiMwzp9/JAwbyeMn03gOd5IF/692c3ho9p
         D/tfCEzuuMQ76JsUapUQUB8kk0Dd7y0WsjLdwpiOQoQ37Xy4H03fxPeg+dKB2VvbND8D
         0kbzk9aM2NH9gEboeYw2rDA/vENBRwMyOvSkZNZAdW4iXRdPJNsjeSl7wkUkTcOOLmZT
         boFRVbvPax/0GUFGFV/RbPVO5iSHEhwpLOgUdbxmDYfLeFgKUbdYwbnREGVFpY6SP3vW
         HkGw==
X-Gm-Message-State: AElRT7EVmsQK3E4r0oLKY27aEJTxFqLxFhmedQ5/gP7EMEmrsExKYpE8
        chXQCviTIh61pEb12ypVxREqpQ==
X-Google-Smtp-Source: AIpwx4/PgWOOHtHPCtsPybJHMH+iBcTaoM7xMtz+u+VyNNL+OBjNjnal6HQCdYR3K3K9EwE65SsIpA==
X-Received: by 2002:a17:902:b117:: with SMTP id q23-v6mr29537216plr.193.1523061764440;
        Fri, 06 Apr 2018 17:42:44 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:ec81:e7e6:a4ca:eef6])
        by smtp.gmail.com with ESMTPSA id b9sm20934639pff.13.2018.04.06.17.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Apr 2018 17:42:43 -0700 (PDT)
Date:   Fri, 6 Apr 2018 17:42:41 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] builtin/config: introduce `color` type specifier
Message-ID: <20180407004241.GB78042@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <cover.1522996150.git.me@ttaylorr.com>
 <20180406063017.GD662@syl.local>
 <CAPig+cT2T8r9mefv-7GEU4khEDVrthK45X5kbVXU5c-MXU39dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cT2T8r9mefv-7GEU4khEDVrthK45X5kbVXU5c-MXU39dg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 06, 2018 at 03:29:48AM -0400, Eric Sunshine wrote:
> On Fri, Apr 6, 2018 at 2:30 AM, Taylor Blau <me@ttaylorr.com> wrote:
> > [...]
> > For consistency, let's introduce `--type=color` and encourage its use
> > with `--default` together over `--get-color` alone.
>
> A couple minor subjective comments below... neither worth a re-roll.
>
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> > diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> > @@ -180,6 +180,10 @@ Valid `<type>`'s include:
> > +- 'color': When writing to a caller, canonicalize by converting to an ANSI color
> > +  escape sequence. When writing to the configuration file, a sanity-check is
> > +  performed to ensure that the given value is canonicalize-able as an ANSI
> > +  color, but it is written as-is.
>
> "When writing to a caller" is a somewhat confusing way to say "When
> getting a value".
>
> Likewise, "When writing to the configuration file" could be stated
> more concisely as "When setting a value".

Thanks, I think that these are much clearer, especially when used
together. I have updated this in my local copy, so it will be picked up
when I send the next re-roll.

> >  --bool::
> > @@ -231,6 +235,9 @@ Valid `<type>`'s include:
> >         output it as the ANSI color escape sequence to the standard
> >         output.  The optional `default` parameter is used instead, if
> >         there is no color configured for `name`.
> > ++
> > +It is preferred to use `--type=color`, or `--type=color [--default=<default>]`
> > +instead of `--get-color`.
>
> Repetitious. More conscisely:
>
>     It is preferred to use `--type=color [--default=<value>]`
>     instead of `--get-color`.
>
> Or, even:
>
>     `--type=color [--default=<value>]` is preferred over `--get-color`.

Much clearer; I think that I prefer the second one. I have rolled this
into my local changes as above.


Thanks,
Taylor
