Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D15A1F404
	for <e@80x24.org>; Thu, 22 Mar 2018 18:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeCVSCZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 14:02:25 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34123 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeCVSCX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 14:02:23 -0400
Received: by mail-oi0-f48.google.com with SMTP id u141-v6so8142707oif.1
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZR3Dggqu9n9+AjLy5WE/CVwDZE2p76vhsqnE3MtCxps=;
        b=AxdbqQOnejXXlfVH+9w/qHR4Z6lCG9EYwFufUxh1VeBL2X5bd2LRkNmSbg51SB6Lss
         JgSvNpFfS9rofHqxfbNadiStkWPeHXZtQ7Dx3yuddpXaGy1kgjE5iunv2XVSK0ngKh6C
         GUIwGZ2oFb4bgwFnAnspfWSObCKiAaXln8LzBfmtP/7CJPueTXsjhTzQLe2mpT/7aA3x
         /NtdsqSKaQBa7gm/vnGOUeBs70b3UyJkwKm1+MS1whxl1bSJgfCl5g2UF+yiqkdVmiqY
         IttuXZEv+KCcDYkHt2hfiXn3gb3OUKMbUuP2GPI63t6CuVcIzdHxiy4p8Gt/EmXgF5u1
         kpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZR3Dggqu9n9+AjLy5WE/CVwDZE2p76vhsqnE3MtCxps=;
        b=EDiukjGw8bJ74At4pCsvJHACOYD33+EwEhkzAmGkhO0LJvPyOhAMJIcYRBM8Etnzen
         BMlW7Ya6iF5FASUQJVg2drJ91SWaJd9Q8hT4sTl8yvl2oJ7XgeMoeRIv0upbjZ4WQ48i
         LJSyZqeHpX3083NCch/EMAsCK9gNWZeNlCuyO4oi7kIK/3M55W0QLE2kJz3pUfZy4/v5
         l3p6Tkeb7UMHODQC4PFcuhfNtz1QGk8XiFzAvJr5RR1aExoy/LgZ/HcEmFgjKkTHTu3K
         DoRGvjWtcjrd8UYiEdCAvorEuMyKTSJWGgh7xprTv8mvBsiwXKxd91h57AZJNuUex2Te
         +8AA==
X-Gm-Message-State: AElRT7GYeROizaocKqk5JS5afYa5MbCPXRLuikoGsUxMbyxVQT6fXJdu
        QexgiA7baLG3WaQi2NxBwGnxwQfmr1JGj2q8RWE=
X-Google-Smtp-Source: AG47ELsr11IhpWP7vqn5HrKZpdRJQjKQhXgcr0dehy3K6QInzga/UGVodUgqEs+IQhtgwg4k/sBcc1mQDXue3c0nacM=
X-Received: by 10.202.64.85 with SMTP id n82mr15149454oia.30.1521741742497;
 Thu, 22 Mar 2018 11:02:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Thu, 22 Mar 2018 11:01:51 -0700 (PDT)
In-Reply-To: <xmqqtvt8kn92.fsf@gitster-ct.c.googlers.com>
References: <20180321193039.19779-1-pclouds@gmail.com> <xmqqd0zxno0j.fsf@gitster-ct.c.googlers.com>
 <CACsJy8CWWSixQpXDh+q108j4xF8vpm5gsj2u3gJEgW=2bnXQHA@mail.gmail.com>
 <xmqqy3ikkpba.fsf@gitster-ct.c.googlers.com> <20180322173553.GA20984@duynguyen.home>
 <xmqqtvt8kn92.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 22 Mar 2018 19:01:51 +0100
Message-ID: <CACsJy8AbviwGqjWoq_SYDpLkM4PALcZOP432HBe0S1D=m16DLg@mail.gmail.com>
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

GIt has taught my fingers some bad habit.

>
> I imagined that you'd keep an associative shell array (we are not
> constrained by POSIX here) that can be used like so
>
>         elif test -n "${__git_main_with_parseopt_helper[$command]}"; then
>

Great. We could even kill two existing _git_xxx functions because they
are too simple they could be replaced with this new code. I'll send
out a series later.
-- 
Duy
