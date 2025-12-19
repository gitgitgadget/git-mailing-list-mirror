Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA60D35950
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766128738; cv=none; b=IVIbfzRmY2voB0ZivvRYGuu0NAPc6RRwtMGCb3pdAqI4R3BsjNhJdPITMPNNrn+jPAz4SV4UHy5sxVi1VNp8UcbGDXMYKJC90TMX21wG/QViEP5+7IYciBw5LbpIL44Pq1v5g1IPc1v33bk0kMdtGNmmKqggwyFQmtBfwi7k2V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766128738; c=relaxed/simple;
	bh=AiLQDGYrn0xny7bCguSHAL6N/z7QWKMD/v19S3P6r2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9G0vsELt57xaL1R2ZQFYiNQQBPSg3/AcN/I2ANGNyW4q90g1+h8GwXSvJpBg89/svw+SnZ6jLgKdAcCYQQlGyjn2h0tolgKhGj4DbS0Yq6LustE8Y3Gv7Bt2uluRizRDyu2++G+WkSQTQxP/Uyf6DH/UjzMkQ9bJk6h+PifvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EysnH7nk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oVmkodId; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EysnH7nk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oVmkodId"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC9C27A00AE;
	Fri, 19 Dec 2025 02:18:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 19 Dec 2025 02:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766128735; x=1766215135; bh=+sirKAjcnL
	+v83IDRj91r/Jy1QOCVbHAb2BVd+I9MHY=; b=EysnH7nkE1knoBekZyC1XjQzmj
	R2a5ZtSTaeJ8ZwqwbU6Xz/7lLhtKylF0rCCn3nkSs2ILI18yZdz5+vc16H/PpdA3
	puQPgViNqcCSu/ATqUB3yGZjiSVp7SJyp0qmulgJs6drlQA21iELRup5JZFNHW8k
	aEM+8Hs1XZoe6ZNfqqnFGm7h+SN5EA5elAX3c6n70mYyiSbzoPRMSecA3ZaQHa3t
	Zh7pUmRcTkNAu4I9+um1DLiyaaZn1i+ZI520DDDgdg6ZSebSn401r+BnadS4cwj0
	Sd7dcV82b3ZoLOeWtsWo5xCw33B6TTroAjZ/XGF3Qb1ijMOKsVnh7vXQ05gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766128735; x=1766215135; bh=+sirKAjcnL+v83IDRj91r/Jy1QOCVbHAb2B
	Vd+I9MHY=; b=oVmkodIdzvUoQhmbOZ+9AS7tNyJyzlTOVeGGiHApu4hJuInfyrv
	vdoEkvTnPA/72Ha8azsGygpHEaR+tKzXO42uENNaPdyqqox/4mSugU7vA55vL1aC
	8diRoMC3zUTdoyy/qzsIsjHkZajSxvq+hw+PkoN2xNgUHdz++h9C2Sth7+9kkttP
	NQlZI/kx1SIbjgWYUO71grsa0CIo45mxQ5Dg+AR6fm7OmXaURScf0C7qvy7IDPv8
	CG2bXBVA7yUO6YrtHTSq1qwyuTQEDgUloxMNyWvJ+CMghWAgEFQs8EpPhdU6c52c
	TFNTLDy+wJ7ah85fJSfIGiy4Hojfs/0oX3A==
X-ME-Sender: <xms:X_xEaUR6nyBLxJs8geLNUxQbT-Qa1ladlKFbnONoZJk3qvDXmxl54A>
    <xme:X_xEaZMeQoyMEOkaXnXItJG5OOiKQodZqBS_N6DJiaSK7cZlUfkBlXApsyiLYIFf_
    FpJybiLX5UjbhHUVG1mqVdmHFP3Dt8MJkzximzb9W1h1E2lKZoVnQ>
X-ME-Received: <xmr:X_xEafMeof0n8Nybemhivd7QWNFqZ5NgAZ6F4soE9LluVxME2QaZFkqMAQ3MDIvxU0RHpOsSPHO9eIgTxkP3W9BiZJQHArAfE7vbs1_jC52aqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegjeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhvgifhhhugh
    hhvghsleefgeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:X_xEaRsDN-rG9hrM9CB1IYhwKtUcBarf-cuiO1T4J7De5Y29IB6yOQ>
    <xmx:X_xEaRUQfNeUj54kWkfVPbrhszP-N7D6UjwGowrXCHNzqxLYTlkl3w>
    <xmx:X_xEaRs4M0pgbFyQpRUruwprlfzCU0MelrHy0CV0hyUYawZ7i_8Shw>
    <xmx:X_xEaVUv7izYSYuJU5LTqJ4gSpByzUg60uQNFlb-rf8SbdmwieRkbw>
    <xmx:X_xEaQpoDvBbEs3lpIOP95Dnv08yWMqgxDrnsUIQqm_m-lEt3BvPisMT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 02:18:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cad7ca5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Dec 2025 07:18:53 +0000 (UTC)
Date: Fri, 19 Dec 2025 08:18:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Matthew Hughes <matthewhughes934@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 1/1] maintenance: add config option for config-file
Message-ID: <aUT8Vcevf8WiQgn0@pks.im>
References: <20251218184751.31209-1-matthewhughes934@gmail.com>
 <20251218184751.31209-2-matthewhughes934@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218184751.31209-2-matthewhughes934@gmail.com>

