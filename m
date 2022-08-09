Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86024C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 13:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243494AbiHINLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 09:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbiHINLt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 09:11:49 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447A5108D
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 06:11:48 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l22so14287914wrz.7
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=fNsJBsh0LgRIdqD9bpXaQjkTKMiyH0n7yYsAp7pRiEA=;
        b=EDeIy57LqiCZg51ARz3Bc91zye7CMGv7Owur1H4YAEgQgTlFpUBxKiQu0Xah2xJ6sj
         dby2JeEPZsFnqbJdQjawVn4HM4V0eO+/0yYxl9jP32N4kxaYkSO30F4hTGAXbHtquICl
         cifF2DJcnjdv5R+2pmvXvIysdEFCtoI3uQd1XJ7391nxZFl+RddSZvc96TuLH/cFzyRV
         UStw7nH2mHQN91eNc4IVzS7VqwwlyEJwCWL4F4Dw/kWRPORH5UuEPZv8Vsc8tAdoH76d
         bv5P80bstrMF7bFWjGjW5tzlm0C4tnpI0Gdh0HEE5D04EPnNUna807bmwZ7iQwOihaBl
         EoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=fNsJBsh0LgRIdqD9bpXaQjkTKMiyH0n7yYsAp7pRiEA=;
        b=q/18CPHV++3+2ucWm7CDXKKTucq6PVeUzRXWZonM7CnJMFFQQhSV6WmEjXdt8cYd7B
         E6c9f0dzjyUcGc8c3dvVGsDSDntNYezWZzmoqdwQG4vF+CkFUk4+IDuoSDQIUMbVNE96
         zmZOwAu1N7FH4c7iyfjbcWDb2SwwMYLJ88KQrE2RMttGhVDgeGa7yBYwoKUnx9FW7Tt4
         4oFd6zU0sCGiF7P93UOIwKq9i1KCckTvS83W2nzQ4FawtIOubNDz1+0n+E1aYXxSIuUI
         y3GhcRoPf7hvs2U07mIusuBDUqLE1EcfdAPasaYtTJ3qRLggei1zS5VQhFnhJU1/XtJQ
         F9pw==
X-Gm-Message-State: ACgBeo1E84pTH/LgefuqHouAG77HSjTnJeL7SDPICk8psqrZsIwGf17o
        YIzIAPFvM4qVyV1U2TKt0wpZoIEJwww=
X-Google-Smtp-Source: AA6agR4eNQ6aYmPGi1Bqnw01P1FYprO81RZyJkdyw4Z42DkCXKBkDw+oJuENlhgmHAggOZx1hg2Azg==
X-Received: by 2002:adf:f804:0:b0:21e:de03:b64f with SMTP id s4-20020adff804000000b0021ede03b64fmr13477632wrp.543.1660050706242;
        Tue, 09 Aug 2022 06:11:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17-20020adff051000000b002217e3f41f1sm9544309wro.106.2022.08.09.06.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 06:11:44 -0700 (PDT)
Message-Id: <pull.1300.v3.git.1660050703.gitgitgadget@gmail.com>
In-Reply-To: <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
References: <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Aug 2022 13:11:38 +0000
Subject: [PATCH v3 0/5] Bundle URIs II: git clone --bundle-uri
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second series building the bundle URI feature as discussed in
the previous series that added the design document [1]. This series does not
modify the design document, so the patches are independent and can be
applied to the latest 'master'.

[1]
https://lore.kernel.org/git/pull.1248.v3.git.1658757188.gitgitgadget@gmail.com

This series brings in just enough logic that we can bootstrap clones from a
single bundle using git clone --bundle-uri=<X>.

 * Patch 1 adds a 'get' capability to 'git remote-https' which allows
   downloading the contents of a URI to a local file.
 * Patch 2 creates basic file-copy logic within a new bundle-uri.c file. It
   is not used until patch 3.
 * Patch 3 creates the git clone --bundle-uri=<X> option, allowing Git to
   bootstrap a clone from a bundle, but get the remaining objects from the
   origin URL. (As of this patch, it only accepts a filename.)
 * Patch 4 extends the git clone --bundle-uri=<X> option to allow file://
   and https:// URIs.
 * Patch 5 is a CLI helper to avoid using --bundle-uri and --depth at the
   same time in git clone.

