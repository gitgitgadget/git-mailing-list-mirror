Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 817B32023D
	for <e@80x24.org>; Wed, 28 Jun 2017 22:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbdF1WaN (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 18:30:13 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38180 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbdF1WaL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 18:30:11 -0400
Received: by mail-wm0-f42.google.com with SMTP id b184so73137473wme.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 15:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=umMClNuCTSTdYn7mRX8oujL1jQfPomgZk1yrV3wRRhc=;
        b=Okc8cKw+vtSGdQRSZr5vzddyIg2RwnfLR49RvVCjVMctVdV6WYk8AwKP61fzT/puYu
         uER2T0ai7O5UcsS17TkhRll/UDZP8Mq2SLc09IKmlvKiNGaJNFRpbyJX6tQWVPWwfBFC
         r/g8/oKbvFVT4bCJ2hJ4p7TGwUs6DgY7qProivzix1DJcuGYiwC6WYJ+g27GkpmN3Qg8
         uqi50nj9o1kLI6y3ViNRVyx+Gl55MIUbEHzVCRuGuzK6LsLBiPFqgbeTJH+oHauqx8fq
         Tl9OncvaqJKxswfIdoWy7CwiAojES3U9kHsCHshAeBX/SQWpfvdCmiw5jqQe241xxiGK
         4o/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=umMClNuCTSTdYn7mRX8oujL1jQfPomgZk1yrV3wRRhc=;
        b=jtKxR8Dvs1BOtxjyf6ByswRgaOFRwSOEyQPWkFox9FVi3hDZi8motvtArYswPyi8e3
         /V88P+F70eHP4sQVl8SVty77WnpZg4Ckm5fVLbTZpIZ/sRt8a4FQeGMvgT/bouLFTJMF
         zwNqBLaQE/YWcVmxRtyItcxC1Fybx919E46h0Qns6ECpyjeJsR9uz0SQosplsA/Vtcrs
         vqHpMPVye2jM01SHjhqtySOivwoW2Q4Hl0K3kUX1EGhfzpA7ZdLAT5/vtQ64NFaoxCSy
         6Y6QfP1OJyCLeCgqTz1/W7SKrEiQrM9s/ub1NA67CKffnajR88aeeB6sR+2oawRxljrt
         CUCA==
X-Gm-Message-State: AKS2vOyiHsDIcGUAAnSpEk1xWJ5hguXRaekQlnJkTKbtfB2DNtEW31DY
        aCJJPxU9/jkYAQ==
X-Received: by 10.80.182.211 with SMTP id f19mr9132685ede.44.1498689009201;
        Wed, 28 Jun 2017 15:30:09 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id x51sm2687082edd.49.2017.06.28.15.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jun 2017 15:30:07 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dQLTL-0004LW-0w; Thu, 29 Jun 2017 00:30:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 4/6] coccinelle: add a rule to make "expression" code use FREE_AND_NULL()
References: <20170615231549.20085-1-avarab@gmail.com> <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com> <20170615231549.20085-5-avarab@gmail.com> <xmqq7f0byayu.fsf@gitster.mtv.corp.google.com> <2122b01f-7627-cd1b-c7df-751c076f90ff@web.de> <87injfkd0j.fsf@gmail.com> <433f9fb7-a202-1091-46de-04535b2a49e1@web.de>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <433f9fb7-a202-1091-46de-04535b2a49e1@web.de>
Date:   Thu, 29 Jun 2017 00:30:07 +0200
Message-ID: <87efu3kaog.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 28 2017, René Scharfe jotted:

