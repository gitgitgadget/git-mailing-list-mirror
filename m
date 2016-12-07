Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A47161FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 23:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933902AbcLGXhJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 18:37:09 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:33445 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933900AbcLGXhI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 18:37:08 -0500
Received: by mail-qt0-f169.google.com with SMTP id p16so395691771qta.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 15:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aLCS+s6zNMLq/ijk45PDD46Ul+PajBN6xp3U0b9srEM=;
        b=JJdc52fuSY6wS5OzQhMIbpdHA0QfjimsGgYBOL/KBCW1pym0VnmT+hiC2+ZcRNj/Sv
         P6H5cy6yhTarCR84sbm5XK3zaiZHZPt0x0npOqCgyr+2JEBHuAyOph8KEA80y0fwXI/U
         ht3hcks9XWsqICY7/CVH+ktiVmOVVjYUTtjF3iREMspV1ws3Nf3dy63vVcyHdryDkJyX
         CiJAR3sXMzNr/p/WVJ1AaUzkDkoUPWg5esZMWVQMOZC6KbWhkOd8P3+RiRqXABs29N56
         FYPdZVKHeaZotvIIjqXFEo5ciOzcex7cdUH7/rLgqK52voUtDPy2RKEmde4KALrVbk9j
         SuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aLCS+s6zNMLq/ijk45PDD46Ul+PajBN6xp3U0b9srEM=;
        b=m2B0VW0r0ZvOevAMyCFxDHY4ruFbPvJlPQNwf3x78v3Ng4wYPZs2u/BkdHMBkEjNSa
         0QuqMrqbzljp9lrGnyv7xEFjBQyIW1VP4y8l+jPy6u7WHu09E8kx0Za2+n9uoxwN+9EL
         ANmsdFFMSnwwBBKK0HM1WkU95P6svykGYhdkV/ARwI6JtbfTUlaYn8qRkYBupi8otSGa
         c7mFRjYIH1ZsVdzoOd3UJP9r0Ku6YRc40r3dYuYTBpTh4vtBW+6wwqIZGCzZiV7B6cqg
         hOVB+OU/BpzPsFYHEy1Pzsggvjc7fZZ7RSx+lwZWvhXO3q9At1Ermzb2drjSKGo5RIZ/
         4V+A==
X-Gm-Message-State: AKaTC00dX/GyOgIhpEaqEyr5zZGsvq+TOrRhuL9G1Q7YPOU8hR/NPhPvAnciJ3Y41lNhRB7cTJP3KLlfxGfF5w/H
X-Received: by 10.200.42.232 with SMTP id c37mr68182870qta.145.1481153827420;
 Wed, 07 Dec 2016 15:37:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Wed, 7 Dec 2016 15:37:07 -0800 (PST)
In-Reply-To: <xmqqlgvruyt2.fsf@gitster.mtv.corp.google.com>
References: <20161207210157.18932-1-sbeller@google.com> <20161207210157.18932-6-sbeller@google.com>
 <xmqqlgvruyt2.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 7 Dec 2016 15:37:07 -0800
Message-ID: <CAGZ79kb7WJKDBqgy3jgOv_FQGJvKfJk5nYQ_eVBuGUW+R6weeA@mail.gmail.com>
Subject: Re: [PATCHv5 5/5] submodule: add embed-git-dir function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 3:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> @@ -1093,7 +1129,8 @@ static struct cmd_struct commands[] = {
>>       {"resolve-relative-url", resolve_relative_url, 0},
>>       {"resolve-relative-url-test", resolve_relative_url_test, 0},
>>       {"init", module_init, 0},
>> -     {"remote-branch", resolve_remote_submodule_branch, 0}
>> +     {"remote-branch", resolve_remote_submodule_branch, 0},
>> +     {"embed-git-dirs", embed_git_dir, SUPPORT_SUPER_PREFIX}
>>  };
>
> If you want to avoid patch noise like this, your 2/5 can add a
> trailing comma after the entry for remote-branch.  It is OK to end
> elements in an array literal with trailing comma, even though we
> avoid doing similar in enum definition (which is only allowed in
> newer C standards).

Ok, thanks for pointing out!

