Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA7EB201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 23:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbdBUXoF (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 18:44:05 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:37337 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbdBUXoE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 18:44:04 -0500
Received: by mail-it0-f48.google.com with SMTP id 203so59499775ith.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 15:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RnPWvJ/tdfd4Z4L8O1FCg4dftTr9t+42kWWsd5yZT0s=;
        b=AKyHxkdYN1a8rLfeB082MLH89qNCUuKNfGvroo/qjN+hqs1CI5w9iJycYp0PGyglue
         rv5m7LgrtKiJFQ+ToMEPEym1kJKq0PVp8Uuk8xvfBQ/pq+cAjSp2Zj3QWIeAy1IC2EVd
         HtFkoaJ01YLaYeA22AsCjMOapDQOvKIEJcIOrubsd/4rW2E+kyEik3Mc891aU7r0umZW
         dxybDcmu5Ao83H05wOLxOqXb605sk6xM/4SPKDeEbiJfwFzz0+HGTIBjrlfduBCAiNKV
         2oMdHzT1K3gO8Emm3bxHTdefVLJoEEf2JQ4imqwmlxg50L0JDnYOu4vNxWSJY1YTtVad
         /ClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RnPWvJ/tdfd4Z4L8O1FCg4dftTr9t+42kWWsd5yZT0s=;
        b=fdMCikVXGIevOpr+Sm1QNyqiyLbWaKp78tq8nr51RwncP4FN/NsPl4UeRVOktEcO8X
         XNPylDi/S76f8n5g9Q2yhM9Gm/xUv1XXyidYjEHeiHCa6HSH1HxdAbyeAnRW7ORHCpoW
         FnXplvRIpmyb9k9SyAXJgV9v9qNFoDemg7/hB7SGxZCM4eelOUNhtXmO0X7cHs3+GnLc
         g3PIsdt2gaLDolCU4WGsM7D5Yq8fTLfefK/J0OZ+9SxHM/i2WSFnMA4j91ltUYWAW6Y6
         C1KWXAeoWeyGFNWHrPi402bws/SvMqTLm6owB+d8OpII4GmI1TvgkGSoXh9KRU7SuRGj
         TKag==
X-Gm-Message-State: AMke39nQ+yHozMuMvueXvw0glDJ/BhmpdgIbYPXXuEy9ZfZBi5ibnY67a6NQ/cM5XQ4GXxP0MoBwa3J88CKfAaIj
X-Received: by 10.36.225.13 with SMTP id n13mr12069712ith.114.1487720642837;
 Tue, 21 Feb 2017 15:44:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Tue, 21 Feb 2017 15:44:02 -0800 (PST)
In-Reply-To: <CA+P7+xq3XF2=erRLiNjOUq9H66Sa5VCxNBzTF=RAycPYrPRFJg@mail.gmail.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com> <20170216003811.18273-1-sbeller@google.com>
 <20170216003811.18273-13-sbeller@google.com> <CA+P7+xrwxb9G3QVOascSZqnBa_vGEx95nv0jN9USmBqB5Q_Mzw@mail.gmail.com>
 <CAGZ79kahCN2dd9=CzqXJWSJKrkOfvd3HeQ-NORhyP=6B=KCrqg@mail.gmail.com> <CA+P7+xq3XF2=erRLiNjOUq9H66Sa5VCxNBzTF=RAycPYrPRFJg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Feb 2017 15:44:02 -0800
Message-ID: <CAGZ79kbVr5uqwJmzXJxUn0bpe=d_pgnW3_pYW-q0W0iO0KSRtw@mail.gmail.com>
Subject: Re: [PATCH 12/15] unpack-trees: check if we can perform the operation
 for submodules
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 3:35 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Feb 21, 2017 at 2:16 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Fri, Feb 17, 2017 at 10:42 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>> On Wed, Feb 15, 2017 at 4:38 PM, Stefan Beller <sbeller@google.com> wrote:
>>>> +       if (is_active_submodule_with_strategy(ce, SM_UPDATE_UNSPECIFIED))
>>>
>>> Here, and in other cases where we use
>>> is_active_submodule_with_strategy(), why do we only ever check
>>> SM_UPDATE_UNSPECIFIED? It seems really weird that we're only going to
>>> check submodules who's strategy is unspecified, when that defaults to
>>> checkout if I recall correctly? Shouldn't we check both? This applies
>>> to pretty much everywhere that you call this function that I noticed,
>>> which is why I removed the context.
>>
>> I am torn between this.
>>
>> submodule.<name>.update = {rebase, merge, checkout, none !command}
>> is currently documented in GIT-CONFIG(1) as
>>
>>        submodule.<name>.update
>>            The default update procedure for a submodule. This variable is
>>            populated by git submodule init from the gitmodules(5) file. See
>>            description of update command in git-submodule(1).
>>
>> and in GIT-SUBMODULE(1) as
>>
>>        update
>>            [...] can be done in several ways
>>            depending on command line options and the value of
>>            submodule.<name>.update configuration variable. Supported update
>>            procedures are:
>>
>>            checkout
>>                [...] or no option is given, and
>>                submodule.<name>.update is unset, or if it is set to checkout.
>>
>> So the "update" config clearly only applies to the "submodule update"
>> command, right?
>>
>> Well no, "checkout --recurse-submodules" is very similar
>> to running "submodule update", except with a bit more checks, so you could
>> think that such an option applies to checkout as well. (and eventually
>> rebase/merge etc. are supported as well.)
>>
>> So initially I assumed both "unspecified" as well as "checkout"
>> are good matches to support in the first round.
>>
>> Then I flip flopped to think that we should not interfere with these
>> settings at all (The checkout command does checkout and checkout only;
>> no implicit rebase/merge ever in the future, because that would be
>> confusing). So ignoring that option seemed like the way to go.
>
> Hmm. So it's a bit complicated.
>
>>
>> But ignoring that option is also not the right approach.
>> What if you have set it to "none" and really *expect* Git to not touch
>> that submodule?
>
> Or set it to "rebase" and suddenly git-checkout is ignoring you and
> just checking things out anyways.
>
>>
>> So I dunno. Maybe it is a documentation issue, we need to spell out
>> in the man page for checkout that --recurse-submodules is
>> following one of these models. Now which is the best default model here?
>
> Personally, I would go with that the config option sets the general
> strategy used by the submodule whenever its updated, regardless of
> how.
>
> So, for example, setting it to none, means that recurse-submoduls will
> ignore it when checking out. Setting it to rebase, or merge, and the
> checkout will try to do those things?

That is generally a sound idea when it comes to git-checkout.

What about other future things like git-revert?
(Ok I already brought up this example too many times; it should have
a revert-submodules as well switch, which is neither of the current strategies,
so we'd have to invent a new strategy and make that the default for
revert. That strategy would make no sense in any other command though)

What about "git-rebase --recurse-submodules"?
Should git-rebase merge the submodules when it is configured to "merge"
Or just "checkout" (the possibly non-fast-forward-y old sha1) ?

The only sane option IMO is "rebase" as well in the submodules, rewriting
the submodule pointers in the rebased commits in the superproject.

>
> Or, if that's not really feasible, have the checkout go "hey.. you
> asked me to recurse, but uhhh these submodules don't allow me to do
> checkout, so I'm gonna fail"? I think that's the best approach for
> now.

So you'd propose to generally use the submodule.<name>.update
strategies with aggressive error-out but also keeping in mind
that the strategies might grow by a lot in the future (well only revert
comes to mind here).

ok, let's do that then.

Thanks,
Stefan
