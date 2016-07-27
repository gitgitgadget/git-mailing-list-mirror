Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3DC9203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 16:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757097AbcG0QxR (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 12:53:17 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:35438 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbcG0QxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 12:53:16 -0400
Received: by mail-io0-f180.google.com with SMTP id m101so75730582ioi.2
        for <git@vger.kernel.org>; Wed, 27 Jul 2016 09:53:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jbMvY6TL4ap+RFHjUKAYpiTLf6NncVdPi8IporYM4+4=;
        b=Ce0I7cVGDe73lret6+LBSV5msAo1w2BB/c/9xLORZXkcN9Bp5rl96ZuVWF+9E7+3tL
         TQkt7q93Ux2mTUB744bOeY6FAkXspZcDP93AjShnJZ633P/iljvUfybQuMKsWce433xu
         RpxVHDr7NlY9CyMpc3hjP2EtUYUtR8U0bcRLbUQhBHxNq0QouzeoI6ePMbWPe7gUPxgt
         CjX/IhWhxnG2h0dOoFqKcy2hLnioErTvuRozSGvRhipEy+daK7VKdIXujSOMcm8BIx7p
         r3Mwg0N5KNKoKVhYSLCBNaIJ+ySL+Gz66WK5+CHZeyIdz10cQjlJY7QJSBElL/EMDVcp
         bP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jbMvY6TL4ap+RFHjUKAYpiTLf6NncVdPi8IporYM4+4=;
        b=gKJ8mVU4E74beu+nnkE1zmK6U8xX4rXtiYaNCO7ha3HkS4517+C/vT1JyMyUrqni7Q
         lXu7Dwy3NBoqfae5oY5PLpsfVPcQpXR2L5Li75sYPPXBkDDUscdMCUN9af4wELI5UUH0
         7/njf1Sl054QwB+Ktu8RiUxS3yfeBpe33LZad/rAaUK+aW1aGwuS9ojunxyhIOj6Y6H6
         AMMb6RcOZOZfknXIG0+eR/Zu2I127Ny98iksInOjK7RtBkQqumFBmceSziHbviafgV1J
         Tm8nZYd8gduRM159sm4fZIPblsVi3mAMfluK3qYHgbZq4EmP0leGJF68IfnopA31BPFJ
         a3Jg==
X-Gm-Message-State: AEkoouvUz+/bAEQZeaDM+rImzIqG/5pOD4GyrkOV1anVnG9PldZz69RWkVuA+wGbPIhlxjXTzxhHARDkECqYFJi4
X-Received: by 10.107.144.10 with SMTP id s10mr32255989iod.165.1469638394566;
 Wed, 27 Jul 2016 09:53:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 27 Jul 2016 09:53:13 -0700 (PDT)
In-Reply-To: <5798C744.5080308@gmail.com>
References: <CACsJy8ADRWNL3FR2TtWShviT4Lc4m1xaY8VOPP26Foyq+_A-3g@mail.gmail.com>
 <20160720172419.25473-1-pclouds@gmail.com> <20160720172419.25473-4-pclouds@gmail.com>
 <CAGZ79kZB8U+ERNeYpZ-i7Ldip7xbz0ND53g4bzMkzFC3pnyv+w@mail.gmail.com>
 <CACsJy8CSnmnzDMGpMvvkhWRfJvp1L+pfOZ=eYp5JF0GWNH6D0Q@mail.gmail.com>
 <CAGZ79ka-isR4DL7ZqOp8cXE1bmUOnd33yu=pZZHaqNmPWH3PYQ@mail.gmail.com>
 <CACsJy8DKEV3FNmb1vWinRvb-FHSO_VftG7RevQ3TOFhP-Dm0cw@mail.gmail.com>
 <CAGZ79kYbmoKPAPMVkTUycSKVtT6HLK-Y_eGXSX+z69G3+udR8Q@mail.gmail.com>
 <CACsJy8DgeSOh-RScmcrSwy7PgeQXwA2R6w9mRmHzuWR4djg=4w@mail.gmail.com>
 <CAGZ79kYGj7q=SQyHvFdmXasJppTVw56xSBMiSERdx22B+A68gQ@mail.gmail.com> <5798C744.5080308@gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 27 Jul 2016 09:53:13 -0700
Message-ID: <CAGZ79kZtfpmZRyOfF6NMhCqjNBgfH1bX+xWUCEdedQGbCbL71Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] submodule: support running in multiple worktree setup
To:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jakub wrote:
> I think the problem with `--reference` is that it does not
> setup backreferences to prevent gc removing borrowed objects;
> which is a hard problem to solve, except for limited cases...
> like git-worktree.

