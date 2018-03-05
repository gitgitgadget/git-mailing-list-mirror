Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85EB11F404
	for <e@80x24.org>; Mon,  5 Mar 2018 18:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbeCES6j (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 13:58:39 -0500
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35574 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeCES6i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 13:58:38 -0500
Received: by mail-qk0-f175.google.com with SMTP id s188so21885854qkb.2
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 10:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=5D12Mb9cujde/a7bSUUPN/1xbBPR3Gcp4JdwTLXXLas=;
        b=ewyMW82Kb4LBZwaPaZzkFO4a4TgWoRvoixAG715BFN8fk3B3QdqJChRoG+dPbLMnUb
         fMRqWlynlcY+C+VEgsjgNf387xQFzZvlFBx/utrUwgXiDf0GShl+MTnTBGgrif6qfgxo
         j7x+zRdJSdr5w35UYwDNg2Cb5myBK7BH2qPy726xhJ/P6ZbSH3RvswMmoWVMNUDKZ4uO
         S25jcg8MCVygvSxHhjoTCca8yLopB1EaMnV/d4IWkeZKL9N6F1FH8h6fCNl+w9qSpEYh
         VE5aYN0AuFqKim5VMNfJP2hhHVlOjwiexVXOG6M/Tz7FXLTFC0Tn5fDo9xWRl7/twsiP
         WMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=5D12Mb9cujde/a7bSUUPN/1xbBPR3Gcp4JdwTLXXLas=;
        b=O25RKyFz3UE3BhjkFAGM1ff/NwGHbfYppKl7r1aLJc4v6dP7ZTS4ORzTYBOTdyJNlB
         TQqMVErPlfGTNWP2BsHH4cUEzpwXDcOxzF5wINkaNjOdwFPt+/WYKC1h34wKbU0fcQmO
         KpZGGcjNDOsYJ19VpGDmJCr1R0orvl5M3ppBUYJUlZAwGe7vyRcP+BZS+MDxgC6nHmYe
         cDRoV36UkL09NDtRjZVTF+6Accr1AxCLMzUO9yznb3zujNdKHm1k2YisGs6u8X78Z5Qj
         H/+VE0F92BR0JwPqkmXL8JU9un01SjM4b6z1BzGXzMGr6Vct98Cq8yEGkXq5cqIkhBAA
         QbWA==
X-Gm-Message-State: AElRT7HC0HZStyD2L/RstNSinHGbxJK2eUgx2sGmTrpo1lOcjMnVGpN6
        pr6/SsH1ZmmsdZrM3gLD9TwoUtXrAH9/md0TwpI=
X-Google-Smtp-Source: AG47ELuWzCVBx6cFjl2lhyCz6TKgkiod0A6i52u4FcTJPWL3O4QE7awCanEAG49UXKPLhsOECAg1cQzuK2E7d94lGkI=
X-Received: by 10.55.32.2 with SMTP id g2mr23731577qkg.176.1520276317627; Mon,
 05 Mar 2018 10:58:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Mon, 5 Mar 2018 10:58:37 -0800 (PST)
In-Reply-To: <20180305182658.GC28067@aiede.svl.corp.google.com>
References: <176408fc-3645-66d3-2aa3-30ca3fa723e7@gmail.com>
 <20180302044409.GC238112@aiede.svl.corp.google.com> <xmqq606ee89v.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1803031721590.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180303182723.GA76934@aiede.svl.corp.google.com> <nycvar.QRO.7.76.6.1803051711210.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180305182658.GC28067@aiede.svl.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Mar 2018 13:58:37 -0500
X-Google-Sender-Auth: Ue8vEVWOaQ9zJhJcvcOeCOLI1Mo
Message-ID: <CAPig+cQa9B6OJwH6TB14JO8SQ2iVDdKXBBAtgz4wdtn2zRo-qw@mail.gmail.com>
Subject: Re: [RFC] Contributing to Git (on Windows)
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 5, 2018 at 1:26 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Johannes Schindelin wrote:
>> The Google gang (you & Junio included) uses Linux. Peff uses Linux. From
>> what I can see Duy, Eric and Jake use Linux. That covers already the most
>> active reviewers right there.
>
> We are not as uniform as it may seem.  The Google gang all uses Linux
> on workstations but some use Mac laptops as well.  We deal with user
> reports all the time from all three popular platforms.

And, Eric uses Mac, not Linux, though he does test his submissions on
Linux and BSD VM's.
