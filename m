Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41A739A7F4
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672644; cv=none; b=jdMpnE5g9/YaVHAVqB3ENprvLJw2fXIJAoalWqin11i+Z+KYs0uyX4vzLa1EcHtuGPlaVwqC7kjI8XWL07NGpnjSEaoJcvV/iIjyxJcyydZwiQcJ/2F1wHiJzG0AVnTXeGTv3fWkg2q0pKRBuk5BbwtFKZqHssxXyweXUcIJd5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672644; c=relaxed/simple;
	bh=k0krpDv0Vmtn0DmKcn0Y40FXDxUGTsz2M7lswO8wCOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pDM6rBT64Be3TbQq0rBTez+9luWa8rICSmkFW90gpOS+LMMxpvFp/8UKO5csS66AD4si/kW72bGeaFUbrsNrYQeByY0JbholX8lgoBdmYNo8eGj/oJWkNW3eYnifCL31fozDw31R2RAjpQqN0DSAvEQnaNL810rI07ORE4xX77A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAhGFMgf; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAhGFMgf"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68bac6e24fdso2979522a12.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780672640; x=1781277440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ssjj5Jda4Vot3gDsthRo8fouLicQurIqJsBsGjLT/+M=;
        b=kAhGFMgfXcHnY54NXQVHiXqMGdTe5Z5j9G2okwM6OFfWCE+aGCvpy0xpD7Mzp6mos5
         pFyDSymwildQwZ/3PC/SqxmcRppVgelHpwabkBWgYKzv/PIsbU1vA9QqYx9eKhyyST8X
         bOEwQcGLzkfREj8RNQUK+wXA3ThtF+8Ih9lP6xArjbuRjx9y2JausKeVxHTxWM+zJvnD
         MYWH/gGY0D2UpE6BJHfop7TXt8oMysOpMYqvLHNkDwFRZaRRKJ9Axp9aZjTC5aEG0cy3
         hqL648XI9BFz1++ZgymkdXufqtg3suKa7VL2tvTa0lccq88dob17pvWbv40/pRAzgJdf
         KSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780672640; x=1781277440;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssjj5Jda4Vot3gDsthRo8fouLicQurIqJsBsGjLT/+M=;
        b=q+zpBgzvtk0lk1eQQHRjcdg62GoqfE2qIDKnKjtFzqs4Cx74xnCItMs88tAKc8nIgd
         AV/2zHRDObbkzuaXglurPbPH5Xg5nKE8Y7QCQrB+WsFbZSULO4VVWrD17gmiUXC+vr/Y
         CLAm1GASXgq3XXRNJYi52B+cV4v/IT20HTasjNu3Uy0hawKdnKVZcfAxm2LVnd8mDN3H
         HM/EE+DPAd5rtZrYsPLIPMZhIqluoMymvPh3uxhLoZAcZ6PP59qrDqsPi8FK47XI9T3z
         OKE8RY0uwAXu1DlvItiwAJako5RGKnjFUC4O681N4ZlzglPV9rtHIRL/h9rwaY7xdICt
         W2Nw==
X-Forwarded-Encrypted: i=1; AFNElJ/AA0LSzlPiNCp1Ga3DeYoZxQtgEyG9XIGM8D7hcqWfM7IPLF5UKP9VODXnhu3r5wZsa5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx/nCXuk7kV8noiL2zz6Ts7LAnqDO6YxFVX+rcrucA3IKpJCTN
	EJvYcVgdLYcWFrbaFA0FqFnOVLq4/gHcwtBdYwQ20y8XbucW3pG3yDz3BXPwug==
X-Gm-Gg: Acq92OFN5E78QG68CICkOVyIUs23KaQhD8FNU0Or+VwLK9pbkABZYHNGxnQCnrXL/zN
	YQ7lel79JLK4bidlIrPEnQkACNFfhVWgQWALO8ctHuH6P6lzoYm+K3vwAdII5Pi/ufdGmI2iInL
	HeCnLvlOru9SK/+F+o4AhJP6a0RnxneVwXAZzhAHYdBpCq8JJWWYQwHID9SjaEuc3ioh0jj0U3d
	wHmA9LxX+RSOll9d5p/4fgTgMw8FnBvPWSVqDQr3AioeTIebpPfY4tl5E7iIjEiJVwresWnnGr6
	+YRRJWPPDZaJ9Jnkmopyct4ZJ9lbLF4AYVOONDvvBVhyn6ps+1G34QX2NI5rIyfe/gZDpyh9eXp
	TLl3W2q0ooYdoJiR3uBPMHZUFmI1qh573R9hxYLyknYWmD+psbMzd9vxG1gP7JeBnaosUcCYB2c
	a29WluRfeXOjZazqvM+RcpLx+UFzXwk/U3Zur96vFR7TpWUyF5GBdWe2/8C1UGGMRhtVtfkwd+w
	dbDGSEBD6vvOQ==
