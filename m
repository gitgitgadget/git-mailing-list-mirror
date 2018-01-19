Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 736D41FAE2
	for <e@80x24.org>; Fri, 19 Jan 2018 00:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932874AbeASABh (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:01:37 -0500
Received: from mail-ot0-f175.google.com ([74.125.82.175]:44575 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932547AbeASABf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:01:35 -0500
Received: by mail-ot0-f175.google.com with SMTP id t20so12364287ote.11
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=my44hkNC1kQQVqyySVV6sEPDKadL/7So0HwWmSzJ4G8=;
        b=lSOi1hnUDRXsDg2HgCZekFDxco8beS/5uzTUJSg6tkUwz/02rX09GeJUQvbcwHYgE2
         4OL3ex2srwDtWMG1KVvMsi3vlg6P/jjCt3nAHTX0dMQ4SU00dbB+l1TXhia4VEQ07RVd
         F6knUcqcslO2zZZ4YLSiDwqLn00soEiON5F9H5IoLTv+8+9zX3Zq3+8gNZcb4Z6uD0jT
         LSiubwWlYklQW8SULG+LCYLfdrkQc6gshJhaHYHxbuHvjKaybnaf19XGGlxd82Nn9ACM
         6br7cU59sYhQ2t6zWHin/W6xPpFhIuDqQJHNm4A4wLWEU6/nEeAydTEAHRa4Ai9wkY1G
         4LqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=my44hkNC1kQQVqyySVV6sEPDKadL/7So0HwWmSzJ4G8=;
        b=ls4oyknCsKl/HP8rtGAPMNMW+iOc+boLV0B2z//3UavLxF6Au0BStcRQXubie0xTDg
         MmKxeuNHHwCD6MALDBTk0V/6k6o9Al1YYV3FCYLccxsoL27M5Q2f2azL08piLy0Y5dFo
         60psQ2RVUp+Xaf19KB4KIn9i1zUJzdt5ATjoYN8hLQX2Mn/GL2FM9sL/R0k+OCtqYAON
         K26XmTWs35VrHe5thE/Y3bMJIVndqV8NZx/x2sAitZE5jJFqwTBgH+Xvyv7oLwZ3bSxr
         hb47kRRMeisHU5Ou+J0ZNwEaxvwRAubaZ7sd1N5hlO0KkfcUc+WXz1Wb4i99ogpt4HtG
         3lmg==
X-Gm-Message-State: AKwxytdSR5qjcht0BBOmMm6xOFvsZf9p02a61ovTRjhIo73Iu9A7tKmP
        yunO6PbBke0MAUKZoEpzqxaNXhQTmbNr1wISw9s=
X-Google-Smtp-Source: ACJfBotO/5Zx67aowNKQmLFjgycI9OcOHFG65AvaousoDhmG0gbGxlsKq1sB93JlccPSgIMo9fEg1WJl5xiWPjV0RKo=
X-Received: by 10.157.45.198 with SMTP id g64mr4993970otb.226.1516320095075;
 Thu, 18 Jan 2018 16:01:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Thu, 18 Jan 2018 16:01:04 -0800 (PST)
In-Reply-To: <CAPig+cQLgs59JYxcmK30qY307ArwqJx6pNOo95Z39_jJ9+D6+g@mail.gmail.com>
References: <20180113132211.13350-1-pclouds@gmail.com> <20180118100546.32251-1-pclouds@gmail.com>
 <CAPig+cQLgs59JYxcmK30qY307ArwqJx6pNOo95Z39_jJ9+D6+g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 19 Jan 2018 07:01:04 +0700
Message-ID: <CACsJy8B5qrN8T1aai3y3nfEc5baqn2Xkk6vZozMp5Lh-mPZ0VQ@mail.gmail.com>
Subject: Re: [PATCH v2] diff: add --compact-summary option to complement --stat
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 1:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> @@ -188,6 +188,17 @@ and accumulating child directory counts in the parent directories:
>> +--compact-summary::
>> +       Output a condensed summary of extended header information in
>> +       front of the file name part of diffstat. This option is
>> +       ignored if --stat is not specified.
>
> Rather than ignoring this option if --stat is not specified, a
> different approach would be for --compact-summary to imply --stat.
>
> Also, per documentation:
>
>     --stat[=<width>[,<name-width>[,<count>]]]::
>
>     These parameters can also be set individually with `--stat-width=<width>`,
>     `--stat-name-width=<name-width>` and `--stat-count=<count>`.
>
> One wonders if "compact" could be another modifier recognized by --stat.
>
> (Genuine questions/observations; I haven't formed strong opinions either way.)

I left open an option to combine this with other --*stat like numstat
(or unlikely, dirstat). I haven't really thought about this. Yeah
perhaps putting this in --stat would be a better move.
--
Duy
