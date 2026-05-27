Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A214D18A6D4
	for <git@vger.kernel.org>; Wed, 27 May 2026 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890923; cv=none; b=E4HlxzvOKAWAMqW/cNH3p3usI3mz+fN/vmMaakyYTqpdjFra0Fp9BQJUyz+i4hX9rKfQgpQsfDrKNSUBILAs96npebbyCFs/hRVGX831t7noWlJKV1ZfAd7D9uXyp4HgFn356KQpLn4EFdnxoDt5W1Ps2Ak6D6koSWthPm29+wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890923; c=relaxed/simple;
	bh=NnQitqlNd/EzdF2KcmzjHJ7+FCrq0PsZoYfmQoM6dR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dC7ZLqysPOFEEw5WqskLWwLDrLZ2SEgUjd51zbCuU6tFu381WzbJcV8wCvEaO8jJeEc4YNMYPMwU7Expak3GCNDHtlsYS538K6tlirRwAZmSOFKUZdhzCiQLMcIBWadi2JDshY+YHw+opkWb1AatrxmeKv3uWHVxwWXgpm303dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy5zz4va; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy5zz4va"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bdb3eb93e20so1094567166b.0
        for <git@vger.kernel.org>; Wed, 27 May 2026 07:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779890920; x=1780495720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1G7AIqWQ2TdpO9lHL4E/1IdMu34lUWHF3kitRr9XTg=;
        b=Oy5zz4vaig9jGF3bMCLxgQZNnxnsDgZKBRMTgO7lv8NeSdBUJNrPHVMwhEweaDUgFe
         JofmKhcP8EVuGgogi0NXU3mliAd4h2/nklln9Sl0+fxA6CXRbADXC4zM64gwI4FoSH2e
         u9txf8qEgw42t1ef56TWUEh4fkYSue5etd/s5KaIomhFGmIZHxBvVZHxur4psENj4XJm
         X8VpQ0qoavJRszANrpbC9u0Bxoqej4zdhgGlYoFtQqWsk5MNvL8eaxSgaRegsRSvme1+
         bf2+BE5EkGLEdt+fvRIoZK7w+fHu7fJj07pMUtZheqwFJS/aHJiDhBzIxw4Tz8pjba51
         /GYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779890920; x=1780495720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m1G7AIqWQ2TdpO9lHL4E/1IdMu34lUWHF3kitRr9XTg=;
        b=bEmk3VsNudhasGl5ZlNDzDECbD3PF22/Pbb3ViDIXodxc2ZwK8e7ZCaSIrerkXwZIt
         0A1Eu5Hc0nuCQvr5RDfGe39yM5Lu9iJ1M8OHISX3PnthXEBYqKppj+UOOT5taMmszD26
         GJnz098L8n7zx3nU8wAIrMBYCP3RI50Q4vO7fftC2fLkqR+YEwx8Tc3qoxpY8+ReGosh
         vvc+Bce/odZGL7o255T0N/RQK0Yqhx3WaTpadhsZcHSHUM3IayJRDDeKNIXUtAAUaUw/
         dNEBsLQB8GLGkQ4/RyptWZpEbuiS3+MJyfi3sJGfBf5zEtFauEAc6tZm/mojAGevA68T
         wypg==
X-Gm-Message-State: AOJu0YxsGFYtQKUmuI5+tysGlNJbnIp9nsbW6X1XbPtp5Y8gLZauB4Ub
	rI/PXqF8vrV5apfpCqbP4qr24AObg+koBnb3B8f+Gz4pCqNoYJQVgXL1Npavag==
