Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B794C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 12:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbiHBM3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbiHBM3s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 08:29:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC045141E
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 05:29:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v3so16789790wrp.0
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OhnENNoj5EHHhP9H2QiL94BRJ8H9yULo34s2toG3iy0=;
        b=et4xqj90zKOEMwZ8SbTLWIHtGK7fjQ/WcCRJ694a13FFl5rzKdTnRYEu5rnrJjNhHw
         7DuOz2nzuwAGJB2+Bub8whymdAERcM2NUrLV/OuQy4t2UA5g4Nz2DnAq6Pq0zcuLEAhK
         FU2eZxF4OUyhGbg3Ul7QMsuxXb9UmHYYIGNf4q7G0uRmfLQrAScoVDmEPHCO3wcvBCAD
         dEhiC2aJ6tg8ZY6f2tkyXVT2K0Qru+QI7+QcL5u7BwCjyu72R/TvazgSEEirzzWAi83f
         LKlb3ZrM7hOJMUt2G0Nf2SQlbAY4kzO7R5WK/eqLU2zWP0pr7cwRyODmgo9mAoucaQ81
         AVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OhnENNoj5EHHhP9H2QiL94BRJ8H9yULo34s2toG3iy0=;
        b=Iofb2qrEsfUh9HUCmi1g7w3+x9djiZ8wOx5Es6DnLSl/JLNwbz1D91/rN17zqPykP8
         rRVO076QI2EaDwVdDt4m1GIGmqhmseZo/TkX9DUkZau0JknT7mLjirJL0T2+6JJWlRGm
         /ymX5YXzvgTlyYGBg+6v/wUa/684qhM2lqu38HP34mlhyjiQTKMpM0teT8gyO3xpKnYo
         YjFMoaru/C19JjdsWCWGik+Z24HimlQ0S4PBwHdRm7HQesfjcjRm94vMFsvx7aDraLpw
         gfYtbYsMEwCqwb+muMqaMHkxHDmEGXTNuvagB8kvbJG57nVPtMiHPRIqK3QOOQD1N+sL
         7pnw==
X-Gm-Message-State: ACgBeo0CVeq+Wg3lHhqEMReK6qnBe6nlLVQN6kWY7qcHAiUBGq08lLyC
        PDUEMwnlCB1ZQEar2VdxFi7sHQfIjNQ=
X-Google-Smtp-Source: AA6agR6iCKG8WRtFhH7gLpOFOv1HhsYIGMDME+ECzdprEAaxzpswhIXVuht1VenuIWP1igNJOKAC/Q==
X-Received: by 2002:a5d:64aa:0:b0:21f:12ae:f8ef with SMTP id m10-20020a5d64aa000000b0021f12aef8efmr12576297wrp.452.1659443385550;
        Tue, 02 Aug 2022 05:29:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h6-20020a1ccc06000000b003a0323463absm12396384wmb.45.2022.08.02.05.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 05:29:44 -0700 (PDT)
Message-Id: <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
In-Reply-To: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Aug 2022 12:29:39 +0000
Subject: [PATCH v2 0/5] Bundle URIs II: git clone --bundle-uri
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1300%2Fderrickstolee%2Fbundle-redo%2Fclone-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1300/derrickstolee/bundle-redo/clone-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1300

