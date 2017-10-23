Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB3A1202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 23:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbdJWX1W (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 19:27:22 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:52269 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdJWX1S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 19:27:18 -0400
Received: by mail-io0-f172.google.com with SMTP id f20so21922187ioj.9
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 16:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yK38VvSxNIOkmNNTGwSJXUh9/YdwCNOyKS5rAmjChR0=;
        b=XUA3tOt4BngrZB97LG9JtnXf9OKkrK5kUYGNZFaKRwsgOej7PASihEl0Ax2uTO6Siu
         YTLQQrYi5Fo5pm9j3d5Cbh/i4ne1hT8rvWxo+JNTYbHh8SUlgDwaGHj08vDtWG/xOg7R
         s3h8fs34D50iFPNeqteIuuyXGYXbqJqjpVCMf6t1/abGvS+2UVwyycUFJ96Sbwf1UeXL
         yULVvGoY0Vywa8l0jgP06J+XFiYMA5f5mZGVpqiFtFmHqaSvLKOhZMyxk2tShjp7+zAo
         qAjV+HAUhN74yGBv6FvAWyrfAm1K/+bQzfpuUKWV/7cYOdsFABGUoqF3TElRhGsdk+0N
         mRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yK38VvSxNIOkmNNTGwSJXUh9/YdwCNOyKS5rAmjChR0=;
        b=Jc5bnMKks692vY0yWDL+c4Cg8Hu0x5Y8mgqkgEXUo5T/SD6+qyu6h1V3l6IT9BTu4k
         Dy3yx+/xI3IjBnBjK1Ub6I+M/MEMTbpoNvpd9Ei+gzC0ptglpx/pDKXm4uITNx+qSurU
         DvlmsRgxU8Rlg3Mu3ErmUu2sbncIPGcVmKYx7gQd1HLFDHZMsMjyd6umoXwehTspmICk
         KNjmHQJwjF0/67ZtC0tk7yEHzxYCVB2a66mcUf3Pu4NaTQBuQTY04GttMsN484mCU3gw
         dqgfBqp3JwHk+eyrEHu9nvNpzEhiUpfNhzEMZaag5jKuXR89ScP+8iCDGDHBd9uygvhE
         JO1w==
X-Gm-Message-State: AMCzsaW2+mSEpbAO8GVTUapTOb/dRxX1r+bUOj9VSb7irFGK/jG0mIvl
        KMsjlum6O0TTYrjcGdZjisonTA==
X-Google-Smtp-Source: ABhQp+TRWl/6+IuOLaP5Xtpvi/vAdM1/L3kg392UUVytAOjBWJqk4/ppjm1P1dtARarLXCu2uEbwTw==
X-Received: by 10.107.47.17 with SMTP id j17mr18103433ioo.96.1508801235970;
        Mon, 23 Oct 2017 16:27:15 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:692b:e84b:6615:aa09])
        by smtp.gmail.com with ESMTPSA id f193sm53803ita.27.2017.10.23.16.27.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 23 Oct 2017 16:27:15 -0700 (PDT)
Date:   Mon, 23 Oct 2017 16:27:13 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, sbeller@google.com,
        William Yan <wyan@google.com>
Subject: Re: [PATCH 3/5] ssh: 'auto' variant to select between 'ssh' and
 'simple'
Message-ID: <20171023232713.GA79163@google.com>
References: <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com>
 <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
 <20171023151929.67165aea67353e5c24a15229@google.com>
 <20171023224310.o7ftwmbr7n74vvc6@aiede.mtv.corp.google.com>
 <20171023225106.GA73667@google.com>
 <20171023155713.5055125d7467d8daaee42e32@google.com>
 <20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com>
 <20171023231839.2g5wudvmoj3hphua@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023231839.2g5wudvmoj3hphua@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/23, Jonathan Nieder wrote:
> Android's "repo" tool is a tool for managing a large codebase
> consisting of multiple smaller repositories, similar to Git's
> submodule feature.  Starting with Git 94b8ae5a (ssh: introduce a
> 'simple' ssh variant, 2017-10-16), users noticed that it stopped
> handling the port in ssh:// URLs.
> 
> The cause: when it encounters ssh:// URLs, repo pre-connects to the
> server and sets GIT_SSH to a helper ".repo/repo/git_ssh" that reuses
> that connection.  Before 94b8ae5a, the helper was assumed to support
> OpenSSH options for lack of a better guess and got passed a -p option
> to set the port.  After that patch, it uses the new default of a
> simple helper that does not accept an option to set the port.
> 
> The next release of "repo" will set GIT_SSH_VARIANT to "ssh" to avoid
> that.  But users of old versions and of other similar GIT_SSH
> implementations would not get the benefit of that fix.
> 
> So update the default to use OpenSSH options again, with a twist.  As
> observed in 94b8ae5a, we cannot assume that $GIT_SSH always handles
> OpenSSH options: common helpers such as travis-ci's dpl[*] are
> configured using GIT_SSH and do not accept OpenSSH options.  So make
> the default a new variant "auto", with the following behavior:
> 
>  1. First, check for a recognized basename, like today.
> 
>  2. If the basename is not recognized, check whether $GIT_SSH supports
>     OpenSSH options by running
> 
> 	$GIT_SSH -G <options> <host>
> 
>     This returns status 0 and prints configuration in OpenSSH if it
>     recognizes all <options> and returns status 255 if it encounters
>     an unrecognized option.  A wrapper script like
> 
> 	exec ssh -- "$@"
> 
>     would fail with
> 
> 	ssh: Could not resolve hostname -g: Name or service not known
> 
>     , correctly reflecting that it does not support OpenSSH options.
> 
>  3. Based on the result from step (2), behave like "ssh" (if it
>     succeeded) or "simple" (if it failed).
> 
> This way, the default ssh variant for unrecognized commands can handle
> both the repo and dpl cases as intended.
> 
> [*] https://github.com/travis-ci/dpl/blob/6c3fddfda1f2a85944c544446b068bac0a77c049/lib/dpl/provider.rb#L215
> 
> Reported-by: William Yan <wyan@google.com>
> Improved-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> This is the main one.  Simplified by making "auto" behave the same as
> unset.

I still don't see the benefit of allowing a user to explicitly set
'auto' then, if setting it to 'auto' is effectively a noop.  But maybe
there's something I'm not seeing.

