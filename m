Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D2501FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 17:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753532AbcKRRqL (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 12:46:11 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:32917 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752857AbcKRRqK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 12:46:10 -0500
Received: by mail-pg0-f41.google.com with SMTP id 3so105220597pgd.0
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 09:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sLG8SaPzu1LTg8Ve68OlCq7NBkH6nxDK4kYG75XDDRs=;
        b=O8CUedyVXaUOjf3Nd+DGHU90kxAsyd7DZn70QnMdbzn1bRDgzNYF6wstsxpf0j5dDs
         ZvAp3dftBYyD8Ft029w2QMIWqfrGQkcVngG4iwk+4FafcB8L6diupFKcbENvjlIyP7iA
         WQ/xjZgLWCymT+c3HG/rK4DAAdRFbkqTudOQC4TS263WCc1QsW7azFkXYsFW/tDzW3z0
         Gyc929uzEIo34MHPIhJVYS3ELhhv3AUTOSczxyz0+gMyulv7fCW32mcu1VnsS3g+NjLq
         2zymcWMlxt45np6OnM1+Elp0LlkpbMi+gtZ+MmbYgCEJNVXjPfGHdpf3mw5Dk/omC9p+
         f2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sLG8SaPzu1LTg8Ve68OlCq7NBkH6nxDK4kYG75XDDRs=;
        b=ZjfGgvEMXY/eYOSv0vIf0lAFILiOXNuAAGAJQvmEBDkgsUhOgY2hpxtwO1il/9jRb6
         bVkTHX+soIlkSgvySXYer7QPQivC09raR8408NHQkpR09BRFs6Mb95DCY6W1iGukZ2rW
         UQ56paD6t3SUCj0jtPDgkAiImKxniCKSeTwZ69nyf+aWx0oOD7uu7sac6H5DUJa5mtV0
         M1wS/GYhhfa2wJmWkns4/qcZ7SKhAK67ABFRT/lrFvzOCSEWqUKtLIHSbnvbFRFf4AwA
         FWZ9+b+2d9fT9YxzvHO0y7vAxkbaK+Bv0rZqKekunrZImuUc4GyEN1DMq99YYy3XWc9O
         Q9nA==
X-Gm-Message-State: AKaTC02yGXHpbOt0RezruRDVPrromdkB0QgZnAQvJd91sBMUmU+1ZMWPoNrkIHn63gig5iXa
X-Received: by 10.99.44.84 with SMTP id s81mr1739869pgs.153.1479491169237;
        Fri, 18 Nov 2016 09:46:09 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:dc40:d740:d9f4:37a3])
        by smtp.gmail.com with ESMTPSA id y134sm19428066pfg.81.2016.11.18.09.46.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 18 Nov 2016 09:46:08 -0800 (PST)
Date:   Fri, 18 Nov 2016 09:46:07 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin Fick <mogulguy10@gmail.com>,
        David Turner <David.Turner@twosigma.com>
Subject: Re: [PATCH 08/16] update submodules: add depopulate_submodule
Message-ID: <20161118174607.GP66382@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
 <20161115230651.23953-9-sbeller@google.com>
 <20161115234403.GE66382@google.com>
 <CAGZ79kbCqLsRzrsX29uM7pobs_11UZtFOQWP9RO8ptS5PyDfmw@mail.gmail.com>
 <20161117222926.GN66382@google.com>
 <CAGZ79ka0-JFvogHRoTA4ioMK86zD=zkgEfBb-gpU8tbOjwEoFA@mail.gmail.com>
 <CAGZ79kYE1JooyKMDsEM5=6OWxbCOL3q2=Et3nL7mMcayxtLZxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYE1JooyKMDsEM5=6OWxbCOL3q2=Et3nL7mMcayxtLZxA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17, Stefan Beller wrote:
