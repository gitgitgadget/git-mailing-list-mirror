Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17190201A4
	for <e@80x24.org>; Tue, 16 May 2017 08:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdEPIFg (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 04:05:36 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:38822 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdEPIFb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 04:05:31 -0400
Received: by mail-it0-f53.google.com with SMTP id e65so83060344ita.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 01:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3sOFWesCibIDoOe7SoHpQ10U4/EcheYv7QRIANmgWpw=;
        b=J/lI68H2npWcNbcI5zLaPxrmfkGSaqbMu6Ad/wjzMnAFP/jVimqkw4YSa4D2akpfT8
         n26gIElIibkWWmEQUDHkjFzKfaRZ7uV4W4KSV/2xSLymMudNLk0j6bdPauymXczERDAJ
         nhpZB/hJjB0SNc+ju772iCNHw9j1l/gIKNl0g8b1f1MqEk7qZcYIDaitxdwpDLuJXeNR
         RvEL9FfQ4UX3XMEefL7AB/LMUHVv/VyoFnj+JoBjLsnkXJpcXGG9pux1LzhHYeo1T5Yu
         407/ndab9043N0CbSGI7fusAFbY1IsR5C0WzyEZ4sIt49Iy1RdrUNpWtSJZxqRQDh6Ww
         6nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3sOFWesCibIDoOe7SoHpQ10U4/EcheYv7QRIANmgWpw=;
        b=WfT3x5FpvbMUYUo7AU2eNVU5eqm9oxx6613VdGJNLJe3FUZ/TPPIzWj8ZG9RJ27ugl
         LaPeYGxXhNJ9fTrXWYjvhzx8COyKVNOT7h4hkAcL7SsVBjhUrUk1vkl6ooBWZzpEP7GE
         pEv0Y4qW7SPa7pk0maGkGNUK4LbutAK2WOv3z4Oc0u/+RrMjygIkxNPiVzLATTCOvcF4
         kmUx+z456VTBCBUwfJ6iYGXnQEvYVnLZhMJ5c3kT6OrHnrWLr5mpr1R7OBYh1PUByiTx
         6lQGB5x/xiljVC0LDDxML1BN1Nr5ubX8A8zc03wdINg35ZSBcxrduLe3m4BuL+WmKxZ5
         +22Q==
X-Gm-Message-State: AODbwcDMY2aqiLZTv6uLppLyLh5GJ41z1Yqior6yxdh/zaHP3gScKKOS
        Yr5jBrHQKK+KXGuSlf9bZosnH8gvRg==
X-Received: by 10.36.166.4 with SMTP id q4mr9385639ite.66.1494921930583; Tue,
 16 May 2017 01:05:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Tue, 16 May 2017 01:05:09 -0700 (PDT)
In-Reply-To: <xmqq7f1h63h9.fsf@gitster.mtv.corp.google.com>
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
 <xmqqk25m98rd.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1705121216290.146734@virtualbox>
 <xmqq7f1h63h9.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 16 May 2017 10:05:09 +0200
Message-ID: <CACBZZX5EXxsB3TWiiB0TH-ZpOsadcAPAe4chrQBe7py9VAMY+Q@mail.gmail.com>
Subject: Re: [PATCH 00/11] Start retiring .git/remotes/ and .git/branches/ for good
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 2:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Fri, 12 May 2017, Junio C Hamano wrote:
>>
>>> Is it really hurting us having to support these old information
>>> sources we treat as read-only?
>>
>> Well, you frequently complain about my patches, claiming that they place
>> unnecessary maintenance burden on you.
>>
>> I would say that the .git/remotes/ and .git/branches/ code is a lot more
>> maintenance burden than most of my patches.
>
> I wasn't going to respond to this thread anymore, because I didn't
> feel like the discussion was going anywhere, and you already said
> you won't listen to me.
>
> You seem to be confused between "maintenance burden" and "burden on
> the maintainer". I felt that it needs to be corrected for other
> people reading this exchange from the sideline.
>
>     When we worked to add feature X in the remotes subsystem, we
>     were slowed down because we had to adjust the code also for
>     .git/branches.  The same story for feature Y.  The same for
>     feature Z.  This is getting ridiculous/cumbersome, especially
>     given that we know .git/branches is not used by anybody.
>
> That's a maintenance burden, and the "we" refers to the Git
> development community as a whole, not the maintainer.  It is not a
> burden on _me_.
>
> Also important to notice is I do not know what X, Y and Z are with
> respect to .git/branches feature.  That is where "Is it really
> hurting?" question comes from, but it hasn't been answered so far.
>
> What's burden on the maintainer is having to engage in a discussion
> like this one, to reject an attempt to remove something that is not
> demonstratably a maintenance burden, because the maintainer has to
> act as the last-resort champion for the end-users, when others on
> the list do not speak up X-<.

This and many other discussions on-list basically come down to:

1. Someone wants to change X.
2. This would have user impact Y.
3. We have no way to quantify Y.
4. X doesn't happen out of fear of unquantifiable Y.

It seems to me that a way out of this that would make everyone happy
is to go through some deprecation cycle through several releases with
X where:

1. We detect that you're using X, and warn that it's a candidate for deprecation
2. In another release, we turn off the feature by default, threatening
that it's going to go away forever unless someone pipes up (this is
what we did with rsync:// accidentally)
3. In another release, If you turned on the feature after #2 we emit a
noisy warning every time it's used, saying "it'll really be removed in
$release+1"

Another open source community I'm involved in, the Perl language, used
to have the same issue. Every time something like
adding/changing/removing X came up we'd have the same discussion all
over again from scratch.

A lot of that was solved by having some written down guide for how
deprecations are done:
http://perldoc.perl.org/perlpolicy.html#BACKWARD-COMPATIBILITY-AND-DEPRECATION

Of course that's not a perfect solution, nothing is, but it makes it
much easier to get patches like this on some sort of well-defined
track towards deprecation.

> Yes, I know that proving that something we currently support is not
> used by anybody is HARD [*1*].  That is why removal is costly.  And
> that in turn is why we need to be careful when adding new things and
> making changes in general.

From my reading of this series we already have a solution to that. We
start warning and then we find out who's using it.

To the extent that that causes issues I think it's better to peel that
discussion off this specific topic, i.e. the pain that causes users is
not specific to this proposed update, but has to do with how we want
to do deprecations in general, and the trade-offs involved with doing
that.

> [Footnotes]
>
> *1* Removal of "rsync" transport we did recently was a happy but
>     rare case.  It has been broken for a few years without anybody
>     complaining.
