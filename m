Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2AD820288
	for <e@80x24.org>; Wed, 19 Jul 2017 14:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755086AbdGSOxS (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 10:53:18 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:34545 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755079AbdGSOxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 10:53:16 -0400
Received: by mail-qt0-f174.google.com with SMTP id 32so3979481qtv.1
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 07:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Atxd5c52K76Va2F03eKRCwxtoNDC97NDc++xzPEZJWw=;
        b=rgSexkE36dUSYi4PObZwqRUcykBDG9+/dr07xj16ENeZcQRhWRIUWAkxJ/0rjAuYWD
         prgqEUf4yAA2jRpL8/DAkWOToBgfbVDQvSh2i3YRlrsnXG9yTgF+V1jLpbEPMEtyMIba
         RwU+UMMsac9PwWRfpB4PTvZx6NCAHpBO6Qg0SEwSX7LpeVwaO66h1j+GhG2rPlGnvaNU
         9TRF1ZRvVpDeQKMupmrcbWW8fClfchd3Iq4MlGWmUKeUm1o7n45JPW8wANWxs+pQ2atO
         x/6nj8Mw6gjf0DkAoWjwfEP4DcLFpVHwHTbTZxZ0UtpCiRDH/kQV/6crG8OaxAENqCtF
         WjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Atxd5c52K76Va2F03eKRCwxtoNDC97NDc++xzPEZJWw=;
        b=ZpiG/pIXifs8QdSTgrnQB4leEMGGcV50yCY7Z+Q7iNCvQyGh7S8zJywvftOi7pVvGJ
         BNUxPTyP13enmqhzRFPSEEp8OFm4KsAOQwscTru6K9MFppkN8wT4xB0p1TWtMsVZMJO/
         m3BEJz8k6DSdMScxfp9Mhhz8GEG2SUaMtL2qvaN6r6YbUmYeAZQEEV0u6JxtJjWfU5uM
         AkcKx6gbJDkkaLLD4CjGWRc2bUOIKiyqaZWag3SpqggDlTjmHisTKhEZD/26o+aox3ii
         zazPK3USdCGWIkjINMz4HFW76t6oCCwAHn7NbvXxLk40HlqnHfwEjeV5PdMxlrwLmF+V
         jGVA==
X-Gm-Message-State: AIVw110NGHdSQ7743cjyZpHCzO5bk6CGFRMLP+Xq7sQcxYdkJYNi/TlK
        0qeIHJT6aQjx5ZoKD7jz/AzXEJb8ww==
X-Received: by 10.237.49.194 with SMTP id 60mr487983qth.73.1500475995949; Wed,
 19 Jul 2017 07:53:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Wed, 19 Jul 2017 07:53:15 -0700 (PDT)
In-Reply-To: <20170718204904.3768-9-pc44800@gmail.com>
References: <20170718204904.3768-1-pc44800@gmail.com> <20170718204904.3768-9-pc44800@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 19 Jul 2017 16:53:15 +0200
Message-ID: <CAP8UFD3ySECbyzCooSLetSk-qdnjj1kpvcjVMAO8oGmsFYsEMQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH 8/8] submodule: port submodule subcommand 'summary'
 from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 18, 2017 at 10:49 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:



