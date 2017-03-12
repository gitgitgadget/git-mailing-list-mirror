Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1101FC43
	for <e@80x24.org>; Sun, 12 Mar 2017 09:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933592AbdCLJKx (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 05:10:53 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:35886 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933310AbdCLJKs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 05:10:48 -0400
Received: by mail-it0-f45.google.com with SMTP id h10so15708129ith.1
        for <git@vger.kernel.org>; Sun, 12 Mar 2017 01:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Amf8WCDwdOf6/GXIkGrt4MKPMJLoO3kop2oJtFBu4S0=;
        b=OWktbh9Noti/1BERy4b3FCthhICVFtKdKSpz/ypc0P3qal7lrhlZxEbveMEYfhwuK7
         chgASLGi8KmExzvmTIy8Rjdjd3tm5kdgfkYD/qG4Tork3Qf9LWGCO1tzQO4OZgByDVW6
         85O60WYzcYJou2rLk5hxXHt0FtpxRHpP+sKZgo9kB8R7U+vunYdpQuYe2N8Cs69ODAK6
         l6uekym0wdgAPKEZJuTFV39IfY1Ig6zG/ShtuKNYLplzraLJkLtyV4bBDuvQgATwiwtp
         sfrAdLvKk8no+YTSYwTKa7upqgC41tk7Ra96+0lQf89gPj6QbetO4Tj4v9MN3Ron1ukL
         Dmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Amf8WCDwdOf6/GXIkGrt4MKPMJLoO3kop2oJtFBu4S0=;
        b=lsk7sRd5rEm+IKdCBPYhMfEcyja8YcWGSullfVFVL5Z3VdwJ32+XBVTT9qCPqDihHi
         d5oyfRk2+UnSlbk6lLQMCOTxAodApdm/0hx6Mq5yOrpB/HN5nI4Lqm3oNhN7r46v4rOt
         /MuBDyn3InPcwJQgEmygMw9xJPuI+U/Xm0P8mGUYBXs4t1dlxrDJS1weK76gDI/fr5lM
         /Wl5nxLzE++qgdTG1zIT3M8dHXfrYq9HcH3C+HKfFVMsftOr5+qXfQGQmavmRILthsOg
         M9SoK5o76grLvsHHEvlTpmcd9BABlM7CdDLZm9vFLKe0hFVgla+ZB2ImpYHoPqBw+v6T
         Qp3A==
X-Gm-Message-State: AFeK/H02bnaPcVqHjkqFPlFFH9fTtUEKxB9tiZ21OtOhBFHyXB68pkxwAjYYg0zOoSPMBFoAwHS0+S53WMEN1A==
X-Received: by 10.36.116.71 with SMTP id o68mr6440107itc.60.1489309846788;
 Sun, 12 Mar 2017 01:10:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sun, 12 Mar 2017 01:10:25 -0800 (PST)
In-Reply-To: <xmqqwpbvumrk.fsf@gitster.mtv.corp.google.com>
References: <20170309132728.c57ltzel746l366a@sigill.intra.peff.net>
 <20170311201858.27555-1-avarab@gmail.com> <xmqqwpbvumrk.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 12 Mar 2017 10:10:25 +0100
Message-ID: <CACBZZX4v49zfyGVpcxGSKsxbMfVaUcGHtitpfaZMUtG82YzW-g@mail.gmail.com>
Subject: Re: [PATCH v4] ref-filter: Add --no-contains option to tag/branch/for-each-ref
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 12, 2017 at 5:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change the tag, branch & for-each-ref commands to have a --no-contains
>> option in addition to their longstanding --contains options.
>>
>> The use-case I have for this is to find the last-good rollout tag
>> given a known-bad <commit>. Right now, given a hypothetically bad
>> commit v2.10.1-3-gcf5c7253e0, you can find which git version to revert
>> to with this hacky two-liner:
>>
>>     (./git tag -l 'v[0-9]*'; ./git tag -l 'v[0-9]*' --contains v2.10.1-3=
-gcf5c7253e0) \
>>         |sort|uniq -c|grep -E '^ *1 '|awk '{print $2}' | tail -n 10
>>
>> But with the --no-contains option you can now get the exact same
>> output with:
>>
>>     ./git tag -l 'v[0-9]*' --no-contains v2.10.1-3-gcf5c7253e0|sort|tail=
 -n 10
>
> This command line, while it may happen to work, logically does not
> make much sense.  Move the pattern to the end, i.e.
>
>         git tag -l --no-contains v2.10.1-3-gcf5c7253e0 'v[0-9]*'

Sure, if you'd like it like that I can change it.

But as an aside, I don't understand why you think it happens to work
and doesn't make much sense. To someone reading "git help tag" this
would be *exactly* how you'd expect to have to write this, since the
example given in the synopsis is:

    git tag [-n[<num>]] -l [--contains <commit>] [....]

And then later in the documentation:

    -l <pattern>, --list <pattern>

I.e. for git-branch this type of invocation wouldn't make sense and
would just happen to work, but for git-tag the --list option is
explicitly documented to immediately take a <pattern> argument.

But of course the whole branch v.s. tag difference is just more fodder
for my "tag: Implicitly supply --list given another list-like option"
patch.

> Also if an overlong line in an example disturbs you, do not solve it
> by omitting SP around pipe.  If you are trying to make the result
> readable, pick a readable solution, e.g.

FWIW I just write one-liners like this, i.e. I don't add the
semantically meaningless spaces around all pipes to save myself some
typing, and wasn't trying to squeeze this all on one line, but sure
I'll change it.

>     git tag -l --no-contains v2.10.1-3-gcf5c7253e0 'v[0-9]*' |
>     sort | tail -n 10

Although I'll add a \ to that so you can still paste it to a terminal.

> Oh, drop ./ from ./git while at it ;-)