On Thu, Dec 18, 2025 at 06:48:19PM +0000, Matthew Hughes wrote:
> This is to allow splitting out this configuration from the global config
> file, e.g.:
> 
>     # in ~/.config/git/config
>     [include]
>         path = maintenance.config
>     [maintenance]
>         # use a separate files for reads/writes from
>         # 'git maintenance {un,}register'
>         configFile = ~/.config/git/maintenance.config
> 
>     # in ~/.config/git/maintenance.config
>     [maintenance]
>         repo = /path/to/some/repo
>         repo = /path/to/another/repo
> 
> My motivation for this is that I track my global config in git, so I'd
> like to avoid changes in there that depend on specific repos/workflows
> that I'm working with.

I think the idea is quite sensible, and I understand the need to split
up static configuration from dynamic one. One part I'm unsure about
though is the explicit need to use "include.path" for this. Ideally,
git-maintenance(1) should by itself know to include the path that the
user has configured in "maintenance.configFile".

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 92c6e7b954..257cceecf6 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -2124,6 +2124,10 @@ static int maintenance_register(int argc, const char **argv, const char *prefix,
>  		usage_with_options(builtin_maintenance_register_usage,
>  				   options);
>  
> +	if (config_file == NULL) {
> +		repo_config_get_pathname(the_repository, "maintenance.configFile", &config_file);
> +	}

Note that in our codebase this would typically be written as:

	if (!config_file)
		repo_config_get_pathname(the_repository, "maintenance.configFile", &config_file);

Note the missing curly braces around a single-line statement as well as
the implicit check for NULL.

It's nice that we only need a two-line change here to make this work.

> @@ -2194,6 +2198,10 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
>  		usage_with_options(builtin_maintenance_unregister_usage,
>  				   options);
>  
> +	if (config_file == NULL) {
> +		repo_config_get_pathname(the_repository, "maintenance.configFile", &config_file);
> +	}

Okay, this is the equivalent for unregistering maintenance. Makes senes.

So these both are straight-forward. The question is whether we can also
easily teach scheduled maintenance to respect `maintenance.configFile`
so that the user doesn't have to manually include the configured file.
I think the answer is "not quite".

The services that scheduled maintenance writes use git-for-each-repo(1)
to iterate through all repositories. We basically execute that command
via `git for-each-repo --config=maintenance.repo -- git maintenance
run --schedule=%%i`. But that command does not have a way to have it
read the configuration from a different file.

I think adding such a feature shouldn't be that hard though. You can use
the below (completely untested) patch as a starter for this. But once we
had such a feature we'd only have to adapt how we write the services
files to pass the new flag in case "maintenance.configFile" is set.

There's two questions in this context:

  - Do we already know to rewrite the service files in case the commands
    that Git would write change?

  - Do we need to migrate any of the preexisting keys that exist in the
    global configuration?

Also Cc'ing Stolee for input.

Thanks!

Patrick

-- >8 --

diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 325a7925f1..874f98ced6 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
+#include "abspath.h"
 #include "config.h"
 #include "gettext.h"
 #include "parse-options.h"
@@ -39,11 +40,16 @@ int cmd_for_each_repo(int argc,
 	int keep_going = 0;
 	int result = 0;
 	const struct string_list *values;
+	struct config_set configset = { 0 };
+	const char *config_file = NULL;
+	char *config_file_to_free = NULL;
 	int err;
 
 	const struct option options[] = {
 		OPT_STRING(0, "config", &config_key, N_("config"),
 			   N_("config key storing a list of repository paths")),
+		OPT_STRING(0, "file", &config_file, N_("file"),
+			   N_("use given config file")),
 		OPT_BOOL(0, "keep-going", &keep_going,
 			 N_("keep going even if command fails in a repository")),
 		OPT_END()
@@ -55,21 +61,38 @@ int cmd_for_each_repo(int argc,
 	if (!config_key)
 		die(_("missing --config=<config>"));
 
-	err = repo_config_get_string_multi(the_repository, config_key, &values);
+	if (config_file) {
+		if (!is_absolute_path(config_file) && prefix)
+			config_file = config_file_to_free = prefix_filename(prefix, config_file);
+
+		git_configset_init(&configset);
+		err = git_configset_add_file(&configset, config_file);
+		if (err < 0)
+			die_errno(_("config file could not be read: '%s'"), config_file);
+
+		err = git_configset_get_string_multi(&configset, config_key, &values);
+	} else {
+		err = repo_config_get_string_multi(the_repository, config_key, &values);
+	}
 	if (err < 0)
 		usage_msg_optf(_("got bad config --config=%s"),
 			       for_each_repo_usage, options, config_key);
 	else if (err)
-		return 0;
+		goto out;
 
 	for (size_t i = 0; i < values->nr; i++) {
 		int ret = run_command_on_repo(values->items[i].string, argc, argv);
 		if (ret) {
-			if (!keep_going)
-					return ret;
+			if (!keep_going) {
+				result = ret;
+				goto out;
+			}
 			result = 1;
 		}
 	}
 
+out:
+	git_configset_clear(&configset);
+	free(config_file_to_free);
 	return result;
 }
