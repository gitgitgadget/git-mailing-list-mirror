Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46842ECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 15:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiIIPGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 11:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiIIPGd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 11:06:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70D5136CF8
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 08:06:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e16so3241451wrx.7
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 08:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=aaefARsVa3zQn6xZd5Yp5lIHWA9/QOH0zhizgjfEPdo=;
        b=e2XCt8m8pdJkPtiOwNOJRrGWYHZYQzb+HL6Jkx9TspNYXMxRgm/ylX+4SAYvCCdfq3
         ULiqHdPpfUR+WpWsJInV83XopCr4K2eiJq+26gGULvNZ5reSsX0ZpJzAkqjwWPUOBsLS
         CZhAoMHJMF8dabVQ48lauZJQi6Ei1ICB90DB+E1yWI/toFdTAKwpgTATL6Ycv/hDthQ5
         RHJswh13eQWfKGLuQVX3GiVakNqL+iyp8wnyN1vGXvVHIrGOw0d1O+9EVazz6gCBrhel
         MzMOStVVV1TLHcFYKuM1yuhaZI/OstjaFQiaD/FUOffUmBXo1hk94NreOwpCWYUvl+wv
         W7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aaefARsVa3zQn6xZd5Yp5lIHWA9/QOH0zhizgjfEPdo=;
        b=Ih+zkiqUdB1HU86G3FEKiI4kgHBke6iHD7HVSSJLcoJbf+QJGECj/m/nmKdwoe4vLm
         T1pX+wGNw2B+s0Zik4kAfjadhEP/1c7f4lS3Gtx2NrHMFJY8l4HnWBUnQ7Adu/oi1x0g
         mewv2mZz3AU2pag5qwr9rJNu0sUph3IZ0pFk6tFRH3VYPhduSqMZdEmIS5nVZxohWQyx
         BWE7l8h9WV+xoUCXm1JzPScfVrXwr8h2p+8oi/qV/No6GDDiXXGoaX7pBvpuN5XKFgfp
         dodXsm0J+kx1JbmBbOHbuYfoBzSR7qXRLG1+70yCCvgXz0i8TwfO0TABqracmZSVubUC
         MRLg==
X-Gm-Message-State: ACgBeo0LWMAhQ+XOSAaKjSYLmWamVetGrkN88D9TIs36/IOb+MPRa9t6
        vwATexAd6UOKhAXk/t3e32GBrlNbUiQ=
X-Google-Smtp-Source: AA6agR6uyyEaMsx08JrBk+bs6F8M3IMttrW3XsxB4XUCwU05XGvupQdF7lNYi0r79qOEc5I0hdrh8g==
X-Received: by 2002:adf:f905:0:b0:224:f876:c001 with SMTP id b5-20020adff905000000b00224f876c001mr8016695wrr.201.1662735986992;
        Fri, 09 Sep 2022 08:06:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e11-20020adffd0b000000b00228da845d4dsm674791wrr.94.2022.09.09.08.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:06:26 -0700 (PDT)
Message-Id: <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v4.git.git.1660575688.gitgitgadget@gmail.com>
References: <pull.1301.v4.git.git.1660575688.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Sep 2022 15:06:20 +0000
Subject: [PATCH v5 0/5] hiderefs: add hide-refs hook to hide refs dynamically
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sun Chao <16657101987@163.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, thanks for reviewing the patches, we'd like to add a new hook called
"hide-refs", which can be used to hide refs dynamically according to the
user's access to the git servers. Here is the reasons:

(1) There are lots of development teams in our company (Huawei), and they
have been using the Gerrit platform during development work for a long time
and get used to its features, e.g. Gerrit's reference-level control feature
can be used to arrange different small teams to develop on different
branches, some branches will be only visible to special teams, this way of
working effectively shields the interference between different branches.

In this way Gerrit could protect each teams' codes privately until
administrators decided to merge or cherry-pick the codes together. Most of
the developers cannot see all the references of the repositories, and Gerrit
does not apply the 'fork' feature which exists in Github or Gitlab, if you
want to create a code review task you can just run git command like:

git push origin HEAD:refs/for/main


Developers cannot fork their own repositories but clone from and push to the
same repositories, so in Huawei, when we talk about Gerrit, we always treat
it as a centralized workflow platform and lots of teams like its features.

(2) Gerrit implement the JGit which supports the wire git protocol V1 and
V2. We have built our new git server based on Gitlab-CE
[https://gitlab.com/rluna-gitlab/gitlab-ce] and it uses CGit (Compared to
Gerrit's JGit, someone call the Git itself as CGit). Recently we were
planning to migrate some development teams from Gerrit platform to the new
server. So we wish the new server can work like Gerrit which allow users
create code review task by git push command and also can hide refs according
to the user's access.

Commit 15d3af5e22 (receive-pack: add new proc-receive hook, 2020-08-27) make
it possible to create a code review by a single proc-receive command on the
server side. What we need right now is reference-level permission control,
we referred to Gerrit's implementation mechanism and added a new reference
filtering mechanism:

a) We config the reference level control rules on server side, eg:

    ```json
    {
        {
            "ref":"refs/heads/stable/*",
            "action":"read",
            "access":"allow",
            "user_group":"dev_group_1"
        },
        {
            "ref":"refs/heads/stable/*",
            "action":"read",
            "access":"deny",
            "user_group":"dev_group_1"
        },
        {
            "ref":"refs/for/*",
            "action":"create-codereview",
            "access":"access",
            "user_group":"dev_group_1"
        },
        ... ...
    }
    ```

b) During upload-pack and receive-pack the hide-refs hook will hide the refs
    that the user cannot read during reference advertise phase according to
    the reference level control rules above.
c) We also add a `HIDDEN_REF_FORCE` flag to make sure the private data
    of these hide refs cannot be fetched by the git clients.


(3) When we talk about permission control in git, it may comes to the
directory permission control, but however we can use the workflow like
Gerrit to control the contents of a repository by put its parts to different
branches, and merge or cherry-pick them together if needed.

In special scenarios, we need to protect the content on some branches from
being seen by others and leaked to other teams, now we can achieve that by
the new "hide-refs" hook.

And here I will talk about how the "hide-refs" works on server side:

This hook would be invoked by 'git-receive-pack' and 'git-upload-pack'
during the reference discovery phase, each reference will be filtered with
this hook. The hook executes once with no arguments for each
'git-upload-pack' and 'git-receive-pack' process. Once the hook is invoked,
a version number and server process name ('uploadpack' or 'receive') will
send to it in pkt-line format, followed by a flush-pkt. The hook should
respond with its version number.

During reference discovery phase, each reference will be filtered by this
hook. In the following example, the letter 'G' stands for 'git-receive-pack'
or 'git-upload-pack' and the letter 'H' stands for this hook. The hook
decides if the reference will be hidden or not, it sends result back in
pkt-line format protocol, a response "hide" means the references will hide
to the client.

# Version negotiation
G: PKT-LINE(version=1\0uploadpack)
G: flush-pkt
H: PKT-LINE(version=1)
H: flush-pkt

# Send reference filter request to hook
G: PKT-LINE(ref <refname>:<refname_full>)
G: flush-pkt

# Receive result from the hook.
# Case 1: this reference is hidden
H: PKT-LINE(hide)
H: flush-pkt

# Case 2: this reference can be advertised
H: flush-pkt


To enable the hide-refs hook, we should config hiderefs with hook: option,
eg:

git config --add transfer.hiderefs hook:refs/prefix1/
git config --add uploadpack.hiderefs hook:!refs/prefix2/


the hide-refs will be called during reference discovery phase and check each
matched reference, a 'hide' response means the reference will be hidden for
its private data even if allowTipSHA1InWant or allowReachableSHA1InWant are
set to true.

Sun Chao (5):
  hiderefs: add hide-refs hook to hide refs dynamically
  hiderefs: use new flag to mark force hidden refs
  hiderefs: hornor hide flags in wire protocol V2
  test: add test cases for hide-refs hook
  doc: add documentation for the hide-refs hook

 Documentation/githooks.txt                    |  48 +++
 Makefile                                      |   1 +
 ls-refs.c                                     |   2 +-
 refs.c                                        | 288 +++++++++++++++++-
 refs.h                                        |   7 +
 t/helper/test-hide-refs.c                     | 107 +++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t1419-hide-refs-hook.sh                     | 112 +++++++
 t/t1419/abnormal-hide-refs-hook.sh            |  82 +++++
 t/t1419/common-functions.sh                   |  74 +++++
 ...test-0001-ls-remote-with-hide-refs-hook.sh |  45 +++
 ...st-0002-upload-pack-with-hide-refs-hook.sh |  47 +++
 ...t-0003-receive-pack-with-hide-refs-hook.sh |  42 +++
 upload-pack.c                                 |  25 +-
 15 files changed, 855 insertions(+), 27 deletions(-)
 create mode 100644 t/helper/test-hide-refs.c
 create mode 100755 t/t1419-hide-refs-hook.sh
 create mode 100644 t/t1419/abnormal-hide-refs-hook.sh
 create mode 100644 t/t1419/common-functions.sh
 create mode 100644 t/t1419/test-0001-ls-remote-with-hide-refs-hook.sh
 create mode 100644 t/t1419/test-0002-upload-pack-with-hide-refs-hook.sh
 create mode 100644 t/t1419/test-0003-receive-pack-with-hide-refs-hook.sh


base-commit: 79f2338b3746d23454308648b2491e5beba4beff
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1301%2Fsunchao9%2Frefs_advertise-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1301/sunchao9/refs_advertise-v5
Pull-Request: https://github.com/git/git/pull/1301

