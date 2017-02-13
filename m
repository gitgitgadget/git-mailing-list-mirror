Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAACD1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 19:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbdBMTdV (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 14:33:21 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36055 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbdBMTdU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 14:33:20 -0500
Received: by mail-ot0-f194.google.com with SMTP id 36so13192458otx.3
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 11:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=A7OEWi/s9ogQQUUh1eU1702kySPu6N5bGjwqPGQzz3w=;
        b=fjpqck4xhcm0SA0TWkc+aHEeVM1BZ7rzw6ZW3UKYI2c4FA3gE+1M5u48eopbY7kLQP
         aTQXP+Zxel9QPT7TzPmLkA61VBq6PO85x1suVxbusMybL4oOSo1wqbeNF9zPurgXeM6/
         828VWNfoJVdqk0ZSQUUyMlC7xPiM2Q47lwZoE60KijxOhYSc/ZA3YxSAX8i3gIULsTRx
         QzkiSPFcSqaJxlw9yXArh7jRS3G2TSNoNo3IVlJh8J6Zjnpo2MDyJfc5EF8NuzrPY6k8
         5byYpwE6l+XunPHRlaXDTFfvVTsIURU0Le5HMQMMEqb+Kc8vBfT9+KuicRWnZFFR34B4
         oBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=A7OEWi/s9ogQQUUh1eU1702kySPu6N5bGjwqPGQzz3w=;
        b=cwDzB4bnRu6ZTGqoQJWQsH+XuV+6C0jLYT5zTx7ZK4a/XGA9+MSnwD5K7i48o4gYUg
         vamjmdUp9/hbDkio1+uBw/Bzd0xT4cp5bLDZqTJXecAwqB6ZKzii9M+RaUIMYbBC5gNz
         H3MSFYSihfI8AmC0U/lj9vwQVT2ff7L0UCQsdtkwvDgMILc9qHGu0lUXrFM2bX34d8pC
         5mlRyYmWmSzbBZLC1MIwcrY0vyxg/zdIQCEufO6Bl79RfIoB9D8RCWMU1DbE0+X76AIP
         hXdI5tytu2d3pOe+n3f2uKi8bagX6lLctX3v71O253Iwy4vEzojt/O6BOZfNcYQdU/wT
         Jb5w==
X-Gm-Message-State: AMke39kkvsK80a5sEUpXSB9sGOFg1jXqZzwXpVHndNwV7Ua0ERzimqPJIbiXJ47xGtboX7gtGO/unK2eiGWTlg==
X-Received: by 10.157.41.204 with SMTP id g12mr12520001otd.165.1487014398843;
 Mon, 13 Feb 2017 11:33:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.63.13 with HTTP; Mon, 13 Feb 2017 11:33:18 -0800 (PST)
In-Reply-To: <xmqq1sv2fq6m.fsf@gitster.mtv.corp.google.com>
References: <alpine.LFD.2.20.1702110943460.31350@i7.lan> <CA+55aFw2S14a4_4YK0b6PNK4TH_AUo_+2JN+PTyBTufNeB5t6A@mail.gmail.com>
 <xmqq1sv2fq6m.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Feb 2017 11:33:18 -0800
X-Google-Sender-Auth: YUjTIOBgg5FlNMSg-Ve_kXA225c
Message-ID: <CA+55aFy-vvOBu5Y4KDeteUyK-7U7yTa1HoqHo+hME1=8bq7Xhw@mail.gmail.com>
Subject: Re: [RFC PATCH] show decorations at the end of the line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 12:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> An obvious downside is that people (against all recommendations) are
> likely to have written a loose script expecting the --oneline format
> is cast in stone.

Actually, I don't believe that is the case wrt decorations.

Why?

If you script the --oneline format and parse the output, you won't
have any decorations at all unless you are crazy (you can set
"log.decorations=true", but that will truly screw up any scripting).

And if you actually want decorations, and you're parsing them, you are
*not* going to script it with "--oneline --decorations", because the
end result is basically impossible to parse already (because it's
ambiguous - think about parentheses in the commit message).

So if you actually want decorations for parsing, you'd do something like

   git log --pretty="%h '%D' %s"

which is at least parseable (because now the decoration separator is
unconditional.

Yeah, I guess you could use "--decorations --color=always" and then
use the color codes to parse the decorations, but that's so
complicated as to be unrealistic.

And I considered adding a format string explanation, something along
the lines of

 - oneline used to mean "--pretty=%h%d %s", now it means "%h %s%d" instead

but that's actually not true. The "oneline" format was much more
complex than that, in that it has special rules for "-g", and it has
all those colorization ones too.

           Linus
