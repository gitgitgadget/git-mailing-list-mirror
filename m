Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D95B71F404
	for <e@80x24.org>; Wed,  7 Feb 2018 13:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754047AbeBGNSP (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 08:18:15 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:52854 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753648AbeBGNSN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 08:18:13 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:58378 helo=android-a172fe96dd584b41)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1ejPc4-0007Gc-Ev
        for git@vger.kernel.org; Wed, 07 Feb 2018 08:18:12 -0500
Date:   Wed, 7 Feb 2018 08:18:09 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@android-a172fe96dd584b41
To:     Git Mailing list <git@vger.kernel.org>
Subject: categorization, documentation and packaging of "git core" commands
Message-ID: <alpine.LFD.2.21.1802070801470.19185@android-a172fe96dd584b41>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  (related to earlier thread but different enough that i'll start
fresh.)

  based on the collection of man page links here:

https://www.kernel.org/pub/software/scm/git/docs/

i took a look at how git 2.14.3 is laid out on my fedora 27 system,
particularly all of the executables under /usr/libexec/git-core/.
after manually cross-checking all of those executables against the
links on the docs page, here's what i learned.

  first, here are the executables under /usr/libexec/git-core/ that
are unreferenced by that web page, but that should be fine as almost
all of them would be considered underlying helpers or utilities
(except for things like git-subtree, but we're still unclear on its
status, right?):

  git-add--interactive
  git-bisect--helper
  git-credential-cache--daemon
  git-credential-libsecret
  git-credential-netrc
  git-difftool--helper
  git-fsck-objects
  git-gui--askpass
  git-init-db
  git-merge-octopus
  git-merge-ours
  git-merge-recursive
  git-merge-resolve
  git-merge-subtree
  git-mergetool--lib
  git-rebase--am
  git-rebase--helper
  git-rebase--interactive
  git-rebase--merge
  git-remote-ext
  git-remote-fd
  git-remote-ftp
  git-remote-ftps
  git-remote-http
  git-remote-https
  git-sh-i18n--envsubst
  git-stage
  git-submodule--helper
  git-subtree
  git-web--browse

on the other hand (and this is not so much a git issue as a fedora
packaging issue), there are a number of command links at that web page
that are supplied by distinct RPM packages rather than by the basic
fedora git package, so one would need to install the following
packages to get some of those commands on fedora:

  * gitk
  * git-cvs
  * git-svn
  * git-p4
  * git-email (provides git-send-email)

finally, from fedora, i am utterly unable to find a package that
provides git-archimport. pretty sure fedora used to have a "git-arch"
package but it's not there now.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
