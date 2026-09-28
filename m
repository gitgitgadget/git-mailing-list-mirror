Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9CD4C7539
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602752; cv=none; b=sY+pT9ngNS/V6fRgtSjkqRnURcw+60Uw9uovz3uMh3m0B17xDdPn25Y1gfFqxBHB+45pyLCDBpdLw9/RM1U32buvjkVOrHdQbfZmCF/UOIkISt3ZJNsB2PVGm6lTj+soiBgxghEaxu8jEmYLI4oq6kQmt5eYwJEUNJSGL6uWBhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602752; c=relaxed/simple;
	bh=qXVLXRSOn6T1TBsSEWfU+9Aaowe4YGOR+4lnJTNqxuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDAvlv2OV9SrZKqjwEhaJkzsks3VuPDnLFIEuALLKT/yxjeSpK+XLDBJcyESUfzJzDZ0Ft1FDlAfJzd37Sp0kTdPnkA8PHHbevUc5qaX0s46CoBY48oPOPoi1i4QITJj8BLB/IiCijPCsloa+DwmvuFcFgBGD/7HRxL6KMdClsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8+eavxf; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8+eavxf"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d391aso22315855e9.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602747; x=1791207547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pk9shrO7zbtn+FMTe2iVc5uX+TNBWvtF3y9pmH6N9H4=;
        b=W8+eavxfOqpzRLualSm9YHz1eiTvT2O84aDVK5EPaRfcLkqbwCgUVgAzm9/o6NUIo0
         8+vImBDJab8eQ+UrZlguZpkTmoVjnYEeHRn9dlzVnPGy409Pb7zkFRnxK1DhCUgqIqvk
         ZT2/m0a+iNvjOBhZAcMIK/BpIWQAQa1Vv07AjnGXp+ajjKWmN9Xv8y1tr/DWKC9/5xgm
         XnGQvMowaJkSFm79kOfbldSqznEE0cOuOVBYzCery9VqT7pHW6QJMQ+nqJPLosTOESAr
         qYLwltDkhu61Fwx3tqjP+Lb4WK/EhdT+NjLWd8b0kYWh9SZ34w4ecB1e/pv9f3NkHPw7
         2E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602747; x=1791207547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pk9shrO7zbtn+FMTe2iVc5uX+TNBWvtF3y9pmH6N9H4=;
        b=vOombZz/qED0uFmp1O1Q1l0uuqB3xxBvSOr1RV7VmrtnxpHJul5jv5X/YZHfLL0n6l
         X3dPBp/4MBZvMB3/yxzYh9RdiApWJl65+lxDRsBSO5UmKVHQKGPTouoOOO95yCa4VsPz
         YCUFJfAj/g5pBTQc/fcBIMRURY4/G5X+Ff3exole7V9kjXEqVx4pfLx+YsyzzQgpwm9j
         nXqX85Z5N3hgUL0a3xf3ivZ7ybXFcGssAUmWZzKErSB/rl9JxHF5I59Iz8xKnUFLMXCz
         2Z4im8iAFmKJGBo4nNVQ02uTru+/5q/x1tyO9Yeyr5JOd0g+TN0taDh2JTNX9TGhzSiD
         jhbg==
X-Gm-Message-State: AFuF++lr8NNT+GCi/AXjWI91lam5qGkOQXdes7FwyDIkSIbs+U4fvm6l
	e/l89EbxiUyqijUwThju47pNrCzzo4SPFgnVZOeYnXHsbDMxSDeyUrPS6yu2Dw==
X-Gm-Gg: AYBFou3q2J+WboXQK6If7+f1leMTQCL++SSwKeF/cOcb8jFR/rDLKI9AcEkJrP1enSA
	9CKBVHFzeISNpqpOvzvHnW64P16vP9B3o3HIrMX8EZUVT7CT65n9ISXvAF5pIvJfBjNn2GDgudt
	oHCOHbjSu130tEhVBHDMjNC5lKb/f1KcKUsYC3j7ZrLC72YKFgdcLarxS2BpfOhOaRfOt2snusT
	A4WxFBoNvD1jIzqHABadCk9p8Gp1RO3XSCKyJiUJGy45MptsUmWdD777pnoHh/hJXjs0m5ZhGe7
	ErpvC7Z3tekj2KSBsd2iGW5nK1S9naH8MRDUaXLJEiqjcolqohXwickFmkCr+M/PXIz3JzUsFCD
	nUbFM1nXARFFU0FTRblhsXSy+SI14PTrL6PLqF9m1s/J6HSo3pLZ1T6lFjc2sJqa/iyeESOQM1a
	+arlEsX8mHdhf1+85Z5MqY+WeOyCEcv0S5mzKqWu2AU+tdkAnV1o/9yXvbdACYzBTKlW8Sis0PL
	A6UzDTDe0rnpjgdNJwBDrnEK7wNikmcHLzVMJ7GJ8Zzo5vbw40Z+sd7yTkixPR3d4yMuiyx5zlx
	6Ev5IGt+wL/sQDwU6SzBu2ugt7LKYbcWmJzE4MHjkAEon4wf9po5lF3hMJzTlO77xeV8dx1f5vR
	ZBrI7vVA9
