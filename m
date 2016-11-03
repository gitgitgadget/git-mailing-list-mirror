Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E71E9206A7
	for <e@80x24.org>; Thu,  3 Nov 2016 17:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758149AbcKCRjh (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 13:39:37 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36784 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbcKCRjg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 13:39:36 -0400
Received: by mail-qk0-f181.google.com with SMTP id o68so66556065qkf.3
        for <git@vger.kernel.org>; Thu, 03 Nov 2016 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MG2c8w8mjtdu5EtJIdJAhCYOd0tJHuw+ASIGl1NjV7Y=;
        b=M5cs2plvAoC7ZCD0dB4PCDgb4Zn1AeocdApbLxkTuRMKNG8U0/3jn9HbH9/f464CcP
         ZXcoBVZDr9gMq5oBz1aQL0teyOi6PvnbsC9EjFmhwDaaqW4coAgW6L/rjbPQJ3ZNRm/F
         iQB13F6XcRIXUU4qbS372sTlV8WBi8atP73IDLBDV7zttN/qDfZHBKw529mfk/OhU6Ll
         yuNecnuiR1lYgIDOjFCBJHjdbK4WwszZ4BffSp4oM2uM6+uZNrseG8zWrJZJELHLvHJl
         Coz8OGgzGDLk0/BJm75kBZe5ng33GBkkJkNoh1LQRv4KYmkJp5SEGF4U4StQZKYvb5sq
         63UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MG2c8w8mjtdu5EtJIdJAhCYOd0tJHuw+ASIGl1NjV7Y=;
        b=Xz9Uq4XcZqAWqrBCQsXg/J+P8pjjrH+Vx21wqdvXzgzxzpN+kf8wZwYIhu28CqI09u
         HaembNdLADGXcmEGTz8IAAIh0zf1YYFPHtAHMzPV2Fa4jkpVsoFFfwrP11SjLnvx2Nqs
         7fHl9C1dDSMnj8b4PAqbAO95QzR+6hzLUq44l2G0lPzGFdQUvVMLLAsUsxzSMSoZfQ4P
         IIbfdizTrUwN8xs4xy2eeZyT+gPor9dhz9Xme/KmePnFZXv2gUdixl4GJYn8ad2w5RmX
         am6chCh22HfOqJzZpN8ka9vo2gE1GrcIc0h9TVu6YdDkZIWHTzIMKdEr2ld6Hd+JN5vI
         ZziQ==
X-Gm-Message-State: ABUngvcoYfU0Bh0/q/fbQt1WEBKVkDvVUDGq5hX9fq3GsgUUpeBeeDg3hKwO2v28CkPrwTwHIa1BpUcSfS60nH1X
X-Received: by 10.55.105.129 with SMTP id e123mr4091775qkc.173.1478194775730;
 Thu, 03 Nov 2016 10:39:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Thu, 3 Nov 2016 10:39:35 -0700 (PDT)
In-Reply-To: <20161103172515.GA182568@google.com>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161103002225.GA13369@google.com> <20161103143806.hce4msk3dhxtgpre@sigill.intra.peff.net>
 <20161103172515.GA182568@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 Nov 2016 10:39:35 -0700
Message-ID: <CAGZ79kbvs+ryGRjCkHYO=3iNK4tPPhBhYjRMZaH7rP0QMrULhg@mail.gmail.com>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Blake Burkhart <bburky@bburky.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>   protocol.X.allow = always | user | never
>
> It sounds like there is interest for this sort of behavior, it would
> definitely require a larger change than what I initially proposed.  One
> problem I see though is that with this we have support for both a
> blacklist and a whitelist.  Which wins?

For the submodule operations we'll use a whitelist, because we want to
provide security and for the other case we can offer a blacklist as a bandaid.

My opinion on blacklists is roughly aligned with e.g. :
https://blog.codinghorror.com/blacklists-dont-work/
http://blog.deepinstinct.com/2016/02/04/when-blacklists-dont-really-work/

So IMHO we could drop the "never" and substitute it with a "warn" or
"ask-user", such that this configuration becomes a white list for both cases:

     protocol.X.allow = always | user | warn

> Or do we simply generate a
> whitelist of allowed protocols which includes all protocols with allow
> set to 'always' and if it is set to 'never' then it just isn't included
> in the whitelist?

So you're suggesting that setting it to "never" doesn't have any effect
except for cluttering the config file?
I don't think we should do that; each setting should have an impact.
So maybe the "never" would be there to disallow protocols of the hardcoded
white list (e.g. http)

>
> I don't know if I'm sold on a 'user' state just yet, perhaps that's just
> because I view a whitelist or blacklist as well black and white and
> having this user state adds in a gray area.

Well the "user" state is to differentiate between the
* "I consciously typed `git clone ...` (and e.g. I know what happens as
  I know the server admin and they are trustworthy.)
* a repository contains a possible hostile .gitmodules file such
  that I am not aware of the network connection.
