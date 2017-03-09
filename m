Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 943251FBEC
	for <e@80x24.org>; Thu,  9 Mar 2017 10:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932192AbdCIKvH (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 05:51:07 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:33332 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbdCIKvE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 05:51:04 -0500
Received: by mail-it0-f65.google.com with SMTP id g138so9626619itb.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 02:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xsXOtJGFonlJnoV1Amm1ssVHVYoNcnHqd+Q14Z9LGOs=;
        b=fiKNHFBA0yHckgARbk1q03pOe2ONqLx/x2Ul3RkFdzSYAs2+spvUKXpKyzKxSPDfLf
         Hpet1yGxNaDpGWtEOPHKOFmkV3CcmHs5SO+fdFgA+/Oz4ENPx80GtW0C9LjWRROg3Yd9
         Cxl66jV7Yfg2BVFunLhXrWT1vvjKxlnJ5e8juG5KMI+rG165O+cfP1a3qJXX4Wb5yDyY
         NVErJNZZ/qPLAUsRlpt9WizFd2snE4c8vsz5Ef5KGdm+hr+XVVmxYofRl9EfATkr7odE
         8Z7BzgZBRzciuLIlEhhjRX3paTexTAybnsT3/CILNsLEjDspjxLi8DitjBKd9t+gJ/fN
         dfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xsXOtJGFonlJnoV1Amm1ssVHVYoNcnHqd+Q14Z9LGOs=;
        b=Ps/9wjp6BwEElcOa3+NZcdm/4+e0YbQKAZ66R3qNoIgtyxX9+01vGCRYxqn2mphQuL
         KLJYm9vwg9LHf32I6Ad1yTloC5RoZKX5GKfVqWQNRubzuGaB+x0jouysqhGXh32B+hQS
         fferRBbfsKeLRIPqvDZ1fz2gUr3Bdpi6HQ9A1ADwyMTshJXKc89e5+LoeEyfflDSUCU2
         8Opr1Lq6+/vCzOAS0HpZ8AHI7p6EGcY0llnP8d43kUvms0ZKRiclqzj0wkCyu59MngHT
         I6gqwO/cPSGSz/kxQqdCclMVhKzDfHM+jnZ10PBKi+cwE8Bd29+Nymz22D254B8SBwo5
         Ijeg==
X-Gm-Message-State: AMke39l4yqpL/Mqs75sjlBfwDOoHnDFbPrcClMA1TB0QkpdepeaOlrZw6RGBKjwPgk3DuYBWkU8cpXbz3MvF8w==
X-Received: by 10.36.181.65 with SMTP id j1mr10076857iti.91.1489056140420;
 Thu, 09 Mar 2017 02:42:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Thu, 9 Mar 2017 02:41:59 -0800 (PST)
In-Reply-To: <20170309100910.z4h7bwqzxw2xynyu@sigill.intra.peff.net>
References: <20170308202025.17900-1-avarab@gmail.com> <20170309100910.z4h7bwqzxw2xynyu@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 9 Mar 2017 11:41:59 +0100
Message-ID: <CACBZZX53rMiB5-cA_7-SeU2Dt7d_Cr7_GgyC0rjQQPPf4qyCqw@mail.gmail.com>
Subject: Re: [PATCH] branch & tag: Add a --no-contains option
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 9, 2017 at 11:09 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 08, 2017 at 08:20:25PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Change the branch & tag commands to have a --no-contains option in
>> addition to their longstanding --contains options.
>>
>> The use-case I have for this is mainly to find the last-good rollout
>> tag given a known-bad <commit>. Right given a hypothetically bad
>> commit v2.10.1-3-gcf5c7253e0 now you can find that with this hacky
>> one-liner:
>>
>>     (./git tag -l 'v[0-9]*'; ./git tag -l 'v[0-9]*' --contains v2.10.1-3=
-gcf5c7253e0)|sort|uniq -c|grep -E '^ *1 '|awk '{print $2}'
>>
>> But with the --no-contains option you can now get the exact same
>> output with:
>>
>>     ./git tag -l 'v[0-9]*' --no-contains v2.10.1-3-gcf5c7253e0 | sort
>
> I think that's a good goal.
>
> I'm not sure about the name. I would have expected "--no-contains" to
> reset the list of "--contains" commits to the empty set. That's an
> option convention we've been slowly moving towards (e.g., with
> OPT_STRING_LIST).
>
> What you've added here _does_ match "--no-merged", though. I'm not sure
> of the best way forward. At the very least, "--no-contains" is currently
> an error, so you would not be changing existing behavior.

