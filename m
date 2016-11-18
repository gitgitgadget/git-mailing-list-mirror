Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA9AC1FF40
	for <e@80x24.org>; Fri, 18 Nov 2016 00:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753170AbcKRAQi (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 19:16:38 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33391 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752087AbcKRAQh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 19:16:37 -0500
Received: by mail-qk0-f170.google.com with SMTP id x190so243573780qkb.0
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 16:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TSWpA/T1oy8Z7p5uLDf/2rhsxCXcEXbvHkQ5qnaT6dQ=;
        b=mzALwyVi0hspRQ+SZTjQP8QtZ5Mdzl/mMJafcJOmokcNg4u51Q9PxQdAFTgrAhlp4E
         84PlORb82GTNCqtHWiA3zje30Y1VexXA0530Pk8xZdiVZuummG96YgRkZg6q+LcwsBEq
         yRU2puoBo6gjhbyUn6tJGrRknCe+8f7pKPGQc18PQQLWVJCHoNWWFoNmFKgViyOZMaP9
         cTT6pfvKvrEIlAUPbam7q4xsJ4qeJY63mJj/ltdRJAaPoxomD41BixrXs0npJFMq0/dp
         zvK5zzFr5fTDoisM2S3mwWqR0xQcT5QaouKJXAn8eZ+DyyUF6WjFuoNPHXqEpJ114nHG
         Hn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TSWpA/T1oy8Z7p5uLDf/2rhsxCXcEXbvHkQ5qnaT6dQ=;
        b=ZfSTyHzm5Q0aIJfM0eLx5axQqqj/xFoAINq2iaq/0cZKrueJS8Y9eu29GOjpPZgabC
         EbzgxlOBSDDTdbaKqrhpuKVHi5ibEsB1NtZfLJSn+BQn6/BpwlopLmY2Vfjro5tAEJCF
         8tFR2MNo0tdJz9hRc+1E1++4mGTyD719e7OOtK7pGwz+bqUjg1qhEtVpis7yIdzz+sDV
         aR7wZEEhYm8FZMjslrnZEoqyaUgXV9jr5rQXGTtngtYjsMCRAwLuUWZYqgGX0lLAF39I
         AEIDC6nzjPLj31xBItieB+kxd80KWtJr3EGCrOvvJsYN0Lcar+VUKR2NzChSZgoY8mEz
         5UCg==
X-Gm-Message-State: AKaTC03vjCI1f8j4t3bsiL3WaAAvUhEtRefthNR+K5t9sJbOdwTopCUUbwpL+54lrSUKjnqaYfodTdyBXMdnyxsY
X-Received: by 10.55.16.147 with SMTP id 19mr7018825qkq.255.1479428196542;
 Thu, 17 Nov 2016 16:16:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Thu, 17 Nov 2016 16:16:36 -0800 (PST)
In-Reply-To: <CAGZ79ka0-JFvogHRoTA4ioMK86zD=zkgEfBb-gpU8tbOjwEoFA@mail.gmail.com>
References: <20161115230651.23953-1-sbeller@google.com> <20161115230651.23953-9-sbeller@google.com>
 <20161115234403.GE66382@google.com> <CAGZ79kbCqLsRzrsX29uM7pobs_11UZtFOQWP9RO8ptS5PyDfmw@mail.gmail.com>
 <20161117222926.GN66382@google.com> <CAGZ79ka0-JFvogHRoTA4ioMK86zD=zkgEfBb-gpU8tbOjwEoFA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Nov 2016 16:16:36 -0800
Message-ID: <CAGZ79kYE1JooyKMDsEM5=6OWxbCOL3q2=Et3nL7mMcayxtLZxA@mail.gmail.com>
Subject: Re: [PATCH 08/16] update submodules: add depopulate_submodule
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin Fick <mogulguy10@gmail.com>,
        David Turner <David.Turner@twosigma.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2016 at 2:42 PM, Stefan Beller <sbeller@google.com> wrote:
>
> I think I'll just write this functionality in C and optionally expose
> it via the submodule--helper,
> such that the user facing git-submodule.sh only has to call that helper.

I think it will roughly look like this:
(white space mangled)


commit e72ef244c667920c874247aa32aa55845500aac8
Author: Stefan Beller <sbeller@google.com>
Date:   Thu Nov 17 16:14:46 2016 -0800

    submodule--helper: add intern-git-dir function

    When a submodule has its git dir inside the working dir, the submodule
    support for checkout that we plan to add in a later patch will fail.

    Add functionality to migrate the git directory to be embedded
    into the superprojects git directory.

    Signed-off-by: Stefan Beller <sbeller@google.com>

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4beeda5..4f31100 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1076,6 +1076,21 @@ static int resolve_remote_submodule_branch(int
argc, const char **argv,
        return 0;
 }

+static int intern_git_dir(int argc, const char **argv, const char *prefix)
+{
+       int i;
+       struct pathspec pathspec;
+       struct module_list list = MODULE_LIST_INIT;
+
+       if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+               return 1;
+
+       for (i = 0; i < list.nr; i++)
+               migrate_submodule_gitdir(list.entries[i]->name);
+
+       return 0;
+}
+
 struct cmd_struct {
        const char *cmd;
        int (*fn)(int, const char **, const char *);
@@ -1090,7 +1105,8 @@ static struct cmd_struct commands[] = {
        {"resolve-relative-url", resolve_relative_url},
        {"resolve-relative-url-test", resolve_relative_url_test},
        {"init", module_init},
-       {"remote-branch", resolve_remote_submodule_branch}
+       {"remote-branch", resolve_remote_submodule_branch},
+       {"intern-git-dir", intern_git_dir}
 };

 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/submodule.c b/submodule.c
index 45b9060..e513bba 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1335,3 +1335,42 @@ void prepare_submodule_repo_env(struct argv_array *out)
        }
        argv_array_push(out, "GIT_DIR=.git");
 }