> +static void print_submodule_summary(struct summary_cb *info,
> +                                   struct module_cb *p)
> +{
> +       int missing_src = 0;
> +       int missing_dst = 0;
> +       char *displaypath;
> +       char *sha1_abbr_src;
> +       char *sha1_abbr_dst;
> +       int errmsg = 0;
> +       int total_commits = -1;
> +       struct strbuf sb_sha1_src = STRBUF_INIT;
> +       struct strbuf sb_sha1_dst = STRBUF_INIT;
> +       char *sha1_dst = oid_to_hex(&p->oid_dst);
> +       char *sha1_src = oid_to_hex(&p->oid_src);
> +       char *sm_git_dir = xstrfmt("%s/.git", p->sm_path);
> +       int is_sm_git_dir = 0;
> +
> +       if (!info->cached && !strcmp(sha1_dst, sha1_to_hex(null_sha1))) {
> +               if (S_ISGITLINK(p->mod_dst)) {
> +                       struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
> +                       struct strbuf sb_rev_parse = STRBUF_INIT;
> +
> +                       cp_rev_parse.git_cmd = 1;
> +                       cp_rev_parse.no_stderr = 1;
> +                       cp_rev_parse.dir = p->sm_path;
> +                       prepare_submodule_repo_env(&cp_rev_parse.env_array);
> +
> +                       argv_array_pushl(&cp_rev_parse.args,
> +                                        "rev-parse", "HEAD", NULL);
> +                       if (!capture_command(&cp_rev_parse, &sb_rev_parse, 0)) {
> +                               strbuf_strip_suffix(&sb_rev_parse, "\n");
> +                               sha1_dst = xstrdup(sb_rev_parse.buf);
> +                       }
> +                       strbuf_release(&sb_rev_parse);
> +               } else if (S_ISLNK(p->mod_dst) || S_ISREG(p->mod_dst)) {
> +                       struct child_process cp_hash_object = CHILD_PROCESS_INIT;
> +                       struct strbuf sb_hash_object = STRBUF_INIT;
> +
> +                       cp_hash_object.git_cmd = 1;
> +                       argv_array_pushl(&cp_hash_object.args,
> +                                        "hash-object", p->sm_path,
> +                                        NULL);
> +                       if (!capture_command(&cp_hash_object,
> +                                            &sb_hash_object, 0)) {
> +                               strbuf_strip_suffix(&sb_hash_object, "\n");
> +                               sha1_dst = xstrdup(sb_hash_object.buf);
> +                       }
> +                       strbuf_release(&sb_hash_object);
> +               } else {
> +                       if (p->mod_dst != 0)

Maybe: if (p->mod_dst)

> +                               die(_("unexpected mode %d\n"), p->mod_dst);
> +               }
> +       }
> +
> +       if (is_git_directory(sm_git_dir))
> +               is_sm_git_dir = 1;
> +
> +       if (is_sm_git_dir && S_ISGITLINK(p->mod_src)) {
> +               struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
> +
> +               cp_rev_parse.git_cmd = 1;
> +               cp_rev_parse.no_stdout = 1;
> +               cp_rev_parse.dir = p->sm_path;
> +               prepare_submodule_repo_env(&cp_rev_parse.env_array);
> +
> +               argv_array_pushl(&cp_rev_parse.args, "rev-parse", "-q",
> +                                "--verify", NULL);
> +               argv_array_pushf(&cp_rev_parse.args, "%s^0", sha1_src);
> +
> +               if (run_command(&cp_rev_parse))
> +                       missing_src = 1;
> +       }
> +
> +       if (is_sm_git_dir && S_ISGITLINK(p->mod_dst)) {
> +               struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
> +
> +               cp_rev_parse.git_cmd = 1;
> +               cp_rev_parse.no_stdout = 1;
> +               cp_rev_parse.dir = p->sm_path;
> +               prepare_submodule_repo_env(&cp_rev_parse.env_array);
> +
> +               argv_array_pushl(&cp_rev_parse.args, "rev-parse", "-q",
> +                                "--verify", NULL);
> +               argv_array_pushf(&cp_rev_parse.args, "%s^0", sha1_dst);
> +
> +               if (run_command(&cp_rev_parse))
> +                       missing_dst = 1;
> +       }

The code of the 2 big if() { } clauses above look very similar and
could be factorized to avoid duplicating code.

[...]

> +       if (errmsg) {
> +               /*
> +                * Don't give error msg for modification whose dst is not
> +                * submodule, i.e. deleted or changed to blob
> +                */
> +               if (S_ISGITLINK(p->mod_src)) {
> +                       if (missing_src && missing_dst) {
> +                               printf(_("  Warn: %s doesn't contain commits %s and %s\n"),
> +                                displaypath, sha1_src, sha1_dst);
> +                       } else if (missing_src) {
> +                               printf(_("  Warn: %s doesn't contain commit %s\n"),
> +                                displaypath, sha1_src);
> +                       } else {
> +                               printf(_("  Warn: %s doesn't contain commit %s\n"),
> +                                displaypath, sha1_dst);
> +                       }
> +               }
> +

Spurious new line.

> +       } else if (is_sm_git_dir) {
> +               if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst)) {
> +                       struct child_process cp_log = CHILD_PROCESS_INIT;
> +                       char *limit = NULL;
> +
> +                       if (info->summary_limits > 0)
> +                               limit = xstrfmt("-%d", info->summary_limits);
> +
> +                       cp_log.git_cmd = 1;
> +                       cp_log.dir = p->sm_path;
> +                       prepare_submodule_repo_env(&cp_log.env_array);
> +
> +                       argv_array_pushl(&cp_log.args, "log", NULL);
> +                       if (limit)
> +                               argv_array_push(&cp_log.args, limit);
> +                       argv_array_pushl(&cp_log.args, "--pretty=  %m %s",
> +                                        "--first-parent", NULL);
> +                       argv_array_pushf(&cp_log.args, "%s...%s", sha1_src,
> +                                        sha1_dst);
> +
> +                       run_command(&cp_log);
> +

Spurious new line.

> +               } else if (S_ISGITLINK(p->mod_dst)) {
> +                       struct child_process cp_log = CHILD_PROCESS_INIT;
> +
> +                       cp_log.git_cmd = 1;
> +                       cp_log.dir = p->sm_path;
> +                       prepare_submodule_repo_env(&cp_log.env_array);
> +
> +                       argv_array_pushl(&cp_log.args, "log",
> +                                        "--pretty=  > %s", "-1",
> +                                        sha1_dst, NULL);
> +
> +                       run_command(&cp_log);
> +               } else {
> +                       struct child_process cp_log = CHILD_PROCESS_INIT;
> +
> +                       cp_log.git_cmd = 1;
> +                       cp_log.dir = p->sm_path;
> +                       prepare_submodule_repo_env(&cp_log.env_array);
> +
> +                       argv_array_pushl(&cp_log.args, "log",
> +                                        "--pretty=  < %s",
> +                                        "-1", sha1_src, NULL);
> +
> +                       run_command(&cp_log);
> +               }

