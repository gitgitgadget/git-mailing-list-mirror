Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7D3A1F576
	for <e@80x24.org>; Wed, 14 Feb 2018 07:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754505AbeBNHXy (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 02:23:54 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:46847 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754470AbeBNHXy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 02:23:54 -0500
Received: by mail-qk0-f176.google.com with SMTP id g129so11010461qkb.13
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 23:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cpD7pB/MxgjbyVckT4ICIrazDbRt7wGmwjXu9HSsh0s=;
        b=DhXVXMPw6MJZMqKJx41tNTrF5itlCOuVoH42l7RBPSEC7TYxTtDKJPV126aOWuNTX0
         GQOcK7cVcsKwPdHYr+NBQgfkqN9+2tNN45FfTxGdeiSw0FbuDbqr1i6zqkucDVGWzZT3
         7JCXKrdhg18NpiwAtpetEnqCYWLjBzJHe0lU/AToZXnQPnE0QQkkERIEUK7XnAejzBk5
         Et5/tEmjNOTFx0DZZTqNGHQ48r0XxuSiMCSEfvf1NxRf2cr9QlNaPEWLIjMRicSaKBC0
         NIJ+VDz5X28gGgeSglEYdiJpnEUIULJnPHucf2Y/OxS3hvgxDPPrIzicrIW2n8llhZh9
         +fWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cpD7pB/MxgjbyVckT4ICIrazDbRt7wGmwjXu9HSsh0s=;
        b=R6aIsWP3BgheaxyZIond7hRzy6LZv6t6kwS7teJSpI2+pyc1rvgTpRY2e5o8XX5Sqm
         vnULVj8+9YVh+71M5OG+V2qAd/veu2+UFgzoNLxjFrN2znw6sKUyeHIWfOjyvYEOPO4B
         lZ6SEOY0Osjuswav9gM0GYx7+OKtYQBMykd+bZX7Sh708j33J/g2rmeuULEyTliSSOqL
         x/t336P80UYiRfEWXu+gfexgXPJEMJWPBwf537+0l9yIvRooqnnKI5WY48fhGM4pTGCs
         Q2+fykeM7g8Ofja/qetgoymPGLwQvmc2/K/4MUyRJ/QAaMCIPDoawSCv9sbtQ01saGOt
         5Biw==
X-Gm-Message-State: APf1xPAG8zEXICmFDJ3JH/yFyMGScaN3RX8Schbk1XMvcEwKLpT452rU
        eeOqrQkX1MmmJQh3iO3CHt3lUMESLUJ/SNIafD8=
X-Google-Smtp-Source: AH8x227Z5s1+mH+xQLqJBoUhKzS6wvo6iHty/gspcwRZj9eS69Cl3XzqYww4ybEG5GQfJR5B9N/GnM6vN1lRIqXBGmo=
X-Received: by 10.55.221.76 with SMTP id n73mr5761732qki.53.1518593033295;
 Tue, 13 Feb 2018 23:23:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.128.40 with HTTP; Tue, 13 Feb 2018 23:23:52 -0800 (PST)
In-Reply-To: <CAPig+cSQecUr5+QkSWNHbzUeViTA7KjLdcjLZmfhK5hT-fuKfA@mail.gmail.com>
References: <CAPig+cRUr=dJgaG2-aRArswQXXZEExQah4k17+HkiB+sZHORYQ@mail.gmail.com>
 <20180213014130.190374-1-sbeller@google.com> <CAPig+cSQecUr5+QkSWNHbzUeViTA7KjLdcjLZmfhK5hT-fuKfA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 14 Feb 2018 02:23:52 -0500
X-Google-Sender-Auth: sn9YFFBGi-UdKKawKsNUquuR9kQ
Message-ID: <CAPig+cQwzSVkapkRxFOn7DSVJ8hCXnuCciPQdFaZnFEq=VKCuA@mail.gmail.com>
Subject: Re: [PATCH] color.h: document and modernize header
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 10:55 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Feb 12, 2018 at 8:41 PM, Stefan Beller <sbeller@google.com> wrote:
>> + * Output the formatted string in the specified color (and then reset to normal
>> + * color so subsequent output is uncolored). Omits the color encapsulation if
>> + * `color` is NULL. The `color_fprintf_ln` prints a new line after resetting
>> + * the color.  BUG: The `color_print_strbuf` prints the given pre-formatted
>> + * strbuf instead, up to its first NUL character.
>
> "`color_print_strbuf` prints the given pre-formatted strbuf (BUG: but
> only up to the first NUL character)."
>
> Probably not worth a re-roll is Junio can amend it locally.

By the way, thanks for the patience in the face of the nit-picking
this patch has undergone.
