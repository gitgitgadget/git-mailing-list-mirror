Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712EE1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 14:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732090AbeGTPah (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 11:30:37 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34987 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731591AbeGTPag (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 11:30:36 -0400
Received: by mail-it0-f66.google.com with SMTP id q20-v6so14898476ith.0
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 07:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9KtgZLBI9amKGtoqy/x2j6lT7OOFoOZ14RT7I5jFYo=;
        b=ioQTh2FxYFAS1Y/rpHWD4IjLmCMQUzliuS9GcjC0ACWnaiPVUHtwrDVTkfqWkI+o6W
         MbFBGb5nt1Tnoha2MU+pdgsxbi28XG1rwMOQCbuYEWtumqAx2hIxvgoKq+TxXLwiYT9U
         ++ZgqTSj73jxBW3w04AEEgf9okaL/evsFH8eho7vh1iyBZE3c/36AbUqWhOzcETN574P
         wHBZCEjUW7MXKy5lmxhLBlPCk0d1vGmTkjrE7DDhNO9CI5FguIta6fk79SUPiUZ3/kh/
         uG8MX9kuv5p+rnJd/Zy9rXXa3oR0vFj+0thl1uvw698Mu9oLLS7Yf0eq+76yOnwKGr/Y
         +iUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9KtgZLBI9amKGtoqy/x2j6lT7OOFoOZ14RT7I5jFYo=;
        b=AoK4/l8g4VN20JjCXXuOufJ3a8n+DRGharQdz+zZ/N/HfA+9r/YWokztwwgxFmSvwZ
         SrvEPQAQx+eYojvr28okB/41ojbZoQCfuzURtFkBVHLLrAF3ZycUiNFvQW1TPVQRsrua
         7A3rUZdmLWYeyZyOayf08eFXfV8td9phivHvMuZYoe8mZGXJJSBKStJlKiddcif0F8Q3
         UPkWB0pAa0tKX1h/54R0bOFPcdbyjrcx3gbMrlZ++lg8WrtxIPAmXek7u6b8ovlE5vmG
         9PZpBUl6Y9MnK6ggRZUfSjxm49QhCdlKQLC+3zi5mfOgM63UcK8I2RhZU45r5RHbJfvU
         ob5Q==
X-Gm-Message-State: AOUpUlELdR/6XhD7WXnQ1prPMvhrLff9x3QLm83S7AZAPPmerc8avdsi
        pf95ededusk2bluEufb3L6zZw04ziIFWjiTxADE=
X-Google-Smtp-Source: AAOMgpf8GXurDek0meovbQIAuGQqHkGYDZ9LOZmKCe6a0IJEK+LTSODI4u7gKBNqL53UnQtIkb1mR2Qr7bCN/numTt4=
X-Received: by 2002:a24:c888:: with SMTP id w130-v6mr2275866itf.78.1532097720540;
 Fri, 20 Jul 2018 07:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180719203259.GA7869@sigill.intra.peff.net> <20180719203901.GA8079@sigill.intra.peff.net>
In-Reply-To: <20180719203901.GA8079@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 20 Jul 2018 16:41:34 +0200
Message-ID: <CACsJy8BxXyY6h8iN-RExBHASB6FkFLKDkrE_h+gH0A1k2tVd6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] introduce "banned function" list
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 10:40 PM Jeff King <peff@peff.net> wrote:
>
> There are a few standard C functions (like strcpy) which are
> easy to misuse. We generally discourage these in reviews,
> but we haven't put advice in CodingGuidelines, nor provided
> any automated enforcement. The latter is especially
> important because it's more consistent, and it can often
> save a round-trip of review.
>
> Let's start by banning strcpy() and sprintf(). It's not
> impossible to use these correctly, but it's easy to do so
> incorrectly, and there's always a better option.

Is it possible to extend this to ban variables as well? I'm still
going to delete the_index from library code. Once that work is done I
will ban it from entering again (it's only allowed in builtin/ for
example). The next target after that would be the_repository.

Right now I will do this by not declaring the variable [2], which ends
up with a much less friendly compile warning. I did something similar
[1] in an earlier iteration but did not do extensive research on this
topic like you did.

[1] https://public-inbox.org/git/20180606073933.14755-1-pclouds@gmail.com/T/
[2] https://public-inbox.org/git/20180616054157.32433-16-pclouds@gmail.com/
-- 
Duy
