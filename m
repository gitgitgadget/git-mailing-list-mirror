Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88E021F406
	for <e@80x24.org>; Tue, 19 Dec 2017 22:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbdLSWy4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 17:54:56 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:39574 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752680AbdLSWyz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 17:54:55 -0500
Received: by mail-qk0-f174.google.com with SMTP id u184so24583291qkd.6
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 14:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8BVIG4/RcVYfvX0EOfyMmCNozuqudzowzvCsi461Bew=;
        b=ExR86PFBHUtumh2DmYxFNXD/uzGD55KXVjph1qvLaSGCdtiVqNuBd7DdjDCMa1um+q
         7MfzgD6qdfFsf/5CZNB5XZYGbQDxSikn+U1u+mPZH3Wa8F74wUMXFP3a9q3aBaS3Z6Om
         BftrGx5Gev1Vbsken477AvKvjmoql4B31jPoqdqZtPQCyAg1/7VbBck4yGhV1TcJ+mJU
         lDuFmsZ63EI2evO/KwUf57YBZrHDhG3N7dTZ+NdtJNfd99VL+qiLISk28MZxxk9TwU2T
         yxlJYeT8SOKsWnL1alh5Zj6+r+LCqZfwIblOanzQVDxeq30mYqY9NRuiL9fUJWU4gKlh
         NQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8BVIG4/RcVYfvX0EOfyMmCNozuqudzowzvCsi461Bew=;
        b=eyMavrbo8uZhRp6ZcVrzMYPz15YKi3D4b7/II67YoSH2f8bILCw97nQQ9mqqz5X7Uy
         wWo7DCkIRJcAATPeCSe0Dd3pGjLEmelKl1lNrSP3pJiyCsIR6EZI4dcKCHk6LkUVT1hc
         pAED4e32tktJYcgYsk8p6JSboKVE87W68y+sg801AoFkk3DUR7OdEtyo5G1jmLjk0Ip4
         tjmmpe0+iuI3P3RL2dWRA1mcARmmWyWK7lcY3Z1/kp7QjHAGKi7zffciVDpW/y7t10Sg
         RpD+Zh63ieoZM3qXJzJP+ICr2cpslE7C1MsjdU4yeFduQT7c/4WVUlQRxLR27V7iZeYZ
         IHUw==
X-Gm-Message-State: AKGB3mJMVTQnx5sdgHsat5oEFwCm8fGy2uG8QdVyR1ImxLohqaATPcU8
        QUllC5POFneD6wVVcmx4JTU8wrRlZ+8Adfzho7Lw0w==
X-Google-Smtp-Source: ACJfBovT78lx4ih2S91TL2Ge6L5O9leQpCQ4wkAkA9jdhuWXFXRG0YHHSLfByTtiiB8J2XYMAJgSuYxSp9JWxEMjq7g=
X-Received: by 10.55.124.7 with SMTP id x7mr804499qkc.133.1513724094820; Tue,
 19 Dec 2017 14:54:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 19 Dec 2017 14:54:53 -0800 (PST)
In-Reply-To: <20171219224431.GG240141@aiede.mtv.corp.google.com>
References: <20171219222636.216001-1-sbeller@google.com> <20171219222636.216001-6-sbeller@google.com>
 <20171219224431.GG240141@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 19 Dec 2017 14:54:53 -0800
Message-ID: <CAGZ79kake8k2dM=NPwNoqB5Vkxy+k67PACz01-aXx6-njcisgQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] submodule: submodule_move_head omits old argument in
 forced case
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 19, 2017 at 2:44 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> I had trouble understanding what this fixes, so I'll try nitpicking a
> bit as a sideways way to address that.
>
> Stefan Beller wrote:
>
>> With the previous patch applied (fix of the same() function),
>
> This tripped me up a bit.  Usually commits assume that all previous
> patches have already been applied, since that allows the maintainer to
> apply the early part of a series on one day and the later part another
> day without losing too much context.
>
> I think this intends to say something like
>
>         Now that we allow recursing into an unchanged submodule (see
>         "unpack-trees: Fix same() for submodules", 2017-12-19), it is
>         possible for ...


yup

>
>>                                                               the
>> function `submodule_move_head` may be invoked with the same argument
>> for the `old` and `new` state of a submodule, for example when you
>> run `reset --hard --recurse-submodules` in the superproject that has no
>> change in the gitlink entry, but only worktree related change in the
>> submodule. The read-tree call in the submodule is not amused about
>> the duplicate argument.
>
> What is the symptom of read-tree being unamused?  Is that a sign that
> these patches are out of order (i.e. that we should prepare to handle an
> unchanged submodule first, and then adjust the caller to pass in
> unchanged submodules)?
>
>> It turns out that we can omit the duplicate old argument in all forced
>> cases anyway, so let's do that.
>
> What is the end-user visibile effect of such a change?  E.g. what
> becomes possible to a user that wasn't possible before?
>
> Among the commands you mentioned before:
>
>   checkout -f
>         I think I would expect this not to touch a submodule that
>         hasn't changed, since that would be consistent with its
>         behavior on files that haven't changed.
>
>   reset --hard
>         Nice!  Yes, recursing into unchanged submodules is a big part
>         of the psychological comfort of being able to say "you can
>         always use reset --hard <commit> to get back to a known
>         state".

I may have a different understanding of git commands than you do,
but a plain "checkout -f" with no further arguments is the same as
a hard reset IMHO, and could be used interchangeably?

Rehashing the "What is a submodule?" discussion, I would claim
that when its worktree is changed, we'd want checkout to restore
the submodules worktree back, so I disagree with your assessment
of checkout -f.

>   read-tree -u --reset
>         This is essentially the plumbing equivalent of reset --hard,
>         so it makes sense for them to be consistent.  Ok.
>
> Based on the checkout -f case, if I've understood correctly then patch
> 4/5 goes too far on it (but I could easily be convinced otherwise).

Without 4/5 we cannot implement hard reset recursing into submodules
as it is functionally the same as forced checkout except when we
differentiate them
on a higher layer?

>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  submodule.c               | 4 +++-
>>  t/lib-submodule-update.sh | 2 +-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/submodule.c b/submodule.c
>> index fa25888783..db0f7ac51e 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -1653,7 +1653,9 @@ int submodule_move_head(const char *path,
>>       else
>>               argv_array_push(&cp.args, "-m");
>>
>> -     argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);
>> +     if (!(flags & SUBMODULE_MOVE_HEAD_FORCE))
>> +             argv_array_push(&cp.args, old ? old : EMPTY_TREE_SHA1_HEX);
>
> Interesting.  What is the effect when old != new?

when the force flag is set we mostly pass in old="HEAD", which is
technically correct,
but not a sha1. (I assume you want to know what happens when two unequal sha1s
are given; for that it will perform a 2 way merge instead of a complete reset)

Thanks,
Stefan
