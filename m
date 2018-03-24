Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 219D81F404
	for <e@80x24.org>; Sat, 24 Mar 2018 13:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeCXNiv (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 09:38:51 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:40877 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeCXNiu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 09:38:50 -0400
Received: by mail-oi0-f52.google.com with SMTP id 1-v6so6859730oix.7
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zAFakm/UBgTYC5AOLxF4Kk6gUvomY+KFeYOPgJAEhw8=;
        b=lFZEkx+3IZ9hXB76Mp7ixy9ahjgZHFQCjA4sZ9zFCt2ReEDg4ctrghZBTWqPFD8LkT
         cdjCbm56sHTey43s66iYxYOlGnxOyjYG+xA0KJ8PkVgt0ILQ95S2LwlNxAmzy6WO7RTr
         XYNh1TdZBHB0gkUIKFNTfk7Jdfd8qfWos4rte5X0VQUSqeDRzDbsfb1wX3+2Y6Ozr7xO
         5OvPuTrtymwgb6qumq9PorqO7YHBSOt8OwSL42vKbPjt6E2mHxw799E3PFz7ekUgNhVY
         +sQ/SV7r6OZKqS90i0NWjVXQo9sAHR+S04PSjywkIkq0/NPS10Sqp5GDVzixSzQibeiC
         N+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zAFakm/UBgTYC5AOLxF4Kk6gUvomY+KFeYOPgJAEhw8=;
        b=BrmP8c89d61RRNcgkFgi9Sl+cSViO1Dyz6NAuDhx6dA5KfesPuWdiePU2kauolsHsP
         W223G/lWl8eesNL2aFxPxV8GeFPyFcKsWxmfSSx0eB7ZvIPmYpdZJhuTFLABxv746IuW
         8GVe+lbUKSj1AMCr4QbDTATzMc/hSuxzWK9QfGHEhFRQ4Q9dY3v727fek0DrJ+Z8xw1Y
         zB97PqajJl0BsIUg9CgmdPQh0piraEhMJM3VgOReIzDmtFtq5/weJhufY4N9Na+IT0B7
         dTzQVM8vD2nKcI09JhKicZTV/1CSVrYj0KJkT21rAXqkHU3RmRjQ7pODqLLoywX8WE3B
         GTkg==
X-Gm-Message-State: AElRT7FGOlMStCurz16ianiRDntaEhdPKTorfb2v6wlmFDv2JShV7I3H
        kxNQc/PkDYYxN/HCJPceu9xQm6OAtDdNuxSTWc4=
X-Google-Smtp-Source: AG47ELuyX0Cfj9uG438aVpuSASmKuzms2W/t/mwPUNX9ez3tcAzGJrz2eBbyf3UuIiQPSyGNRZWIN8nG0lWCB4iTUEo=
X-Received: by 10.202.81.200 with SMTP id f191mr19035497oib.32.1521898729760;
 Sat, 24 Mar 2018 06:38:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Sat, 24 Mar 2018 06:38:19 -0700 (PDT)
In-Reply-To: <xmqqtvt8kn92.fsf@gitster-ct.c.googlers.com>
References: <20180321193039.19779-1-pclouds@gmail.com> <xmqqd0zxno0j.fsf@gitster-ct.c.googlers.com>
 <CACsJy8CWWSixQpXDh+q108j4xF8vpm5gsj2u3gJEgW=2bnXQHA@mail.gmail.com>
 <xmqqy3ikkpba.fsf@gitster-ct.c.googlers.com> <20180322173553.GA20984@duynguyen.home>
 <xmqqtvt8kn92.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 24 Mar 2018 14:38:19 +0100
Message-ID: <CACsJy8CxdGXUcqP5r2u6kcjrsftO+-CrNVaFy5wv85Mm3F8pPg@mail.gmail.com>
Subject: Re: [PATCH] completion: add option completion for most builtin commands
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 22, 2018 at 6:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> +__git_main_with_parseopt_helper='
>> +     blame cat-file check-attr check-ignore
>> +     check-mailmap checkout-index column count-objects fast-export
>> +     hash-object index-pack interpret-trailers merge-file mktree
>> +     pack-objects pack-refs prune prune-packed read-tree repack
>> +     send-pack show-ref stripspace symbolic-ref update-index
>> +     update-ref verify-commit verify-tag write-tree
>> +'
>> +__git_complete_command() {
>> +     local command="$1"
>> +     local completion_func="_git_${command//-/_}"
>> +     if declare -f $completion_func >/dev/null 2>/dev/null; then
>> +             $completion_func
>> +     elif echo $__git_main_with_parseopt_helper | git grep -w "$command" >/dev/null; then
>
> "git grep"???
>
> I imagined that you'd keep an associative shell array (we are not
> constrained by POSIX here) that can be used like so
>
>         elif test -n "${__git_main_with_parseopt_helper[$command]}"; then

Nope. We are not constrained by POSIX, but MacOS still runs the
ancient bash 3.x while associative arrays are in 4.x
-- 
Duy
