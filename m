Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCBDC20229
	for <e@80x24.org>; Tue,  1 Nov 2016 17:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbcKAR0n (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 13:26:43 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33110 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750889AbcKAR0l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 13:26:41 -0400
Received: by mail-qk0-f173.google.com with SMTP id v138so116523579qka.0
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jXrOfQaC/Cc4+D0Epguf4IY8ynxVw56gqbGrBHJpL/Y=;
        b=E6GbwwNaYanyGVCcT7qmNws1YyAfY/Cz9EQjnobaadNPXhjLJYnzcf5pRV4TguDG/2
         UiOp9Z4fMWGv4Cx/Px9g636yPhKQkHRNXnGqjpsEkibJh5U0gbSXDOskk1NV2uUsxAmf
         /AVuiG+NFAtJrbGUYvvDCOGpVSSDkCoX32wRU1QZXU/tij9mCrrE09qJ+3I/KiakKxBu
         VcpB4tktaR/t4bnw4816xvsWUISeJvPe3VvjR2W7F88i3M32R9AFp/0KhbcqzdBAom7j
         oLEH01HZ9mblr92+VlYjRw6R0zKBCh13rihJTLi8bR91BWytjj48aWTfJV3uYzTT0Yos
         /Ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jXrOfQaC/Cc4+D0Epguf4IY8ynxVw56gqbGrBHJpL/Y=;
        b=bEHCUNWf4oNSH41/7BquXn+RxBwGziqyNovwXMXm0g26Vb8Qv+2Ua88JgguVsL+C8W
         giLs6DRMhfZlws1l4MPSqGRsk68EEzwq2alOz3WHGsqzEYOtMivJsQr3KxZKAwu2tRzZ
         bBcZ+IOSIfA51maLql1umluw5jvqMjuFQjRfqFIr9w9a9lWEB+UCYdGbovbJqTLR2n2C
         Ap60ul0Yw86BHE8lP5XfLV3cwELwndngfk5dQPW4n6B313u8VRHfZSVAIyqcuRj+/ntX
         n2XPpy+kSrpSFzUF/w8Zeoh6QrsvC7KM+VWHDwUnW5V0gsLAXhJgHtNZjCKKwYdk53HI
         +dZQ==
X-Gm-Message-State: ABUngvdHzSq8bJmhFFKM+ph4drJRdG5QDlce4m4FEYdD5U/ZBGb57stTmqyYfQbD+OGG2PM+m+jU5eFotD6ZQBQw
X-Received: by 10.55.16.147 with SMTP id 19mr20352747qkq.255.1478021200625;
 Tue, 01 Nov 2016 10:26:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 1 Nov 2016 10:26:40 -0700 (PDT)
In-Reply-To: <1477953496-103596-5-git-send-email-bmwill@google.com>
References: <20161027223834.35312-1-bmwill@google.com> <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1477953496-103596-5-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 1 Nov 2016 10:26:40 -0700
Message-ID: <CAGZ79kaPSCJo4jBh5pha6_u4pe-7zXoYQi3bD1L14nwUmdD-Hg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] grep: optionally recurse into submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2016 at 3:38 PM, Brandon Williams <bmwill@google.com> wrote:

>
> +--recurse-submodules::
> +       Recursively search in each submodule that has been initialized and
> +       checked out in the repository.
> +

and warn otherwise.

> +
> +       /*
> +        * Limit number of threads for child process to use.
> +        * This is to prevent potential fork-bomb behavior of git-grep as each
> +        * submodule process has its own thread pool.
> +        */
> +       if (num_threads)
> +               argv_array_pushf(&submodule_options, "--threads=%d",
> +                                (num_threads + 1) / 2);

Just like in the run_parallel machinery this seems like an approximate
workaround. I'm ok with that for now.

