Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F357193432
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 23:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732750549; cv=none; b=od+/FSWVZGyCWgXprKZlevSLUwBeKi6aYH/GIhWokNsNLSqOhRztlR++3bbKM/8P9AwzuEXkEFNo19nCAameBix32u5vctMHiOGZnf54mc7nHrmRo1StB6IjZuYLvfv9HIChaRQcS/PVfpZYzpPOF8/qSlrVxMkvDSb08Pvbblo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732750549; c=relaxed/simple;
	bh=04Hw7DLq1qXQbCyyRC4Emi1/ntu+ZgnnhpGc43bC7uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orCAUED0CtBbmDRjoYjXjEvABf+6O7ru7tlu9q1EUILCaskZrIGFv7lNjegXQLkY8JhOhAuWDDhdbPDdaJpGghDjY0XAUzsABUYqMwUtYHeeRhsqB8g5YHwlhTrjDtXu4NnWSCtSFmHCzGiJFXq4hWPTVxw33maqYrcdyKTUnYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSda4iVD; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSda4iVD"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-296994dd3bfso213770fac.0
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 15:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732750547; x=1733355347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwvTvZ4BzN5RYepabfZPe28tGt+iFG6nz+62Z1bGhUU=;
        b=dSda4iVDXT6H1MsmbVEHkeclU6CPUeBLCY6ZZcoGJhvmmpmi1PV7wG7PbHuKN+ubBP
         767JUd83UNcj7saubw82Fd5x+IlN9H9Y+LgBNKsgBop2YUs8gHhz/K0uAvedDigAp7Pm
         JZ3MOivEafk+m0UWh9bWOpV0oQCqupJmaTPaHYM+m8A0lvQbvOl0VWqGtmq2mFFSbmtx
         MrFAK05xcAyOqWMk2t78tfCYCPnp4XeAPNbVgF6I4bDu/SDwQbFM+DcjoJIlatM58T5c
         BmdLKyPkVpNHoSalRiNHHRDWxiSu4YxB4JyRvjoWv2mzEKBRtNd+ftYD2v8Ev2Wf2+y3
         rj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732750547; x=1733355347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwvTvZ4BzN5RYepabfZPe28tGt+iFG6nz+62Z1bGhUU=;
        b=F8jtno1HkGEuH3kTZWxGKXv4httUKRTXoVjf4QkGeBEOMnRsNbRJWl5I4/V/fUVu/J
         M52rOQLFSmhcwhLUzeRMgDjDhIVhGTkqzYyweay8B1Tx2i7xC3kN82znDX5b7QilW3MF
         jH+MgVbPuN1ElJsS1eyZjX55GER5+ofNu8usCu1G/15z3K2Fy4Bvc9SyvlApYvk/U3Tb
         ViqGOWHrsJNZEFrzKuZPEjbKtoD8tvcJGSpFY/HN7b9F/noxMhfvX3jqLEufmyrlLoMM
         +wGTpuRSkp4hPaq4Tz21FOpO7JCWXtQjNb4/mDDeVNNGnyacf+QxbeYsLR3Gl1LlOIof
         IE1w==
X-Gm-Message-State: AOJu0Yzk5PATKbuTbaOdsbWIc3swoEiYjrUt8iYmhzg/4BvCfgBKvLtq
	jcJFcNllpV6ntWuXHydXQILYU9WOZe91tFiXmzIORLSjzcOzu0mi2bbm3g==
X-Gm-Gg: ASbGncvH1hxjPssWToj+kbU6Pyn5fj6Klruy2Zwoyw3f6aXE7Ba1m1XWTwsclRjQ4yW
	kph1GVSgNCJEX0HSGBgo89THOSEBdT24iEpCBFuKwpiF9WPbiaWA7A4rwaWvB17Vppv68VdiRUA
	8YLq8RCuxom4lL8HVsn/Khk/iOGLVmayQQdJsufUSB4Xx6l7n+RSEERiuoQPeACLgCiUCbUN2iL
	SnI71F25GYl9J8WN+1GTXFFR8xTNwdYWG8IO6WdydbEY03v4yEM90+3Wg==
X-Google-Smtp-Source: AGHT+IHlqPr6L6+NGu+kYn6Jzv3RicG/AsBBDXQ8Y9CVe0Q9JVgmWL3PicGgFeS7qDEt0M2TJ38JLQ==
X-Received: by 2002:a05:6870:a19e:b0:296:a67c:d239 with SMTP id 586e51a60fabf-29dc4008d30mr4102190fac.12.1732750546773;
        Wed, 27 Nov 2024 15:35:46 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29de8f31cefsm109260fac.2.2024.11.27.15.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 15:35:46 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 0/4] propagate fsck message severity for bundle fetch
Date: Wed, 27 Nov 2024 17:33:08 -0600
Message-ID: <20241127233312.27710-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127005707.319881-1-jltobler@gmail.com>
References: <20241127005707.319881-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