X-Received: by 2002:a05:600c:154c:b0:4a0:4c7:e0c4 with SMTP id 5b1f17b1804b1-4a004c7e4e7mr50637755e9.1.1790602746454;
        Mon, 28 Sep 2026 06:39:06 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00c0730a8sm5554505e9.0.2026.09.28.06.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:39:05 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 0/5] Introduce 'uploadpack.lazyFetchTrusted'
Date: Mon, 28 Sep 2026 15:38:41 +0200
Message-ID: <20260928133846.2094261-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.rc2.20.g34f06850c1
In-Reply-To: <20260908164129.560396-1-christian.couder@gmail.com>
References: <20260908164129.560396-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently the "promisor-remote" capability was added to protocol v2,
allowing servers and clients to agree on the promisor remotes they can
safely use.

The more servers use promisor remotes, the more it is important to
properly control if they can lazy fetch when responding to a clone or
fetch request from the client.

For example, in the context of large object promisors (see
"Documentation/technical/large-object-promisors.adoc"), if a client
clones with a filter set to 100kB while the server has moved all of
the blobs >= 10kB to a promisor remote, the server will not be able to
provide blobs between 10kB and 100kB to the client, which will make
the clone fail.

Even if the `--filter=auto` option is available since ef2f1845ec
(fetch-pack: wire up and enable auto filter logic, 2026-02-16) it's
still a good idea to provide more control over lazy fetching on the
server side to server operators, as lazy fetching on the server side
could be useful in corporate environments.

Since 7b70e9efb1 (upload-pack: disable lazy-fetching by default,
2024-04-16), lazy fetching has been controlled by the
`GIT_NO_LAZY_FETCH` environment variable. This is a boolean that is
set to 'true' by default when calling `git upload-pack` for security
reasons.

The main security issue on the server side is making sure the served
repo itself is also trusted, as lazily fetching runs `git fetch`,
which may execute arbitrary commands specified in the configuration
and hooks of the served repo. The operator of the server should decide
and mark that trust, not the served repo itself, nor the client.

This series introduces a new 'uploadpack.lazyFetchTrusted' protected
configuration variable similar to 'safe.directory' (see
"Documentation/config/safe.adoc") to mark trusted repos where lazy
fetching is allowed. As it is protected, this config variable will
only take effect if it is set in global or system scope, so only
server operators can control it.

Previous related work
=====================

A previous series called "Introduce a 'fromAccepted' option to
GIT_NO_LAZY_FETCH" [1] took a different approach as it wanted to make
it easier to allow lazy fetching from accepted promisor remotes. But
after brian replied that he didn't think it was a good idea, and after
thinking about this more, my opinion now is that some promisor remotes
being accepted or not is not really relevant to the issue.

In my reply to brian, I said:

"""
Different features could be developed (in future work) to improve on
the current state:
    - a way for lazy fetching to work without reading config files,
triggering hooks, or doing potentially sensitive things,
    - an explicit way for operators to mark trusted repos (like
perhaps a server-side config the operator sets per-repo),
    - operator-defined allow/deny rules, or maybe
    - some ways/scripts/commands to scan repos and check configuration
information, remote settings and everything potentially sensitive to
decide if a repo looks safe enough to allow lazy fetching or not.
"""

So I decided to go with "an explicit way for operators to mark trusted
repos" and this series is an implementation of that.

Note that the feature developed in this series applies to protocol
v0/v1 as well as v2 while the previous one was only related to v2.

[1]: https://lore.kernel.org/git/CAP8UFD0_S9eg_w42tcNRnT9E2ntLr_eHLnzE4c2dSu67DzZoXg@mail.gmail.com/

