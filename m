Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 677681F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 14:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbdAZOv4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 09:51:56 -0500
Received: from mout.gmx.net ([212.227.17.20]:52460 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752277AbdAZOvz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 09:51:55 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLB89-1cX2Nm1zGr-000I1W; Thu, 26
 Jan 2017 15:51:47 +0100
Date:   Thu, 26 Jan 2017 15:51:46 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 0/3] Handle PuTTY (plink/tortoiseplink) even in
 GIT_SSH_COMMAND
In-Reply-To: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de>
Message-ID: <alpine.DEB.2.20.1701261550590.3469@virtualbox>
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xOU9WHX56wGNTbePcDq5SMkeyywyTYWcBL35D4yLMHZiuAQI7qt
 PzTZOqW5utqlc5oMmzmDNfKkgQp+Zj1x6rHap9DEWLRFqnbaHlc1rZNUU9lJUVyL6b02/3t
 0rRPqVrx/KqPLuntHXMwu4/r5seWS5Brn7kNh8VCNnKkAAJpC6y6gQTpsydKBm/A1xrW1Pc
 SBzF8Se5Go5KV9q76xdeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CduQdzpNT+M=:y8Mt3eocSkS/vFS3h47EXa
 eycTEQFYMfHItkE1TAjwHQIL3dQKPmo4d7+LuFf3I5ExjZZCcoFZuuhgMS6/LLRUFohGfRI35
 EaxoEojHTmh9jPyeas7le8DP9UpLrr8j4k6Ur1TuZ/zV3O3j0+UZS1KpKD1/6V9SkqMgfLeux
 1ZsKz88rnoqdF5/IF1C0n74BP88Vr9kZEIJbm+pWZOJUrxQFkYhf8BUFsXRmTt6grG1zk1w75
 jefIo7O/KaKyN6gFBB7QwsW7dgMtfDuVkIMDYRnuKk78Y9Bk7zCI+9DNKt8L7YaJO96YdzMIx
 ASY2uBAg1Q98DEqhmKQEZ0XCC/r/Em9c1SFJk1PupTC0xk8BOR4f2JDoQIhQwxgIJpLTegCOJ
 fHlo9EKMEkQtuK5KdLjVWbdyeKiLw2X0hs5IYZnjiUEh4TxhuMx4zSDSBi+adodZWAY2zDUiV
 /Q9C8sGaRiOSxIW3cY23/xhVd+C3QxuUclvSe5ws/rW9lc6FniWTX+Jx9BkPNtX4Kq13dMzrz
 PlEAUS5LLGJMw/Oh65K0zZgvqrZ28mJW+KktGeT3d1L/DVYHbH+ye8lHgxvjaxPMbbmVnK7R0
 DAA4G7gnyM0jEsvgp+6B0f4Hq8sRNWvtZzEI2YUfgqyRT9TZ51LacqNW3fcB9XjNdUCPfNqcl
 aWaDLffKKwcTlIFqx/SqGr7bLpHuO/MjtPT9Dbj35XhcjjobviNZRB2g+AgQ3Q+IKsffB5sEM
 tuxmL/mHyaCD0yW38+LUvaUQjYhP1vdeEtdPdq8oKzlwRqEX6LQItBskOddT8SLWU24Dyt777
 tWiGCKn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already handle PuTTY's plink and TortoiseGit's tortoiseplink in
GIT_SSH by automatically using the -P option to specify ports, and in
tortoiseplink's case by passing the --batch option.

For users who need to pass additional command-line options to plink,
this poses a problem: the only way to do that is to use GIT_SSH_COMMAND,
but Git does not handle that specifically, so those users have to
manually parse the command-line options passed via GIT_SSH_COMMAND and
replace -p (if present) by -P, and add --batch in the case of
tortoiseplink.

This is error-prone and a bad user experience.

To fix this, the changes proposed in this patch series introduce
handling this by splitting the GIT_SSH_COMMAND value and treating the
first parameter with the same grace as GIT_SSH. To counter any possible
misdetection, the user can also specify explicitly via GIT_SSH_VARIANT
or ssh.variant which SSH variant they are using.

