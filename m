Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEAB256D
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205110; cv=none; b=HN/3A6znLNSc9wEQMEukDlsW+HClE7NsNxOojnZ0RAEknt8zo17hb6K6m5V4INdBXK+dr6izG3dg52fJFlTAmQ20pjTkirSkmemV7zQ28hmBYB5zAjNzNqkQ6PY7FN3MBqCGH7EH1NgqqyKBkC6OWbnLoFpQpu8hNKw6b4tbbYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205110; c=relaxed/simple;
	bh=Avvk0o80E+S7OoD5ePxrtQo5ieIpkhOv2xGGNYNTZHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ro7Bi3DsQxEtGQp7gREUpOiJmhbwlRleA0P+Idmv5UNpcvgQ+wL/1A1HtKfc/SARkZQrXPKq5gwGie6CMWYn5JePy3Xh8vK4bRWHkWr9G0jMHPbHgdDwYX/+iKrB0aDyFaDwf2m0aL8Rj4mTvycE0J29N79eFAYSPP4idDOy2ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwWwixuS; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwWwixuS"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bccd251d622so639440766b.3
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779205106; x=1779809906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xakLkCccoGJrkhDy26/jQuVqoE7BDy2QWP3dQQBTf0=;
        b=DwWwixuS0WeVnpyHUyB0Iwd7uU5P+bmGKadBgXRkQEs3FZ//DvHmDs4Ib0J/67A0A3
         /QNpjgdN7OakfVBpkREElV1NSajA9NWdvR425wRWuUx0oUpS1VNG/F252R1SdLwQq5n+
         t4qPJcg/tlVyZsiwknz1Mo11UauRw8D91uyI0o36Pnkw8mmD8rqYgjxoCLNi3HbcRAmP
         qYyjUhBzH0CrwbR/2CJtKWIIFcvhQ0+tBcqxh/qGAZ3BUkmLbrJbHsRXX++rRFwQFrDz
         NHn3ithd5mr7hSsBB2mEwh6Pp3hxzq/5YA08yA/6qQuWVaQ40GFEpUU//6sO0m/9P98H
         5fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205106; x=1779809906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3xakLkCccoGJrkhDy26/jQuVqoE7BDy2QWP3dQQBTf0=;
        b=iCquWSiSdTShZBNpglKv+aSmP8exQxyMgPoQBcbxhAcd5NR+nqh4x0YD5LXKCEba5S
         7hpyPVrdtNuXRwyCy7aiquGUl3KG2WpUJQNgu3tf+WHKKDxhQN4uIuArvwCbfqPTOTvI
         Il7TQvLQn3N8TmUIvPymNK64+LAASyHaCiQzHVurZoAsMP+mz3WvFKM6VzlV3KDwu3qb
         moTNNCwVQWs4+tbfjqXUvrdJ25isj750zaV42Gwy/QS135VvrZppt14chA4nBwndPjy8
         yubzpTir6SNlhpj/0Y4A9fD6uV6WcTKYXBi7QvrPjP9RC3wRPyXD1FuQySq2OBX+j7ah
         nAcg==
X-Gm-Message-State: AOJu0YxCjGJu0FsIycIRFLGP5CjxdPeUmepsAWqcNN/ZXjRvKLr9Ac7o
	XgxxpXM0MVLLRqlcYKHDs4LkJm1hvYxzLZ0CbYRTWsH5v6tcQyKs09v6IY4MPg==
X-Gm-Gg: Acq92OGG8eaBCl1gApd47BpSx5LQbRErtjWSGMIoYAwHtkdV/bbPDx5D7aUiTjzG5ZW
	PRi5txnLrr115m0Wdl9Vet80MLtUCceAXQEnENYj4GKCcoHYogbiOTQkBsX/k5g5cBaYpVaKG5b
	AFYJHkmOxVcDiLAYBmGF3piXLkdwJRqNMhD+RJZybCZv1oJbpqmLPEjJ1/6H2pdPUG5/UPa8Lnv
	GKS9UGZEicjKiUWmBHdmuoqa4VhB8Z42DLTi/Buni8CRy+qPgZfAIVnyU4ooIOsjIu78GAsUSu5
	K5Zi41ej1KPrzTVHun+t1X33w4Z7m3AHNhOCFb7aXSVGk050WtkmikQyVzcwCtPS7PF57Qt6+uP
	gPbFc+gxCl5OmdwZ2UYACLS+XxDxNB4nnG4cUr06KC8FmRLqTJoHxKz+Q6BD75DSMOEz7+n7FRE
	R+F0SBFW3snYqHhWv+TM2fGnumyAMu9ZjoKrSMcGVb96j2TVVH2iJ27hmxTpAcxcNWJU2eFzzTk
	dq/bm6cdRCOK0O44S7LVtMx5zfYO7soYA7QlqFVuOsy4LIomyPcq/AoSvdb
