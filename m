Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC4AE1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 18:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752978AbeDPSU1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 14:20:27 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:41821 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752417AbeDPSU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 14:20:26 -0400
Received: by mail-wr0-f178.google.com with SMTP id v24so11568874wra.8
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4pxTXb5S02zZ84aOkCx2HXCQpK9xQycn69ntnrOl4Tc=;
        b=BvFwjNw5+T8NZe42kWpFk9RQvjIl/yk6Uh0nMf1ev5hD014b8OiLgwXeLb8QwR/b0I
         KCWagnrkrSIyRQjMZlLplaeSeueE3YaSc8Ml9z/6mSePMFeWGVKjMqHhvdfeyUPlZJFG
         j9zN7rTo0pgq2jpUc3RlIr9+/8c0AW57+YzB98fY4uT3moHWFE6UiYZw2lQBja4Wa8U3
         E4TvJMmtfA3v4o3vsicvPt4iyEGQmnpoVUcSDotwBP+8B3UgH553Oxmu8DOTWAxxDn/c
         qKX7qs+Mqs01RDYA1iy7726uCCKdLdBI+AwGvbjl4itcNSjKncuNCYKH6k1hyBf6WxnC
         Sjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4pxTXb5S02zZ84aOkCx2HXCQpK9xQycn69ntnrOl4Tc=;
        b=Mm0vv//OvJ6BLgHqPstjr7R8k8z/j/J10lXHiaFqR0lK9YYyZjLF9GNhh2wpFV5n8o
         7dOO966ZMBhTBOGJHJaBO5Fu8yzLw7rjNox0DazZzhBF8zKpgEqncp8W/mb2t+VV5Y4u
         dj6+qWg04SRrRkeNhFQ4syOlMDB0wVkslnGEdcoBw48pXaXp9h2GNmBy++P9BlgeGBwV
         42rc0goqWcEmK7RbTGCoX78Rd/QAecOBriHQfDLrXREw96zUr3/4u/Nt1Ngx9+RDWhF3
         53VVWYSM3PwhD+JlKxoWzgeqslEou78OWHbZ1/7KB5RuyjKuvPPnAa5od4hVpuEw9vJ5
         0Fbw==
X-Gm-Message-State: ALQs6tDhVnf8IsD/NcfcILxHwjSr8tpQj3OgJL4t8cDGoJ0d7bIOZgLf
        TDUDC0Xyf27akc5h6cZ675fLKM+y5eVCOyNmkc8jL9ya
X-Google-Smtp-Source: AIpwx4+qUH0YFzH+t4AfZg99KrhQBAV72ptQS2eP2Q6SrQ6/QZsFEN9EHxEn2gppamxYC47+xd+NEfIW+SbWpq0VqbI=
X-Received: by 10.80.175.2 with SMTP id g2mr33805697edd.84.1523902824099; Mon,
 16 Apr 2018 11:20:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Mon, 16 Apr 2018 11:20:03 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1804160918120.6924@localhost.localdomain>
References: <alpine.LFD.2.21.1804160538100.3564@localhost.localdomain>
 <87y3hn5drx.fsf@linux-m68k.org> <alpine.LFD.2.21.1804160918120.6924@localhost.localdomain>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 16 Apr 2018 11:20:03 -0700
Message-ID: <CA+P7+xrDsPXA6Bq77gYwWtc16Dz4drg+CHA80=vBNB9-NhxHVg@mail.gmail.com>
Subject: Re: man page for "git remote set-url" seems confusing/contradictory
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 16, 2018 at 9:19 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> On Mon, 16 Apr 2018, Andreas Schwab wrote:
>
>> On Apr 16 2018, "Robert P. J. Day" <rpjday@crashcourse.ca> wrote:
>>
>> > i don't understand how you can clearly set the fetch and push URLs
>> > of a remote independently, while the man page nonetheless insists
>> > that "even though they can be set differently, must still refer to
>> > the same place". how can they be set differently yet still must
>> > refer to the same place?
>>
>> They could be using different transport methods.  For example, for
>> fetching the unauthenticated git: method could be used, but for
>> pushing an authenticated method like ssh: is usually needed.
>
>   ok, point taken, but does that mean the two must actually refer to
> the same "place"? it seems that i'm perfectly free to use this command
> to set the push and fetch URLs to totally different locations.
>
> rday

Things won't work so well if you set the push url and fetch url to
different repositories. Git assumes that refs updated by "push" will
also be reflected via "fetch".

I don't know offhand what will break, but likely something will. For
one, when you fetch again it will rewind your remotes after the push.

The URLs could be different for lots of reasons, but they need to
ultimately link to the same remote repository. As Andreas said, the
most likely reason is differing transport protocols.

Thanks,
Jake