As outlined in [1], the next steps after this are:

 1. Allow parsing a bundle list as a config file at the given URI. The
    key-value format is unified with the protocol v2 verb (coming in (3)).
    [2]
 2. Implement the protocol v2 verb, re-using the bundle list logic from (2).
    Use this to auto-discover bundle URIs during 'git clone' (behind a
    config option). [3]
 3. Implement the 'creationToken' heuristic, allowing incremental 'git
    fetch' commands to download a bundle list from a configured URI, and
    only download bundles that are new based on the creation token values.
    [4]

I have prepared some of this work as pull requests on my personal fork so
curious readers can look ahead to where we are going:

[2] https://github.com/derrickstolee/git/pull/20

[3] https://github.com/derrickstolee/git/pull/21

[4] https://github.com/derrickstolee/git/pull/22

Note: this series includes some code pulled out of the first series [1], and
in particular the git fetch --bundle-uri=<X> option is removed. The
intention was to replace that with git bundle fetch <X>, but that conflicts
with the work to refactor how subcommands are parsed. The git bundle fetch
subcommand could be added later for maximum flexibility on the client side,
but we can also move forward without it.


Updates in v3
=============

 * The protocol matching for "http://", "https://", and "file://" now
   uniformly include the "//" portion and are case-sensitive.


Updates in v2
=============

 * Several typos or small tweaks. See the range-diff for details.

Thanks, -Stolee

Derrick Stolee (5):
  remote-curl: add 'get' capability
  bundle-uri: create basic file-copy logic
  clone: add --bundle-uri option
  bundle-uri: add support for http(s):// and file://
  clone: --bundle-uri cannot be combined with --depth

 Documentation/git-clone.txt         |   7 ++
 Documentation/gitremote-helpers.txt |   9 ++
 Makefile                            |   1 +
 builtin/clone.c                     |  18 +++
 bundle-uri.c                        | 168 ++++++++++++++++++++++++++++
 bundle-uri.h                        |  14 +++
 remote-curl.c                       |  28 +++++
 t/t5557-http-get.sh                 |  39 +++++++
 t/t5558-clone-bundle-uri.sh         |  81 ++++++++++++++
 t/t5606-clone-options.sh            |   8 ++
 10 files changed, 373 insertions(+)
 create mode 100644 bundle-uri.c
 create mode 100644 bundle-uri.h
 create mode 100755 t/t5557-http-get.sh
 create mode 100755 t/t5558-clone-bundle-uri.sh


base-commit: e72d93e88cb20b06e88e6e7d81bd1dc4effe453f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1300%2Fderrickstolee%2Fbundle-redo%2Fclone-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1300/derrickstolee/bundle-redo/clone-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1300

Range-diff vs v2:

 1:  4df4a1d679a = 1:  4df4a1d679a remote-curl: add 'get' capability
 2:  6a6f1a04889 = 2:  6a6f1a04889 bundle-uri: create basic file-copy logic
 3:  00debaf6e77 = 3:  00debaf6e77 clone: add --bundle-uri option
 4:  e4f2dcc7a45 ! 4:  66a1ce40451 bundle-uri: add support for http(s):// and file://
     @@ bundle-uri.c: static int find_temp_filename(struct strbuf *name)
      +	struct strbuf line = STRBUF_INIT;
      +	int found_get = 0;
      +
     -+	strvec_pushl(&cp.args, "git-remote-https", "origin", uri, NULL);
     ++	strvec_pushl(&cp.args, "git-remote-https", uri, NULL);
      +	cp.in = -1;
      +	cp.out = -1;
      +
     @@ bundle-uri.c: static int find_temp_filename(struct strbuf *name)
      +{
      +	const char *out;
      +
     -+	if (istarts_with(uri, "https:") ||
     -+	    istarts_with(uri, "http:"))
     ++	if (starts_with(uri, "https:") ||
     ++	    starts_with(uri, "http:"))
      +		return download_https_uri_to_file(filename, uri);
      +
     -+	if (!skip_prefix(uri, "file://", &out))
     -+		out = uri;
     ++	if (skip_prefix(uri, "file://", &out))
     ++		uri = out;
      +
      +	/* Copy as a file */
     -+	return copy_file(filename, out, 0);
     ++	return copy_file(filename, uri, 0);
       }
       
       static int unbundle_from_file(struct repository *r, const char *file)
 5:  acee1fae027 = 5:  ed76d84c5a7 clone: --bundle-uri cannot be combined with --depth

-- 
gitgitgadget