Right. And instead of solving the reference problem, I'd
rather solve the worktree problem as I think it yields more?

>
>> So I think the current workflow for submodules
>> may need some redesign anyway as the submodule
>> commands were designed with a strict "one working
>> tree only" assumption.
>>
>> Submodule URLs  are stored in 3 places:
>>  A) In the .gitmodules file of the superproject
>>  B) In the option submodule.<name>.URL in the superproject
>>  C) In the remote.origin.URL in the submodule
>>
>> A) is a recommendation from the superproject to make life
>> of downstream easier to find and setup the whole thing.
>> You can ignore that if you want, though generally a caring
>> upstream provides good URLs here.
>
> Also, this URL might have change if the repository moves
> to other server; even when checking out ancient version
> we usually want to use current URL, not the one in currently
> checked-out .gitmodules file.

Right.

>
>> C) is where we actually fetch from (and hope it has all
>> the sha1s that are recorded as gitlinks in the superproject)
>
> Is it? Or is it only the case if you do `git fetch` or
> equivalent from within inside of submodule? You can fetch
> updates using `git submodule ...` from supermodule, isn't it?
> But I might be wrong here.

If you call `submodule update` in the  superproject
it actually just does a `(cd $submodule && git fetch)`.

And in the submodule we have a .git file pointing to
the superprojects ".git/modules/<name>/" which is a full
blown git dir, i.e. it has its own config, HEAD etc.

>
> Also: if .git file is gitfile link, do submodule even has
> it's own configuration file?

Yes they do.

>
>>
>> B) seems like a hack to enable the workflow as below:
>
> It has overloaded meaning, being used both for current URL
> of submodule as seen in supermodule, AND that submodule
> is checked out / needs to be checked out in the worktree
> of a supermodule.  There might be the case when you check
> out (in given worktree) a version of a supermodule that
> do not include submodule at all, but you want to know that
> when going back, this submodule is to be checked out (or not).

I am currently working on solving that with a patch series, that
allows 2 settings. The URL will be used only to overwrite the
URL from the .gitmodules file and another setting will be used
to determine if we want to checkout the submodule.

>
> The second information needs to be per-worktree. How to
> solve it, be it per-worktree configuration (not shared),
> or a special configuration variable, or worktree having
> unshared copy of configuration -- this what is discussed.

>
>> Current workflow for handling submodule URLs:
>>  1) Clone the superproject
>>  2) Run git submodule init on desired submodules
>
> Or 1-2) clone the superproject recursively, with all its
> submodules.

Only if the URLs are setup properly.

>
>>  3) Inspect .git/config to see if any submodule URL needs adaption
>
> Which is usually not needed.

Yeah, I should have added the assertion that the .gitmodules
may be out of date or such for this workflow to make sense.
Usually just go with recursive clone.

>>
>> This long lived stuff probably doesn't make sense for the a single
>> repository, but in combination with submodules (which is another way
>> to approach the "sparse/narrow" desire of a large project), I think
>> that makes sense, because the "continuous integration" shares a lot
>> of submodules with my "regular everyday hacking" or the "I need to
>> test my colleague work now" worktree.
>
> One thing that git-worktree would be very useful, if it could work
> with submodules: you could use separate worktrees to easily test
> if the supermodule works with and without its submodules present.

Oh! Yeah that makes sense!

>
> [...]
>> If you switch a branch (or to any sha1), the submodule currently stays
>> "as-is" and may be updated using "submodule update", which goes through
>> the list of existing (checked out) submodules and checks them out to the
>> sha1 pointed to by the superprojects gitlink.
>
> Which might be simply a problem that submodule UI is not mature enough.
> I would like to see automatic switch of submodule contents, if
> configured so.

Me too. Once upon a time Jens pushed for that with a series found at:
https://github.com/jlehmann/git-submod-enhancements/tree/git-checkout-recurse-submodules
