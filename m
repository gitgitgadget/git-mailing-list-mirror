Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39FA11F600
	for <e@80x24.org>; Sun, 23 Jul 2017 22:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbdGWW5N (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 18:57:13 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:33001 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751361AbdGWW5L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 18:57:11 -0400
Received: by mail-ua0-f171.google.com with SMTP id 80so66724803uas.0
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 15:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WFiAL+/t1Fsq4xCFwUQow2u8DtvAKZyu7dx+KXKq6RU=;
        b=Uyy1o9n8caRclrGMdK2tuNTY6UZXIQFCrIqUACxbW4DSbfvoMzwm4hRkm6rp7PMZqY
         lKq8E9qDjzCbuSESaMh800r/GhBSEmrgroxe9KuMJP8jNjT/ekn1sbRDdYL3nHqyez58
         cOmjUKc6h3N2Xo8dc4BmblftCfmNJNYxHW+CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WFiAL+/t1Fsq4xCFwUQow2u8DtvAKZyu7dx+KXKq6RU=;
        b=HzCgUhWvcuMTyJKD89RvTvd9KK2shJOdJ3QdfcVOK9QqOWX5J4W34XUCXJDsNwdea2
         SSMQIQK5nCsEnpFSRmXs7ZgYzR1EUU6oYq9loEEldviw8PlVZ7z5XqY/U1XkvatPBLvP
         IFVpDAP1T4RB2SnS7JKu7LmNKzaenWRsD64MTLe0wgAIqFWc9olujxrOwAH4vEOpDJrR
         KL9T9N78m19y3tAWyKwTVez81aKIDiVFqZ8XhZ3Z2hH+obj6NnXB3a2Sexn6D/USAG0b
         BWWP+ZrKzeOgBDtjuvDzdavbTNRoB1hxuDHHw9YKbHNLd21TI1xqPn+fXGq3ZlV0BWon
         kpUA==
X-Gm-Message-State: AIVw111uhPvkkjYlxb9p0i0uZvfVCRlXQb/mSCwpdFz0GKctC/BoP5b7
        LGFHMqWkAdu3KNwGSn/RJI4BOn8AKnzf
X-Received: by 10.176.74.8 with SMTP id q8mr8773790uae.33.1500850630047; Sun,
 23 Jul 2017 15:57:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.137.4 with HTTP; Sun, 23 Jul 2017 15:56:49 -0700 (PDT)
In-Reply-To: <CAMy9T_Fuf3YoHzsLgx-fcX5OQBNXw8xOvrPEpffkYjWGBpNsMQ@mail.gmail.com>
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
 <CAMy9T_GsgDewHhe1heH7t2qPZuE3XQOKzoxc50-fLmOqm=6ZzQ@mail.gmail.com>
 <CAJo=hJv36tYuxHuso7NrPkfE9hApGfn=iP8g_8+MeM8L91h09g@mail.gmail.com> <CAMy9T_Fuf3YoHzsLgx-fcX5OQBNXw8xOvrPEpffkYjWGBpNsMQ@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Sun, 23 Jul 2017 15:56:49 -0700
Message-ID: <CAJo=hJvm5P6fq4KzZsO0h879xU4pV05MOscCWBPy_gCCYSxobQ@mail.gmail.com>
Subject: Re: reftable: new ref storage format
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+git@vger.kernel.org. I originally sent the below reply privately by mistake.

On Mon, Jul 17, 2017 at 6:43 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On Sun, Jul 16, 2017 at 12:43 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> On Sun, Jul 16, 2017 at 10:33 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
> On second thought, the idea of having HEAD (or maybe all pseudorefs)
> in the same system would open a few interesting possibilities that
> derive from having a global, atomic view of all references:
>
> 1. We could store backlinks from references to the symbolic references
> that refer to them. This would allow us to update the reflogs for
> symbolic refs properly. (Currently, there is special-case code to
> update the reflogs for HEAD when the reference that it points at is
> modified, but not for other symrefs.)

This is a good idea, but makes for some difficult transition code. We
have to keep the special case for HEAD, but other symrefs would log
when in a reftable.

> 2. We could store "peeled" versions of symbolic refs. These would have
> to be updated whenever the pointed-at reference is updated, but that
> would have two nice advantages: HEAD would usually be resolvable based
> on the top reftable in the stack, and it would be resolvable in one
> step (without having the follow the symref explicitly).

Great observation. I wish I saw that sooner. Its a pain in the neck to
resolve symrefs, and has caused us a few bugs in JGit on our current
non-standard storage. It depends on the back pointer being present and
accurate to ensure an update of master also updates the cached HEAD.

I'll have to mull on these a bit. I'm not folding them into my
documentation and implementation just yet.


[...]
> I'm still not quite resigned to non-Google users wanting to use blocks
> as large as 64k, but (short of doing actual experiments, yuck!) I
> can't estimate whether it would make any detectable difference in the
> real world.

I think it is only likely to matter with NFS, and then its a balancing
act of how much of that block did you need vs. not need. :)