X-Received: by 2002:a17:906:6296:b0:bda:a98:e584 with SMTP id a640c23a62f3a-bf37234ab68mr221993166b.23.1780672639478;
        Fri, 05 Jun 2026 08:17:19 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf055307aacsm476221966b.47.2026.06.05.08.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 08:17:19 -0700 (PDT)
Message-ID: <b1b15a47-0842-4a26-9a95-bfdae12799e0@gmail.com>
Date: Fri, 5 Jun 2026 16:17:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] worktree: record creation time and free-form note
To: "Kiesel, Norbert" <norbert.kiesel@creditkarma.com>, git@vger.kernel.org
References: <CAPGaHku+RAV+FA3C0md0xHiavfdB_anoqcMM06MAiU1VyMAdLA@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPGaHku+RAV+FA3C0md0xHiavfdB_anoqcMM06MAiU1VyMAdLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Norbert

On 02/06/2026 22:40, Kiesel, Norbert wrote:
> 
> Add per-worktree metadata so users can answer "what is this worktree
> for, and when did I make it?" without resorting to external notes.

A couple of thoughts related to this

Isn't "what is the worktree for" a property of the branch that's checked 
out, not the worktree itself? We already have 
branch.<branch>.description to add a descritpion to a branch. If you 
have a detached HEAD it is trickier though.

I don't think I've ever wanted to know when a worktree was created. I 
would find it useful to be able to sort worktrees by when they were last 
updated (i.e. the reflog date of HEAD in each worktree) to see which 
ones are stale though.

Thanks

Phillip

