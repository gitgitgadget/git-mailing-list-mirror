Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DF732036B
	for <e@80x24.org>; Tue,  3 Oct 2017 21:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbdJCVmL (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 17:42:11 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34260 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdJCVmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 17:42:10 -0400
Received: by mail-pf0-f195.google.com with SMTP id g65so10391498pfe.1
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 14:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+8io//m5jIjqF0zEn/pJbfY8N55zM2U5h9O+GDIcvx0=;
        b=myL+JnbG+sN2xGUyoXGnlPag1vT/wmpRnRY9bC1Aqza8VAEJRnbxQAgMkpRhMjKGFi
         /TPhNM27B174G/VrMPPkl5JpAooBCMM3iJ1aUykSFigX8bi5fZ9f+3cUpYYAt0i9FL4G
         dlHX+J4NSeGP9C8UYWk//fQIcKrjaRWwflygsBlxk9pNmtbWNjU3INhyE+tGxcZrdMiK
         cGEU+icHDG/Q0cYlz3AvPuKqr99YZEwgUOSR4o9+tMdcPjr8zeAg0yUQgQFckpbmmaAt
         /VXuFzzJKNBRFI347nXI1kx6XTerfb3ACNpA1ip8fDXSRNdv8WfewGRD5Eu6J4cBoA1+
         031w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+8io//m5jIjqF0zEn/pJbfY8N55zM2U5h9O+GDIcvx0=;
        b=VIZuzl+rdH1h0Zhy/TmOzONISC2WGPcsYK5przUIhoVU87mlVtNRNxjUdKqzbB7XQf
         4jvcw8NjSLbg4T/djpk4zjfXnkx+vFCZCcbOLFqWAfaRgmfQw1OhXxvnsSQLgjUJY/mw
         QYatCtA+++JPRDTHJG2MTVUeuZVySlgBls589s3dZ8Vqy+zTmKhG+F/ePRsgULnj6io/
         GvyLPZgDPBY3jMb/yb9p/1ABYKH+TfFVZqbDZO1sIUJ7mOwQt0K8SjrYS+Qq3oKsevNF
         GCI7iAaSjn0Tg1EiNXJNWrZ/lBdUOePODANrgbBSU0mxoGvKJ0MEGMpR2bBrtriBoaxV
         OwZw==
X-Gm-Message-State: AMCzsaWDH2Pt5RMGLAgBt0uBAzfH56+ihMlngiNt8QisBb0Wluhp/Uum
        QvGju8LRyVrPD6t5/HuzKLY=
X-Google-Smtp-Source: AOwi7QA/7pUII9w/7mxo0z4YptUHos6F2oFZPMBwEVdItx4ZCt4iHb+EVOAXrR8zOGqSDI/qJiflBg==
X-Received: by 10.99.102.6 with SMTP id a6mr2944521pgc.298.1507066929299;
        Tue, 03 Oct 2017 14:42:09 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:3463:ab6b:5863:927c])
        by smtp.gmail.com with ESMTPSA id o88sm11867576pfk.28.2017.10.03.14.42.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 14:42:08 -0700 (PDT)
Date:   Tue, 3 Oct 2017 14:42:06 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        gitster@pobox.com, jonathantanmy@google.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v3 10/10] ssh: introduce a 'simple' ssh variant
Message-ID: <20171003214206.GY19555@aiede.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-11-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171003201507.3589-11-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> When using the 'ssh' transport, the '-o' option is used to specify an
> environment variable which should be set on the remote end.  This allows
> git to send additional information when contacting the server,
> requesting the use of a different protocol version via the
> 'GIT_PROTOCOL' environment variable like so: "-o SendEnv=GIT_PROTOCOL"
>
> Unfortunately not all ssh variants support the sending of environment
> variables to the remote end.  To account for this, only use the '-o'
> option for ssh variants which are OpenSSH compliant.  This is done by
> checking that the basename of the ssh command is 'ssh' or the ssh
> variant is overridden to be 'ssh' (via the ssh.variant config).

This also affects -p (port), right?

What happens if I specify a ssh://host:port/path URL and the SSH
implementation is of 'simple' type?