> On Thu, Nov 17, 2016 at 2:42 PM, Stefan Beller <sbeller@google.com> wrote:
> >
> > I think I'll just write this functionality in C and optionally expose
> > it via the submodule--helper,
> > such that the user facing git-submodule.sh only has to call that helper.
> 
> I think it will roughly look like this:
> (white space mangled)
> 
> 
> commit e72ef244c667920c874247aa32aa55845500aac8
> Author: Stefan Beller <sbeller@google.com>
> Date:   Thu Nov 17 16:14:46 2016 -0800
> 
>     submodule--helper: add intern-git-dir function
> 
>     When a submodule has its git dir inside the working dir, the submodule
>     support for checkout that we plan to add in a later patch will fail.
> 
>     Add functionality to migrate the git directory to be embedded
>     into the superprojects git directory.
> 
>     Signed-off-by: Stefan Beller <sbeller@google.com>
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 4beeda5..4f31100 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1076,6 +1076,21 @@ static int resolve_remote_submodule_branch(int
> argc, const char **argv,
>         return 0;
>  }
> 
> +static int intern_git_dir(int argc, const char **argv, const char *prefix)
> +{
> +       int i;
> +       struct pathspec pathspec;
> +       struct module_list list = MODULE_LIST_INIT;
> +
> +       if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
> +               return 1;
> +
> +       for (i = 0; i < list.nr; i++)
> +               migrate_submodule_gitdir(list.entries[i]->name);
> +
> +       return 0;
> +}
> +
>  struct cmd_struct {
>         const char *cmd;
>         int (*fn)(int, const char **, const char *);
> @@ -1090,7 +1105,8 @@ static struct cmd_struct commands[] = {
>         {"resolve-relative-url", resolve_relative_url},
>         {"resolve-relative-url-test", resolve_relative_url_test},
>         {"init", module_init},
> -       {"remote-branch", resolve_remote_submodule_branch}
> +       {"remote-branch", resolve_remote_submodule_branch},
> +       {"intern-git-dir", intern_git_dir}
>  };
> 
>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
> diff --git a/submodule.c b/submodule.c
> index 45b9060..e513bba 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1335,3 +1335,42 @@ void prepare_submodule_repo_env(struct argv_array *out)
>         }
>         argv_array_push(out, "GIT_DIR=.git");
>  }
> +
> +/*
> + * Migrate the given submodule (and all its submodules recursively) from
> + * having its git directory within the working tree to the git dir nested
> + * in its superprojects git dir under modules/.
> + */
> +void migrate_submodule_gitdir(const char *path)
> +{
> +       char *old_git_dir;
> +       const char *new_git_dir;
> +       const struct submodule *sub;
> +
> +       struct child_process cp = CHILD_PROCESS_INIT;
> +       cp.git_cmd = 1;
> +       cp.no_stdin = 1;
> +       cp.dir = path;
> +       argv_array_pushl(&cp.args, "submodule", "foreach", "--recursive",
> +                       "git", "submodule--helper" "intern-git-dir", NULL);
> +
> +       if (run_command(&cp))
> +               die(_("Could not migrate git directory in submodule '%s'"),
> +                   path);
> +
> +       old_git_dir = xstrfmt("%s/.git", path);
> +       if (read_gitfile(old_git_dir))
> +               /* If it is an actual gitfile, it doesn't need migration. */
> +               goto out;
> +
> +       sub = submodule_from_path(null_sha1, path);

This should probably be checked to see if sub not NULL before
dereferencing it right?

> +       new_git_dir = git_common_path("modules/%s", sub->name);
> +
> +       if (rename(old_git_dir, new_git_dir) < 0)
> +               die_errno(_("Could not migrate git directory from %s to %s"),
> +                       old_git_dir, new_git_dir);
> +
> +       connect_work_tree_and_git_dir(path, new_git_dir);
> +out:
> +       free(old_git_dir);
> +}
> diff --git a/submodule.h b/submodule.h
> index aac202c..143ec18 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -90,5 +90,6 @@ extern int parallel_submodules(void);
>   * retaining any config in the environment.
>   */
>  extern void prepare_submodule_repo_env(struct argv_array *out);
> +extern void migrate_submodule_gitdir(const char *path);
> 
>  #endif

-- 
Brandon Williams