> On the other end of the spectrum, I might mention that the
> shared-storage "network.git" repositories that we use at GitHub often
> have a colossal number of references (basically, the sum of the number
> of references in all of the forks in a "repository network", including
> some hidden references that users don't see). For example, one
> "network.git" repository has 56M references(!) Mercifully, we
> currently only have to access these repositories for batch jobs, but,
> given a better reference storage backend, that might change.

A larger block size right now has the advantage of a smaller index,
which could make a single ref lookup more efficient. Otherwise, the
block size doesn't have a big impact on streaming through many
references.


>>> 2. The stacking of multiple reftable files together
[...]
>> At $DAY_JOB we can do this successfully with pack files, which are
>> larger and more costly to combine than reftable. I think we can get
>> reftable to do support a reasonable stack depth.
>
> Are you saying that you merge subsets of packfiles without merging all
> of them? Does this work together with bitmaps, or do you only have
> bitmaps for the biggest packfile?
>
> We've thought about merging packfiles in that way, but don't want to
> give up the benefits of bitmaps.

Yes. We compact smaller pack files together into a larger pack file,
and try to keep a repository at:

 - 2 compacted packs, each <20 MiB
 - 1 base pack + bitmap

We issue a daily GC for any repository that isn't just 1 base pack.
But during a business day this compacting process lets us handle most
read traffic quite well, despite the bitmaps being incomplete.


>>> I haven't reviewed your proposal for storing reflogs in reftables in
[...]
>
> Those sizes don't sound that scary. Do your reflogs include
> significant information in the log messages, or are they all "push"
> "push" "push"? We record quite a bit of information in our audit_log
> entries (our equivalent of reflogs), so I would expect ours to
> compress much less well.

These were pretty sparse in the comment field, and frequent reuse of a
message. So it may not be representative of what you are storing.

> We also tend to use our audit_logs to see what was happening in a
> repository; e.g., around the time that a problem occurred. So for us
> it is useful that the entries are in chronological order across
> references, as opposed to having the entries for each reference
> grouped together. We might be the oddballs here though, and in fact it
> is possible that this would be an argument for us to stick to our
> audit_log scheme rather than use reflogs stored in reftables.

I think of reflogs about a single ref, not the whole repository. So
I'm inclined to say the reftable storage of them should be by ref,
then time. Anyone who wants a repository view must either scan the
entire log segment, or should roll their own log with an
update/post-receive hook.


> I've since read over the reflog part of your proposal. Comments:
>
> * With file-based reflogs, the presence or absence of a reflog file
> (even if it is empty) is sometimes used to decide whether to log new
> updates for the corresponding reference [1]. Is there an equivalent
> for reftable-based reflogs?
>
> [1] https://github.com/git/git/blob/f3da2b79be9565779e4f76dc5812c68e156af=
df0/refs/files-backend.c#L1976-L1991

No, I was going to store everything. The flag you are talking about
was added because IIRC Gerrit Code Review was making a lot of
create-only references that were never modified and the reflogs were
growing out of control in terms of inodes used. So disabling reflogs
by default and then explicitly creating files for refs under
refs/heads/ provided an escape hatch.

With integrated storage in reftable, these problems go away.


> * It is not clear from your proposal whether
> refname+reverse_int32(time_sec) is meant to be a unique key.
>   * If yes, think again. It is not at all unusual for a reference to
> be updated more than once in a second.
>   * If no, then how can reflogs be expired? It seems that there would
> often be no alternative to rewriting all of the reftable files.

Great catch, I missed that. I've expanded the format to be int64(
time_usec ) using microseconds since the epoch, with the requirement
that the time be unique.

Writers working with a second precision clock (e.g. current reflog)
should pad the timestamp with a suffix of 999999, and decrement a
microsecond from each older log record that would otherwise have a
duplicate time.


> * As reflog entries accumulate and reftable files are compacted, it
> will often be the case that compacted reftable files will contain many
> reflog entries for the some references. Normally (though not always),
> the old_id of one entry should be identical to the new_id of the next.
> It seems that it should be possible to save quite a bit of space by
> representing such entries as a group rather than singly.