It looks like you could factorize the big if () { } else { } clause
above using something like:

              if (S_ISGITLINK(p->mod_dst))
                       argv_array_pushl(&cp_log.args, "log",
                                        "--pretty=  > %s", "-1",
                                        sha1_dst, NULL);
              else
                       argv_array_pushl(&cp_log.args, "log",
                                        "--pretty=  < %s", "-1",
                                        sha1_src, NULL);

> +       }
> +       printf("\n");
> +}
> +
> +static void prepare_submodule_summary(struct summary_cb *info,
> +                                     struct module_cb_list *list)
> +{
> +       int i;
> +       for (i = 0; i < list->nr; i++) {
> +               struct module_cb *p = list->entries[i];
> +               struct child_process cp_rev_parse = CHILD_PROCESS_INIT;
> +
> +               if (p->status == 'D' || p->status == 'T') {
> +                       print_submodule_summary(info, p);
> +                       continue;
> +               }
> +
> +               if (info->for_status) {
> +                       char *config_key;
> +                       const char *ignore_config = "none";
> +                       const char *value;
> +                       const struct submodule *sub = submodule_from_path(null_sha1, p->sm_path);
> +
> +                       if (sub) {
> +                               config_key = xstrfmt("submodule.%s.ignore",
> +                                                    sub->name);
> +                               if (!git_config_get_value(config_key, &value))
> +                                       ignore_config = value;
> +                               else if (sub->ignore)
> +                                       ignore_config = sub->ignore;
> +
> +                               if (p->status != 'A' && !strcmp(ignore_config,
> +                                                               "all"))

Maybe in the case where p->status == 'A' we could avoid computing ignore_config.

> +                                       continue;
> +                       }

It looks like config_key is not freed.

> +               }

[...]

> +       cp_rev.git_cmd = 1;
> +       argv_array_pushl(&cp_rev.args, "rev-parse", "-q", "--verify",
> +                        NULL);
> +       if (argc)
> +               argv_array_push(&cp_rev.args, argv[0]);
> +       else
> +               argv_array_pushl(&cp_rev.args, "HEAD", NULL);

Maybe the last 4 lines replaced with:

      argv_array_push(&cp_rev.args, argc ? argv[0] : "HEAD");

or even the last 6 lines with:

       argv_array_pushl(&cp_rev.args, "rev-parse", "-q", "--verify",
                        argc ? argv[0] : "HEAD", NULL);

> +       if (!capture_command(&cp_rev, &sb_rev, 0)) {
> +               strbuf_strip_suffix(&sb_rev, "\n");
> +               head = xstrdup(sb_rev.buf);

It looks like "head" is not freed below.

I wonder if the "head" variable is really needed. Couldn't "sb_rev" be
used all along?
