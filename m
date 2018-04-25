Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36B641F424
	for <e@80x24.org>; Wed, 25 Apr 2018 16:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755416AbeDYQBa (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 12:01:30 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:43195 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932080AbeDYQBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 12:01:25 -0400
Received: by mail-ua0-f196.google.com with SMTP id s15so15230152uae.10
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 09:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7MS+7Nez6HFJKrvsqIcTlcI8tNKBVPRfucIzv1FO88A=;
        b=ZfZ5bMTceKoiPP3buF6l5DfS6VzFDnHTWn479nxKZwxb+hj1co5KkLyN0fZCeL/pin
         SY4i0LqzSwAkABp5jDIgQIbJ9NKRo0VlPQRnuPJWbqadXvRq3q6zduHqGvEPoxJ/GQYX
         btG8AILYw03sBcSJhVq4R8iQt1PA4uEmrpq47V/8i0QA3RCexvgPAvglvOiu2go2YViW
         ZQ69IbKeTPEAtycXyEM++M+t4IpUj7K+POiezZaHbx9vdue04F5HGGCFe5a1lEdcZ8V0
         Vj68PVSpizbx2mGlB9Oqp+mI8eY8wCVbbaKvvh5Tk8bPg0n7JgVSEtdGovjkaWN4X1ST
         orTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7MS+7Nez6HFJKrvsqIcTlcI8tNKBVPRfucIzv1FO88A=;
        b=LrTTX4jSZ6CtCP0O8zi7TyOlF8OKnLqWsQG/jxpVt24AChtusApfHmWd3gOmCEaVXK
         HV058/oUse5JB4u1OlKkI7SxjTJP6Z/HqgfCjofX5wzhLd8PSrOsJEycchi+9YF1NrOE
         Qh1ZZQpIOxJdCyKffL9TkXFdeFInVlzESVRnwJs37bSee7SMBoeHBuY/+szyBOzQgeil
         RVdEjYCNLwJbLdVIuidCkwv9mNmm2SV566r3MxwOlYzH+/e1CFaBpJltd6jE8ZfnR6uP
         QU/EfCu0eD0LL7jhxurageVsp0CsXliGhgI3aQNCchT72Xz8z3umMHdLd4rpHIsQ+pBr
         Otjw==
X-Gm-Message-State: ALQs6tAZiKLdQV9VGdlAEbJcvI+8JaS5nPNb6Wqgk1+s0tZ7woirzQD7
        xGGYtbwc5gyj7Z9tjqCa9S5HdIIvfS0jwXiYSts=
X-Google-Smtp-Source: AB8JxZo3zgLuMbHCZ58tWiY2HK8Tn/dhV3bUEKEa4Ftl94Hi8QKrcHh88ldKumofCH3p335DLMNLp2WBQfOzy5w9XQ4=
X-Received: by 10.176.30.139 with SMTP id o11mr1588755uak.154.1524672083055;
 Wed, 25 Apr 2018 09:01:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Wed, 25 Apr 2018 09:01:21 -0700 (PDT)
In-Reply-To: <68fa18c0-1dac-f6dc-0c41-fa5722c2c227@gmail.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180424171124.12064-1-benpeart@microsoft.com> <20180424171124.12064-2-benpeart@microsoft.com>
 <CABPp-BFTywvVFV3Wx1jv9RyoFk_cE7XE8x1neuLVt4qwyw0EMw@mail.gmail.com> <68fa18c0-1dac-f6dc-0c41-fa5722c2c227@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 25 Apr 2018 09:01:21 -0700
Message-ID: <CABPp-BGGtLGKVGY_ry8=sdi=s=EDphzTADt+0UR1F4NJpSqmFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] merge: Add merge.renames config setting
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 24, 2018 at 1:31 PM, Ben Peart <peartben@gmail.com> wrote:
> On 4/24/2018 2:59 PM, Elijah Newren wrote:
>> On Tue, Apr 24, 2018 at 10:11 AM, Ben Peart <Ben.Peart@microsoft.com>
>> wrote:
>>>
>>> diff --git a/builtin/merge.c b/builtin/merge.c
>>> index 8746c5e3e8..3be52cd316 100644
>>> --- a/builtin/merge.c
>>> +++ b/builtin/merge.c
>>> @@ -424,6 +424,7 @@ static void finish(struct commit *head_commit,
>>>                  opts.output_format |=
>>>                          DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
>>>                  opts.detect_rename = DIFF_DETECT_RENAME;
>>> +               git_config_get_bool("merge.renames",
>>> &opts.detect_rename);
>>>                  diff_setup_done(&opts);
>>>                  diff_tree_oid(head, new_head, "", &opts);
>>>                  diffcore_std(&opts);
>>
>>
>> Shouldn't this also be turned off if either (a) merge.renames is unset
>> and diff.renames is false, or (b) the user specifies -Xno-renames?
>>
>
> This makes me think that I should probably remove the line that overrides
> the detect_rename setting with the merge config setting.  As I look at the
> code, none of the other merge options are reflected in the diffstat;
> instead, all the settings are pretty much hard coded.  Perhaps I shouldn't
> rock that boat.

Actually, stat_graph_width respects the diff.statGraphWidth config
option, even though it's slightly hidden due to the magic value of -1,
and being handled from diff.c.

However, trying to get this suggestion of mine hooked up, particularly
with -Xno-renames and -Xfind-renames (the latter because it might need
to override a merge.renames or diff.renames config setting), might be
slightly tricky because the -X options are only passed down to a
single merge strategy but this code is outside of the merge
strategies.  So making it a separate patch, or even a separate patch
series may make sense.  I'm still interested in this change if you
aren't, but I'm fine with it not being part of your series if you
don't want to tackle it.
