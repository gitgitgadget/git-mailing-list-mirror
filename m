Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE5DC201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 20:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbdBXU1f (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 15:27:35 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:35362 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdBXU1e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 15:27:34 -0500
Received: by mail-it0-f43.google.com with SMTP id 203so33073749ith.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 12:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gP6pP8l+CuVdRe32LvmaDldKT8liUR4RPzD8SQaTUG8=;
        b=LBiWXk4ZWSjw3gWpA1BNlXhUmGXInoid3L+mKpKB0ruXlca5DFCRGD1IoFQiBoFqzu
         nsWrWiGJKyADd3GwzZNG6DU6cQWT8NMq6Pbjeki90X11atxeVDUoOR3W+IBrj7DHY/w7
         D5YInvHE6hCEt9FlnKkqIpKC2tVuznzRTeyieoh4HD+cL2Cbe2GuAmN3VfAF2PHKiv0v
         ZrMO0vMIayJe0ifDh2mUEJcZAM8D32PlvAf6L5z6I7t4FVW4Ej0mgNsiXAjgNbUobtaT
         /rukMiY1T7fPsX3V0HrGcdv20t8etayePXyUeMb11thHhhMBw2tDSZZPNcJycfAZOrxv
         oprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gP6pP8l+CuVdRe32LvmaDldKT8liUR4RPzD8SQaTUG8=;
        b=bIr8z/oYiRskzkSMOcLuccp17mT+k+3eD/7kuOfwtW/KkYxU0lWHFoGpBftv/VS1Np
         dyRW2DEnZ8KzKulH7GSCC+LezwmpmHrB4/urLcuVFNekEUHVkFNYkoGBwpFj2NDprZS8
         Rxsnn9JOm9Ufvx3Rzk8nxndevD1wjXpBLeNlKIspLCXFeSVGlGYrqrjkI9F0Ogg7Uj81
         SGGFxCnWBeLThHYsxAT4OdTTGmwETbFpIvPz4pxRskz2q5IfkP6iwNJgCs0mUax8bf3t
         SZYRQT1Vxx7qQX+LDtqpACaekynim9+XaMc3Kl6Vzbz8clWxuwQ2oKKdqaYBmGbDNq2E
         Cf9g==
X-Gm-Message-State: AMke39mB6aJ5ru6exx3B/1O36MUqOSPnxe27NIFsoaTqmErssBmczAEPPtbnOeyDmWnK1HoDEe6HJJ2sv/aIvhxo
X-Received: by 10.36.40.198 with SMTP id h189mr4128139ith.114.1487968052931;
 Fri, 24 Feb 2017 12:27:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Fri, 24 Feb 2017 12:27:32 -0800 (PST)
In-Reply-To: <xmqqlgsv1guq.fsf@gitster.mtv.corp.google.com>
References: <ae377bda-0776-f98b-5b6f-afa198647400@kdbg.org>
 <20170224182237.3696-1-sbeller@google.com> <xmqqlgsv1guq.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 24 Feb 2017 12:27:32 -0800
Message-ID: <CAGZ79kbzhHaV4-cVvqwodwXSBstRfH1FrOh=iYMvU6cqYUcUng@mail.gmail.com>
Subject: Re: [PATCH] submodule init: warn about falling back to a local path
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        Shawn Pearce <sop@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 12:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> When a submodule is initialized, the config variable 'submodule.<name>.url'
>> is set depending on the value of the same variable in the .gitmodules
>> file. When the URL indicates to be relative, then the url is computed
>> relative to its default remote. The default remote cannot be determined
>> accurately in all cases, such that it falls back to 'origin'.
>>
>> The 'origin' remote may not exist, though. In that case we give up looking
>> for a suitable remote and we'll just assume it to be a local relative path.
>
> IOW we keep the .url to be relative, the same as the original one we
> took from .gitmodules?

Well that is one way to say that. Another way is:
If we cannot construct a URL based on the given relative URL, we
demote the relative URL to be a relative PATH and resolve that instead.

>  That sounds like a sensible thing to do and
> I agree it makes sense to warn when it happens.

ok.

>
>> @@ -118,18 +122,22 @@ too (and can also report changes to a submodule's work tree).
>>
>>  init [--] [<path>...]::
>>       Initialize the submodules recorded in the index (which were
>> -     added and committed elsewhere) by copying submodule
>> -     names and urls from .gitmodules to .git/config.
>> -     Optional <path> arguments limit which submodules will be initialized.
>> -     It will also copy the value of `submodule.$name.update` into
>> -     .git/config.
>> -     The key used in .git/config is `submodule.$name.url`.
>> -     This command does not alter existing information in .git/config.
>> -     You can then customize the submodule clone URLs in .git/config
>> -     for your local setup and proceed to `git submodule update`;
>> -     you can also just use `git submodule update --init` without
>> -     the explicit 'init' step if you do not intend to customize
>> -     any submodule locations.
>> +     added and committed elsewhere) by copying `submodule.$name.url`
>> +     from .gitmodules to .git/config, resolving relative urls to be
>> +     relative to the default remote.
>
> I read this as "copying..., resolving relative to the default remote
> (if exists)."  A reader would wonder what happens if the default
> remote does not exist---don't we want to describe what happens in
> that case, like, "recording . (the current repository) as the
> upstream" or something?

eh, a better approach is s/copying/<something else>/
We will resolve the relative URL no matter what. It's just that
we may end up with an absolute path instead of an absolute URL.

>
>> ++
>> +Optional <path> arguments limit which submodules will be initialized.
>> +If no path is specified all submodules are initialized.
>
> Perhaps s/ all submodules/,&/?

ok

Will reroll, once I have found a better wording.
