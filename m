Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D541FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 21:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933532AbdBPV06 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 16:26:58 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33355 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933214AbdBPV05 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 16:26:57 -0500
Received: by mail-lf0-f54.google.com with SMTP id x1so14374661lff.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 13:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=egGl+gxjPIUjXinCh2YZ5NgjMprrUVsAmERN+zPZ/0A=;
        b=GcwpnJA3NXcbdBqIdVnHu0+PFNLP57sYlIloTbMJBDKlCyF9MUPUC32tdGzN2gsqBs
         W2T7qn+/B0rMpuJjQfqputTEWTkMZoP3tTdhhDpyM+1vfgvdBnP2M1eqZ0Yof4yOA2/P
         2z2L4NYGKM7WoOGX6BSnkp7EzPlDDucUVn1WJss7Glu0Wh5YT0ui0/71TKx8L6lY8MSs
         14D8WzkG6kMqFfNuCP59gMcOOHtylhb8oi7FLXmKMmVDmKMTTCmKWoKkKUq4XwV02X08
         xq7NWPy+Nq5RMyE5XFs5XR0t8T7izDIzwOJu1cVFJuFhmVjdt04DuybN7bRCpQJMxz8X
         AkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=egGl+gxjPIUjXinCh2YZ5NgjMprrUVsAmERN+zPZ/0A=;
        b=EyVMa9Tj5WyGEx9jo1wfJO9wW6sVF1y6+MyLx8/lZ6AjE/ujTKmoU9tzI8wPEtoP0D
         U8U4vrFMaKPhJzcLxov6koiR9APLAdT6taVUnln+6xZirIzCn8+P4mIfluXihUH5Ouix
         6oCI9yWskVadUDohW9kUt1brpDg36ZVyO1YYwyOY7NeQl6K3EIsl/Ex8bnRSOgYV/VJJ
         Sjm/EHXzmiDN3SKzmJ0k0/CSkD7myJW75RPqlm4DVn071QiFgP+HVGn8xFr4kD6AceF2
         xYa3nF1aLIpH0ln01GF/swiVNTt80CzouoDCT4Yd63ubhSU1Ji3Z2DhDWGk1rtEBA/qk
         UAzQ==
X-Gm-Message-State: AMke39kBix3tn4+ELuAjsv1KN8cInIST58tV3s1oOg6VlaKR7KX3klYqZ66AKRy7767SsaoVk9h/Z7gZwwITTw==
X-Received: by 10.25.87.196 with SMTP id l187mr1184456lfb.143.1487280415727;
 Thu, 16 Feb 2017 13:26:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Thu, 16 Feb 2017 13:26:35 -0800 (PST)
In-Reply-To: <xmqqpoihx6f4.fsf@gitster.mtv.corp.google.com>
References: <20170216002212.31088-1-jacob.e.keller@intel.com>
 <xmqq4lzux7sc.fsf@gitster.mtv.corp.google.com> <xmqqpoihx6f4.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 16 Feb 2017 13:26:35 -0800
Message-ID: <CA+P7+xr4a+NK8Ye5DK7=EdDfZTSwuZsp3kG3DMHabCu5z+sbCQ@mail.gmail.com>
Subject: Re: [PATCH v3] reset: add an example of how to split a commit into two
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 11:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jacob Keller <jacob.e.keller@intel.com> writes:
>>
>>> The interdiff between v2 and v3 is not really worth showing since I
>>> basically re-wrote the entire section a bit.
>>
>> Could this be made into an incremental, now that v2 has been in
>> 'next' for about 10 days, please?
>
> Nah, I think it is easier to read "log -p" if I just revert v2 out
> of existence from 'next', and queue this (with a minor typofixes) as
> a different topic to be merged later to 'master'.
>

Ok. Yea, I didn't even realize it was put into next because of the
various comments I'd received. I guess I could have checked, but the
diff really is bad when seeing incrementally.

> So no need to resend and certainly no need to make it incremental.
>
>>> +Split a commit apart into a sequence of commits::
>>> ++
>>> +Suppose that you have create lots of logically separate changes and commit them
>>
>> s/create/&d/; s/commit/&ed/
>
> I'd do this myself while queuing.
>
> Thanks.

Thanks,
Jake
