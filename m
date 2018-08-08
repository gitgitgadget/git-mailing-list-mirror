Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3222208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 09:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeHHMCL (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 08:02:11 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45026 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeHHMCL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 08:02:11 -0400
Received: by mail-yw1-f68.google.com with SMTP id l9-v6so1067552ywc.11
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 02:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+urka5bEVU11Iz1P/PQIte69xR+t12UhjEQL1UzCAw=;
        b=ceTfntSgf4uGdv9TKaZHGnvXvUixqxztMAHMZdQ2Q0MjEk294rIdsWk+xXOso6U3/4
         WTRrpelXDVvdFRK5jSA8AUeZFxEjd6SQ3n06IfeOCBLi7vcLRwM1LsKwU/2cbAXJeKxL
         s+raT5eFd+SvC8SnAsz8tEEO5FrQSYUwpseoXRdFzXjpq5xNtIuySjRi5DvapCFTFRp9
         gFPow2NEXYe/Gash4DwX0lUYhR40gQDQ+tkbFfmJVfT5BCFPijYGUjgOlhPsazTr2jR/
         jK2yYlIIZ8ZPBAuBTFG0rHv/iRLuTP2tfgEBr8Ceg/mCHlMEH+JaEQwqWQc95hUxChMB
         1IWA==
X-Gm-Message-State: AOUpUlFue5rCOijnZgeQmB6NvFddXVXbJa2+04EmbPT357XIk+tXxiPu
        Ha69u3C4Igr9ocMfMeqwb/7UJpcryKKPKj9NvXk=
X-Google-Smtp-Source: AA+uWPwXrlx2ipDyiuwCn1eePyIuXy+1urTds+aboy/OgGxvvXHm3jypODmS+txBR2psCm5CKiUGqzjTBkzDsiSui3I=
X-Received: by 2002:a81:7bd4:: with SMTP id w203-v6mr1003285ywc.70.1533721397199;
 Wed, 08 Aug 2018 02:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180807093452.22524-1-phillip.wood@talktalk.net> <20180807093452.22524-2-phillip.wood@talktalk.net>
In-Reply-To: <20180807093452.22524-2-phillip.wood@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 8 Aug 2018 05:43:06 -0400
Message-ID: <CAPig+cStNhC=+naumnpw0+XzDKZ1Un+pziZ7sa8J0cu6O8pa4Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sequencer: handle errors from read_author_ident()
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 7, 2018 at 5:35 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> Check for a NULL return value from read_author_ident() that indicates
> an error. Previously the NULL author was passed to commit_tree() which
> would then fallback to using the default author when creating the new
> commit. This changed the date and potentially the author of the commit
> which corrupted the author data compared to its expected value.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>     changes since v3:
>      - Implemented the simpler scheme suggested by Eric

This iteration is much nicer, much simpler, and much easier to review. Thanks.
