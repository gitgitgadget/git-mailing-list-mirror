Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F88620248
	for <e@80x24.org>; Wed, 20 Mar 2019 01:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfCTBWu (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 21:22:50 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37484 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfCTBWt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 21:22:49 -0400
Received: by mail-it1-f194.google.com with SMTP id z124so30133125itc.2
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 18:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fa88VD5PstZ+9oX0ejh73gFcEHHLQh/2cqtOHNCcRgs=;
        b=duGHRFMBD7iQW42XC+hsb77P596ls2LfLM5bGub5kEzdSugNDSCBfvbGWLp+/1g202
         o93hwL7HslrWGIH8EGXpijV+2fhM3UPUBNBMQDsxd1X4oo/jnabtGC10GPxaT9qMjXau
         fhLMk0JkntLWblspkkjhyh8rjyErH6DELplNnVvnPELtM2vZI8xmoHspOXB7mrX4Zoku
         klhd5RmPVkg4FfRHMOAJSj6YhrqA4FWNTC6F0EbE+UzXRyFoFi1NOvT4WogNNF7fbFlA
         vr5Xzg75CumBEyhmm+3jeO9dTc7ek4fDY1anZXtqqa51J15yhmxsGhfKmmxzKEf6LR2+
         dOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fa88VD5PstZ+9oX0ejh73gFcEHHLQh/2cqtOHNCcRgs=;
        b=Moiz1zmZfERZgZyVxyuewG+bNF8XBXjiPsTTtBzQpIxCh55F0Z1UPC9FrI0sxdg2lE
         pYJgI2rZDwRPmj5NSH5o949ceWM4go2XbPsNCJyAXTziuhsoVwNVyyQLm5Ff56yCovLE
         3Z7N0287fNYlnwyuKE3AOF9u2TzS7FU4sL0q394zTJCe/vI8qoBuIPLFbS+mPcCnVgyf
         hjuEFwoXbFiUKtZTPZIjbAHrdNWlhHxxOmdsTlIzrCu2+rFFooM8+3b4szvVPQqCOWh7
         fkjnQVO3qMNKzkA1Q072J0q7NkX3KA2d9zqc1QSPi18VG0bGzhfWxdwZ7kVyj3uqXQ6r
         nibA==
X-Gm-Message-State: APjAAAU1a9MXyX69GH8NPWQd6dhuLIe6CDcbt79xRwwHlY+IsohBz8Cq
        z7lcFS9oZGF9qY+tiBQHJtEIIPAOb3e4r7+phxMtXw==
X-Google-Smtp-Source: APXvYqz32YBdwWfOffkJjiXhc5+MRF6Z1lgy4kmALvyGvsG7UNhRvNCDWOCXV8B+wrG079NBlI1IqHpCY7kjm+pW9nc=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr3309518itf.123.1553044968969;
 Tue, 19 Mar 2019 18:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <78628256-79dc-3036-c57b-a96797ceb120@gmail.com>
 <20190319093910.20229-1-pclouds@gmail.com> <xmqqimwexujm.fsf@gitster-ct.c.googlers.com>
 <CACsJy8BLxWea0ZrHkSU6+nE7dr5YvFNVH1tLhaqPRadi+2Hhwg@mail.gmail.com> <xmqqk1guwdeu.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1guwdeu.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Mar 2019 08:22:22 +0700
Message-ID: <CACsJy8AUH4nOkt6H=yu=eRktK4me9kEkjqsC3zyNZDwUKXqCPg@mail.gmail.com>
Subject: Re: [PATCH] checkout.txt: note about losing staged changes with --merge
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 20, 2019 at 8:19 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> >> I think "checkout -m <otherbranch>" with a dirty index should refuse
> >> to run; there is nothing to "continue" after such a failure, so I am
> >> not sure what you mean by "an option to continue" (iow, I do not see
> >> a need for such an option, and if that option makes the whole notion
> >> strange, we can just decide not to have it, can't we?).
> >
> > We have --force to continue even when we have local changes, which
> > will be overwritten. I was thinking a similar option which gives us
> > permission to destroy staged changes.
>
> Ah, then that is not "checkout --continue", but "checkout --force
> -m"?  That sounds sensible, and should behave as if "checkout -f
> HEAD && checkout -m <otherbranch>" was done, with respect to local
> changes, I would think.

Kinda. But "--force --merge" makes no sense. --force discards all
local changes by definition, which means you can't have conflicts and
will not need --merge. I think this is the reason why we die() out
when both are specified. So we need something like
--discard-staged-changes-only...
-- 
Duy