This is v2 of the patch, now turned patch series. Relative to v1, it
integrates Junio's cleanup patch and Segev's follow-up Pull Request that
introduces the GIT_SSH_VARIANT and ssh.variant settings to override
Git's autodetection manually.


Junio C Hamano (1):
  connect: rename tortoiseplink and putty variables

Segev Finer (2):
  connect: handle putty/plink also in GIT_SSH_COMMAND
  connect: Add the envvar GIT_SSH_VARIANT and ssh.variant config

 Documentation/config.txt |  7 +++++
 Documentation/git.txt    |  7 +++++
 connect.c                | 66 +++++++++++++++++++++++++++++++++++-------------
 t/t5601-clone.sh         | 41 ++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+), 17 deletions(-)


base-commit: 4e59582ff70d299f5a88449891e78d15b4b3fabe
Published-As: https://github.com/dscho/git/releases/tag/putty-w-args-v2
Fetch-It-Via: git fetch https://github.com/dscho/git putty-w-args-v2

Interdiff vs v1:

 diff --git a/Documentation/config.txt b/Documentation/config.txt
 index af2ae4cc02..f2c210f0a0 100644
 --- a/Documentation/config.txt
 +++ b/Documentation/config.txt
 @@ -1949,6 +1949,13 @@ Environment variable settings always override any matches.  The URLs that are
  matched against are those given directly to Git commands.  This means any URLs
  visited as a result of a redirection do not participate in matching.
  
 +ssh.variant::
 +	Override the autodetection of plink/tortoiseplink in the SSH
 +	command that 'git fetch' and 'git push' use. It can be set to
 +	either `ssh`, `plink`, `putty` or `tortoiseplink`. Any other
 +	value will be treated as normal ssh. This is useful in case
 +	that Git gets this wrong.
 +
  i18n.commitEncoding::
  	Character encoding the commit messages are stored in; Git itself
  	does not care per se, but this information is necessary e.g. when
 diff --git a/Documentation/git.txt b/Documentation/git.txt
 index 4f208fab92..c322558aa7 100644
 --- a/Documentation/git.txt
 +++ b/Documentation/git.txt
 @@ -1020,6 +1020,13 @@ Usually it is easier to configure any desired options through your
  personal `.ssh/config` file.  Please consult your ssh documentation
  for further details.
  
 +`GIT_SSH_VARIANT`::
 +	If this environment variable is set, it overrides the autodetection
 +	of plink/tortoiseplink in the SSH command that 'git fetch' and 'git
 +	push' use. It can be set to either `ssh`, `plink`, `putty` or
 +	`tortoiseplink`. Any other value will be treated as normal ssh. This
 +	is useful in case that Git gets this wrong.
 +
  `GIT_ASKPASS`::
  	If this environment variable is set, then Git commands which need to
  	acquire passwords or passphrases (e.g. for HTTP or IMAP authentication)
 diff --git a/connect.c b/connect.c
 index c81f77001b..7b4437578b 100644
 --- a/connect.c
 +++ b/connect.c
 @@ -691,6 +691,24 @@ static const char *get_ssh_command(void)
  	return NULL;
  }
  
 +static int handle_ssh_variant(int *port_option, int *needs_batch)
 +{
 +	const char *variant;
 +
 +	if (!(variant = getenv("GIT_SSH_VARIANT")) &&
 +		git_config_get_string_const("ssh.variant", &variant))
 +		return 0;
 +
 +	if (!strcmp(variant, "plink") || !strcmp(variant, "putty"))
 +		*port_option = 'P';
 +	else if (!strcmp(variant, "tortoiseplink")) {
 +		*port_option = 'P';
 +		*needs_batch = 1;
 +	}
 +
 +	return 1;
 +}
 +
  /*
   * This returns a dummy child_process if the transport protocol does not
   * need fork(2), or a struct child_process object if it does.  Once done,
 @@ -769,7 +787,8 @@ struct child_process *git_connect(int fd[2], const char *url,
  		conn->in = conn->out = -1;
  		if (protocol == PROTO_SSH) {
  			const char *ssh;
 -			int putty = 0, tortoiseplink = 0;
 +			int needs_batch = 0;
 +			int port_option = 'p';
  			char *ssh_host = hostandport;
  			const char *port = NULL;
  			char *ssh_argv0 = NULL;
 @@ -816,28 +835,32 @@ struct child_process *git_connect(int fd[2], const char *url,
  				ssh_argv0 = xstrdup(ssh);
  			}
  
 -			if (ssh_argv0) {
 +			if (!handle_ssh_variant(&port_option, &needs_batch) &&
 +			    ssh_argv0) {
  				const char *base = basename(ssh_argv0);
  
 -				tortoiseplink = !strcasecmp(base, "tortoiseplink") ||
 -					!strcasecmp(base, "tortoiseplink.exe");
 -				putty = tortoiseplink ||
 -					!strcasecmp(base, "plink") ||
 -					!strcasecmp(base, "plink.exe");
 -
 -				free(ssh_argv0);
 +				if (!strcasecmp(base, "tortoiseplink") ||
 +				    !strcasecmp(base, "tortoiseplink.exe")) {
 +					port_option = 'P';
 +					needs_batch = 1;
 +				} else if (!strcasecmp(base, "plink") ||
 +					   !strcasecmp(base, "plink.exe")) {
 +					port_option = 'P';
 +				}
  			}
  
 +			free(ssh_argv0);
 +
  			argv_array_push(&conn->args, ssh);
  			if (flags & CONNECT_IPV4)
  				argv_array_push(&conn->args, "-4");
  			else if (flags & CONNECT_IPV6)
  				argv_array_push(&conn->args, "-6");
 -			if (tortoiseplink)
 +			if (needs_batch)
  				argv_array_push(&conn->args, "-batch");
  			if (port) {
 -				/* P is for PuTTY, p is for OpenSSH */
 -				argv_array_push(&conn->args, putty ? "-P" : "-p");
 +				argv_array_pushf(&conn->args,
 +						 "-%c", port_option);
  				argv_array_push(&conn->args, port);
  			}
  			argv_array_push(&conn->args, ssh_host);
 diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
 index 9335e10c2a..b52b8acf98 100755
 --- a/t/t5601-clone.sh
 +++ b/t/t5601-clone.sh
 @@ -401,6 +401,32 @@ test_expect_success 'single quoted plink.exe in GIT_SSH_COMMAND' '
  	expect_ssh "-v -P 123" myhost src
  '
  
 +test_expect_success 'GIT_SSH_VARIANT overrides plink detection' '
 +	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
 +	GIT_SSH_VARIANT=ssh \
 +	git clone "[myhost:123]:src" ssh-bracket-clone-variant-1 &&
 +	expect_ssh "-p 123" myhost src
 +'
 +
 +test_expect_success 'ssh.variant overrides plink detection' '
 +	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
 +	git -c ssh.variant=ssh \
 +		clone "[myhost:123]:src" ssh-bracket-clone-variant-2 &&
 +	expect_ssh "-p 123" myhost src
 +'
 +
 +test_expect_success 'GIT_SSH_VARIANT overrides plink detection to plink' '
 +	GIT_SSH_VARIANT=plink \
 +	git clone "[myhost:123]:src" ssh-bracket-clone-variant-3 &&
 +	expect_ssh "-P 123" myhost src
 +'
 +
 +test_expect_success 'GIT_SSH_VARIANT overrides plink to tortoiseplink' '
 +	GIT_SSH_VARIANT=tortoiseplink \
 +	git clone "[myhost:123]:src" ssh-bracket-clone-variant-4 &&
 +	expect_ssh "-batch -P 123" myhost src
 +'
 +
  # Reset the GIT_SSH environment variable for clone tests.
  setup_ssh_wrapper
  

-- 
2.11.1.windows.prerelease.2.9.g3014b57

