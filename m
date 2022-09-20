Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE25C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 08:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiITIZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 04:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiITIZO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 04:25:14 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0D51A800
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 01:22:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e16so2984416wrx.7
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 01:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=Hdp2zP4olAgMQinHGW0x3eUDKl9StDJHnEn/uqMAcmg=;
        b=TM6CRML8QR4ZL91SpNzQmhuSlBXKa+mgp796JXvc+SE8TWeXitiAyWAHvlCCVew99m
         80WcMVIP+tXPPCNZKdGUc7H1uO2tEhj2DGfNviZcXMgt4UVyfUfe4gEkY7WkHpouwFJS
         rH6Ztylyip9hxVO/B0iZmYFIoaNJe/Ddlh2uFbv8sgj+FIxWyI6JCTOrlJoUPW211e3V
         EcQpyNlBUMPmeBgs85aaCCQCheltsMbzHQBZ7MTLo/yhPcQ0vT+IBnw9bTCLUGrZ4pIx
         P8NZcmIFWikVXtVdHB84FvqU2cYhJscd4xPHanQXARuqPqcvlcswQr0Njd3HnP+68C+c
         7rPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Hdp2zP4olAgMQinHGW0x3eUDKl9StDJHnEn/uqMAcmg=;
        b=WnGc+BXC4UwW5NguOLGwViKSgfWDhBClZE/AgtEnaJrCEvGtZUjdenk5XvfybxZKbs
         8aS7I8leH/ve/fb8ORMKy3JJ+jcZUhw7apmYDvPWV6BBMpdxS4UDwLlUhv6NYiUHVE6X
         4egUU0kJnGUyvpdevGgQQDqMb4Fel1bhIZe5yIQlVy3LYnVOXyetrMz3eZA1OZ711j6w
         3BuPW3lTldqaASvwS0gSmyHWeLHDMZCDl1jc1DGWgp3yR/lsGmJVis0/eXTt1lzLOwkT
         kA0+NMCXYmrfrB9KjPMjeuux0tcxUljlbuOJwoHnB1pTGP008xEtGE0/jynfT1HtJEfp
         l5qQ==
X-Gm-Message-State: ACrzQf07RTVZ5CRWqxjRhe/GqzhZjHnWO46VRJYBK2ZBmJf8iW8UOO+z
        qD6BAS3GQZe26cAd/rAGWkqavIAp4wI=
X-Google-Smtp-Source: AMsMyM6sNBVmmSzpMln4/aa7+8dE0+gl6Bq6p7S/H+RS7wZK8qL+m/NNPv24tEzVJjLmOyOx6xspPw==
X-Received: by 2002:a5d:648b:0:b0:22a:d169:6fba with SMTP id o11-20020a5d648b000000b0022ad1696fbamr12541370wri.447.1663662168884;
        Tue, 20 Sep 2022 01:22:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d64e3000000b002205a5de337sm1044588wri.102.2022.09.20.01.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 01:22:48 -0700 (PDT)
Message-Id: <pull.1301.v6.git.git.1663662167.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
References: <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Sep 2022 08:22:42 +0000
Subject: [PATCH v6 0/5] hiderefs: add hide-refs hook to hide refs dynamically
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
            "ref":"refs/heads/stable/secret_feature",
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
e.g. if we want to pass all the refs to the new hook except for the tags:

git config --add transfer.hiderefs hook:
git config --add transfer.hiderefs hook:!refs/tags/


the hide-refs will be called during reference discovery phase and check each
matched reference, a 'hide' response means the reference will be hidden for
its private data even if allowTipSHA1InWant or allowReachableSHA1InWant are
set to true.

