Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE9651FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 21:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752508AbdLHVLf (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 16:11:35 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:46580 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753177AbdLHVLd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 16:11:33 -0500
Received: by mail-qk0-f178.google.com with SMTP id b184so515551qkc.13
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 13:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9HV/EC/tM7gKCXG5MsBUX+vsDCmPl4CnioTpdASv+fg=;
        b=gI14xDdYiDAOBKgVhbaBWeo/GcXuAeigTL1CR/AX60caEqZSAY1/VPjrM+8WkEY0P5
         xD5ixJfC4fdZfY94838hAcIY5Bz1c6VaVHyxnbe50CgskoCx1jUpULQvvHrMvn/mseOE
         m8xfzYARd7tgDjRTeFWYmTRpKh73qNO4xpGAHL5tlVHhXvdU6E3SAEzun6BnpyhWRJZu
         Fjo2r43Z1u3c2Z0juIkSf5+mWnRh2SM0eNknire9fK4Cmq9/xAfljObyWml6ayQMvBY5
         YazLftBc5K2KKwVLvfFMfzJlYCOwIW5ZjOS1sjH4m7WSLaiYYPDFkZ/pVJuh0/SFd5NL
         BQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9HV/EC/tM7gKCXG5MsBUX+vsDCmPl4CnioTpdASv+fg=;
        b=gEODtgdsSCiii7/IE6LLmH2cyH//53hYb5tL6Y+XT2qLwZ21v+60qpbdb7byjVEydB
         BS68lZDllnXKSJIXQmF0nyd7X3vzN1YhSUew8ZFaxCkoAo8sbNbZidbkVaJVdXceU8e3
         XOfMU6jX6/nwc6mdf3U6JfAjaYyFuqjXuCZIWIAA8tKFcyFfY3r+uZP5sp9uyk6A4MKk
         +uWhuvaPDy9QXa8cSJblB/E+JzKY169k/f7WPCYX9ns4npU995ruXyZ3QjN3PNGCLGKa
         o2dq76jvPLmZTk8e3daaWCq42H630OuehJ1ktyqiqMzLJQEy+R56cU0XSeGnQnHJmsf/
         s/tA==
X-Gm-Message-State: AKGB3mK+Mxuwq4RnhOoT9HulkppA6FYsKKyEVCP5e+a4trUNYMqVN+4z
        kLYjbjlH6CntgJ4efTCXZBhwXW/3fuw9ha/Y6R+08MszCeU=
X-Google-Smtp-Source: AGs4zMb80SqR7Oe1ql2cV5wxacfcx7uDGgF49WQ12bLrZccEYwTTOHVi9s2P3CtfaahQK77FVfSO+wq/4vjmu97ra38=
X-Received: by 10.55.107.65 with SMTP id g62mr36179296qkc.295.1512767492948;
 Fri, 08 Dec 2017 13:11:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Fri, 8 Dec 2017 13:11:32 -0800 (PST)
In-Reply-To: <xmqq1sk5b6rx.fsf@gitster.mtv.corp.google.com>
References: <20171208002447.20261-1-sbeller@google.com> <20171208002447.20261-2-sbeller@google.com>
 <xmqq1sk5b6rx.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 8 Dec 2017 13:11:32 -0800
Message-ID: <CAGZ79kbE9ePfxdD+rxp=P_jZwv4RPiVSbhdpjEf48dAMsKWYrQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] diffcore: add a filter to find a specific blob
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> +
>> +             if ((DIFF_FILE_VALID(p->one) &&
>> +                  oidset_contains(options->blobfind, &p->one->oid)) ||
>> +                 (DIFF_FILE_VALID(p->two) &&
>> +                  oidset_contains(options->blobfind, &p->two->oid))) {
>
> Shouldn't this make sure that !DIFF_PAIR_UNMERGED(p) before looking
> at the sides of the pair?  I think an unmerged pair is queued with
> filespecs whose modes are cleared, but we should not be relying on
> that---I think we even had bugs we fixed by introducing an explicit
> is_unmerged field to the filepair struct.

I am not sure I follow. IIUC 'unmerged' only ever happens in the
index when there are multiple stages for one path (represented in the
working tree with diff markers). Aren't we supposed to find such
an unmerged blob as well (despite wrong mode, but the oid ought to fit)?

>> +     if (revs->diffopt.blobfind)
>> +             revs->simplify_history = 0;
>>       return 0;
>>  }
>
> It makes sense to clear this bit by default, but is this an
> unconditonal clearing?  In other words, is there a way for the user
> to countermand this default and ask for merge simplification from
> the command line, e.g. "diff --simplify-history --blobfind=<blob>"?

As noted in your reply, this is consistent with other occurrences of
simplify_history, so let's keep it this way.

>> +
>> +     git log --abbrev=12 --oneline --blobfind=greeting^{blob} >actual.raw &&
>> +     cut -c 14- actual.raw >actual &&
>> +     test_cmp expect actual
>
> The hardcoded numbers look strange and smell like a workaround of
> not asking for full object names.

You mean the 12 and 14 ? Yeah I can fix that to 40 and 42 if you want.
I wrote it this way to be agnostic of the actual object id, but thought 12
would be enough for this test no matter the future hash.

> Also, now it has the simplify-history bit in the change, don't we
> want to check a mergy history, and also running "diff-files" while
> the index has unmerged entries?

yup, I am working on that.
