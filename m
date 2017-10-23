Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0367F202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 22:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbdJWWTc (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 18:19:32 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52507 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbdJWWTb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 18:19:31 -0400
Received: by mail-it0-f68.google.com with SMTP id j140so7807831itj.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 15:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Py49ucT+PFYUufuUP7JH8KBbJrJlJF03SBnuT5DzJsI=;
        b=ob51C5k/f0+QzzDPJJjJIVvnKzU8q8Y3YB6Svl7Apl42yi1tLc6mP2JdeLtU32VZPj
         ie+t4PwaGHpYzya4F8S95ipxpNkr2qYmc3AaL5Pd4Gn9M386nmwvk6GixWOblm1kLn3w
         7+JA77SKp1LLcxNWqp8uxpaSBBGOrpZCRXhF5CojU+83lGrs1JTp+mBIFBfA/2zHfzRa
         4LXoj0+glweOA3n1e0ll3jD7/vsYcwVfVQq2BG1H1zUic8idmwyv/1wv8z5WC2jgHMhx
         3GIFmB9Krcjlg99Tg4QEjYcQvLSLYaV0AMPpbXd0WCN++lblAwXM5R0Gs9TPMt5WdUMQ
         BfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Py49ucT+PFYUufuUP7JH8KBbJrJlJF03SBnuT5DzJsI=;
        b=WCbtLqkB0gYlU2u/LPKdBqMa/2ZHBytURXA/45ziLjAo6aQZFCQROI+8F0FAy8HDbu
         NOqb4jVP6rUxG8KvMFRe5NGhmM4V0XSokYrlmIhJqOvtjydyvewSF9HtSuy/2obiMf9a
         GasZGAb0X7++3Gp4jZFOGrmvKqmaCxuc6MYzN1j3JMOnViHs0Sdwo5nl5B7vXRKH9HBs
         AvYaJjKvuzVNE9rU5u5IcE+ZrHCo4VPp6+ueWhDhmWiOU3q3zU04a9nFySytmFrpgT1D
         OMQJkmuWzugbUieNZgi6OmgmhYAZZPPCZLd4GRL/pd8qpvVdDRXi68hABgxV1RXZWli4
         HFQA==
X-Gm-Message-State: AMCzsaW7W3vcUUa4SEQdiWB4DoDmBV87UMjtvoLt7yGweSD9jRE9Tbj7
        YFJn4+z2HeVT6G5ymsgpUXsETg==
X-Google-Smtp-Source: ABhQp+TxMeeOsObo8lrFgow1VfVnuqDBhRLrrIN5/0jvCXmpSMS7+ptY+s0S6dR5C35Os4FpGx72tQ==
X-Received: by 10.36.14.145 with SMTP id 139mr11071430ite.111.1508797170848;
        Mon, 23 Oct 2017 15:19:30 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:4d18:32f5:4fe3:81f8])
        by smtp.gmail.com with ESMTPSA id x137sm2915072itb.37.2017.10.23.15.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Oct 2017 15:19:30 -0700 (PDT)
Date:   Mon, 23 Oct 2017 15:19:29 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, sbeller@google.com, William Yan <wyan@google.com>
Subject: Re: [PATCH 3/5] ssh: 'auto' variant to select between 'ssh' and
 'simple'
Message-Id: <20171023151929.67165aea67353e5c24a15229@google.com>
In-Reply-To: <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com>
        <20171003201507.3589-1-bmwill@google.com>
        <20171003201507.3589-11-bmwill@google.com>
        <20171003214206.GY19555@aiede.mtv.corp.google.com>
        <20171016171812.GA4487@google.com>
        <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
        <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 23 Oct 2017 14:31:59 -0700
Jonathan Nieder <jrnieder@gmail.com> wrote:

> @@ -2083,14 +2083,19 @@ visited as a result of a redirection do not participate in matching.
>  ssh.variant::
>  	Depending on the value of the environment variables `GIT_SSH` or
>  	`GIT_SSH_COMMAND`, or the config setting `core.sshCommand`, Git
> -	auto-detects whether to adjust its command-line parameters for use
> -	with ssh (OpenSSH), plink or tortoiseplink, as opposed to the default
> -	(simple).
> +	auto-detects whether to pass command-line parameters for use
> +	with a simple wrapper script (simple), OpenSSH (ssh), plink, or
> +	tortoiseplink.
> ++
> +The default is `auto`, which means to auto-detect whether the ssh command
> +implements OpenSSH options using the `-G` (print configuration) option.
> +If the ssh command supports OpenSSH options, it then behaves like `ssh`;
> +otherwise, it behaves like `simple`.
>  +
>  The config variable `ssh.variant` can be set to override this auto-detection;
> -valid values are `ssh`, `simple`, `plink`, `putty` or `tortoiseplink`. Any
> -other value will be treated as normal ssh. This setting can be overridden via
> -the environment variable `GIT_SSH_VARIANT`.
> +valid values are `ssh`, `simple`, `plink`, `putty`, `tortoiseplink`, and
> +`auto`.  Any other value will be treated as normal ssh.  This setting can be
> +overridden via the environment variable `GIT_SSH_VARIANT`.

The new documentation seems to imply that setting ssh.variant (or
GIT_SSH_VARIANT) to "auto" is equivalent to not setting it at all, but
looking at the code, it doesn't seem to be the case (not setting it at
all invokes checking the first word of core.sshCommand, and only uses
VARIANT_AUTO if that check is inconclusive, whereas setting
ssh.variant=auto skips the core.sshCommand check entirely).

Maybe document ssh.variant as follows:

    If unset, Git will determine the command-line arguments to use based
    on the basename of the configured SSH command (through the
    environment variable `GIT_SSH` or `GIT_SSH_COMMAND`, or the config
    setting `core.sshCommand`). If the basename is unrecognized, Git
    will attempt to detect support of OpenSSH options by first invoking
    the configured SSH command with the `-G` (print configuration) flag,
    and will subsequently use OpenSSH options (upon success) or no
    options besides the host (upon failure).

    If set, Git will not do any auto-detection based on the basename of
    the configured SSH command. This can be set to `ssh` (OpenSSH
    options), `plink`, `putty`, `tortoiseplink`, `simple` (no options
    besides the host), or `auto` (the detection with `-G` as described
    above). If set to any other value, Git behaves as if this is set to
    `ssh`.

(Patches 1, 2, 4, and 5 seem fine to me.)
