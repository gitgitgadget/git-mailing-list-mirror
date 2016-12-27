Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E24D200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 22:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753877AbcL0WSy (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 17:18:54 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33064 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753160AbcL0WSw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 17:18:52 -0500
Received: by mail-qt0-f172.google.com with SMTP id p16so334572005qta.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 14:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fPRMg868cN2PY0ANUcIYR+D8aHmErPlQ6zfaWMNNBrM=;
        b=FflbxyHQ55erG2QNXr3D4kSllltDbB4NGoh1wPGhP8TBKJ2l++N37oqjy316NZc5ow
         IFdnQRJx2+0waBgk99vjgluXJUEuWgeqnNvpNELxpqkTLUjxnzYvp7Bfl7RmlEC7jOY0
         trhEYZOmnv9fW1uJmoeg//oRMU0cIVmNirI1g5AnBcIekMqkKMMh0Pate8laJJNQUHfL
         rT0Lh2ee8XSXKP2C9uM46EciYjzGKySe3B4KzqUt04h3OFjvBPzFz0ZxfNQykOLPlMrS
         GQWSyqeiP8m65/nSh3p6XGIgTt76WYoDM4+8Jjkm1WlOURsou8vZs+2598EAhnIIdFSG
         8OYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fPRMg868cN2PY0ANUcIYR+D8aHmErPlQ6zfaWMNNBrM=;
        b=ORB/K/ht030aRgq0U27kYtR8wdm5/rA4skXEbB1EE7hNQ2qUvXP1vCqWnuTl6QO1h2
         eI2VQuoH7fx5XK+/+/m0Euluz525hPZR2xwBnk65qSC2JXohYjIOOY38sbB3pmX7Wkz5
         NmXtKbIC6vCBKwKfPQKM6rYhzGldoIn1XKNJrkTpqX7wsC8skfRivL1Op3oXZZWAHhW/
         K35bG8fEMTPwlus7TkQsBBBqw97rFnF5plge7LmI9xNVFxNmiNG7Btw1D0NyOPVwZTfb
         VWKUJgAuqVmIi/abErzZqEOsN535mVF6k11I+gmLsAd0XgCXv0FadZESVbOH2tBjS0ey
         GIxg==
X-Gm-Message-State: AIkVDXIStKwsrGwsg8a0ve8ugHOvjWFAhy/lXHfPjJ0ojb9HIdHePXm8f6uvtnz/j++WR346tMemUacyaQ+rbFOR
X-Received: by 10.200.44.217 with SMTP id 25mr28227273qtx.176.1482877091019;
 Tue, 27 Dec 2016 14:18:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Tue, 27 Dec 2016 14:18:10 -0800 (PST)
In-Reply-To: <xmqqa8bh6myb.fsf@gitster.mtv.corp.google.com>
References: <7E1C7387-4F37-423F-803D-3B5690B49D40@gmail.com>
 <20161227175013.12747-1-sbeller@google.com> <xmqqa8bh6myb.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Dec 2016 14:18:10 -0800
Message-ID: <CAGZ79kbbm=g9DTUWY=xVZPUi4ajCMgKT63bGXJSpP2t0RDH0Ew@mail.gmail.com>
Subject: Re: [PATCH] worktree: initialize return value for submodule_uses_worktrees
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 27, 2016 at 2:12 PM, Junio C Hamano <gitster@pobox.com> wrote:

>
> or even make it a helper function "is_empty_directory(const char *)".

This sounds like the way to go IMHO.

> I'm planning to disappear until early next
> year

Safe travels!
I assume there is no interim maintainer for such a short
period of time (which also is not as busy).

Thanks,
Stefan
