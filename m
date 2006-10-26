X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: [PATCH] git-svnimport: support for partial imports
Date: Thu, 26 Oct 2006 12:31:20 +0200
Message-ID: <20061026103120.GA15502@sashak.voltaire.com>
References: <20061025225026.GA13031@sashak.voltaire.com> <20061026084710.GC13780@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 10:26:20 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Matthias Urlichs <smurf@smurf.noris.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061026084710.GC13780@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 26 Oct 2006 10:25:55.0207 (UTC) FILETIME=[1EA89170:01C6F8E9]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30180>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd2R6-0003XQ-5N for gcvg-git@gmane.org; Thu, 26 Oct
 2006 12:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422925AbWJZK0A (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 06:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422931AbWJZK0A
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 06:26:00 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:1238 "EHLO
 taurus.voltaire.com") by vger.kernel.org with ESMTP id S1422925AbWJZKZ7
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 06:25:59 -0400
Received: from sashak ([172.25.5.107]) by taurus.voltaire.com with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 26 Oct 2006 12:25:55 +0200
Received: by sashak (sSMTP sendmail emulation); Thu, 26 Oct 2006 12:31:20
 +0200
To: Karl Hasselstr?m <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On 10:47 Thu 26 Oct     , Karl Hasselstr?m wrote:
> On 2006-10-26 00:50:26 +0200, Sasha Khapyorsky wrote:
> 
> > This adds support for partial svn imports. Let's assume that SVN
> > repository layout looks like:
> >
> >   $trunk/path/to/our/project
> >   $branches/path/to/our/project
> >   $tags/path/to/our/project
> >
> > , and we would like to import only tree under this specific
> > 'path/to/our/project' and not whole tree under $trunk, $branches,
> > etc.. Now we will be be able to do it by using '-P
> > path/to/our/project' option with git-svnimport.
> 
> Isn't this already doable with "-T trunk/path/to/our/project -t
> tags/path/to/our/project -b branches/path/to/our/project"?

In such case git-svnimport will not be able to resolve branches and
tags names - note that actual SVN paths are:

  branches/<branch-name>/path/to/our/project
  tags/<tag-name>/path/to/our/project