I'm betting on grouping of log records by ref and time, and then libz
deflate over the log block to reduce duplications. I actually tried
adding a flag byte to recycle the id across records, and it was
slightly larger than letting libz handle it.


> Regarding your updated proposal for how to name and stack reftable files:
>
> * You say that ".ref files are named by the SHA-1 hash of the contents
> of the reftable". I assume that means "the contents of that particular
> file". However, this is not entirely straightforward. It is thinkable
> for two reftable files to have the exact same contents. For example,
> if reflogs are turned off, and I (1) make commit A; (2) make commit B;
> (3) reset the branch back to commit A; then I think that the first and
> third reftable files would have identical contents. This would not
> *necessarily* be a problem=E2=80=94given that the two reftable files woul=
d
> have identical contents, the same file could serve for both of them.
> But it could very easily lead to confusion, for example if some
> process that is compacting the first two reftables decides that it can
> delete the file at the same moment that the `git reset` process has
> just rewritten the file or decided that it doesn't have to rewrite the
> file.

Yikes!  Good catch.

>   We could avoid this situation by including the name of the
> predecessor reftable file in the body of each new reftable, or even by
> including it in the SHA-1 without writing it into the file.
>
>   It *seems* as if it would be an advantage to include the name of the
> predecessor reftable in a new reftable, but that info would become
> obsolete if some deeper reftables are compacted while new reftables
> are being written (which I think is a more useful design goal than
> being able to chain the reftable files to each other ab initio).

I agree. We don't want to embed the predecessor table names into the
table itself.

>   We could have both properties if the SHA-1 of a reftable file were a
> hash of the *logical* contents of the whole stack of
> references+reflogs, including its predecessors. That hash would be
> invariant under compaction, so if we compact files A, B, and C, the
> results would necessarily have the same hash as file C did previously.
> However, it would be expensive to compute the hash of the whole
> contents, because to do so one would have to iterate through all of
> the references and reflog entries. Moreover, IIUC, on Windows it would
> not be possible to rename the "new C" file on top of the "old C" file
> if any reader has that file open.
>
> But I don't think there is any reason that the files have to be named
> using the hash of their contents. As far as I understand, any unique
> filename (i.e., even something as simple as `mktemp XXXXXX.ref`) would
> serve just fine. It might also be convenient to embed the timestamp or
> N+1 of the predecessor file in the filename for human consumption.

Yes, you've sold me on this. We don't want to name them by SHA-1 of
contents, instead any suitable unique name is fine, such as one
constructed by mktemp.


> * Do we really want to use Git-style varints here? It seems to me that
> protocol-buffer-style varints are more familiar and are a lot easier
> to understand (albeit a miniscule bit larger on average). They also
> have the advantage that they can be padded by inserting 0x80 bytes, a
> property that would have come in handy in a packfile-related project
> that we were working on internally.

Yes, I would prefer to stick with a varint already in use in the git
project, vs. introducing yet another varint format. Its bad enough we
have 2 varint types in the pack file format. And I really don't see a
reason to support people doing weird things with a reftable, like
padding a file by inserting no-op 0x80 varint bytes.

> * What would you think about being extravagant and making the
> value_type a full byte? It would make the format a tiny bit easier to
> work with, and would leave room for future enhancements (e.g.,
> pseudorefs, peeled symrefs, support for the successors of SHA-1s)
> without having to change the file format dramatically.

I reran my 866k file with full byte value_type. It pushes up the
average bytes per ref from 33 to 34, but the overall file size is
still 28M (with 64 block size). I think its reasonable to expand this
to the full byte as you suggest.


> * The transition to reftable will require a new repository format
> version and an extension [2]. You might as well mention that in your
> proposal and suggest a name.
>
> [2] https://github.com/git/git/commit/00a09d57eb8a041e6a6b0470c53533719c0=
49bab

Thanks, documented.

> * Current versions of git look for `$GIT_DIR/refs` as part of
> determining whether a directory might be a plausible git directory
> [3]. Although current versions of Git won't be able to read a
> reftable-based repository, they *should* be able to recognize the
> directory as a plausible Git directory. So ISTM that a reftable-based
> Git repository should put *something* at that path. For example, that
> path could be used as the name of the "stack" file. The fact that it
> is a file rather than a directory shouldn't bother is_git_directory()
> but should be enough to prevent it from accidentally being used as a
> loose refs directory.
>
> [3] https://github.com/git/git/blob/f3da2b79be9565779e4f76dc5812c68e156af=
df0/setup.c#L335-L339

Thanks, documented.