I initially started hacking this up as --not-contains, but after
briefly chatting with Christian about it off-list he suggested --no-*.
Since as you point out it's consistent with --no-merge. I have no
strong view on it, I just want the feature whatever the flag is
called.

>> Once I'd implemented this for "tag" it was easy enough to add it for
>> "branch". I haven't added it to "for-each-ref" but that would be
>> trivial if anyone cares, but that use-case would be even more obscure
>> than adding it to "branch", so I haven't bothered.
>
> I'd prefer to have it consistently in all three. We should be able to
> tell people to use for-each-ref in their scripts, and that's harder if
> it is missing features.

Agreed. I'd already hacked that up this morning for a v2. It works &
has tests at https://github.com/avar/git/tree/avar/no-contains-2

>> The "describe" command also has a --contains option, but its semantics
>> are unrelated to what tag/branch/for-each-ref use --contains for, and
>> I don't see how a --no-contains option for it would make any sense.
>
> Yeah, I think that feature is orthogonal.

*Nod* just adding a note about it in case anyone's puzzled about why
describe doesn't have --no-contains, elaborated & clarified this a bit
in my WIP v2.

>> -static int commit_contains(struct ref_filter *filter, struct commit *co=
mmit)
>> +static int commit_contains(struct ref_filter *filter, struct commit *co=
mmit, const int with_commit)
>>  {
>> +     struct commit_list *tmp =3D with_commit ? filter->with_commit : fi=
lter->no_commit;
>>       if (filter->with_commit_tag_algo)
>> -             return contains_tag_algo(commit, filter->with_commit);
>> -     return is_descendant_of(commit, filter->with_commit);
>> +             return contains_tag_algo(commit, tmp);
>> +     return is_descendant_of(commit, tmp);
>>  }
>
> Perhaps it would be simpler if the caller just passed the right
> commit_list rather than a flag. We unfortunately do still need to pass
> the "filter" (for the algorithm field), but the caller is then:
>
>   if (filter->with_commit &&
>       !commit_contains(filter, filter->with_commit, commit))
>           return 0;
>   if (filter->no_commit &&
>       commit_contains(filter, filter->no_commit, commit))
>           return 0;
>
> which avoids the 0/1 flag whose meaning is not immediately apparent at
> the callsite. One day we can hopefully unify the two algorithms and
> ditch the extra filter parameter.

My C rustyness is showing. Yeah that's much better, thanks, changed it
to that in my WIP v2.

> I almost suggested that there simply be an option to invert the match
> (like --invert-contains or something).  But what you have here is more
> flexible, if somebody ever wanted to do:
>
>   git tag --contains X --no-contains Y

Yeah that's really useful. E.g. this shows the branches I branched off
(or have locally) from 2.6..2.8:

    $ ./git branch --contains v2.6.0 --no-contains v2.8.0
      avar/monkeypatch-untracked-cache-disabled
      avar/uc-notifs21
      dturner/pclouds-watchman-noshm

But I'd expect this to show all the tags between the two:

    $ ./git tag --contains v2.6.0 --no-contains v2.8.0
    $

But it just returns an empty list. Manually disabling the
contains_tag_algo() path (i.e. effectively locally reverting your
ffc4b8012d) makes it "work", but of course it's much slower now. I
haven't dug into why it's not working yet.

Also I wonder if this should be an error:

    $ ./git [tag|branch|for-each-ref] --contains A --no-contains A

I.e. when you give the same argument to both, this can never return
anything for obvious reasons.

>> @@ -1708,8 +1782,91 @@ run_with_limited_stack () {
>>
>>  test_lazy_prereq ULIMIT_STACK_SIZE 'run_with_limited_stack true'
>>
>> +# These are all the tags we've created above
>> +cat >expect.no-contains <<EOF
>> [...80 tags...]
>> +EOF
>
> That's a lot of tags, and I'd worry it makes the test a little brittle.
> Can we limit the set of tags with a name-match? It shouldn't affect the
> purpose of the test (the deep stack comes from traversing the commits,
> not the number of tags).

I'll make this less sucky in v2 somehow. I did it this way because no
existing test was checking all the tags we'd created at the end, so
this does that by proxy now, but I agree it's too verbose. Will fix
it.
