Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 795961F859
	for <e@80x24.org>; Thu,  1 Sep 2016 01:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754227AbcIABEF (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 21:04:05 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35137 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753708AbcIABEE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 21:04:04 -0400
Received: by mail-oi0-f42.google.com with SMTP id p186so60538793oia.2
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 18:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twitter.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2tpjnJqIx9yFraXIt5+9+b7z7MAY0ZwbZjZ1b5Dazlw=;
        b=oZK0B9+XfnVcLV1mpm6IZzrJkzFJ2nzTCrWi5rP1+KqTh3cJdlx/TBMI8d5B9Wfc4z
         F6P70ibgXNn7yAjchl0pBcbeONXdGpwKeaj1xtygtROzs8m+mEqsBbqv2OcHWACBgnTY
         Kn3NPxdKfB7+6ldobCIKN1C+2BA+n/OQIHI50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2tpjnJqIx9yFraXIt5+9+b7z7MAY0ZwbZjZ1b5Dazlw=;
        b=mXV73mox+3mOpdR68FDRZ+0IHIu9xGf3P/TpUYaeaPw4znEvQL3NiG6C6NSSW6Zilj
         rfQY1mVJMKZogJgG4bUcjRhy518GtLaa54KE20tnWpMMF+F0Qo2ieCoxHsO2wve3Nhsh
         XeIlTUgV5SEvVSp90XVAr12YiV0uXb7yI5JQmXB7v3/eVIH22F2zas0HFqXK+bm2t5uv
         RisjcWLU51e13A5ZmuovcBcMQ4Q+dUeNqOJJG2gKAuMSv2Lyd7OqSdFV3t36GI6IJwkD
         b1gsiIs8gqheY3XAPFsrTFWqDAtftcZrS/sZKL8ioOzOkTA5MdawXVKkKomIS8TdQYVs
         lhZw==
X-Gm-Message-State: AE9vXwO4j39g/cVcU6S4PhUZHG4iQWxpLEX8cYx0fuu6NkUFbw33D8UbzqWdG5Ed/51lnIT6QWtT066pgVZ5lPnT
X-Received: by 10.202.244.133 with SMTP id s127mr11787600oih.15.1472691843325;
 Wed, 31 Aug 2016 18:04:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.55.226 with HTTP; Wed, 31 Aug 2016 18:04:02 -0700 (PDT)
In-Reply-To: <CAN5XQfujk2HpRGCeeGgDeeHJV3amEX=gSGva0Zot6LfEBv4CVg@mail.gmail.com>
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
 <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com> <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
 <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
 <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
 <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
 <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com> <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
 <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com>
 <CA+P7+xohfRsoV9VXgUrRaXPb9HvCc5gs4-KSWp38X_d_6EfkTA@mail.gmail.com>
 <CA+P7+xpGnsKzBPLVgPNSmZ7K00vY7-eJp7kSHWMRHM+cOsL_XQ@mail.gmail.com>
 <CAN5XQftCC+TUm2Jx4q3V9oFbXndtFx3H+daoB3TD3eWUs6s54A@mail.gmail.com>
 <xmqqzinu3zyw.fsf@gitster.mtv.corp.google.com> <CAN5XQfuoq6MV4e98RzUCG02KvZO6VZAbs1oxAzpdg5zswqpHGw@mail.gmail.com>
 <xmqq7faw3n5w.fsf@gitster.mtv.corp.google.com> <CAN5XQfvK7M5eSkMfz5iRTnE_va9VGjONAPO5hmF+iQg-i3XEpQ@mail.gmail.com>
 <xmqqh9a022xt.fsf@gitster.mtv.corp.google.com> <CAN5XQfujk2HpRGCeeGgDeeHJV3amEX=gSGva0Zot6LfEBv4CVg@mail.gmail.com>
From:   Uma Srinivasan <usrinivasan@twitter.com>
Date:   Wed, 31 Aug 2016 18:04:02 -0700
Message-ID: <CAN5XQfth-MLXOG0RjtJZ=4HZf2km3TgQ=4A88Wa7cOuRBgpi_g@mail.gmail.com>
Subject: Re: git submodules implementation question
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's one more attempt where I changed prepare_submodule_repo_env()
to take the submodule git dir as an argument.
Sorry for including this long code diff inline. If there's a better
way to have this discussion with code please let me know.

Thanks,
Uma

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9d79f19..0741f6c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -465,7 +465,7 @@ static int clone_submodule(const char *path, const
char *gitdir, const char *url
        argv_array_push(&cp.args, path);

        cp.git_cmd = 1;
-       prepare_submodule_repo_env(&cp.env_array);
+       prepare_submodule_repo_env(&cp.env_array, gitdir);
        cp.no_stdin = 1;

        return run_command(&cp);
diff --git a/submodule.c b/submodule.c
index 5a62aa2..3d9174a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -522,11 +522,31 @@ static int has_remote(const char *refname, const
struct object_id *oid,
        return 1;
 }

+static const char *submodule_git_dir = NULL;
+const char *get_submodule_git_dir(const char *path, struct strbuf *bufptr)
+{
+       strbuf_addf(bufptr, "%s/.git", path);
+       submodule_git_dir = read_gitfile(bufptr->buf);
+       if (!submodule_git_dir)
+               submodule_git_dir = bufptr->buf;
+       if (!is_directory(submodule_git_dir)) {
+               return NULL;
+       }
+       return submodule_git_dir;
+}
+
 static int submodule_needs_pushing(const char *path, const unsigned
char sha1[20])
 {
        if (add_submodule_odb(path) || !lookup_commit_reference(sha1))
                return 0;

+       struct strbuf gitdirbuf = STRBUF_INIT;
+        const char *sm_gitdir = get_submodule_git_dir(path, &gitdirbuf);
+       if (sm_gitdir == NULL) {
+               strbuf_release(&gitdirbuf);
+               return 0;
+       }
        if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
                struct child_process cp = CHILD_PROCESS_INIT;
                const char *argv[] = {"rev-list", NULL, "--not",
"--remotes", "-n", "1" , NULL};
@@ -535,7 +555,7 @@ static int submodule_needs_pushing(const char
*path, const unsigned char sha1[20

                argv[1] = sha1_to_hex(sha1);
                cp.argv = argv;
-               prepare_submodule_repo_env(&cp.env_array);
+               prepare_submodule_repo_env(&cp.env_array, sm_gitdir);
                cp.git_cmd = 1;
                cp.no_stdin = 1;
                cp.out = -1;
@@ -551,6 +571,7 @@ static int submodule_needs_pushing(const char
*path, const unsigned char sha1[20
                return needs_pushing;
        }

+       strbuf_release(&gitdirbuf);
        return 0;
 }

@@ -617,12 +638,18 @@ static int push_submodule(const char *path)
        if (add_submodule_odb(path))
                return 1;

+       struct strbuf gitdirbuf = STRBUF_INIT;
+        const char *sm_gitdir = get_submodule_git_dir(path, &gitdirbuf);
+       if (sm_gitdir == NULL) {
+               strbuf_release(&gitdirbuf);
+               return 0;
+       }
        if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
                struct child_process cp = CHILD_PROCESS_INIT;
                const char *argv[] = {"push", NULL};

                cp.argv = argv;
-               prepare_submodule_repo_env(&cp.env_array);
+               prepare_submodule_repo_env(&cp.env_array, sm_gitdir);
                cp.git_cmd = 1;
                cp.no_stdin = 1;
                cp.dir = path;
@@ -631,6 +658,7 @@ static int push_submodule(const char *path)
                close(cp.out);
        }

+       strbuf_release(&gitdirbuf);
        return 1;
 }

@@ -665,10 +693,16 @@ static int is_submodule_commit_present(const
char *path, unsigned char sha1[20])
                struct child_process cp = CHILD_PROCESS_INIT;
                const char *argv[] = {"rev-list", "-n", "1", NULL,
"--not", "--all", NULL};
                struct strbuf buf = STRBUF_INIT;
+               struct strbuf gitdirbuf = STRBUF_INIT;
+               const char *sm_gitdir = get_submodule_git_dir(path, &gitdirbuf);
+               if (sm_gitdir == NULL) {
+                       strbuf_release(&gitdirbuf);
+                       return 0;
+               }

                argv[3] = sha1_to_hex(sha1);
                cp.argv = argv;
-               prepare_submodule_repo_env(&cp.env_array);
+               prepare_submodule_repo_env(&cp.env_array, sm_gitdir);
                cp.git_cmd = 1;
                cp.no_stdin = 1;
                cp.dir = path;
@@ -676,6 +710,7 @@ static int is_submodule_commit_present(const char
*path, unsigned char sha1[20])
                        is_present = 1;

                strbuf_release(&buf);
+               strbuf_release(&gitdirbuf);
        }
        return is_present;
 }
@@ -851,7 +886,7 @@ static int get_next_submodule(struct child_process *cp,
                if (is_directory(git_dir)) {
                        child_process_init(cp);
                        cp->dir = strbuf_detach(&submodule_path, NULL);
-                       prepare_submodule_repo_env(&cp->env_array);
+                       prepare_submodule_repo_env(&cp->env_array, git_dir);
                        cp->git_cmd = 1;
                        if (!spf->quiet)
                                strbuf_addf(err, "Fetching submodule %s%s\n",
@@ -958,15 +993,14 @@ unsigned is_submodule_modified(const char *path,
int ignore_untracked)
                strbuf_release(&buf);
                /* The submodule is not checked out, so it is not modified */
                return 0;
-
        }
-       strbuf_reset(&buf);

        if (ignore_untracked)
                argv[2] = "-uno";

        cp.argv = argv;
-       prepare_submodule_repo_env(&cp.env_array);
+       prepare_submodule_repo_env(&cp.env_array, git_dir);
+       strbuf_reset(&buf);
        cp.git_cmd = 1;
        cp.no_stdin = 1;
        cp.out = -1;
@@ -1023,11 +1057,11 @@ int submodule_uses_gitfile(const char *path)
                strbuf_release(&buf);
                return 0;
        }
-       strbuf_release(&buf);

        /* Now test that all nested submodules use a gitfile too */
        cp.argv = argv;
-       prepare_submodule_repo_env(&cp.env_array);
+       prepare_submodule_repo_env(&cp.env_array, git_dir);
+       strbuf_release(&buf);
        cp.git_cmd = 1;
        cp.no_stdin = 1;
        cp.no_stderr = 1;
@@ -1052,6 +1086,7 @@ int ok_to_remove_submodule(const char *path)
        };
        struct strbuf buf = STRBUF_INIT;
        int ok_to_remove = 1;
+       const char *git_dir;

        if (!file_exists(path) || is_empty_dir(path))
                return 1;
@@ -1060,7 +1095,10 @@ int ok_to_remove_submodule(const char *path)
                return 0;

        cp.argv = argv;
-       prepare_submodule_repo_env(&cp.env_array);
+       strbuf_addf(&buf, "%s/.git", path);
+       git_dir = read_gitfile(buf.buf);
+       prepare_submodule_repo_env(&cp.env_array, git_dir);
+       strbuf_release(&buf);
        cp.git_cmd = 1;
        cp.no_stdin = 1;
        cp.out = -1;
@@ -1272,12 +1310,16 @@ int parallel_submodules(void)
        return parallel_jobs;
 }