> Previously if an ssh command's basename wasn't 'plink' or

Git's commit messages use the present tense to describe the current
state of the code, so this is "Currently". :)

> 'tortoiseplink' git assumed that the command was an OpenSSH variant.
> Since user configured ssh commands may not be OpenSSH compliant, tighten
> this constraint and assume a variant of 'simple' if the basename of the
> command doesn't match the variants known to git.  The new ssh variant
> 'simple' will only have the host and command to execute ([username@]host
> command) passed as parameters to the ssh command.
>
> Update the Documentation to better reflect the command-line options sent
> to ssh commands based on their variant.
>
> Reported-by: Jeffrey Yasskin <jyasskin@google.com>
> Signed-off-by: Brandon Williams <bmwill@google.com>

Thanks for working on this.

For background, the GIT_SSH implementation that motivated this is
https://github.com/travis-ci/dpl/blob/6c3fddfda1f2a85944c544446b068bac0a77c049/lib/dpl/provider.rb#L215,
which does not support -p or -4/-6, either.

> ---
>  Documentation/config.txt |  27 ++++++++++--
>  Documentation/git.txt    |   9 ++--
>  connect.c                | 107 ++++++++++++++++++++++++++---------------------
>  t/t5601-clone.sh         |   9 ++--
>  t/t5700-protocol-v1.sh   |   2 +
>  5 files changed, 95 insertions(+), 59 deletions(-)
[...]
> --- a/connect.c
> +++ b/connect.c
> @@ -776,37 +776,44 @@ static const char *get_ssh_command(void)
[...]
> +static enum ssh_variant determine_ssh_variant(const char *ssh_command,
> +					      int is_cmdline)
[...]
> -	if (!strcasecmp(variant, "plink") ||
> -	    !strcasecmp(variant, "plink.exe"))
> -		*port_option = 'P';
> +	if (!strcasecmp(variant, "ssh"))
> +		ssh_variant = VARIANT_SSH;

Could this handle ssh.exe, too?

[...]
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh

Can this get tests for the new defaulting behavior?  E.g.

 - default is "simple"
 - how "simple" treats an ssh://host:port/path URL
 - how "simple" treats ipv4/ipv6 switching
 - ssh defaults to "ssh"
 - if GIT_SSH=ssh, can set ssh.variant to "simple" to force the "simple"
   mode

One other worry: this (intentionally) changes the behavior of a
previously-working GIT_SSH=ssh-wrapper that wants to support
OpenSSH-style options but does not declare ssh.variant=ssh.  When
discovering this change, what should the author of such an ssh-wrapper
do?

They could instruct their users to set ssh.variant or GIT_SSH_VARIANT
to "ssh", but then they are at the mercy of future additional options
supported by OpenSSH we may want to start using in the future (e.g.,
maybe we will start passing "--" to separate options from the
hostname).  So this is not a futureproof option for them.

They could take the new default behavior or instruct their users to
set ssh.variant or GIT_SSH_VARIANT to "simple", but then they lose
support for handling alternate ports, ipv4/ipv6, and specifying -o
SendEnv to propagate GIT_PROTOCOL or other envvars.  They can handle
GIT_PROTOCOL propagation manually, but losing port support seems like
a heavy cost.

They could send a patch to define yet another variant that is
forward-compatible, for example using an interface similar to what
git-credential(1) uses.  Then they can set GIT_SSH to their
OpenSSH-style helper and GIT_FANCY_NEW_SSH to their more modern
helper, so that old Git versions could use GIT_SSH and new Git
versions could use GIT_FANCY_NEW_SSH.  This might be their best
option.  It feels odd to say that their only good way forward is to
send a patch, but on the other hand someone with such an itch is
likely to be in the best position to define an appropriate interface.

They could send a documentation patch to make more promises about the
commandline used in OpenSSH mode: e.g. setting a rule in advance about
which options can take an argument so that they can properly parse an
OpenSSH command line in a future-compatible way.

Or they could send a patch to allow passing the port in "simple"
mode, for example using an environment variable.

Am I missing another option?  What advice do we give to this person?

Thanks,
Jonathan
