Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65EEB1F576
	for <e@80x24.org>; Sat, 10 Feb 2018 10:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbeBJKYR (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 05:24:17 -0500
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35294 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbeBJKYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 05:24:16 -0500
Received: by mail-oi0-f42.google.com with SMTP id e15so7924594oiy.2
        for <git@vger.kernel.org>; Sat, 10 Feb 2018 02:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Q5TMY1JiWP6K43GrcGWOUYtPHDgZD2bxxN9hSrD2aoc=;
        b=Q6imJfZkqyJ9wTzmkGxhCa2+Pb8zVIMhieSTcfHTI39TsgvtlyhPOA1Q+QLJgFBq+q
         /0ic36xFcg42LkFvQXk/LtN3Duvq3RjeTU18g/HBCiufy8Ps4A+Zdv+M8H+I21AAKZlw
         O+bhRQJ0EveK+f3dFcxNOV2lX9APfcwlkgOud+BWOJ0pNw6bSpWovCyfU0QnDGr+9pyx
         NkYsO61u0g1STMr2UHhgaCQPAL/VwvwptwHVn0tKnPtIdAO6y5QFGdgRHBWTxaWMCEZQ
         xnV8k1l0m98xG2JAtGqApj070VBp3U33WZ2mjMqj2wz4FQj/Pzo7xqbJ6CXh292+yyT9
         oLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Q5TMY1JiWP6K43GrcGWOUYtPHDgZD2bxxN9hSrD2aoc=;
        b=N/xKe+DlzAw0A4v/BH+zgYpPJBtovtxuq1xuDF/T9VXfmefqZi3+hlqiCr0ewRRTqL
         Bv/gTZw0h1EaH1L26NgRijWdWrY9UbfMac5P5d9vknc44Fj0/JAvIsPaG4msLJj0KceQ
         1TgYIgKQ3oXoRjFCWAEUZ2M/Y5oLEsRRw6eawXYtbalv+elSNPeKpXHF3telnEev82Cd
         Wixu5kwQzeDcaFkBI2noXRqmh5yTtOP+CKHf33fIbiVxfoAACebY3dtuMIIPobYqdhdV
         /x+6rlCMPYaYhN0DcJnDXxbLNgAvfhL5unSGhEB65vpb7JaB9KO8WG5baKBWRiVzqDqB
         3WPg==
X-Gm-Message-State: APf1xPBxgta+2cTazmIM9sMb+eYxp9lFDVzeKIDakOUO8SqUOD4oDx3s
        AVV+tlOIffIg+8DQw5XiPOLK3hPg93G20wm4w9Y=
X-Google-Smtp-Source: AH8x227OXwJKfzpm6ZcHyU7d273WTJTDkNcGPkfTzEIzzJvxga67Ifr3rfLBbtxeyqKcYFdkK8Ub06DQ8L+nQo1SoMo=
X-Received: by 10.202.177.136 with SMTP id a130mr3820297oif.252.1518258255866;
 Sat, 10 Feb 2018 02:24:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Sat, 10 Feb 2018 02:23:45 -0800 (PST)
In-Reply-To: <CAGZ79kauMhgP4Gjm=yVKSDGh0-WMSpNVCJRamfjnANyO5SWXTQ@mail.gmail.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-23-bmwill@google.com> <CAGZ79kauMhgP4Gjm=yVKSDGh0-WMSpNVCJRamfjnANyO5SWXTQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 10 Feb 2018 17:23:45 +0700
Message-ID: <CACsJy8DhLzkxAr7oaBfb22x-bOOPxXxsKKwo5WKJ8p=19BSezg@mail.gmail.com>
Subject: Re: [PATCH v3 22/35] upload-pack: support shallow requests
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 2:00 AM, Stefan Beller <sbeller@google.com> wrote:
>> +
>> +    deepen-relative
>> +       Requests that the semantics of the "deepen" command be changed
>> +       to indicate that the depth requested is relative to the clients
>> +       current shallow boundary, instead of relative to the remote
>> +       refs.
>> +
>> +    deepen-since <timestamp>
>> +       Requests that the shallow clone/fetch should be cut at a
>> +       specific time, instead of depth.  Internally it's equivalent of
>> +       doing "rev-list --max-age=<timestamp>". Cannot be used with
>> +       "deepen".
>> +
>> +    deepen-not <rev>
>> +       Requests that the shallow clone/fetch should be cut at a
>> +       specific revision specified by '<rev>', instead of a depth.
>> +       Internally it's equivalent of doing "rev-list --not <rev>".
>> +       Cannot be used with "deepen", but can be used with
>> +       "deepen-since".
>
> What happens if those are given in combination?

It should be described in the old protocol document or I did a bad job
documenting it. Some of these can be combined (I think it's AND logic
from rev-list point of view), with the exception of --depth which does
not use rev-list underneath and cannot be combined with the others.
-- 
Duy
