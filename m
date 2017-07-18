Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BACC1FA2C
	for <e@80x24.org>; Tue, 18 Jul 2017 01:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751583AbdGRBnn convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 17 Jul 2017 21:43:43 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57417 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751440AbdGRBnm (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Jul 2017 21:43:42 -0400
X-AuditID: 12074412-243ff70000003b38-c1-596d67ca3eac
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 5B.C7.15160.AC76D695; Mon, 17 Jul 2017 21:43:40 -0400 (EDT)
Received: from mail-io0-f169.google.com (mail-io0-f169.google.com [209.85.223.169])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v6I1hbr8015829
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 21:43:37 -0400
Received: by mail-io0-f169.google.com with SMTP id z62so6352117ioi.3
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 18:43:37 -0700 (PDT)
X-Gm-Message-State: AIVw113xlkqVnD9tL2cveAm+TZUvqW7zyN5VV1bI+jI/7mNSSQzyncLQ
        92VcNZVtH4PRGOtK1IMoe3+qEhyDuA==
X-Received: by 10.107.128.230 with SMTP id k99mr358912ioi.115.1500342217004;
 Mon, 17 Jul 2017 18:43:37 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.128.90 with HTTP; Mon, 17 Jul 2017 18:43:35 -0700 (PDT)
In-Reply-To: <CAJo=hJv36tYuxHuso7NrPkfE9hApGfn=iP8g_8+MeM8L91h09g@mail.gmail.com>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <CAMy9T_GsgDewHhe1heH7t2qPZuE3XQOKzoxc50-fLmOqm=6ZzQ@mail.gmail.com> <CAJo=hJv36tYuxHuso7NrPkfE9hApGfn=iP8g_8+MeM8L91h09g@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Mon, 17 Jul 2017 18:43:35 -0700
X-Gmail-Original-Message-ID: <CAMy9T_Fuf3YoHzsLgx-fcX5OQBNXw8xOvrPEpffkYjWGBpNsMQ@mail.gmail.com>
Message-ID: <CAMy9T_Fuf3YoHzsLgx-fcX5OQBNXw8xOvrPEpffkYjWGBpNsMQ@mail.gmail.com>
Subject: Re: reftable: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqHsmPTfSoGOimUXXlW4mB0aPz5vk
        AhijuGxSUnMyy1KL9O0SuDKWHTjMVDC5uOLEtHlsDYz/YroYOTkkBEwktk9cwNbFyMUhJLCD
        SWLp8l+MEM5TJomF1/8wQTh9jBJX179igWjJl/j48y8jhF0i8XVNGyuIzSsgKHFy5hOwGiEB
        OYlXG24wQtjeEqf3PQWr4RQIlDj7cxkrxNA7jBLf3n9gBkmwCehKLOppZgKxWQRUJQ5dv8gM
        sSBRYvrdgywQCwIk5u87DhYXBqp/8XELWFxEQE1i+4UeoKEcHMwCshKPz6qChJkFNCVat/9m
        h7C1JZYtfM08gVFkFpJTZyEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXTO93MwS
        vdSU0k2MkLAX2sG4/qTcIUYBDkYlHt4bu3MihVgTy4orcw8xSnIwKYnySibkRgrxJeWnVGYk
        FmfEF5XmpBYfYpTgYFYS4f2fApTjTUmsrEotyodJSXOwKInz/lys7ickkJ5YkpqdmlqQWgST
        leHgUJLgTUoDahQsSk1PrUjLzClBSDNxcIIM5wEa3ghSw1tckJhbnJkOkT/FaM9x5cq6L0wc
        Uw5sB5Jzfu8Akh0zfn5jEmLJy89LlRLnfZEK1CYA0pZRmgc3GZbSXjGKAz0qzJsCMpwHmA7h
        Zr8CWssEtFbYNwdkbUkiQkqqgdE/dZM+//mtBY82PChsuB4nw3NRqcFCP3h9f6iiRmTv0e8f
        Mv5sXMu8Olr1e+chli88tRpyD5XOX6r4lbqBLWfVjMwwpSWW3T7PPp3n3ZE4Z5OPRlPiAd/I
        c6qvdFvddm3hCnkttnPy/OPiX6fvOaGz44ZZr+tXpu/BgoUW16zE2TTemho/M1BiKc5INNRi
        LipOBACInWV1RAMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 16, 2017 at 12:43 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Sun, Jul 16, 2017 at 10:33 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> * Do you propose to store *all* references (i.e., including the
>> references that we call pseudorefs, like `HEAD`, `FETCH_HEAD`, etc) in
>> reftables, or only the references under `refs/`? If the former, then
>> you need to consider that some pseudorefs contain additional
>> information besides the SHA-1 or linked-to reference. If the latter,
>> then you could get some additional compression by making the `refs/`
>> prefix implicit rather than storing it in the "restart" records
>> explicitly.
>
> Great question I didn't have an answer for. I was planning to store
> HEAD, but not FETCH_HEAD/MERGE_HEAD/etc. Mostly because our storage
> system at $DAY_JOB doesn't have a place to store HEAD itself, its
> buried down in the reference system. So reftable has to do the job.
>
> The file format for reftable describes a type 0x3 which is just a
> length delimited byte string. Provided that the data fits into a
> single block, reftable can store these larger files with their
> auxiliary data.
>
> I'm open to the idea of HEAD and friends being outside of reftable in
> a git-core accessed repository, but the backend storage I want to run
> reftable on would likely need to store HEAD inside reftable.
>
>>   Personally, I don't think it makes sense to store pseudorefs in
>> reftables. HEAD, though it doesn't include any supplemental
>> information, is read so frequently that it seems like a bad idea to
>> have to go through the lookup process rather than storing it in a
>> separate flat file. Moreover, HEAD is written very *infrequently*, so
>> (absent special treatment) it would tend to sink deep in the reftable
>> stack, making reads even more expensive.
>
> That is a very fair argument for keeping HEAD outside.
>
> A counter argument is HEAD is written very frequently by following its
> indirect pointer to the branch (e.g. refs/heads/master). HEAD is
> consequently reflogged very frequently. reftable stores the logs
> inside the table shards. HEAD could be floated onto the top on every
> write to accompany its log record.

On second thought, the idea of having HEAD (or maybe all pseudorefs)
in the same system would open a few interesting possibilities that
derive from having a global, atomic view of all references:

1. We could store backlinks from references to the symbolic references
that refer to them. This would allow us to update the reflogs for
symbolic refs properly. (Currently, there is special-case code to
update the reflogs for HEAD when the reference that it points at is
modified, but not for other symrefs.)

2. We could store "peeled" versions of symbolic refs. These would have
to be updated whenever the pointed-at reference is updated, but that
would have two nice advantages: HEAD would usually be resolvable based
on the top reftable in the stack, and it would be resolvable in one
step (without having the follow the symref explicitly).

> [...]
>> * The tuning parameter number_of_restarts currently trades off space
>> (for the full refnames and the restart_offsets) against the need to
>> read and parse more ref_records to get the full refnames. ISTM that
>> this tradeoff could be made less painful by defining a blockwide
>> prefix that is omitted from the refnames as used in the restarts. So
>> the full refname would change from
>>
>>       this_name = prior_name[0..prefix_length] + suffix
>>
>>   to
>>
>>       this_name = block_prefix + prior_name[0..prefix_length] + suffix
>>
>>   I would expect this to allow more frequent restarts at lower space
>> cost.
>
> I've been on the fence about the value of this. It makes the search
> with restarts more difficult to implement, but does allow shrinking a
> handful of very popular prefixes like "refs/" and "refs/pulls/" in
> some blocks.
>
> An older format of reftable used only a block_prefix, and could not
> get nearly as good compression as too many blocks contained references
> with different prefixes.

It's clear that using *only* a block_prefix wouldn't yield as good
compression as your proposed scheme. And it feels plausible that when
using 64k blocks, a block_prefix wouldn't help much.

I'm still not quite resigned to non-Google users wanting to use blocks
as large as 64k, but (short of doing actual experiments, yuck!) I
can't estimate whether it would make any detectable difference in the
real world.

On the other end of the spectrum, I might mention that the
shared-storage "network.git" repositories that we use at GitHub often
have a colossal number of references (basically, the sum of the number
of references in all of the forks in a "repository network", including
some hidden references that users don't see). For example, one
"network.git" repository has 56M references(!) Mercifully, we
currently only have to access these repositories for batch jobs, but,
given a better reference storage backend, that might change.

> [...]
>> 2. The stacking of multiple reftable files together
>>
>> * A very frequent operation will be to read a single reference. This
>> could get expensive if a reftable stack grows deep, because every
>> single reftable might have to be inspected. One way to reduce this
>> cost might be to store a bloom filter in large reftable files. This
>> could allow a quick determination that the file doesn't contain the
>> reference being sought.
>
> Yes, of course. But I'm torn on that premise. My gut theory says most
> references that are read individually were/are recently modified. Thus
> they should be higher in the reftable stack, and a reader will
> terminate with its result. Its only the not-founds that will have a
> penalty of reaching the base of the stack.
>
> I'd also really like to see repositories holding stacks <4 deep, not
> 32 deep. If we can get the compaction working well, we should be able
> to see most repositories with 1 large base file, 1 medium-ish
> compaction, 2 recent updates.
>
> At $DAY_JOB we can do this successfully with pack files, which are
> larger and more costly to combine than reftable. I think we can get
> reftable to do support a reasonable stack depth.

Are you saying that you merge subsets of packfiles without merging all
of them? Does this work together with bitmaps, or do you only have
bitmaps for the biggest packfile?

We've thought about merging packfiles in that way, but don't want to
give up the benefits of bitmaps.

>> I haven't reviewed your proposal for storing reflogs in reftables in
>> any detail, though I must say that my first reaction is surprise that
>> you want to store reflogs (which are mostly immutable, rarely read,
>> and can be an order of magnitude bigger) in the same files as
>> references.
>
> reftable compressed 87,393 references into 3M, and a year's worth of
> their log updates into another 4M. Keeping them together actually
> simplifies a lot of nasty corner cases in Git.
>
> D/F conflicts ("refs/heads/foo", "refs/heads/foo/bar") go away, but
> assuming we continue to reject these to protect existing clients, we
> can also still retain logs for deleted names that were cleared out.
>
> Logs can be written in the same atomic filesystem operation as the
> refs are mutated, avoiding any skew about the log being dropped or
> logged early. Logs are now searchable in reverse time order, which
> accelerates log queries.
>
> I really think its worth storing the logs inside the reftable. I'm
> pretty sold on that part of the design at this point. There are many
> advantages, and I've been able to sufficiently push off the downsides
> by storing the logs in a separate region of the reftable.

Those sizes don't sound that scary. Do your reflogs include
significant information in the log messages, or are they all "push"
"push" "push"? We record quite a bit of information in our audit_log
entries (our equivalent of reflogs), so I would expect ours to
compress much less well.

We also tend to use our audit_logs to see what was happening in a
repository; e.g., around the time that a problem occurred. So for us
it is useful that the entries are in chronological order across
references, as opposed to having the entries for each reference
grouped together. We might be the oddballs here though, and in fact it
is possible that this would be an argument for us to stick to our
audit_log scheme rather than use reflogs stored in reftables.

I agree that it would be nice to have logs in the same atomic store as
the references, so if it can be made efficient, I'm all for it.

I've since read over the reflog part of your proposal. Comments:

* With file-based reflogs, the presence or absence of a reflog file
(even if it is empty) is sometimes used to decide whether to log new
updates for the corresponding reference [1]. Is there an equivalent
for reftable-based reflogs?

[1] https://github.com/git/git/blob/f3da2b79be9565779e4f76dc5812c68e156afdf0/refs/files-backend.c#L1976-L1991

* It is not clear from your proposal whether
refname+reverse_int32(time_sec) is meant to be a unique key.
  * If yes, think again. It is not at all unusual for a reference to
be updated more than once in a second.
  * If no, then how can reflogs be expired? It seems that there would
often be no alternative to rewriting all of the reftable files.

* As reflog entries accumulate and reftable files are compacted, it
will often be the case that compacted reftable files will contain many
reflog entries for the some references. Normally (though not always),
the old_id of one entry should be identical to the new_id of the next.
It seems that it should be possible to save quite a bit of space by
representing such entries as a group rather than singly.

Regarding your updated proposal for how to name and stack reftable files:

* You say that ".ref files are named by the SHA-1 hash of the contents
of the reftable". I assume that means "the contents of that particular
file". However, this is not entirely straightforward. It is thinkable
for two reftable files to have the exact same contents. For example,
if reflogs are turned off, and I (1) make commit A; (2) make commit B;
(3) reset the branch back to commit A; then I think that the first and
third reftable files would have identical contents. This would not
*necessarily* be a problem—given that the two reftable files would
have identical contents, the same file could serve for both of them.
But it could very easily lead to confusion, for example if some
process that is compacting the first two reftables decides that it can
delete the file at the same moment that the `git reset` process has
just rewritten the file or decided that it doesn't have to rewrite the
file.

  We could avoid this situation by including the name of the
predecessor reftable file in the body of each new reftable, or even by
including it in the SHA-1 without writing it into the file.

  It *seems* as if it would be an advantage to include the name of the
predecessor reftable in a new reftable, but that info would become
obsolete if some deeper reftables are compacted while new reftables
are being written (which I think is a more useful design goal than
being able to chain the reftable files to each other ab initio).

  We could have both properties if the SHA-1 of a reftable file were a
hash of the *logical* contents of the whole stack of
references+reflogs, including its predecessors. That hash would be
invariant under compaction, so if we compact files A, B, and C, the
results would necessarily have the same hash as file C did previously.
However, it would be expensive to compute the hash of the whole
contents, because to do so one would have to iterate through all of
the references and reflog entries. Moreover, IIUC, on Windows it would
not be possible to rename the "new C" file on top of the "old C" file
if any reader has that file open.

But I don't think there is any reason that the files have to be named
using the hash of their contents. As far as I understand, any unique
filename (i.e., even something as simple as `mktemp XXXXXX.ref`) would
serve just fine. It might also be convenient to embed the timestamp or
N+1 of the predecessor file in the filename for human consumption.

Some other random comments:

* Do we really want to use Git-style varints here? It seems to me that
protocol-buffer-style varints are more familiar and are a lot easier
to understand (albeit a miniscule bit larger on average). They also
have the advantage that they can be padded by inserting 0x80 bytes, a
property that would have come in handy in a packfile-related project
that we were working on internally.

* What would you think about being extravagant and making the
value_type a full byte? It would make the format a tiny bit easier to
work with, and would leave room for future enhancements (e.g.,
pseudorefs, peeled symrefs, support for the successors of SHA-1s)
without having to change the file format dramatically.

* Speaking of the successors of SHA-1s, if you haven't already, it
would make sense for somebody to read the proposal for the transition
to a post-SHA-1 world with an eye to considering whether the reftable
file should play a role, and whether that should have an effect on the
current design. I'm not saying we should build in support already, but
it would be a pity if the format had to be changed radically at the
time of the transition.

* The transition to reftable will require a new repository format
version and an extension [2]. You might as well mention that in your
proposal and suggest a name.

[2] https://github.com/git/git/commit/00a09d57eb8a041e6a6b0470c53533719c049bab

* Current versions of git look for `$GIT_DIR/refs` as part of
determining whether a directory might be a plausible git directory
[3]. Although current versions of Git won't be able to read a
reftable-based repository, they *should* be able to recognize the
directory as a plausible Git directory. So ISTM that a reftable-based
Git repository should put *something* at that path. For example, that
path could be used as the name of the "stack" file. The fact that it
is a file rather than a directory shouldn't bother is_git_directory()
but should be enough to prevent it from accidentally being used as a
loose refs directory.

[3] https://github.com/git/git/blob/f3da2b79be9565779e4f76dc5812c68e156afdf0/setup.c#L335-L339

Yours,
Michael
