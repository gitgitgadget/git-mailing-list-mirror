Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B89F1FADF
	for <e@80x24.org>; Sat, 13 Jan 2018 06:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbeAMGsE (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 01:48:04 -0500
Received: from mail-oi0-f54.google.com ([209.85.218.54]:46276 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbeAMGsD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 01:48:03 -0500
Received: by mail-oi0-f54.google.com with SMTP id d124so5338747oib.13
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 22:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sngsbT7Rs7jbZyE133nbx1xCFwrhjncRjjOpTpDUsO4=;
        b=Xb6E6lnrkODPHEBN5lN+f5vPqUCkIKI7IOAJAkWl3+2bsTRPyzLMAJj8+43ylgEQk6
         Gj/01XZDFVxK3nTpssTR9q/K+FL51cg41zLc/jXU7ivIyG5MTBNjpoKdQctnBxVnu8HW
         2dZNBvPIqFXTAAjXhLhwJIjLMEe6HYvQwCvd7PV2n3TlBC/aURR5v+pWOb4edyOV7e51
         w9tlPQeKmlyj5eogEb8vrtZ03iIUVY7M0J1BxJaCL0YKB3x/65ar7/Lpsf+pHL4iGW4F
         JvRMvmpMhYZySR7/LdBEkJw1rvRcptpr4110kUWegEWRCgVUhS93wVWCpXoKnh8LO6Zf
         RLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sngsbT7Rs7jbZyE133nbx1xCFwrhjncRjjOpTpDUsO4=;
        b=Z8z0swySc6NEZTRrTy9uc85ru7ruDNggo/D7Y6PSj1E2ga0eL/cCefARbPnNMJ9r5I
         d0AeC0ZLgFQs6Ix8YZVQzbT3Shk4seMvlB8uLsMAcgBIqttw5jX414f51b+UOsw6CpLu
         lvm1EhT57YTgC+u1GZC3eqIMBzg0bc1UPj254qvoXtEO+PQgeIDfXJGJXC5SpJMahAi2
         V7e76r7kB92Q0aM4MTD/4MlbOy3UITWBeosQfyFf51Zabcg7girW0KGY9wlGMPhT36SI
         KVKoFSSPx4+L3z6c9B11HaFaoBrDWB9NfHE9W+GYf5/C9/tkC6CJYY1NsiRhSqOKXHys
         haCA==
X-Gm-Message-State: AKwxytdEGHau/7JdwXNrvZOthmUYkAM94KOTT+WsjcOwx3GTRmkwnKNU
        ykO/RoRRnO9k2Gsbk5BhnjgovTUz4wClK+gD9/o=
X-Google-Smtp-Source: ACJfBoubTD3qvdvvYQKW/q+KGtiUBAQIl8nS+VPjMPTUPkWXU35IO5H8WAqXx0SQIj5qCnDYL3xwOKbCk05cpBG0vCI=
X-Received: by 10.202.82.196 with SMTP id g187mr5475226oib.297.1515826082642;
 Fri, 12 Jan 2018 22:48:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Fri, 12 Jan 2018 22:47:32 -0800 (PST)
In-Reply-To: <CACsJy8CeYY34G=JjwHWqM+QbBG41pkW7VP+Aowak26rdM1qpPg@mail.gmail.com>
References: <20180111094712.2551-1-pclouds@gmail.com> <20180112095607.18293-1-pclouds@gmail.com>
 <20180112095607.18293-5-pclouds@gmail.com> <20180112133355.GE27499@sigill.intra.peff.net>
 <xmqq7esmwuwn.fsf@gitster.mtv.corp.google.com> <CACsJy8CeYY34G=JjwHWqM+QbBG41pkW7VP+Aowak26rdM1qpPg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 13 Jan 2018 13:47:32 +0700
Message-ID: <CACsJy8Dc5gcaoKG6i7JoiuCaD2Xn-saeAgN=u2nK0zryiMJY3g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] trace.c: be smart about what env to print in trace_run_command()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 13, 2018 at 11:54 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Jan 13, 2018 at 5:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> I also think this is a special case of a more general problem. FOO could
>>> appear any number of times in the "env" array, as a deletion or with
>>> multiple values. Our prep_childenv() would treat that as "last one
>>> wins", I think. Could we just do the same here?
>>
>> Perhaps this should be squashed into the original 4/4 instead of
>> being a separate patch.  We'd probably want some sort of test, I
>> wonder?  Not tested at all beyond compiling...
>>
>> -- >8 --
>> Subject: [PATCH 7/4] run-command.c: don't be too cute in concatenate_env()
>>
>> Instead of relying on "sort" being stable to sort "unset VAR"
>> immediately before "VAR=VAL" to remove the former, just pick the
>> last manipulation for each VAR from the list of environment tweaks
>> and show them in the output.
>
> This is not enough.

No it is. I misunderstood string_list_insert() and my tests proved me
wrong. Sorry for the noise.
-- 
Duy