> Am 28.06.2017 um 23:39 schrieb Ævar Arnfjörð Bjarmason:
>>
>> On Sun, Jun 25 2017, René Scharfe jotted:
>>
>>> Am 16.06.2017 um 21:43 schrieb Junio C Hamano:
>>>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>>>
>>>>> A follow-up to the existing "type" rule added in an earlier
>>>>> change. This catches some occurrences that are missed by the previous
>>>>> rule.
>>>>>
>>>>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>>>> ---
>>>>
>>>> Hmph, I wonder if the "type" thing is really needed.  Over there,
>>>> "ptr" is an expression and we can find "free(ptr); ptr = NULL" with
>>>> the rule in this patch already, no?
>>>
>>> Indeed.  How about this on top of master?
>>>
>>> -- >8 --
>>> Subject: [PATCH] coccinelle: polish FREE_AND_NULL rules
>>>
>>> There are two rules for using FREE_AND_NULL in free.cocci, one for
>>> pointer types and one for expressions.  Both cause coccinelle to remove
>>> empty lines and even newline characters between replacements for some
>>> reason; consecutive "free(x);/x=NULL;" sequences end up as multiple
>>> FREE_AND_NULL calls on the same time.
>>>
>>> Remove the type rule, as the expression rule already covers it, and
>>> rearrange the lines of the latter to place the addition of FREE_AND_NULL
>>> between the removals, which causes coccinelle to leave surrounding
>>> whitespace untouched.
>>>
>>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>>> ---
>>>   contrib/coccinelle/free.cocci | 10 +---------
>>>   1 file changed, 1 insertion(+), 9 deletions(-)
>>>
>>> diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
>>> index f2d97e755b..4490069df9 100644
>>> --- a/contrib/coccinelle/free.cocci
>>> +++ b/contrib/coccinelle/free.cocci
>>> @@ -11,16 +11,8 @@ expression E;
>>>     free(E);
>>>
>>>   @@
>>> -type T;
>>> -T *ptr;
>>> -@@
>>> -- free(ptr);
>>> -- ptr = NULL;
>>> -+ FREE_AND_NULL(ptr);
>>> -
>>> -@@
>>>   expression E;
>>>   @@
>>>   - free(E);
>>> -- E = NULL;
>>>   + FREE_AND_NULL(E);
>>> +- E = NULL;
>>
>> Late reply, sorry. What version of coccinelle are you running? I have
>> 1.0.4 (from Debian) and can't get this to produce the same results as
>> what I have.
>>
>> On top of next, I did:
>>
>>          Revert "*.[ch] refactoring: make use of the FREE_AND_NULL() macro"
>>          Revert "coccinelle: make use of the "expression" FREE_AND_NULL() rule"
>>          Revert "coccinelle: make use of the "type" FREE_AND_NULL() rule"
>>
>> And then generated the patch as usual with `make coccicheck`, and
>> applied it. This has your change.
>>
>> I then re-applied the manual "*.[ch] refactoring" changes
>>
>> This results in this diff with next:
>>
>>      $ git diff --stat origin/next.. -- '*.[ch]'
>>       builtin/am.c             |  3 ++-
>>       builtin/clean.c          |  6 ++++--
>>       builtin/config.c         |  6 ++++--
>>       builtin/index-pack.c     |  6 ++++--
>>       builtin/pack-objects.c   | 12 ++++++++----
>>       builtin/unpack-objects.c |  3 ++-
>>       fast-import.c            |  6 ++++--
>>       http-push.c              | 24 ++++++++++++++++--------
>>       http.c                   | 15 ++++++++++-----
>>       imap-send.c              |  3 ++-
>>       ref-filter.c             |  3 ++-
>>       refs/files-backend.c     |  3 ++-
>>       remote-testsvn.c         |  3 ++-
>>       sequencer.c              |  3 ++-
>>       sha1-array.c             |  3 ++-
>>       sha1_file.c              |  3 ++-
>>       transport-helper.c       | 27 ++++++++++++++++++---------
>>       transport.c              |  3 ++-
>>       tree-diff.c              |  6 ++++--
>>       tree.c                   |  3 ++-
>>       20 files changed, 94 insertions(+), 47 deletions(-)
>>
>> These are all cases where we now miss things that should use
>> FREE_AND_NULL(), e.g.:
>>
>>      diff --git a/builtin/am.c b/builtin/am.c
>>      index c973bd96dc..2f89338ed7 100644
>>      --- a/builtin/am.c
>>      +++ b/builtin/am.c
>>      @@ -484,7 +484,8 @@ static int run_applypatch_msg_hook(struct am_state *state)
>>              ret = run_hook_le(NULL, "applypatch-msg", am_path(state, "final-commit"), NULL);
>>
>>              if (!ret) {
>>      -               FREE_AND_NULL(state->msg);
>>      +               free(state->msg);
>>      +               state->msg = NULL;
>>                      if (read_commit_msg(state) < 0)
>>                              die(_("'%s' was deleted by the applypatch-msg hook"),
>>                                      am_path(state, "final-commit"));
>>
>> So it looks to me like removing the "type T" rule breaks a lot of
>> things, but that the change you made to the expression rule is good, and
>> we should do that for the "type" rule as well. Your commit says the
>> "expression rule already covers it", but this doesn't seem to be the
>> case at all.
>>
>> As an aside: Junio, did you mean to apply f8bb4631fb to next this way?
>> Looks like a mis-applied scissor commit.
>
> I can't reproduce that strange result with master, but get a scissors
> line into the commit message as well.  The diff at the end looks
> reasonable (contains just the manual stuff).  Here's what I did:

I get exactly the same thing as you do below when following these
steps. So it seems your patch in
2122b01f-7627-cd1b-c7df-751c076f90ff@web.de is just fine as-is and I
just screwed something up when testing this.

Sorry about the noise. Since this works your original patch is obviously
preferrable since it's not duplicating the rule.

> $ uname -a
> Linux debian 4.9.0-3-amd64 #1 SMP Debian 4.9.30-2 (2017-06-12) x86_64 GNU/Linux
>
> $ spatch -version
> spatch version 1.0.4 with Python support and with PCRE support
>
> $ git checkout -b cocci-free-null origin/master
> Branch cocci-free-null set up to track remote branch master from origin.
> Switched to a new branch 'cocci-free-null'
>
> $ git am
> # pasted my email
> Applying: coccinelle: add a rule to make "expression" code use FREE_AND_NULL()
> # results in commit message with scissor line, interesting..
>
> $ git revert --no-edit 88ce3ef636 e140f7afdd 6a83d90207
> [cocci-free-null b50d5eca5f] Revert "*.[ch] refactoring: make use of the FREE_AND_NULL() macro"
>  12 files changed, 49 insertions(+), 23 deletions(-)
> [cocci-free-null cf9072ce4e] Revert "coccinelle: make use of the "expression" FREE_AND_NULL() rule"
>  2 files changed, 4 insertions(+), 2 deletions(-)
> [cocci-free-null 97675d4dc2] Revert "coccinelle: make use of the "type" FREE_AND_NULL() rule"
>  37 files changed, 142 insertions(+), 71 deletions(-)
>
> $ make contrib/coccinelle/free.cocci.patch
> GIT_VERSION = 2.13.2.537.g97675d4dc2
>      SPATCH contrib/coccinelle/free.cocci
>      SPATCH result: contrib/coccinelle/free.cocci.patch
>
> $ patch -p0 <contrib/coccinelle/free.cocci.patch
> patching file alias.c
> patching file apply.c
> patching file attr.c
> patching file blame.c
> patching file branch.c
> patching file commit.c
> patching file config.c
> patching file credential.c
> patching file diffcore-rename.c
> patching file diff-lib.c
> patching file diff.c
> patching file dir.c
> patching file grep.c
> patching file line-log.c
> patching file ll-merge.c
> patching file mailinfo.c
> patching file object.c
> patching file pathspec.c
> patching file read-cache.c
> patching file refs/files-backend.c
> patching file ref-filter.c
> patching file sequencer.c
> patching file sha1-array.c
> patching file sha1_file.c
> patching file transport.c
> patching file transport-helper.c
> patching file tree-diff.c
> patching file tree.c
> patching file builtin/am.c
> patching file builtin/clean.c
> patching file builtin/config.c
> patching file builtin/index-pack.c
> patching file builtin/pack-objects.c
> patching file builtin/unpack-objects.c
> patching file fast-import.c
> patching file imap-send.c
> patching file remote-testsvn.c
> patching file http-push.c
> patching file http.c
>
> $ git diff HEAD^^^
> diff --git a/builtin/am.c b/builtin/am.c
> index c973bd96dc..eb24eb7b08 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1074,8 +1074,11 @@ static void am_next(struct am_state *state)
>  	struct object_id head;
>
>  	FREE_AND_NULL(state->author_name);
> +
>  	FREE_AND_NULL(state->author_email);
> +
>  	FREE_AND_NULL(state->author_date);
> +
>  	FREE_AND_NULL(state->msg);
>  	state->msg_len = 0;
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index c98e2ce5f5..0c5476ee9d 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -300,8 +300,10 @@ static int add_worktree(const char *path, const char *refname,
>  	}
>
>  	is_junk = 0;
> -	FREE_AND_NULL(junk_work_tree);
> -	FREE_AND_NULL(junk_git_dir);
> +	free(junk_work_tree);
> +	free(junk_git_dir);
> +	junk_work_tree = NULL;
> +	junk_git_dir = NULL;
>
>  done:
>  	if (ret || !opts->keep_locked) {
> diff --git a/commit-slab.h b/commit-slab.h
> index 333d81e370..42d16dcded 100644
> --- a/commit-slab.h
> +++ b/commit-slab.h
> @@ -82,7 +82,8 @@ static MAYBE_UNUSED void clear_ ##slabname(struct slabname *s)		\
>  	for (i = 0; i < s->slab_count; i++)				\
>  		free(s->slab[i]);					\
>  	s->slab_count = 0;						\
> -	FREE_AND_NULL(s->slab);						\
> +	free(s->slab);							\
> +	s->slab = NULL;							\
>  }									\
>  									\
>  static MAYBE_UNUSED elemtype *slabname## _at_peek(struct slabname *s,	\
> diff --git a/gpg-interface.c b/gpg-interface.c
> index d936f3a32f..8ab32df457 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -14,11 +14,16 @@ static const char *gpg_program = "gpg";
>
>  void signature_check_clear(struct signature_check *sigc)
>  {
> -	FREE_AND_NULL(sigc->payload);
> -	FREE_AND_NULL(sigc->gpg_output);
> -	FREE_AND_NULL(sigc->gpg_status);
> -	FREE_AND_NULL(sigc->signer);
> -	FREE_AND_NULL(sigc->key);
> +	free(sigc->payload);
> +	free(sigc->gpg_output);
> +	free(sigc->gpg_status);
> +	free(sigc->signer);
> +	free(sigc->key);
> +	sigc->payload = NULL;
> +	sigc->gpg_output = NULL;
> +	sigc->gpg_status = NULL;
> +	sigc->signer = NULL;
> +	sigc->key = NULL;
>  }
>
>  static struct {
> diff --git a/help.c b/help.c
> index 88a3aeaeb9..5af5319caf 100644
> --- a/help.c
> +++ b/help.c
> @@ -269,8 +269,9 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
>
>  	for (i = 0; i < old->cnt; i++)
>  		cmds->names[cmds->cnt++] = old->names[i];
> -	FREE_AND_NULL(old->names);
> +	free(old->names);
>  	old->cnt = 0;
> +	old->names = NULL;
>  }
>
>  /* An empirically derived magic number */
> diff --git a/line-log.c b/line-log.c
> index ab0709f9ae..f225447ebb 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -34,8 +34,9 @@ void range_set_init(struct range_set *rs, size_t prealloc)
>
>  void range_set_release(struct range_set *rs)
>  {
> -	FREE_AND_NULL(rs->ranges);
> +	free(rs->ranges);
>  	rs->alloc = rs->nr = 0;
> +	rs->ranges = NULL;
>  }
>
>  /* dst must be uninitialized! */
> diff --git a/prio-queue.c b/prio-queue.c
> index 126d096727..fc3860fdcb 100644
> --- a/prio-queue.c
> +++ b/prio-queue.c
> @@ -27,9 +27,10 @@ void prio_queue_reverse(struct prio_queue *queue)
>
>  void clear_prio_queue(struct prio_queue *queue)
>  {
> -	FREE_AND_NULL(queue->array);
> +	free(queue->array);
>  	queue->nr = 0;
>  	queue->alloc = 0;
> +	queue->array = NULL;
>  	queue->insertion_ctr = 0;
>  }
>
> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index 76bb723c86..af2fcb2c12 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -82,8 +82,9 @@ static void clear_ref_dir(struct ref_dir *dir)
>  	int i;
>  	for (i = 0; i < dir->nr; i++)
>  		free_ref_entry(dir->entries[i]);
> -	FREE_AND_NULL(dir->entries);
> +	free(dir->entries);
>  	dir->sorted = dir->nr = dir->alloc = 0;
> +	dir->entries = NULL;
>  }
>
>  struct ref_entry *create_dir_entry(struct ref_cache *cache,
> diff --git a/rerere.c b/rerere.c
> index 70634d456c..829b3b0f08 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -40,8 +40,9 @@ static void free_rerere_dirs(void)
>  		free(rerere_dir[i]->status);
>  		free(rerere_dir[i]);
>  	}
> -	FREE_AND_NULL(rerere_dir);
> +	free(rerere_dir);
>  	rerere_dir_nr = rerere_dir_alloc = 0;
> +	rerere_dir = NULL;
>  }
>
>  static void free_rerere_id(struct string_list_item *item)
> diff --git a/split-index.c b/split-index.c
> index 83e39ec8d7..f519e60f87 100644
> --- a/split-index.c
> +++ b/split-index.c
> @@ -167,9 +167,10 @@ void merge_base_index(struct index_state *istate)
>
>  	ewah_free(si->delete_bitmap);
>  	ewah_free(si->replace_bitmap);
> -	FREE_AND_NULL(si->saved_cache);
> +	free(si->saved_cache);
>  	si->delete_bitmap  = NULL;
>  	si->replace_bitmap = NULL;
> +	si->saved_cache	   = NULL;
>  	si->saved_cache_nr = 0;
>  }
>
