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
	by dcvr.yhbt.net (Postfix) with ESMTP id 910A21F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 10:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbfJOKyH (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 06:54:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34200 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfJOKyH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 06:54:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id r22so14125172lfm.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 03:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gAXVkhfPmylhACNbqb9xgzjjGoU+8ZAm11O5Ea6xCZA=;
        b=XIq2yO+3x12fJz8xEhkiXnq8auWcUBv9T/Smkg1YKbHS+bIZvfi402WSptxJn6pUm2
         3N2sff638DesrDhyJBPoXkXY6BMuMpL3nRYB4oI3nIkbKRjGzGIFDWGwTK9SKLD5/Gy2
         9t7ns2iucPPASlLJfjD8pylinMSoTicMkutdNA7MY6sKi17YGEoPOemDWRjqvQeEJeqB
         D+qknN1Nz/4VjI1wXMDA77LZ5OhjZAR4d23w/qrKddkz5p1SlQs+f30m8Ph68pMh67gb
         RdQzc4eXmbbyvar5cZmnjD07Ij4wsBbBUKUjJvkVPPRULdp1yyT2af1qxcw2/UT5HmmQ
         B1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gAXVkhfPmylhACNbqb9xgzjjGoU+8ZAm11O5Ea6xCZA=;
        b=Grw8pLXhKSBSuGWxnVWXquVvv9wEoJAJitI3qTWDCik4QEdpPdysRubqx4f6MeecIj
         IZnNj1q90q7ZGrHw/tZbwCTqXVcb6N4ve3o+POdL/5jHxfsxfwjGyqMRbd0p8tDAByFM
         FlVKFPZ6rdQTHtpoagOeXVr+NIUuTGrVllcoT3Ts9Xn8KWne9/7hqIJEymKvFuQSwUtw
         xdu3pscfEDKNZzV/QhyNBeO01BmRYamTdz+Q8t0tOXl9H5xBy1mG6UbhN/ExaZULlUMz
         JpEAZEAilMvOGAwEs06PG/M37FUehbkNEy55Y1Bkv/pe1jGD4iqZrfWwBV//Ny/83pC8
         xdJQ==
X-Gm-Message-State: APjAAAVp3ObwlLuZ+Gt5UuD5o+AfEnRo6t8Orpas253iF6A53m7D2LWA
        meyxEWgj1efdnQB9jlBCzD5k5kJOaY1Ng6/blY2qJpjj
X-Google-Smtp-Source: APXvYqzhzH1PvOfbgza/Az7dGNqmRJDH/m/CxUaBK4qYcIuKf7ZKqN7Cj/o6MfCllXrUkGzcEo1AeTM0OJ8Rvxf2xys=
X-Received: by 2002:a19:3814:: with SMTP id f20mr20535192lfa.103.1571136845395;
 Tue, 15 Oct 2019 03:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=KXpt7GzqPpm1BCrsc1jhfaXeCT-XrWKNvq2pLtgAbSwQ@mail.gmail.com>
 <20191007171145.1259-1-birger.sp@gmail.com> <20191013202110.z3gyx7eikackvmzb@yadavpratyush.com>
In-Reply-To: <20191013202110.z3gyx7eikackvmzb@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Tue, 15 Oct 2019 12:51:03 +0200
Message-ID: <CAGr--=K8beYCwRgjFdokyCkjguXTJu8wMoxMAMG_H7CVgmEA=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-gui: implement proc select_path_in_widget
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

Thanks for reviewing. How does this work, do I send a re-roll of the patch(es)?

Birger
