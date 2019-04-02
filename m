Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC16220248
	for <e@80x24.org>; Tue,  2 Apr 2019 00:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfDBAid (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 20:38:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53069 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfDBAic (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 20:38:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so1307047wma.2
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 17:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZXCPzmPWgVtDIAXedmI9peuL4qMPFUCBqJwuNTJGnsQ=;
        b=cB+iJi3ic4mehIVHSk42EkNYBX6tyqWh5/muoueth0ypbrsg1UWkYkGHLWDlCdl3UA
         TQYJ9sF6mJxonyJC1FcpU+48Ce49vvayutP/sUPiwzJgFjD1fU9DGu1KhTQPp86KqGHT
         9Zm1ETxlY0VhpCOX0Li2BVFWS8U0ohvk1IOc2ICSEMSY+0hW83WLOmRwfDT1sfJfdPYN
         DEO+mNO+dbLe2GfwHGLKWFRQAjrnJGVAwM2nA382fFlYPxeRZHWVQUcSd7knF/dZYs8u
         FWQMoq3U2ITXo1/GhFbNTZSw6X77ION9ArzRPriGRymq0Z173FowAy9IfW3DE2qGL8nF
         DDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZXCPzmPWgVtDIAXedmI9peuL4qMPFUCBqJwuNTJGnsQ=;
        b=OYI4svb3x6W7TZ2xPRuZ+xbuQiUM4gphdLn/FOyIl9u+NcAs27QkTUnm2JNwIar9xY
         ia057B+RogZIgnLySZMCo7zM/vPHAOgkH8i1lhLsNLpuxG7g5Fm5cteNqu983vbOhRSN
         pi7//q5yiM/sFuLKpg1cuLX6KmBYuYJuk7x5BgiWOPsEFENpN0LS/UX84DM9+5F8P1fm
         XSc5wQY+BpKDgQNsq7kcgQf/6ZkP3wS5dDWqSBG9Sa9Tecijz1EqKIjf1xJOTUKWnZLc
         yNyn1H91YYSu4diDSTu67fzFm/zLYnYy8eA2UkcEJEmXJe8u6h9Nf54nLrtPUma/z/BY
         AY+g==
X-Gm-Message-State: APjAAAVQ5Xe4wqjQDEPN+DDEYYTTQURpoq6tkzX8VyFGiWnOduilP6yc
        LR9Da8+FnehfbpFlQEUEeUI=
X-Google-Smtp-Source: APXvYqzBZIh5ujT3I23/8tkYjknjyujjC3g5JLjAIgVhvG+p/FNLWijBziuRbAZFlZFNg5jgh/swmw==
X-Received: by 2002:a1c:9d4c:: with SMTP id g73mr1438582wme.48.1554165510673;
        Mon, 01 Apr 2019 17:38:30 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id k9sm16861644wru.55.2019.04.01.17.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 17:38:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chanseok Oh <chanseok@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug] git log - reports wrong date and time
References: <CAP5K-1YJN9jt_6yEbLs=ET6M2tRLMMoio65GJMsJy69Y+LCn1g@mail.gmail.com>
Date:   Tue, 02 Apr 2019 09:38:29 +0900
In-Reply-To: <CAP5K-1YJN9jt_6yEbLs=ET6M2tRLMMoio65GJMsJy69Y+LCn1g@mail.gmail.com>
        (Chanseok Oh's message of "Mon, 1 Apr 2019 18:31:10 -0400")
Message-ID: <xmqq7ecdutq2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chanseok Oh <chanseok@google.com> writes:

> BROKEN: anything other than UTC reports wrong date.
>
>     $ TZ=KST git log '--date=format-local:%Y%m%d %H%M%S %z (%Z)'
> --format=%cd -n1
>     20190401 210250 +0000 (KST)

I think you are probably on a system where timezones can be given
only with a more modern and unambiguous style and not in the
potentially ambiguous abbreviated form.  Here is one experiment to
show what I mean:

    $ TZ=KST date
    Tue Apr  2 00:29:51 KST 2019
    $ TZ=JST date
    Tue Apr  2 00:29:51 JST 2019
    $ TZ=Asia/Tokyo date
    Tue Apr  2 09:29:51 JST 2019

Two points to be learned from the above exercise are:

 - It is not limited to your copy of "git".  Even a system supplied
   command like "date" does not work with "JST" but it can grok
   Asia/Tokyo just fine ("JST" does not necessarily have to be
   "Japan standard time"; it could be Jamaican ;-)).

 - It is not limited to KST (is that Kabul standard time?  Khartoum?
   Kinshasa?).

Perhaps try TZ=Asia/Seoul or something?