> When `git worktree add` creates a linked worktree, it now writes a
> `created` file containing the unix timestamp. A new `--note <string>`
> option to `add`, and a new `git worktree annotate <worktree> [<note>]`
> subcommand, store an optional free-form description in a `note` file
> next to the other administrative files. Passing `annotate` without a
> note clears it. The main worktree carries no metadata and cannot be
> annotated.
> 
> `git worktree list` learns `--show-created` and `--show-note` for
> human-readable output, and `--sort=<key>` (path or created, optionally
> prefixed with `-` to reverse) for ordering linked worktrees; the main
> worktree always stays first. Worktrees without a recorded timestamp
> (those created before this change) display as `created: unknown` and
> sort after timestamped ones. Porcelain output unconditionally emits
> `created` and `note` lines when the corresponding metadata is present.
> 
> Tests cover add/annotate/list behaviour and the legacy-worktree case.
> The two existing porcelain assertions in t2402 are taught to strip the
> new `created` line so they continue to pass.
> 
> Signed-off-by: Norbert Kiesel <norbert.kiesel@creditkarma.com>
> ---
>   Documentation/git-worktree.adoc |  61 ++++++++++++-
>   builtin/worktree.c              | 152 +++++++++++++++++++++++++++++++-
>   t/meson.build                   |   1 +
>   t/t2402-worktree-list.sh        |  10 ++-
>   t/t2410-worktree-metadata.sh    | 143 ++++++++++++++++++++++++++++++
>   worktree.c                      |  78 ++++++++++++++++
>   worktree.h                      |  23 +++++
>   7 files changed, 459 insertions(+), 9 deletions(-)
>   create mode 100755 t/t2410-worktree-metadata.sh
> 
> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
> index fbf8426cd9..200f3d7772 100644
> --- a/Documentation/git-worktree.adoc
> +++ b/Documentation/git-worktree.adoc
> @@ -10,8 +10,11 @@ SYNOPSIS
>   --------
>   [synopsis]
>   git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]
> + [--note <string>]
>    [--orphan] [(-b | -B) <new-branch>] <path> [<commit-ish>]
> -git worktree list [-v | --porcelain [-z]]
> +git worktree annotate <worktree> [<note>]
> +git worktree list [-v | --porcelain [-z]] [--show-created] [--show-note]
> + [--sort=<key>]
>   git worktree lock [--reason <string>] <worktree>
>   git worktree move <worktree> <new-path>
>   git worktree prune [-n] [-v] [--expire <expire>]
> @@ -106,6 +109,15 @@ passed to the command. In the event the
> repository has a remote and
>   command fails with a warning reminding the user to fetch from their remote
>   first (or override by using `-f`/`--force`).
> 
> +`annotate <worktree> [<note>]`::
> +
> +Set, replace, or clear a free-form note (description) on a linked worktree.
> +Useful for recording what a worktree was created for so it can be identified
> +later. With _<note>_, the worktree's note is set or replaced; without a note
> +argument, the existing note is cleared. The note for a worktree may also be
> +set at creation time with `git worktree add --note <note>`. The main
> +worktree cannot be annotated.
> +
>   `list`::
> 
>   List details of each worktree.  The main worktree is listed first,
> @@ -114,6 +126,20 @@ whether the worktree is bare, the revision
> currently checked out, the
>   branch currently checked out (or "detached HEAD" if none), "locked" if
>   the worktree is locked, "prunable" if the worktree can be pruned by the
>   `prune` command.
> ++
> +Each worktree's creation timestamp is recorded when it is created with
> +`git worktree add`. Worktrees created before this feature existed have no
> +recorded creation timestamp; for them, `list` reports `created: unknown`
> +in human output and omits the `created` line in `--porcelain` output. Pass
> +`--show-created` to include creation timestamps in human output. Worktrees
> +without a recorded timestamp sort last (or first when reversed) with
> +`--sort=created`.
> ++
> +Pass `--show-note` to include any user-provided note in human output. In
> +`--porcelain` output, both `created` and `note` lines are emitted whenever
> +present. Use `--sort=<key>` (where _<key>_ is `path` or `created`,
> +optionally prefixed with `-` to reverse) to order the linked worktrees;
> +the main worktree always remains first.
> 
>   `lock`::
> 
> @@ -286,6 +312,32 @@ _<time>_.
>    With `lock` or with `add --lock`, an explanation why the worktree
>    is locked.
> 
> +`--note <string>`::
> + With `add`, attach a free-form note (description) to the new worktree.
> + The note is stored alongside the worktree's administrative files and
> + can be displayed with `git worktree list --show-note` or in
> + `--porcelain` output. It can be changed later with
> + `git worktree annotate`.
> +
> +`--show-created`::
> + With `list`, include each worktree's creation timestamp in the
> + human-readable output. Worktrees with no recorded creation time are
> + shown as `created: unknown`. In `--porcelain` output, the creation
> + timestamp is always included (when available) on a `created` line.
> +
> +`--show-note`::
> + With `list`, include each worktree's note (if set) in the
> + human-readable output. In `--porcelain` output, the note is always
> + included (when set) on a `note` line.
> +
> +`--sort=<key>`::
> + With `list`, sort linked worktrees by _<key>_, which is one of
> + `path` or `created`. Prefix with `-` to reverse the order, e.g.
> + `--sort=-created` lists newest first. The main worktree is always
> + listed first regardless of sort order. Worktrees with no recorded
> + creation timestamp sort after those that have one (or before, when
> + reversed).
> +
>   _<worktree>_::
>    Worktrees can be identified by path, either relative or absolute.
>   +
> @@ -462,7 +514,9 @@ are terminated with NUL rather than a newline.
> Attributes are listed with a
>   label and value separated by a single space.  Boolean attributes (like `bare`
>   and `detached`) are listed as a label only, and are present only
>   if the value is true.  Some attributes (like `locked`) can be listed as a label
> -only or with a value depending upon whether a reason is available.  The first
> +only or with a value depending upon whether a reason is available.  Optional
> +valued attributes (like `created` and `note`) appear only when the
> +corresponding metadata has been recorded for that worktree.  The first
>   attribute of a worktree is always `worktree`, an empty line indicates the
>   end of the record.  For example:
> 
> @@ -474,10 +528,13 @@ bare
>   worktree /path/to/linked-worktree
>   HEAD abcd1234abcd1234abcd1234abcd1234abcd1234
>   branch refs/heads/master
> +created 2026-06-01T12:34:56Z
> +note investigating login bug
> 
>   worktree /path/to/other-linked-worktree
>   HEAD 1234abc1234abc1234abc1234abc1234abc1234a
>   detached
> +created 2026-05-28T08:15:00Z
> 
>   worktree /path/to/linked-worktree-locked-no-reason
>   HEAD 5678abc5678abc5678abc5678abc5678abc5678c
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index d21c43fde3..ac22277d6c 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -27,13 +27,16 @@
>   #include "utf8.h"
>   #include "worktree.h"
>   #include "quote.h"
> +#include "date.h"
> 
>   #define BUILTIN_WORKTREE_ADD_USAGE \
>    N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason
> <string>]]\n" \
> +    "                 [--note <string>]\n" \
>       "                 [--orphan] [(-b | -B) <new-branch>] <path>
> [<commit-ish>]")
> 
>   #define BUILTIN_WORKTREE_LIST_USAGE \
> - N_("git worktree list [-v | --porcelain [-z]]")
> + N_("git worktree list [-v | --porcelain [-z]] [--show-created]
> [--show-note]\n" \
> +    "                  [--sort=<key>]")
>   #define BUILTIN_WORKTREE_LOCK_USAGE \
>    N_("git worktree lock [--reason <string>] <worktree>")
>   #define BUILTIN_WORKTREE_MOVE_USAGE \
> @@ -46,6 +49,8 @@
>    N_("git worktree repair [<path>...]")
>   #define BUILTIN_WORKTREE_UNLOCK_USAGE \
>    N_("git worktree unlock <worktree>")
> +#define BUILTIN_WORKTREE_ANNOTATE_USAGE \
> + N_("git worktree annotate <worktree> [<note>]")
> 
>   #define WORKTREE_ADD_DWIM_ORPHAN_INFER_TEXT \
>    _("No possible source branch, inferring '--orphan'")
> @@ -66,6 +71,7 @@
> 
>   static const char * const git_worktree_usage[] = {
>    BUILTIN_WORKTREE_ADD_USAGE,
> + BUILTIN_WORKTREE_ANNOTATE_USAGE,
>    BUILTIN_WORKTREE_LIST_USAGE,
>    BUILTIN_WORKTREE_LOCK_USAGE,
>    BUILTIN_WORKTREE_MOVE_USAGE,
> @@ -116,6 +122,11 @@ static const char * const git_worktree_unlock_usage[] = {
>    NULL
>   };
> 
> +static const char * const git_worktree_annotate_usage[] = {
> + BUILTIN_WORKTREE_ANNOTATE_USAGE,
> + NULL
> +};
> +
>   struct add_opts {
>    int force;
>    int detach;
> @@ -124,6 +135,7 @@ struct add_opts {
>    int orphan;
>    int relative_paths;
>    const char *keep_locked;
> + const char *note;
>   };
> 
>   static int show_only;
> @@ -131,6 +143,8 @@ static int verbose;
>   static int guess_remote;
>   static int use_relative_paths;
>   static timestamp_t expire;
> +static int show_created;
> +static int show_note;
> 
>   static int git_worktree_config(const char *var, const char *value,
>           const struct config_context *ctx, void *cb)
> @@ -544,6 +558,16 @@ static int add_worktree(const char *path, const
> char *refname,
>    strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
>    write_file(sb.buf, "../..");
> 
> + strbuf_reset(&sb);
> + strbuf_addf(&sb, "%s/created", sb_repo.buf);
> + write_file(sb.buf, "%"PRItime, (timestamp_t) time(NULL));
> +
> + if (opts->note && *opts->note) {
> + strbuf_reset(&sb);
> + strbuf_addf(&sb, "%s/note", sb_repo.buf);
> + write_file(sb.buf, "%s", opts->note);
> + }
> +
>    /*
>    * Set up the ref store of the worktree and create the HEAD reference.
>    */
> @@ -815,6 +839,8 @@ static int add(int ac, const char **av, const char *prefix,
>    OPT_BOOL(0, "lock", &keep_locked, N_("keep the new working tree locked")),
>    OPT_STRING(0, "reason", &lock_reason, N_("string"),
>       N_("reason for locking")),
> + OPT_STRING(0, "note", &opts.note, N_("string"),
> +    N_("attach a free-form note/description to the worktree")),
>    OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
>    OPT_PASSTHRU(0, "track", &opt_track, NULL,
>         N_("set up tracking mode (see git-branch(1))"),
> @@ -963,6 +989,8 @@ static int add(int ac, const char **av, const char *prefix,
>   static void show_worktree_porcelain(struct worktree *wt, int line_terminator)
>   {
>    const char *reason;
> + const char *note;
> + timestamp_t created;
> 
>    printf("worktree %s%c", wt->path, line_terminator);
>    if (wt->is_bare)
> @@ -975,6 +1003,18 @@ static void show_worktree_porcelain(struct
> worktree *wt, int line_terminator)
>    printf("branch %s%c", wt->head_ref, line_terminator);
>    }
> 
> + created = worktree_created_at(wt);
> + if (created)
> + printf("created %s%c",
> +        show_date(created, 0, DATE_MODE(ISO8601_STRICT)),
> +        line_terminator);
> +
> + note = worktree_note(wt);
> + if (note && *note) {
> + fputs("note ", stdout);
> + write_name_quoted(note, stdout, line_terminator);
> + }
> +
>    reason = worktree_lock_reason(wt);
>    if (reason) {
>    fputs("locked", stdout);
> @@ -1034,6 +1074,21 @@ static void show_worktree(struct worktree *wt,
> struct worktree_display *display,
>    else if (reason)
>    strbuf_addstr(&sb, " prunable");
> 
> + if (show_created || verbose) {
> + timestamp_t created = worktree_created_at(wt);
> + if (created)
> + strbuf_addf(&sb, "\n\tcreated: %s",
> +     show_date(created, 0, DATE_MODE(ISO8601)));
> + else if (show_created && !is_main_worktree(wt))
> + strbuf_addstr(&sb, "\n\tcreated: unknown");
> + }
> +
> + if (show_note || verbose) {
> + const char *note = worktree_note(wt);
> + if (note && *note)
> + strbuf_addf(&sb, "\n\tnote: %s", note);
> + }
> +
>    printf("%s\n", sb.buf);
>    strbuf_release(&sb);
>   }
> @@ -1068,6 +1123,27 @@ static int pathcmp(const void *a_, const void *b_)
>    return fspathcmp((*a)->path, (*b)->path);
>   }
> 
> +static int createdcmp(const void *a_, const void *b_)
> +{
> + struct worktree *const *a = a_;
> + struct worktree *const *b = b_;
> + timestamp_t ta = worktree_created_at(*a);
> + timestamp_t tb = worktree_created_at(*b);
> +
> + /* Worktrees without a recorded timestamp (legacy) sort after those
> with one. */
> + if (!ta && !tb)
> + return fspathcmp((*a)->path, (*b)->path);
> + if (!ta)
> + return 1;
> + if (!tb)
> + return -1;
> + if (ta < tb)
> + return -1;
> + if (ta > tb)
> + return 1;
> + return 0;
> +}
> +
>   static void pathsort(struct worktree **wt)
>   {
>    int n = 0;
> @@ -1078,11 +1154,43 @@ static void pathsort(struct worktree **wt)
>    QSORT(wt, n, pathcmp);
>   }
> 
> +static int sort_worktrees(struct worktree **wt, const char *key)
> +{
> + int n = 0, reverse = 0;
> + struct worktree **p = wt;
> + int (*cmp)(const void *, const void *);
> +
> + if (*key == '-') {
> + reverse = 1;
> + key++;
> + }
> + if (!strcmp(key, "path"))
> + cmp = pathcmp;
> + else if (!strcmp(key, "created"))
> + cmp = createdcmp;
> + else
> + return -1;
> +
> + while (*p++)
> + n++;
> + QSORT(wt, n, cmp);
> + if (reverse) {
> + int i;
> + for (i = 0; i < n / 2; i++) {
> + struct worktree *tmp = wt[i];
> + wt[i] = wt[n - 1 - i];
> + wt[n - 1 - i] = tmp;
> + }
> + }
> + return 0;
> +}
> +
>   static int list(int ac, const char **av, const char *prefix,
>    struct repository *repo UNUSED)
>   {
>    int porcelain = 0;
>    int line_terminator = '\n';
> + const char *sort_key = NULL;
> 
>    struct option options[] = {
>    OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
> @@ -1091,6 +1199,12 @@ static int list(int ac, const char **av, const
> char *prefix,
>    N_("add 'prunable' annotation to missing worktrees older than <time>")),
>    OPT_SET_INT('z', NULL, &line_terminator,
>        N_("terminate records with a NUL character"), '\0'),
> + OPT_BOOL(0, "show-created", &show_created,
> + N_("show worktree creation timestamps")),
> + OPT_BOOL(0, "show-note", &show_note,
> + N_("show worktree notes")),
> + OPT_STRING(0, "sort", &sort_key, N_("key"),
> +    N_("sort worktrees by key (path, created); prefix with - to reverse")),
>    OPT_END()
>    };
> 
> @@ -1107,8 +1221,13 @@ static int list(int ac, const char **av, const
> char *prefix,
>    int path_maxwidth = 0, abbrev = DEFAULT_ABBREV, i;
>    struct worktree_display *display = NULL;
> 
> - /* sort worktrees by path but keep main worktree at top */
> - pathsort(worktrees + 1);
> + /* sort worktrees but keep main worktree at top */
> + if (sort_key) {
> + if (sort_worktrees(worktrees + 1, sort_key))
> + die(_("unknown sort key '%s'"), sort_key);
> + } else {
> + pathsort(worktrees + 1);
> + }
> 
>    if (!porcelain)
>    measure_widths(worktrees, &abbrev,
> @@ -1200,6 +1319,32 @@ static int unlock_worktree(int ac, const char
> **av, const char *prefix,
>    return ret;
>   }
> 
> +static int annotate_worktree(int ac, const char **av, const char *prefix,
> +      struct repository *repo UNUSED)
> +{
> + struct option options[] = {
> + OPT_END()
> + };
> + struct worktree **worktrees, *wt;
> + int ret;
> +
> + ac = parse_options(ac, av, prefix, options, git_worktree_annotate_usage, 0);
> + if (ac < 1 || ac > 2)
> + usage_with_options(git_worktree_annotate_usage, options);
> +
> + worktrees = get_worktrees();
> + wt = find_worktree(worktrees, prefix, av[0]);
> + if (!wt)
> + die(_("'%s' is not a working tree"), av[0]);
> + if (is_main_worktree(wt))
> + die(_("The main working tree cannot be annotated"));
> +
> + ret = set_worktree_note(wt, ac == 2 ? av[1] : NULL);
> +
> + free_worktrees(worktrees);
> + return ret;
> +}
> +
>   static void validate_no_submodules(const struct worktree *wt)
>   {
>    struct index_state istate = INDEX_STATE_INIT(the_repository);
> @@ -1469,6 +1614,7 @@ int cmd_worktree(int ac,
>    parse_opt_subcommand_fn *fn = NULL;
>    struct option options[] = {
>    OPT_SUBCOMMAND("add", &fn, add),
> + OPT_SUBCOMMAND("annotate", &fn, annotate_worktree),
>    OPT_SUBCOMMAND("prune", &fn, prune),
>    OPT_SUBCOMMAND("list", &fn, list),
>    OPT_SUBCOMMAND("lock", &fn, lock_worktree),
> diff --git a/t/meson.build b/t/meson.build
> index 2af8d01279..7b6e8435d7 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -308,6 +308,7 @@ integration_tests = [
>     't2405-worktree-submodule.sh',
>     't2406-worktree-repair.sh',
>     't2407-worktree-heads.sh',
> +  't2410-worktree-metadata.sh',
>     't2500-untracked-overwriting.sh',
>     't2501-cwd-empty.sh',
>     't3000-ls-files-others.sh',
> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> index e0c6abd2f5..8422340443 100755
> --- a/t/t2402-worktree-list.sh
> +++ b/t/t2402-worktree-list.sh
> @@ -71,7 +71,8 @@ test_expect_success '"list" all worktrees --porcelain' '
>    echo "HEAD $(git rev-parse HEAD)" >>expect &&
>    echo "detached" >>expect &&
>    echo >>expect &&
> - git worktree list --porcelain >actual &&
> + git worktree list --porcelain >actual.raw &&
> + grep -v "^created " actual.raw >actual &&
>    test_cmp expect actual
>   '
> 
> @@ -86,7 +87,7 @@ test_expect_success '"list" all worktrees --porcelain -z' '
>    "$(git -C here rev-parse --show-toplevel)" \
>    "$(git rev-parse HEAD)" >>expect &&
>    git worktree list --porcelain -z >_actual &&
> - nul_to_q <_actual >actual &&
> + nul_to_q <_actual | tr Q "\n" | grep -v "^created " | tr "\n" Q >actual &&
>    test_cmp expect actual
>   '
> 
> @@ -220,7 +221,7 @@ test_expect_success '"list" all worktrees from bare main' '
>   '
> 
>   test_expect_success '"list" all worktrees --porcelain from bare main' '
> - test_when_finished "rm -rf there actual expect && git -C bare1
> worktree prune" &&
> + test_when_finished "rm -rf there actual actual.raw expect && git -C
> bare1 worktree prune" &&
>    git -C bare1 worktree add --detach ../there main &&
>    echo "worktree $(pwd)/bare1" >expect &&
>    echo "bare" >>expect &&
> @@ -229,7 +230,8 @@ test_expect_success '"list" all worktrees
> --porcelain from bare main' '
>    echo "HEAD $(git -C there rev-parse HEAD)" >>expect &&
>    echo "detached" >>expect &&
>    echo >>expect &&
> - git -C bare1 worktree list --porcelain >actual &&
> + git -C bare1 worktree list --porcelain >actual.raw &&
> + grep -v "^created " actual.raw >actual &&
>    test_cmp expect actual
>   '
> 
> diff --git a/t/t2410-worktree-metadata.sh b/t/t2410-worktree-metadata.sh
> new file mode 100755
> index 0000000000..3f8b508593
> --- /dev/null
> +++ b/t/t2410-worktree-metadata.sh
> @@ -0,0 +1,143 @@
> +#!/bin/sh
> +
> +test_description='git worktree creation timestamp and note metadata'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> + test_commit init
> +'
> +
> +test_expect_success 'add writes created file' '
> + test_when_finished "git worktree remove -f wt1 && git worktree prune" &&
> + git worktree add wt1 &&
> + test_path_is_file .git/worktrees/wt1/created &&
> + # contents should be a positive integer (unix timestamp)
> + created=$(cat .git/worktrees/wt1/created) &&
> + test "$created" -gt 0
> +'
> +
> +test_expect_success 'add --note writes note file' '
> + test_when_finished "git worktree remove -f wt2 && git worktree prune" &&
> + git worktree add --note "investigating bug" wt2 &&
> + test_path_is_file .git/worktrees/wt2/note &&
> + echo "investigating bug" >expect &&
> + test_cmp expect .git/worktrees/wt2/note
> +'
> +
> +test_expect_success 'add without --note does not create note file' '
> + test_when_finished "git worktree remove -f wt3 && git worktree prune" &&
> + git worktree add wt3 &&
> + test_path_is_missing .git/worktrees/wt3/note
> +'
> +
> +test_expect_success 'annotate sets a note on an existing worktree' '
> + test_when_finished "git worktree remove -f wt4 && git worktree prune" &&
> + git worktree add wt4 &&
> + git worktree annotate wt4 "later note" &&
> + echo "later note" >expect &&
> + test_cmp expect .git/worktrees/wt4/note
> +'
> +
> +test_expect_success 'annotate replaces an existing note' '
> + test_when_finished "git worktree remove -f wt5 && git worktree prune" &&
> + git worktree add --note "old" wt5 &&
> + git worktree annotate wt5 "new" &&
> + echo "new" >expect &&
> + test_cmp expect .git/worktrees/wt5/note
> +'
> +
> +test_expect_success 'annotate with no text clears the note' '
> + test_when_finished "git worktree remove -f wt6 && git worktree prune" &&
> + git worktree add --note "to delete" wt6 &&
> + test_path_is_file .git/worktrees/wt6/note &&
> + git worktree annotate wt6 &&
> + test_path_is_missing .git/worktrees/wt6/note
> +'
> +
> +test_expect_success 'annotate refuses to operate on the main worktree' '
> + test_must_fail git worktree annotate . "should fail" 2>err &&
> + grep -i "main working tree" err
> +'
> +
> +test_expect_success 'list --show-note displays note in human output' '
> + test_when_finished "git worktree remove -f wt7 && git worktree prune" &&
> + git worktree add --note "release branch" wt7 &&
> + git worktree list --show-note >actual &&
> + grep "note: release branch" actual
> +'
> +
> +test_expect_success 'list --show-created displays created timestamp' '
> + test_when_finished "git worktree remove -f wt8 && git worktree prune" &&
> + git worktree add wt8 &&
> + git worktree list --show-created >actual &&
> + grep "created: " actual
> +'
> +
> +test_expect_success 'list --show-created shows unknown for legacy worktrees' '
> + test_when_finished "git worktree remove -f wt9 && git worktree prune" &&
> + git worktree add wt9 &&
> + rm .git/worktrees/wt9/created &&
> + git worktree list --show-created >actual &&
> + grep "created: unknown" actual
> +'
> +
> +test_expect_success 'list --porcelain always includes created and note' '
> + test_when_finished "git worktree remove -f wtp && git worktree prune" &&
> + git worktree add --note "porcelain test" wtp &&
> + git worktree list --porcelain >actual &&
> + grep "^created " actual &&
> + grep "^note porcelain test" actual
> +'
> +
> +test_expect_success 'list --sort=created orders by creation time' '
> + test_when_finished "git worktree remove -f a && git worktree remove
> -f b && git worktree remove -f c && git worktree prune" &&
> + git worktree add a &&
> + git worktree add b &&
> + git worktree add c &&
> + echo 1000 >.git/worktrees/a/created &&
> + echo 2000 >.git/worktrees/b/created &&
> + echo 3000 >.git/worktrees/c/created &&
> + git worktree list --sort=created --porcelain >actual &&
> + grep "^worktree " actual | sed -n "2,4p" >linked &&
> + awk "NR==1" linked | grep -q "/a$" &&
> + awk "NR==2" linked | grep -q "/b$" &&
> + awk "NR==3" linked | grep -q "/c$"
> +'
> +
> +test_expect_success 'list --sort=-created reverses order' '
> + test_when_finished "git worktree remove -f a && git worktree remove
> -f b && git worktree remove -f c && git worktree prune" &&
> + git worktree add a &&
> + git worktree add b &&
> + git worktree add c &&
> + echo 1000 >.git/worktrees/a/created &&
> + echo 2000 >.git/worktrees/b/created &&
> + echo 3000 >.git/worktrees/c/created &&
> + git worktree list --sort=-created --porcelain >actual &&
> + grep "^worktree " actual | sed -n "2,4p" >linked &&
> + awk "NR==1" linked | grep -q "/c$" &&
> + awk "NR==2" linked | grep -q "/b$" &&
> + awk "NR==3" linked | grep -q "/a$"
> +'
> +
> +test_expect_success 'list --sort=created places legacy worktrees last' '
> + test_when_finished "git worktree remove -f early && git worktree
> remove -f legacy && git worktree prune" &&
> + git worktree add early &&
> + echo 1000 >.git/worktrees/early/created &&
> + git worktree add legacy &&
> + rm .git/worktrees/legacy/created &&
> + git worktree list --sort=created --porcelain >actual &&
> + grep "^worktree " actual | sed -n "2,3p" >linked &&
> + awk "NR==1" linked | grep -q "/early$" &&
> + awk "NR==2" linked | grep -q "/legacy$"
> +'
> +
> +test_expect_success 'list --sort with unknown key fails' '
> + test_must_fail git worktree list --sort=bogus 2>err &&
> + grep -i "unknown sort key" err
> +'
> +
> +test_done
> diff --git a/worktree.c b/worktree.c
> index 97eddc3916..7989e694b7 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -14,6 +14,8 @@
>   #include "dir.h"
>   #include "wt-status.h"
>   #include "config.h"
> +#include "date.h"
> +#include "wrapper.h"
> 
>   void free_worktree(struct worktree *worktree)
>   {
> @@ -24,6 +26,7 @@ void free_worktree(struct worktree *worktree)
>    free(worktree->head_ref);
>    free(worktree->lock_reason);
>    free(worktree->prune_reason);
> + free(worktree->note);
>    free(worktree);
>   }
> 
> @@ -324,6 +327,81 @@ const char *worktree_lock_reason(struct worktree *wt)
>    return wt->lock_reason;
>   }
> 
> +timestamp_t worktree_created_at(struct worktree *wt)
> +{
> + if (is_main_worktree(wt))
> + return 0;
> +
> + if (!wt->created_at_valid) {
> + struct strbuf path = STRBUF_INIT;
> + struct strbuf buf = STRBUF_INIT;
> +
> + strbuf_addstr(&path, worktree_git_path(wt, "created"));
> + if (file_exists(path.buf) &&
> +     strbuf_read_file(&buf, path.buf, 0) >= 0) {
> + char *end;
> + timestamp_t t;
> + strbuf_trim(&buf);
> + t = parse_timestamp(buf.buf, &end, 10);
> + if (end != buf.buf && *end == '\0')
> + wt->created_at = t;
> + }
> + wt->created_at_valid = 1;
> + strbuf_release(&path);
> + strbuf_release(&buf);
> + }
> +
> + return wt->created_at;
> +}
> +
> +const char *worktree_note(struct worktree *wt)
> +{
> + if (is_main_worktree(wt))
> + return NULL;
> +
> + if (!wt->note_valid) {
> + struct strbuf path = STRBUF_INIT;
> +
> + strbuf_addstr(&path, worktree_git_path(wt, "note"));
> + if (file_exists(path.buf)) {
> + struct strbuf note = STRBUF_INIT;
> + if (strbuf_read_file(&note, path.buf, 0) < 0)
> + die_errno(_("failed to read '%s'"), path.buf);
> + strbuf_trim_trailing_newline(&note);
> + wt->note = strbuf_detach(&note, NULL);
> + } else
> + wt->note = NULL;
> + wt->note_valid = 1;
> + strbuf_release(&path);
> + }
> +
> + return wt->note;
> +}
> +
> +int set_worktree_note(struct worktree *wt, const char *text)
> +{
> + char *path;
> + int ret = 0;
> +
> + if (is_main_worktree(wt))
> + return error(_("cannot set note on the main worktree"));
> +
> + path = repo_common_path(wt->repo, "worktrees/%s/note", wt->id);
> + if (!text || !*text) {
> + if (file_exists(path) && unlink(path))
> + ret = error_errno(_("failed to remove '%s'"), path);
> + } else {
> + write_file(path, "%s", text);
> + }
> +
> + /* invalidate cache so a follow-up worktree_note() re-reads */
> + FREE_AND_NULL(wt->note);
> + wt->note_valid = 0;
> +
> + free(path);
> + return ret;
> +}
> +
>   const char *worktree_prune_reason(struct worktree *wt, timestamp_t expire)
>   {
>    struct strbuf reason = STRBUF_INIT;
> diff --git a/worktree.h b/worktree.h
> index 1075409f9a..0fcdb8bd1b 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -13,12 +13,16 @@ struct worktree {
>    char *head_ref; /* NULL if HEAD is broken or detached */
>    char *lock_reason; /* private - use worktree_lock_reason */
>    char *prune_reason;     /* private - use worktree_prune_reason */
> + char *note; /* private - use worktree_note */
>    struct object_id head_oid;
> + timestamp_t created_at; /* private - use worktree_created_at; 0 if unknown */
>    int is_detached;
>    int is_bare;
>    int is_current; /* does `path` match `repo->worktree` */
>    int lock_reason_valid; /* private */
>    int prune_reason_valid; /* private */
> + int note_valid;        /* private */
> + int created_at_valid;  /* private */
>   };
> 
>   /*
> @@ -96,6 +100,25 @@ int is_main_worktree(const struct worktree *wt);
>    */
>   const char *worktree_lock_reason(struct worktree *wt);
> 
> +/*
> + * Return the worktree's recorded creation timestamp, or 0 if no timestamp
> + * was recorded (e.g. a worktree created before this metadata existed, or
> + * the main worktree which never carries the file).
> + */
> +timestamp_t worktree_created_at(struct worktree *wt);
> +
> +/*
> + * Return the user-supplied note/description for the given worktree, or NULL
> + * if none was set.
> + */
> +const char *worktree_note(struct worktree *wt);
> +
> +/*
> + * Write or replace the worktree's note. Pass NULL or "" to delete the note.
> + * Returns 0 on success, -1 on failure. Not valid for the main worktree.
> + */
> +int set_worktree_note(struct worktree *wt, const char *text);
> +
>   /*
>    * Return the reason string if the given worktree should be pruned, otherwise
>    * NULL if it should not be pruned. `expire` defines a grace period to prune
> --
> 

