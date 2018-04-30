Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57EF4215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 15:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754755AbeD3PyM (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 11:54:12 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:38447 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754744AbeD3PyG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 11:54:06 -0400
Received: by mail-ot0-f182.google.com with SMTP id j27-v6so9981818ota.5
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y0W58dwbCYzNAWWfS71sv4WNGrxHOhm1WVEtQVQiY3o=;
        b=qxWNtlFl6noCBOBVup+apNcUEvTHt3YtZcT8RDOtKLdsF2zt0mW20YKa4HnQd1rzc8
         VKtfHKV+Hn9F0ki2/5ujeQQ2sKrlfWQNBbtSyu+GVbWiGxf9fOOzeFO6bKl0vTuwbkln
         yPVK3Brytf6gAMhzGKC8zLEYbpmm4zpk3WVhu3Lb10uDIUCbu0swwMnXW0VBDkMcVUYg
         iAQs2YpEssUzKKpplie5UwBQpSA5+ZvAxQ8qzdBF7wbdE2JsDOULnc8eIm3cRlkLZdH1
         F4YZzvOAw8dKmzUt93/j4ubZEIC+0G66pQ+aifzBu1OIQaOkNiN6GAWoUtkg7P4CPPrp
         R3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y0W58dwbCYzNAWWfS71sv4WNGrxHOhm1WVEtQVQiY3o=;
        b=qBtrzVYaky4u5yIqpyEatUZsA7kYUV4tlwnR3jhT8zkUAvcOfnikmulyoBliAHvepi
         WJvTY1dIqdxnQnn+h/iyC17c6FAWX36ufc3k66I7c8N20fUNVY8unMH/zi0kRc7vI6N0
         JeyaEYEOhYK1w7DW6xYh3B6bUA85VBJdMyLRKhHhhzj+5AfSjDfoUlZN+0K0jsIsnSw5
         VQD2oi2ylvAKU0niTqfJsi7LXG9PdZAkBGjtPLloAkz52+A7iqwM++vVxiGFfR+Huz8K
         lSgTwA+qbOIzTc9E0AcyZik3+es7dB2+iVuQq5bna5wcs0WZvdwBXB1H4CITBPBicTAG
         chDQ==
X-Gm-Message-State: ALQs6tDFZ3NcJXNPvoMqHoEQ0XeTStglDo2yGo7EKDgISf/GQvZ6QehN
        xUk2vRSoOhCHGHWzopvAN5i31QJ54Reh6WjEG0o=
X-Google-Smtp-Source: AB8JxZoPC6zZfx0I1QWcAAx7O3eIeP84C01rNXU92R6WfhEfe0lbhxwY1im+k+y8O5/guxcQ4YxcLVPZcOjNViGDsEM=
X-Received: by 2002:a9d:2995:: with SMTP id n21-v6mr9273594otb.152.1525103645695;
 Mon, 30 Apr 2018 08:54:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Mon, 30 Apr 2018 08:53:34 -0700 (PDT)
In-Reply-To: <20180429181844.21325-1-pclouds@gmail.com>
References: <20180421165414.30051-1-pclouds@gmail.com> <20180429181844.21325-1-pclouds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 30 Apr 2018 17:53:34 +0200
Message-ID: <CACsJy8A5O2qPHPNTCWWcFb6FJx3XAwfmaSWSdg7658JtDNV4rA@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] Keep all info in command-list.txt in git binary
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is probably scope creep for this series, but do you guys think we
should do the same for config variables completion? We currently
maintain a giant list at the end of _git_config(). Extracting the list
from Documentation/config.txt to keep it in a C array does not look
super hard. There will be some special handling for advice.* or
color.<slot>... but overall I still think it's a net gain.

Listing all recognizable config variables from "git config" (or "git
help") would be lovely, but I don't think it helps unless we could
print a short summary line each variable, but this info is not
available anywhere.
--
Duy