>
>> diff --git a/dir.c b/dir.c
>> index bfa8c8a9a5..e023b04407 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -2748,3 +2748,30 @@ void untracked_cache_add_to_index(struct index_state *istate,
>>  {
>>       untracked_cache_invalidate_path(istate, path);
>>  }
>> +
>> +/*
>> + * Migrate the git directory of the given `path` from `old_git_dir` to
>> + * `new_git_dir`. If an error occurs, append it to `err` and return the
>> + * error code.
>> + */
>> +int relocate_gitdir(const char *path, const char *old_git_dir,
>> +                 const char *new_git_dir, const char *displaypath,
>> +                 struct strbuf *err)
>> +{
>> +     int ret = 0;
>> +
>> +     printf("Migrating git directory of '%s' from\n'%s' to\n'%s'\n",
>> +             displaypath, old_git_dir, new_git_dir);
>
> By using "strbuf err", it looks like that the calling convention of
> this function wants to cater to callers who want to have tight
> control over their output and an unconditional printing to the
> standard output looks somewhat out of place.

Before sending it out to the list I had a version with another flag
that controlled whether we die on error or just print a warning.
That was not fully true however as the connect_work_tree_and_git_dir
would die nevertheless, we'd only warn for the failed rename().

It turns out we do not need a fully functional non-die()ing version
for the checkout series, so I ripped that out again and the version sent out
just dies in case of failure in relocate_gitdir.

That said, I think the printing of the migration message ought to go
into the caller and to stderr as you note.

>
> Besides, does it belong to the standard output?  It looks more like
> a progress-bar eye candy that we send out to the standard error
> stream (and only when we are talking to a tty).
>
>> +/* Embeds a single submodule, non recursively. */
>> +static void submodule_embed_git_dir_for_path(const char *prefix, const char *path)
>> +{
>> +     struct worktree **worktrees;
>> +     struct strbuf pathbuf = STRBUF_INIT;
>> +     struct strbuf errbuf = STRBUF_INIT;
>> +     char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
>> +     const char *new_git_dir;
>> +     const struct submodule *sub;
>> +     int code;
>> +
>> +     worktrees = get_submodule_worktrees(path, 0);
>> +     if (worktrees) {
>> +             int i;
>> +             for (i = 0; worktrees[i]; i++)
>> +                     ;
>> +             free_worktrees(worktrees);
>> +             if (i > 1)
>> +                     die(_("relocate_gitdir for submodule '%s' with "
>> +                         "more than one worktree not supported"), path);
>> +     }
>
> We may benefit from "does this have secondary worktrees?" boolean
> helper function, perhaps?

ok, I'll add that helper as its own patch to the worktree code earlier
in the series.

>
>> +     old_git_dir = xstrfmt("%s/.git", path);
>> +     if (read_gitfile(old_git_dir))
>> +             /* If it is an actual gitfile, it doesn't need migration. */
>> +             return;
>
> Isn't this "no-op return" a valid thing to do, even when the
> submodule has secondary worktrees that borrow from it?

If we have 2 worktrees, all bets are off (in my non-understanding).
The git file here *could* point to git directory living inside the
other working tree, which then would need migration from that other
working tree to some embedded place.

I don't think that is how worktrees work (or have ever worked?)
but I am unfamiliar with worktrees, so I erred on the safe side.

>  I am
> wondering if the "ah, we don't do a repository that has secondary
> worktrees" check should come after this one.

Maybe Duy can answer that? (Where are git directories
located in a worktree setup, even historically? Were they
ever inside one of the submodules? The other working tree may
not be a submodule, but a standalone thing as well?)

>
>> +     real_old_git_dir = xstrdup(real_path(old_git_dir));
>> +...
>> +}
>
>> +/*
>> + * Migrate the git directory of the submodule given by path from
>> + * having its git directory within the working tree to the git dir nested
>> + * in its superprojects git dir under modules/.
>> + */
>
> I think that this operation removes the git directories that are
> embedded in the working tree of the superproject and storing them
> away to safer place, i.e. unembedding.

Oh right we had that discussion what the embedding actually means.
I asked around for English language help here:
What about "absorbGitDir" ? (absorb as in eat/consume) for the external
UI and internally I can call it relocate_submodule_git_dir_into_superproject
(or embed_git_dir_into_superproject)

>> +
>> +
>
> Lose the extra blank line here?

ok

>> +     if (!skip_prefix(real_sub_git_dir, real_common_git_dir, &v))
>
> Yeah, checking for NULL-ness with !skip_prefix() helps ;-)

I think you are referring to the interdiff to the previous patches..
Yes we should just use it as it is here.

>
>> +             submodule_embed_git_dir_for_path(prefix, path);
>> +
>> +     if (flags & RELOCATE_GITDIR_RECURSE_SUBMODULES) {
>> +             struct child_process cp = CHILD_PROCESS_INIT;
>> +             struct strbuf sb = STRBUF_INIT;
>> +
>> +             if (flags & ~RELOCATE_GITDIR_RECURSE_SUBMODULES)
>> +                     die("BUG: we don't know how to pass the flags down?");
>> +
>> +             if (get_super_prefix())
>> +                     strbuf_addstr(&sb, get_super_prefix());
>> +             strbuf_addstr(&sb, path);
>> +             strbuf_addch(&sb, '/');
>> +
>> +             cp.dir = path;
>> +             cp.git_cmd = 1;
>> +             cp.no_stdin = 1;
>> +             argv_array_pushl(&cp.args, "--super-prefix", sb.buf,
>> +                                         "submodule--helper",
>> +                                        "embed-git-dirs", NULL);
>> +             prepare_submodule_repo_env(&cp.env_array);
>> +             if (run_command(&cp))
>> +                     die(_("could not recurse into submodule '%s'"), path);
>> +             strbuf_release(&sb);
>> +     }
>
> Hmph.  We cannot use run_processes_parallel() thing here?  Is its
> API too hard to use to be worth it?

The problem here is that we do not know about the names of
the nested submodules.  We could do a "git -C path submodule--helper list"
and then use the run_processes_parallel for

    git -C <submodule> embed-git-dir <nested-sub1>
    git -C <submodule> embed-git-dir <nested-sub2>
    git -C <submodule> embed-git-dir <nested-sub3>

etc. As a first approach I considered

    git -C <submodule> embed-git-dir <no-pathspec>

to be fast enough as the functionality is not implemented is only
a filesystem-local rename() (fast regardless of directory size).

So if we want to make that relocate git dir aware of
non-atomic-cross-filesystem moves, we want to revisit the decision
to run it in parallel?

>
>> +test_expect_success 'embedding does not fail for deinitalized submodules' '
>> +     test_when_finished "git submodule update --init" &&
>> +     git submodule deinit --all &&
>> +     git submodule embedgitdirs &&
>> +     test -d .git/modules/sub1 &&
>> +     ! test -f sub1/.git &&
>
> Does this expect "sub1/.git is not a regular file (we want directory
> instead)"?  Or "there is no filesystem entity at sub1/.git"?

This mainly ought to test that the new call doesn't crash or segfault
but accepts this as a valid state.

>
> If the former, write "test -d sub1/.git"; if the latter, you
> probably want "! test -e sub1/.git" instead.

However the -e is the correct thing to do.
