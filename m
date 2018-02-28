Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 559CC1F404
	for <e@80x24.org>; Wed, 28 Feb 2018 21:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934953AbeB1VUw (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 16:20:52 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:46849 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933074AbeB1VUu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 16:20:50 -0500
Received: by mail-qk0-f172.google.com with SMTP id 130so4884080qkd.13
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 13:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AvrFlLkarRN0Gd+cnXDbWYmr6+ylKLE26Er6/oCH96o=;
        b=KdD62N32XP2tKlCgq2DXOW2mCgbPSKL8+3E/3SX25ORWhEQ890jCtevOQzGJDqGMBb
         kt2bU+6kZNRQ62FZ0jxWlOgM03GjuM1l/+7dbFkqGIjVv8Njx5uWzLqLW+DGqe61zQi9
         95KuUq3ahNoDlJePQSM8l/HhMIVEqlVxQ8WrbH8HFu2d0W8BVGNQTZd3TwjpSNho7usC
         3ERYHX1s1ZALx7cdGiltp9LXMQ2CjoE9IzTftxssT5g35mLKLGgQwtnyhWP+KLkVHmgl
         gSSVHNskgeaTMMdyMml68p/BABYzqGNRwKui/CKDtaCWAY2YIeS8lvCyMFiDG+fblV/a
         C8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AvrFlLkarRN0Gd+cnXDbWYmr6+ylKLE26Er6/oCH96o=;
        b=M1TUPGNObrWSygknOvHkIlNDf2ysIijCb9UkK4z7gFGEiwPQfCa7pmTy5+Yqr4wyds
         Jtj3JKSQXG2uMxkKzZiLaWx6pfn5klFCuLBQnEejUksXVJtUD9iJZiw35jw68x50vUQf
         YOkB8kf2D8mgoE4+JxvmRr34HlHIhvChybiSSuGCex4miwHM1vy8/g4dkdlrCesLlpXQ
         NKlTrUhc15oy0yG8cmkwgXoX1i/Xc8P2fv0pBrf/hlJ7svsHAfcOqr1tFSXN/E3+CQVM
         u0HnkTL2tU2Ig1ekKDn2NlrrD+muOCsdQh6cv9t2B0PTv52YzmagjPDzt7kgeYUpCVwS
         llDg==
X-Gm-Message-State: APf1xPAnQO5/9OsKonFJ4Zp36Qed4reHIWNDaHLiU8/GKiazcWGkdlv0
        yP5OrRh0KBKmOuxXvCZHYBt7bdY2Dc8XbUb/11o=
X-Google-Smtp-Source: AG47ELsnoYFu44l7MPQjxPcRAIS2hybViqY39P00a6yFpQRNDxmehPGf7t88qeHWZYnFnZDvwG5/63WmV9BPpZakYNk=
X-Received: by 10.55.133.131 with SMTP id h125mr31185942qkd.79.1519852849995;
 Wed, 28 Feb 2018 13:20:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Wed, 28 Feb 2018 13:20:49 -0800 (PST)
In-Reply-To: <3A3B1BD6-642C-467F-B80C-82853410C235@gmail.com>
References: <20180224162801.98860-1-lars.schneider@autodesk.com>
 <20180224162801.98860-6-lars.schneider@autodesk.com> <CAPig+cRtp5g0iDd3pHybZXd_VkGG2-a4CdCZdiqN55Cr1T5Zyg@mail.gmail.com>
 <3A3B1BD6-642C-467F-B80C-82853410C235@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Feb 2018 16:20:49 -0500
X-Google-Sender-Auth: EtbXuqcSiCsP-Mg9CLhRq0Zs8cs
Message-ID: <CAPig+cQ1CNS0GbUWfeMBc+Q+fHjN3+t7c0RMQ9fWLrcZHBBJxw@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] convert: add 'working-tree-encoding' attribute
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 6:16 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>> On 25 Feb 2018, at 08:15, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sat, Feb 24, 2018 at 11:27 AM,  <lars.schneider@autodesk.com> wrote:
>> The above paragraph is giving an example of the scenario described in
>> the paragraph above it. It might, therefore, be clearer to start this
>> paragraph with "For example,...". Also, as an aid to non-Windows
>> developers, it might be helpful to introduce ".proj" files as
>> "Microsoft Visual Studio `*.proj` files...".
>
> Agreed. How about this?
>
>   For example, Microsoft Visual Studio resources files (`*.rc`) or
>   PowerShell script files (`*.ps1`) are sometimes encoded in UTF-16.
>   If you declare `*.ps1` as files as UTF-16 and you add `foo.ps1` with
>   a `working-tree-encoding` enabled Git client, then `foo.ps1` will be
>   stored as UTF-8 internally. A client without `working-tree-encoding`
>   support will checkout `foo.ps1` as UTF-8 encoded file. This will
>   typically cause trouble for the users of this file.

Since "*.proj" is mentioned a number of times in paragraphs below this
one, perhaps just stick with it instead of introducing "*.rc" and
"*.ps1", which don't necessarily add value. Alternately, if you use
.rc and .ps1, then change the remaining .proj references to follow
suit.

>>> diff --git a/convert.c b/convert.c
>>> +       } else if (is_missing_required_utf_bom(enc->name, src, src_len)) {
>>> +               const char *error_msg = _(
>>> +                       "BOM is required in '%s' if encoded as %s");
>>> +               const char *advise_msg = _(
>>> +                       "The file '%s' is missing a byte order mark (BOM). "
>>> +                       "Please use %sBE or %sLE (depending on the byte order) "
>>> +                       "as working-tree-encoding.");
>>> +               advise(advise_msg, path, enc->name, enc->name);
>>> +               if (conv_flags & CONV_WRITE_OBJECT)
>>> +                       die(error_msg, path, enc->name);
>>> +               else
>>> +                       error(error_msg, path, enc->name);
>>> +       }
>>
>> For a function which presumably is agnostic about the working-tree
>> encoding (supporting whatever iconv does), it nevertheless has
>> unusually intimate knowledge about UTF BOMs, in general, and the
>> internals of has_prohibited_utf_bom() and
>> is_missing_required_utf_bom(), in particular. It might be cleaner, and
>> would simplify this function, if all this UTF BOM-specific gunk was
>> moved elsewhere and generalized into a "validate conversion" function.
>
> Agreed! How about this?
>
>         /*
>          * If we convert to an UTF encoding, then check for common BOM errors.
>          */
>         if (!memcmp("UTF-", enc, 4))
>                 if (has_utf_bom_error(path, enc, src, src_len, die_on_error))
>                         return 0;

Better. The comment merely repeats the code, which is clear in its
intent, thus doesn't really add value (but that's a minor point).

I'd probably generalize it further to a "validate conversion" function
(which itself would have this UTF-specific knowledge), but that's a
matter of taste and can be done later when/if other types of
validation requirements arise.
