Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18BAB202A3
	for <e@80x24.org>; Wed, 18 Oct 2017 17:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbdJRR5A (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 13:57:00 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:48814 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdJRR47 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 13:56:59 -0400
Received: by mail-qt0-f171.google.com with SMTP id f8so11328054qta.5
        for <git@vger.kernel.org>; Wed, 18 Oct 2017 10:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1UkF0P/pGUiS7K7P8b4Qn0zBtmKc7j1Ds8UvpjwovFA=;
        b=f4PAHmTDfNFpENBxoeF1NUbGKy2iO8+e0bjbEcN3NpoNzAWxBICr4BedOuFm9RlhWJ
         Fn++Yt01CHmHMlb73URK3o0OdAgRqvZm6J2DOc/lCc4xvqQOnPhXtjnlrc6pqXUy4BLd
         zwlMaVzHtMOZ+cn021Lt9xugnmkkp/+IeGN/ieGfsjix23e6u2Voo00eD/X75xAZ/44V
         96I9UxUfVinJ9K5Cg/kNRNv5haNYAIA0sWWdJFaEMTqGAl8yo6qhycefDwHG6XhPbQEp
         DxxXPgq6WTEMIlyhWGwOfZoPdSoScduqfBnOJ30W6Xmrf/PkkQh9bidop/ttyGSBF+E0
         myOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1UkF0P/pGUiS7K7P8b4Qn0zBtmKc7j1Ds8UvpjwovFA=;
        b=OsaK939kBbkzPUAMBA392ZjizNtLJVc/Po4bekQ5tzNNQ1glh2qm+X9fOfEj2b5F88
         tEKuOtphl6ccllRhLSX8Kw+afo8FlTQQCXMMilsvivWumwSmlhMnr10+EPl5CVbDfzQx
         F9JY42aUv/X3lo2Xd6ixGARBZ4+X5joW2len6JFDmn05wBuGZBiEuc+tceVVBL9yGBkI
         yDp8Ykxny2YovM+soTlyFm95fHO6lJ0llxk24rKI+Q+wVEJmpV0gKZpQG2TUvn76LOmk
         yB4kWO+Xw7hYnVR0kfWEnoFpADg4ns2Bj9Pv3qWLKKh7JBUNmfaQeXhiDDxU8twv1Mt9
         MyoQ==
X-Gm-Message-State: AMCzsaWZuS3q2s8HgdxDlbwBKC9Z09W+ygLyJodMSQL9PfmucuztjD5B
        JES4Z2olTg75Cf4lljc75lSCxqnbsF93A71BgQmKmg==
X-Google-Smtp-Source: ABhQp+Rk2lksCcLurJoGn0JpJcocQp7vr6ETuVYHTmW74vGk1+y2L6v3vXh3fKGkI7ctRcluHthxt3ueYLtRPEq9Kgw=
X-Received: by 10.237.37.71 with SMTP id w7mr4320425qtc.299.1508349418718;
 Wed, 18 Oct 2017 10:56:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 18 Oct 2017 10:56:58 -0700 (PDT)
In-Reply-To: <xmqqfuahmif9.fsf@gitster.mtv.corp.google.com>
References: <20171016135623.GA12756@book.hvoigt.net> <20171016135827.GC12756@book.hvoigt.net>
 <CAGZ79kZsQoU8wJk+i5aJOxFtsD=EWu_ycEPLM1KhTaOCWD7Y2w@mail.gmail.com> <xmqqfuahmif9.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Oct 2017 10:56:58 -0700
Message-ID: <CAGZ79kaTXC9Eius3jMZGefZioJtS-uuf+ar5zt=WSEWQJxdcwQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] implement fetching of moved submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 17, 2017 at 5:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> +                       /* make sure name does not collide with existing one */
>>> +                       submodule = submodule_from_name(commit_oid, name);
>>> +                       if (submodule) {
>>> +                               warning("Submodule in commit %s at path: "
>>> +                                       "'%s' collides with a submodule named "
>>> +                                       "the same. Skipping it.",
>>> +                                       oid_to_hex(commit_oid), name);
>>> +                               name = NULL;
>>> +                       }
>>
>> This is the ugly part of using one string list and storing names or
>> path in it. I wonder if we could omit this warning if we had 2 string lists?
>
> We are keying off of 'name', because that is what will give a module
> its identity.  If we have a gitlink whose path is not in .gitmodules
> in the same tree, then we are seeing an unregistered submodule.

Right, so it has no submodule specific identity and we chose to "fake it"
by pretending its path is its name. However this requires checking as
there might be overlap in the name-namespace and the path-namespace.


>  If
> we were to "git add" it, then we'd use its path as the default name,

I presume "git submodule add"

> but if we already have a submodule with that name (the most likely
> explanation for its existence is because it started its life there
> and then later moved), and the submodule is bound to a different
> path, then that is a different submodule.  Skipping and warning both
> are sensible thing to do.

Skipping and warning is sensible once we decide to go this way.

I propose to take a step back and not throw away the information
whether the given string is a name or path, as then we do not have
to warn&skip, but we can treat both correctly.

As we only need to store an additional boolean (is it path or name?),
I had suggested to just use two lists, one for key-by-name and one
key-by-path, where we intend to use the key-by-name for submodules
and the by-path only for those with no name (i.e. lone gitlinks), hence
making this a "fallback list"

>
> I do not know what you see as ugly here,

the necessity of warn&skip instead of having a solution that
works in corner cases just fine.

> and more importantly, I am
> not sure how having two lists would help.

The current situation is that we use the path of the submodules only,
which makes it work without warn&skip, but it has other disadvantages
(i.e. new & moved submodules are not detected), which we want to fix.

We can add this functionality without caving in to skip the corner case
by storing an additional bit of information. The renaming is detected by
having a constant name before and after, just the path changed.
So we could continue to use by-path logic and only have the name
for rename detection. However that seems to be ugly, too. So we
seem to think that the by-name is better (as it is more in line with what
we think should happen, it is easier to explain, review and maintain(?)).

So we could have by-name keys, with the extra information of whether the
key is genuine or a "fake" key, which is t be resolved to a path instead.
And as that is just one bit, I proposed two lists for that.

Do I miss an essential part here?

Thanks,
Stefan
