Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 162D2201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 23:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752875AbdBUXfn (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 18:35:43 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34756 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752000AbdBUXfl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 18:35:41 -0500
Received: by mail-lf0-f50.google.com with SMTP id g134so28497616lfe.1
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 15:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wMLBsuA9YLnYkXu6viOR7lVyS9FBsWfZhfZyom9qY5k=;
        b=veWCUqQ8bMk0+5Maevf1Hj9gHlLNEef+y6OJfDK3FMGdy50RXttNVYy+V3wurPen4A
         avwNYCViOdb99aOQt+lQkr3VxMkafmvAQdfo5qjgV232X7CfKl7XPkc3+pJtAUDNDbIB
         cE0s0kpLuegSOglFlf+ykyCdXf/AZUjwzQp7+WH7Ylzy1JCwtYpr3nTuUBlmQMgoPJEl
         O54yy83A5BfVql/20oRoKW4uZeMvBpoAm8YzIY8h8rVpscjjxUpZiWPOPbxacsAcf20g
         c3g2j62qtudTzX050tQ3YZLPCG4EcOlv9xKBezZGZnmqBoOCX8UPkaFlWt2J5REdFnkO
         iiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wMLBsuA9YLnYkXu6viOR7lVyS9FBsWfZhfZyom9qY5k=;
        b=jIc/e8Ae0dC4rsMGlgwXQUE2zzmy6I78vnF+HAS1yOY9MH8zvnIDwRCdqp7FxRJpj+
         BMht8qlhKeyx1BKkwzO14CBtwtAIb+pUDJaWcrT3MgDRCp52F4/erNag3Vj62nqdjXJK
         VweIEVvGnlJAXszWd3B7lW8oIHQFSjsD9pkN/3xDqTN+HwxEHgiFJ9Hlmqfo2dWiFkU8
         DfUC2SKZ7JvSQx03Jm9XpAqDn7HaecUvFh9bH4jlKGi3PicoA7Qm4lAF241+FU0+oBQl
         UGGtom4erP5lZ+Xr2s9oeOEqg0ZGi3te7E3ZMTfwF0LWyXXvzQ/n7Ry0cGPk8HIK+Xay
         cZXA==
X-Gm-Message-State: AMke39lezzjW01lbYC3rq9geKDh0d9Edqn2+6IuGRSJ8CkYSiHtJl/Y0abbq5Pmpje6txkTv2oVzUsNBgoSJxg==
X-Received: by 10.46.80.29 with SMTP id e29mr7634781ljb.121.1487720138928;
 Tue, 21 Feb 2017 15:35:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Tue, 21 Feb 2017 15:35:18 -0800 (PST)
In-Reply-To: <CAGZ79kahCN2dd9=CzqXJWSJKrkOfvd3HeQ-NORhyP=6B=KCrqg@mail.gmail.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com> <20170216003811.18273-1-sbeller@google.com>
 <20170216003811.18273-13-sbeller@google.com> <CA+P7+xrwxb9G3QVOascSZqnBa_vGEx95nv0jN9USmBqB5Q_Mzw@mail.gmail.com>
 <CAGZ79kahCN2dd9=CzqXJWSJKrkOfvd3HeQ-NORhyP=6B=KCrqg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 21 Feb 2017 15:35:18 -0800
Message-ID: <CA+P7+xq3XF2=erRLiNjOUq9H66Sa5VCxNBzTF=RAycPYrPRFJg@mail.gmail.com>
Subject: Re: [PATCH 12/15] unpack-trees: check if we can perform the operation
 for submodules
To:     Stefan Beller <sbeller@google.com>
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

On Tue, Feb 21, 2017 at 2:16 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Feb 17, 2017 at 10:42 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Wed, Feb 15, 2017 at 4:38 PM, Stefan Beller <sbeller@google.com> wrote:
>>> +       if (is_active_submodule_with_strategy(ce, SM_UPDATE_UNSPECIFIED))
>>
>> Here, and in other cases where we use
>> is_active_submodule_with_strategy(), why do we only ever check
>> SM_UPDATE_UNSPECIFIED? It seems really weird that we're only going to
>> check submodules who's strategy is unspecified, when that defaults to
>> checkout if I recall correctly? Shouldn't we check both? This applies
>> to pretty much everywhere that you call this function that I noticed,
>> which is why I removed the context.
>
> I am torn between this.
>
> submodule.<name>.update = {rebase, merge, checkout, none !command}
> is currently documented in GIT-CONFIG(1) as
>
>        submodule.<name>.update
>            The default update procedure for a submodule. This variable is
>            populated by git submodule init from the gitmodules(5) file. See
>            description of update command in git-submodule(1).
>
> and in GIT-SUBMODULE(1) as
>
>        update
>            [...] can be done in several ways
>            depending on command line options and the value of
>            submodule.<name>.update configuration variable. Supported update
>            procedures are:
>
>            checkout
>                [...] or no option is given, and
>                submodule.<name>.update is unset, or if it is set to checkout.
>
> So the "update" config clearly only applies to the "submodule update"
> command, right?
>
> Well no, "checkout --recurse-submodules" is very similar
> to running "submodule update", except with a bit more checks, so you could
> think that such an option applies to checkout as well. (and eventually
> rebase/merge etc. are supported as well.)
>
> So initially I assumed both "unspecified" as well as "checkout"
> are good matches to support in the first round.
>
> Then I flip flopped to think that we should not interfere with these
> settings at all (The checkout command does checkout and checkout only;
> no implicit rebase/merge ever in the future, because that would be
> confusing). So ignoring that option seemed like the way to go.

Hmm. So it's a bit complicated.

>
> But ignoring that option is also not the right approach.
> What if you have set it to "none" and really *expect* Git to not touch
> that submodule?

Or set it to "rebase" and suddenly git-checkout is ignoring you and
just checking things out anyways.

>
> So I dunno. Maybe it is a documentation issue, we need to spell out
> in the man page for checkout that --recurse-submodules is
> following one of these models. Now which is the best default model here?

Personally, I would go with that the config option sets the general
strategy used by the submodule whenever its updated, regardless of
how.

So, for example, setting it to none, means that recurse-submoduls will
ignore it when checking out. Setting it to rebase, or merge, and the
checkout will try to do those things?

Or, if that's not really feasible, have the checkout go "hey.. you
asked me to recurse, but uhhh these submodules don't allow me to do
checkout, so I'm gonna fail"? I think that's the best approach for
now.

>
> Thanks,
> Stefan