Overview of the patches
=======================

  - Patch 1/5 is the only patch saved from the "Introduce a
    'fromAccepted' option to GIT_NO_LAZY_FETCH" series. It's not
    necessary for the rest of this series and its main feature to
    work, but I think it's a nice refactoring related to lazy
    fetching, so it might as well be part of this series.

  - Patch 2/5 extracts and modifies code used by the 'safe.directory'
    config variable in new path_allowlist_config_apply() and
    path_allowlist_apply() functions, so that these functions can be
    reused to process 'uploadpack.lazyFetchTrusted' in the next patch.

  - Patch 3/5 uses the new functions from the previous patch in a new
    upload_pack_lazy_fetch_trusted() function to process
    'uploadpack.lazyFetchTrusted', but the result from that processing
    isn't actually used to have a practical effect.

  - Patch 4/5 prevents infinite lazy fetch recursions that the
    following patch would otherwise make possible. If a repo is
    allowed to lazy fetch and one of its promisor remotes resolves
    back to it, for example if it is its own promisor remote as Junio
    noticed when reviewing v2, each nested `upload-pack` inherits
    `GIT_NO_LAZY_FETCH=0` and fetches again.

  - Patch 5/5 wires up the new upload_pack_lazy_fetch_trusted()
    function to decide if lazy fetching can actually be enabled.

Changes since v3
================

Thanks to Junio for reviewing previous versions of this series.

