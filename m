Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EB5D20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 22:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbdLEW2W (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 17:28:22 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:33762 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbdLEW2P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 17:28:15 -0500
Received: by mail-qt0-f182.google.com with SMTP id e2so4691332qti.0
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 14:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AOCfY6Afq8n25iDC7CYhOO8/vnoM4XfB2wESsC6IMPc=;
        b=EJY2taRgPPsn1N9DGyWkVGzLJlM3CpCXGA66HyQl82uuQ3q3z6iI99Be7eys3TQTXw
         SpDQHxrwuvVAnIMEvjy21QpmWuUD2OF/7DSg39SJ87gqxrv3JXyoFMqj3NxuFC8H5//F
         6Tsor+xRoY1cKB8knabo92kzrm98lJ3xkGKJeHgB2vgRfLcBd8w99/QVOs/xOK63VNg3
         9ZnV0WKeGtE35Y8WoxA6BYdWwpzUQ6/g+mD7LcF7hERKfueu6VeNHm335KjikH4lCjzX
         D3tDZm+7DQ/IXFdMpiu7WXV2trgrvIJzo1gqCDneylItXoGAYUtNlTyyhQY5B7o++IZ2
         xocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AOCfY6Afq8n25iDC7CYhOO8/vnoM4XfB2wESsC6IMPc=;
        b=UcG0Zis0umTvfav2sJzXJkrQtNvx/7z3I5URTPTSsZYIonLP3GrRvY1LmHbmX8FoYa
         jeaGi50qunqMFWtwu3HIkLROqvyq3ryCGpT7TOxi2eC0wn/FuXp8pafSLfCzozXK0n9E
         8BmK+7J1BFK4VEPmfli4/oLhVM+KYItX0SC3nOMJq3A/GTOAzZHaQB9wEp4PBftoObks
         a5HAIoW8AbX4yDArVbcsEJxnKKPJn+agIrPrxGJ7Fs4scAf9G4bPfvocJs8laLd+I8qs
         Gps4Kutp51F60j0Ab6eHy3ZIGFoFl51npz8UxrsEqTOT1Bcs+qevCTjolrfTljo2pz+P
         cZnw==
X-Gm-Message-State: AKGB3mJ8r1MAnOIPezjvjaFQLm8fmnj/TSrUWA3ZFw8AHu7XRwPUjJnt
        w3rCUq1FB14t3X7rtR/l3SXPH0eSS2OU4rpjheYv4Oo6Wkw=
X-Google-Smtp-Source: AGs4zMbH3i2d3eC49XPU/aeQeBmPlEanVU1MtjGJEAhe6H7cJ9DM3wso29OErcI+VyYxH/oUlzXJ2PqVVFREqqsugRA=
X-Received: by 10.55.76.193 with SMTP id z184mr24367635qka.346.1512512894338;
 Tue, 05 Dec 2017 14:28:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 5 Dec 2017 14:28:13 -0800 (PST)
In-Reply-To: <bba84ff0be9c2cbd87bff77a481a74698d90062f.1512168087.git.jonathantanmy@google.com>
References: <cover.1512168087.git.jonathantanmy@google.com> <bba84ff0be9c2cbd87bff77a481a74698d90062f.1512168087.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 5 Dec 2017 14:28:13 -0800
Message-ID: <CAGZ79kZv-P55acwkXZUfDXPAmwng2yD17awNkZ85RbaJ2O0ppw@mail.gmail.com>
Subject: Re: [WIP 2/2] submodule: read-only super-backed ref backend
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 1, 2017 at 2:50 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Note that a few major parts are still missing:
>  - special handling of the current branch of the superproject
>  - writing (whether "refs/..." to the superproject as an index change or
>    a commit, or non-"refs/..." directly to the subproject like usual)
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>


> --- a/refs.c
> +++ b/refs.c
> @@ -1575,12 +1575,17 @@ static struct ref_store *lookup_ref_store_map(struct hashmap *map,
>  static struct ref_store *ref_store_init(const char *gitdir,
>                                         unsigned int flags)
>  {
> -       const char *be_name = "files";
> -       struct ref_storage_be *be = find_ref_storage_backend(be_name);
> +       struct ref_storage_be *be;
>         struct ref_store *refs;
>
> +       if (getenv("USE_SP")) {
> +               be = &refs_be_sp;
> +       } else {
> +               be = &refs_be_files;
> +       }
> +
>         if (!be)
> -               die("BUG: reference backend %s is unknown", be_name);
> +               die("BUG: reference backend %s is unknown", "files");

If we pursue this approach more than just RFC-ish we would probably not use
an environment variable but have some detection logic for the
different ref backends.

For example Shawns refstable[1] proposal uses the configuration
`extensions.refStorage == reftable`, which this proposal could reuse and
set to 'indexed_superproject' or 'commit_in_superproject', depending on the
write semantics that we'd need to disucss (or do we want to offer 2 different
superproject backends having these different semantics?)

More to the code here, we could still use `find_ref_storage_backend()`
depending on the env:

    const char *be_name = "files";
    ...
+    if (getenv("USE_SP"))
+        be_name = "sp-backend";
    ...

and then we'd have to change the 'next ' pointer in refs_be_files
(in refs/files-backend.c line ~3100) to point at the superproject backend
instead of NULL.

[1] https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md#Repository-format

> +static int sp_read_raw_ref(struct ref_store *ref_store,
> +                             const char *refname, struct object_id *oid,
> +                             struct strbuf *referent, unsigned int *type)
> +{
> +       struct sp_ref_store *refs;
> +
> +       refs = sp_downcast(ref_store, REF_STORE_READ, "read_raw_ref");
> +
> +       if (!starts_with(refname, "refs/")) {
> +               return refs_read_raw_ref(refs->files, refname, oid, referent, type);
> +       }
> +
> +       /* read from the superproject instead */
> +       return get_superproject_gitlink_oid(refname, oid);
> +}

This function would need to get more sophisticated logic I would assume;
the current RFC is a read-only thing, such that it may be sufficient
to differentiate
between refs/* and specials such as [FETCH_]HEAD, but as seen in the
sp_ref_store struct definition we're already keeping a local reflog. I would
assume that remotes are also local to the submodule instead of reusing the
superprojects remote, for the sake of pulling in upstream changes of the
submodule instead of being fully integrated.



> diff --git a/submodule.c b/submodule.c
> index ce511180e..1ffaeec82 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -471,6 +471,7 @@ static void prepare_submodule_repo_env_no_git_dir(struct argv_array *out)
>  void prepare_submodule_repo_env(struct argv_array *out)
>  {
>         prepare_submodule_repo_env_no_git_dir(out);
> +       argv_array_pushf(out, "USE_SP");
>         argv_array_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
>                          DEFAULT_GIT_DIR_ENVIRONMENT);
>  }

This is an easy way to enforce all submodules use the superproject refs mode,
which makes it easy to make recursive commands (e.g. `git checkout --recursive`
would not need to pass down the exact gitlink sha1, but could pass
down the branch
name or even commit-ish "HEAD^^" and the submodule stays in perfect
sync (according
to superproject commit-ish). Once we take this further I would imagine
there is an option
in the submodule that specifies what mode it is using. Not sure if
we'd want to keep the
environment variable to force that mode from the superproject, though.

> @@ -1986,7 +1987,7 @@ void absorb_git_dir_into_superproject(const char *prefix,
>   * Return 0 if successful, 1 if not (for example, if the parent
>   * directory is not a repo or an unrelated one).
>   */
> -int get_superproject_entry(const char **full_name)
> +static int get_superproject_entry(const char *ref, const char **full_name, struct object_id *oid)

Making it static could be part of the prior patch?

When the ref is given we use `ls-tree -r` instead of `ls-files --stage`
which give similar outputs to have the parsing logic overlap below,
the difference
is whether the index is looked up or the given ref.

> @@ -2016,9 +2017,11 @@ int get_superproject_entry(const char **full_name)
>         prepare_submodule_repo_env(&cp.env_array);
>         argv_array_pop(&cp.env_array);
>
> -       argv_array_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
> -                       "ls-files", "-z", "--stage", "--full-name", "--",
> -                       subpath, NULL);
> +       argv_array_pushl(&cp.args, "--literal-pathspecs", "-C", "..", NULL);
> +       if (ref)
> +               argv_array_pushl(&cp.args, "ls-tree", "-z", "--full-name", "-r", ref, subpath, NULL);

-- between ref and path?

> @@ -2063,7 +2077,7 @@ const char *get_superproject_working_tree(void)
>         size_t len;
>         const char *ret;
>
> -       if (get_superproject_entry(&full_name))
> +       if (get_superproject_entry(NULL, &full_name, NULL))
>                 return NULL;
>
>         super_wt = xstrdup(xgetcwd());
> @@ -2075,6 +2089,13 @@ const char *get_superproject_working_tree(void)
>         return ret;
>  }
>
> +int get_superproject_gitlink_oid(const char *ref, struct object_id *oid)
> +{
> +       if (get_superproject_entry(ref, NULL, oid))

I see; the get_superproject_entry function is more powerful, than what
I proposed
in the status series. It takes vastly different arguments, for
inspection, so the caller
is responsible instead of having dumber callers and two different functions

>
> +test_expect_success 'ref backend based on superproject data' '
> +       rm -rf sub super &&
> +
> +       git init sub &&
> +       test_commit -C sub first &&
> +       test_commit -C sub second &&
> +
> +       git init super &&
> +
> +       # master branch in superproject, submodule at second
> +       git -C super submodule add ../sub sub &&
> +       git -C super commit -m x &&
> +
> +       # anotherbranch in superproject, submodule at first
> +       git -C super checkout -b anotherbranch &&
> +       git -C super/sub checkout first &&
> +       git -C super commit -a -m x &&
> +
> +       # Notice that rev-parse can parse "anotherbranch" and see that it
> +       # points to first, even though a branch with the name "anotherbranch"
> +       # is only defined in the superproject
> +       git -C sub rev-parse first >expect &&
> +       USE_SP=1 git -C super/sub rev-parse anotherbranch >actual &&
> +       test_cmp expect actual
> +'

Thanks for writing this proof of concept.
As Jonathan Nieder mentioned another similar direction of this idea could be
used to decorate the branches in the submodule to indicate where the
superproject
points to.

I think we'd need to hash out the details of the write operations,
before going further here,
but this is the best long term solution so far IMHO. (Short term we
might carry local
patches that make submodules more repo like).

Thanks,
Stefan
