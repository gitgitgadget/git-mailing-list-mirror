Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4640202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 22:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbdJWWnP (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 18:43:15 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53041 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdJWWnO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 18:43:14 -0400
Received: by mail-it0-f66.google.com with SMTP id j140so7861315itj.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LfmIq3yqLKfWnv2SRtqmmN6q5Vi102LUreW2epRSkPw=;
        b=mMjhBV/gr6OSn0HdnUXY7jt8rVxzcvTR+OTuQ2fn3O4uP278zhuUcIC2Z+jaV/RlS8
         asy6LR6E895iKvQkaWXY7Hn4n2PRwPYxUgbvh1eayzjGqRR/tYUDuFxPfXBQiaQCXYCj
         Mz7xni8nKneMYvhz0OJk/J5YFikpn5UnCvxPGDvbIoGk2zqebBcM6vzX3/ym6mcpOC2d
         AOlUdJK/Aa4g6cKiESH8aV9PrzddIkORYAfBsfUJfCePwjur0HRaXqz6Abwqh33UHoqR
         GQw8eWIiK/r/OK7q17BscaKM4YHa/xn/y3g+6ZaGPNAdWGRlsxtL39FHmiFcMWV2u2XO
         hzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LfmIq3yqLKfWnv2SRtqmmN6q5Vi102LUreW2epRSkPw=;
        b=Fn+8gwr4zOqcpLJ5VwqWBCZgwzEoazFkcRDlNojBvvHjMvfyV2H46QmuejnVkuw2ll
         hGpFBn/pkYWv5ZV9z3EgheTLOlh364mRbYerihjmF1KLVzZAdwBn+hSMKv25vxplRxmP
         rOfgJIZPO3X1K7EgxmTN8FZCbIOMgUBuiO7tA/yvP17G+2JayVFkE9KltoNn+N9E0Qtd
         632mONFz1AE46ONwfv/gCXvH1XcMEk9ulI/G8IqgJKTBIifKyOYrdUy2vlzLwwqe/42E
         Cbv19ivmNuhszbLIlWQnBWoHHYXRvzFlWRtO7PXVhEJGEqGW3qlGi1UC5FajVgKfJZ91
         z1Ag==
X-Gm-Message-State: AMCzsaVOP7KUaridDaIN/tHO9sqdVHggWguMq5HmPovLlIRRtx6AVmJH
        lVCcgd7/c+QKNAgOtVsH5sg=
X-Google-Smtp-Source: ABhQp+Rg1tN6+EAf8wQo0yjcKa0gKm21SEV/jf8vdeOt+GEA5xBUXKI1J2Vnhi0+ui9QY3ROeQ+gVQ==
X-Received: by 10.36.219.198 with SMTP id c189mr10594861itg.29.1508798593600;
        Mon, 23 Oct 2017 15:43:13 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f70sm16236itc.23.2017.10.23.15.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 15:43:12 -0700 (PDT)
Date:   Mon, 23 Oct 2017 15:43:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, sbeller@google.com, William Yan <wyan@google.com>
Subject: Re: [PATCH 3/5] ssh: 'auto' variant to select between 'ssh' and
 'simple'
Message-ID: <20171023224310.o7ftwmbr7n74vvc6@aiede.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-11-bmwill@google.com>
 <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com>
 <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
 <20171023151929.67165aea67353e5c24a15229@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023151929.67165aea67353e5c24a15229@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> The new documentation seems to imply that setting ssh.variant (or
> GIT_SSH_VARIANT) to "auto" is equivalent to not setting it at all, but
> looking at the code, it doesn't seem to be the case (not setting it at
> all invokes checking the first word of core.sshCommand, and only uses
> VARIANT_AUTO if that check is inconclusive, whereas setting
> ssh.variant=auto skips the core.sshCommand check entirely).
>
> Maybe document ssh.variant as follows:
>
>     If unset, Git will determine the command-line arguments to use based
>     on the basename of the configured SSH command (through the
>     environment variable `GIT_SSH` or `GIT_SSH_COMMAND`, or the config
>     setting `core.sshCommand`). If the basename is unrecognized, Git
>     will attempt to detect support of OpenSSH options by first invoking
>     the configured SSH command with the `-G` (print configuration) flag,
>     and will subsequently use OpenSSH options (upon success) or no
>     options besides the host (upon failure).
>
>     If set, Git will not do any auto-detection based on the basename of
>     the configured SSH command. This can be set to `ssh` (OpenSSH
>     options), `plink`, `putty`, `tortoiseplink`, `simple` (no options
>     besides the host), or `auto` (the detection with `-G` as described
>     above). If set to any other value, Git behaves as if this is set to
>     `ssh`.