Rebased on top of 34f06850c1 (Merge tag 'l10n-2.56.0-v1' of
https://github.com/git-l10n/git-po, 2026-09-27) as I wanted to avoid
possible merge issues and be based on a stable commit close to
v2.56.0.

Except for some functions and variables that are now typed using a
regular `int` instead of a `bool` or an `unsigned long`, there are
mostly commit message and code comment changes in the first 4 patches
of this version compared to v3.

The most significant changes are in patch 5/5.

 - In patch 1/5:

   - The commit message explains why it's fine to not call
     promisor_remote_init() when lazy fetching is disabled.

   - The code comments documenting both try_promisor_remotes() and the
     new lazy_fetch_objects() function are improved.

   - These two functions now keep returning `int`, as before this
     series, instead of `bool` as in v3.

 - In patch 2/5, instead of changing `int is_safe` to `bool safe` in
   `struct safe_directory_data`, only the type of this member is
   changed from `int` to `bool`. The commit message also better
   explains this change.

 - Patch 3/5 is unchanged. 

 - In patch 4/5, the variable and function arguments called `depth`
   are changed from an `unsigned long` to a regular `int`.

 - In patch 5/5:

   - In the code, instead of checking if GIT_NO_LAZY_FETCH is already
     set at the beginning of the command, then unconditionally setting
     it to 1, and later setting it to 0 if the repo is trusted, we now
     only check if it is set after entering the repo, and set it to 1
     if it isn't and the repo isn't trusted.

   - The patch title is changed accordingly from "set
     GIT_NO_LAZY_FETCH to 0 on trusted repo" to "don't disable lazy
     fetching on trusted repo".

   - The commit message is changed too:

     - the patch is reframed as teaching the code that sets
       `GIT_NO_LAZY_FETCH` to consult the config, rather than config
       overriding the environment,

     - the 3 possible cases regarding `GIT_NO_LAZY_FETCH` are listed,

     - the "served repo is trusted" sentence is fixed to say that the
       operator vouches for the promisor remotes, configuration and
       hooks of the listed repo.

CI tests
========

They all pass, see:

https://github.com/chriscool/git/actions/runs/36414541860

Range-diff compared to v3
=========================

1:  9403597855 ! 1:  e7332d0aa4 promisor-remote: factor out lazy_fetch_objects()
    @@ Commit message
             instead of once per promisor remote, and
     
           - promisor_remote_init() is no longer called when lazy fetching
    -        is disabled, which is fine as nothing downstream of it, like
    -        is_promisor_object(), needs it in that case.
    +        is disabled.
     
    -    While at it, let's also convert try_promisor_remotes() to return
    -    'bool' instead of 'int', as it just returns whether all the objects
    -    could be fetched, and document its return value.
    +    The latter is fine because the convention around promisor_remote_init()
    +    is that whoever needs to access the promisor remote information is
    +    expected to initialize it beforehand, and not that it should be
    +    initialized once at the very beginning before doing random things on
    +    promisor remotes. So moving its call site into lazy_fetch_objects(),
    +    which is the only code that needs the promisor remotes here, follows
    +    that convention. Nothing downstream of it, like is_promisor_object(),
    +    needs it when lazy fetching is disabled.
    +
    +    While at it, let's document try_promisor_remotes() and the new
    +    lazy_fetch_objects() function, especially how their `remaining_oids`,
    +    `remaining_nr` and `to_free` arguments are used, as the ownership
    +    rules around `to_free` are easy to get wrong.
     
         Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
    @@ promisor-remote.c: static int remove_fetched_oids(struct repository *repo,
      	return remaining_nr;
      }
      
    --static int try_promisor_remotes(struct repository *repo,
    --				struct object_id **remaining_oids,
    --				int *remaining_nr, int *to_free,
    --				bool accepted_only)
     +/*
    -+ * Return 'true' if all the objects could be fetched from the
    -+ * (non-)accepted remotes, 'false' otherwise.
    ++ * Fetch the remaining objects (given in '*remaining_oids', which
    ++ * contains '*remaining_nr' object ids) from the known promisor
    ++ * remotes. If 'accepted_only' is true, ignore promisor remotes with
    ++ * their 'accepted' member unset.
    ++ *
    ++ * When a fetch from a remote fails, the objects that are still
    ++ * missing are computed, and '*remaining_oids' and '*remaining_nr' are
    ++ * updated accordingly before trying the next remote. In that case
    ++ * '*remaining_oids' points to a new array that this function
    ++ * allocated, and '*to_free' is set to 1 to tell the caller that it
    ++ * owns that array and should free it. '*to_free' should be 0 on the
    ++ * first call.
    ++ *
    ++ * Return 1 when all the requested objects have been fetched, 0
    ++ * otherwise.
     + */
    -+static bool try_promisor_remotes(struct repository *repo,
    -+				 struct object_id **remaining_oids,
    -+				 int *remaining_nr,
    -+				 int *to_free,
    -+				 bool accepted_only)
    + static int try_promisor_remotes(struct repository *repo,
    + 				struct object_id **remaining_oids,
    +-				int *remaining_nr, int *to_free,
    ++				int *remaining_nr,
    ++				int *to_free,
    + 				bool accepted_only)
      {
      	struct promisor_remote *r = repo->promisor_remote_config->promisors;
    - 
     @@ promisor-remote.c: static int try_promisor_remotes(struct repository *repo,
    - 				continue;
    - 			}
    - 		}
    --		return 1; /* all fetched */
    -+		return true; /* all fetched */
    - 	}
    --	return 0;
    -+	return false;
    -+}
    -+
    + 	return 0;
    + }
    + 
     +/*
    -+ * Return 'true' if all the objects could be fetched, 'false' otherwise.
    ++ * Lazily fetch the objects given in '*remaining_oids' from the
    ++ * promisor remotes, trying the accepted ones first. See
    ++ * try_promisor_remotes() above for how '*remaining_oids',
    ++ * '*remaining_nr' and '*to_free' are used.
    ++ *
    ++ * Return 1 when all the requested objects have been fetched, 0
    ++ * otherwise.
     + */
    -+static bool lazy_fetch_objects(struct repository *repo,
    -+			       struct object_id **remaining_oids,
    -+			       int *remaining_nr,
    -+			       int *to_free)
    ++static int lazy_fetch_objects(struct repository *repo,
    ++			      struct object_id **remaining_oids,
    ++			      int *remaining_nr,
    ++			      int *to_free)
     +{
     +	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0)) {
     +		static int warning_shown;
    @@ promisor-remote.c: static int try_promisor_remotes(struct repository *repo,
     +			warning_shown = 1;
     +			warning(_("lazy fetching disabled; some objects may not be available"));
     +		}
    -+		return false;
    ++		return 0;
     +	}
     +
     +	promisor_remote_init(repo);
    @@ promisor-remote.c: static int try_promisor_remotes(struct repository *repo,
     +				    to_free, true) ||
     +		try_promisor_remotes(repo, remaining_oids, remaining_nr,
     +				     to_free, false);
    - }
    - 
    ++}
    ++
      void promisor_remote_get_direct(struct repository *repo,
    + 				const struct object_id *oids,
    + 				int oid_nr)
     @@ promisor-remote.c: void promisor_remote_get_direct(struct repository *repo,
      	struct object_id *remaining_oids = (struct object_id *)oids;
      	int remaining_nr = oid_nr;
2:  2155c4202d ! 2:  b4a63e3e4e setup: extract path_allowlist_apply()
    @@ Commit message
         the config-value handling in a future commit, let's also introduce a
         path_allowlist_config_apply() helper.
     
    -    For clarity, let's change the `int is_safe` to `bool safe` in
    -    `struct safe_directory_data`.
    +    As the new path_allowlist_apply() function reports its result through
    +    a `bool *matches` argument, let's also change the `int is_safe` member
    +    of `struct safe_directory_data` to a `bool`, so that its address can
    +    be passed as that argument.
     
         Signed-off-by: Christian Couder <christian.couder@gmail.com>
     
    @@ setup.c: static int canonicalize_ceiling_entry(struct string_list_item *item,
      struct safe_directory_data {
      	char *path;
     -	int is_safe;
    -+	bool safe;
    ++	bool is_safe;
      };
      
      static int safe_directory_cb(const char *key, const char *value,
    @@ setup.c: static int canonicalize_ceiling_entry(struct string_list_item *item,
     -			free(allowed);
     -		}
     -	}
    -+	path_allowlist_config_apply(key, value, data->path, &data->safe,
    ++	path_allowlist_config_apply(key, value, data->path, &data->is_safe,
     +				    allow_safe_dir, &cbdata);
      
      	return 0;
      }
    -@@ setup.c: static int ensure_valid_ownership(const char *gitfile,
    - 	git_protected_config(safe_directory_cb, &data);
    - 
    - 	free(data.path);
    --	return data.is_safe;
    -+	return data.safe;
    - }
    - 
    - void die_upon_dubious_ownership(const char *gitfile, const char *worktree,
     
      ## setup.h ##
     @@ setup.h: struct startup_info {
3:  37043ffeaf = 3:  1e2d2d4b4f upload-pack: read uploadpack.lazyFetchTrusted
4:  38fc060999 ! 4:  3e88ec41a4 promisor-remote: prevent infinite recursion when lazy fetching
    @@ promisor-remote.c: struct promisor_remote_config {
      			 const char *remote_name,
      			 const struct object_id *oids,
     -			 int oid_nr)
    -+			 int oid_nr, unsigned long depth)
    ++			 int oid_nr, int depth)
      {
      	struct child_process child = CHILD_PROCESS_INIT;
      	int i;
    @@ promisor-remote.c: static int fetch_objects(struct repository *repo,
      		     "--filter=blob:none", "--stdin", NULL);
      	if (!repo_config_get_bool(repo, "promisor.quiet", &quiet) && quiet)
      		strvec_push(&child.args, "--quiet");
    -+	strvec_pushf(&child.env, "%s=%lu", LAZY_FETCH_DEPTH_ENVIRONMENT, depth + 1);
    ++	strvec_pushf(&child.env, "%s=%d", LAZY_FETCH_DEPTH_ENVIRONMENT, depth + 1);
      	if (start_command(&child))
      		die(_("promisor-remote: unable to fork off fetch subprocess"));
      	child_in = xfdopen(child.in, "w");
    -@@ promisor-remote.c: static bool try_promisor_remotes(struct repository *repo,
    - 				 struct object_id **remaining_oids,
    - 				 int *remaining_nr,
    - 				 int *to_free,
    -+				 unsigned long depth,
    - 				 bool accepted_only)
    +@@ promisor-remote.c: static int try_promisor_remotes(struct repository *repo,
    + 				struct object_id **remaining_oids,
    + 				int *remaining_nr,
    + 				int *to_free,
    ++				int depth,
    + 				bool accepted_only)
      {
      	struct promisor_remote *r = repo->promisor_remote_config->promisors;
    -@@ promisor-remote.c: static bool try_promisor_remotes(struct repository *repo,
    +@@ promisor-remote.c: static int try_promisor_remotes(struct repository *repo,
      	for (; r; r = r->next) {
      		if (accepted_only != r->accepted)
      			continue;
    @@ promisor-remote.c: static bool try_promisor_remotes(struct repository *repo,
      			if (*remaining_nr == 1)
      				continue;
      			*remaining_nr = remove_fetched_oids(repo, remaining_oids,
    -@@ promisor-remote.c: static bool try_promisor_remotes(struct repository *repo,
    - 	return false;
    +@@ promisor-remote.c: static int try_promisor_remotes(struct repository *repo,
    + 	return 0;
      }
      
     +#define MAX_LAZY_FETCH_DEPTH 5
     +
      /*
    -  * Return 'true' if all the objects could be fetched, 'false' otherwise.
    -  */
    -@@ promisor-remote.c: static bool lazy_fetch_objects(struct repository *repo,
    - 			       int *remaining_nr,
    - 			       int *to_free)
    +  * Lazily fetch the objects given in '*remaining_oids' from the
    +  * promisor remotes, trying the accepted ones first. See
    +@@ promisor-remote.c: static int lazy_fetch_objects(struct repository *repo,
    + 			      int *remaining_nr,
    + 			      int *to_free)
      {
    -+	unsigned long depth = git_env_ulong(LAZY_FETCH_DEPTH_ENVIRONMENT, 0);
    ++	int depth = (int)git_env_ulong(LAZY_FETCH_DEPTH_ENVIRONMENT, 0);
     +
      	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0)) {
      		static int warning_shown;
      		if (!warning_shown) {
    -@@ promisor-remote.c: static bool lazy_fetch_objects(struct repository *repo,
    - 		return false;
    +@@ promisor-remote.c: static int lazy_fetch_objects(struct repository *repo,
    + 		return 0;
      	}
      
     +	if (depth >= MAX_LAZY_FETCH_DEPTH) {
     +		static int warning_shown;
     +		if (!warning_shown) {
     +			warning_shown = 1;
    -+			warning(_("too many nested lazy fetches (%lu); "
    ++			warning(_("too many nested lazy fetches (%d); "
     +				  "is a promisor remote pointing at the repository itself?"),
     +				depth);
     +		}
    -+		return false;
    ++		return 0;
     +	}
     +
      	promisor_remote_init(repo);
5:  8cb97230e5 ! 5:  ad8814984b builtin/upload-pack: set GIT_NO_LAZY_FETCH to 0 on trusted repo
    @@ Metadata
     Author: Christian Couder <christian.couder@gmail.com>
     
      ## Commit message ##
    -    builtin/upload-pack: set GIT_NO_LAZY_FETCH to 0 on trusted repo
    +    builtin/upload-pack: don't disable lazy fetching on trusted repo
     
         A previous commit added a new "uploadpack.lazyFetchTrusted" protected
         config variable that can contain an allowlist of repos, as well as
         functions to check if the current repo is in that list. But when the
         current repo is in that list, we currently do nothing.
     
    -    Let's instead set `GIT_NO_LAZY_FETCH` to `0`, which allows
    -    `upload-pack` and its `pack-objects` child process to lazily fetch the
    -    objects they need to serve a client, for example when the filter used
    -    by the client and the one used by the server don't match.
    +    Since 7b70e9efb1 (upload-pack: disable lazy-fetching by default,
    +    2024-04-16), `upload-pack` sets `GIT_NO_LAZY_FETCH` to 1 itself,
    +    unconditionally, because by default it shouldn't trust the repositories
    +    it serves. Lazily fetching runs `git fetch`, which may execute
    +    arbitrary commands specified in the configuration and hooks of the
    +    served repo.
     
    -    This allows server operators to properly control lazy fetching. It is
    -    their responsibility, not the client's, to decide if the served repo is
    -    trusted, as the main security issue is that lazily fetching runs `git
    -    fetch`, which may execute arbitrary commands specified in the
    -    configuration and hooks of the served repo.
    +    The new "uploadpack.lazyFetchTrusted" protected config variable is not
    +    about overriding an environment variable. It's rather about teaching
    +    the code that automatically sets `GIT_NO_LAZY_FETCH` (because it had no
    +    way to know if the served repo could be trusted) to look at the new
    +    config variable to find out if a server operator actually vouched for
    +    that repo.
    +
    +    Let's implement that, so we now have the following cases:
    +
    +      - if `GIT_NO_LAZY_FETCH` is already set, we honor it and leave it
    +        alone, as it comes from the server operator,
    +
    +      - otherwise, if the served repo is in the
    +        "uploadpack.lazyFetchTrusted" allowlist, we don't disable lazy
    +        fetching,
    +
    +      - otherwise, we disable lazy fetching, as we used to.
    +
    +    This allows `upload-pack` and its `pack-objects` child process to
    +    lazily fetch the objects they need to serve a client, for example when
    +    the filter used by the client and the one used by the server don't
    +    match.
    +
    +    Note that what a server operator vouches for by listing a repo there
    +    is that the promisor remotes this repo is configured to lazily fetch
    +    from, as well as its configuration and hooks, are trustworthy. Whether
    +    a client trusts the repo it fetches from is a separate matter, and up
    +    to the client.
     
         As `GIT_NO_LAZY_FETCH` is passed down to child processes through the
         environment, this works for `pack-objects`, which performs the lazy
    @@ Documentation/git.adoc: for full details.
     
      ## builtin/upload-pack.c ##
     @@ builtin/upload-pack.c: int cmd_upload_pack(int argc,
    - 		OPT_END()
    - 	};
    - 	unsigned enter_repo_flags = ENTER_REPO_ANY_OWNER_OK;
    -+	bool no_lazy_fetch_set;
    - 
      	packet_trace_identity("upload-pack");
      	disable_replace_refs();
      	save_commit_buffer = 0;
    -+
    -+	no_lazy_fetch_set = !!getenv(NO_LAZY_FETCH_ENVIRONMENT);
    - 	xsetenv(NO_LAZY_FETCH_ENVIRONMENT, "1", 0);
    +-	xsetenv(NO_LAZY_FETCH_ENVIRONMENT, "1", 0);
      
      	argc = parse_options(argc, argv, prefix, options, upload_pack_usage, 0);
    + 
     @@ builtin/upload-pack.c: int cmd_upload_pack(int argc,
      	if (!enter_repo(the_repository, dir, enter_repo_flags))
      		die("'%s' does not appear to be a git repository", dir);
      
     +	/*
    -+	 * Relax the GIT_NO_LAZY_FETCH=1 default if the served repo is in
    -+	 * the "uploadpack.lazyFetchTrusted" protected allowlist and
    -+	 * GIT_NO_LAZY_FETCH was not already set explicitly.
    ++	 * Lazily fetching while serving a client would run `git fetch`,
    ++	 * which may execute arbitrary commands from the configuration
    ++	 * and hooks of the served repo, so we disable it by default as
    ++	 * we trust nobody. There are two ways for a server operator to
    ++	 * allow it though:
    ++	 *
    ++	 *   - if GIT_NO_LAZY_FETCH is already set, we leave it alone and
    ++	 *     honor whatever the operator put there,
    ++	 *
    ++	 *   - otherwise, if the served repo is in the
    ++	 *     "uploadpack.lazyFetchTrusted" protected allowlist, we
    ++	 *     don't disable lazy fetching.
     +	 */
    -+	if (!no_lazy_fetch_set && upload_pack_lazy_fetch_trusted(the_repository))
    -+		xsetenv(NO_LAZY_FETCH_ENVIRONMENT, "0", 1);
    ++	if (!getenv(NO_LAZY_FETCH_ENVIRONMENT) &&
    ++	    !upload_pack_lazy_fetch_trusted(the_repository))
    ++		xsetenv(NO_LAZY_FETCH_ENVIRONMENT, "1", 1);
     +
      	switch (determine_protocol_version_server()) {
      	case protocol_v2:


Christian Couder (5):
  promisor-remote: factor out lazy_fetch_objects()
  setup: extract path_allowlist_apply()
  upload-pack: read uploadpack.lazyFetchTrusted
  promisor-remote: prevent infinite recursion when lazy fetching
  builtin/upload-pack: don't disable lazy fetching on trusted repo

 Documentation/config/uploadpack.adoc  |  49 +++++++++
 Documentation/git-upload-pack.adoc    |   5 +
 Documentation/git.adoc                |   4 +-
 builtin/upload-pack.c                 |  19 +++-
 environment.h                         |   8 ++
 promisor-remote.c                     | 105 ++++++++++++++-----
 setup.c                               | 136 +++++++++++++++---------
 setup.h                               |  50 +++++++++
 t/t0410-partial-clone.sh              |  33 ++++++
 t/t5710-promisor-remote-capability.sh | 142 ++++++++++++++++++++++++++
 upload-pack.c                         |  59 +++++++++++
 upload-pack.h                         |   3 +
 12 files changed, 534 insertions(+), 79 deletions(-)


base-commit: 34f06850c16c7f7ac822b1adc71354f11b0f2ca3
-- 
2.56.0.rc2.20.g34f06850c1

