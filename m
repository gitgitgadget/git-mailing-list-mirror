Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAA7334C20
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607854; cv=none; b=GtFUwX+h4JHbC0WGDKUZpVKHqdn4qBu9QBLdZhPKdC0Tzs6iJAABlbgo6FwPRSCtJKDq1mM8GXBix+deyGAByTCZoFQ0OUcpzZdu2wlX8C4viiWYCHH7aAaPNtd2dWxli29MKzGM0trsAK86IsKeSzfsL6dau3T5m9OerrqHhSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607854; c=relaxed/simple;
	bh=76ftagCDRRcts56SnwOh0padUrUpZbGkqU7ipvhi4Ko=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DvQyqBXnJSo4dyNi3QUNgwsMgl0fJ9QNIKzqpYPr1qA2Ao5YY3cYaqUq2QPLSUznMYUOVGghQd4QZ0SxZ+VCpClZGgV04/kFsgTGQf3kgeGDRngkaTtE9I7P99uiPx6er33OFm6Wm+X/0uql04IwqarA12+4gcJE7jSnCSbCJAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwwycXp8; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwwycXp8"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bcfd82f55ebso2118440a12.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 08:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764607849; x=1765212649; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLubXbv9ukGUwnmrIK/VJg/TDaH0OV1hFj1NnxF62Xg=;
        b=FwwycXp8uzkpj6ECyHgLmn7CN4bG+mU/ADe2ItTiAtZibqUkTU3xIOAEgwekSa8F3Z
         yR3XNUfmRfVkKCIh5nBYtNTnMGcCm/1nX/+Mcp+LOJ+P7ip1csLoNhZ+yX8+M9sa0/qd
         rg/KOYn+BI9qs8pMdyFYltIlZlwcpEVLOx9T/+dpcQyR1W6Nu1rXeo6jPVLgO+didvST
         nwipleATzgU4vZmAkv2qSJZWSeIWRkLVtw1FIZ/J+G4e7gAjlVTSnq1iGA5IeU5phLh5
         zfzDj1g5e1BEmcawk4Wkcj/1lFGqMyuhRzFSgQ8tRkH4gTfYxrRHhe6HjvVUXL1FkCJX
         8Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764607849; x=1765212649;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rLubXbv9ukGUwnmrIK/VJg/TDaH0OV1hFj1NnxF62Xg=;
        b=X+FWHqAFUAE/f1eAGPPb8CtX9v7F2548gZ1AM+M/qvKpO0hvBvp0MNwMh/Hb/3hEOw
         XyFEUwEJjSYOS4m14+srxCYiuzooDqzKKX0ha9JXklOqBOuJlWU1ERzuOHR6OLWfdhMd
         Cxz5E/mBmGKQcckSAJoMJ2OW5PB9iW3dhDuMdexFiFSDG0ELzbYWTXapy1baoe8wXqFB
         QzqBrFI2RUV5BolspOGcjzYCsGr842bvmWE150+Wz0yfv/jqOIyyd/wz9mOBya6RPDTZ
         AmdyI85oTOmwrescATD6zITT9V92mVndhG+UpEgLVPV4QMRNe/pT+dRtS+cfDC12UmzI
         TOzA==
X-Gm-Message-State: AOJu0YxpVwJPH5e5TslNcUDFE4k2W8Skxn80DogkdzRrnn7L1e9N9Fqe
	js4Zc6oV6OTrCMMxYMcpohssnVi1U2RF9EY5DWiUsdxNFSe0+mTzW8QOYAmtxA==
X-Gm-Gg: ASbGncuz3t0RZAsiQ+VS4Z6y1QGABudWJJRXGk259DZYNV53dA+zXmL3iIQYQQz3Nk+
	1TbIPT2JrHAqGWTCq9WfPCT2H8hw6fmpuAheH/vogv7QKXosqQxasL+bvrcONJEA6eAPmHjNi1q
	sfv9AIeABjCmqawlV7pbs3ic+EGw7oYhofGK1fsoRPmxpBpACMP5KZoAUCsbCP0fV8vd34TaXmd
	iPmgIbq1GtX07FAEIGyUwpX+N/DNsZsGqeSsUOi+gGk9ZveCLEbTGud8HK6yn06GiGGVYiiFGdn
	cfUMjmrFN7wOhHScXPxyA00jQlKuM6GaAHdF+Hwk8heLEubzwOPfnhLHYeswVtTXv4hyVjebrfr
	EKBbBvbYnM1RwdMgq6W9RHRoAtsBXuhITz01MzpcDFld3hdq4Qp8hRGf8e+28fsBKp+iZ6RLdfT
	rEOPEuXlB5L3c/Gg==
