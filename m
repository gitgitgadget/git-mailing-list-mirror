Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9004320A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 20:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbeLNUUn (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 15:20:43 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40074 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbeLNUUn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 15:20:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id d3so5942112edx.7
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 12:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=46NgHsT2/0ucqE5p43tzYp0FIE1ppHgvrot4PTpdQos=;
        b=LfmO2+Kflvb9LEBSoiNJTxxsB5rwI+l0g3Sac7yHwq+15uAuw7cYW6M6nijkqIC1Fb
         n2SRekjrJcHQ86RetF87MBS5dduogtvw+FrZKjC+zdu5FEsOYKZ6Ny3X28Mg2y5bWbhM
         aDEpdKR5iEv8fJmkATq0cTi/w/Eph7SweRMUMdSahiOaZXyYpYqsUgsw63EIffsyoQ8H
         h/n6fuoQF1nkwgMS80RH0i3bRT/R7JwoQc+AZtoW2k4MGtNOXIaW8rI3RyWSNbYx4OiE
         1HunjvFlkAf5CHoC+4V4Dr6HMSh5wVVUsa+C5TLjEjiwYTJYajjVptXwkH56H5Hxdb2U
         14mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=46NgHsT2/0ucqE5p43tzYp0FIE1ppHgvrot4PTpdQos=;
        b=kinRjoBewSyCcGLDVAXvpYjf2CFP1VQK1x6lN3dFeG8wzN0PMRgKF1q85R/z8P61/H
         vwlKYU8uGW1zFYAqtJZMuKtwDMmuwR6b7+YCyQksdt9eYvnqnV1aHHl1WI1eAWb05u1v
         CfBZSDvqixbKfynFDbPfPFn+2sAEDVu+C9aK8+yLiykAb5bGurCjfkpcg6J3giQU7nBz
         7Xey1eeAQxuBjRPIhDybbI/x43cN+Vb1Fiq/bzreOmdj6hz8ndQfuHhtIA+F12P8qAno
         R5074K7hP6Jnmyn9EABfwvFpcoScXeapYVBse/t9h8z6UcdyVrHTHFcfBDZxn6++Sx7h
         w6gw==
X-Gm-Message-State: AA+aEWYS0NbPvIjllk/gUZOQAsUOfyNxJajpzIVeXzI2x8xj5MFu6dHj
        g7quIo0r9XhtybkmTAGFJAkeEain
X-Google-Smtp-Source: AFSGD/WPi0yyPwnrNv+ulcug6qON/oS1alXH0abwu8M10lKl6E/6LAeTAtnN1K+3sI7u1vuefilHMw==
X-Received: by 2002:a17:906:64cb:: with SMTP id p11-v6mr3349120ejn.181.1544818840198;
        Fri, 14 Dec 2018 12:20:40 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id f19-v6sm883231eje.28.2018.12.14.12.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 12:20:38 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        jonathantanmy@google.com, szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/1] protocol: advertise multiple supported versions
References: <cover.1542162201.git.steadmon@google.com> <cover.1542407348.git.steadmon@google.com> <60f6f2fbd8ee03b2d461803b9313b7473300eecc.1542407348.git.steadmon@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <60f6f2fbd8ee03b2d461803b9313b7473300eecc.1542407348.git.steadmon@google.com>
Date:   Fri, 14 Dec 2018 21:20:37 +0100
Message-ID: <87imzv273e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 16 2018, Josh Steadmon wrote:

I started looking at this to address
https://public-inbox.org/git/nycvar.QRO.7.76.6.1812141318520.43@tvgsbejvaqbjf.bet/
and was about to send a re-roll of my own series, but then...

> Currently the client advertises that it supports the wire protocol
> version set in the protocol.version config. However, not all services
> support the same set of protocol versions. For example, git-receive-pack
> supports v1 and v0, but not v2. If a client connects to git-receive-pack
> and requests v2, it will instead be downgraded to v0. Other services,
> such as git-upload-archive, do not do any version negotiation checks.
>
> This patch creates a protocol version registry. Individual client and
> server programs register all the protocol versions they support prior to
> communicating with a remote instance. Versions should be listed in
> preference order; the version specified in protocol.version will
> automatically be moved to the front of the registry.
>
> The protocol version registry is passed to remote helpers via the
> GIT_PROTOCOL environment variable.
>
> Clients now advertise the full list of registered versions. Servers
> select the first allowed version from this advertisement.
>
> Additionally, remove special cases around advertising version=0.
> Previously we avoided adding version negotiation fields in server
> responses if it looked like the client wanted v0. However, including
> these fields does not change behavior, so it's better to have simpler
> code.

...this paragraph is new in your v5, from the cover letter: "Changes
from V4: remove special cases around advertising version=0". However as
seen in the code & tests:

> [...]
>  static void push_ssh_options(struct argv_array *args, struct argv_array *env,
>  			     enum ssh_variant variant, const char *port,
> -			     enum protocol_version version, int flags)
> +			     const struct strbuf *version_advert, int flags)
>  {
> -	if (variant == VARIANT_SSH &&
> -	    version > 0) {
> +	if (variant == VARIANT_SSH) {
>  		argv_array_push(args, "-o");
>  		argv_array_push(args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
> -		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
> -				 version);
> +		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s",
> +				 version_advert->buf);
>  	}
> [...]
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -346,7 +346,7 @@ expect_ssh () {
>
>  test_expect_success 'clone myhost:src uses ssh' '
>  	git clone myhost:src ssh-clone &&
> -	expect_ssh myhost src
> +	expect_ssh "-o SendEnv=GIT_PROTOCOL" myhost src
>  '
>
>  test_expect_success !MINGW,!CYGWIN 'clone local path foo:bar' '
> @@ -357,12 +357,12 @@ test_expect_success !MINGW,!CYGWIN 'clone local path foo:bar' '
>
>  test_expect_success 'bracketed hostnames are still ssh' '
>  	git clone "[myhost:123]:src" ssh-bracket-clone &&
> -	expect_ssh "-p 123" myhost src
> +	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
>  '
>
>  test_expect_success 'OpenSSH variant passes -4' '
>  	git clone -4 "[myhost:123]:src" ssh-ipv4-clone &&
> -	expect_ssh "-4 -p 123" myhost src
> +	expect_ssh "-o SendEnv=GIT_PROTOCOL -4 -p 123" myhost src
>  '
>
>  test_expect_success 'variant can be overridden' '
> @@ -406,7 +406,7 @@ test_expect_success 'OpenSSH-like uplink is treated as ssh' '
>  	GIT_SSH="$TRASH_DIRECTORY/uplink" &&
>  	test_when_finished "GIT_SSH=\"\$TRASH_DIRECTORY/ssh\$X\"" &&
>  	git clone "[myhost:123]:src" ssh-bracket-clone-sshlike-uplink &&
> -	expect_ssh "-p 123" myhost src
> +	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
>  '
>
>  test_expect_success 'plink is treated specially (as putty)' '
> @@ -446,14 +446,14 @@ test_expect_success 'GIT_SSH_VARIANT overrides plink detection' '
>  	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
>  	GIT_SSH_VARIANT=ssh \
>  	git clone "[myhost:123]:src" ssh-bracket-clone-variant-1 &&
> -	expect_ssh "-p 123" myhost src
> +	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
>  '
>
>  test_expect_success 'ssh.variant overrides plink detection' '
>  	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
>  	git -c ssh.variant=ssh \
>  		clone "[myhost:123]:src" ssh-bracket-clone-variant-2 &&
> -	expect_ssh "-p 123" myhost src
> +	expect_ssh "-o SendEnv=GIT_PROTOCOL -p 123" myhost src
>  '
>
>  test_expect_success 'GIT_SSH_VARIANT overrides plink detection to plink' '
> @@ -488,7 +488,7 @@ test_clone_url () {
>  }
>
>  test_expect_success !MINGW 'clone c:temp is ssl' '
> -	test_clone_url c:temp c temp
> +	test_clone_url c:temp "-o SendEnv=GIT_PROTOCOL" c temp
>  '
>
>  test_expect_success MINGW 'clone c:temp is dos drive' '
> @@ -499,7 +499,7 @@ test_expect_success MINGW 'clone c:temp is dos drive' '
>  for repo in rep rep/home/project 123
>  do
>  	test_expect_success "clone host:$repo" '
> -		test_clone_url host:$repo host $repo
> +		test_clone_url host:$repo "-o SendEnv=GIT_PROTOCOL" host $repo
>  	'
>  done
>
> @@ -507,16 +507,16 @@ done
>  for repo in rep rep/home/project 123
>  do
>  	test_expect_success "clone [::1]:$repo" '
> -		test_clone_url [::1]:$repo ::1 "$repo"
> +		test_clone_url [::1]:$repo "-o SendEnv=GIT_PROTOCOL" ::1 "$repo"
>  	'
>  done
>  #home directory
>  test_expect_success "clone host:/~repo" '
> -	test_clone_url host:/~repo host "~repo"
> +	test_clone_url host:/~repo "-o SendEnv=GIT_PROTOCOL" host "~repo"
>  '
>
>  test_expect_success "clone [::1]:/~repo" '
> -	test_clone_url [::1]:/~repo ::1 "~repo"
> +	test_clone_url [::1]:/~repo "-o SendEnv=GIT_PROTOCOL" ::1 "~repo"
>  '
>
>  # Corner cases
> @@ -532,22 +532,22 @@ done
>  for tcol in "" :
>  do
>  	test_expect_success "clone ssh://host.xz$tcol/home/user/repo" '
> -		test_clone_url "ssh://host.xz$tcol/home/user/repo" host.xz /home/user/repo
> +		test_clone_url "ssh://host.xz$tcol/home/user/repo" "-o SendEnv=GIT_PROTOCOL" host.xz /home/user/repo
>  	'
>  	# from home directory
>  	test_expect_success "clone ssh://host.xz$tcol/~repo" '
> -	test_clone_url "ssh://host.xz$tcol/~repo" host.xz "~repo"
> +	test_clone_url "ssh://host.xz$tcol/~repo" "-o SendEnv=GIT_PROTOCOL" host.xz "~repo"
>  '
>  done
>
>  # with port number
>  test_expect_success 'clone ssh://host.xz:22/home/user/repo' '
> -	test_clone_url "ssh://host.xz:22/home/user/repo" "-p 22 host.xz" "/home/user/repo"
> +	test_clone_url "ssh://host.xz:22/home/user/repo" "-o SendEnv=GIT_PROTOCOL -p 22 host.xz" "/home/user/repo"
>  '
>
>  # from home directory with port number
>  test_expect_success 'clone ssh://host.xz:22/~repo' '
> -	test_clone_url "ssh://host.xz:22/~repo" "-p 22 host.xz" "~repo"
> +	test_clone_url "ssh://host.xz:22/~repo" "-o SendEnv=GIT_PROTOCOL -p 22 host.xz" "~repo"
>  '
>
>  #IPv6
> @@ -555,7 +555,7 @@ for tuah in ::1 [::1] [::1]: user@::1 user@[::1] user@[::1]: [user@::1] [user@::
>  do
>  	ehost=$(echo $tuah | sed -e "s/1]:/1]/" | tr -d "[]")
>  	test_expect_success "clone ssh://$tuah/home/user/repo" "
> -	  test_clone_url ssh://$tuah/home/user/repo $ehost /home/user/repo
> +	  test_clone_url ssh://$tuah/home/user/repo '-o SendEnv=GIT_PROTOCOL' $ehost /home/user/repo
>  	"
>  done
>
> @@ -564,7 +564,7 @@ for tuah in ::1 [::1] user@::1 user@[::1] [user@::1]
>  do
>  	euah=$(echo $tuah | tr -d "[]")
>  	test_expect_success "clone ssh://$tuah/~repo" "
> -	  test_clone_url ssh://$tuah/~repo $euah '~repo'
> +	  test_clone_url ssh://$tuah/~repo '-o SendEnv=GIT_PROTOCOL' $euah '~repo'
>  	"
>  done
>
> @@ -573,7 +573,7 @@ for tuah in [::1] user@[::1] [user@::1]
>  do
>  	euah=$(echo $tuah | tr -d "[]")
>  	test_expect_success "clone ssh://$tuah:22/home/user/repo" "
> -	  test_clone_url ssh://$tuah:22/home/user/repo '-p 22' $euah /home/user/repo
> +	  test_clone_url ssh://$tuah:22/home/user/repo '-o SendEnv=GIT_PROTOCOL -p 22' $euah /home/user/repo
>  	"
>  done
>
> @@ -582,7 +582,7 @@ for tuah in [::1] user@[::1] [user@::1]
>  do
>  	euah=$(echo $tuah | tr -d "[]")
>  	test_expect_success "clone ssh://$tuah:22/~repo" "
> -	  test_clone_url ssh://$tuah:22/~repo '-p 22' $euah '~repo'
> +	  test_clone_url ssh://$tuah:22/~repo '-o SendEnv=GIT_PROTOCOL -p 22' $euah '~repo'
>  	"
>  done

...so now we're unconditionally going to SendEnv=GIT_PROTOCOL to "ssh"
invocations. I don't have an issue with this, but given the change in
the commit message this seems to have snuck under the radar. You're just
talking about always including the version in server responses, nothing
about the client always needing SendEnv=GIT_PROTOCOL now even with v0.

If the server always sends the version now, why don't you need to amend
the same t5400-send-pack.sh tests as in my "tests: mark & fix tests
broken under GIT_TEST_PROTOCOL_VERSION=1"? There's one that spews out
"version" there under my GIT_TEST_PROTOCOL_VERSION=1.

I was worried about this breaking GIT_SSH_COMMAND, but then I see due to
an interaction with picking "what ssh implementation?" we don't pass "-G
-o SendEnv=GIT_PROTOCOL" at all when I have a GIT_SSH_COMMAND, but *do*
pass it to my normal /usr/bin/ssh. Is this intended? Now if I have a
GIT_SSH_COMMAND that expects to wrap openssh I need to pass "-c
ssh.variant=ssh", because "-c ssh.variant=auto" will now omit these new
arguments.
