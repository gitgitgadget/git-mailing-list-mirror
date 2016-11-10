Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50E9920229
	for <e@80x24.org>; Thu, 10 Nov 2016 17:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964843AbcKJRMT (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 12:12:19 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34612 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934264AbcKJRMS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 12:12:18 -0500
Received: by mail-yw0-f193.google.com with SMTP id a10so1036245ywa.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 09:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S7ykque+PBPe6apmRExD3Rx87A5vfOkicKULFPbjKqo=;
        b=Dt/j0epD1mANs+uuzpCJK0nkxrVTLH9wVoy5CzrJnAIaqx89LeCwu2otQzU5kESH4l
         gFzxggki99GQJKbKOuonyf7fpzm04x+KuPrqsT/usVGqDOe30PfOulRYrWgO+DcShK7m
         ydMt+R9GE6jQWsu+lE0Q2jMOiM2qpmleMpmglS7gX2BJ6mDhT1cL6UHIzM3aYi/Q4lDC
         nSjbBICcmpVWWrhT1rbRxwOIyvOJcZeCdCIdxuK6VsnxEkRB90BBadAEd+tUtxOr4WY7
         AZbhGuC7lKZEXpWwBkpFOTdUyNIo/A9xOu4l5Hl08aYdLbtIiUVd8WdioTRfgA7dJYsx
         F17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S7ykque+PBPe6apmRExD3Rx87A5vfOkicKULFPbjKqo=;
        b=LCoyBImr7yIqYCASj31ZtajSGnsWunurmswun3/2IFxo4Ov9Zh0fRJKCh7hVEDVdbM
         qksSSZ+m5CyLpwhkBL7O70QYwOzdUNczMPBVWrSty0JTCOxUt3ooy0anSlWpMzYde+a8
         mtzn8mKru7yycMzWbER/rzq9d9pshHJ+JCyoEhzbXV3fpKf2d3E6q5zlB5lFuB+IrMqz
         VRWVjN+ZM8Hd8LT7oRdLW9QWwBlxcy9oNqYBQ/aX/aHr+OqVJ7plse823OxdFx2QXKCN
         fIduLbolTCLF+7hqZFbjbO2dbNOOcZsnwxINwHmxQ/XZmqqX55i12lw/17EgaJV/Xd03
         iKTQ==
X-Gm-Message-State: ABUngvdoLZ6eWOkPRASomjy2+cPxEBV406NZwyGaUKFxD2pcpZkYBI3qThw8B8IREwT+0jLP3IMNcPYaPxPo7w==
X-Received: by 10.129.70.198 with SMTP id t189mr6049658ywa.131.1478797937213;
 Thu, 10 Nov 2016 09:12:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Thu, 10 Nov 2016 09:11:46 -0800 (PST)
In-Reply-To: <CA+P7+xoAmYqi0OazZux+rooXW+D_N9L5s+2BzUyJJJXtmLZX-Q@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-2-Karthik.188@gmail.com>
 <CA+P7+xoAmYqi0OazZux+rooXW+D_N9L5s+2BzUyJJJXtmLZX-Q@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Thu, 10 Nov 2016 22:41:46 +0530
Message-ID: <CAOLa=ZS_V5SNSbiC_sT6E9rJMbxCMm=BRaoPL44xBNXAG2pgbA@mail.gmail.com>
Subject: Re: [PATCH v7 01/17] ref-filter: implement %(if), %(then), and
 %(else) atoms
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

On Wed, Nov 9, 2016 at 4:43 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Nov 8, 2016 at 12:11 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> +Some atoms like %(align) and %(if) always require a matching %(end).
>> +We call them "opening atoms" and sometimes denote them as %($open).
>> +
>> +When a scripting language specific quoting is in effect (i.e. one of
>> +`--shell`, `--perl`, `--python`, `--tcl` is used), except for opening
>> +atoms, replacement from every %(atom) is quoted when and only when it
>> +appears at the top-level (that is, when it appears outside
>> +%($open)...%(end)).
>> +
>> +When a scripting language specific quoting is in effect, everything
>> +between a top-level opening atom and its matching %(end) is evaluated
>> +according to the semantics of the opening atom and its result is
>> +quoted.
>> +
>>
>
> Nice, I like the explanation above.
>

All thanks to Eric, Junio, Christian, Matthieu and everyone else who
helped me phrase
these.

>>
>> +               }
>> +       } else if (!if_then_else->condition_satisfied)
>
> Minor nit. I'm not sure what standard we use here at Git, but
> traditionally, I prefer to see { } blocks on all sections even if only
> one of them needs it. (That is, only drop the braces when every
> section is one line.) It also looks weird with a comment since it
> appears as multiple lines to the reader. I think the braces improve
> readability.
>
> I don't know whether that's Git's code base standard or not, however.
> It's not really worth a re-roll unless something else would need to
> change.
>

I believe this is the syntax followed in Git, xdiff/xmerge.c:173 and so on.

You're comments are right on though.

-- 
Regards,
Karthik Nayak
