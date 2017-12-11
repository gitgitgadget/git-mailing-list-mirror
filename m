Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39AAF1F404
	for <e@80x24.org>; Mon, 11 Dec 2017 22:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbdLKW4Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 17:56:24 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:36269 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752326AbdLKW4T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 17:56:19 -0500
Received: by mail-it0-f66.google.com with SMTP id d16so19804726itj.1
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 14:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/njm9DbLD29jdvrva/EEVgBtfILFCrNbCoSglp7+SHA=;
        b=lSnEAj+8B1zzaawoyteG+f82SG3iMjOJ11mOSV+GAMEmsPJ9GtmL4VaKRnwvzgc014
         3O1bOzCpSbuWGN1V/SWoA1sXRp7KoI8SZeFggWOZKorkeRLYasDJBzPj6YUe9084Eb9v
         fd0jPm4o0haA+ptpO51uSradKuwYbu6BKXFT/72KlSud5Hooo3zTKngKTk9Aaq96vCi0
         daSMHktRPUYBNykTv1mLhAgmsnYtvsPFx1FO36Oib5X5yazDw8mT6NDaJFKZ3a2zNMgg
         wkJTWnJ+x2rww+BpjNIi2THbmYOh4Zk5sTgbGDhYuX1kjrI+vF9P6Bh8hX0/5paBEUE6
         fnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/njm9DbLD29jdvrva/EEVgBtfILFCrNbCoSglp7+SHA=;
        b=DiuHEQc4aRA5pVRp4zqQQ08CjM85wIrdjK24rm/FiL/BeXdyBQ5/Kk8en84gWCGG5R
         w48FeFYU1vVsFqQIvKrtaLq+MmFra9EAyvLdRKQW1h9FHoKOc6pdnTV6tF6N0yJSSzuI
         FKV7/h3iI1FDMJk6zaGzsys2YWNT8mDKYngSRNPwlEZBK0tFsFbAd+U0IMhyYsT43LwV
         x1uSfNTi4RRhj6RjseAahlJCFdBE2Kh27W6zUJdWTIkLAQwOvZ0NW7kWgmoSKd1EEPPx
         wHDBgQJp0kCj5c5/3Nqh113mCy1an1p6aJKJ0pbg9TWYE8fdKjAepdr+L3pqYwALd+Gx
         Tm8Q==
X-Gm-Message-State: AKGB3mJKlB0dmRZVVQEVHe+CD8im9zhnn3+CkFl+ri4nSmuSS425jWT7
        PteC23+6nUAOq7eMJLrhfio=
X-Google-Smtp-Source: ACJfBov+5pCuOOdlSmPl1ofUBkK+zmyUs/7mKV+lf/CDJqNVnwurKnYiu4VK4D1RwVbLlJva1fK8oA==
X-Received: by 10.36.115.133 with SMTP id y127mr3245522itb.83.1513032978225;
        Mon, 11 Dec 2017 14:56:18 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 76sm4303285itk.23.2017.12.11.14.56.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Dec 2017 14:56:17 -0800 (PST)
Date:   Mon, 11 Dec 2017 14:56:15 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>, kyle@kyleam.com,
        Jeff King <peff@peff.net>
Subject: Re: Q: rational for $XDG_CONFIG_HOME/git/config to be "non global"
 or just a bug?
Message-ID: <20171211225615.GC214273@aiede.mtv.corp.google.com>
References: <20171211211102.rrxqd6yscnd33efd@hopa.kiewit.dartmouth.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171211211102.rrxqd6yscnd33efd@hopa.kiewit.dartmouth.edu>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Yaroslav Halchenko wrote:

> Example to show that TFM outlines precedence and --global correctly:
>
> $> grep xdg .gitconfig .config/git/config
> .gitconfig:    xdg-and-user = user
> .config/git/config: xdg = xdg
> .config/git/config: xdg-and-user = xdg
> $> git config user.xdg ; git config user.xdg-and-user
> xdg
> user

I agree, this is confusing.

Reverse engineering from source, I find that git reads the following
files in sequence:

	system:
		/etc/gitconfig
	global:
		$XDG_CONFIG_HOME/git/config
		$HOME/.gitconfig
	repo:
		$GIT_DIR/config
	commandline:
		options passed with -c or GIT_CONFIG_PARAMETERS

These terms (system, global, repo, etc) are accessible in code as
current_config_scope().  I don't think there's any user-visible effect
to $XDG_CONFIG_HOME/git/config and $HOME/.gitconfig both being global
--- it would probably be a good cleanup to rename the scope for one of
them.

I think the documentation

	~/.gitconfig
		User-specific configuration file. Also called "global"
		configuration file.

should be clarified --- e.g. it could say

	$XDG_CONFIG_HOME/git/config
	~/.gitconfig
		User-specific configuration files. Because options in
		these files are not specific to any repository, thes
		are sometimes called global configuration files.

As for "git config --global", I think the best thing would be to split
it into two options: something like "git config --user" and "git
config --xdg-user".  That way, it is unambiguous which configuration
file the user intends to inspect or modify.  When a user calls "git
config --global" and both files exist, it could warn that the command
is ambiguous.

Thoughts?

Thanks,
Jonathan
