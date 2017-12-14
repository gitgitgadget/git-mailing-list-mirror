Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705281F404
	for <e@80x24.org>; Thu, 14 Dec 2017 18:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754343AbdLNSYE (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 13:24:04 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:43699 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754063AbdLNSYC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 13:24:02 -0500
Received: by mail-qk0-f171.google.com with SMTP id j207so7372268qke.10
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 10:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=57zgo7AdzClCeOjuDKke5fmqALLvOy/Oep0qx5n09zY=;
        b=aGvzED8FGnoyqQgVzEyNYot5cKOgQNa7vGort9Dtsdra+vVvaEAJpEZamWbTnuLClR
         u16TJFZKmNyRvmXLVy4zHeUEETsCTwfAxCairwzkvdr63khqMtfNRmnVUWS46LZFr8GQ
         EiPpuZ36bUr4iqEZ9M95uTb+PRAWIaMdAO4ADmSyUaCmtKZJgk+26EAGieMeFVdAmQQa
         V3lrpLbXW74wGxjnvJ9C+mLTafsIuOylXdXheHZq+IpLWYQF1iTQXbZtminTBzr3MtJc
         E085fh3aHeXwGMRF1huVVmqx4aJHEKdiruVG/2TxxKJQBEFEvfw2F2dsOSYrSCfUn6jF
         NsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=57zgo7AdzClCeOjuDKke5fmqALLvOy/Oep0qx5n09zY=;
        b=CvEk1AzCeUzlb/iq7e2f8lHWsHIg13nz6DQLhw3BHpe3lu4f9X+D0JmqUTg9AwJ4a6
         ukE1OJW64V8pmFyQSJ8/yzF28OZ6MIPg2a8YUf6DJ0LDUIUq5pzchmHV3jr40bZLffcS
         amVkwxslhDj0RmoKRR6P3b/GcluJj/DlyavhFJPgkGhX2qjToD91Q/otDplke5HJMYT1
         J+vvO7x2ATcAiXuy5KC0O5apO9KezUFvvB8CEdvUBO+ERhN8OurLvmh/XgEZ8HgzVxnD
         mpokWTbCJDFN3zKUVoGLRnTUmci8CUbkaFlqVoAJMzfoTezs6Dk8uA/JR6JYgSnY2EcD
         bsdQ==
X-Gm-Message-State: AKGB3mLLuvw6+sGdUCkiIHvJV7HA7cJElTMBeX0dIs4Fo1cfTiiV5M3U
        lrSFMEzu80nP2snm/uFo75w9loemA2bZRQ1SIj+8KQ==
X-Google-Smtp-Source: ACJfBovKrMRMAWwdeGjk8GwCkbzU09Eu/wwviP3klaLzt8w0YVLxzr4X5gPlvgoxhkh0w84JT6W/VAq9IdkOZSlbDrE=
X-Received: by 10.55.143.134 with SMTP id r128mr16577228qkd.320.1513275841208;
 Thu, 14 Dec 2017 10:24:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Thu, 14 Dec 2017 10:24:00 -0800 (PST)
In-Reply-To: <xmqq6099uqq9.fsf@gitster.mtv.corp.google.com>
References: <E1eOwqn-0005Bd-OB@rmmprod05.runbox> <CA+P7+xrWFE+6t-Z8cGQX5WtZP1_EQSa+J7vF65dLDSOnLfFxXQ@mail.gmail.com>
 <01075529-4B7B-4C05-927F-0504315F2B3F@dwheeler.com> <CACBZZX5XDKwwXWtH8V9QD5v-4i+nHPuZ8x2n_Z3zuexQmg2mgw@mail.gmail.com>
 <xmqq6099uqq9.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 14 Dec 2017 10:24:00 -0800
Message-ID: <CAGZ79kZeMVLesunBzW5hhN-snL8fBXdjPgy=Tt8JCDmhDePDZA@mail.gmail.com>
Subject: Re: [PATCH] doc: Modify git-add doc to say "staging area"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "David A. Wheeler" <dwheeler@dwheeler.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 14, 2017 at 10:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Dec 13, 2017 at 6:46 AM, David A. Wheeler <dwheeler@dwheeler.com=
> wrote:
>>> On December 13, 2017 12:40:12 AM EST, Jacob Keller <jacob.keller@gmail.=
com> wrote:
>>>>I know we've used various terms for this concept across a lot of the
>>>>documentation. However, I was under the impression that we most
>>>>explicitly used "index" rather than "staging area".
>>>
>>> I think "staging area" is the better term. It focuses on its purpose, a=
nd it is also less confusing ("index" and "cache" have other meanings in ma=
ny of the repos managed by git).
>>
>> After your patch the majority of the docs will still talk about
>> "index", is this part of some larger series, perhaps it would be good
>> to see it all at once...
>
> ... or none of it.  I do not quite see a point of spending list
> bandwidth on a change like this one.

I think wording (as well as its consistency) in the documentation
is rather important.

Just the other day I was reading[1], yet another blog explaining
why git sucks. TL;DR:
(1) (a) The staging area is an advanced concept
    and should be disabled by default
    (b) and is documented super confusingly.
(2) Branches and Remotes Management is
    Complex and Time-Consuming
(3) its ecosystem (GitHub et al.) is not pushing for
    innovation, because "forks are not the right model".

[1] https://gregoryszorc.com/blog/2017/12/11/high-level-problems-with-git-a=
nd-how-to-fix-them/

When I saw the original patch, I assumed it was a reaction to this
blog and attempting to fix (1b), but maybe it is unrelated.

Anyway I think spending list band width on good documentation is
not bandwidth wasted.

Stefan
