X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn throwing assertion on old svn tracking branch
Date: Wed, 20 Dec 2006 17:05:20 -0800
Message-ID: <20061221010520.GB3901@localdomain>
References: <20061220235551.GA2974@hermes.lan.home.vilz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 21 Dec 2006 01:05:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061220235551.GA2974@hermes.lan.home.vilz.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34995>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxCNB-0005re-KG for gcvg-git@gmane.org; Thu, 21 Dec
 2006 02:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161103AbWLUBFX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 20:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161104AbWLUBFX
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 20:05:23 -0500
Received: from hand.yhbt.net ([66.150.188.102]:35508 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1161103AbWLUBFW
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 20:05:22 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 999D62DC034; Wed, 20 Dec 2006 17:05:20 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 20 Dec 2006
 17:05:20 -0800
To: Nicolas Vilz <niv@iaglans.de>
Sender: git-owner@vger.kernel.org

Nicolas Vilz <niv@iaglans.de> wrote:
> hello guys,
> 
> it has been a while, i tried git in conjunction with svn... i got a nice
> history, when working with it. This Work is now a year old.
> 
> Now I wanted to get on working and got following error message while
> fetching from one specific svn tracking branch:
> 
> $ git-svn fetch -i svn_master
> perl: subversion/libsvn_subr/path.c:343: svn_path_remove_component: 
> Assertion `is_canonical(path->data, path->len)' failed.
> Aborted

I don't recall seeing that error before.

Are you using the command-line client or the perl SVN libraries?  If
you're using the command-line client, you may want to try:
rm -rf .git/svn/svn_master/tree && git-svn rebuild -i svn_master

> I checked the svn working copy, it is uptodate now (although i had to
> search for it, i havent been using this repository for one year...)

Does the directory you're tracking the the repository still
exist?  If it disappeared, git-svn could have some issues with it
(regardless of command-line or SVN libraries).

-- 