-void prepare_submodule_repo_env(struct argv_array *out)
+void prepare_submodule_repo_env(struct argv_array *out, const char* git_dir)
 {
        const char * const *var;

        for (var = local_repo_env; *var; var++) {
                if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
                        argv_array_push(out, *var);
+               if (strcmp(*var, GIT_DIR_ENVIRONMENT))
+                       argv_array_pushf(out, "%s=%s", GIT_DIR_ENVIRONMENT,
+                                        real_path(git_dir));
        }
+
 }
diff --git a/submodule.h b/submodule.h
index d9e197a..4f8b0c7 100644
--- a/submodule.h
+++ b/submodule.h
@@ -73,6 +73,6 @@ int parallel_submodules(void);
  * a submodule by clearing any repo-specific envirionment variables, but
  * retaining any config in the environment.
  */
-void prepare_submodule_repo_env(struct argv_array *out);
+void prepare_submodule_repo_env(struct argv_array *out, const char *git_dir);

On Wed, Aug 31, 2016 at 11:58 AM, Uma Srinivasan
<usrinivasan@twitter.com> wrote:
>> We want to affect only the process we are going to spawn to work
>> inside the submodule, not ourselves, which is what this call does;
>> this does not sound like a good idea.
>
> Okay, in that case I would have to pass the "git_dir" as a new
> argument to prepare_submodule_repo_env(). I know what to pass from the
> is_submodule_modified() caller. I don't think it's all that obvious
> for the other callers.
>
> Thanks,
> Uma
>
> On Wed, Aug 31, 2016 at 11:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Uma Srinivasan <usrinivasan@twitter.com> writes:
>>
>>> diff --git a/submodule.c b/submodule.c
>>> index 5a62aa2..23443a7 100644
>>> --- a/submodule.c
>>> +++ b/submodule.c
>>> @@ -960,6 +960,9 @@ unsigned is_submodule_modified(const char *path,
>>> int ignore_untracked)
>>>                 return 0;
>>>
>>>         }
>>> +       /* stuff submodule git dir into env var */
>>> +       set_git_dir(git_dir);
>>
>> We want to affect only the process we are going to spawn to work
>> inside the submodule, not ourselves, which is what this call does;
>> this does not sound like a good idea.
>>
