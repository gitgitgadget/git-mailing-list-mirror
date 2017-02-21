Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51386201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 21:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbdBUVrl (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 16:47:41 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35291 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbdBUVrk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 16:47:40 -0500
Received: by mail-pg0-f66.google.com with SMTP id 1so12929299pgz.2
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 13:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5qB8B7ehR57unVF0zlKLpXBmFZbqhgwCtLy4KCv1Jiw=;
        b=YtOWuDJrdxYcvkJz6N1yDWS9U+WplpweRpfGUwMl2jwN1h7QEHiQ5ges8D5vz6OToL
         KajS/DEvV8C3ovF86ZrdylbgKIZS1tDf+yV34Nj7L1l0enONDaj0QQOgSsCQu/JG+MWG
         VZ1lbah/lf/gsDmu2/hcqI6zOwyVCJxaKHiNYBvydbRXF/VCUQ6YuYKAhZxYLm8cDF0L
         oPESiIcoHQbm+6u6Ic/y47Mdk1EMTS3YC4vlwQ1ep6RMAr8BQG5/ZwQQwqg+6cXQkUCW
         +SS6se1vgm3JeG0uCeu506/I/217LEZBi5zcIB4mh3X9bmY1BSaY5P38sQFF1aACK87a
         iajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5qB8B7ehR57unVF0zlKLpXBmFZbqhgwCtLy4KCv1Jiw=;
        b=j4Am9IYu7mwJ8xyeZu1k5uBuLFf5IU9Oz/p0ittHTGeSmtMoagp8QUxrM+dz5vWwUH
         s2JtoG16V3eu+a8QXNlW5uiPPaAGEpjT5tP9BOH/F2B2qFhb27Id+RgtmD84AZ1TUAUa
         OK9/jE7iJUzrzysoRyu+Whnol/ogG3LJcVByVciusIkt2p4ECSlaCF8L2UczxwlkeDTt
         IeHlNb8DpHyXzmAX4qvAYF1qqjm8fZTq/1aAg/pcfM8qh/gFX1WiWZYcdV7WJI83pLF/
         fM1wawYGHifWO0QAMHY2VTOh9hTYtBXxQ3U4UXUnra9ykP+D5vLMsxr/Kq8W9KlNu3fm
         +p+A==
X-Gm-Message-State: AMke39n6rypbM+4sy1RWEmhS3yFzHcCxndnS8hZkSUzqN+XMh4p8OklRw7n6giDzYwNkMg==
X-Received: by 10.99.146.70 with SMTP id s6mr7284035pgn.109.1487713659198;
        Tue, 21 Feb 2017 13:47:39 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d997:8b5d:f579:2a90])
        by smtp.gmail.com with ESMTPSA id z74sm42730632pfd.70.2017.02.21.13.47.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 13:47:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] show decorations at the end of the line
References: <xmqq7f4tdcua.fsf@gitster.mtv.corp.google.com>
        <xmqqr330779h.fsf@gitster.mtv.corp.google.com>
        <20170215002901.gtzegvhyy7d6cvrb@sigill.intra.peff.net>
        <xmqqefywnk5a.fsf@gitster.mtv.corp.google.com>
        <CA+55aFw3ZRtgsLGW-TFqpq-3uCw55L42p7cF=Q-73qM_VPuYsQ@mail.gmail.com>
        <CA+P7+xqtPwzt3J6O05TP=E_hh-ko97adn+__Zmc0DNSDqEnEHw@mail.gmail.com>
        <20170220004648.c2zz6bm2hylvep6x@sigill.intra.peff.net>
        <CA+55aFwdUxCvmi28T3yn1K4rqn2bZmJBdTRr7tSbMa-g5izHbw@mail.gmail.com>
        <xmqqpoibfgo3.fsf@gitster.mtv.corp.google.com>
        <CA+55aFwT2HUBzZO8Gpt9tHoJtdRxv9oe3TDoSH5jcEOixRNBXg@mail.gmail.com>
        <20170221210808.3ryri33ve7w7csdp@sigill.intra.peff.net>
Date:   Tue, 21 Feb 2017 13:47:37 -0800
In-Reply-To: <20170221210808.3ryri33ve7w7csdp@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 21 Feb 2017 16:08:08 -0500")
Message-ID: <xmqq8tozfc7a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The for-each-ref formatting code has %(if), but it's not unified with
> the commit-format ones.
>
> So the best I could come up with is:
>
>   git config pretty.twoline '%C(auto)%h %s%C(auto)%+d'
>   git log --format=twoline
>
> which looks like:
>
>   80ba04ed9 Merge branch 'svn-escape-backslash' of git://bogomips.org/git-svn
>    (origin/master, origin/HEAD)
>   20769079d Git 2.12-rc2
>    (tag: v2.12.0-rc2)
>   076c05393 Hopefully the final batch of mini-topics before the final
>   c5b22b819 Merge branch 'jk/tempfile-ferror-fclose-confusion'
>   62fef5c56 Merge branch 'dp/submodule-doc-markup-fix'
>   1f73ff080 Merge branch 'jk/reset-to-break-a-commit-doc-updated'

Yeah, I had a similar thought to use something around "%n%-d", but

 $ git log --format='%h%n%-d%C(auto) %s %C(auto)'

is not it.

I guess we could pile on another hack to make the sign between % and
the format specifier cumulative and then "%n%-+d" may do what we
want, but we need a true %(if)...%(then)...%(else)...%(end) support
if we really want to do this thing properly.