Sure.

>> The filtering machinery is generic between the tag, branch &
>> for-each-ref commands, so once I'd implemented it for tag it was
>> trivial to add support for this to the other two.
>
> Also, we tend not to say "I did this, I do that".
>
>         Because the filtering machinery is generic ..., support it
>         for all three consistently.
>
>> I'm adding a --without option to "tag" as an alias for --no-contains
>> for consistency with --with and --contains. Since we don't even
>> document --with anymore (or test it). The --with option is
>> undocumented, and possibly the only user of it is Junio[1]. But it's
>> trivial to support, so let's do that.
>
> The sentence that begins "Since we don't" is unfinished.  I think
> it can safely removed without losing any information (the next
> sentence says the same thing).
>
>> Where I'm changing existing documentation lines I'm mainly word
>> wrapping at 75 columns to be consistent with the existing style.

Ack.

> Reviewers would appreciate you refrain from doing that in the same
> patch.  Do a minimum patch so that the review can concentrate on
> what got changed (i.e. contents), followed by a mechanical reflow as
> a follow-up, or something like that, would be much nicer to handle.

Okey, so two patches, one where I potentially produce very long lines
& then re-flow them in a subsequent commit.

>> Most of the test changes I've made are just doing the inverse of the
>> existing --contains tests, with this change --no-contains for tag,
>> branch & for-each-ref is just as well tested as the existing
>> --contains option.
>
> Again, we tend to try our commits not about "I, my, me".
>
>         Add --no-contains tests for tag, branch and for-each-ref
>         that mostly do the inverse of the existing tests we have for
>         --contains.

*Nod*

>> This is now based on top of pu, which has Jeff King's "fix object flag
>> pollution in "tag --contains" series.
>
> Thanks for this note.  I obviously cannot queue on top of 'pu' ;-)
> but will fork this topic off of the jk/ref-filter-flags-cleanup
> topic.

If I'd like to base on top of that to make things easier for you do
you publish  jk/ref-filter-flags-cleanup sowhere? I.e. as a git ref
rather than me also following that topic, applying it on top of
master, and then applying my topic on top of that.

>>  'git for-each-ref' [--count=3D<count>] [--shell|--perl|--python|--tcl]
>>                  [(--sort=3D<key>)...] [--format=3D<format>] [<pattern>.=
..]
>>                  [--points-at <object>] [(--merged | --no-merged) [<obje=
ct>]]
>> -                [--contains [<object>]]
>> +                [(--contains | --no-contains) [<object>]]
>
> THis notation makes sense.  We have to have one of these but
> <object> at the end could be omitted (to default to HEAD).  I guess
> the same notation can be used in the log for the other "filtering
> implies --list mode for 'git tag'" topic.

I don't know what makes to list in the synopsis given the default
arguments to --contains and --no-contains, maybe "[<object>]?", but in
any case, I'm not changing how that part is documented in
for-each-ref, just adding an alternative to the existing --contains
option.

>> +--no-contains [<commit>]::
>> +     Only list tags which don't contain the specified commit (HEAD if
>> +     not specified).
>
> Just being curious.  Can we do
>
>         for-each-ref --contains --no-contains
>
> and have both default to HEAD?  I know that would not make sense as
> a set operation, but I am curious what our command line parser
> (which is oblivious to what the command is doing) does.  I am guessing
> that it would barf saying "--contains" needs a commit but "--no-contains"
> is not a commit (which is very sensible)?