X-Gm-Gg: Acq92OF8JHDZFP9bF72BVJIdPENPLBfZ1bXHFIwaotnyt34/FMrdHGlzmihk8lz6ZaO
	5HArQXAco7f0mEUjaDPn0lPsjKhojuIDmyR5eiyFAARSvpX5daOObGiiItSyJU0AuZRkKOEgUsp
	8fKYOMhq7eXI85U23gshbTWpBNjAO0MmUgVngsP96/siWAqxg4iHxaruohP1qvmHtt2oy7YHt61
	NZneeX9+xaX6hBSHHufVnj3xZoUklt9+Tk9TNPihySfTeQcs6OGa0YmF1KLONLhKZehlHB8Pi+i
	mDX1g0L4yj/NLoxZxs7kDxOUMoNWYhAKSBqrxw9z8ln24Xz8nAY3pzCPuHuZIeoMoHhvCXTsze2
	JuujPepY+f800KxUbK3PP52pG7osOEWm6DnFDyFY2dxIEDeSzrH1BuAkxQu+P4Jpumt9t66ApAc
	dAhd3obOH++G0F8opyuBQiB92LS8RSh0E4Gbz/rwuYbsWJ/br+BtpbNHYn4LoqZ5nlS7kZdPKtX
	1u3bLwkiPOG8sqXeVfozdHIBwOcENaLSUqoMa49WpWuDz97aw==
X-Received: by 2002:a17:906:cc59:b0:bda:24df:231 with SMTP id a640c23a62f3a-bdd22a3de07mr961553466b.9.1779890919568;
        Wed, 27 May 2026 07:08:39 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-be1ca138bc7sm268122366b.41.2026.05.27.07.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:08:38 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 0/8] Auto-configure advertised remotes via URL allowlist
Date: Wed, 27 May 2026 16:08:12 +0200
Message-ID: <20260527140820.1438165-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.275.g96c817d129.dirty
In-Reply-To: <20260519153808.494105-1-christian.couder@gmail.com>
References: <20260519153808.494105-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the "promisor-remote" protocol capability allows a server
to advertise promisor remotes (and their tokens/filters), but the
client's `promisor.acceptFromServer` mechanism requires these remotes
to already exist in the config.

This is a significant burden for users and administrators who have to
pre-configure remotes.

This patch series improves on this by introducing a new
`promisor.acceptFromServerUrl` config option, which provides an
additive, URL-based security allowlist.

Multiple `promisor.acceptFromServerUrl` config options can be provided
in different config files. Each one should contain a URL glob pattern
which can optionally be prefixed with a remote name in the
"[<name>=]<pattern>" format.

The goal is for something like a simple:

  git config set --global promisor.acceptFromServerUrl "https://my-org.com/*"

to be all that is needed for internal work in many organizations. 

With this new config option:

 - The server can update fields (like tokens) for known remotes,
   provided their URL matches the allowlist, even if
   `acceptFromServer` is set to `None`.

 - Unknown remotes advertised by the server can be automatically
   configured on the client if their URL matches the allowlist.

 - If there is no `<name>` prefix before the glob pattern matched, the
   auto-configured remote is named using the
   "promisor-auto-<sanitized-url>" format. So the same auto-configured
   remote config entry will be reused for the same URL.

 - If a `<name>` prefix is provided, it will be used for the
   auto-configured remote config entry.

 - If the chosen name (auto-generated or prefixed) already exists but
   points to a different URL, overwriting the existing config is
   prevented by appending a numeric suffix (e.g., -1, -2) to the name
   and auto-configuring using that name.

 - The server's originally advertised name is always saved in the
   `remote.<name>.advertisedAs` config variable of the auto-configured
   remote for tracing and debugging.

Security considerations:

 - Advertised URLs and glob patterns are routed through
   url_normalize() / url_normalize_pattern() before matching, to
   prevent percent-encoding, case variation, or path-traversal (..)
   bypasses.

 - URL matching is done component by component: scheme and port
   must match exactly (no wildcards), the host is matched with
   WM_PATHNAME so a '*' cannot cross the '/' boundary into the
   path, and the path is matched without WM_PATHNAME so '*' can
   still span multi-level paths.

 - Auto-generated remote names are sanitized (non-alphanumeric
   characters are replaced with '-', runs of '-' are collapsed)
   and prefixed with 'promisor-auto-'. User-supplied names (from
   the 'name=<pattern>' syntax) are validated with
   valid_remote_name(). Together, these prevent a server from
   maliciously overwriting standard remotes (like 'origin').

 - If the auto-generated or user-supplied name collides with an
   existing remote configured to a different URL, a numeric
   suffix ('-1', '-2', ...) is appended, up to a bounded limit,
   so a server cannot hijack an existing remote by name.

 - Known remotes are still subject to URL consistency checks:
   even if an advertised URL matches the allowlist, it is only
   accepted for a known remote if it matches the URL already
   configured locally for that remote.

 - The documentation explains in detail how to write secure glob
   patterns in `promisor.acceptFromServerUrl`, and highlights the
   risks of overly broad patterns on shared hosting platforms.