+
+/*
+ * Migrate the given submodule (and all its submodules recursively) from
+ * having its git directory within the working tree to the git dir nested
+ * in its superprojects git dir under modules/.
+ */
+void migrate_submodule_gitdir(const char *path)
+{
+       char *old_git_dir;
+       const char *new_git_dir;
+       const struct submodule *sub;
+
+       struct child_process cp = CHILD_PROCESS_INIT;
+       cp.git_cmd = 1;
+       cp.no_stdin = 1;
+       cp.dir = path;
+       argv_array_pushl(&cp.args, "submodule", "foreach", "--recursive",
+                       "git", "submodule--helper" "intern-git-dir", NULL);
+
+       if (run_command(&cp))
+               die(_("Could not migrate git directory in submodule '%s'"),
+                   path);
+
+       old_git_dir = xstrfmt("%s/.git", path);
+       if (read_gitfile(old_git_dir))
+               /* If it is an actual gitfile, it doesn't need migration. */
+               goto out;
+
+       sub = submodule_from_path(null_sha1, path);
+       new_git_dir = git_common_path("modules/%s", sub->name);
+
+       if (rename(old_git_dir, new_git_dir) < 0)
+               die_errno(_("Could not migrate git directory from %s to %s"),
+                       old_git_dir, new_git_dir);
+
+       connect_work_tree_and_git_dir(path, new_git_dir);
+out:
+       free(old_git_dir);
+}
diff --git a/submodule.h b/submodule.h
index aac202c..143ec18 100644
--- a/submodule.h
+++ b/submodule.h
@@ -90,5 +90,6 @@ extern int parallel_submodules(void);
  * retaining any config in the environment.
  */
 extern void prepare_submodule_repo_env(struct argv_array *out);
+extern void migrate_submodule_gitdir(const char *path);

 #endif
