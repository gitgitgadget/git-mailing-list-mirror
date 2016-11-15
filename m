Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6962021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936323AbcKOXtr (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:49:47 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34053 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935646AbcKOXto (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:49:44 -0500
Received: by mail-qk0-f175.google.com with SMTP id q130so155604825qke.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U1hTn5V5dTVgZm4/j4lZ83QknFeVOc3F/L9wv1IA2g8=;
        b=KPH7FGYP7FDCbrPcZN0P9sFCM0eFJugkG1WCmrrMQeTrMDj0VLu2gyhCRllSiIElIa
         xuP93P/eMcKM+1l6yv3YtQ/yWRU2TkyUGnyppnUlJJdpBxnfydCkBQ4V0UEd9shhn3vk
         RXliwf1zlYvJUBAVYXoxinG56kdm/IqDrNNRvlIUuAM1whP5xSj4fShf35Wnob/JfHC8
         cMJAvjLEsJ33WKAVwPa3glh8FRHYoDAP7hGBC/0l98GmUR9JOxaLhrl7J3I1jMxks7RK
         lONSL7PULwz8E3en8gZ+DlO+Tp01UhmGJUmM85AazdyEC1y6uwnsrHFNmk8eZMlkyArt
         WjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U1hTn5V5dTVgZm4/j4lZ83QknFeVOc3F/L9wv1IA2g8=;
        b=lf9QSJ4PC89qEsRXNIn8F0ICTC6I3XHxMv65wUMpotYt3Hb+NR9DKcKG8E1JVTbdaB
         8fTmGnh6s+qo9AYS+tcVJMm07a6r9tjwJF1fJR/czUo2LEvCjdQULOAs1vutpCuPMgfd
         aYwKTrWExBP+mHibIQ/qAoHl4XVG3UynL/9qTcqDbq+9STsQ17w3TBDdO4qz2VOGntOw
         ShbkVlNmATojSdapPhc7UBBzIzfa4vMHJV/HjN3/TAvT9JW2XCdviRP/SESgzLkUdc5e
         QSiPqUI+YKamwIrTCtWIltMQ/O9PGnfC30f215Ui8aJ9cfyEUOdC006xOyNQHBo0xAG1
         pnkQ==
X-Gm-Message-State: AKaTC03uYGvoAq40aCWlU1vC6Rz4GgEy6SUta0UZVGgJBl5511axdDjrHqkfm4tmg0BUPNDAqUsYxgqK91spKWQf
X-Received: by 10.55.20.164 with SMTP id 36mr89711qku.86.1479253783585; Tue,
 15 Nov 2016 15:49:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 15 Nov 2016 15:49:43 -0800 (PST)
In-Reply-To: <1478908273-190166-2-git-send-email-bmwill@google.com>
References: <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1478908273-190166-1-git-send-email-bmwill@google.com> <1478908273-190166-2-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Nov 2016 15:49:43 -0800
Message-ID: <CAGZ79kYTY3SYxn65bXr-nqosoQrBTioV8GpL7gUqdeFMmxsEZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] submodules: add helper functions to determine
 presence of submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 3:51 PM, Brandon Williams <bmwill@google.com> wrote:
> Add two helper functions to submodules.c.
> `is_submodule_initialized()` checks if a submodule has been initialized
> at a given path and `is_submodule_populated()` check if a submodule
> has been checked out at a given path.

This reminds me to write the documentation patch explaining the
concepts of submodules (specifically that overview page would state
all the possible states of submodules)

This patch looks good,
Stefan

> +
> +       if (module) {
> +               char *key = xstrfmt("submodule.%s.url", module->name);
> +               char *value = NULL;

minor nit:
In case a reroll is needed, you could replace `value` by
`not_needed` or `unused` to make it easier to follow.
Hence it also doesn't need initialization (Doh, it does
for free() to work, nevermind).
