Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 458982095E
	for <e@80x24.org>; Thu, 23 Mar 2017 02:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbdCWC5C (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 22:57:02 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44848 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751355AbdCWC5A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 22:57:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id CDBD72095E;
        Thu, 23 Mar 2017 02:56:23 +0000 (UTC)
Date:   Thu, 23 Mar 2017 02:56:23 +0000
From:   Eric Wong <e@80x24.org>
To:     Craig McQueen <craig.mcqueen@innerrange.com>
Cc:     git@vger.kernel.org
Subject: Re: git svn and SVN property svn:original-date
Message-ID: <20170323025623.GA14619@starla>
References: <5500469A22567C4BAF673A6E86AFA3A40295E65B42D1@IR-CENTRAL.corp.innerrange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5500469A22567C4BAF673A6E86AFA3A40295E65B42D1@IR-CENTRAL.corp.innerrange.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Craig McQueen <craig.mcqueen@innerrange.com> wrote:
> When doing "git svn dcommit", the SVN revision just has the date/time stamp of the time of the dcommit.

Yeah, that's sometimes annoying to me, too.

> Apparently SVN revisions can have an "svn:original-date" property, which would be good to set on dcommit, to preserve the timestamp from the git repository.
> 
> https://subversion.apache.org/docs/api/1.7/group__svn__props__revision__props.html#ga8f17351dd056149da9cb490f1daf4018

Any idea if which versions of SVN it's supported in and how
recent the feature is?

Perhaps we can enable it everywhere, and maybe only old clients
won't understand it, but won't fail; and we could start using
it as the author date with "git svn fetch".

OTOH, that would break the (perhaps unofficial)
independently-created-git-svn-mirrors-should-have-same-oids-by-default
rule when people run different versions of git, so maybe it
could be an option...
