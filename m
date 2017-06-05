Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88A091F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 20:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbdFEUwj (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 16:52:39 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35741 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdFEUwi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 16:52:38 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so10786947pgc.2
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 13:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=hp7tNtOWDNP7dwxnmpAcDp/hNcM7HRF14O21S6ZIzKo=;
        b=F6Wt+t+tY6yW+hOzyqEfQnPTQIyZ2LCA6rkV95zemtYb6nQzXCBDOl8immyzNim/S8
         me12w+V2FzXeProtKSHoLkSP2KpSAGi+dfbHeN1cWmNyO+3hCMUa4kLt2HAd94/M1xAI
         Lt1UNBi2Kl0hfBBkGrrxtFZpa1KZ677RRoApQ2Jtz81tAhFHfnM0Tr5ldiO2q0leC2cR
         BVKWFj8pE48Z5Wzxnlm4ACd28dyNt4jslHWJ9NpPCQpxfA/UX8MCQLBMAGqnsgdUqUjz
         H+fv7Z6eVv2L2BYsi/okC5nA+LCTzsgMYE5ZdzpN1vTEYUyoA8pfucDarBz8mlgKTFYp
         wSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=hp7tNtOWDNP7dwxnmpAcDp/hNcM7HRF14O21S6ZIzKo=;
        b=NPJT5F8f2amR+j7AF7hrO9N7UyWkWtJ7/qMG7N2QoI8pvi+7lk0A6VlGHCFLYW8Td6
         H4Zn18F/fOFqBJFUg2V/7Mx17KGMk3q79gLHWiKvcjcFhFlN9iSwQpVm8DLoE76sk9Mp
         CFSPq+YCB+OVZsW9x6oWcq9JN1kXSE0Mngwjp5E2AsANckOS19uToYj2zqWyj0y4WJgL
         nU/fK4JcaT/ZI6r9i3Vw3ztTnTKqn1W6O28rPsFbv4hrachbwB4ndGrFmNm0adQYOYeJ
         Q+Dx6QiFpZbA1sDHmqY0y+7ND5PYbZ0wX8LJmC8RZL5jl2VJAEV2zJIGxI/Wge9Yi5ZJ
         oOCw==
X-Gm-Message-State: AODbwcAs+f15Bq7dxpz/vc34D8ApyGEIV1DMmBx08hUDbjsiMnzPW/Wv
        oZUTeWkb1waar8rb8u5SFbS6wky5Ow==
X-Received: by 10.99.186.91 with SMTP id l27mr18864999pgu.87.1496695956831;
 Mon, 05 Jun 2017 13:52:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.151.14 with HTTP; Mon, 5 Jun 2017 13:52:16 -0700 (PDT)
In-Reply-To: <0102015c79fcbe99-7e18cee7-d82d-4ab2-9d6a-ad7376a5ac27-000000@eu-west-1.amazonses.com>
References: <0102015c79fcbda0-2779b4ff-54ad-46f4-bef0-14eeb58338d4-000000@eu-west-1.amazonses.com>
 <0102015c79fcbe99-7e18cee7-d82d-4ab2-9d6a-ad7376a5ac27-000000@eu-west-1.amazonses.com>
From:   Sahil Dua <sahildua2305@gmail.com>
Date:   Mon, 5 Jun 2017 22:52:16 +0200
Message-ID: <CALiud+=qoSSSg_p2MXZEaVTGMhFW_FtirDJ2-FnmNh+U0yf0Gw@mail.gmail.com>
Subject: Re: [PATCH/RFC v4 3/3] branch: add copy branch feature implementation
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I want suggestions about one logical point raised by Evar.

Let's consider a case that I'm on branch maint and then I do 'git
checkout master' followed by 'git branch -m feature', it will rename
master branch to feature. Now if I do 'git checkout -' to go to the
last branch, it will take me to maint since master branch doesn't
exist in this case.

Now, for this copy operation - if I'm on branch maint and then I do
'git checkout master' followed by 'git branch -c feature', it will
copy master branch to feature. Now if I do 'git checkout -' to go to
the last branch, it will again go to maint (according to the current
implementation). What do you think it should do? Is this the desired
behavior? Or should it go to master branch since that was the branch
checked out before copying.

Also, in case this needs to be changed, can someone please point me to
how it's being handled so that I can change the behavior.

On Mon, Jun 5, 2017 at 10:40 PM, Sahil Dua <sahildua2305@gmail.com> wrote:
> Adds copy branch option available using -c or -C (forcefully).
>
> Adds new function copy_existing_ref to copy the ref and
> git_config_copy_section to copy the git config section. Under the hood,
> both git_config_copy_section and git_config_rename_section functions use
> the same function which takes a flag copy? to decide whether it should
> copy or move the config section.
>
> Similarly for copy_existing_ref - rename_ref and copy_existing_ref use
> same function which takes the copy? flag and work in the same way as
> mentioned above.
>
> The new function is named copy_existing_ref instead of copy_ref because
> of conflicts with another function copy_ref from remote.h.
>
> The new copied branch logs start with a line mentioning the copy
> operation.
>
> git config copy section logic:
> While we're parsing the config file, we need to make sure we start
> copying the config section once we find the matching block for our
> branch1 (for example when running 'git branch -c branch1 branch2').
>
> There is one flag used - 'copying_section' which can take 0/1/2 values.
> 0 - not copying currently
> 1 - just started copying section
> 2 - currently copying
> I thought of making this flag binary to keep things easier. However,
> since there was distinction in behavior(adding to currently copied
> section) depending upon whether it's the first line of config section or
> not.
>
> The copied section has first line which contains the new branch name
> (branch2 in our example). This is achieved using store_create_section
> method.
>
> Once we're done with reading the entire config file, we write our copied
> section. Hence, literally copying the config section from branch1 to
> branch2.
>
> However, there's one case which is not handled by this yet - when
> branch2 already has some configuration and -C command is used, operation
> should delete the present configuration for branch2.
>
> Also, it doesn't make sense to trigger config section copy config
> section function if both the branch names are same.
>
> For example - git branch -C a a
> In such a case, it shouldn't try to copy or rename the git config
> section.
>
> fixups by avar:
>
> -   fixup: use git comment style, and not C++ comments...
> -   fixup bad i18n usage
>     This interpolation of English words with sprintf resulted in
>     untranslatable strings.
> -   fixup mixed code/decl warning
>
> Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
> ---
>  builtin/branch.c     | 66 ++++++++++++++++++++++++++++----------
>  cache.h              |  2 ++
>  config.c             | 89 +++++++++++++++++++++++++++++++++++++++++-----------
>  refs.c               | 11 +++++++
>  refs.h               |  9 +++++-
>  refs/files-backend.c | 46 ++++++++++++++++++++++-----
>  refs/refs-internal.h |  4 +++
>  7 files changed, 184 insertions(+), 43 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 83fcda43dceec..8ae87b1d6e68e 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -27,6 +27,7 @@ static const char * const builtin_branch_usage[] = {
>         N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
>         N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
>         N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
> +       N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
>         N_("git branch [<options>] [-r | -a] [--points-at]"),
>         N_("git branch [<options>] [-r | -a] [--format]"),
>         NULL
> @@ -449,15 +450,19 @@ static void reject_rebase_or_bisect_branch(const char *target)
>         free_worktrees(worktrees);
>  }
>
> -static void rename_branch(const char *oldname, const char *newname, int force)
> +static void copy_or_rename_branch(const char *oldname, const char *newname, int copy, int force)
>  {
>         struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
>         struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
>         int recovery = 0;
>         int clobber_head_ok;
>
> -       if (!oldname)
> -               die(_("cannot rename the current branch while not on any."));
> +       if (!oldname) {
> +               if (copy)
> +                       die(_("cannot copy the current branch while not on any."));
> +               else
> +                       die(_("cannot rename the current branch while not on any."));
> +       }
>
>         if (strbuf_check_branch_ref(&oldref, oldname)) {
>                 /*
> @@ -480,17 +485,33 @@ static void rename_branch(const char *oldname, const char *newname, int force)
>
>         reject_rebase_or_bisect_branch(oldref.buf);
>
> -       strbuf_addf(&logmsg, "Branch: renamed %s to %s",
> -                oldref.buf, newref.buf);
> +       if (copy)
> +               strbuf_addf(&logmsg, "Branch: copied %s to %s",
> +                           oldref.buf, newref.buf);
> +       else
> +               strbuf_addf(&logmsg, "Branch: renamed %s to %s",
> +                           oldref.buf, newref.buf);
>
> -       if (rename_ref(oldref.buf, newref.buf, logmsg.buf))
> +       if (!copy && rename_ref(oldref.buf, newref.buf, logmsg.buf))
>                 die(_("Branch rename failed"));
> +       if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
> +               die(_("Branch copy failed"));
>
> -       if (recovery)
> -               warning(_("Renamed a misnamed branch '%s' away"), oldref.buf + 11);
> +       if (recovery) {
> +               if (copy)
> +                       warning(_("Copied a misnamed branch '%s' away"),
> +                               oldref.buf + 11);
> +               else
> +                       warning(_("Renamed a misnamed branch '%s' away"),
> +                               oldref.buf + 11);
> +       }
>
> -       if (replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
> -               die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
> +       if (replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf)) {
> +               if (copy)
> +                       die(_("Branch copied to %s, but HEAD is not updated!"), newname);
> +               else
> +                       die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
> +       }
>
>         strbuf_release(&logmsg);
>
> @@ -498,8 +519,10 @@ static void rename_branch(const char *oldname, const char *newname, int force)
>         strbuf_release(&oldref);
>         strbuf_addf(&newsection, "branch.%s", newref.buf + 11);
>         strbuf_release(&newref);
> -       if (git_config_rename_section(oldsection.buf, newsection.buf) < 0)
> +       if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
>                 die(_("Branch is renamed, but update of config-file failed"));
> +       if (copy && strcmp(oldname, newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
> +               die(_("Branch is copied, but update of config-file failed"));
>         strbuf_release(&oldsection);
>         strbuf_release(&newsection);
>  }
> @@ -537,7 +560,7 @@ static int edit_branch_description(const char *branch_name)
>
>  int cmd_branch(int argc, const char **argv, const char *prefix)
>  {
> -       int delete = 0, rename = 0, force = 0, list = 0;
> +       int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
>         int reflog = 0, edit_description = 0;
>         int quiet = 0, unset_upstream = 0;
>         const char *new_upstream = NULL;
> @@ -574,6 +597,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>                 OPT_BIT('D', NULL, &delete, N_("delete branch (even if not merged)"), 2),
>                 OPT_BIT('m', "move", &rename, N_("move/rename a branch and its reflog"), 1),
>                 OPT_BIT('M', NULL, &rename, N_("move/rename a branch, even if target exists"), 2),
> +               OPT_BIT('c', NULL, &copy, N_("copy a branch and its reflog"), 1),
> +               OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists"), 2),
>                 OPT_BOOL(0, "list", &list, N_("list branch names")),
>                 OPT_BOOL('l', "create-reflog", &reflog, N_("create the branch's reflog")),
>                 OPT_BOOL(0, "edit-description", &edit_description,
> @@ -617,14 +642,14 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>         argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
>                              0);
>
> -       if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
> +       if (!delete && !rename && !copy && !edit_description && !new_upstream && !unset_upstream && argc == 0)
>                 list = 1;
>
>         if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr ||
>             filter.no_commit)
>                 list = 1;
>
> -       if (!!delete + !!rename + !!new_upstream +
> +       if (!!delete + !!rename + !!copy + !!new_upstream +
>             list + unset_upstream > 1)
>                 usage_with_options(builtin_branch_usage, options);
>
> @@ -696,13 +721,22 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>
>                 if (edit_branch_description(branch_name))
>                         return 1;
> +       } else if (copy) {
> +               if (!argc)
> +                       die(_("branch name required"));
> +               else if (argc == 1)
> +                       copy_or_rename_branch(head, argv[0], 1, copy > 1);
> +               else if (argc == 2)
> +                       copy_or_rename_branch(argv[0], argv[1], 1, copy > 1);
> +               else
> +                       die(_("too many branches for a copy operation"));
>         } else if (rename) {
>                 if (!argc)
>                         die(_("branch name required"));
>                 else if (argc == 1)
> -                       rename_branch(head, argv[0], rename > 1);
> +                       copy_or_rename_branch(head, argv[0], 0, rename > 1);
>                 else if (argc == 2)
> -                       rename_branch(argv[0], argv[1], rename > 1);
> +                       copy_or_rename_branch(argv[0], argv[1], 0, rename > 1);
>                 else
>                         die(_("too many branches for a rename operation"));
>         } else if (new_upstream) {
> diff --git a/cache.h b/cache.h
> index ae4c45d379d5b..109d91cb5248a 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1935,6 +1935,8 @@ extern int git_config_set_multivar_in_file_gently(const char *, const char *, co
>  extern void git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
>  extern int git_config_rename_section(const char *, const char *);
>  extern int git_config_rename_section_in_file(const char *, const char *, const char *);
> +extern int git_config_copy_section(const char *, const char *);
> +extern int git_config_copy_section_in_file(const char *, const char *, const char *);
>  extern const char *git_etc_gitconfig(void);
>  extern int git_env_bool(const char *, int);
>  extern unsigned long git_env_ulong(const char *, unsigned long);
> diff --git a/config.c b/config.c
> index 721aef1938081..53b154b2cfcb1 100644
> --- a/config.c
> +++ b/config.c
> @@ -2639,16 +2639,18 @@ static int section_name_is_ok(const char *name)
>  }
>
>  /* if new_name == NULL, the section is removed instead */
> -int git_config_rename_section_in_file(const char *config_filename,
> -                                     const char *old_name, const char *new_name)
> +static int git_config_copy_or_rename_section_in_file(const char *config_filename,
> +                                     const char *old_name, const char *new_name, int copy)
>  {
> -       int ret = 0, remove = 0;
> +       int ret = 0, remove = 0, copying_section = 0, copied_section_length;
>         char *filename_buf = NULL;
>         struct lock_file *lock;
>         int out_fd;
>         char buf[1024];
>         FILE *config_file = NULL;
>         struct stat st;
> +       struct strbuf copied_section = STRBUF_INIT;
> +       int offset;
>
>         if (new_name && !section_name_is_ok(new_name)) {
>                 ret = error("invalid section name: %s", new_name);
> @@ -2689,33 +2691,51 @@ int git_config_rename_section_in_file(const char *config_filename,
>                         ; /* do nothing */
>                 if (buf[i] == '[') {
>                         /* it's a section */
> -                       int offset = section_name_match(&buf[i], old_name);
> +                       if (copying_section) {
> +                               /*
> +                                * Mark the end of copying the matching
> +                                * section, as this is the beginning
> +                                * of the new section
> +                                */
> +                               copying_section = 0;
> +                       }
> +                       offset = section_name_match(&buf[i], old_name);
>                         if (offset > 0) {
>                                 ret++;
>                                 if (new_name == NULL) {
>                                         remove = 1;
>                                         continue;
>                                 }
> -                               store.baselen = strlen(new_name);
> -                               if (!store_write_section(out_fd, new_name)) {
> -                                       ret = write_error(get_lock_file_path(lock));
> -                                       goto out;
> +                               if (!copy) {
> +                                       store.baselen = strlen(new_name);
> +                                       if (!store_write_section(out_fd, new_name)) {
> +                                               ret = write_error(get_lock_file_path(lock));
> +                                               goto out;
> +                                       }
> +                               } else {
> +                                       /* Mark the beginning of copying the matching section */
> +                                       copying_section = 1;
> +                                       /* Create a section with new branch name */
> +                                       store.baselen = strlen(new_name);
> +                                       copied_section = store_create_section(new_name);
>                                 }
>                                 /*
>                                  * We wrote out the new section, with
>                                  * a newline, now skip the old
>                                  * section's length
>                                  */
> -                               output += offset + i;
> -                               if (strlen(output) > 0) {
> -                                       /*
> -                                        * More content means there's
> -                                        * a declaration to put on the
> -                                        * next line; indent with a
> -                                        * tab
> -                                        */
> -                                       output -= 1;
> -                                       output[0] = '\t';
> +                               if (!copy) {
> +                                       output += offset + i;
> +                                       if (strlen(output) > 0) {
> +                                               /*
> +                                                * More content means there's
> +                                                * a declaration to put on the
> +                                                * next line; indent with a
> +                                                * tab
> +                                                */
> +                                               output -= 1;
> +                                               output[0] = '\t';
> +                                       }
>                                 }
>                         }
>                         remove = 0;
> @@ -2723,11 +2743,25 @@ int git_config_rename_section_in_file(const char *config_filename,
>                 if (remove)
>                         continue;
>                 length = strlen(output);
> +
> +               if (copying_section > 1) {
> +                       strbuf_addf(&copied_section, "%s", output);
> +               } else if (copying_section == 1) {
> +                       copying_section = 2;
> +               }
>                 if (write_in_full(out_fd, output, length) != length) {
>                         ret = write_error(get_lock_file_path(lock));
>                         goto out;
>                 }
>         }
> +
> +       if (copy && copied_section.len > 0) {
> +               copied_section_length = strlen(copied_section.buf);
> +               if (write_in_full(out_fd, copied_section.buf, copied_section_length) != copied_section_length) {
> +                       ret = write_error(get_lock_file_path(lock));
> +                       goto out;
> +               }
> +       }
>         fclose(config_file);
>         config_file = NULL;
>  commit_and_out:
> @@ -2743,11 +2777,30 @@ int git_config_rename_section_in_file(const char *config_filename,
>         return ret;
>  }
>
> +int git_config_rename_section_in_file(const char *config_filename,
> +                                     const char *old_name, const char *new_name)
> +{
> +       return git_config_copy_or_rename_section_in_file(config_filename,
> +                                        old_name, new_name, 0);
> +}
> +
>  int git_config_rename_section(const char *old_name, const char *new_name)
>  {
>         return git_config_rename_section_in_file(NULL, old_name, new_name);
>  }
>
> +int git_config_copy_section_in_file(const char *config_filename,
> +                                     const char *old_name, const char *new_name)
> +{
> +       return git_config_copy_or_rename_section_in_file(config_filename,
> +                                        old_name, new_name, 1);
> +}
> +
> +int git_config_copy_section(const char *old_name, const char *new_name)
> +{
> +       return git_config_copy_section_in_file(NULL, old_name, new_name);
> +}
> +
>  /*
>   * Call this to report error for your variable that should not
>   * get a boolean value (i.e. "[my] var" means "true").
> diff --git a/refs.c b/refs.c
> index 8af9641aa17e6..42b1abef76b1a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1917,3 +1917,14 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
>  {
>         return refs_rename_ref(get_main_ref_store(), oldref, newref, logmsg);
>  }
> +
> +int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
> +                   const char *newref, const char *logmsg)
> +{
> +       return refs->be->copy_ref(refs, oldref, newref, logmsg);
> +}
> +
> +int copy_existing_ref(const char *oldref, const char *newref, const char *logmsg)
> +{
> +       return refs_copy_existing_ref(get_main_ref_store(), oldref, newref, logmsg);
> +}
> diff --git a/refs.h b/refs.h
> index 685a979a0eb70..df93d5a261b6c 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -396,7 +396,14 @@ char *shorten_unambiguous_ref(const char *refname, int strict);
>  /** rename ref, return 0 on success **/
>  int refs_rename_ref(struct ref_store *refs, const char *oldref,
>                     const char *newref, const char *logmsg);
> -int rename_ref(const char *oldref, const char *newref, const char *logmsg);
> +int rename_ref(const char *oldref, const char *newref,
> +                       const char *logmsg);
> +
> +/** copy ref, return 0 on success **/
> +int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
> +                   const char *newref, const char *logmsg);
> +int copy_existing_ref(const char *oldref, const char *newref,
> +                       const char *logmsg);
>
>  int refs_create_symref(struct ref_store *refs, const char *refname,
>                        const char *target, const char *logmsg);
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index cb1f528cbeec4..82d6692584c9c 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1703,9 +1703,9 @@ static int commit_ref_update(struct files_ref_store *refs,
>                              const struct object_id *oid, const char *logmsg,
>                              struct strbuf *err);
>
> -static int files_rename_ref(struct ref_store *ref_store,
> +static int files_copy_or_rename_ref(struct ref_store *ref_store,
>                             const char *oldrefname, const char *newrefname,
> -                           const char *logmsg)
> +                           const char *logmsg, int copy)
>  {
>         struct files_ref_store *refs =
>                 files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
> @@ -1737,8 +1737,12 @@ static int files_rename_ref(struct ref_store *ref_store,
>         }
>
>         if (flag & REF_ISSYMREF) {
> -               ret = error("refname %s is a symbolic ref, renaming it is not supported",
> -                           oldrefname);
> +               if (copy)
> +                       ret = error("refname %s is a symbolic ref, copying it is not supported",
> +                                   oldrefname);
> +               else
> +                       ret = error("refname %s is a symbolic ref, renaming it is not supported",
> +                                   oldrefname);
>                 goto out;
>         }
>         if (!refs_rename_ref_available(&refs->base, oldrefname, newrefname)) {
> @@ -1746,13 +1750,19 @@ static int files_rename_ref(struct ref_store *ref_store,
>                 goto out;
>         }
>
> -       if (log && rename(sb_oldref.buf, tmp_renamed_log.buf)) {
> +       if (!copy && log && rename(sb_oldref.buf, tmp_renamed_log.buf)) {
>                 ret = error("unable to move logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
>                             oldrefname, strerror(errno));
>                 goto out;
>         }
>
> -       if (refs_delete_ref(&refs->base, logmsg, oldrefname,
> +       if (copy && log && copy_file(tmp_renamed_log.buf, sb_oldref.buf, 0644)) {
> +               ret = error("unable to copy logfile logs/%s to logs/"TMP_RENAMED_LOG": %s",
> +                           oldrefname, strerror(errno));
> +               goto out;
> +       }
> +
> +       if (!copy && refs_delete_ref(&refs->base, logmsg, oldrefname,
>                             orig_oid.hash, REF_NODEREF)) {
>                 error("unable to delete old %s", oldrefname);
>                 goto rollback;
> @@ -1765,7 +1775,7 @@ static int files_rename_ref(struct ref_store *ref_store,
>          * the safety anyway; we want to delete the reference whatever
>          * its current value.
>          */
> -       if (!refs_read_ref_full(&refs->base, newrefname,
> +       if (!copy && !refs_read_ref_full(&refs->base, newrefname,
>                                 RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>                                 oid.hash, NULL) &&
>             refs_delete_ref(&refs->base, NULL, newrefname,
> @@ -1796,7 +1806,10 @@ static int files_rename_ref(struct ref_store *ref_store,
>         lock = lock_ref_sha1_basic(refs, newrefname, NULL, NULL, NULL,
>                                    REF_NODEREF, NULL, &err);
>         if (!lock) {
> -               error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
> +               if (copy)
> +                       error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, err.buf);
> +               else
> +                       error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
>                 strbuf_release(&err);
>                 goto rollback;
>         }
> @@ -1847,6 +1860,22 @@ static int files_rename_ref(struct ref_store *ref_store,
>         return ret;
>  }
>
> +static int files_rename_ref(struct ref_store *ref_store,
> +                           const char *oldrefname, const char *newrefname,
> +                           const char *logmsg)
> +{
> +       return files_copy_or_rename_ref(ref_store, oldrefname,
> +                                newrefname, logmsg, 0);
> +}
> +
> +static int files_copy_ref(struct ref_store *ref_store,
> +                           const char *oldrefname, const char *newrefname,
> +                           const char *logmsg)
> +{
> +       return files_copy_or_rename_ref(ref_store, oldrefname,
> +                                newrefname, logmsg, 1);
> +}
> +
>  static int close_ref(struct ref_lock *lock)
>  {
>         if (close_lock_file(lock->lk))
> @@ -3319,6 +3348,7 @@ struct ref_storage_be refs_be_files = {
>         files_create_symref,
>         files_delete_refs,
>         files_rename_ref,
> +       files_copy_ref,
>
>         files_ref_iterator_begin,
>         files_read_raw_ref,
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index b6b291cf00e5c..823a1c48af6ec 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -513,6 +513,9 @@ typedef int delete_refs_fn(struct ref_store *ref_store,
>  typedef int rename_ref_fn(struct ref_store *ref_store,
>                           const char *oldref, const char *newref,
>                           const char *logmsg);
> +typedef int copy_ref_fn(struct ref_store *ref_store,
> +                         const char *oldref, const char *newref,
> +                         const char *logmsg);
>
>  /*
>   * Iterate over the references in the specified ref_store that are
> @@ -607,6 +610,7 @@ struct ref_storage_be {
>         create_symref_fn *create_symref;
>         delete_refs_fn *delete_refs;
>         rename_ref_fn *rename_ref;
> +       copy_ref_fn *copy_ref;
>
>         ref_iterator_begin_fn *iterator_begin;
>         read_raw_ref_fn *read_raw_ref;
>
> --
> https://github.com/git/git/pull/363
