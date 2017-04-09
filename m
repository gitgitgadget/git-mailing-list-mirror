Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9E2920966
	for <e@80x24.org>; Sun,  9 Apr 2017 11:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbdDILk2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Apr 2017 07:40:28 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:33502 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbdDILk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2017 07:40:27 -0400
Received: by mail-io0-f182.google.com with SMTP id t68so36389003iof.0
        for <git@vger.kernel.org>; Sun, 09 Apr 2017 04:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0NRja79khP0YlQtfp6pyHW0aPI67AdCbXjy06ylkjBw=;
        b=Tqz8mwEQrQeUR5rsYwhO6RP8r6+1TgdrDlvW+oZ/Xktqb1ZIA6eUJ9VJs2V8/shAyk
         rPQ+cyekbjlrb2qF5Ar39xaZ4y2TuTP/Dq8bbQKPQdGCWTwry6NoIjzsp4UDqlAFBM+O
         F/zth1OF0Yqs+1VGwhgGbbwrq/oe0OrVefeTNHhPHDOwdfcHfJwX4MEzC8mSOd/buMik
         +9ovGwy0s28nRNpcSQ8wK5rOMcfIVtj/XWcv+S2lhZbD8j6Kdnpv90o+nvi/VhJwFGq8
         xqXxxvfLvuqqqowRXMdButmb41bs5iAsPttdsM0gu/Zfhh/ofnyRinWW4lz4vt2INg0A
         SC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0NRja79khP0YlQtfp6pyHW0aPI67AdCbXjy06ylkjBw=;
        b=IecOrotGKBM5zNFlK9rYvqHzXdxZ0B7C/QtYPN8N2a3gVjncqVsPG8vANh7BUItBTb
         lD7voAf/Y/Dzn4ndEjG+uBPKTZHVBMe8Sy2w49cRi1rJve994tDazdjT5e7f4LBhJfnC
         dfBbnQJTk7dpu0moprSx2fC/wGRjcH1ZDJxu0jEnYFE679l65TT8qO6X26fmmHc3HkNJ
         8HGCRA/LL44BYgPLj0DydcadyPEEHV1lTPHucLMz5gzHpp7TWdCL/fK7wnRlzh7XEVtk
         1vjHqw2jrMp1hV5BCORbLBT9xCgNKoCjpEaEqMXONtJsR4sMrI2bBjIIOTY6FfdCW0WG
         ZXgw==
X-Gm-Message-State: AFeK/H1+bFv0I14D2cg6V6/W1kMagSZPrOYhU+SXJfUFO4p+XVPcPK6hEncsAZSRCEJAykOvF9WABSucfgWdiw==
X-Received: by 10.107.46.229 with SMTP id u98mr34463089iou.147.1491738026352;
 Sun, 09 Apr 2017 04:40:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sun, 9 Apr 2017 04:40:05 -0700 (PDT)
In-Reply-To: <20170409095511.d7wewvggvirnhsbr@ruderich.org>
References: <487622bf-00d0-e4fc-4a74-08e18d59336a@gmail.com>
 <20170408114100.13743-1-avarab@gmail.com> <20170409095511.d7wewvggvirnhsbr@ruderich.org>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 9 Apr 2017 13:40:05 +0200
Message-ID: <CACBZZX57eLtKjWPuG1gx=s_+ZPjCvnrUCa2xwZbGgkVUkrHwXg@mail.gmail.com>
Subject: Re: [PATCH] push: document & test --force-with-lease with multiple remotes
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 9, 2017 at 11:55 AM, Simon Ruderich <simon@ruderich.org> wrote:
> Hello,
>
> I like the documentation update and test.
>
> On Sat, Apr 08, 2017 at 11:41:00AM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> [snip]
>>
>> ++
>> +Now when the background process runs `git fetch origin` the references
>> +on `origin-push` won't be updated, and thus commands like:
>> ++
>> +     git push --force-with-lease origin
>
> I think this should be origin-push.

Thanks! Well spotted. Will fix in v2 which I'll hold off on sending
for now pending more comments.

> Regards
> Simon
> --
> + privacy is necessary
> + using gnupg http://gnupg.org
> + public key id: 0x92FEFDB7E44C32F9