Ideally the parent/child can send each other signals to hand
over threads. (SIGUSR1/SIGUSR2 would be enough to do that,
though I wonder if that is as portable as I would hope. Or we'd look at
"make" and see how they handle recursive calls.

> +
> +       /*
> +        * Capture output to output buffer and check the return code from the
> +        * child process.  A '0' indicates a hit, a '1' indicates no hit and
> +        * anything else is an error.
> +        */
> +       status = capture_command(&cp, &w->out, 0);
> +       if (status && (status != 1))

Does the user have enough information what went wrong?
Is the child verbose enough, such that we do not need to give a
die[_errno]("submodule processs failed") ?


> +static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
> +                         const char *filename, const char *path)
> +{
> +       if (!(is_submodule_initialized(path) &&

If it is not initialized, the user "obviously" doesn't care, so maybe
we only need to warn
if init, but not checked out?

> +             is_submodule_checked_out(path))) {
> +               warning("skiping submodule '%s%s' since it is not initialized and checked out",
> +                       super_prefix ? super_prefix : "",
> +                       path);
> +               return 0;
> +       }
> +
> +#ifndef NO_PTHREADS
> +       if (num_threads) {
> +               add_work(opt, GREP_SOURCE_SUBMODULE, filename, path, sha1);
> +               return 0;
> +       } else
> +#endif
> +       {
> +               struct work_item w;
> +               int hit;
> +
> +               grep_source_init(&w.source, GREP_SOURCE_SUBMODULE,
> +                                filename, path, sha1);
> +               strbuf_init(&w.out, 0);
> +               opt->output_priv = &w;
> +               hit = grep_submodule_launch(opt, &w.source);
> +
> +               write_or_die(1, w.out.buf, w.out.len);
> +
> +               grep_source_clear(&w.source);
> +               strbuf_release(&w.out);
> +               return hit;
> +       }
> +}
> +
> +static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec,
> +                     int cached)
>  {
>         int hit = 0;
>         int nr;
> +       struct strbuf name = STRBUF_INIT;
> +       int name_base_len = 0;
> +       if (super_prefix) {
> +               name_base_len = strlen(super_prefix);
> +               strbuf_addstr(&name, super_prefix);
> +       }
> +
>         read_cache();
>
>         for (nr = 0; nr < active_nr; nr++) {
>                 const struct cache_entry *ce = active_cache[nr];
> -               if (!S_ISREG(ce->ce_mode))
> -                       continue;
> -               if (!ce_path_match(ce, pathspec, NULL))
> -                       continue;
> -               /*
> -                * If CE_VALID is on, we assume worktree file and its cache entry
> -                * are identical, even if worktree file has been modified, so use
> -                * cache version instead
> -                */
> -               if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
> -                       if (ce_stage(ce) || ce_intent_to_add(ce))
> -                               continue;
> -                       hit |= grep_sha1(opt, ce->oid.hash, ce->name, 0,
> -                                        ce->name);
> +               strbuf_setlen(&name, name_base_len);
> +               strbuf_addstr(&name, ce->name);
> +
> +               if (S_ISREG(ce->ce_mode) &&
> +                   match_pathspec(pathspec, name.buf, name.len, 0, NULL,
> +                                  S_ISDIR(ce->ce_mode) ||
> +                                  S_ISGITLINK(ce->ce_mode))) {

Why do we have to pass the ISDIR and ISGITLINK here for the regular file
case? ce_path_match and match_pathspec are doing the same thing?

> +                       /*
> +                        * If CE_VALID is on, we assume worktree file and its
> +                        * cache entry are identical, even if worktree file has
> +                        * been modified, so use cache version instead
> +                        */
> +                       if (cached || (ce->ce_flags & CE_VALID) ||
> +                           ce_skip_worktree(ce)) {
> +                               if (ce_stage(ce) || ce_intent_to_add(ce))
> +                                       continue;
> +                               hit |= grep_sha1(opt, ce->oid.hash, ce->name,
> +                                                0, ce->name);
> +                       } else {
> +                               hit |= grep_file(opt, ce->name);
> +                       }
> +               } else if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
> +                          submodule_path_match(pathspec, name.buf, NULL)) {
> +                       hit |= grep_submodule(opt, NULL, ce->name, ce->name);

What is the difference between the last two parameters?

> + * filename: name of the submodule including tree name of parent
> + * path: location of the submodule

That sounds the same to me.

>         }
>
> +       if (recurse_submodules && (!use_index || untracked || list.nr))
> +               die(_("option not supported with --recurse-submodules."));

The user asks: Which option?

> +
> +test_expect_success 'grep and nested submodules' '
> +       git init submodule/sub &&
> +       echo "foobar" >submodule/sub/a &&
> +       git -C submodule/sub add a &&
> +       git -C submodule/sub commit -m "add a" &&
> +       git -C submodule submodule add ./sub &&
> +       git -C submodule add sub &&
> +       git -C submodule commit -m "added sub" &&
> +       git add submodule &&
> +       git commit -m "updated submodule" &&

Both in this test as well as in the setup, we setup a repository
with submodules, that have clean working dirs.

What should happen with dirty working dirs. dirty in the sense:
* file untracked in the submodule
* file added in the submodule, but not committed
* file committed in the submodule, that commit is
   untracked in the superproject
* file committed in the submodule, that commit is
  added to the index in the superproject
* (last case is just as above:) file committed in submodule,
   that commit was committed into the superproject.
