Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44C771F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 16:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbcIVQEi (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 12:04:38 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:38350 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752022AbcIVQEh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 12:04:37 -0400
Received: by mail-it0-f48.google.com with SMTP id n143so86209001ita.1
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=74c/7q6q8y7Yj0ysTnYChfmrMpr0zRqNBeGkxYaBKcs=;
        b=OmfwHmFMIzIPaGcGEfROVszi0vMvO3NtsAKgsJDyMtRX8DQcy6P7EHQom4M4LuRRPl
         2PCyBjtAMsdVwcvcvhiXlG/BNs2fxsatg/uu/q3+KoKjBqAp4fF5Q1I5M1I1kwgHfTwt
         mkCfMgb/LcFufNg7a9/owr0gorIWWW96O4oYcMB6FPZoFs0jEW3JO9KbXbYaU7eYpH67
         OKgvnH6PGznOgfISw3zB1/ewpEqlWaPTjsj5Aw/vV2S5+J+S6p8A3tdXLb44uj+s+c+4
         55unRTKuqAJF1Xyav9YGtOzvHOgbqPJz737lI7+OyJ5YHB/LRUWcOrBn+ikmGzN8pOhH
         NBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=74c/7q6q8y7Yj0ysTnYChfmrMpr0zRqNBeGkxYaBKcs=;
        b=SRdS0Gm8rYeVWLYmEJZD+TknJVqlA2xmsC4K0+w94ThmE2qUR8T3iI/Rge76kIIyS4
         NiZWD9rvkwM5atPRZnXoE1fUrr3gOQarZs0o33iya6qsou/bcdyFkSBV3v8QissLOpV3
         5jAH8mRIZJhdkV6+bRBfj/1qyvJ5YpM/TsXj0A9XPkp1mk3N6r+px40vCfTxombUJEhR
         fILTv1jwqWFGw2yQcsE5jPFT5JQktRqwiPNcxE6LH02+kY60wSehcCe2Qzf7jvLTc7Kp
         GCAFag8+EYshaRw3PuP05beGU97KZHNUKqiI4WzqTrvgrKMRyaxYRhxdO6F98Bl3Dtyx
         B9Xg==
X-Gm-Message-State: AE9vXwOiNK5dOMFlHPQAKBlQ2MW3JLTrLHCbcqkLPKUUAYvh39sk35eK4HcdFQJ75pwiYmyUBg8MdsB5aF3yJOIJ
X-Received: by 10.36.4.143 with SMTP id 137mr11013101itb.39.1474560276026;
 Thu, 22 Sep 2016 09:04:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Thu, 22 Sep 2016 09:04:35 -0700 (PDT)
In-Reply-To: <20160922041854.7754ujcynhk7mdnh@sigill.intra.peff.net>
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
 <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com>
 <xmqq1t0c7ur2.fsf@gitster.mtv.corp.google.com> <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
 <xmqqponw6e3x.fsf@gitster.mtv.corp.google.com> <20160922041854.7754ujcynhk7mdnh@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Sep 2016 09:04:35 -0700
Message-ID: <CAGZ79kYQVhVN1mzJCWCH8bLEFTmgL8yqrN=KUiAY5PT1t7-D6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ls-files: adding support for submodules
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2016 at 9:18 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 21, 2016 at 04:13:22PM -0700, Junio C Hamano wrote:
>
>> Brandon Williams <bmwill@google.com> writes:
>>
>> > yes you mentioned this and I meant to change that before sending it out.
>> > Looks like it slipped through have slipped through.
>>
>> I already fixed it up locally when I sent the reply, but thanks for
>> resending (which assures me that your local copy is up-to-date and I
>> do not have to worry about having to repeat me in the future, if
>> this ever needs further rerolling ;-).
>
> While we are on the subject, the commit message also uses some past
> tense:
>
>   Allow ls-files to recognize submodules in order to retrieve a list of
>   files from a repository's submodules.  This is done by forking off a
>   process to recursively call ls-files on all submodules. Also added a
>   submodule-prefix command in order to prepend paths to child processes.
>
> The final sentence should be "Also add...".
>
> Since this final bit of logic was sufficiently non-obvious that it only
> came about in v2, maybe it is worth describing a little more fully:
>
>   Also add a submodule-prefix option, which instructs the child
>   processes to prepend the prefix to each path they output. This makes
>   the output paths match what is on the filesystem (i.e., as if the
>   submodule boundaries were not there at all).
>
> Should this option just be "--prefix", or maybe "--output-prefix"?

I think --prefix can easily be confused with the internal prefix that we hand
down to each command. --output-prefix works for the ls-files case, but as
soon as we do more than just printing out file names, we'd use that prefix for
more than just output, e.g. in grep it becomes part of the pathspec IIUC.
I agree however that we probably don't want to keep it submodule specific.

> Submodules are the obvious use case here, but I could see somebody
> adapting this for other uses (alternatively, if we _do_ want to keep it
> just as an implementation detail for submodules, we should probably
> discourage people in the documentation from using it themselves).
>
> -Peff