X-Received: by 2002:a17:907:1b27:b0:bd4:e62e:d399 with SMTP id a640c23a62f3a-bd51797a024mr1135989366b.26.1779205105339;
        Tue, 19 May 2026 08:38:25 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd7bbae7a93sm281403766b.22.2026.05.19.08.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:38:24 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 0/8] Auto-configure advertised remotes via URL allowlist
Date: Tue, 19 May 2026 17:38:00 +0200
Message-ID: <20260519153808.494105-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.136.g92075d88d8
In-Reply-To: <20260427124108.3524129-1-christian.couder@gmail.com>
References: <20260427124108.3524129-1-christian.couder@gmail.com>
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

Changes compared to v2
======================

Thanks to Toon, Patrick and Junio for reviewing the previous versions
of this series and of the preparatory series.

This series has been rebased on top of master now that the preparatory
series has been merged in a19de4d24a (Merge branch
'cc/promisor-auto-config-url', 2026-05-11).

Only the following patches changed:

 - Patch 6/8 (promisor-remote: trust known remotes matching acceptFromServerUrl)

   - The WM_PATHNAME flag is not used anymore when calling wildmatch().

   - The match_one_url() function has been refactored using a new
     match_pattern_url() helper function. There is no double negation
     anymore.

   - The call to url_matches_accept_list() in should_accept_remote()
     has been moved up to make sure `promisor.acceptFromServerUrl`
     takes precedence over `promisor.acceptFromServer`.

   - It's documented that the username and password components of the
     URL are intentionally ignored during matching.

   - The documentation now clarifies how
     `promisor.acceptFromServerUrl` interacts with
     `promisor.acceptFromServer`.

 - Patch 7/8 (promisor-remote: auto-configure unknown remotes)

   - The call to should_accept_new_remote_url() is now before the
     `accept == ACCEPT_ALL` check.

   - The documentation continues to clarify how
     `promisor.acceptFromServerUrl` interacts with
     `promisor.acceptFromServer`.

CI tests
========

They all pass, see:

https://github.com/chriscool/git/actions/runs/26103407562

Range diff since v2
===================