Sun Chao (5):
  hiderefs: add hide-refs hook to hide refs dynamically
  hiderefs: use a new flag to mark force hidden refs
  hiderefs: hornor hide flags in wire protocol V2
  test: add test cases for hide-refs hook
  doc: add documentation for the hide-refs hook

 Documentation/githooks.txt                    |  49 +++
 Makefile                                      |   1 +
 ls-refs.c                                     |   2 +-
 refs.c                                        | 309 ++++++++++++++++--
 refs.h                                        |   7 +
 t/helper/test-hide-refs.c                     | 107 ++++++
 t/helper/test-tool.c                          |   1 +
 t/helper/test-tool.h                          |   1 +
 t/t1419-hide-refs-hook.sh                     | 111 +++++++
 t/t1419/abnormal-hide-refs-hook.sh            |  80 +++++
 t/t1419/common-functions.sh                   |  74 +++++
 ...test-0001-ls-remote-with-hide-refs-hook.sh |  43 +++
 ...st-0002-upload-pack-with-hide-refs-hook.sh |  45 +++
 ...t-0003-receive-pack-with-hide-refs-hook.sh |  40 +++
 upload-pack.c                                 |  25 +-
 15 files changed, 856 insertions(+), 39 deletions(-)
 create mode 100644 t/helper/test-hide-refs.c
 create mode 100755 t/t1419-hide-refs-hook.sh
 create mode 100644 t/t1419/abnormal-hide-refs-hook.sh
 create mode 100644 t/t1419/common-functions.sh
 create mode 100644 t/t1419/test-0001-ls-remote-with-hide-refs-hook.sh
 create mode 100644 t/t1419/test-0002-upload-pack-with-hide-refs-hook.sh
 create mode 100644 t/t1419/test-0003-receive-pack-with-hide-refs-hook.sh


base-commit: 79f2338b3746d23454308648b2491e5beba4beff
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1301%2Fsunchao9%2Frefs_advertise-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1301/sunchao9/refs_advertise-v6
Pull-Request: https://github.com/git/git/pull/1301

