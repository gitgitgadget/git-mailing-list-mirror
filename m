Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AE1C1F404
	for <e@80x24.org>; Sun, 18 Mar 2018 23:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754258AbeCRXE0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 19:04:26 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35980 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754166AbeCRXE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 19:04:26 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A309B1F404;
        Sun, 18 Mar 2018 23:04:25 +0000 (UTC)
Date:   Sun, 18 Mar 2018 23:04:25 +0000
From:   Eric Wong <e@80x24.org>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] git-svn: allow empty email-address in
 authors-prog and authors-file
Message-ID: <20180318230425.GB25017@80x24.org>
References: <20180304112237.19254-1-asheiduk@gmail.co>
 <20180311135835.9775-3-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180311135835.9775-3-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> wrote:
> The email address in --authors-file and --authors-prog can be empty but
> git-svn translated it into a syntethic email address in the form
> $USERNAME@$REPO_UUID. Now git-svn behaves like git-commit: If the email
> is explicitly set to the empty string, the commit does not contain
> an email address.

What is missing is WHY "<>" is preferable to "<$USERNAME@$REPO_UUID>".

$USERNAME is good anyways since projects/organizations tie their
SVN usernames to email usernames via LDAP, making it easy to
infer their email address from $USERNAME.  The latter can also
be used to disambiguate authors if they happen to have the same
real name.

"<>" is completely meaningless.