High level description of the patches
=====================================

 - Patch 1/8 is a very small preparatory patch that simplifies some
   tests a bit.

 - Patches 2/8 and 3/8 expose and adapt a url_normalize_pattern()
   helper function in the urlmatch API.

 - Patch 4/8 adapts `struct promisor_info` by adding a new
   `local_name` member to it to prepare for the next patches.

 - Patches 5/8 to 7/8 implement the core feature. They introduce the
   parsing machinery, add the additive allowlist for known remotes
   (with url_normalize() security), and finally implement the
   auto-creation and collision resolution for unknown remotes.

 - Patch 8/8 cleans up and modernizes the existing
   `promisor.acceptFromServer` documentation.

Changes compared to v3
======================

Thanks to Toon, Kristoffer, Patrick and Junio for reviewing the
previous versions of this series and of the preparatory series.

This has been rebased onto master @ 56a4f3c3a2 (The 8th batch,
2026-05-25) to avoid a trivial conflict in "urlmatch.c".

Only minor changes have been made since v3, in the following patches:

 - Patch 4/8 ("promisor-remote: add 'local_name' to 'struct
   promisor_info'"):

   - The promisor_info_internal_name() function has been renamed
     promisor_info_local_name() for clarity.

   - A `const char *local` local variable has been renamed
     `remote_name` for consistency with another similar variable.

 - Patch 6/8 ("promisor-remote: trust known remotes matching
   acceptFromServerUrl"):

   - A spurious comma in the commit message has been deleted.

   - The `promisor.acceptFromServerUrl` documentation in
     "Documentation/config/promisor.adoc" now uses `--` to separate a
     numbered list from the surrounding paragraphs.

CI tests
========

They all pass, see:

https://github.com/chriscool/git/actions/runs/26514308470

Range diff since v3
===================

1:  ab231c0896 = 1:  9fcc7d9d5e t5710: simplify 'mkdir X' followed by 'git -C X init'
2:  b3e66f329f ! 2:  ec558c2b9c urlmatch: change 'allow_globs' arg to bool
    @@ urlmatch.c: static char *url_normalize_1(const char *url, struct url_info *out_i
     +	return url_normalize_1(url, out_info, false);
      }
      
    - static size_t url_match_prefix(const char *url,
    + char *url_parse(const char *url_orig, struct url_info *out_info)
     @@ urlmatch.c: int urlmatch_config_entry(const char *var, const char *value,
      		struct url_info norm_info;
      
3:  813d748dd6 ! 3:  79ee353449 urlmatch: add url_normalize_pattern() helper
    @@ urlmatch.c: char *url_normalize(const char *url, struct url_info *out_info)
     +	return url_normalize_1(url, out_info, true);
     +}
     +
    - static size_t url_match_prefix(const char *url,
    - 			       const char *url_prefix,
    - 			       size_t url_prefix_len)
    + char *url_parse(const char *url_orig, struct url_info *out_info)
    + {
    + 	struct strbuf url;
     
      ## urlmatch.h ##
     @@ urlmatch.h: struct url_info {
    - 
      char *url_normalize(const char *, struct url_info *);
    + char *url_parse(const char *, struct url_info *);
      
     +/*
     + * Like url_normalize(), but also allows '*' glob characters in the host
4:  e92863bee8 ! 4:  037fd46ac7 promisor-remote: add 'local_name' to 'struct promisor_info'
    @@ Commit message
         To prepare for this change, let's add a new 'char *local_name' member
         to 'struct promisor_info', and let's update the related functions.
     
    -    While at it, let's also add a small promisor_info_internal_name()
    -    helper that returns `local_name` when set, `name` otherwise, and let's
    -    use this small helper in promisor_store_advertised_fields() and in the
    +    While at it, let's also add a small promisor_info_local_name() helper
    +    that returns `local_name` when set, `name` otherwise, and let's use
    +    this small helper in promisor_store_advertised_fields() and in the
         post-loop of filter_promisor_remote() so that lookups against the local
         repo configuration use the right name.
     
    @@ promisor-remote.c: static void promisor_info_list_clear(struct string_list *list
      	string_list_clear(list, 0);
      }
      
    -+static const char *promisor_info_internal_name(struct promisor_info *p)
    ++static const char *promisor_info_local_name(struct promisor_info *p)
     +{
     +	return p->local_name ? p->local_name : p->name;
     +}
    @@ promisor-remote.c: static bool promisor_store_advertised_fields(struct promisor_
      	struct promisor_info *p;
      	struct string_list_item *item;
     -	const char *remote_name = advertised->name;
    -+	const char *remote_name = promisor_info_internal_name(advertised);
    ++	const char *remote_name = promisor_info_local_name(advertised);
      	bool reload_config = false;
      
      	if (!(store_info->store_filter || store_info->store_token))
    @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      	for_each_string_list_item(item, accepted_remotes) {
      		struct promisor_info *info = item->util;
     -		struct promisor_remote *r = repo_promisor_remote_find(repo, info->name);
    -+		const char *local = promisor_info_internal_name(info);
    -+		struct promisor_remote *r = repo_promisor_remote_find(repo, local);
    ++		const char *remote_name = promisor_info_local_name(info);
    ++		struct promisor_remote *r = repo_promisor_remote_find(repo, remote_name);
      
      		if (r) {
      			r->accepted = 1;
5:  7e1b106404 = 5:  532adb7ca9 promisor-remote: introduce promisor.acceptFromServerUrl
6:  f00eed4bf2 ! 6:  b970f5647c promisor-remote: trust known remotes matching acceptFromServerUrl
    @@ Commit message
         the 'token' field of the capability is preferred over embedding
         credentials in the URL.
     
    -    Let's then use this helper in should_accept_remote() so that, a known
    +    Let's then use this helper in should_accept_remote() so that a known
         remote whose URL matches the allowlist is accepted.
     
         To prepare for this new logic, let's also:
    @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
     +authentication tokens) on known remotes without further confirmation.
     +To minimize security risks, follow these guidelines:
     ++
    ++--
     +1. Start with a secure protocol scheme, like `https://` or `ssh://`.
     ++
     +2. Only allow domain names or paths where you control and trust _ALL_
    @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
     +   subdomain. This is extremely dangerous on shared hosting platforms
     +   (e.g., `https://*.github.io/*` trusts every user's site on the
     +   entire platform).
    ++--
     ++
     +Before matching, both the advertised URL and the pattern are
     +normalized: the scheme and host are lowercased, percent-encoded
7:  af06fb31db ! 7:  1875228a7b promisor-remote: auto-configure unknown remotes
    @@ Documentation/config/promisor.adoc: documentation of that option.)
     +without further confirmation. To minimize security risks, follow these
     +guidelines:
      +
    + --
      1. Start with a secure protocol scheme, like `https://` or `ssh://`.
    - +
     @@ Documentation/config/promisor.adoc: ignored during matching. Note that embedding credentials in URLs is
      discouraged. Passing authentication tokens via the `token` field of
      the `promisor-remote` capability is strongly preferred.
8:  92075d88d8 = 8:  351ece0b90 doc: promisor: improve acceptFromServer entry


Christian Couder (8):
  t5710: simplify 'mkdir X' followed by 'git -C X init'
  urlmatch: change 'allow_globs' arg to bool
  urlmatch: add url_normalize_pattern() helper
  promisor-remote: add 'local_name' to 'struct promisor_info'
  promisor-remote: introduce promisor.acceptFromServerUrl
  promisor-remote: trust known remotes matching acceptFromServerUrl
  promisor-remote: auto-configure unknown remotes
  doc: promisor: improve acceptFromServer entry

 Documentation/config/promisor.adoc    | 148 +++++++--
 Documentation/config/remote.adoc      |   9 +
 Documentation/gitprotocol-v2.adoc     |   9 +-
 promisor-remote.c                     | 413 ++++++++++++++++++++++++--
 t/t5710-promisor-remote-capability.sh | 202 ++++++++++++-
 urlmatch.c                            |  11 +-
 urlmatch.h                            |  12 +
 7 files changed, 756 insertions(+), 48 deletions(-)

-- 
2.54.0.275.g96c817d129.dirty

