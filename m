Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DFBE1F406
	for <e@80x24.org>; Thu, 11 Jan 2018 09:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932612AbeAKJF0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 04:05:26 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:47458 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754157AbeAKJEx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 04:04:53 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A9AD41F406;
        Thu, 11 Jan 2018 09:04:52 +0000 (UTC)
Date:   Thu, 11 Jan 2018 09:04:52 +0000
From:   Eric Wong <e@80x24.org>
To:     Jason Greenbaum <jgbaum@lji.org>
Cc:     git@vger.kernel.org
Subject: Re: git svn clone of messy repository
Message-ID: <20180111090452.GA29874@dcvr>
References: <CAKNOR-JbAjE9URdFw_ZrqVeZot=emHFWLgpjhQ7uqUsJpRzx2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKNOR-JbAjE9URdFw_ZrqVeZot=emHFWLgpjhQ7uqUsJpRzx2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jason Greenbaum <jgbaum@lji.org> wrote:
> --trunk=trunk/project_of_interest \
> --branches=branches/FF-1.0/project_of_interest \
> --branches=branches/FF-1.1/project_of_interest \

> The trunk seems to become the 'master' branch just fine, but my svn
> branches are not pulled down.  I'm not sure I have the syntax right or
> if this is even possible without first reorganizing the svn repo in
> place, updating the .git/config file, or by some other means.

By default, the basename ("project_of_interest") is used and you
get collisions.

I think this section of the git-svn manpage should help:

| When using multiple --branches or --tags, 'git svn' does not automatically
| handle name collisions (for example, if two branches from different paths have
| the same name, or if a branch and a tag have the same name).  In these cases,
| use 'init' to set up your Git repository then, before your first 'fetch', edit
| the $GIT_DIR/config file so that the branches and tags are associated
| with different name spaces.  For example:
| 
| 	branches = stable/*:refs/remotes/svn/stable/*
| 	branches = debug/*:refs/remotes/svn/debug/*

