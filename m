Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980312023D
	for <e@80x24.org>; Mon, 22 May 2017 22:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760378AbdEVWtJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 18:49:09 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36292 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760295AbdEVWsw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 18:48:52 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so95285605pfg.3
        for <git@vger.kernel.org>; Mon, 22 May 2017 15:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LVtZKrOgaJl39BxjU/BzYJVSw3wv1W3PiT/RV4KTvaE=;
        b=wS8OWtZvKlbbb6+oMrQ5rSOkvguUOar1NQNeQkMtIt9hg0zF95U1FzrO3MgnBJxJ7J
         jmWXGkcLk6dYyDjagKsEHieyD8oXHA9QY2l1+NBVPQdPlbtirCLPVMnQqB801JDFHZts
         4tzsgldfYadVocczc4KXmNlEFK24bARZtOBNW4q+FXdJANcPnLfh8G/DtPOobJGHOFnX
         ONOnp21WMfRvX0ETVpGnllYEDyKy5jSRc4vMdUuEjl6swL2GNfvq5ncCQSDu2KTa25r7
         IlrZXEB1fS0pmdaHWlIryOAQZW6UFOASbN69KKXF9/HR/os5KAjEztCT6fopTZ3RHPXm
         VMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LVtZKrOgaJl39BxjU/BzYJVSw3wv1W3PiT/RV4KTvaE=;
        b=JXrcsCE3PpuNEjGD+Esm+xjrYce0GrmVpL487whO08OOTF5ItQNjUa6u07VRs0BDAW
         wy2CCGFD1kjlNEOvPMH6D9qQ8EbDbl0xZ9GzyosIW607d59hX8SBOLSk+95B2q/3S+aj
         yg07ZrrEj/7Ydo2kGm/dQvPoNUUwOSE2cYw/fkqGvUMJ9KR0lwar87roZHUlKDjN72wZ
         ZkiN9DmKEziC/DS3F91I4cbyYaGlD+yU4wNl4X0x8h54FvlaMawmbfi8KaF+qTWVH5iy
         dAFL1KISoFdHvmRQpopQ67mW9HKqYSmXZDLuS8hj17AFagDVD4ZKPSqfXonD1SBfXuxv
         dh0w==
X-Gm-Message-State: AODbwcDQfuhwFXUeoyd23RcEMFls5ULofZ8A6gmj/XCx8ZLFkLBIvo7w
        HWtVx1y5l8WnIuRwE5cibhvRL5X2u1U5Y5jDIQ==
X-Received: by 10.98.205.65 with SMTP id o62mr27858306pfg.105.1495493326435;
 Mon, 22 May 2017 15:48:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Mon, 22 May 2017 15:48:45 -0700 (PDT)
In-Reply-To: <xmqqbmqko7c2.fsf@gitster.mtv.corp.google.com>
References: <xmqqpof3srw4.fsf@gitster.mtv.corp.google.com> <20170520115429.12289-1-avarab@gmail.com>
 <xmqqbmqko7c2.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 22 May 2017 15:48:45 -0700
Message-ID: <CAGZ79kb9Ca6QtyRzOW-1Q-E+7Z+PB7+MBtj4KvZx-mV36opWpA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Update sha1dc from upstream & optionally make it a submodule
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 22, 2017 at 3:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> I liked the suggestion to make the URL a relative path, but this would
>> require you to maintain a mirror in the same places you push git.git
>> to, is that something you'd be willing to do?
>
> After thinking about this a bit more, I know what I think we want a
> bit better.
>
> Relative URL (e.g. ../sha1collisiondetection that sits next to the
> copy of git.git) may be a good way to go.  I can arrange to create
> necessary repository next to git.git on k.org and github.com but I
> need to double check about other places

And here we see another deficit with a single URL:
We have to abide by the same scheme at all hosting endpoints.

For example consider the host https://kernel.googlesource.com/pub/scm/git/g=
it
that mirrors from kernel.org. It would be able to bind the
submodule at  https://kernel.googlesource.com/pub/scm/git/git/sha1dc
i.e. it would look like a subdirectory of the main git repo.

This is not an issue for our desired usecase, as all hosts can comply
with the scheme that you outlined (url=3D../sha1...), but worth noting that
in the long term we may want to have the ability to "configure" each
remote individually by having out-of-history config options. I think we
would want to solve that via a "refs/meta/gitmodules" branch that can be
adapted per remote. (original idea from jrnieder@)

> Whether the submodule is referenced by a relative URL from the main
> project, the submodule should not come directly from the upstream,
> and various mirrors that sit next to git.git should not be blind and
> automated "mirrors".

That sounds reasonable for our sanity.

> This is because I do not want us to trust the
> security measures of https://github.com/cr-marcstevens/ repository.
> The consumers already need to trust k.org/pub/scm/git/git.git and by
> ensuring k.org/pub/scm/git/sha1dc is managed the same way, they do
> not have to trust anything extra.

The trust would be transitive, as the said submodule is referenced via
sha1, so all malicious actions upstream could perform are:
* denial of service: (by remove a commit that we pointed at in our history)
* denial of service 2: add a huge blob to their repo, such that anyone
  obtaining the submodule not carefully is annoyed by a super large repo.
* add additional malicious data (such as illegal numbers and algorithms)
  to a branch, which would be obtained by users cloning the submodule
  carelessly.

> Another reason is that we want to make sure all commits in the
> submodule that we bind to the superproject (i.e. git.git) are always
> in the submodule, regardless of what our upstream does, and one way
> to do so is to have control over _our_ canonical repository for the
> submodule.

By having all repos under one entity of trust, we would not need to discuss
all kinds of possible attacks as above.

>  In normal times, it will faithfully follow the upstream
> without doing anything else, but we'd keep the option of anchoring a
> submodule commit that is referenced by the superproject history with
> our own tag, if it is ever rewound away in the upstream history for
> whatever reason.

That makes sense.

Thanks,
Stefan