Range-diff vs v4:

 1:  01c63ea5fee ! 1:  278bd185aec hide-refs: add hook to force hide refs
     @@ Metadata
      Author: Sun Chao <sunchao9@huawei.com>
      
       ## Commit message ##
     -    hide-refs: add hook to force hide refs
     +    hiderefs: add hide-refs hook to hide refs dynamically
      
          Gerrit is implemented by JGit and is known as a centralized workflow system
          which supports reference-level access control for repository. If we choose
     @@ Commit message
          hook. In the following example, the letter 'G' stands for 'git-receive-pack'
          or 'git-upload-pack' and the letter 'H' stands for this hook. The hook
          decides if the reference will be hidden or not, it sends result back in
     -    pkt-line format protocol, a response "hide" means the references will hide
     -    to the client and can not fetch its private data even in protocol V2.
     +    pkt-line format protocol, a response "hide" means the references will be
     +    hidden to the client.
      
                  # Version negotiation
                  G: PKT-LINE(version=1\0uploadpack)
     @@ Commit message
                  # Case 2: this reference can be advertised
                  H: flush-pkt
      
     -    To enable the `hide-refs` hook, we should config hiderefs with `force:`
     +    To enable the `hide-refs` hook, we should config hiderefs with `hook:`
          option, eg:
      
     -            git config --add transfer.hiderefs force:refs/prefix1/
     -            git config --add uploadpack.hiderefs force:!refs/prefix2/
     -
     -    the `hide-refs` will be called during reference discovery phase and
     -    check each matched reference, a 'hide' response means the reference will
     -    be hidden for its private data even if `allowTipSHA1InWant` or
     -    `allowReachableSHA1InWant` are set to true.
     +            git config --add transfer.hiderefs hook:refs/prefix1/
     +            git config --add uploadpack.hiderefs hook:!refs/prefix2/
      
          Signed-off-by: Sun Chao <sunchao9@huawei.com>
      
     - ## Makefile ##
     -@@ Makefile: TEST_BUILTINS_OBJS += test-wildmatch.o
     - TEST_BUILTINS_OBJS += test-windows-named-pipe.o
     - TEST_BUILTINS_OBJS += test-write-cache.o
     - TEST_BUILTINS_OBJS += test-xml-encode.o
     -+TEST_BUILTINS_OBJS += test-hide-refs.o
     - 
     - # Do not add more tests here unless they have extra dependencies. Add
     - # them in TEST_BUILTINS_OBJS above.
     -
     - ## builtin/receive-pack.c ##
     -@@ builtin/receive-pack.c: static int show_ref_cb(const char *path_full, const struct object_id *oid,
     - 	struct oidset *seen = data;
     - 	const char *path = strip_namespace(path_full);
     - 
     --	if (ref_is_hidden(path, path_full))
     -+	if (ref_is_hidden(path, path_full) || ref_is_force_hidden(path, path_full))
     - 		return 0;
     - 
     - 	/*
     -@@ builtin/receive-pack.c: static void reject_updates_to_hidden(struct command *commands)
     - 		strbuf_setlen(&refname_full, prefix_len);
     - 		strbuf_addstr(&refname_full, cmd->ref_name);
     - 
     --		if (!ref_is_hidden(cmd->ref_name, refname_full.buf))
     -+		if (!ref_is_hidden(cmd->ref_name, refname_full.buf) &&
     -+			!ref_is_force_hidden(cmd->ref_name, refname_full.buf))
     - 			continue;
     - 		if (is_null_oid(&cmd->new_oid))
     - 			cmd->error_string = "deny deleting a hidden ref";
     -
     - ## ls-refs.c ##
     -@@ ls-refs.c: static int send_ref(const char *refname, const struct object_id *oid,
     - 
     - 	strbuf_reset(&data->buf);
     - 
     --	if (ref_is_hidden(refname_nons, refname))
     -+	if (mark_our_ref(refname_nons, refname, oid))
     - 		return 0;
     - 
     - 	if (!ref_match(&data->prefixes, refname_nons))
     -
       ## refs.c ##
      @@
       #include "lockfile.h"
     @@ refs.c: char *shorten_unambiguous_ref(const char *refname, int strict)
       }
       
       static struct string_list *hide_refs;
     --
     -+static struct string_list *force_hide_refs;
     ++static struct string_list *hook_hide_refs;
      +static struct strbuf hide_refs_section = STRBUF_INIT;
     + 
       int parse_hide_refs_config(const char *var, const char *value, const char *section)
       {
       	const char *key;
     -+	int force = 0;
     ++	int hook = 0;
      +
       	if (!strcmp("transfer.hiderefs", var) ||
       	    (!parse_config_key(var, section, NULL, NULL, &key) &&
       	     !strcmp(key, "hiderefs"))) {
     - 		char *ref;
     - 		int len;
     -+		int forcelen;
     +@@ refs.c: int parse_hide_refs_config(const char *var, const char *value, const char *secti
       
       		if (!value)
       			return config_error_nonbool(var);
      +
     -+		forcelen = strlen("force:");
     -+		len = strlen(value);
     -+		if ((len >= forcelen) && !strncmp(value, "force:", forcelen)) {
     -+			if (len == forcelen)
     -+				return error(_("missing value for '%s' with force option"), var);
     -+
     -+			force = 1;
     -+			value += forcelen;
     ++		/*
     ++		 * the prefix 'hook:' means that the matched refs will be
     ++		 * checked by the hide-refs hook dynamically, we need to put
     ++		 * the 'ref' string to the hook_hide_refs list
     ++		 */
     ++		if (skip_prefix(value, "hook:", &value)) {
     ++			if (!strlen(value))
     ++				return error(_("missing value for '%s' after hook option"), var);
     ++			hook = 1;
      +		}
      +
       		ref = xstrdup(value);
     @@ refs.c: char *shorten_unambiguous_ref(const char *refname, int strict)
      -			CALLOC_ARRAY(hide_refs, 1);
      -			hide_refs->strdup_strings = 1;
      +
     -+		if (force) {
     -+			if (!force_hide_refs) {
     -+				CALLOC_ARRAY(force_hide_refs, 1);
     -+				force_hide_refs->strdup_strings = 1;
     ++		if (hook) {
     ++			if (!hook_hide_refs) {
     ++				CALLOC_ARRAY(hook_hide_refs, 1);
     ++				hook_hide_refs->strdup_strings = 1;
      +			}
     -+			string_list_append(force_hide_refs, ref);
     ++			string_list_append(hook_hide_refs, ref);
      +		} else {
      +			if (!hide_refs) {
      +				CALLOC_ARRAY(hide_refs, 1);
     @@ refs.c: char *shorten_unambiguous_ref(const char *refname, int strict)
      -		string_list_append(hide_refs, ref);
       	}
      +
     -+	if (hide_refs_section.len == 0) {
     ++	/*
     ++	 * Once hide-refs hook is invoked, Git need to do version negotiation,
     ++	 * with it, version number and process name ('uploadpack' or 'receive')
     ++	 * will send to it in pkt-line format, the proccess name is recorded
     ++	 * by hide_refs_section
     ++	 */
     ++	if (hook && hide_refs_section.len == 0)
      +		strbuf_addstr(&hide_refs_section, section);
     -+	}
      +
       	return 0;
       }
     @@ refs.c: char *shorten_unambiguous_ref(const char *refname, int strict)
      -int ref_is_hidden(const char *refname, const char *refname_full)
      +static struct child_process *hide_refs_proc;
      +static struct packet_reader *hide_refs_reader;
     -+static void create_hide_refs_process(void) {
     ++
     ++/*
     ++ * Create the hide-refs hook child process and complete version negotiation,
     ++ * return non-zero upon success, otherwise 0
     ++ */
     ++static int create_hide_refs_process(void)
     ++{
      +	struct child_process *proc;
      +	struct packet_reader *reader;
      +	const char *hook_path;
      +	int version = 0;
     -+	int code;
     ++	int err;
      +
      +	hook_path = find_hook("hide-refs");
     -+	if (!hook_path) {
     -+		die("can not find hide-refs hook");
     -+	}
     ++	if (!hook_path)
     ++		return 0;
      +
     -+	proc = (struct child_process *) xcalloc (1, sizeof (struct child_process));
     -+	reader = (struct packet_reader *) xcalloc (1, sizeof(struct packet_reader));
     ++	proc = (struct child_process *)xcalloc(1, sizeof (struct child_process));
     ++	reader = (struct packet_reader *)xcalloc(1, sizeof(struct packet_reader));
      +
      +	child_process_init(proc);
      +	strvec_push(&proc->args, hook_path);
     @@ refs.c: char *shorten_unambiguous_ref(const char *refname, int strict)
      +	proc->trace2_hook_name = "hide-refs";
      +	proc->err = 0;
      +
     -+	code = start_command(proc);
     -+	if (code)
     -+		die("can not run hook hide-refs");
     ++	err = start_command(proc);
     ++	if (err)
     ++		goto cleanup;
      +
      +	sigchain_push(SIGPIPE, SIG_IGN);
      +
      +	/* Version negotiaton */
      +	packet_reader_init(reader, proc->out, NULL, 0,
     -+			   PACKET_READ_CHOMP_NEWLINE |
     -+			   PACKET_READ_GENTLE_ON_EOF);
     -+	code = packet_write_fmt_gently(proc->in, "version=1%c%s", '\0', hide_refs_section.buf);
     -+	if (!code)
     -+		code = packet_flush_gently(proc->in);
     ++			   PACKET_READ_CHOMP_NEWLINE | PACKET_READ_GENTLE_ON_EOF);
     ++	err = packet_write_fmt_gently(proc->in, "version=1%c%s", '\0', hide_refs_section.buf);
     ++	if (!err)
     ++		err = packet_flush_gently(proc->in);
      +
     -+	if (!code)
     ++	if (!err)
      +		for (;;) {
      +			enum packet_read_status status;
      +
     @@ refs.c: char *shorten_unambiguous_ref(const char *refname, int strict)
      +			if (status != PACKET_READ_NORMAL) {
      +				/* Check whether hide-refs exited abnormally */
      +				if (status == PACKET_READ_EOF)
     -+					die("can not read version message from hook hide-refs");
     ++					goto failure;
      +				break;
      +			}
      +
     @@ refs.c: char *shorten_unambiguous_ref(const char *refname, int strict)
      +			}
      +		}
      +
     -+	if (code)
     -+		die("can not read version message from hook hide-refs");
     ++	if (err)
     ++		goto failure;
      +
      +	switch (version) {
      +	case 0:
     @@ refs.c: char *shorten_unambiguous_ref(const char *refname, int strict)
      +	case 1:
      +		break;
      +	default:
     -+		die(_("hook hide-refs version '%d' is not supported"), version);
     ++		trace_printf(_("hook hide-refs version '%d' is not supported"), version);
     ++		goto failure;
      +	}
      +
      +	sigchain_pop(SIGPIPE);
      +
      +	hide_refs_proc = proc;
      +	hide_refs_reader = reader;
     -+	return;
     ++	return 1;
     ++
     ++failure:
     ++	close(proc->in);
     ++	close(proc->out);
     ++	kill(proc->pid, SIGTERM);
     ++	finish_command_in_signal(proc);
     ++
     ++cleanup:
     ++	free(proc);
     ++	free(reader);
     ++	sigchain_pop(SIGPIPE);
     ++	return 0;
      +}
      +
     -+static int ref_force_hidden_check(const char *refname, const char *refname_full)
     ++/* If hide-refs child process start failed, set skip_hide_refs_proc to true */
     ++static int skip_hide_refs_proc;
     ++
     ++/*
     ++ * Return non-zero if hide-refs hook want to hide the ref and 0 otherwise,
     ++ * and return 0 if hide-refs child proccess start failed or exit abnormally
     ++ */
     ++static int ref_hidden_check_by_hook(const char *refname, const char *refname_full)
      +{
      +	struct strbuf buf = STRBUF_INIT;
     -+	int code;
     ++	int err;
      +	int ret = 0;
      +
     -+	if (!force_hide_refs) {
     ++	if (skip_hide_refs_proc)
      +		return 0;
     -+	}
      +
     -+	if (!hide_refs_proc) {
     -+		create_hide_refs_process();
     -+	}
     ++	if (!hide_refs_proc)
     ++		if (!create_hide_refs_process()) {
     ++			skip_hide_refs_proc = 1;
     ++			return 0;
     ++		}
      +
      +	sigchain_push(SIGPIPE, SIG_IGN);
     -+	code = packet_write_fmt_gently(hide_refs_proc->in, "ref %s:%s", refname, refname_full);
     -+	if (code)
     -+		die("hook hide-refs died abnormally");
     ++	err = packet_write_fmt_gently(hide_refs_proc->in, "ref %s:%s", refname, refname_full);
     ++	if (err)
     ++		goto cleanup;
      +
     -+	code = packet_flush_gently(hide_refs_proc->in);
     -+	if (code)
     -+		die("hook hide-refs died abnormally");
     ++	err = packet_flush_gently(hide_refs_proc->in);
     ++	if (err)
     ++		goto cleanup;
      +
      +	for (;;) {
      +		enum packet_read_status status;
     @@ refs.c: char *shorten_unambiguous_ref(const char *refname, int strict)
      +		if (status != PACKET_READ_NORMAL) {
      +			/* Check whether hide-refs exited abnormally */
      +			if (status == PACKET_READ_EOF)
     -+				die("hook hide-refs died abnormally");
     ++				goto cleanup;
      +			break;
      +		}
      +
     -+		strbuf_reset(&buf);
      +		strbuf_addstr(&buf, hide_refs_reader->line);
      +	}
      +
     @@ refs.c: char *shorten_unambiguous_ref(const char *refname, int strict)
      +
      +	sigchain_pop(SIGPIPE);
      +	return ret;
     ++
     ++cleanup:
     ++	close(hide_refs_proc->in);
     ++	close(hide_refs_proc->out);
     ++	kill(hide_refs_proc->pid, SIGTERM);
     ++	finish_command_in_signal(hide_refs_proc);
     ++
     ++	free(hide_refs_proc);
     ++	free(hide_refs_reader);
     ++	sigchain_pop(SIGPIPE);
     ++
     ++	skip_hide_refs_proc = 1;
     ++	return 0;
      +}
      +
     -+static int ref_hidden_check(const char *refname, const char *refname_full, int force)
     ++static int ref_hidden_check(const char *refname, const char *refname_full, int hook)
       {
      +	struct string_list *hide_refs_list = hide_refs;
       	int i;
       
      -	if (!hide_refs)
     -+	if (force)
     -+		hide_refs_list = force_hide_refs;
     ++	if (hook)
     ++		hide_refs_list = hook_hide_refs;
      +
      +	if (!hide_refs_list)
       		return 0;
     @@ refs.c: int ref_is_hidden(const char *refname, const char *refname_full)
      +		    (!*p || *p == '/')) {
      +			if (neg)
      +				return 0;
     -+			if (!force)
     ++			if (!hook)
      +				return 1;
     -+			return ref_force_hidden_check(refname, refname_full);
     ++			return ref_hidden_check_by_hook(refname, refname_full);
      +		}
       	}
       	return 0;
     @@ refs.c: int ref_is_hidden(const char *refname, const char *refname_full)
       
      +int ref_is_hidden(const char *refname, const char *refname_full)
      +{
     -+	return ref_hidden_check(refname, refname_full, 0);
     -+}
     -+
     -+int ref_is_force_hidden(const char *refname, const char *refname_full)
     -+{
     -+	return ref_hidden_check(refname, refname_full, 1);
     -+}
     -+
     -+#define OUR_REF		(1u << 12)
     -+#define HIDDEN_REF	(1u << 19)
     -+#define HIDDEN_REF_FORCE	(1u << 20)
     -+static int has_force_hidden;
     -+int mark_our_ref(const char *refname, const char *refname_full,
     -+			const struct object_id *oid)
     -+{
     -+	struct object *o;
     -+
     -+	if (!oid || is_null_oid(oid)) {
     -+		return 0;
     -+	}
     -+
     -+	o = lookup_unknown_object(the_repository, oid);
     -+	if (ref_is_force_hidden(refname, refname_full)) {
     -+		o->flags |= HIDDEN_REF_FORCE;
     -+		has_force_hidden = 1;
     -+		return 1;
     -+	}
     -+	if (ref_is_hidden(refname, refname_full)) {
     -+		o->flags |= HIDDEN_REF;
     ++	if (ref_hidden_check(refname, refname_full, 0) ||
     ++	    ref_hidden_check(refname, refname_full, 1))
      +		return 1;
     -+	}
     -+	o->flags |= OUR_REF;
      +	return 0;
      +}
     -+
     -+int has_force_hidden_refs(void) {
     -+	return has_force_hidden;
     -+}
      +
       const char *find_descendant_ref(const char *dirname,
       				const struct string_list *extras,
       				const struct string_list *skip)
     -
     - ## refs.h ##
     -@@ refs.h: int parse_hide_refs_config(const char *var, const char *value, const char *);
     -  * parameter always points to the full ref name.
     -  */
     - int ref_is_hidden(const char *, const char *);
     -+int ref_is_force_hidden(const char *, const char *);
     -+/* return non-zero if the ref is hidden, otherwise 0 */
     -+int mark_our_ref(const char *refname, const char *refname_full,
     -+			const struct object_id *oid);
     -+int has_force_hidden_refs(void);
     -+void lazy_load_hidden_refs(void);
     - 
     - enum ref_type {
     - 	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
     -
     - ## serve.c ##
     -@@
     - #include "cache.h"
     - #include "repository.h"
     - #include "config.h"
     -+#include "refs.h"
     - #include "pkt-line.h"
     - #include "version.h"
     - #include "ls-refs.h"
     -@@ serve.c: void protocol_v2_serve_loop(int stateless_rpc)
     - 	 * a single request/response exchange
     - 	 */
     - 	if (stateless_rpc) {
     -+		lazy_load_hidden_refs();
     - 		process_request();
     - 	} else {
     - 		for (;;)
     -
     - ## t/helper/test-hide-refs.c (new) ##
     -@@
     -+#include "cache.h"
     -+#include "hash.h"
     -+#include "config.h"
     -+#include "connect.h"
     -+#include "parse-options.h"
     -+#include "pkt-line.h"
     -+#include "sigchain.h"
     -+#include "test-tool.h"
     -+
     -+static const char *hide_refs_usage[] = {
     -+	"test-tool hide-refs [<options>...]",
     -+	NULL
     -+};
     -+
     -+static int die_read_version;
     -+static int die_write_version;
     -+static int die_read_first_ref;
     -+static int die_read_second_ref;
     -+static int die_after_proc_ref;
     -+static int verbose;
     -+static int version = 1;
     -+static int first_ref;
     -+static int second_ref;
     -+static int hash_size = GIT_SHA1_HEXSZ;
     -+static struct string_list returns = STRING_LIST_INIT_NODUP;
     -+
     -+struct command {
     -+	struct command *next;
     -+	const char *error_string;
     -+	unsigned int skip_update:1,
     -+		     did_not_exist:1;
     -+	int index;
     -+	struct object_id old_oid;
     -+	struct object_id new_oid;
     -+	char ref_name[FLEX_ARRAY]; /* more */
     -+};
     -+
     -+static void hide_refs_verison(struct packet_reader *reader) {
     -+	int server_version = 0;
     -+
     -+	if (die_read_version)
     -+		die("die with the --die-read-version option");
     -+
     -+	for (;;) {
     -+		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
     -+			break;
     -+
     -+		/* Ignore version negotiation for version 0 */
     -+		if (version == 0)
     -+			continue;
     -+
     -+		if (reader->pktlen > 8 && starts_with(reader->line, "version=")) {
     -+			server_version = atoi(reader->line+8);
     -+			if (server_version != 1)
     -+				die("bad protocol version: %d", server_version);
     -+		}
     -+	}
     -+
     -+	if (die_write_version)
     -+		die("die with the --die-write-version option");
     -+
     -+	packet_write_fmt(1, "version=%d\n", version);
     -+	packet_flush(1);
     -+}
     -+
     -+static void hide_refs_proc(struct packet_reader *reader)
     -+{
     -+	const char *p;
     -+	struct strbuf buf = STRBUF_INIT;
     -+	enum packet_read_status status;
     -+
     -+	if (!first_ref) {
     -+		if (die_read_first_ref)
     -+			die("die with the --die-read-first-ref option");
     -+
     -+		first_ref = 1;
     -+	}
     -+
     -+	if (first_ref && !second_ref) {
     -+		if (die_read_second_ref)
     -+			die("die with the --die-read-second-ref option");
     -+
     -+		second_ref = 1;
     -+	}
     -+
     -+	for (;;) {
     -+		status = packet_reader_read(reader);
     -+		if (status == PACKET_READ_EOF)
     -+			exit(0);
     -+
     -+		if (status != PACKET_READ_NORMAL)
     -+			break;
     -+
     -+		p = reader->line;
     -+		strbuf_reset(&buf);
     -+		strbuf_addstr(&buf, reader->line);
     -+	}
     -+
     -+	p = strchr(buf.buf, ':');
     -+	if (unsorted_string_list_has_string(&returns, p + 1)) {
     -+		packet_write_fmt(1, "hide");
     -+	}
     -+
     -+	if (die_after_proc_ref)
     -+		die("die with the --die-after-proc-refs option");
     -+
     -+	packet_flush(1);
     -+}
     -+
     -+int cmd__hide_refs(int argc, const char **argv) {
     -+	int nongit_ok = 0;
     -+	struct packet_reader reader;
     -+	const char *value = NULL;
     -+	struct option options[] = {
     -+		OPT_BOOL(0, "die-read-version", &die_read_version,
     -+			 "die when reading version"),
     -+		OPT_BOOL(0, "die-write-version", &die_write_version,
     -+			 "die when writing version"),
     -+		OPT_BOOL(0, "die-read-first-ref", &die_read_first_ref,
     -+			 "die when reading first reference"),
     -+		OPT_BOOL(0, "die-read-second-ref", &die_read_second_ref,
     -+			 "die when reading second reference"),
     -+		OPT_BOOL(0, "die-after-proc-refs", &die_after_proc_ref,
     -+			 "die after proc ref"),
     -+		OPT_STRING_LIST('r', "reserved", &returns, "refs-to-force-hidden",
     -+				"refs that will force hide"),
     -+		OPT__VERBOSE(&verbose, "be verbose"),
     -+		OPT_INTEGER('V', "version", &version,
     -+			    "use this protocol version number"),
     -+		OPT_END()
     -+	};
     -+
     -+	setup_git_directory_gently(&nongit_ok);
     -+
     -+	argc = parse_options(argc, argv, "test-tools", options, hide_refs_usage, 0);
     -+	if (argc > 0)
     -+		usage_msg_opt("Too many arguments.", hide_refs_usage, options);
     -+
     -+	packet_reader_init(&reader, 0, NULL, 0, PACKET_READ_CHOMP_NEWLINE | PACKET_READ_GENTLE_ON_EOF);
     -+
     -+	if (!git_config_get_value("extensions.objectformat", &value)) {
     -+		if (!strcmp(value, "sha256"))
     -+			hash_size = GIT_SHA256_HEXSZ;
     -+	}
     -+
     -+	hide_refs_verison(&reader);
     -+	for (;;) {
     -+		hide_refs_proc(&reader);
     -+	}
     -+
     -+	return 0;
     -+}
     -
     - ## t/helper/test-tool.c ##
     -@@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
     - 	{ "regex", cmd__regex },
     - 	{ "repository", cmd__repository },
     - 	{ "revision-walking", cmd__revision_walking },
     -+	{ "hide-refs", cmd__hide_refs },
     - 	{ "run-command", cmd__run_command },
     - 	{ "scrap-cache-tree", cmd__scrap_cache_tree },
     - 	{ "serve-v2", cmd__serve_v2 },
     -
     - ## t/helper/test-tool.h ##
     -@@ t/helper/test-tool.h: int cmd__reftable(int argc, const char **argv);
     - int cmd__regex(int argc, const char **argv);
     - int cmd__repository(int argc, const char **argv);
     - int cmd__revision_walking(int argc, const char **argv);
     -+int cmd__hide_refs(int argc, const char **argv);
     - int cmd__run_command(int argc, const char **argv);
     - int cmd__scrap_cache_tree(int argc, const char **argv);
     - int cmd__serve_v2(int argc, const char **argv);
     -
     - ## upload-pack.c ##
     -@@
     - #define NOT_SHALLOW	(1u << 17)
     - #define CLIENT_SHALLOW	(1u << 18)
     - #define HIDDEN_REF	(1u << 19)
     -+#define HIDDEN_REF_FORCE	(1u << 20)
     - 
     --#define ALL_FLAGS (THEY_HAVE | OUR_REF | WANTED | COMMON_KNOWN | SHALLOW | \
     --		NOT_SHALLOW | CLIENT_SHALLOW | HIDDEN_REF)
     -+#define ALL_FLAGS (THEY_HAVE |WANTED | COMMON_KNOWN | SHALLOW | \
     -+		NOT_SHALLOW | CLIENT_SHALLOW)
     - 
     - /* Enum for allowed unadvertised object request (UOR) */
     - enum allow_uor {
     -@@ upload-pack.c: static void receive_needs(struct upload_pack_data *data,
     - 		packet_flush(1);
     - }
     - 
     --/* return non-zero if the ref is hidden, otherwise 0 */
     --static int mark_our_ref(const char *refname, const char *refname_full,
     --			const struct object_id *oid)
     --{
     --	struct object *o = lookup_unknown_object(the_repository, oid);
     --
     --	if (ref_is_hidden(refname, refname_full)) {
     --		o->flags |= HIDDEN_REF;
     --		return 1;
     --	}
     --	o->flags |= OUR_REF;
     --	return 0;
     --}
     --
     - static int check_ref(const char *refname_full, const struct object_id *oid,
     - 		     int flag, void *cb_data)
     - {
     -@@ upload-pack.c: static int parse_want_ref(struct packet_writer *writer, const char *line,
     - 
     - 		strbuf_addf(&refname, "%s%s", get_git_namespace(), refname_nons);
     - 		if (ref_is_hidden(refname_nons, refname.buf) ||
     -+			ref_is_force_hidden(refname_nons, refname.buf) ||
     - 		    read_ref(refname.buf, &oid)) {
     - 			packet_writer_error(writer, "unknown ref %s", refname_nons);
     - 			die("unknown ref %s", refname_nons);
     -@@ upload-pack.c: enum fetch_state {
     - 	FETCH_DONE,
     - };
     - 
     -+static int lazy_load_hidden = 0;
     -+// lazy load hidden refs for protocol V2
     -+void lazy_load_hidden_refs(void) {
     -+	lazy_load_hidden = 1;
     -+}
     -+
     - int upload_pack_v2(struct repository *r, struct packet_reader *request)
     - {
     - 	enum fetch_state state = FETCH_PROCESS_ARGS;
     -@@ upload-pack.c: int upload_pack_v2(struct repository *r, struct packet_reader *request)
     - 				state = FETCH_DONE;
     - 			break;
     - 		case FETCH_SEND_PACK:
     -+			if (lazy_load_hidden) {
     -+				head_ref_namespaced(check_ref, NULL);
     -+				for_each_namespaced_ref(check_ref, NULL);
     -+			}
     -+			if (has_force_hidden_refs())
     -+				check_non_tip(&data);
     - 			send_wanted_ref_info(&data);
     - 			send_shallow_info(&data);
     - 
     -
     - ## upload-pack.h ##
     -@@ upload-pack.h: struct strbuf;
     - int upload_pack_advertise(struct repository *r,
     - 			  struct strbuf *value);
     - 
     -+void lazy_load_hidden_refs(void);
     - #endif /* UPLOAD_PACK_H */
 -:  ----------- > 2:  0df5ecc216d hiderefs: use new flag to mark force hidden refs
 -:  ----------- > 3:  de73f5a6fd9 hiderefs: hornor hide flags in wire protocol V2
 2:  b8a490cb3df ! 4:  fb135cb3bd3 t1419: add test cases for hide-refs hook
     @@ Metadata
      Author: Sun Chao <sunchao9@huawei.com>
      
       ## Commit message ##
     -    t1419: add test cases for hide-refs hook
     +    test: add test cases for hide-refs hook
      
          Add test cases for the new 'hide-refs' hook which is used to
          filter the references during reference discovery phase.
      
          Signed-off-by: Sun Chao <sunchao9@huawei.com>
      
     + ## Makefile ##
     +@@ Makefile: TEST_BUILTINS_OBJS += test-wildmatch.o
     + TEST_BUILTINS_OBJS += test-windows-named-pipe.o
     + TEST_BUILTINS_OBJS += test-write-cache.o
     + TEST_BUILTINS_OBJS += test-xml-encode.o
     ++TEST_BUILTINS_OBJS += test-hide-refs.o
     + 
     + # Do not add more tests here unless they have extra dependencies. Add
     + # them in TEST_BUILTINS_OBJS above.
     +
     + ## t/helper/test-hide-refs.c (new) ##
     +@@
     ++#include "cache.h"
     ++#include "hash.h"
     ++#include "config.h"
     ++#include "connect.h"
     ++#include "parse-options.h"
     ++#include "pkt-line.h"
     ++#include "sigchain.h"
     ++#include "test-tool.h"
     ++
     ++static const char *hide_refs_usage[] = {
     ++	"test-tool hide-refs [<options>...]",
     ++	NULL
     ++};
     ++
     ++static int die_before_read_ref;
     ++static int die_after_proc_ref;
     ++static int version = 1;
     ++static int hash_size = GIT_SHA1_HEXSZ;
     ++static struct string_list hidelist = STRING_LIST_INIT_NODUP;
     ++
     ++static void hide_refs_verison(struct packet_reader *reader) {
     ++	int server_version = 0;
     ++
     ++	for (;;) {
     ++		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
     ++			break;
     ++
     ++		if (reader->pktlen > 8 && starts_with(reader->line, "version=")) {
     ++			server_version = atoi(reader->line+8);
     ++			if (server_version != 1)
     ++				die("bad protocol version: %d", server_version);
     ++		}
     ++	}
     ++
     ++	packet_write_fmt(1, "version=%d\n", version);
     ++	packet_flush(1);
     ++}
     ++
     ++static void hide_refs_proc(struct packet_reader *reader)
     ++{
     ++	const char *p;
     ++	struct strbuf buf = STRBUF_INIT;
     ++	enum packet_read_status status;
     ++
     ++	if (die_before_read_ref)
     ++		die("die with the --die-before-read-ref option");
     ++
     ++	for (;;) {
     ++		status = packet_reader_read(reader);
     ++		if (status == PACKET_READ_EOF)
     ++			exit(0);
     ++
     ++		if (status != PACKET_READ_NORMAL)
     ++			break;
     ++
     ++		p = reader->line;
     ++		strbuf_reset(&buf);
     ++		strbuf_addstr(&buf, reader->line);
     ++	}
     ++
     ++	p = strchr(buf.buf, ':');
     ++	if (unsorted_string_list_has_string(&hidelist, p + 1)) {
     ++		packet_write_fmt(1, "hide");
     ++	}
     ++
     ++	if (die_after_proc_ref)
     ++		die("die with the --die-after-proc-refs option");
     ++
     ++	packet_flush(1);
     ++}
     ++
     ++int cmd__hide_refs(int argc, const char **argv) {
     ++	int nongit_ok = 0;
     ++	struct packet_reader reader;
     ++	const char *value = NULL;
     ++	struct option options[] = {
     ++		OPT_BOOL(0, "die-before-read-ref", &die_before_read_ref,
     ++			 "die when reading first reference"),
     ++		OPT_BOOL(0, "die-after-proc-refs", &die_after_proc_ref,
     ++			 "die after proc ref"),
     ++		OPT_STRING_LIST('H', "hide", &hidelist, "refs-to-force-hidden",
     ++				"refs that will be force hidden"),
     ++		OPT_INTEGER('V', "version", &version,
     ++			    "use this protocol version number"),
     ++		OPT_END()
     ++	};
     ++
     ++	setup_git_directory_gently(&nongit_ok);
     ++
     ++	argc = parse_options(argc, argv, "test-tools", options, hide_refs_usage, 0);
     ++	if (argc > 0)
     ++		usage_msg_opt("Too many arguments.", hide_refs_usage, options);
     ++
     ++	packet_reader_init(&reader, 0, NULL, 0, PACKET_READ_CHOMP_NEWLINE | PACKET_READ_GENTLE_ON_EOF);
     ++
     ++	if (!git_config_get_value("extensions.objectformat", &value)) {
     ++		if (!strcmp(value, "sha256"))
     ++			hash_size = GIT_SHA256_HEXSZ;
     ++	}
     ++
     ++	hide_refs_verison(&reader);
     ++	for (;;) {
     ++		hide_refs_proc(&reader);
     ++	}
     ++
     ++	return 0;
     ++}
     +
     + ## t/helper/test-tool.c ##
     +@@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
     + 	{ "regex", cmd__regex },
     + 	{ "repository", cmd__repository },
     + 	{ "revision-walking", cmd__revision_walking },
     ++	{ "hide-refs", cmd__hide_refs },
     + 	{ "run-command", cmd__run_command },
     + 	{ "scrap-cache-tree", cmd__scrap_cache_tree },
     + 	{ "serve-v2", cmd__serve_v2 },
     +
     + ## t/helper/test-tool.h ##
     +@@ t/helper/test-tool.h: int cmd__reftable(int argc, const char **argv);
     + int cmd__regex(int argc, const char **argv);
     + int cmd__repository(int argc, const char **argv);
     + int cmd__revision_walking(int argc, const char **argv);
     ++int cmd__hide_refs(int argc, const char **argv);
     + int cmd__run_command(int argc, const char **argv);
     + int cmd__scrap_cache_tree(int argc, const char **argv);
     + int cmd__serve_v2(int argc, const char **argv);
     +
       ## t/t1419-hide-refs-hook.sh (new) ##
      @@
      +#!/bin/sh
     @@ t/t1419-hide-refs-hook.sh (new)
      +
      +test_description='Test hide-refs hook'
      +
     -+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     -+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     -+
      +. ./test-lib.sh
     -+
      +. "$TEST_DIRECTORY"/t1419/common-functions.sh
      +
     -+setup_bare_repo_and_work_repo () {
     -+	# Refs of bare_repo : main(A)
     -+	# Refs of work_repo: main(A)  tags/v123
     ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
     ++export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     ++
     ++setup_test_repos () {
      +	test_expect_success "setup bare_repo and work_repo" '
     -+		rm -rf bare_repo.git bare_repo.git.dump &&
     -+		rm -rf work_repo work_repo.dump &&
     ++		rm -rf bare_repo.git &&
     ++		rm -rf work_repo &&
      +		git init --bare bare_repo.git &&
      +		git init work_repo &&
     ++
     ++		# create new commits and references
      +		create_commits_in work_repo A B C D &&
      +		(
      +			cd work_repo &&
      +			git config --local core.abbrev 7 &&
     -+			git remote add origin ../bare_repo.git &&
     -+			git update-ref refs/heads/dev $A &&
     -+			git update-ref refs/heads/main $B &&
     ++			git update-ref refs/heads/main $A &&
     ++			git update-ref refs/heads/dev $B &&
      +			git update-ref refs/pull-requests/1/head $C &&
      +			git tag -m "v123" v123 $D &&
     -+			git push origin +refs/heads/*:refs/heads/* &&
     -+			git push origin +refs/tags/*:refs/tags/* &&
     -+			git push origin +refs/pull-requests/*:refs/pull-requests/*
     ++			git push ../bare_repo.git +refs/heads/*:refs/heads/* &&
     ++			git push ../bare_repo.git +refs/tags/*:refs/tags/* &&
     ++			git push ../bare_repo.git +refs/pull-requests/*:refs/pull-requests/*
      +		) &&
      +		TAG=$(git -C work_repo rev-parse v123) &&
      +
     -+		# setup pre-receive hook
     -+		write_script bare_repo.git/hooks/pre-receive <<-\EOF &&
     -+		exec >&2
     -+		echo "# pre-receive hook"
     -+		while read old new ref
     -+		do
     -+			echo "pre-receive< $old $new $ref"
     -+		done
     -+		EOF
     -+
     -+		# setup update hook
     -+		write_script bare_repo.git/hooks/update <<-\EOF &&
     -+		exec >&2
     -+		echo "# update hook"
     -+		echo "update< $@"
     -+		EOF
     -+
     -+		# setup post-receive hook
     -+		write_script bare_repo.git/hooks/post-receive <<-\EOF
     -+		exec >&2
     -+		echo "# post-receive hook"
     -+		while read old new ref
     -+		do
     -+			echo "post-receive< $old $new $ref"
     -+		done
     -+		EOF
     ++		# config transfer.hiderefs values with "hook:" prefix
     ++		(
     ++			git -C bare_repo.git config --local http.receivepack true &&
     ++			git -C bare_repo.git config --add transfer.hiderefs hook:HEAD &&
     ++			git -C bare_repo.git config --add transfer.hiderefs hook:refs
     ++		)
      +	'
      +}
      +
     -+run_hide_refs_hook_tests() {
     -+	case $1 in
     -+		http)
     -+			PROTOCOL="HTTP protocol"
     -+			BAREREPO_GIT_DIR="$HTTPD_DOCUMENT_ROOT_PATH/bare_repo.git"
     -+			BAREREPO_PREFIX="$HTTPD_URL"/smart
     -+			;;
     -+		local)
     -+			PROTOCOL="builtin protocol"
     -+			BAREREPO_GIT_DIR="$(pwd)/bare_repo.git"
     -+			BAREREPO_PREFIX="$(pwd)"
     -+			;;
     -+	esac
     -+
     -+	BAREREPO_URL="$BAREREPO_PREFIX/bare_repo.git"
     -+
     -+	GIT_TEST_PROTOCOL_VERSION=$2
     -+
     -+	# Run test cases for 'hide-refs' hook
     -+	for t in  "$TEST_DIRECTORY"/t1419/test-*.sh
     ++setup_httpd() {
     ++	ROOT_PATH="$PWD"
     ++	. "$TEST_DIRECTORY"/lib-gpg.sh
     ++	. "$TEST_DIRECTORY"/lib-httpd.sh
     ++	. "$TEST_DIRECTORY"/lib-terminal.sh
     ++
     ++	start_httpd
     ++	set_askpass user@host pass@host
     ++	setup_askpass_helper
     ++}
     ++
     ++# Run test cases when hide-refs hook exit abnormally
     ++run_tests_for_abnormal_hook() {
     ++	GIT_TEST_PROTOCOL_VERSION=$1
     ++	BAREREPO_GIT_DIR="$(pwd)/bare_repo.git"
     ++
     ++	for t in  "$TEST_DIRECTORY"/t1419/abnormal-*.sh
      +	do
     -+		# Initialize the bare_repo repository and work_repo
     -+		setup_bare_repo_and_work_repo
     -+		git -C work_repo remote set-url origin "$BAREREPO_URL"
     -+		cp -rf work_repo work_repo.dump
     -+
     -+		git -C bare_repo.git config --local http.receivepack true
     -+		git -C bare_repo.git config --add transfer.hiderefs force:HEAD
     -+		git -C bare_repo.git config --add transfer.hiderefs force:refs
     -+		cp -rf bare_repo.git bare_repo.git.dump
     -+
     -+		if test "$1" = "http"; then
     -+			setup_askpass_helper
     -+			rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/bare_repo.git"
     -+			mv bare_repo.git "$HTTPD_DOCUMENT_ROOT_PATH/bare_repo.git"
     -+		fi
     ++		setup_test_repos
      +
      +		. "$t"
      +	done
      +}
      +
     ++# Run test cases under local/HTTP protocol
     ++run_tests_for_normal_hook() {
     ++	for t in  "$TEST_DIRECTORY"/t1419/test-*.sh
     ++	do
     ++		setup_test_repos
     ++		case $1 in
     ++			http)
     ++				PROTOCOL="HTTP protocol"
     ++
     ++				# bare_repo.git need move to httpd sever root path
     ++				BAREREPO_GIT_DIR="$HTTPD_DOCUMENT_ROOT_PATH/bare_repo.git"
     ++				rm -rf "$BAREREPO_GIT_DIR"
     ++				mv bare_repo.git "$BAREREPO_GIT_DIR"
     ++
     ++				# setup the repository service URL address of http protocol
     ++				BAREREPO_PREFIX="$HTTPD_URL"/smart
     ++				BAREREPO_URL="$BAREREPO_PREFIX/bare_repo.git"
     ++				;;
     ++			local)
     ++				PROTOCOL="builtin protocol"
     ++				BAREREPO_GIT_DIR="$(pwd)/bare_repo.git"
     ++
     ++				# setup the repository service address of builtin protocol
     ++				BAREREPO_PREFIX="$(pwd)"
     ++				BAREREPO_URL="$BAREREPO_PREFIX/bare_repo.git"
     ++				;;
     ++		esac
     ++
     ++		GIT_TEST_PROTOCOL_VERSION=$2
     ++		git -C work_repo remote add origin "$BAREREPO_URL"
      +
     -+setup_bare_repo_and_work_repo
     -+BAREREPO_GIT_DIR="$(pwd)/bare_repo.git"
     -+BAREREPO_PREFIX="$(pwd)"
     -+BAREREPO_URL="$BAREREPO_PREFIX/bare_repo.git"
     -+
     -+# Load test cases that only need to be executed once.
     -+for t in  "$TEST_DIRECTORY"/t1419/once-*.sh
     -+do
     -+	git -C "$BAREREPO_GIT_DIR" config --add transfer.hiderefs force:HEAD
     -+	git -C "$BAREREPO_GIT_DIR" config --add transfer.hiderefs force:refs
     -+	. "$t"
     -+done
     ++		. "$t"
     ++	done
     ++}
      +
     ++setup_httpd
      +for protocol in 1 2
      +do
     -+	# Run test cases for 'hide-refs' hook on local file protocol.
     -+	run_hide_refs_hook_tests local $protocol
     ++	run_tests_for_abnormal_hook $protocol
     ++	run_tests_for_normal_hook local $protocol
     ++	run_tests_for_normal_hook http $protocol
      +done
      +
     -+ROOT_PATH="$PWD"
     -+. "$TEST_DIRECTORY"/lib-gpg.sh
     -+. "$TEST_DIRECTORY"/lib-httpd.sh
     -+. "$TEST_DIRECTORY"/lib-terminal.sh
     ++test_done
     +
     + ## t/t1419/abnormal-hide-refs-hook.sh (new) ##
     +@@
     ++#!/bin/sh
      +
     -+start_httpd
     -+set_askpass user@host pass@host
     ++# Upstream repository (bare_repo.git) contains the configurations:
     ++#
     ++#	[transfer]
     ++#		hiderefs = hook:HEAD
     ++#		hiderefs = hook:refs
     ++#
     ++# During refs advertise phase the hide-refs hook will be invoked and each ref will be checked by it,
     ++# we should make sure Git works correctly in some speicail cases
     ++
     ++# If hide-refs not exists, Git should not invoke it and continue advertise all the refs
     ++test_expect_success "protocol $GIT_TEST_PROTOCOL_VERSION: advertise-refs while hide-refs hook not exists" '
     ++	rm -f "$BAREREPO_GIT_DIR/hooks/hide-refs" &&
     ++	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION upload-pack --advertise-refs "$BAREREPO_GIT_DIR" >out 2>&1 &&
     ++	cat out | make_user_friendly_and_stable_output >actual &&
     ++	format_and_save_expect <<-EOF &&
     ++		<COMMIT-A> HEAD
     ++		<COMMIT-B> refs/heads/dev
     ++		<COMMIT-A> refs/heads/main
     ++		<COMMIT-C> refs/pull-requests/1/head
     ++		<COMMIT-TAG-v123> refs/tags/v123
     ++		<COMMIT-D> refs/tags/v123^{}
     ++	EOF
     ++	test_cmp expect actual
     ++'
      +
     -+# Run test cases for 'hide-refs' hook on HTTP protocol.
     -+for protocol in 1 2
     -+do
     -+	run_hide_refs_hook_tests http $protocol
     -+done
     ++# If hide-refs hook run with incompatible version, Git should not invoke it and continue to advertise all the refs
     ++test_expect_success "protocol $GIT_TEST_PROTOCOL_VERSION: advertise-refs while hide-refs hook run with incompatible version" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
     ++		test-tool hide-refs --version=2
     ++	EOF
     ++	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION upload-pack --advertise-refs "$BAREREPO_GIT_DIR" >out 2>&1 &&
     ++	cat out | make_user_friendly_and_stable_output >actual &&
     ++	format_and_save_expect <<-EOF &&
     ++		<COMMIT-A> HEAD
     ++		<COMMIT-B> refs/heads/dev
     ++		<COMMIT-A> refs/heads/main
     ++		<COMMIT-C> refs/pull-requests/1/head
     ++		<COMMIT-TAG-v123> refs/tags/v123
     ++		<COMMIT-D> refs/tags/v123^{}
     ++	EOF
     ++	test_cmp expect actual
     ++'
      +
     -+test_done
     ++# If hide-refs hook exit before processing any refs, Git should not die and continue to advertise all the refs
     ++test_expect_success "protocol $GIT_TEST_PROTOCOL_VERSION: advertise-refs while hide-refs hook die before read ref" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
     ++		test-tool hide-refs --die-before-read-ref
     ++	EOF
     ++	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION upload-pack --advertise-refs "$BAREREPO_GIT_DIR" >out 2>&1 &&
     ++	cat out | make_user_friendly_and_stable_output | grep -v "^error:" >actual &&
     ++	format_and_save_expect <<-EOF &&
     ++		fatal: die with the --die-before-read-ref option
     ++		<COMMIT-A> HEAD
     ++		<COMMIT-B> refs/heads/dev
     ++		<COMMIT-A> refs/heads/main
     ++		<COMMIT-C> refs/pull-requests/1/head
     ++		<COMMIT-TAG-v123> refs/tags/v123
     ++		<COMMIT-D> refs/tags/v123^{}
     ++	EOF
     ++	test_cmp expect actual
     ++'
     ++
     ++# If hide-refs hook exit abnormally, Git should not die and continue to advertise left refs
     ++test_expect_success "protocol $GIT_TEST_PROTOCOL_VERSION: advertise-refs while hide-refs hook die after proc ref" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
     ++		test-tool hide-refs --die-after-proc-refs
     ++	EOF
     ++	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION upload-pack --advertise-refs "$BAREREPO_GIT_DIR" >out 2>&1 &&
     ++	cat out | make_user_friendly_and_stable_output | grep -v "^error:" >actual &&
     ++	format_and_save_expect <<-EOF &&
     ++		fatal: die with the --die-after-proc-refs option
     ++		<COMMIT-A> HEAD
     ++		<COMMIT-B> refs/heads/dev
     ++		<COMMIT-A> refs/heads/main
     ++		<COMMIT-C> refs/pull-requests/1/head
     ++		<COMMIT-TAG-v123> refs/tags/v123
     ++		<COMMIT-D> refs/tags/v123^{}
     ++	EOF
     ++	test_cmp expect actual
     ++'
      
       ## t/t1419/common-functions.sh (new) ##
      @@
     @@ t/t1419/common-functions.sh (new)
      +	fi
      +}
      +
     -+# Format the output of git-push, git-show-ref and other commands to make a
     ++# Format the output of git-fetch, git-ls-remote and other commands to make a
      +# user-friendly and stable text.  We can easily prepare the expect text
      +# without having to worry about changes of the commit ID (full or abbrev.)
      +# of the output.  Single quotes are replaced with double quotes, because
     -+# it is boring to prepare unquoted single quotes in expect text.  We also
     -+# remove some locale error messages. The emitted human-readable errors are
     -+# redundant to the more machine-readable output the tests already assert.
     ++# it is boring to prepare unquoted single quotes in expect text.
      +make_user_friendly_and_stable_output () {
      +	tr '\0' '@' | sed \
      +		-e "s/'/\"/g" \
     @@ t/t1419/common-functions.sh (new)
      +		-e "s/$(get_abbrev_oid $D)[0-9a-f]*/<COMMIT-D>/g" \
      +		-e "s/$(get_abbrev_oid $TAG)[0-9a-f]*/<COMMIT-TAG-v123>/g" \
      +		-e "s/$ZERO_OID/<ZERO-OID>/g" \
     -+		-e "s#$TRASH_DIRECTORY/bare_repo.git#<URL/of/bare_repo.git>#" \
     -+		-e "s#$BAREREPO_PREFIX/bare_repo.git#<URL/of/bare_repo.git>#"
     ++		-e "s#$BAREREPO_PREFIX/bare_repo.git#<URL/of/bare_repo.git>#" \
     ++		-e 's/^[0-9a-f]\{4\}//g'
     ++
      +}
      +
      +filter_out_hide_refs_output() {
      +	make_user_friendly_and_stable_output | sed 's/^[0-9a-f]\{4\}//g'
      +}
      +
     -+filter_out_user_friendly_and_stable_output () {
     -+	make_user_friendly_and_stable_output |
     -+		sed -n ${1+"$@"}
     -+}
     -+
      +format_and_save_expect () {
      +	sed -e 's/^> //' -e 's/Z$//' >expect
      +}
     @@ t/t1419/common-functions.sh (new)
      +	test_cmp show-ref.expect show-ref.filtered
      +}
      
     - ## t/t1419/once-0000-abnormal-hide-refs-hook.sh (new) ##
     -@@
     -+test_expect_success "builtin protocol (protocol: 1): setup hide-refs hook which die when read version" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     -+		test-tool hide-refs \
     -+			--die-read-version \
     -+			-r refs/heads/main
     -+	EOF
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while hide-refs hook die when read version" '
     -+	test_must_fail git -c protocol.version=1 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
     -+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		fatal: die with the --die-read-version option
     -+		fatal: can not read version message from hook hide-refs
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 1): setup hide-refs hook which die when write version" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     -+		test-tool hide-refs --die-write-version
     -+	EOF
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while hide-refs hook die when write version" '
     -+	test_must_fail git -c protocol.version=1 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
     -+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		fatal: die with the --die-write-version option
     -+		fatal: can not read version message from hook hide-refs
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 1): setup hide-refs hook which die when read first filter request" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     -+		test-tool hide-refs --die-read-first-ref
     -+	EOF
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while hide-refs hook die when read first filter request" '
     -+	test_must_fail git -c protocol.version=1 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
     -+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		fatal: die with the --die-read-first-ref option
     -+		fatal: hook hide-refs died abnormally
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 1): setup hide-refs hook which die when read second filter request" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     -+		test-tool hide-refs --die-read-second-ref
     -+	EOF
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while hide-refs hook die when read second filter request" '
     -+	test_must_fail git -c protocol.version=1 upload-pack --advertise-refs "$BAREREPO_URL"  >out 2>&1 &&
     -+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		fatal: die with the --die-read-second-ref option
     -+		fatal: hook hide-refs died abnormally
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 1): setup hide-refs hook which die while filtring refs" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     -+		test-tool hide-refs --die-after-proc-refs
     -+	EOF
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 1): upload-pack --advertise-refs while hide-refs hook die while filtring refs" '
     -+	test_must_fail git -c protocol.version=1 upload-pack --advertise-refs "$BAREREPO_URL"  >out 2>&1 &&
     -+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		fatal: die with the --die-after-proc-refs option
     -+		fatal: hook hide-refs died abnormally
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 2): setup hide-refs hook which die when read version" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     -+		test-tool hide-refs --die-read-version
     -+	EOF
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while hide-refs hook die when read version" '
     -+	test_must_fail git -c protocol.version=2 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
     -+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		fatal: die with the --die-read-version option
     -+		fatal: can not read version message from hook hide-refs
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 2): setup hide-refs hook which die when write version" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     -+		test-tool hide-refs --die-write-version
     -+	EOF
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while hide-refs hook die when write version" '
     -+	test_must_fail git -c protocol.version=2 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
     -+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		fatal: die with the --die-write-version option
     -+		fatal: can not read version message from hook hide-refs
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 2): setup hide-refs hook which die when read first filter request" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     -+		test-tool hide-refs --die-read-first-ref
     -+	EOF
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while hide-refs hook die when read first filter request" '
     -+	test_must_fail git -c protocol.version=2 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
     -+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		fatal: die with the --die-read-first-ref option
     -+		fatal: hook hide-refs died abnormally
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 2): setup hide-refs hook which die when read second filter request" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     -+		test-tool hide-refs --die-read-second-ref
     -+	EOF
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while hide-refs hook die when read second filter request" '
     -+	test_must_fail git -c protocol.version=2 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
     -+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		fatal: die with the --die-read-second-ref option
     -+		fatal: hook hide-refs died abnormally
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 2): setup hide-refs hook which die while filtring refs" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     -+		test-tool hide-refs --die-after-proc-refs
     -+	EOF
     -+'
     -+
     -+test_expect_success "builtin protocol (protocol: 2): upload-pack --advertise-refs while hide-refs hook die while filtring refs" '
     -+	test_must_fail git -c protocol.version=2 upload-pack --advertise-refs "$BAREREPO_URL" >out 2>&1 &&
     -+	cat out | grep "fatal: " | make_user_friendly_and_stable_output >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		fatal: die with the --die-after-proc-refs option
     -+		fatal: hook hide-refs died abnormally
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -
       ## t/t1419/test-0001-ls-remote-with-hide-refs-hook.sh (new) ##
      @@
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide no refs" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     -+		test-tool hide-refs
     -+	EOF
     -+'
     ++#!/bin/sh
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote while hide-refs hook hide no refs" '
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION ls-remote "$BAREREPO_URL" >out 2>&1 &&
     -+	make_user_friendly_and_stable_output <out >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		<COMMIT-B>	HEAD
     -+		<COMMIT-A>	refs/heads/dev
     -+		<COMMIT-B>	refs/heads/main
     -+		<COMMIT-C>	refs/pull-requests/1/head
     -+		<COMMIT-TAG-v123>	refs/tags/v123
     -+		<COMMIT-D>	refs/tags/v123^{}
     -+	EOF
     -+	test_cmp expect actual
     -+'
     ++# Upstream repository (bare_repo.git) contains the configurations:
     ++#
     ++#	[transfer]
     ++#		hiderefs = hook:HEAD
     ++#		hiderefs = hook:refs
     ++#
     ++# During refs advertise phase the hide-refs hook will be invoked and each ref will be checked by it
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide all refs" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++# Git will not advertise the refs that are hided by hide-refs hook
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote while hide-refs hook hide part of refs" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
      +	test-tool hide-refs \
     -+		-r "HEAD" \
     -+		-r "refs/heads/dev" \
     -+		-r "refs/heads/main" \
     -+		-r "refs/pull-requests/1/head" \
     -+		-r "refs/tags/v123"
     ++		-H "refs/pull-requests/1/head" \
     ++		-H "refs/tags/v123"
      +	EOF
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote while hide-refs hook hide all refs" '
      +	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION ls-remote "$BAREREPO_URL" >out 2>&1 &&
      +	make_user_friendly_and_stable_output <out >actual &&
      +	format_and_save_expect <<-EOF &&
     ++		<COMMIT-A>	HEAD
     ++		<COMMIT-B>	refs/heads/dev
     ++		<COMMIT-A>	refs/heads/main
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide branches" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     -+	test-tool hide-refs \
     -+		-r "HEAD" \
     -+		-r "refs/heads/dev" \
     -+		-r "refs/heads/main"
     ++# The hide-ref hook should not change the default effects of [transfer|uploadpack|receive].hiderefs configurations,
     ++# if it hide no refs, the original hiderefs rules should works
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote while hide-refs hook hide no refs" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
     ++		test-tool hide-refs
      +	EOF
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote while hide-refs hook hide branches" '
     ++	git -C "$BAREREPO_GIT_DIR" config --add transfer.hiderefs refs/heads/dev &&
      +	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION ls-remote "$BAREREPO_URL" >out 2>&1 &&
      +	make_user_friendly_and_stable_output <out >actual &&
      +	format_and_save_expect <<-EOF &&
     ++		<COMMIT-A>	HEAD
     ++		<COMMIT-A>	refs/heads/main
      +		<COMMIT-C>	refs/pull-requests/1/head
      +		<COMMIT-TAG-v123>	refs/tags/v123
      +		<COMMIT-D>	refs/tags/v123^{}
      +	EOF
      +	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide pull refs and tags" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     -+	test-tool hide-refs \
     -+		-r "refs/pull-requests/1/head" \
     -+		-r "refs/tags/v123"
     -+	EOF
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote while hide-refs hook hide pull refs and tags" '
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION ls-remote "$BAREREPO_URL" >out 2>&1 &&
     -+	make_user_friendly_and_stable_output <out >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		<COMMIT-B>	HEAD
     -+		<COMMIT-A>	refs/heads/dev
     -+		<COMMIT-B>	refs/heads/main
     -+	EOF
     -+	test_cmp expect actual
      +'
      
       ## t/t1419/test-0002-upload-pack-with-hide-refs-hook.sh (new) ##
      @@
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide no refs" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     -+		test-tool hide-refs
     -+	EOF
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone while hide-refs hook hide no refs" '
     -+	rm -rf local.git &&
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION clone --mirror "$BAREREPO_URL" local.git &&
     -+	git -C local.git show-ref -d >out 2>&1 &&
     -+	make_user_friendly_and_stable_output <out >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		<COMMIT-A> refs/heads/dev
     -+		<COMMIT-B> refs/heads/main
     -+		<COMMIT-C> refs/pull-requests/1/head
     -+		<COMMIT-TAG-v123> refs/tags/v123
     -+		<COMMIT-D> refs/tags/v123^{}
     -+	EOF
     -+	test_cmp expect actual
     -+'
     ++#!/bin/sh
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide all refs" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     -+	test-tool hide-refs \
     -+		-r "HEAD" \
     -+		-r "refs/heads/dev" \
     -+		-r "refs/heads/main" \
     -+		-r "refs/pull-requests/1/head" \
     -+		-r "refs/tags/v123"
     -+	EOF
     -+'
     ++# Upstream repository (bare_repo.git) contains the configurations:
     ++#
     ++#	[transfer]
     ++#		hiderefs = hook:HEAD
     ++#		hiderefs = hook:refs
     ++#
     ++# During refs advertise phase the hide-refs hook will be invoked and each ref will be checked by it
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone while hide-refs hide all refs" '
     ++# Git client can not fetch the refs that are hided by hide-refs hook
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone while hide-refs hide part of refs" '
      +	rm -rf local.git &&
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION clone --mirror "$BAREREPO_URL" local.git &&
     -+	test_must_fail git -C local.git show-ref -d >out 2>&1 &&
     -+	make_user_friendly_and_stable_output <out >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide branches" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
      +	test-tool hide-refs \
     -+		-r "HEAD" \
     -+		-r "refs/heads/dev" \
     -+		-r "refs/heads/main"
     ++		-H "HEAD" \
     ++		-H "refs/heads/dev" \
     ++		-H "refs/heads/main"
      +	EOF
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone branches" '
     -+	rm -rf local.git &&
      +	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION clone --mirror "$BAREREPO_URL" local.git &&
      +	git -C local.git show-ref -d >out 2>&1 &&
      +	make_user_friendly_and_stable_output <out >actual &&
     @@ t/t1419/test-0002-upload-pack-with-hide-refs-hook.sh (new)
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which some branches" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     -+	test-tool hide-refs \
     -+		-r "HEAD" \
     -+		-r "refs/heads/dev"
     -+	EOF
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): fetch a tip commit which is not hidden" '
     -+	rm -rf local.git &&
     -+	git init local.git &&
     -+	git -C local.git remote add origin "$BAREREPO_URL" &&
     -+	git -C local.git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION fetch "$BAREREPO_URL" $B
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): config allowAnySHA1InWant to true" '
     -+	git -C "$BAREREPO_GIT_DIR" config uploadpack.allowTipSHA1InWant true &&
     -+	git -C "$BAREREPO_GIT_DIR" config uploadpack.allowReachableSHA1InWant true
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): fetch a non-tip commit which is not hidden" '
     ++# If a ref is hided by hide-refs hook, its private commits (tip or non-tip) will be force hidden
     ++# to the client, and the client can not fetch such kind of commit even the server set allowTipSHA1InWant
     ++# or allowReachableSHA1InWant to true
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): fetch a commit which is hided by hide-refs hook" '
      +	rm -rf local.git &&
     -+	git init local.git &&
     -+	git -C local.git remote add origin "$BAREREPO_URL" &&
     -+	git -C local.git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION fetch "$BAREREPO_URL" $A
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide pull refs and tags" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
      +	test-tool hide-refs \
     -+		-r "refs/pull-requests/1/head" \
     -+		-r "refs/tags/v123"
     -+	EOF
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone while hide-refs hook hide pull refs and tags" '
     -+	rm -rf local.git &&
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION clone --mirror "$BAREREPO_URL" local.git &&
     -+	git -C local.git show-ref -d >out 2>&1 &&
     -+	make_user_friendly_and_stable_output <out >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		<COMMIT-A> refs/heads/dev
     -+		<COMMIT-B> refs/heads/main
     ++		-H "refs/heads/dev" \
     ++		-H "refs/pull-requests/1/head" \
     ++		-H "refs/tags/v123"
      +	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): config allowAnySHA1InWant to true" '
      +	git -C "$BAREREPO_GIT_DIR" config uploadpack.allowTipSHA1InWant true &&
     -+	git -C "$BAREREPO_GIT_DIR" config uploadpack.allowReachableSHA1InWant true
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): fetch a non-tip commit which is hidden" '
     -+	rm -rf local.git &&
     ++	git -C "$BAREREPO_GIT_DIR" config uploadpack.allowReachableSHA1InWant true &&
      +	git init local.git &&
      +	git -C local.git remote add origin "$BAREREPO_URL" &&
     -+	test_must_fail git -C local.git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION fetch "$BAREREPO_URL" $C
     ++	test_must_fail git -C local.git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION fetch "$BAREREPO_URL" $B
      +'
      
       ## t/t1419/test-0003-receive-pack-with-hide-refs-hook.sh (new) ##
      @@
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide no refs" '
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++#!/bin/sh
     ++
     ++# Upstream repository (bare_repo.git) contains the configurations:
     ++#
     ++#	[transfer]
     ++#		hiderefs = hook:HEAD
     ++#		hiderefs = hook:refs
     ++#
     ++# During refs advertise phase the hide-refs hook will be invoked and each ref will be checked by it
     ++
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main while hide-refs hook does not hide it" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
      +		test-tool hide-refs
      +	EOF
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main while hide-refs hook hide no refs" '
      +	create_commits_in work_repo E &&
      +	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:main >out 2>&1 &&
      +	make_user_friendly_and_stable_output <out >out.tmp &&
      +	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
      +	format_and_save_expect <<-EOF &&
     -+		remote: # pre-receive hook        Z
     -+		remote: pre-receive< <COMMIT-B> <COMMIT-E> refs/heads/main        Z
     -+		remote: # update hook        Z
     -+		remote: update< refs/heads/main <COMMIT-B> <COMMIT-E>        Z
     -+		remote: # post-receive hook        Z
     -+		remote: post-receive< <COMMIT-B> <COMMIT-E> refs/heads/main        Z
      +		To <URL/of/bare_repo.git>
     -+		   <COMMIT-B>..<COMMIT-E>  HEAD -> main
     ++		   <COMMIT-A>..<COMMIT-E>  HEAD -> main
      +	EOF
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): create ref while hide-refs hook hide no refs" '
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:new >out 2>&1 &&
     -+	make_user_friendly_and_stable_output <out >out.tmp &&
     -+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		remote: # pre-receive hook        Z
     -+		remote: pre-receive< <ZERO-OID> <COMMIT-E> refs/heads/new        Z
     -+		remote: # update hook        Z
     -+		remote: update< refs/heads/new <ZERO-OID> <COMMIT-E>        Z
     -+		remote: # post-receive hook        Z
     -+		remote: post-receive< <ZERO-OID> <COMMIT-E> refs/heads/new        Z
     -+		To <URL/of/bare_repo.git>
     -+		 * [new branch]      HEAD -> new
     -+		EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to delete ref while hide-refs hook hide no refs" '
     -+	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin :dev >out 2>&1 &&
     -+	make_user_friendly_and_stable_output <out >out.tmp &&
     -+	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
     -+	format_and_save_expect <<-EOF &&
     -+		remote: # pre-receive hook        Z
     -+		remote: pre-receive< <COMMIT-A> <ZERO-OID> refs/heads/dev        Z
     -+		remote: # update hook        Z
     -+		remote: update< refs/heads/dev <COMMIT-A> <ZERO-OID>        Z
     -+		remote: # post-receive hook        Z
     -+		remote: post-receive< <COMMIT-A> <ZERO-OID> refs/heads/dev        Z
     -+		To <URL/of/bare_repo.git>
     -+		 - [deleted]         dev
     -+	EOF
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): setup hide-refs hook which hide all refs" '
     -+	rm -rf work_repo &&
     -+	cp -rf work_repo.dump work_repo &&
     -+	rm -rf "$BAREREPO_GIT_DIR" &&
     -+	cp -rf bare_repo.git.dump "$BAREREPO_GIT_DIR" &&
     -+	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF
     ++# If hide-refs hook hide some ref, git push will be rejected
     ++test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main while hide-refs hook hide it" '
     ++	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
      +	test-tool hide-refs \
     -+		-r "HEAD" \
     -+		-r "refs/heads/dev" \
     -+		-r "refs/heads/main" \
     -+		-r "refs/pull-requests/1/head" \
     -+		-r "refs/tags/v123"
     ++		-H "refs/heads/main"
      +	EOF
     -+'
     -+
     -+test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main while hide-refs hook hide all refs" '
     -+	create_commits_in work_repo E &&
     ++	create_commits_in work_repo F &&
      +	test_must_fail git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION -C work_repo push origin HEAD:main >out 2>&1 &&
      +	make_user_friendly_and_stable_output <out >out.tmp &&
      +	sed "s/$(get_abbrev_oid $E)[0-9a-f]*/<COMMIT-E>/g" <out.tmp >actual &&
      +	format_and_save_expect <<-EOF &&
     -+		remote: # pre-receive hook        Z
     -+		remote: pre-receive< <ZERO-OID> <COMMIT-E> refs/heads/main        Z
      +		To <URL/of/bare_repo.git>
      +		 ! [remote rejected] HEAD -> main (deny updating a hidden ref)
      +		error: failed to push some refs to "<URL/of/bare_repo.git>"
 3:  8c5ae78de47 ! 5:  8a5f7762c27 doc: add documentation for the hide-refs hook
     @@
       ## Metadata ##
     -Author: Sun Chao <16657101987@163.com>
     +Author: Sun Chao <sunchao9@huawei.com>
      
       ## Commit message ##
          doc: add documentation for the hide-refs hook
      
     -    "git upload-pack" or "git receive-pack" can use "hide-refs"
     -    hook to filter the references during reference discovery phase.
     +    If uploadpack.allowTipSHA1InWant or
     +    uploadpack.allowReachableSHA1InWant are set to true, the private
     +    commits of hide refs can be fetched by client. The new "hide-refs"
     +    hook are used to hide our refs and we wish to hide the private
     +    commits either.
     +
     +    "git upload-pack" or "git receive-pack" can use "hide-refs" hook to
     +    filter the references during reference discovery phase. If a ref is
     +    hided by "hide-refs" hook, its private data cannot be fetched by
     +    client even if uploadpack.allowTipSHA1InWant or
     +    uploadpack.allowReachableSHA1InWant are set to true.
      
          Signed-off-by: Sun Chao <sunchao9@huawei.com>
      
     @@ Documentation/githooks.txt: If this hook exits with a non-zero status, `git push
      +hook. In the following example, the letter 'G' stands for 'git-receive-pack'
      +or 'git-upload-pack' and the letter 'H' stands for this hook. The hook
      +decides if the reference will be hidden or not, it sends result back in
     -+pkt-line format protocol, a response "hide" the references will hide
     -+to the client and can not fetch it even in protocol V2.
     ++pkt-line format protocol, a response "hide" the references will hidden
     ++to the client.
      +
      +	# Version negotiation
      +	G: PKT-LINE(version=1\0uploadpack)
     @@ Documentation/githooks.txt: If this hook exits with a non-zero status, `git push
      +	# Case 2: this reference can be advertised
      +	H: flush-pkt
      +
     -+To enable the `hide-refs` hook, we should config hiderefs with `force:`
     ++To enable the `hide-refs` hook, we should config hiderefs with `hook:`
      +option, eg:
      +
     -+	git config --add transfer.hiderefs force:refs/prefix1/
     -+	git config --add uploadpack.hiderefs force:!refs/prefix2/
     ++	git config --add transfer.hiderefs hook:refs/prefix1/
     ++	git config --add uploadpack.hiderefs hook:!refs/prefix2/
      +
      +the `hide-refs` will be called during reference discovery phase and
      +check each matched reference, a 'hide' response means the reference will

-- 
gitgitgadget