Range-diff vs v1:

 1:  40808e92afb ! 1:  4df4a1d679a remote-curl: add 'get' capability
     @@ Commit message
          'get <url> <path>' to download the file at <url> into the file at
          <path>.
      
     +    Reviewed-by: Josh Steadmon <steadmon@google.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## Documentation/gitremote-helpers.txt ##
     @@ remote-curl.c: static void parse_fetch(struct strbuf *buf)
       	strbuf_reset(buf);
       }
       
     -+static void parse_get(struct strbuf *buf)
     ++static void parse_get(const char *arg)
      +{
      +	struct strbuf url = STRBUF_INIT;
      +	struct strbuf path = STRBUF_INIT;
     -+	const char *p, *space;
     ++	const char *space;
      +
     -+	if (!skip_prefix(buf->buf, "get ", &p))
     -+		die(_("http transport does not support %s"), buf->buf);
     -+
     -+	space = strchr(p, ' ');
     ++	space = strchr(arg, ' ');
      +
      +	if (!space)
      +		die(_("protocol error: expected '<url> <path>', missing space"));
      +
     -+	strbuf_add(&url, p, space - p);
     ++	strbuf_add(&url, arg, space - arg);
      +	strbuf_addstr(&path, space + 1);
      +
      +	if (http_get_file(url.buf, path.buf, NULL))
     @@ remote-curl.c: static void parse_fetch(struct strbuf *buf)
      +	strbuf_release(&path);
      +	printf("\n");
      +	fflush(stdout);
     -+	strbuf_reset(buf);
      +}
      +
       static int push_dav(int nr_spec, const char **specs)
     @@ remote-curl.c: int cmd_main(int argc, const char **argv)
       			fflush(stdout);
       
      +		} else if (skip_prefix(buf.buf, "get ", &arg)) {
     -+			parse_get(&buf);
     ++			parse_get(arg);
      +			fflush(stdout);
      +
       		} else if (!strcmp(buf.buf, "capabilities")) {
     @@ t/t5557-http-get.sh (new)
      +start_httpd
      +
      +test_expect_success 'get by URL: 404' '
     ++	test_when_finished "rm -f file.temp" &&
      +	url="$HTTPD_URL/none.txt" &&
      +	cat >input <<-EOF &&
      +	capabilities
     @@ t/t5557-http-get.sh (new)
      +
      +	test_must_fail git remote-http $url <input 2>err &&
      +	test_path_is_missing file1 &&
     -+	grep "failed to download file at URL" err &&
     -+	rm file1.temp
     ++	grep "failed to download file at URL" err
      +'
      +
      +test_expect_success 'get by URL: 200' '
     @@ t/t5557-http-get.sh (new)
      +
      +	EOF
      +
     -+	GIT_TRACE2_PERF=1 git remote-http $url <input &&
     ++	git remote-http $url <input &&
      +	test_cmp "$HTTPD_DOCUMENT_ROOT_PATH/exists.txt" file2
      +'
      +
 2:  7d3159f0d9a ! 2:  6a6f1a04889 bundle-uri: create basic file-copy logic
     @@ Commit message
          little benefit. This is especially the case because we expect that most
          bundle URI use will be based on HTTPS instead of file copies.
      
     +    Reviewed-by: Josh Steadmon <steadmon@google.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## Makefile ##
     @@ bundle-uri.h (new)
      +int fetch_bundle_uri(struct repository *r, const char *uri);
      +
      +#endif
     +
     + ## t/t5557-http-get.sh ##
     +@@
     + 
     + test_description='test downloading a file by URL'
     + 
     ++TEST_PASSES_SANITIZE_LEAK=true
     ++
     + . ./test-lib.sh
     + 
     + . "$TEST_DIRECTORY"/lib-httpd.sh
 3:  29e645a54ba ! 3:  00debaf6e77 clone: add --bundle-uri option
     @@ Commit message
          Git to bootstrap the new repository with these bundles before fetching
          the remaining objects from the origin server.
      
     +    Reviewed-by: Josh Steadmon <steadmon@google.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## Documentation/git-clone.txt ##
 4:  f6bc3177332 ! 4:  e4f2dcc7a45 bundle-uri: add support for http(s):// and file://
     @@ Commit message
          Otherwise, check to see if file:// is present and modify the prefix
          accordingly.
      
     +    Reviewed-by: Josh Steadmon <steadmon@google.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## bundle-uri.c ##
     @@ bundle-uri.c: static int find_temp_filename(struct strbuf *name)
      +{
      +	const char *out;
      +
     -+	if (skip_prefix(uri, "https:", &out) ||
     -+	    skip_prefix(uri, "http:", &out))
     ++	if (istarts_with(uri, "https:") ||
     ++	    istarts_with(uri, "http:"))
      +		return download_https_uri_to_file(filename, uri);
      +
      +	if (!skip_prefix(uri, "file://", &out))
 5:  e823b168ab7 ! 5:  acee1fae027 clone: --bundle-uri cannot be combined with --depth
     @@ Commit message
          fetch request, but with a list of haves that might cause a more painful
          computation of that shallow pack-file.
      
     +    Reviewed-by: Josh Steadmon <steadmon@google.com>
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## Documentation/git-clone.txt ##

-- 
gitgitgadget
