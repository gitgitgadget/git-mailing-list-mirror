Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14D341F461
	for <e@80x24.org>; Fri, 21 Jun 2019 08:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfFUIiN (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 04:38:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36385 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfFUIiN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 04:38:13 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so889586ioh.3
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i8lmLdICNtGqybTGSBQpuI4FTZbPGRAReT2FkACitbI=;
        b=mUO6io2cZTPDi8u8CCD+X8DBwe87gwo+6Byr3YbX6shoXP8rBChum9WIjQKbIlZYqS
         Fw1jyJNnPTKjx0pdZeOM7KXqbmMzyDAfI8URkPrVuMnRqy+ScFbzOis6oTXwTj2bcqMO
         r2QPfh2AqzU232evPA+uWUWI9vMMwuLwMvVMTjIUCG741UifRgaRJXwanR9gjby5gymu
         CQXH0WPwV5f7dAGxYZvdo2urzzcB+FUcwUz3L8NZXbd5aFfQB+MGjaVdpG5PuzY4QCjI
         mrg4Qp83+7/fIfkGMiy1eB4WhrXzGu4My5SxgFskw3ZcvcbhMhrWwPNGemAV3+2gnSFI
         qrwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i8lmLdICNtGqybTGSBQpuI4FTZbPGRAReT2FkACitbI=;
        b=hOlV8u3bRXJMT3HxwQRtQbZAc2GJrI70cVzSS/ORLLrszuM2NAxD5Tg98x075H2znA
         TDxrusQBypOroHFnPUrCdhRok68Ah2jiJm/fWR2ISdTHoSk3XgP/XmcpfxgcDoO4RLh2
         n+1hW9KVsjJOesDe4lztaP8EA6ZgnMNThvcaRlITzDstpAi5+M2f/6A87GUqyiYOTxlW
         QYOqjDxcAA65D4tqLHWUs7/Si1aaiLFyphx40Skc4XNAaQ+0ZumoXIWuCMqR3UmBffAr
         blYrSRo6rXi94hShPa+SO10aE6KIxyVAjM4yIihOEf6wx2jU2MlfmulJUe97Fh8WbOFb
         OrhA==
X-Gm-Message-State: APjAAAW5Arh5rSN9lM0z9A20nVvpEz8EIRoQBvSorJnP7eGyzrWZy3Lo
        jrsWpdbCilOvMYqFUaTwwbcJEaoPNLgABCXLqzjUkIi3
X-Google-Smtp-Source: APXvYqwN8k+M9KjgSajqntB0C1bSjlVt6sYn3TVK8vYsyVqMf4b2RD7V9hcvOIOb5/iwYfKJIwefxkvs+joKPxwmJCI=
X-Received: by 2002:a02:cc8e:: with SMTP id s14mr23329675jap.142.1561106292100;
 Fri, 21 Jun 2019 01:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190619095858.30124-1-pclouds@gmail.com> <20190619191709.GF28145@sigill.intra.peff.net>
In-Reply-To: <20190619191709.GF28145@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 21 Jun 2019 15:37:45 +0700
Message-ID: <CACsJy8AYw1QLjWALUNr7hSZemWyTSG0U8Fc_TH=9HNR-LcygTg@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 2:17 AM Jeff King <peff@peff.net> wrote:
> I think your warning in the manpage that this is for debugging is fine,
> as it does not put us on the hook for maintaining the feature nor its
> format forever. We might want to call it "--debug=json" or something,

Hmm.. does it mean we make --debug PARSE_OPT_OPTARG? In other words,
"--debug" still means "text", --debug=json is obvious, but "--debug
json" means "text" debug with  pathspec "json". Which is really
horrible in my opinion.

Or is it ok to just make the argument mandatory? That would be a
behavior change, but I suppose --debug is a thing only we use and
could still be a safe thing to do...

> though, in case we do want real stable json support later (though of
> course we would be free to steal the option then, since we're making no
> promises).
>
> -Peff



-- 
Duy