With 63d903ff52 (unbundle: extend object verification for fetches,
2024-06-19), fsck checks are now performed on fetched bundles depending
on `transfer.fsckObjects` and `fetch.fsckObjects` configuration. This
works, but provides no means to override the default fsck message
severity as is done for other git-fetch(1) operations. This series aims
to propagate fsck message severity configuration to the underlying
git-index-pack(1) process executed on the bundle in a similar manner as
done with git-fetch-pack(1).

  - Patches 1 and 2 adapt the bundle subsystem to support additional
    options when performing `unbundle()`.

  - Patch 3 adapts the fetch-pack subsystem to expose a means to
    generate the message configuration arguments.

  - Patch 4 wires the newly generated fsck configuration options to the
    bundle options used when fetching from a bundle.

Changes in V3:

  - The `fetch_pack_fsck_config()` has been updated to now return 1 when
    the provided config variable is undhandled instead of returning -1.
    This allows call sites to properly differentiate between errors and
    unhandled config variables. To make this change, the handling of
    `git_config_path()` errors was updated to return 0 instead of 1.
    Both of these return values considered by `git_config()` to be a
    success so there is no functional change. This allows returning 1 to
    now indicate that the config variable was not process only.

  - Added comment to document expected `fetch_pack_fsck_config()`
    behavior and return values.

  - Small comment style change.

Thanks
-Justin

Justin Tobler (4):
  bundle: add bundle verification options type
  bundle: support fsck message configuration
  fetch-pack: split out fsck config parsing
  transport: propagate fsck configuration during bundle fetch

 builtin/bundle.c        |  2 +-
 bundle-uri.c            |  7 +++++--
 bundle.c                | 13 +++++++++----
 bundle.h                | 17 ++++++++++++++---
 fetch-pack.c            | 26 ++++++++++++++++++--------
 fetch-pack.h            | 11 +++++++++++
 t/t5607-clone-bundle.sh |  7 +++++++
 transport.c             | 26 ++++++++++++++++++++++++--
 8 files changed, 89 insertions(+), 20 deletions(-)

Range-diff against v2:
1:  da47f0aa0f = 1:  da47f0aa0f bundle: add bundle verification options type
2:  19e91c9f99 ! 2:  5dbd0fa6b7 bundle: support fsck message configuration
    @@ bundle.h: int verify_bundle(struct repository *r, struct bundle_header *header,
      
      struct unbundle_opts {
      	enum verify_bundle_flags flags;
    -+	/**
    ++	/*
     +	 * fsck_msg_types may optionally contain fsck message severity
     +	 * configuration. If present, this configuration gets directly appended
     +	 * to a '--fsck-objects' option and therefore must be prefixed with '='.
3:  527874e73d ! 3:  b8db9af9e7 fetch-pack: split out fsck config parsing
    @@ Commit message
         `fetch_pack_fsck_config()` and expose it. In a subsequent commit, this
         is used to provide fsck configuration when invoking `unbundle()`.
     
    +    For `fetch_pack_fsck_config()` to discern between errors and unhandled
    +    config variables, the return code when `git_config_path()` errors is
    +    changed to a different value also indicating success. This frees up the
    +    previous return code to now indicate the provided config variable
    +    was unhandled. The behavior remains functionally the same.
    +
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## fetch-pack.c ##
    @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
      	const char *msg_id;
      
     @@ fetch-pack.c: static int fetch_pack_config_cb(const char *var, const char *value,
    + 		char *path ;
      
      		if (git_config_pathname(&path, var, value))
    - 			return 1;
    +-			return 1;
     -		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
     -			fsck_msg_types.len ? ',' : '=', path);
    ++			return 0;
     +		strbuf_addf(msg_types, "%cskiplist=%s",
     +			msg_types->len ? ',' : '=', path);
      		free(path);
    @@ fetch-pack.c: static int fetch_pack_config_cb(const char *var, const char *value
      	}
      
     -	return git_default_config(var, value, ctx, cb);
    -+	return -1;
    ++	return 1;
     +}
     +
     +static int fetch_pack_config_cb(const char *var, const char *value,
     +				const struct config_context *ctx, void *cb)
     +{
     +	int ret = fetch_pack_fsck_config(var, value, &fsck_msg_types);
    -+	if (ret < 0)
    ++	if (ret > 0)
     +		return git_default_config(var, value, ctx, cb);
     +
     +	return ret;
    @@ fetch-pack.h: int report_unmatched_refs(struct ref **sought, int nr_sought);
       */
      int fetch_pack_fsck_objects(void);
      
    ++/*
    ++ * Check if the provided config variable pertains to fetch fsck and if so append
    ++ * the configuration to the provided strbuf.
    ++ *
    ++ * When a fetch fsck config option is successfully processed the function
    ++ * returns 0. If the provided config option is unrelated to fetch fsck, 1 is
    ++ * returned. Errors return -1.
    ++ */
     +int fetch_pack_fsck_config(const char *var, const char *value,
     +			   struct strbuf *msg_types);
     +
4:  b1a3f73561 ! 4:  cc8ae0a1c4 transport: propagate fsck configuration during bundle fetch
    @@ transport.c: static struct ref *get_refs_from_bundle(struct transport *transport
     +	int ret;
     +
     +	ret = fetch_pack_fsck_config(var, value, msg_types);
    -+	if (ret < 0)
    ++	if (ret > 0)
     +		return 0;
     +
     +	return ret;

base-commit: 4083a6f05206077a50af7658bedc17a94c54607d
-- 
2.47.0