Good point.  Brandon noticed something similar as well.

Separately from how to document it, what do you think a good behavior
would be?  Should the "auto" configuration trigger command line based
detection just like no configuration at all?  Should the "auto" value
for configuration be removed and that behavior restricted to the
no-configuration case?

I'm tempted to go with the former, which would look like the following.
What do you think?

If this looks good, I can reroll in a moment.

diff --git i/Documentation/config.txt w/Documentation/config.txt
index 4a16b324f0..6dffa4aa3d 100644
--- i/Documentation/config.txt
+++ w/Documentation/config.txt
@@ -2081,20 +2081,21 @@ matched against are those given directly to Git commands.  This means any URLs
 visited as a result of a redirection do not participate in matching.
 
 ssh.variant::
-	Depending on the value of the environment variables `GIT_SSH` or
-	`GIT_SSH_COMMAND`, or the config setting `core.sshCommand`, Git
-	auto-detects whether to pass command-line parameters for use
-	with a simple wrapper script (simple), OpenSSH (ssh), plink, or
-	tortoiseplink.
-+
-The default is `auto`, which means to auto-detect whether the ssh command
-implements OpenSSH options using the `-G` (print configuration) option.
-If the ssh command supports OpenSSH options, it then behaves like `ssh`;
-otherwise, it behaves like `simple`.
-+
-The config variable `ssh.variant` can be set to override this auto-detection;
-valid values are `ssh`, `simple`, `plink`, `putty`, `tortoiseplink`, and
-`auto`.  Any other value will be treated as normal ssh.  This setting can be
+	By default, Git determines the command line arguments to use
+	based on the basename of the configured SSH command (configured
+	using the environment variable `GIT_SSH` or `GIT_SSH_COMMAND` or
+	the config setting `core.sshCommand`). If the basename is
+	unrecognized, Git will attempt to detect support of OpenSSH
+	options by first invoking the configured SSH command with the
+	`-G` (print configuration) option and will subsequently use
+	OpenSSH options (if that is successful) or no options besides
+	the host and remote command (if it fails).
++
+The config variable `ssh.variant` can be set to override this detection:
+valid values are `ssh` (to use OpenSSH options), `plink`, `putty`,
+`tortoiseplink`, `simple` (no options except the host and remote command).
+The default auto-detection can be explicitly requested using the value
+`auto`.  Any other value is treated as `ssh`.  This setting can also be
 overridden via the environment variable `GIT_SSH_VARIANT`.
 +
 The current command-line parameters used for each variant are as
diff --git i/connect.c w/connect.c
index 98f2d9ce57..06bcd3981e 100644
--- i/connect.c
+++ w/connect.c
@@ -785,12 +785,12 @@ enum ssh_variant {
 	VARIANT_TORTOISEPLINK,
 };
 
-static int override_ssh_variant(enum ssh_variant *ssh_variant)
+static void override_ssh_variant(enum ssh_variant *ssh_variant)
 {
 	const char *variant = getenv("GIT_SSH_VARIANT");
 
 	if (!variant && git_config_get_string_const("ssh.variant", &variant))
-		return 0;
+		return;
 
 	if (!strcmp(variant, "auto"))
 		*ssh_variant = VARIANT_AUTO;
@@ -804,8 +804,6 @@ static int override_ssh_variant(enum ssh_variant *ssh_variant)
 		*ssh_variant = VARIANT_SIMPLE;
 	else
 		*ssh_variant = VARIANT_SSH;
-
-	return 1;
 }
 
 static enum ssh_variant determine_ssh_variant(const char *ssh_command,
@@ -815,7 +813,9 @@ static enum ssh_variant determine_ssh_variant(const char *ssh_command,
 	const char *variant;
 	char *p = NULL;
 
-	if (override_ssh_variant(&ssh_variant))
+	override_ssh_variant(&ssh_variant);
+
+	if (ssh_variant != VARIANT_AUTO)
 		return ssh_variant;
 
 	if (!is_cmdline) {
diff --git i/t/t5601-clone.sh w/t/t5601-clone.sh
index 11fa516997..f9a2ae84c7 100755
--- i/t/t5601-clone.sh
+++ w/t/t5601-clone.sh
@@ -373,6 +373,12 @@ test_expect_success 'variant can be overridden' '
 	expect_ssh "-4 -P 123" myhost src
 '
 
+test_expect_success 'variant=auto picks based on basename' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
+	git -c ssh.variant=auto clone -4 "[myhost:123]:src" ssh-auto-clone &&
+	expect_ssh "-4 -P 123" myhost src
+'
+
 test_expect_success 'simple does not support -4/-6' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/simple" &&
 	test_must_fail git clone -4 "myhost:src" ssh-4-clone-simple
