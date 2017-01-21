Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 316A31F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 12:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbdAUMtW (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 07:49:22 -0500
Received: from mail-ot0-f182.google.com ([74.125.82.182]:34791 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbdAUMtV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 07:49:21 -0500
Received: by mail-ot0-f182.google.com with SMTP id f9so73913811otd.1
        for <git@vger.kernel.org>; Sat, 21 Jan 2017 04:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D/a157OpOPSPyd3ueA33ipOSdgGD64He1ZC2TyiQxC0=;
        b=OWc6TJF2foazKJ/QVaOgLN49kwaWl6N6r5xbrYzE6VbcmqJP81geZ3pegJSoNjpDer
         S5GJn5Zd9NeN5PHz1IXJswKip/IIrdU4RBCJSAt8t/J2O/U6WNB3pNhcPtesoUnDpfW/
         pNIzjFYdpVWt/xTz+aaSwVOVGUj7Vsni+4hgCANS4QU0ERe0LWZ88nyolMkm3LQxr20M
         oFRxXULRBvqMTaFazJIC0rW4RjBTdVNnSdZmj7hFRrdSURJegLbfKdPbsVcWS9IQpFmY
         ftWCsuZ/pbZndbPUt5aRB6r9fKy+ICKfO6xiinkIngno3eyxEZLafYjEq9N3Fb/VNCWW
         8ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D/a157OpOPSPyd3ueA33ipOSdgGD64He1ZC2TyiQxC0=;
        b=qvBS1tWUmI8mrn2Ro2Gj/fO0Fliukeg4GmCfCTWQSkuCmo1K6u1W0B/KNXG/Dfc6IG
         dkD3afFpaOVk+WViRBwA1zYfvqs2Cz4fkKO/aqhD/vr5oPL3wzwvQBTgCXuLS98iGPMp
         X6GiKahN1NuBclbg1auvAwtLU/0NX2eCk9C65w8skhehjE5PjyGRYuI52I76KhaAFEdg
         duFW64El6xsM+ZZL/HUF+PTD2XIH5NLusK35T3le7ROM/D8f+ZtFpXdJlgourA24yhGf
         Sdr77cyQZELf2Gx5nqwwCoXI+k2j/vQVKP96ikP8rWcScHejAIc6MZ3+G9DolWOO8u2j
         4ekQ==
X-Gm-Message-State: AIkVDXKoQzpfgafNmsyTu32DUWvWDGs9nI3E7gUhYQ3c0P/a3Mpx0OSAayHJjFLWY+D/rI6JQ62cxBft9YWj6w==
X-Received: by 10.157.9.214 with SMTP id 22mr9109520otz.128.1485002960614;
 Sat, 21 Jan 2017 04:49:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Sat, 21 Jan 2017 04:48:50 -0800 (PST)
In-Reply-To: <CA+P7+xqgyUW-Wt2oUSCc86HG-MfL-itAu2yVrZ219LNwqQnwKw@mail.gmail.com>
References: <20170119122630.27645-1-pclouds@gmail.com> <20170119172310.6meuj6ksxloeee2t@sigill.intra.peff.net>
 <CACsJy8A_LkRMZYfoJuYEUok4r7Tw0VuMwVkG_Kr1o1hFcAUWNw@mail.gmail.com>
 <20170120143031.p2mux5uxxzniovkx@sigill.intra.peff.net> <CA+P7+xqgyUW-Wt2oUSCc86HG-MfL-itAu2yVrZ219LNwqQnwKw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 21 Jan 2017 19:48:50 +0700
Message-ID: <CACsJy8C41D0Qb0ZJoAPJ6Pwp904dVixUR9yXQmZr0NU9W-BU8A@mail.gmail.com>
Subject: Re: [PATCH] log: new option decorate reflog of remote refs
To:     Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 21, 2017 at 5:00 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Fri, Jan 20, 2017 at 6:30 AM, Jeff King <peff@peff.net> wrote:
>>> Imposing order between options could cause confusion, I think, if you
>>> remove --decorate-reflog leaving --remotes on by accident, now you get
>>> --remotes with a new meaning. We could go with something like
>>> --decodate-reflog=remote, but that clashes with the number of reflog
>>> entries and we may need a separator, like --decorate-reflog=remote,3.
>>> Or we could add something to --decorate= in addition to
>>> short|full|auto|no. Something like --decorate=full,reflog or
>>> --decorate=full,reflog=remote,entries=3 if I want 3 reflog entries.
>>
>> I agree that making option-order important is potentially confusing. But
>> it does already exist with --exclude. It's necessary to specify some
>> sets of refs (e.g., all of A, except for those that match B, and then
>> all of C, including those that match B).
>>
>> Having --decorate-reflog=remote would be similarly constrained. You
>> couldn't do "decorate all remotes except for these ones". For that
>> matter, I'm not sure how you would do "decorate just the refs from
>> origin".
>>
>> I'll grant that those are going to be a lot less common than just "all
>> the remotes" (or all the tags, or whatever). I'd just hate to see us
>> revisiting this in a year to generalize it, and being stuck with
>> historical baggage.
>>
>>> My hesitant to go that far is because I suspect decorating reflog
>>> won't be helpful for non-remotes. But I'm willing to make more changes
>>> if it opens door to master.
>>
>> Forgetting reflogs for a moment, I'd actually find it useful to just
>> decorate tags and local branches, but not remotes. But right now there
>> isn't any way to select which refs are worthy of decoration (reflog or
>> not).
>>
>> That's why I'm thinking so much about a general ref-selection system. I
>> agree the "--exclude=... --remotes" thing is complicated, but it's also
>> the ref-selection system we _already_ have, which to me is a slight
>> point in its favor.
>>
>> -Peff
>
> I agree that the interaction between --exclude and --remotes/etc is
> confusing, but I think it's reasonable enough because we already
> support it, so it makes sense to extend it with this. I also think its
> better to extend here than it is to hard-code it.

OK. Next question, how do we deal with the reflog count (i..e the
argument of --decorate-remote-reflog). Should it be shared for all ref
type, or can be specified differently for remote, local and tags? I'm
leaning towards the former. But I'll wait a bit for ideas before
rewriting the patch.
--
Duy