> 
>  Documentation/config.txt | 24 ++++++++------
>  connect.c                | 82 +++++++++++++++++++++++++++++++-----------------
>  t/t5601-clone.sh         | 20 ++++++++++++
>  3 files changed, 88 insertions(+), 38 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0460af37e2..6dffa4aa3d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2081,16 +2081,22 @@ matched against are those given directly to Git commands.  This means any URLs
>  visited as a result of a redirection do not participate in matching.
>  
>  ssh.variant::
> -	Depending on the value of the environment variables `GIT_SSH` or
> -	`GIT_SSH_COMMAND`, or the config setting `core.sshCommand`, Git
> -	auto-detects whether to adjust its command-line parameters for use
> -	with ssh (OpenSSH), plink or tortoiseplink, as opposed to the default
> -	(simple).
> +	By default, Git determines the command line arguments to use
> +	based on the basename of the configured SSH command (configured
> +	using the environment variable `GIT_SSH` or `GIT_SSH_COMMAND` or
> +	the config setting `core.sshCommand`). If the basename is
> +	unrecognized, Git will attempt to detect support of OpenSSH
> +	options by first invoking the configured SSH command with the
> +	`-G` (print configuration) option and will subsequently use
> +	OpenSSH options (if that is successful) or no options besides
> +	the host and remote command (if it fails).
>  +
> -The config variable `ssh.variant` can be set to override this auto-detection;
> -valid values are `ssh`, `simple`, `plink`, `putty` or `tortoiseplink`. Any
> -other value will be treated as normal ssh. This setting can be overridden via
> -the environment variable `GIT_SSH_VARIANT`.
> +The config variable `ssh.variant` can be set to override this detection:
> +valid values are `ssh` (to use OpenSSH options), `plink`, `putty`,
> +`tortoiseplink`, `simple` (no options except the host and remote command).
> +The default auto-detection can be explicitly requested using the value
> +`auto`.  Any other value is treated as `ssh`.  This setting can also be
> +overridden via the environment variable `GIT_SSH_VARIANT`.
>  +
>  The current command-line parameters used for each variant are as
>  follows:
> diff --git a/connect.c b/connect.c
> index 77ab6db3bb..0441dcbacf 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -777,6 +777,7 @@ static const char *get_ssh_command(void)
>  }
>  
>  enum ssh_variant {
> +	VARIANT_AUTO,
>  	VARIANT_SIMPLE,
>  	VARIANT_SSH,
>  	VARIANT_PLINK,
> @@ -784,14 +785,16 @@ enum ssh_variant {
>  	VARIANT_TORTOISEPLINK,
>  };
>  
> -static int override_ssh_variant(enum ssh_variant *ssh_variant)
> +static void override_ssh_variant(enum ssh_variant *ssh_variant)
>  {
>  	const char *variant = getenv("GIT_SSH_VARIANT");
>  
>  	if (!variant && git_config_get_string_const("ssh.variant", &variant))
> -		return 0;
> +		return;
>  
> -	if (!strcmp(variant, "plink"))
> +	if (!strcmp(variant, "auto"))
> +		*ssh_variant = VARIANT_AUTO;
> +	else if (!strcmp(variant, "plink"))
>  		*ssh_variant = VARIANT_PLINK;
>  	else if (!strcmp(variant, "putty"))
>  		*ssh_variant = VARIANT_PUTTY;
> @@ -801,18 +804,18 @@ static int override_ssh_variant(enum ssh_variant *ssh_variant)
>  		*ssh_variant = VARIANT_SIMPLE;
>  	else
>  		*ssh_variant = VARIANT_SSH;
> -
> -	return 1;
>  }
>  
>  static enum ssh_variant determine_ssh_variant(const char *ssh_command,
>  					      int is_cmdline)
>  {
> -	enum ssh_variant ssh_variant = VARIANT_SIMPLE;
> +	enum ssh_variant ssh_variant = VARIANT_AUTO;
>  	const char *variant;
>  	char *p = NULL;
>  
> -	if (override_ssh_variant(&ssh_variant))
> +	override_ssh_variant(&ssh_variant);
> +
> +	if (ssh_variant != VARIANT_AUTO)
>  		return ssh_variant;
>  
>  	if (!is_cmdline) {
> @@ -908,6 +911,38 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
>  	return conn;
>  }
>  
> +static void push_ssh_options(struct argv_array *args, struct argv_array *env,
> +			       enum ssh_variant variant, const char *port,
> +			       int flags)
> +{
> +	if (variant == VARIANT_SSH &&
> +	    get_protocol_version_config() > 0) {
> +		argv_array_push(args, "-o");
> +		argv_array_push(args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
> +		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
> +				 get_protocol_version_config());
> +	}
> +
> +	if (variant != VARIANT_SIMPLE) {
> +		if (flags & CONNECT_IPV4)
> +			argv_array_push(args, "-4");
> +		else if (flags & CONNECT_IPV6)
> +			argv_array_push(args, "-6");
> +	}
> +
> +	if (variant == VARIANT_TORTOISEPLINK)
> +		argv_array_push(args, "-batch");
> +
> +	if (port && variant != VARIANT_SIMPLE) {
> +		if (variant == VARIANT_SSH)
> +			argv_array_push(args, "-p");
> +		else
> +			argv_array_push(args, "-P");
> +
> +		argv_array_push(args, port);
> +	}
> +}
> +
>  /* Prepare a child_process for use by Git's SSH-tunneled transport. */
>  static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
>  			  const char *port, int flags)
> @@ -937,33 +972,22 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
>  
>  	argv_array_push(&conn->args, ssh);
>  
> -	if (variant == VARIANT_SSH &&
> -	    get_protocol_version_config() > 0) {
> -		argv_array_push(&conn->args, "-o");
> -		argv_array_push(&conn->args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
> -		argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
> -				 get_protocol_version_config());
> -	}
> -
> -	if (variant != VARIANT_SIMPLE) {
> -		if (flags & CONNECT_IPV4)
> -			argv_array_push(&conn->args, "-4");
> -		else if (flags & CONNECT_IPV6)
> -			argv_array_push(&conn->args, "-6");
> -	}
> +	if (variant == VARIANT_AUTO) {
> +		struct child_process detect = CHILD_PROCESS_INIT;
>  
> -	if (variant == VARIANT_TORTOISEPLINK)
> -		argv_array_push(&conn->args, "-batch");
> +		detect.use_shell = conn->use_shell;
> +		detect.no_stdin = detect.no_stdout = detect.no_stderr = 1;
>  
> -	if (port && variant != VARIANT_SIMPLE) {
> -		if (variant == VARIANT_SSH)
> -			argv_array_push(&conn->args, "-p");
> -		else
> -			argv_array_push(&conn->args, "-P");
> +		argv_array_push(&detect.args, ssh);
> +		argv_array_push(&detect.args, "-G");
> +		push_ssh_options(&detect.args, &detect.env_array,
> +				 VARIANT_SSH, port, flags);
> +		argv_array_push(&detect.args, ssh_host);
>  
> -		argv_array_push(&conn->args, port);
> +		variant = run_command(&detect) ? VARIANT_SIMPLE : VARIANT_SSH;
>  	}
>  
> +	push_ssh_options(&conn->args, &conn->env_array, variant, port, flags);
>  	argv_array_push(&conn->args, ssh_host);
>  }
>  
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 86811a0c35..df9dfafdd8 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -372,6 +372,12 @@ test_expect_success 'variant can be overriden' '
>  	expect_ssh myhost src
>  '
>  
> +test_expect_success 'variant=auto picks based on basename' '
> +	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
> +	git -c ssh.variant=auto clone -4 "[myhost:123]:src" ssh-auto-clone &&
> +	expect_ssh "-4 -P 123" myhost src
> +'
> +
>  test_expect_success 'simple is treated as simple' '
>  	copy_ssh_wrapper_as "$TRASH_DIRECTORY/simple" &&
>  	git clone -4 "[myhost:123]:src" ssh-bracket-clone-simple &&
> @@ -384,6 +390,20 @@ test_expect_success 'uplink is treated as simple' '
>  	expect_ssh myhost src
>  '
>  
> +test_expect_success 'OpenSSH-like uplink is treated as ssh' '
> +	write_script "$TRASH_DIRECTORY/uplink" <<-EOF &&
> +	if test "\$1" = "-G"
> +	then
> +		exit 0
> +	fi &&
> +	exec "\$TRASH_DIRECTORY/ssh$X" "\$@"
> +	EOF
> +	GIT_SSH="$TRASH_DIRECTORY/uplink" &&
> +	export GIT_SSH &&
> +	git clone "[myhost:123]:src" ssh-bracket-clone-sshlike-uplink &&
> +	expect_ssh "-p 123" myhost src
> +'
> +
>  test_expect_success 'plink is treated specially (as putty)' '
>  	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
>  	git clone "[myhost:123]:src" ssh-bracket-clone-plink-0 &&
> -- 
> 2.15.0.rc1.287.g2b38de12cc
> 

-- 
Brandon Williams
