Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF8651F453
	for <e@80x24.org>; Tue,  5 Feb 2019 02:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfBECSw (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 21:18:52 -0500
Received: from mail-yw1-f52.google.com ([209.85.161.52]:42076 "EHLO
        mail-yw1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfBECSw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 21:18:52 -0500
Received: by mail-yw1-f52.google.com with SMTP id v201so1123802ywa.9
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 18:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=WnQoLb++dysN9u97aFK42a1jeMLniDcSFd1IaEL2L+w=;
        b=VPO2rkhB4D/QjyBlNTkuEJCC750fQSpkzRJ5p+dTcYuNKR2/6ac46YlrbDDPKrY9dA
         52vzZLNOz918TyzYMKakaIE+nIo6FRPeu/+w1dvfY/ZXRMQ/suGwrCgr+t1Hf3wJ3o3P
         gE6CcjNOoG9bukrsyWXkUw28yzr/5KFaVWS9reSpjFR7eTvxsEeJ9Ai760gmcTgnDWB4
         nOlah4UMOFmEu6K1GHkUcqYa/Pir24sXA5dkWwhtSttzPJfZd/g7jA8ABQVDNBSrKzIW
         cnG0ENUg0v4lvzKtbeGIq6SZCyY9o2sK/PBFXOLStqnq+dDnsZ/ByahYnUL9h0Gb2WzQ
         K4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=WnQoLb++dysN9u97aFK42a1jeMLniDcSFd1IaEL2L+w=;
        b=Hf2dN0BUFj2vIzHlCzTnDF7zybu1rGjV7u5dvUDphgteokOhjTDGOor8ZPgSEJKrkH
         kIPgv5zM6gQNwwx2BYm8YhPfghW/mGruNFKJGApqZ/z4hN/C3z8kb7iBnvj1vZw/r3QE
         /x9HbTDReOxNu66O+W7ACn9RTBc5pkwze8w+8M39WbmnDsxNpg9aIAr6IW9tLJ9DgP4z
         AzJVNtAVxw/728zI4vou1fmQgPUZ61O9eHwN4j8zPKF6DqTKp38GCLzi6lQLSQiP/6/L
         1p8M8jfIOIIYHf6RiJFw9CmIiHt2VlzJioQHdHMGHaIfjOan8bHQHCSX27ypv1/Keil2
         euWw==
X-Gm-Message-State: AHQUAuahus0quP09fEGOIX2Zl+waFyChyMrC+janS9ZpxuC1xJ6PeG2j
        R/5JtXOQ8SwiI5Pa/nUl5nH7l7cxA5qX+l27jA==
X-Google-Smtp-Source: AHgI3IaQ3MGU3oRZQvhPKOVmJvveQYjvOaHf4/bU5QYpKjjd5B8fQjU5cPaNEAND1qTL2Fs+EcTOuezjegFLev/QBpI=
X-Received: by 2002:a81:ae63:: with SMTP id g35mr1942306ywk.209.1549333131166;
 Mon, 04 Feb 2019 18:18:51 -0800 (PST)
MIME-Version: 1.0
References: <CACwCsY5xU0pUaPZDJMqWNB0dz7DjTx3_b2Lvrft0NjA6cnPvcg@mail.gmail.com>
 <20190205015506.GB527887@genre.crustytoothpaste.net> <CACwCsY4fwr6=2S5CHe5bH7=7Hukq9np+eT1VO+kUDyBtMLKPcA@mail.gmail.com>
 <20190205021513.GC527887@genre.crustytoothpaste.net>
In-Reply-To: <20190205021513.GC527887@genre.crustytoothpaste.net>
From:   Larry Martell <larry.martell@gmail.com>
Date:   Mon, 4 Feb 2019 21:18:14 -0500
Message-ID: <CACwCsY7o=ArM4T4n7umun-R9Dip5NmmOEL7Ygd9zEQdCyQa4Og@mail.gmail.com>
Subject: Re: hook to get info on commit, and include that in a file that is
 part of the commit
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Larry Martell <larry.martell@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 4, 2019 at 9:15 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On Mon, Feb 04, 2019 at 09:00:42PM -0500, Larry Martell wrote:
> > Thanks for the reply. Any suggestions on how to achieve what I want to do?
> >
> > The use case is that we want to have a file that is part of the
> > install that has certain info (commit id, date of commit, commit
> > message, etc.). and we'd like that to be generated automatically.
>
> If you want to generate a file, you can certainly do that in the
> post-commit hook or using a Makefile target. You just can't check it
> into the repo. Lots of projects do this as part of their build process.
>
> An example of what you could do is "git log --pretty='tformat:%H%n%B' HEAD".
> That will print the commit hash and commit message to standard output
> for each commit. If you want just one commit, you can use "-1".

Yeah, but I want it part of the repo so it makes it to the target system.
