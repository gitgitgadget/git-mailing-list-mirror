Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F10C1F404
	for <e@80x24.org>; Sat, 10 Feb 2018 01:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeBJBI3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 20:08:29 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45656 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbeBJBI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 20:08:28 -0500
Received: by mail-wr0-f195.google.com with SMTP id h9so9919795wre.12
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 17:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FiJgZWxUQGZFb3Xw5rh7LMVg06Ze4JQAHW9mrM82iFw=;
        b=F3ld3VMr48cKMZBfEWbMIM/dnmKi4iMu88S1KbuRM3KhjkheQdoDG9KBFv6tx/mi7n
         2mlRpw6aMxdIlu/kLU0hqq11Ak+i69w5xRkxHWFlWytuI/ohx2/waAdoZF0rrq9XrxH6
         p8X0MiXlpulm62AJrbji3O5wMAVN/Wl/++pjPHWwg3rqhRpxAGOKLvfhM3iXw79cwl7z
         EN6zIYyARyzelegofqvrwGgIEVnG/reHg49PYd+JHoR/gXqZsLxD3Vv2K90QqfTEk+e5
         gLtUXYlqbTlNg4vr57ZPqoKq67KtYzf7Tlc+vY/N6jTLzdbqlcHN9/RsIqxKxlp3LlQQ
         FdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FiJgZWxUQGZFb3Xw5rh7LMVg06Ze4JQAHW9mrM82iFw=;
        b=BZYlTLwfe7X+RbY15ItdbyR6kPK/PoAzdrU09531rl0HMaf6lf+n/UQTgXz2tqMOv/
         mhmMGTxCVbl+nn8JBHD4KBpN3tL5h9DR8s1eR6LsJW2Y6jPxtL3dbSUX/JOn8fsBetsC
         jbud/QxVRWLV8me4QudCIJc+tMe4f8yzrWq1uKWlEf7GlM98cvZrpn42vSGZ4bTOCr54
         DV4ACu/w7o74RmhJN7AuN1e/A09dyA5fjIkqEwaG741JNw3Cfh/7hC5gWpdJjrudDKFT
         Oe+KNaal32dkx80mQ2DGdLwtjNE0oGKPd2trFmOmnn+2SDPL+7WK5pJ2dhhJT1UWKZWE
         JGIg==
X-Gm-Message-State: APf1xPA2MkMI7P3lA+E8Z+ApDfTxDksoguMTbq6Tz8xbUa4dGHeOjd4Y
        tYUsxwENesouqrxrnvu9+ts=
X-Google-Smtp-Source: AH8x226eMpFqe0iVklrg6R+foUsjYpOnF1H+wftcsgaQJUC1xd85ZlWkbPWMYxrmM4G80gz5nHzfuQ==
X-Received: by 10.223.171.67 with SMTP id r3mr3541659wrc.80.1518224906817;
        Fri, 09 Feb 2018 17:08:26 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 1sm5156218wru.19.2018.02.09.17.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 17:08:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Leo Gaspard <leo@gaspard.io>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>
Subject: Re: Fetch-hooks
References: <5898be69-4211-d441-494d-93477179cf0e@gaspard.io>
        <87inb8mn0w.fsf@evledraar.gmail.com>
        <c8d1eb4d-c3d2-5834-a46b-931e825315aa@gaspard.io>
        <20180208153040.GA5180@kitenet.net>
        <871af155-a159-2a29-2e48-74e7a98b60d4@gaspard.io>
        <87bmgzmbsk.fsf@evledraar.gmail.com>
        <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
        <87po5dbz1a.fsf@evledraar.gmail.com>
        <20180209223011.GA24578@sigill.intra.peff.net>
        <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io>
        <20180210001317.GA26856@sigill.intra.peff.net>
        <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io>
Date:   Fri, 09 Feb 2018 17:08:25 -0800
In-Reply-To: <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io> (Leo Gaspard's
        message of "Sat, 10 Feb 2018 01:37:20 +0100")
Message-ID: <xmqqvaf5tzw6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Leo Gaspard <leo@gaspard.io> writes:

> On 02/10/2018 01:13 AM, Jeff King wrote:
>> On Sat, Feb 10, 2018 at 12:49:31AM +0100, Leo Gaspard wrote:
>>> So the changes that are required are:
>>>  * Adding a notification-only post-fetch hook

Maybe I missed a very early part of the discussion, but why does
this even need a hook?  There are some numbers [*1*] of classes of
valid reasons we may want to have hooks triggered by operations, but
"always do something locally after doing something else locally,
regardless of the outcome of that something else" feels like the
most typical anti-pattern that we do not want a hook for.  If you
are doing "git fetch" (or "git pull"), you already know you are
doing that and you donot need a notification.  You just create a
workflow specific script that calls fetch or pull, followed by
whatever you want to do and use that, instead of doing "git pull",
and that is not any extra work than writing a hook and installing
it.

Unlike something like post-receive, which happens on the remote side
where you may not even have an interactive access to, in response to
the operation you locally do (i.e. "git push"), fetching and then
doing something else in a repository you fetch into has no reason to
be done as a hook.

[Footnote]

*1* I think the number was 5 when I last counted/enumerated, but
    don't quote me on that ;-)
