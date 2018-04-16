Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A39B1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 15:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbeDPPib (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 11:38:31 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:39746 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeDPPia (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 11:38:30 -0400
Received: by mail-ot0-f179.google.com with SMTP id a14-v6so17870407otf.6
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 08:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o6t9/JuzTZ36wffq35+FMrirKZyu0z+3cu3qVN5ZqIw=;
        b=quQl8PLjgumwjKpwgJXZKxHqOBWplW6IbRK7dI8/wbCCAUylAsNRHmMFXQQ5icmdjr
         SWnzqIstMxZq3BNpoYjiy/PXp716zWjpDb4Y3T9/2JKx6hZ/ujU4DWvvc/7qKRxqRn0p
         lgBjctiFDJTY7sLTi4gCoE/e0b64Z+cBYmyiZvZuNYhgMBzatMHBKmlqbHv7WadWG8ge
         e83rDh2zcm+RLTkoJMgsAl/SV+CeHYI8Efu8uFiYj8mkAVLmbbS2myWDppldIym/RWKp
         sLisgnVLvb5aOJze7iJlu8KKC9rtucUe45QDvcN2jh4qIPZ4OsgABnUUjhlHRKWIlfWy
         DY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o6t9/JuzTZ36wffq35+FMrirKZyu0z+3cu3qVN5ZqIw=;
        b=G7OwnUNPcQzBDzB+BlbujwIvI7AHLDTx7sj3RDGvvUBGJAF5+jeLk6T8mu79K4B4Xv
         r418cVG0U937VlES+rxkVEHyFEgu+PJHt3kFC3Yvi7ZzKj96Lb/bmy/iU/JcDT+wNmUy
         rXx+LEpeMdegzldvigCB6mGG7W/kDa+Zw7aP0gW9i0yxwdlUYMqERl62suE+Uj2dMeVg
         wR44+L5BxnLkh4npjnpLkdWorM+bo0QpM95Pu3Yv0MDdOfb7zYBtzB9y9nAUl2ZXNsKI
         cK4EPcOSEEH6x0E0HsJJ/Zj99CjwEm4IIGs6MHr4/666w2kAHltHgihX/Ksw/1PFbq8R
         Ixew==
X-Gm-Message-State: ALQs6tByjoMqmkUQd2h/+eG35fZlWlW3+hCbK4wRW3an/8mKnAWGLKVv
        nVXjNmwpKaY5LKA/nGSPVqLJh+OjqJpuLhcUcA4=
X-Google-Smtp-Source: AIpwx4/kmAPEQ1b9jllHK2wI+oeROfJQjJ/sP+WKoJptlcyyyTEERXa3exoqhwuaB0fvyayIY7Csmjc/tQOa8Rb3TmQ=
X-Received: by 2002:a9d:24c7:: with SMTP id z65-v6mr11375483ota.152.1523893110289;
 Mon, 16 Apr 2018 08:38:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Mon, 16 Apr 2018 08:37:59 -0700 (PDT)
In-Reply-To: <8736zwozze.fsf@linux-m68k.org>
References: <877ep8p9yz.fsf@linux-m68k.org> <xmqqin8s18pg.fsf@gitster-ct.c.googlers.com>
 <8736zwozze.fsf@linux-m68k.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 16 Apr 2018 17:37:59 +0200
Message-ID: <CACsJy8DofC0Q9HPE69d=Cd930yG04wTiJdx2j5J8qgSEstr-Pg@mail.gmail.com>
Subject: Re: .gitattributes lookup doesn't respect GIT_WORK_TREE
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 16, 2018 at 12:40 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Apr 16 2018, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I may be mistaken (I do not have the code in front of me right now)
>> but IIRC after the setup.c code runs (which happens quite early in
>> the sequence that starts from git.c::cmd_main()), the Git process
>> moves to the top level of the working tree,
>
> git log/show don't appear to do that.

Yeah we lazily set up worktree in some cases. Elsewhere in the
chdir-notify thread, I suggested that we set up worktree
unconditionally (but do not die setup fails; only die when a command
specifically requests for worktree). That work would help make this
work in most cases. But it's not materialized yet.
-- 
Duy