X-Google-Smtp-Source: AGHT+IFOEGS2QkXJrSrEd7Q7cKj61iw6vZktfGP7O61kkoFy3hd4u2Y8Sdsr7Ul71s9fzc4X/IcoIA==
X-Received: by 2002:a17:903:166e:b0:299:dc97:a6c9 with SMTP id d9443c01a7336-29b5e3b6b04mr413923775ad.20.1764607849203;
        Mon, 01 Dec 2025 08:50:49 -0800 (PST)
Received: from [127.0.0.1] ([20.168.106.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb40297sm126792605ad.72.2025.12.01.08.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 08:50:48 -0800 (PST)
Message-Id: <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
In-Reply-To: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 01 Dec 2025 16:50:42 +0000
Subject: [PATCH v2 0/5] Audit and document Scalar config
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    ps@pks.im,
    atthewhughes934@gmail.com,
    johannes.schindelin@gmx.de,
    Derrick Stolee <stolee@gmail.com>

In September [1], we discussed that the Scalar config options could use some
documented justification as well as some comments to the config file that
they were set by Scalar. I was then immediately distracted by other work
things and am finally here with a series to do just that.

[1]
https://lore.kernel.org/git/ffa61066-7004-48dd-9096-85b305373bc7@gmail.com/

I have indeed used Patrick's idea to add '# set by scalar' to each line
added by Scalar, it took a little more work for all the kinds of config set.
I made myself a co-author.

While working to justify each config option, I found some stale or incorrect
config options. I also relaxed the override setting in most cases which gave
me an opportunity to alphabetize the settings.

There was at least one case (I'm thinking of core.fscache here) where the
config doesn't even exist in core Git, but instead in Git for Windows. We'll
need to adjust in that fork to reinclude it in the right place.


Updates in V2
=============

 * The config-setting code is simplified somewhat.
 * Use 'sane_unset' instead of 'export' in test.
 * Documentation is improved for typos, grammar, and clarity.

Thanks, -Stolee

Derrick Stolee (5):
  scalar: annotate config file with "set by scalar"
  scalar: use index.skipHash=true for performance
  scalar: remove stale config values
  scalar: alphabetize and simplify config
  scalar: document config settings

 Documentation/scalar.adoc | 158 ++++++++++++++++++++++++++++++++++++++
 scalar.c                  |  83 ++++++++++----------
 t/t9210-scalar.sh         |  25 +++---
 3 files changed, 218 insertions(+), 48 deletions(-)


base-commit: 6ab38b7e9cc7adafc304f3204616a4debd49c6e9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2010%2Fderrickstolee%2Fscalar-config-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2010/derrickstolee/scalar-config-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2010

Range-diff vs v1:

 1:  a4ad8f80d0 ! 1:  639ff98c44 scalar: annotate config file with "set by scalar"
     @@ Commit message
          recommendations.
      
          Add "# set by scalar" to the end of each config option to assist users
     -    in identifying why these config options were set in their repo.
     +    in identifying why these config options were set in their repo. Use a new
     +    helper method to simplify the two callsites.
      
          Co-authored-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Patrick Steinhardt <ps@pks.im>
     @@ scalar.c
       
       static void setup_enlistment_directory(int argc, const char **argv,
       				       const char * const *usagestr,
     -@@ scalar.c: static int set_scalar_config(const struct scalar_config *config, int reconfigure
     +@@ scalar.c: struct scalar_config {
     + 	int overwrite_on_reconfigure;
     + };
     + 
     ++static int set_config_with_comment(const char *key, const char *value)
     ++{
     ++	char *file = repo_git_path(the_repository, "config");
     ++	int res = repo_config_set_multivar_in_file_gently(the_repository, file,
     ++							  key, value, NULL,
     ++							  " # set by scalar", 0);
     ++	free(file);
     ++	return res;
     ++}
     ++
     + static int set_scalar_config(const struct scalar_config *config, int reconfigure)
       {
       	char *value = NULL;
     - 	int res;
     -+	char *file = repo_git_path(the_repository, "config");
     - 
     +@@ scalar.c: static int set_scalar_config(const struct scalar_config *config, int reconfigure
       	if ((reconfigure && config->overwrite_on_reconfigure) ||
       	    repo_config_get_string(the_repository, config->key, &value)) {
       		trace2_data_string("scalar", the_repository, config->key, "created");
      -		res = repo_config_set_gently(the_repository, config->key, config->value);
     -+		res = repo_config_set_multivar_in_file_gently(the_repository, file, config->key,
     -+							      config->value, NULL,
     -+							      " # set by scalar", 0);
     ++		res = set_config_with_comment(config->key, config->value);
       	} else {
       		trace2_data_string("scalar", the_repository, config->key, "exists");
       		res = 0;
     - 	}
     - 
     -+	free(file);
     - 	free(value);
     - 	return res;
     - }
      @@ scalar.c: static int set_recommended_config(int reconfigure)
     - 	 * for multiple values.
     - 	 */
       	if (repo_config_get_string(the_repository, "log.excludeDecoration", &value)) {
     -+		char *file = repo_git_path(the_repository, "config");
       		trace2_data_string("scalar", the_repository,
       				   "log.excludeDecoration", "created");
      -		if (repo_config_set_multivar_gently(the_repository, "log.excludeDecoration",
     -+		if (repo_config_set_multivar_in_file_gently(the_repository, file,
     -+						    "log.excludeDecoration",
     - 						    "refs/prefetch/*",
     +-						    "refs/prefetch/*",
      -						    CONFIG_REGEX_NONE, 0))
     -+						    CONFIG_REGEX_NONE,
     -+						    " # set by scalar",
     -+						    0))
     ++		if (set_config_with_comment("log.excludeDecoration",
     ++					    "refs/prefetch/*"))
       			return error(_("could not configure "
       				       "log.excludeDecoration"));
     -+		free(file);
       	} else {
     - 		trace2_data_string("scalar", the_repository,
     - 				   "log.excludeDecoration", "exists");
      
       ## t/t9210-scalar.sh ##
      @@ t/t9210-scalar.sh: test_expect_success 'scalar reconfigure' '
 2:  1c51dbb814 ! 2:  10e9548955 scalar: use index.skipHash=true for performance
     @@ t/t9210-scalar.sh: test_expect_success 'scalar reconfigure --all with includeIf.
       test_expect_success 'scalar reconfigure --all with detached HEADs' '
      +	# This test demonstrates an issue with index.skipHash=true and
      +	# this test variable for the split index. Disable the test variable.
     -+	GIT_TEST_SPLIT_INDEX= &&
     -+	export GIT_TEST_SPLIT_INDEX &&
     ++	sane_unset GIT_TEST_SPLIT_INDEX &&
      +
       	repos="two three four" &&
       	for num in $repos
 3:  156be69a79 = 3:  8783db6153 scalar: remove stale config values
 4:  9b8ce6ba2b = 4:  edc0254770 scalar: alphabetize and simplify config
 5:  18580f020d ! 5:  ac1627dbd9 scalar: document config settings
     @@ Commit message
          Add user-facing documentation that justifies the values being set by
          'scalar clone', 'scalar register', and 'scalar reconfigure'.
      
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Helped-by: Patrick Steinhardt <ps@pks.im>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/scalar.adoc ##
     @@ Documentation/scalar.adoc: delete <enlistment>::
      +	While the preferred version is 2 for performance reasons, existing users
      +	that had version 1 by default will need special care in upgrading to
      +	version 2. This is likely to change in the future as the upgrade story
     -+	is solidifies.
     ++	solidifies.
      +
      +core.autoCRLF=false::
      +	This removes the transformation of worktree files to add CRLF line
     @@ Documentation/scalar.adoc: delete <enlistment>::
      +
      +fetch.unpackLimit=1::
      +	This setting prevents Git from unpacking packfiles into loose objects
     -+	as they are downloaded from the server. This feature was intended as a
     -+	way to prevent performance issues from too many packfiles, but Scalar
     -+	uses background maintenance to group packfiles and cover them with a
     -+	multi-pack-index, removing this issue.
     ++	as they are downloaded from the server. The default limit of 100 was
     ++	intended as a way to prevent performance issues from too many packfiles,
     ++	but Scalar uses background maintenance to group packfiles and cover them
     ++	with a multi-pack-index, removing this issue.
      +
      +fetch.writeCommitGraph=false::
     -+	This config setting was created to help users automatically udpate their
     ++	This config setting was created to help users automatically update their
      +	commit-graph files as they perform fetches. However, this takes time
      +	from foreground fetches and pulls and Scalar uses background maintenance
      +	for this function instead.
     @@ Documentation/scalar.adoc: delete <enlistment>::
      +
      +index.threads=true::
      +	This tells Git to automatically detect how many threads it should use
     -+	when reading the index in parallel due to the `core.preloadIndex=true`
     -+	setting.
     ++	when reading the index due to the default value of `core.preloadIndex`,
     ++	which enables parallel index reads.
      +
      +index.version=4::
      +	This index version adds compression to the path names, reducing the size

-- 
gitgitgadget
