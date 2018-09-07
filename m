Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C7541F404
	for <e@80x24.org>; Fri,  7 Sep 2018 22:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbeIHDS0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 23:18:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44575 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbeIHDS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 23:18:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so7635393pff.11
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 15:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cvhCuDUfe782BvlaHrMNqJVlc9MWEHN0HAYk4ZRsioE=;
        b=WLM8IHGJCiMSSgIpcPNc6Jphs7WmTZghaVb6IhQk+NRq1K8UmzqmS6c0K/cnJrPAfg
         HvLKBvQl1RZq5EXGUKWd66lWu+ZS1C/Ua48CyoU5pOKeEA0RWWMuRsJyVvvxPwNREBVg
         TQjiF/8yY5VlqXN8UCb5x+6EelNW92InlOux4F2Q9subuLjigyPqxtr4klqVFycEZShh
         P+XOuEuOFOdUGuEeTPwIqM2sHZ84DKSVDq6RPA4+sdDWlDm/lgUzyiam8xPs/8jPeyfJ
         BMZbulogo2Hz1csIvhMePScKNHqBIkm6B7nIvbPA88pauNHit2itgMa+HiKiPGNEYpMt
         fB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cvhCuDUfe782BvlaHrMNqJVlc9MWEHN0HAYk4ZRsioE=;
        b=S5+4NOgu5BkWANZq+UdS4YYVpnLpSjenWDtJoXVoOKGn0TiqpPQHyYFq4fit8ViK5U
         wjEkxEw+uO01BREFzqMLPVSqWyZGSYAPcOjLG/YvDOnvJAfSsJ+2KnHc5TdiptOuJzig
         0dZNRzJvBKaCS5i/9bJmQodoHQonITNWMqvZlWfIpAb1g/6by7fIDxSwGgC2PytYJjCf
         liv4u1RthuutD4xJuOURKGFyphVV4d+Fn/+IY9ETj1VrcQyWXAKF5tYR+QJqlKabvRyb
         ypGQ4Cww6PmNHE54faB458QROfPOJQTQ0yfQL3JAcpcE6UVUDnpik/ogVjck42WEmjR1
         kJnw==
X-Gm-Message-State: APzg51AOK934Pc+9ZqmHgbM/QCEXc+x7aRAi0TSvyK7vouKj/X3jdiTi
        y00BJrj6tSxjf+kHLAOZKZMlv084
X-Google-Smtp-Source: ANB0VdbxcdlzjqLS2MbfwCZBTfqgxnAlUpn/FCT+8NLZ2oE6VZkPxrEfJuUppdZTPp8yb9BmUvR4WQ==
X-Received: by 2002:a62:3ac8:: with SMTP id v69-v6mr10868425pfj.164.1536359717635;
        Fri, 07 Sep 2018 15:35:17 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l10-v6sm13895952pfj.179.2018.09.07.15.35.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 15:35:16 -0700 (PDT)
Date:   Fri, 7 Sep 2018 15:35:15 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     allan.jensen@qt.io, git <git@vger.kernel.org>
Subject: Re: Old submodules broken in 2.19rc1 and 2.19rc2
Message-ID: <20180907223515.GD103699@aiede.svl.corp.google.com>
References: <2659750.rG6xLiZASK@twilight>
 <CAGZ79kaVQ0T=acpviOoD+8XVxYsefNkO7c5d+d0Wc0iCbr2Evw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaVQ0T=acpviOoD+8XVxYsefNkO7c5d+d0Wc0iCbr2Evw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
> On Fri, Sep 7, 2018 at 2:53 AM Allan Sandfeld Jensen <allan.jensen@qt.io> wrote:

>> Submodules checked out with older versions of git not longer works in the
>> latest 2.19 releases. A "git submodule update --recursive" command wil fail
>> for each submodule with a line saying "fatal: could not open
>> '<submodule>/.git' for writing> Is a directory.
[...]
> I have the suspicion that e98317508c0 (submodule:
> ensure core.worktree is set after update, 2018-06-18)
> might be the offender.

I still was not able to reproduce it, but after a bit of staring at
the code, I'm pretty sure I just did something wrong in the
reproduction process.  That commit is indeed the offender.

It introduces the following code (rewrapped for clarity) in
git-submodule.sh:

	if ! $(
		git config -f \
			"$(git rev-parse --git-common-dir)/modules/$name/config" \
			core.worktree
	) 2>/dev/null
	then
		git submodule--helper connect-gitdir-workingtree "$name" "$sm_path"
	fi

Staring at it for a while, you can see one problem: the 'if ! $(git
config)' should be simply 'if ! git config'.  This ends up trying to
run the core.worktree value as a command, which would usually fail.

That brings us into connect_work_tree_and_git_dir, which does

	/* Prepare .git file */
	strbuf_addf(&gitfile_sb, "%s/.git", work_tree_);
	if (safe_create_leading_directories_const(gitfile_sb.buf))
		die(_("could not create directories for %s"), gitfile_sb.buf);

	/* Prepare config file */
	strbuf_addf(&cfg_sb, "%s/config", git_dir_);
	if (safe_create_leading_directories_const(cfg_sb.buf))
		die(_("could not create directories for %s"), cfg_sb.buf);

	git_dir = real_pathdup(git_dir_, 1);
	work_tree = real_pathdup(work_tree_, 1);

	/* Write .git file */
	write_file(gitfile_sb.buf, "gitdir: %s",
		   relative_path(git_dir, work_tree, &rel_path));

The write_file runs into .git already existing as a directory, failing
with the message Allan saw.

This would happen in at least two cases:

- if the submodule exists both in .git/modules/ *and* in the worktree
  (due to flipping between Git versions and branches with and without
  the submodule), the above will happen

- likewise if the submodule exists only in the worktree, like for Allan.

In "next" there is 74d4731d (submodule--helper: replace
connect-gitdir-workingtree by ensure-core-worktree, 2018-08-13) which
uses robust helpers in C that handle this much better.  I think we
should revert e98317508c0 in "master" (for 2.19) and keep making use
of that 'second try' in "next" (for 2.20).

I'll try to pin down a reproduction case and send a revert + testsuite
patch.

Thanks again,
Jonathan