Range-diff vs v5:

 1:  278bd185aec ! 1:  99402c1b89f hiderefs: add hide-refs hook to hide refs dynamically
     @@ Metadata
       ## Commit message ##
          hiderefs: add hide-refs hook to hide refs dynamically
      
     -    Gerrit is implemented by JGit and is known as a centralized workflow system
     -    which supports reference-level access control for repository. If we choose
     -    to work in centralized workflow like what Gerrit provided, reference-level
     -    access control is needed and we might add a reference filter hook
     -    `hide-refs` to hide the private data.
     +    Muti-branch workflows are used in some development scenarios, especially
     +    for large teams, where different small teams are assigned to implement
     +    different features on different branches or to develop secret features
     +    on special branches.
     +
     +    If we can control the visible reference list based on developer
     +    permissions, we can reduce the interference between reference lists of
     +    different teams, and can achieve the protection of critical core code
     +    (only certain team members can see it before making it public). This
     +    kind of reference management makes sense, and on some platforms, sunch
     +    as Gerrit implement it through server-side reference access control.
     +
     +    We can use '{transfer,uploadpack,receive}.hiderefs' config items to
     +    control which references need to hide from clients, but the config items
     +    are static and cannot satisfy the above requirements. We need the Git
     +    server to hide references according to the user's permissions, we can
     +    try to implement this mechanism by introducing a server-side hook
     +    'hide-refs' to dynamically hide references during reference discovery
     +    phase.
      
          This hook would be invoked by 'git-receive-pack' and 'git-upload-pack'
          during the reference discovery phase, each reference will be filtered
     @@ Commit message
      
          During reference discovery phase, each reference will be filtered by this
          hook. In the following example, the letter 'G' stands for 'git-receive-pack'
     -    or 'git-upload-pack' and the letter 'H' stands for this hook. The hook
     -    decides if the reference will be hidden or not, it sends result back in
     -    pkt-line format protocol, a response "hide" means the references will be
     -    hidden to the client.
     +    or 'git-upload-pack', and the letter 'H' stands for this hook. The hook
     +    decides if the reference will be hidden or not, and it sends the result
     +    back in pkt-line format protocol, a response "hide" means the references
     +    will be hidden to the client.
      
                  # Version negotiation
                  G: PKT-LINE(version=1\0uploadpack)
     @@ Commit message
                  H: flush-pkt
      
          To enable the `hide-refs` hook, we should config hiderefs with `hook:`
     -    option, eg:
     +    option, e.g. if we want to pass all the refs to the new hook except for
     +    the tags:
      
     -            git config --add transfer.hiderefs hook:refs/prefix1/
     -            git config --add uploadpack.hiderefs hook:!refs/prefix2/
     +            git config --add transfer.hiderefs hook:
     +            git config --add transfer.hiderefs hook:!refs/tags/
      
          Signed-off-by: Sun Chao <sunchao9@huawei.com>
      
     @@ refs.c: char *shorten_unambiguous_ref(const char *refname, int strict)
       
       int parse_hide_refs_config(const char *var, const char *value, const char *section)
       {
     ++	struct string_list **refs_list= &hide_refs;
       	const char *key;
     -+	int hook = 0;
     +-	if (!strcmp("transfer.hiderefs", var) ||
     +-	    (!parse_config_key(var, section, NULL, NULL, &key) &&
     +-	     !strcmp(key, "hiderefs"))) {
     +-		char *ref;
     +-		int len;
     +-
     +-		if (!value)
     +-			return config_error_nonbool(var);
     +-		ref = xstrdup(value);
     +-		len = strlen(ref);
     +-		while (len && ref[len - 1] == '/')
     +-			ref[--len] = '\0';
     +-		if (!hide_refs) {
     +-			CALLOC_ARRAY(hide_refs, 1);
     +-			hide_refs->strdup_strings = 1;
     ++	char *ref;
     ++	int len;
      +
     - 	if (!strcmp("transfer.hiderefs", var) ||
     - 	    (!parse_config_key(var, section, NULL, NULL, &key) &&
     - 	     !strcmp(key, "hiderefs"))) {
     -@@ refs.c: int parse_hide_refs_config(const char *var, const char *value, const char *secti
     - 
     - 		if (!value)
     - 			return config_error_nonbool(var);
     ++	if (strcmp("transfer.hiderefs", var) &&
     ++	    !(!parse_config_key(var, section, NULL, NULL, &key) &&
     ++	      !strcmp(key, "hiderefs")))
     ++		return 0;
     ++
     ++	if (!value)
     ++		return config_error_nonbool(var);
     ++
     ++	if (skip_prefix(value, "hook:", &value)) {
     ++		refs_list = &hook_hide_refs;
      +
      +		/*
     -+		 * the prefix 'hook:' means that the matched refs will be
     -+		 * checked by the hide-refs hook dynamically, we need to put
     -+		 * the 'ref' string to the hook_hide_refs list
     ++		 * Once the 'hide-refs' hook is invoked, Git needs to do
     ++		 * version negotiation with it, the version number and the
     ++		 * process name ('uploadpack' or 'receive') will send to
     ++		 * it in pkt-line format, and the process name is recorded
     ++		 * by hide_refs_section
      +		 */
     -+		if (skip_prefix(value, "hook:", &value)) {
     -+			if (!strlen(value))
     -+				return error(_("missing value for '%s' after hook option"), var);
     -+			hook = 1;
     -+		}
     ++		if (hide_refs_section.len == 0)
     ++			strbuf_addstr(&hide_refs_section, section);
     ++	}
      +
     - 		ref = xstrdup(value);
     - 		len = strlen(ref);
     - 		while (len && ref[len - 1] == '/')
     - 			ref[--len] = '\0';
     --		if (!hide_refs) {
     --			CALLOC_ARRAY(hide_refs, 1);
     --			hide_refs->strdup_strings = 1;
     ++	ref = xstrdup(value);
     ++	len = strlen(ref);
     ++	while (len && ref[len - 1] == '/')
     ++		ref[--len] = '\0';
      +
     -+		if (hook) {
     -+			if (!hook_hide_refs) {
     -+				CALLOC_ARRAY(hook_hide_refs, 1);
     -+				hook_hide_refs->strdup_strings = 1;
     -+			}
     -+			string_list_append(hook_hide_refs, ref);
     -+		} else {
     -+			if (!hide_refs) {
     -+				CALLOC_ARRAY(hide_refs, 1);
     -+				hide_refs->strdup_strings = 1;
     -+			}
     -+			string_list_append(hide_refs, ref);
     - 		}
     --		string_list_append(hide_refs, ref);
     - 	}
     ++	if (!*refs_list) {
     ++		CALLOC_ARRAY(*refs_list, 1);
     ++		(*refs_list)->strdup_strings = 1;
     ++	}
     ++	string_list_append(*refs_list, ref);
      +
     -+	/*
     -+	 * Once hide-refs hook is invoked, Git need to do version negotiation,
     -+	 * with it, version number and process name ('uploadpack' or 'receive')
     -+	 * will send to it in pkt-line format, the proccess name is recorded
     -+	 * by hide_refs_section
     -+	 */
     -+	if (hook && hide_refs_section.len == 0)
     -+		strbuf_addstr(&hide_refs_section, section);
     ++	return 0;
     ++}
      +
     - 	return 0;
     - }
     - 
     --int ref_is_hidden(const char *refname, const char *refname_full)
      +static struct child_process *hide_refs_proc;
      +static struct packet_reader *hide_refs_reader;
      +
     @@ refs.c: int parse_hide_refs_config(const char *var, const char *value, const cha
      +			if (reader->pktlen > 8 && starts_with(reader->line, "version=")) {
      +				version = atoi(reader->line + 8);
      +			}
     -+		}
     + 		}
     +-		string_list_append(hide_refs, ref);
      +
      +	if (err)
      +		goto failure;
     @@ refs.c: int parse_hide_refs_config(const char *var, const char *value, const cha
      +	default:
      +		trace_printf(_("hook hide-refs version '%d' is not supported"), version);
      +		goto failure;
     -+	}
     + 	}
      +
      +	sigchain_pop(SIGPIPE);
      +
     @@ refs.c: int parse_hide_refs_config(const char *var, const char *value, const cha
      +	free(proc);
      +	free(reader);
      +	sigchain_pop(SIGPIPE);
     -+	return 0;
     -+}
     -+
     + 	return 0;
     + }
     + 
     +-int ref_is_hidden(const char *refname, const char *refname_full)
      +/* If hide-refs child process start failed, set skip_hide_refs_proc to true */
      +static int skip_hide_refs_proc;
      +
     @@ refs.c: int parse_hide_refs_config(const char *var, const char *value, const cha
       {
      +	struct string_list *hide_refs_list = hide_refs;
       	int i;
     ++	int match_all = 0;
       
      -	if (!hide_refs)
      +	if (hook)
      +		hide_refs_list = hook_hide_refs;
     -+
      +	if (!hide_refs_list)
       		return 0;
      -	for (i = hide_refs->nr - 1; i >= 0; i--) {
      -		const char *match = hide_refs->items[i].string;
     ++
      +	for (i = hide_refs_list->nr - 1; i >= 0; i--) {
      +		const char *match = hide_refs_list->items[i].string;
       		const char *subject;
       		int neg = 0;
       		const char *p;
     +@@ refs.c: int ref_is_hidden(const char *refname, const char *refname_full)
     + 			match++;
     + 		}
     + 
     ++		/* empty string with the 'hook:' option matches all the refs */
     ++		if (hook && !*match) {
     ++			match_all = !neg;
     ++			continue;
     ++		}
     ++
     + 		if (*match == '^') {
     + 			subject = refname_full;
     + 			match++;
      @@ refs.c: int ref_is_hidden(const char *refname, const char *refname_full)
       		/* refname can be NULL when namespaces are used. */
       		if (subject &&
     @@ refs.c: int ref_is_hidden(const char *refname, const char *refname_full)
      +			return ref_hidden_check_by_hook(refname, refname_full);
      +		}
       	}
     - 	return 0;
     - }
     - 
     ++
     ++	if (hook && match_all)
     ++		return ref_hidden_check_by_hook(refname, refname_full);
     ++
     ++	return 0;
     ++}
     ++
      +int ref_is_hidden(const char *refname, const char *refname_full)
      +{
      +	if (ref_hidden_check(refname, refname_full, 0) ||
      +	    ref_hidden_check(refname, refname_full, 1))
      +		return 1;
     -+	return 0;
     -+}
     -+
     - const char *find_descendant_ref(const char *dirname,
     - 				const struct string_list *extras,
     - 				const struct string_list *skip)
     + 	return 0;
     + }
     + 
 2:  0df5ecc216d ! 2:  f309e9534f2 hiderefs: use new flag to mark force hidden refs
     @@ Metadata
      Author: Sun Chao <sunchao9@huawei.com>
      
       ## Commit message ##
     -    hiderefs: use new flag to mark force hidden refs
     +    hiderefs: use a new flag to mark force hidden refs
      
          If uploadpack.allowTipSHA1InWant or uploadpack.allowReachableSHA1InWant
     -    are set to true, the private commits of hide refs can be fetched by
     -    client. The new hide-refs hook are used to hide our refs and we wish to
     -    hide the private commits either.
     +    is set to true, the private commits of hiding refs can be fetched by
     +    the client. The new hide-refs hook is used to hide our refs and we wish
     +    to hide the private commits either.
      
     -    Now we have hide-refs hook to hide refs dynamically, a new
     -    flag `HIDDEN_REF_FORCE` is used to mark a ref if hide-refs hook
     -    decide to hide it, and we make sure the wire protocol V1 will reject
     -    to send the private commits of these refs even if
     +    A new flag `HIDDEN_REF_FORCE` is used to mark a ref if hide-refs hook
     +    decides to hide it, and we make sure the wire protocol V1 will reject
     +    to send the private commits of this kind of refs even if
          uploadpack.allowTipSHA1InWant or uploadpack.allowReachableSHA1InWant
     -    are set to true.
     +    is set to true.
      
          Signed-off-by: Sun Chao <sunchao9@huawei.com>
      
     @@ refs.c: int ref_is_hidden(const char *refname, const char *refname_full)
      +#define OUR_REF		(1u << 12)
      +#define HIDDEN_REF	(1u << 19)
      +/*
     -+ * Use this flag to mark a ref that is hided by hide-refs hook, its private
     -+ * commits (tip or non-tip commits, not reachable by the refs not hided by
     -+ * hide-refs hook) will be force hidden to the client, which means client can
     -+ * not fetch such kind of commit even uploadpack.allowTipSHA1InWant or
     ++ * Use this flag to mark a ref that is hidden by the hide-refs hook, its private
     ++ * commits (tip or non-tip commits, not reachable by the refs not hidden by the
     ++ * hide-refs hook) will be forced hidden to the client, which means a client can
     ++ * not fetch such kind of commits even uploadpack.allowTipSHA1InWant or
      + * uploadpack.allowReachableSHA1InWant are set to true
      + */
      +#define HIDDEN_REF_FORCE	(1u << 20)
 3:  de73f5a6fd9 ! 3:  0013476266e hiderefs: hornor hide flags in wire protocol V2
     @@ Metadata
       ## Commit message ##
          hiderefs: hornor hide flags in wire protocol V2
      
     -    Previously hide refs can not protect private data of hide refs in wire
     -    protocol V2, for example a `ALL_FLAGS` will be used to clear all the
     -    objects before handling the fetch requests.
     +    Previously hiderefs configurations can not protect the private data
     +    of hiding refs in wire protocol V2, for example, an `ALL_FLAGS` flag
     +    will be used to clear all the objects before handling the fetch requests.
      
     -    Hornor the hide flags by removing `HIDDEN_REFS` flag from `ALL_FLAGS`
     -    and make sure all the refs will check its hidden flags before sending pack
     -    to client, especially during stateless rpc. And if there are refs with
     -    `HIDDEN_REF_FORCE` flag, use `check_non_tip` to protect the private date
     -    of force hidden refs.
     +    Hornor the hide flags by removing the `HIDDEN_REFS` flag from the
     +    `ALL_FLAGS` and make sure all the refs will check its hidden flags
     +    before sending the pack to client, especially during stateless RPC.
     +    And if there are refs with `HIDDEN_REF_FORCE` flag, use `check_non_tip`
     +    to protect the private data of force-hidden refs.
      
          Signed-off-by: Sun Chao <sunchao9@huawei.com>
      
 4:  fb135cb3bd3 ! 4:  c1274d6b834 test: add test cases for hide-refs hook
     @@ Commit message
          test: add test cases for hide-refs hook
      
          Add test cases for the new 'hide-refs' hook which is used to
     -    filter the references during reference discovery phase.
     +    filter the references during the reference discovery phase.
      
          Signed-off-by: Sun Chao <sunchao9@huawei.com>
      
     @@ t/t1419-hide-refs-hook.sh (new)
      +		# config transfer.hiderefs values with "hook:" prefix
      +		(
      +			git -C bare_repo.git config --local http.receivepack true &&
     -+			git -C bare_repo.git config --add transfer.hiderefs hook:HEAD &&
     -+			git -C bare_repo.git config --add transfer.hiderefs hook:refs
     ++			git -C bare_repo.git config --add transfer.hiderefs hook:
      +		)
      +	'
      +}
     @@ t/t1419/abnormal-hide-refs-hook.sh (new)
      @@
      +#!/bin/sh
      +
     -+# Upstream repository (bare_repo.git) contains the configurations:
     ++# The upstream repository (bare_repo.git) contains the configurations:
      +#
     -+#	[transfer]
     -+#		hiderefs = hook:HEAD
     -+#		hiderefs = hook:refs
     ++#	[transfer] hiderefs = hook:
      +#
     -+# During refs advertise phase the hide-refs hook will be invoked and each ref will be checked by it,
     -+# we should make sure Git works correctly in some speicail cases
     ++# During the reference advertise phase the hide-refs hook will be invoked and all the refs will be checked by it,
     ++# we should make sure Git works correctly in some special cases
      +
     -+# If hide-refs not exists, Git should not invoke it and continue advertise all the refs
     ++# If the hide-refs does not exist, Git should not invoke it and continue to advertise all the refs
      +test_expect_success "protocol $GIT_TEST_PROTOCOL_VERSION: advertise-refs while hide-refs hook not exists" '
      +	rm -f "$BAREREPO_GIT_DIR/hooks/hide-refs" &&
      +	git -c protocol.version=$GIT_TEST_PROTOCOL_VERSION upload-pack --advertise-refs "$BAREREPO_GIT_DIR" >out 2>&1 &&
     @@ t/t1419/abnormal-hide-refs-hook.sh (new)
      +	test_cmp expect actual
      +'
      +
     -+# If hide-refs hook run with incompatible version, Git should not invoke it and continue to advertise all the refs
     ++# If the hide-refs hook run with incompatible version, Git should not invoke it and continue to advertise all the refs
      +test_expect_success "protocol $GIT_TEST_PROTOCOL_VERSION: advertise-refs while hide-refs hook run with incompatible version" '
      +	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
      +		test-tool hide-refs --version=2
     @@ t/t1419/abnormal-hide-refs-hook.sh (new)
      +	test_cmp expect actual
      +'
      +
     -+# If hide-refs hook exit before processing any refs, Git should not die and continue to advertise all the refs
     ++# If the hide-refs hook exit before processing any refs, Git should not die and continue to advertise all the refs
      +test_expect_success "protocol $GIT_TEST_PROTOCOL_VERSION: advertise-refs while hide-refs hook die before read ref" '
      +	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
      +		test-tool hide-refs --die-before-read-ref
     @@ t/t1419/abnormal-hide-refs-hook.sh (new)
      +	test_cmp expect actual
      +'
      +
     -+# If hide-refs hook exit abnormally, Git should not die and continue to advertise left refs
     ++# If the hide-refs hook exit abnormally, Git should not die and continue to advertise left refs
      +test_expect_success "protocol $GIT_TEST_PROTOCOL_VERSION: advertise-refs while hide-refs hook die after proc ref" '
      +	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
      +		test-tool hide-refs --die-after-proc-refs
     @@ t/t1419/test-0001-ls-remote-with-hide-refs-hook.sh (new)
      @@
      +#!/bin/sh
      +
     -+# Upstream repository (bare_repo.git) contains the configurations:
     ++# The upstream repository (bare_repo.git) contains the configurations:
      +#
     -+#	[transfer]
     -+#		hiderefs = hook:HEAD
     -+#		hiderefs = hook:refs
     ++#	[transfer] hiderefs = hook:
      +#
     -+# During refs advertise phase the hide-refs hook will be invoked and each ref will be checked by it
     ++# During the reference advertise phase the hide-refs hook will be invoked and all the refs will be checked by it
      +
     -+# Git will not advertise the refs that are hided by hide-refs hook
     ++# Git will not advertise the refs that are hidden by the hide-refs hook
      +test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote while hide-refs hook hide part of refs" '
      +	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
      +	test-tool hide-refs \
     @@ t/t1419/test-0001-ls-remote-with-hide-refs-hook.sh (new)
      +	test_cmp expect actual
      +'
      +
     -+# The hide-ref hook should not change the default effects of [transfer|uploadpack|receive].hiderefs configurations,
     -+# if it hide no refs, the original hiderefs rules should works
     ++# The hide-ref hook should not change the default effects of '{transfer,uploadpack,receive}.hiderefs'
     ++# configurations, if it hides no refs, the original hiderefs configurations should work
      +test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): ls-remote while hide-refs hook hide no refs" '
      +	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
      +		test-tool hide-refs
     @@ t/t1419/test-0002-upload-pack-with-hide-refs-hook.sh (new)
      @@
      +#!/bin/sh
      +
     -+# Upstream repository (bare_repo.git) contains the configurations:
     ++# The upstream repository (bare_repo.git) contains the configurations:
      +#
     -+#	[transfer]
     -+#		hiderefs = hook:HEAD
     -+#		hiderefs = hook:refs
     ++#	[transfer] hiderefs = hook:
      +#
     -+# During refs advertise phase the hide-refs hook will be invoked and each ref will be checked by it
     ++# During the reference advertise phase the hide-refs hook will be invoked and all the refs will be checked by it
      +
     -+# Git client can not fetch the refs that are hided by hide-refs hook
     ++# Git client can not fetch the refs that are hidden by the hide-refs hook
      +test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): mirror clone while hide-refs hide part of refs" '
      +	rm -rf local.git &&
      +	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
     @@ t/t1419/test-0002-upload-pack-with-hide-refs-hook.sh (new)
      +	test_cmp expect actual
      +'
      +
     -+# If a ref is hided by hide-refs hook, its private commits (tip or non-tip) will be force hidden
     -+# to the client, and the client can not fetch such kind of commit even the server set allowTipSHA1InWant
     ++# If a ref is hidden by the hide-refs hook, its private commits (tip or non-tip) will be forced hidden
     ++# to the client, and the client can not fetch such kind of commits even if the server set allowTipSHA1InWant
      +# or allowReachableSHA1InWant to true
      +test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): fetch a commit which is hided by hide-refs hook" '
      +	rm -rf local.git &&
     @@ t/t1419/test-0003-receive-pack-with-hide-refs-hook.sh (new)
      @@
      +#!/bin/sh
      +
     -+# Upstream repository (bare_repo.git) contains the configurations:
     ++# The upstream repository (bare_repo.git) contains the configurations:
      +#
     -+#	[transfer]
     -+#		hiderefs = hook:HEAD
     -+#		hiderefs = hook:refs
     ++#	[transfer] hiderefs = hook:
      +#
     -+# During refs advertise phase the hide-refs hook will be invoked and each ref will be checked by it
     ++# During the reference advertise phase the hide-refs hook will be invoked and all the refs will be checked by it
      +
      +test_expect_success "$PROTOCOL (protocol: $GIT_TEST_PROTOCOL_VERSION): push to main while hide-refs hook does not hide it" '
      +	write_script "$BAREREPO_GIT_DIR/hooks/hide-refs" <<-EOF &&
 5:  8a5f7762c27 ! 5:  0cb019b28da doc: add documentation for the hide-refs hook
     @@ Metadata
       ## Commit message ##
          doc: add documentation for the hide-refs hook
      
     -    If uploadpack.allowTipSHA1InWant or
     -    uploadpack.allowReachableSHA1InWant are set to true, the private
     -    commits of hide refs can be fetched by client. The new "hide-refs"
     -    hook are used to hide our refs and we wish to hide the private
     -    commits either.
     +    If uploadpack.allowTipSHA1InWant or uploadpack.allowReachableSHA1InWant
     +    is set to true, the private commits of hiding refs can be fetched by
     +    the client. The new "hide-refs" hook is used to hide our refs and we
     +    wish to hide the private commits either.
      
     -    "git upload-pack" or "git receive-pack" can use "hide-refs" hook to
     -    filter the references during reference discovery phase. If a ref is
     -    hided by "hide-refs" hook, its private data cannot be fetched by
     -    client even if uploadpack.allowTipSHA1InWant or
     -    uploadpack.allowReachableSHA1InWant are set to true.
     +    "git-upload-pack" or "git-receive-pack" can use "hide-refs" hook to
     +    filter the references during the reference discovery phase. If a ref
     +    is hidden by the "hide-refs" hook, its private data cannot be fetched
     +    by the client even if uploadpack.allowTipSHA1InWant or
     +    uploadpack.allowReachableSHA1InWant is set to true.
      
          Signed-off-by: Sun Chao <sunchao9@huawei.com>
      
     @@ Documentation/githooks.txt: If this hook exits with a non-zero status, `git push
      +~~~~~~~~~
      +
      +This hook would be invoked by 'git-receive-pack' and 'git-upload-pack'
     -+during the reference discovery phase, each reference and will be filtered
     ++during the reference discovery phase, each reference will be filtered
      +by this hook. The hook executes once with no arguments for each
      +'git-upload-pack' and 'git-receive-pack' process. Once the hook is invoked,
      +a version number and server process name ('uploadpack' or 'receive') will
      +send to it in pkt-line format, followed by a flush-pkt. The hook should
      +respond with its version number.
      +
     -+During reference discovery phase, each reference will be filtered by this
     -+hook. In the following example, the letter 'G' stands for 'git-receive-pack'
     -+or 'git-upload-pack' and the letter 'H' stands for this hook. The hook
     -+decides if the reference will be hidden or not, it sends result back in
     -+pkt-line format protocol, a response "hide" the references will hidden
     -+to the client.
     ++During the reference discovery phase, each reference will be filtered by
     ++this hook. In the following example, the letter 'G' stands for
     ++'git-receive-pack' or 'git-upload-pack', and the letter 'H' stands for
     ++this hook. The hook decides if the reference will be hidden or not, it
     ++sends the result back in pkt-line format protocol, and a response 'hide'
     ++means the references will be hidden to the client.
      +
      +	# Version negotiation
      +	G: PKT-LINE(version=1\0uploadpack)
     @@ Documentation/githooks.txt: If this hook exits with a non-zero status, `git push
      +	G: PKT-LINE(ref <refname>:<refnamefull>)
      +	G: flush-pkt
      +
     -+	# Receive result from the hook.
     ++	# Receive the result from the hook.
      +	# Case 1: this reference is hidden
      +	H: PKT-LINE(hide)
      +	H: flush-pkt
     @@ Documentation/githooks.txt: If this hook exits with a non-zero status, `git push
      +	# Case 2: this reference can be advertised
      +	H: flush-pkt
      +
     -+To enable the `hide-refs` hook, we should config hiderefs with `hook:`
     -+option, eg:
     ++To enable the `hide-refs` hook, we should config hiderefs with a `hook:`
     ++option, e.g. if we want to pass all the refs to the new hook except for
     ++the tags:
      +
     -+	git config --add transfer.hiderefs hook:refs/prefix1/
     -+	git config --add uploadpack.hiderefs hook:!refs/prefix2/
     ++	git config --add transfer.hiderefs hook:
     ++	git config --add transfer.hiderefs hook:!refs/tags/
      +
     -+the `hide-refs` will be called during reference discovery phase and
     ++the `hide-refs` will be called during the reference discovery phase and
      +check each matched reference, a 'hide' response means the reference will
     -+be hidden for its private data even if `allowTipSHA1InWant` and
     -+`allowReachableSHA1InWant` are set to true.
     ++be hidden for its private data even if `allowTipSHA1InWant` or
     ++`allowReachableSHA1InWant` is set to true.
      +
       [[pre-receive]]
       pre-receive

-- 
gitgitgadget
