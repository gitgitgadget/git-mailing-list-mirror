Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D12041F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 17:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeJJA4Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 20:56:16 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:35662 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJJA4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 20:56:16 -0400
Received: by mail-ed1-f48.google.com with SMTP id y19-v6so2490939edd.2
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 10:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7mwNdoo1fhI6dY3SvRc7t+1whVUzw1wrdVztjjzyzD0=;
        b=SHZL8AfZUhTJ2p/F9Nbr6qlOZoGxWuBvBWSgqWp5XDr83VZ5Ggh+hcuZibmfZwzSft
         3SJ9S4lhl9rA3T28nwX1b4HOIxYIsHNfEjZiusB98iTkFuWlzKgCF550PBeVtMcDSou5
         I3VEGhs8gyA3qTM21KWEokwYK05O+N+SbG03W4KoQZhKJbSD68l4KhYdNUNG01in6rMb
         CAJBKmbgdXUqPfCTlRbMTNrH6shdQmVT9jgfksL6Kj85tSa/NgDk9KtSbYt2HToj8yWi
         HJN4nfPSHrM3ueTRlq0/4htfa7S2570SS8o7vPmqq+WIaMn81Xikds7OZhqvGFrDrW3h
         bfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7mwNdoo1fhI6dY3SvRc7t+1whVUzw1wrdVztjjzyzD0=;
        b=mQjrr+7JI6hiUOqbtwAtWMjP08BJvVvFZglpSAGURazkF8N77LlyxCBPW5vFxOV+DN
         8rn959LPHeVASeLxR6Q/W6drss3jgVPru7lRO6J/jWG2Q5xG3ypeSDne8fH8D1zlrprj
         xLzLt8Fu+1XXxBYuYxVC+5pX9Awphdsf3/MRbNIEy112Qxqq+26QqkPaLnskugRDn1hh
         5OFUH0vq7hoCfgjNWd6uPF+3eIqAt7xZFte0cLqXH4bKPBmlg5IVcsuoo+ENv1IcPTBH
         0RITF3SoUuKLKLliO8ZlQRPpS7QrvSClIAQfMzNexoz+7sEujPwcn3M1ebZUhICfRbQb
         H/vQ==
X-Gm-Message-State: ABuFfojyG55wJsZL8mLgkCAEBuvJsLoHKzbVvEDBf2hrj18So4Egac1d
        uE/Uug84W6LMmQ5BzCGos0QzynbFUtT31getJyLcaA==
X-Google-Smtp-Source: ACcGV63FzLqolWFyXAVQesgE9LxxGMfPvVi9kxkWJ1owoKtyO3PxbiokaqFH6n684euNucpkXyfBhrwmkaD453HvASM=
X-Received: by 2002:a50:bc12:: with SMTP id j18-v6mr15090030edh.154.1539106690927;
 Tue, 09 Oct 2018 10:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
 <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
 <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
 <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <87k1mta9x5.fsf@evledraar.gmail.com>
 <xmqqpnwltu8s.fsf@gitster-ct.c.googlers.com> <xmqqlg79tta8.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kZq3xtsbscrRFD8CSn++yrvdM6Ux+nkQ3AamgabXtPL+w@mail.gmail.com> <xmqq4ldwszh8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4ldwszh8.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 9 Oct 2018 10:37:59 -0700
Message-ID: <CAGZ79ka5kKrSqPCWFMDetRLYxDqcguJUzJXDex9q-VMwT-ABAw@mail.gmail.com>
Subject: Re: What's so special about objects/17/ ?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        nico@cam.org, Nick Alcock <nix@esperi.org.uk>,
        koreth@midwinter.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 8, 2018 at 6:03 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > On Sun, Oct 7, 2018 at 1:07 PM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Junio C Hamano <gitster@pobox.com> writes:
> >
> >> > ...
> >> > by general public and I do not have to explain the choice to the
> >> > general public ;-)
> >>
> >> One thing that is more important than "why not 00 but 17?" to answer
> >> is why a hardcoded number rather than a runtime random.  It is for
> >> repeatability.
> >
> > Let's talk about repeatability vs statistics for a second. ;-)
>
> Oh, I think I misled you by saying "more important".
>
> I didn't mean that it is more important to stick to the "use
> hardcoded value" design decision than sticking to "use 17".  I've
> made sure that everybody would understnd choosing any arbitrary byte
> value other than "17" does not make the resulting Git any better nor
> worse.

Yes, I totally get that. We could have chosen 42 just because.


>  But discussing the design decision to use hardcoded value is
> "more important", as that affects the balance between the end-user
> experience and debuggability, and I tried to help those who do not
> know the history by giving the fact that choice was made for the
> latter and not for other hidden reasons, that those who would
> propose to change the system may have to keep in mind.

From an end users point of view, the auto gc kicks in at random.
(Maybe it's just me, but I don't keep track of the loose object count ;-)

For debuggability, we could design a system that allows for debugging,
e.g. "When GIT_AUTO_GC_BIN is set, use the number as set, otherwise
take a random slot".

> Sorry if you mistook it as if I were saying that it is important to
> keep the design to use a hardcoded byte value.  That wasn't what the
> message was about.

I understood very well that the choice of value was arbitrary and you
do not have a convincing story as to why 17 (and not say 23, but such
a story is not required, as all slots are equal from a design perspective).

I do challenge the decision to take a hardcoded value, though, as it
yields better properties for the end users IMHO, whereas debugging
this specific case does not seem to be important to me.