1:  44e9a16455 = 1:  ab231c0896 t5710: simplify 'mkdir X' followed by 'git -C X init'
2:  42f174910c = 2:  b3e66f329f urlmatch: change 'allow_globs' arg to bool
3:  8088374458 = 3:  813d748dd6 urlmatch: add url_normalize_pattern() helper
4:  6bfda89a79 = 4:  e92863bee8 promisor-remote: add 'local_name' to 'struct promisor_info'
5:  fefa17e6dd = 5:  7e1b106404 promisor-remote: introduce promisor.acceptFromServerUrl
6:  2f238d0a7a ! 6:  f00eed4bf2 promisor-remote: trust known remotes matching acceptFromServerUrl
    @@ Commit message
         returns the first matching allowed_url entry (or NULL).
     
         The URL matching is done component by component: scheme and port are
    -    compared exactly, the host is matched with wildmatch() using the
    -    WM_PATHNAME flag (so '*' cannot cross the '/' boundary into the path),
    -    and the path is matched with wildmatch() without WM_PATHNAME (so '*'
    -    can still match multi-level paths). Before matching, the advertised
    -    URL is passed through url_normalize() so that case variations in the
    -    scheme/host, percent-encoding tricks, and ".." path segments cannot
    -    bypass the allowlist.
    +    compared exactly, the host and path are matched with wildmatch().
    +    Before matching, the advertised URL is passed through url_normalize()
    +    so that case variations in the scheme/host, percent-encoding tricks,
    +    and ".." path segments cannot bypass the allowlist.
     
    -    Let's then use this helper at the tail of should_accept_remote() so
    -    that, when `accept == ACCEPT_NONE`, a known remote whose URL matches
    -    the allowlist is still accepted.
    +    The username and password components of the URL are intentionally
    +    ignored during matching to allow servers to rotate them, though using
    +    the 'token' field of the capability is preferred over embedding
    +    credentials in the URL.
    +
    +    Let's then use this helper in should_accept_remote() so that, a known
    +    remote whose URL matches the allowlist is accepted.
     
         To prepare for this new logic, let's also:
     
    @@ Commit message
     
          - Replace the BUG() guard in the ACCEPT_KNOWN_URL case with an
            explicit 'if (accept == ACCEPT_KNOWN_URL) return' and a new
    -       BUG() guard in the ACCEPT_NONE case, so url_matches_accept_list()
    -       is only called in the ACCEPT_NONE case.
    +       BUG() guard in the ACCEPT_NONE case.
     
          - Call accept_from_server_url() from filter_promisor_remote()
            and relax its early return so that the function is entered when
    @@ Commit message
         including the URL normalization behavior and the component-wise
         matching, and let's mention it in "gitprotocol-v2.adoc".
     
    +    Also let's clarify in the documentation how
    +    `promisor.acceptFromServerUrl` interacts with
    +    `promisor.acceptFromServer`:
    +
    +     - Precedence: when both options are set,
    +       `promisor.acceptFromServerUrl` is consulted first. If a matching
    +       pattern leads to acceptance, the remote is accepted regardless of
    +       `promisor.acceptFromServer`. Otherwise the decision is left to
    +       `promisor.acceptFromServer`.
    +
    +     - URL-mismatch guard: even when the advertised URL matches the
    +       allowlist, an already-existing client-side remote whose configured
    +       URL differs from the advertised one is not accepted through
    +       `promisor.acceptFromServerUrl`. `promisor.acceptFromServer=all` and
    +       `=knownName` keep their pre-existing, looser semantics.
    +
    +    The precedence paragraph is intentionally scoped here to known remotes
    +    only (field updates). A following commit that introduces auto-creation
    +    of unknown remotes will extend it to cover that case as well.
    +
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## Documentation/config/promisor.adoc ##
    @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
     +URL will be accepted if it matches _ANY_ glob pattern specified by
     +this option in _ANY_ config file read by Git.
     ++
    ++When both `promisor.acceptFromServer` and `promisor.acceptFromServerUrl`
    ++are set, `promisor.acceptFromServerUrl` is consulted first and takes
    ++precedence: if a matching pattern leads to acceptance (by accepting
    ++field updates for a known remote whose URL matches both the local
    ++configuration and the allowlist), the advertised remote is accepted
    ++regardless of the `promisor.acceptFromServer` setting. If no pattern
    ++in `promisor.acceptFromServerUrl` triggers acceptance, the decision
    ++is left to `promisor.acceptFromServer`.
    +++
    ++Note however that, even when an advertised URL matches a pattern in
    ++`promisor.acceptFromServerUrl`, an already-existing remote on the
    ++client whose name matches the advertised name but whose configured URL
    ++differs from the advertised one will _NOT_ be accepted through
    ++`promisor.acceptFromServerUrl`. This prevents a server from silently
    ++re-pointing an existing client-side remote at a different URL. (Such a
    ++remote may still be accepted through `promisor.acceptFromServer=all`
    ++or `=knownName`, which have their own, looser semantics; see the
    ++documentation of that option.)
    +++
     +Be _VERY_ careful with these patterns: `*` matches any sequence of
     +characters within the 'host' and 'path' parts of a URL (but cannot
     +cross part boundaries). An overly broad pattern is a major security
    @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
     +characters are decoded where possible, and path segments like `..`
     +are resolved. The port must also match exactly (e.g.,
     +`https://example.com:8080/*` will not match a URL advertised on
    -+port 9999).
    ++port 9999). The username and password components of the URL are
    ++ignored during matching. Note that embedding credentials in URLs is
    ++discouraged. Passing authentication tokens via the `token` field of
    ++the `promisor-remote` capability is strongly preferred.
     ++
     +For the security implications of accepting a promisor remote, see the
     +documentation of `promisor.acceptFromServer`. For details on the
    @@ promisor-remote.c: static void load_accept_from_server_url(struct repository *re
      	}
      }
      
    ++static bool match_pattern_url(const char *pat, size_t pat_len,
    ++			      const char *url, size_t url_len)
    ++{
    ++	char *p_str = xstrndup(pat, pat_len);
    ++	char *u_str = xstrndup(url, url_len);
    ++	bool res = !wildmatch(p_str, u_str, 0);
    ++
    ++	free(p_str);
    ++	free(u_str);
    ++
    ++	return res;
    ++}
    ++
     +static bool match_one_url(const struct url_info *pi, const struct url_info *ui)
     +{
     +	const char *pat = pi->url;
     +	const char *url = ui->url;
    -+	char *p_str, *u_str;
    -+	bool res;
     +
     +	/*
     +	 * Schemes must match exactly. They are case-folded by
    @@ promisor-remote.c: static void load_accept_from_server_url(struct repository *re
     +	/*
     +	 * Match host and path separately to prevent a '*' in the host
     +	 * portion of the pattern from matching across the '/'
    -+	 * boundary into the path. Use WM_PATHNAME for the host so '*'
    -+	 * cannot cross '/' there, and 0 for the path so '*' can still
    -+	 * match multi-level paths.
    ++	 * boundary into the path.
     +	 */
     +
    -+	p_str = xstrndup(pat + pi->host_off, pi->host_len);
    -+	u_str = xstrndup(url + ui->host_off, ui->host_len);
    -+	res = !wildmatch(p_str, u_str, WM_PATHNAME);
    -+	free(p_str);
    -+	free(u_str);
    -+
    -+	if (!res)
    -+		return false;
    -+
    -+	p_str = xstrndup(pat + pi->path_off, pi->path_len);
    -+	u_str = xstrndup(url + ui->path_off, ui->path_len);
    -+	res = !wildmatch(p_str, u_str, 0);
    -+	free(p_str);
    -+	free(u_str);
    -+
    -+	return res;
    ++	return match_pattern_url(pat + pi->host_off, pi->host_len,
    ++				 url + ui->host_off, ui->host_len) &&
    ++		match_pattern_url(pat + pi->path_off, pi->path_len,
    ++				  url + ui->path_off, ui->path_len);
     +}
     +
     +static struct allowed_url *url_matches_accept_list(
    @@ promisor-remote.c: static void load_accept_from_server_url(struct repository *re
      {
      	struct promisor_info *p;
     @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
    - 	if (accept == ACCEPT_KNOWN_NAME)
    + 		    "this remote should have been rejected earlier",
    + 		    remote_name);
    + 
    +-	if (accept == ACCEPT_ALL)
    +-		return all_fields_match(advertised, config_info, NULL);
    +-
    + 	/* Get config info for that promisor remote */
    + 	item = string_list_lookup(config_info, remote_name);
    + 
    +-	if (!item)
    ++	if (!item) {
    + 		/* We don't know about that remote */
    ++		if (accept == ACCEPT_ALL)
    ++			return all_fields_match(advertised, config_info, NULL);
    + 		return 0;
    ++	}
    + 
    + 	p = item->util;
    + 
    +-	if (accept == ACCEPT_KNOWN_NAME)
    ++	/* Known remote in the allowlist? */
    ++	if (!strcmp(p->url, remote_url) && url_matches_accept_list(accept_urls, remote_url))
      		return all_fields_match(advertised, config_info, p);
      
     -	if (accept != ACCEPT_KNOWN_URL)
     -		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
    --
    ++	if (accept == ACCEPT_ALL)
    ++		return all_fields_match(advertised, config_info, NULL);
    ++
    ++	if (accept == ACCEPT_KNOWN_NAME)
    ++		return all_fields_match(advertised, config_info, p);
    + 
      	if (strcmp(p->url, remote_url)) {
      		warning(_("known remote named '%s' but with URL '%s' instead of '%s', "
    - 			  "ignoring this remote"),
     @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
      		return 0;
      	}
    @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
     +	if (accept != ACCEPT_NONE)
     +		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
     +
    -+	/*
    -+	 * Even if accept == ACCEPT_NONE, we MUST trust this known
    -+	 * remote to update its token or other such fields if its URL
    -+	 * matches the acceptFromServerUrl allowlist!
    -+	 */
    -+	if (url_matches_accept_list(accept_urls, remote_url))
    -+		return all_fields_match(advertised, config_info, p);
    -+
     +	return 0;
      }
      
7:  a077f33df4 ! 7:  af06fb31db promisor-remote: auto-configure unknown remotes
    @@ Commit message
            handling, and by
          - adding a "remote.<name>.advertisedAs" entry to "remote.adoc".
     
    +    Also let's extend the precedence paragraph added by a previous commit
    +    to mention this new acceptance path: until now, the only way for
    +    `promisor.acceptFromServerUrl` to trigger acceptance was to allow
    +    field updates for a known remote. With this commit, it can also trigger
    +    auto-creation of a previously-unknown remote whose advertised URL
    +    matches the allowlist.
    +
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## Documentation/config/promisor.adoc ##
    @@ Documentation/config/promisor.adoc: promisor.acceptFromServer::
      	tokens) from the server, even if `promisor.acceptFromServer`
      	is set to `none` (the default).
     @@ Documentation/config/promisor.adoc: this option in _ANY_ config file read by Git.
    + +
    + When both `promisor.acceptFromServer` and `promisor.acceptFromServerUrl`
    + are set, `promisor.acceptFromServerUrl` is consulted first and takes
    +-precedence: if a matching pattern leads to acceptance (by accepting
    +-field updates for a known remote whose URL matches both the local
    +-configuration and the allowlist), the advertised remote is accepted
    +-regardless of the `promisor.acceptFromServer` setting. If no pattern
    +-in `promisor.acceptFromServerUrl` triggers acceptance, the decision
    +-is left to `promisor.acceptFromServer`.
    ++precedence: if a matching pattern leads to acceptance (either by
    ++auto-configuring an unknown remote or by accepting field updates for
    ++a known remote whose URL matches both the local configuration and the
    ++allowlist), the advertised remote is accepted regardless of the
    ++`promisor.acceptFromServer` setting. If no pattern in
    ++`promisor.acceptFromServerUrl` triggers acceptance, the decision is
    ++left to `promisor.acceptFromServer`.
    + +
    + Note however that, even when an advertised URL matches a pattern in
    + `promisor.acceptFromServerUrl`, an already-existing remote on the
    +@@ Documentation/config/promisor.adoc: documentation of that option.)
      Be _VERY_ careful with these patterns: `*` matches any sequence of
      characters within the 'host' and 'path' parts of a URL (but cannot
      cross part boundaries). An overly broad pattern is a major security
    @@ Documentation/config/promisor.adoc: this option in _ANY_ config file read by Git
      +
      1. Start with a secure protocol scheme, like `https://` or `ssh://`.
      +
    -@@ Documentation/config/promisor.adoc: are resolved. The port must also match exactly (e.g.,
    - `https://example.com:8080/*` will not match a URL advertised on
    - port 9999).
    +@@ Documentation/config/promisor.adoc: ignored during matching. Note that embedding credentials in URLs is
    + discouraged. Passing authentication tokens via the `token` field of
    + the `promisor-remote` capability is strongly preferred.
      +
     +The glob pattern can optionally be prefixed with a remote name and an
     +equals sign (e.g., `cdn=https://cdn.example.com/*`). If such a prefix
    @@ promisor-remote.c: static struct allowed_url *url_matches_accept_list(
      	struct promisor_info *p;
      	struct string_list_item *item;
     @@ promisor-remote.c: static int should_accept_remote(enum accept_promisor accept,
    - 	/* Get config info for that promisor remote */
    - 	item = string_list_lookup(config_info, remote_name);
      
    --	if (!item)
    -+	if (!item) {
    + 	if (!item) {
      		/* We don't know about that remote */
    --		return 0;
    ++
     +		int res = should_accept_new_remote_url(repo, accept_urls, advertised);
    -+		if (res)
    ++		if (res) {
     +			*reload_config = true;
    -+		return res;
    -+	}
    - 
    - 	p = item->util;
    - 
    ++			return res;
    ++		}
    ++
    + 		if (accept == ACCEPT_ALL)
    + 			return all_fields_match(advertised, config_info, NULL);
    + 		return 0;
     @@ promisor-remote.c: static void filter_promisor_remote(struct repository *repo,
      			string_list_sort(&config_info);
      		}
8:  b68b9497aa = 8:  92075d88d8 doc: promisor: improve acceptFromServer entry


Christian Couder (8):
  t5710: simplify 'mkdir X' followed by 'git -C X init'
  urlmatch: change 'allow_globs' arg to bool
  urlmatch: add url_normalize_pattern() helper
  promisor-remote: add 'local_name' to 'struct promisor_info'
  promisor-remote: introduce promisor.acceptFromServerUrl
  promisor-remote: trust known remotes matching acceptFromServerUrl
  promisor-remote: auto-configure unknown remotes
  doc: promisor: improve acceptFromServer entry

 Documentation/config/promisor.adoc    | 146 +++++++--
 Documentation/config/remote.adoc      |   9 +
 Documentation/gitprotocol-v2.adoc     |   9 +-
 promisor-remote.c                     | 413 ++++++++++++++++++++++++--
 t/t5710-promisor-remote-capability.sh | 202 ++++++++++++-
 urlmatch.c                            |  11 +-
 urlmatch.h                            |  12 +
 7 files changed, 754 insertions(+), 48 deletions(-)

-- 
2.54.0.134.gbbe8e27878.dirty