It'll spew out "error: malformed object name --no-contains".

You can do "--contains HEAD --no-contains HEAD" to get nothing.

In an earlier thread I was discussing with Jeff whether it would be
worthwhile to error out in that case, but his opinion was
(paraphrasing) "Nah, GIGO", which I think makes sense in this case.

>> +
>>  --points-at <object>::
>>       Only list tags of the given object.
>
> This is not a new issue (and certainly not a problem caused by your
> patch), but unlike "--contains", this does not default to HEAD when
> <object> is not explicitly given?  It seems a bit inconsistent to me.

Yeah, it doesn't default to HEAD. It's inconsistent, due to a
historical wart in parse-options.[ch]

>> @@ -618,7 +620,7 @@ int cmd_branch(int argc, const char **argv, const ch=
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
> OK.
>
>> diff --git a/parse-options.h b/parse-options.h
>> index dcd8a0926c..0eac90b510 100644
>> --- a/parse-options.h
>> +++ b/parse-options.h
>> @@ -258,7 +258,9 @@ extern int parse_opt_passthru_argv(const struct opti=
on *, const char *, int);
>>         PARSE_OPT_LASTARG_DEFAULT | flag, \
>>         parse_opt_commits, (intptr_t) "HEAD" \
>>       }
>> -#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, 0)
>> +#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, PARS=
E_OPT_NONEG)
>> +#define OPT_NO_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("no-contains", v, h=
, PARSE_OPT_NONEG)
>>  #define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HI=
DDEN)
>> +#define OPT_WITHOUT(v, h) _OPT_CONTAINS_OR_WITH("without", v, h, PARSE_=
OPT_HIDDEN)
>
> Hmph, perhaps WITH/WITHOUT also do not take "--no-" form hence need OPT_N=
ONEG?

I may be missing some subtlety here, but I think you've misread this
(admittedly dense) chunk. the /WITH/ options don't supply NONEG, just
HIDDEN.

>> @@ -1586,11 +1587,11 @@ static enum contains_result contains_tag_algo(st=
ruct commit *candidate,
>>  }
>>
>>  static int commit_contains(struct ref_filter *filter, struct commit *co=
mmit,
>> -                        struct contains_cache *cache)
>> +                        struct commit_list *list, struct contains_cache=
 *cache)
>>  {
>>       if (filter->with_commit_tag_algo)
>> -             return contains_tag_algo(commit, filter->with_commit, cach=
e) =3D=3D CONTAINS_YES;
>> -     return is_descendant_of(commit, filter->with_commit);
>> +             return contains_tag_algo(commit, list, cache) =3D=3D CONTA=
INS_YES;
>> +     return is_descendant_of(commit, list);
>>  }
>>
>>  /*
>> @@ -1780,13 +1781,17 @@ static int ref_filter_handler(const char *refnam=
e, const struct object_id *oid,
>>        * obtain the commit using the 'oid' available and discard all
>>        * non-commits early. The actual filtering is done later.
>>        */
>> -     if (filter->merge_commit || filter->with_commit || filter->verbose=
) {
>> +     if (filter->merge_commit || filter->with_commit || filter->no_comm=
it || filter->verbose) {
>>               commit =3D lookup_commit_reference_gently(oid->hash, 1);
>>               if (!commit)
>>                       return 0;
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
>>       }
>
> When asking "--contains A --contains B", we show refs that contain
> _EITHER_ A or B.  Two predicates are ORed together, and I think it
> makes sense.
>
> When asking "--contains A --no-contains B", we show refs that
> contain A but exclude refs that contains B.  Two predicates are
> ANDed together, and I think this also makes sense.
>
> When asking "--no-contains A --no-contains B", what should we show?
> This implementation makes the two predicates ANDed together [*1*].
>
> The behaviour is sensible, but is it consistent with the way now
> existing --no-merged works?
>
> I think the rule is something like:
>
>     A match with any positive selection criterion (like --contains
>     A) makes a ref eligible for output, but then a match with any
>     negatigve selection criterion (like --no-merged) filters it out.
>
> Is it easy to explain to the users?  Do we need doc updates to
> clarify, or does the description for existing --no-merged already
> cover this?

I'm not sure, and wanting to get the rest of this e-mail out the door,
I didn't have time to fully investigate this. I.e. is it consistent
with how --merged works? It uses a slightly different codepath, maybe,
but it's definitely consistent with how everything in the ref-filter
machinery works in general, and that's used by multiple options.

So to the extent that this needs docs we should do that in some
general place that covers existing options that use it.
