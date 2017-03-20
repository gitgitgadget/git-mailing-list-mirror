Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B320A2095B
	for <e@80x24.org>; Mon, 20 Mar 2017 12:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753552AbdCTJdN (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 05:33:13 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:35211 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753294AbdCTJdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 05:33:09 -0400
Received: by mail-it0-f44.google.com with SMTP id y18so25713513itc.0
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 02:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FEVkIsfH5SxTRPMvOisrzCplP88DTUTju/5ARyfUNMU=;
        b=B4sgB2dVWdSS0ZfDyelpu0sKQjP1ZKs8wKOKnYTJ5xecELctXsU+qJpV8/5+NfiQYh
         tRNL3PAHtT80XHXuUhFFLlOuy7iZt0VeNUMag+03Gd3c7LlNUXaXMXnES2FxGHv11Nkk
         v6wo1x6tk9S2jxnSHIFS3ronUGwdNtNj6dL4iUyZyFDjfZcVSuwhG+YAc0MvkpgMeU9U
         d826IXILWgkWay+aIQMulOAwKtNeUZpsmerojq6/Otcq8tnIzZ+t1LwuTE7bJHxzgtzV
         czJ6IaGH4cC7Pop1kU/Z/otvgaDIiCg1oONaXxJhM+xSEJam0NB+ot6Oqn+uJ58RF+oy
         c15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FEVkIsfH5SxTRPMvOisrzCplP88DTUTju/5ARyfUNMU=;
        b=q1sPlgxAzFrt4A/9iAm1HWSV9qWNxqWfu6J30b9Z275k3q+8KCFCjb3EQprdKcZ+p8
         cmSB7HHxlmR2+y9VQxrUMR/LBiWzJZGEeAZnEV2aFZrRHFCtZi0Yi0ra82cLJyDKULHR
         Qcd+j5IOP6eVCOEiBeR3hzjmz371vo3r73wCAuOVRVDG1DW6BmuhoFF/73GaUzA8t4AY
         a65uWuldK8D/TcnOVLptNH0KIpuZTkmMjXpBKAoTp5bHg7LcI3jb1oYNwXYrCYde5O7Y
         AA1RfaXntyi+1aON92xyNEmz13rCvt7naMIRx4rQQgA2pdu9T7CHizHajTaSVXiNpP1V
         eHEA==
X-Gm-Message-State: AFeK/H1Pm+X7ruNVCU75YZXis++S6pWFACo5RD8rI9lgDgpCVKPFas50aLiHX3B5hUKgL0dCJ2T0h8B8JPZneQ==
X-Received: by 10.36.90.144 with SMTP id v138mr9528552ita.24.1490002388171;
 Mon, 20 Mar 2017 02:33:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 20 Mar 2017 02:32:47 -0700 (PDT)
In-Reply-To: <20170320042519.srtavoxhm3fln5mw@sigill.intra.peff.net>
References: <20170318103256.27141-1-avarab@gmail.com> <20170318103256.27141-7-avarab@gmail.com>
 <20170320042519.srtavoxhm3fln5mw@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 20 Mar 2017 10:32:47 +0100
Message-ID: <CACBZZX6FWjG1bXrk+ee8y=T5=ovxxybfrGzkkDxjskwDzhKPuA@mail.gmail.com>
Subject: Re: [PATCH 6/8] ref-filter: Add --no-contains option to tag/branch/for-each-ref
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 5:25 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 18, 2017 at 10:32:54AM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Change the tag, branch & for-each-ref commands to have a --no-contains
>> option in addition to their longstanding --contains options.
>>
>> This allows for finding the last-good rollout tag given a known-bad
>> <commit>. Given a hypothetically bad commit cf5c7253e0 the git version
>> revert to can be found with this hacky two-liner:
>
> s/revert to/to &/, I think.
Done.
>
>> With this new --no-contains the same can be achieved with:
>> [..]
>
> The goal sounds good to me.
>
>> In addition to those tests, add a test for "tag" which asserts that
>> --no-contains won't find tree/blob tags, which is slightly
>> unintuitive, but consistent with how --contains works & is documented.
>
> Makes sense. In theory we could dig into commits to find trees and blobs
> when the user gives us one. But I kind of doubt anybody really wants it,
> and it's expensive to compute. For the simple cases, --points-at already
> does the right thing.
>
> [more on that below, though...]
>
>> @@ -604,7 +606,7 @@ int cmd_branch(int argc, const char **argv, const ch=
ar *prefix)
>>       if (!delete && !rename && !edit_description && !new_upstream && !u=
nset_upstream && argc =3D=3D 0)
>>               list =3D 1;
>>
>> -     if (filter.with_commit || filter.merge !=3D REF_FILTER_MERGED_NONE=
 || filter.points_at.nr)
>> +     if (filter.with_commit || filter.no_commit || filter.merge !=3D RE=
F_FILTER_MERGED_NONE || filter.points_at.nr)
>>               list =3D 1;
>
> Could we wrap this long conditional?

Done. Will also go through the series as a whole & find other such occuranc=
es.

>> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
>> index df41fa0350..a11542c4fd 100644
>> --- a/builtin/for-each-ref.c
>> +++ b/builtin/for-each-ref.c
>> @@ -9,7 +9,7 @@ static char const * const for_each_ref_usage[] =3D {
>>       N_("git for-each-ref [<options>] [<pattern>]"),
>>       N_("git for-each-ref [--points-at <object>]"),
>>       N_("git for-each-ref [(--merged | --no-merged) [<object>]]"),
>> -     N_("git for-each-ref [--contains [<object>]]"),
>> +     N_("git for-each-ref [(--contains | --no-contains) [<object>]]"),
>>       NULL
>
> I'm not sure if this presentation implies that the two cannot be used
> together. It copies "--merged/--no-merged", but I think those two
> _can't_ be used together (it probably wouldn't be hard to make it work,
> but if nobody cares it may not be worth spending time on).

Yeah this has been bothering me a bit too. I'll change the various
--help and synopsis entries to split them up, since they're not
mutually exclusive at all.

> I also wonder if we need to explicitly document that --contains and
> --no-contains can be used together and don't cancel each other. The
> other option is to pick a new name ("--omits" is the most concise one I
> could think of; maybe that is preferable anyway because it avoids
> negation).
>
>> @@ -457,7 +459,7 @@ int cmd_tag(int argc, const char **argv, const char =
*prefix)
>>       if (!cmdmode && !create_tag_object) {
>>               if (argc =3D=3D 0)
>>                       cmdmode =3D 'l';
>> -             else if (filter.with_commit || filter.points_at.nr || filt=
er.merge_commit || filter.lines !=3D -1)
>> +             else if (filter.with_commit || filter.no_commit || filter.=
points_at.nr || filter.merge_commit || filter.lines !=3D -1)
>
> Ditto here on the wrapping. There were a few other long lines, but I
> won't point them all out.
>
>> -             /* We perform the filtering for the '--contains' option */
>> +             /* We perform the filtering for the '--contains' option...=
 */
>>               if (filter->with_commit &&
>> -                 !commit_contains(filter, commit, &ref_cbdata->contains=
_cache))
>> +                 !commit_contains(filter, commit, filter->with_commit, =
&ref_cbdata->contains_cache))
>> +                     return 0;
>> +             /* ...or for the `--no-contains' option */
>> +             if (filter->no_commit &&
>> +                 commit_contains(filter, commit, filter->no_commit, &re=
f_cbdata->no_contains_cache))
>>                       return 0;
>
> This looks nice and simple. Good.
>
>> +# As the docs say, list tags which contain a specified *commit*. We
>> +# don't recurse down to tags for trees or blobs pointed to by *those*
>> +# commits.
>> +test_expect_success 'Does --[no-]contains stop at commits? Yes!' '
>> +     cd no-contains &&
>> +     blob=3D$(git rev-parse v0.3:v0.3.t) &&
>> +     tree=3D$(git rev-parse v0.3^{tree}) &&
>> +     git tag tag-blob $blob &&
>> +     git tag tag-tree $tree &&
>> +     git tag --contains v0.3 >actual &&
>> +     cat >expected <<-\EOF &&
>> +     v0.3
>> +     v0.4
>> +     v0.5
>> +     EOF
>> +     test_cmp expected actual &&
>> +     git tag --no-contains v0.3 >actual &&
>> +     cat >expected <<-\EOF &&
>> +     v0.1
>> +     v0.2
>> +     EOF
>> +     test_cmp expected actual
>> +'
>
> The tests mostly look fine, but this one puzzled me. I guess we're
> checking that tag-blob does not contain v0.3. But how could it?

It's a very defensive test, but I'd like to leave it in.

It would be possible, and perhaps efficient in some cases, to
implement "--no-contains <commit>" internally as literally something
that just ran "--contains <commit>", got the list of tags, stashed
them into a hash, and then did a "git tag -l" and printed out anything
*not* in the hash.

This test is asserting that we don't somehow regress to such an implementat=
ion.

> The more interesting test to me is:
>
>   git tag --contains $blob
>
> which should barf on a non-commit.

Will make sure that's tested for.

> For the --no-contains side, you could argue that the blob-tag doesn't
> contain the commit, and it should be listed. But it looks like we just
> drop all non-commit tags completely as soon as we start to do a
> contains/not-contains traversal.
>
> I think the more relevant comparison is "--no-merged", and it behaves
> the same way as your new --no-contains. I don't think I saw this
> subtlety in the documentation, though. It might be worth mentioning
> (unless I just missed it).

For --contains we explicitly document "contain the specified commit",
i.e. you couldn't expect this to list tree-test, and indeed it
doesn't:

    $ git tag tree-test master^{tree}
    $ git tag -l --contains master '*test*'

However the --[no-]merged option says "reachable [...] from the
specified commit", which seems to me to be a bit more ambiguous as to
whether you could expect it to print tree/blob tags.
