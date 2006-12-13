X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: t9100-git-svn-basic.sh fails
Date: Wed, 13 Dec 2006 01:43:20 -0800
Message-ID: <20061213094320.GD8179@localdomain>
References: <20061212232321.GL2476@albany.tokkee.org> <Pine.LNX.4.63.0612130102000.2807@wbgn013.biozentrum.uni-wuerzburg.de> <20061213084620.GN2476@albany.tokkee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 09:43:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061213084620.GN2476@albany.tokkee.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34194>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuQe5-0007fH-Do for gcvg-git@gmane.org; Wed, 13 Dec
 2006 10:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932640AbWLMJnW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 04:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbWLMJnW
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 04:43:22 -0500
Received: from hand.yhbt.net ([66.150.188.102]:54999 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932640AbWLMJnW
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 04:43:22 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 5080A2DC034; Wed, 13 Dec 2006 01:43:20 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 13 Dec 2006
 01:43:20 -0800
To: Junio C Hamano <junkio@cox.net>, Sebastian Harl <sh@tokkee.org>
Sender: git-owner@vger.kernel.org

Sebastian Harl <sh@tokkee.org> wrote:
> Hi,
> 
> On Wed, Dec 13, 2006 at 01:03:21AM +0100, Johannes Schindelin wrote:
> > On Wed, 13 Dec 2006, Sebastian Harl wrote:
> > 
> > > When compiling git 1.4.4.2 on my Debian Sarge box t9100-git-svn-basic.sh 
> > > fails with the following output:
> > > 
> > >   * FAIL 6: detect node change from directory to file #1
> > >          git-svn commit --find-copies-harder --rmdir \
> > >		 remotes/git-svn..mybranch2
> > 
> > Could you please run the test like this:
> > 
> > git/t> sh t9100-* -i -v
> 
>   * expecting failure: git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch2
>   diff-tree 5d3b7d019e8fa8d509091bd1d80113c8f20f9f4f 91d77f97b74783aa97ba2aed5a966e936eb9d30f
>   Transaction is out of date: Out of date: 'test-git-svn/bar' in transaction '2-2' at /home/tokkee/projects/debian/backports/backports.org/git-core/git-core-1.4.4.2/t/../git-svn line 1573
>   65280 at /home/tokkee/projects/debian/backports/backports.org/git-core/git-core-1.4.4.2/t/../git-svn line 575
>   	main::commit_lib('91d77f97b74783aa97ba2aed5a966e936eb9d30f') called at /home/tokkee/projects/debian/backports/backports.org/git-core/git-core-1.4.4.2/t/../git-svn line 481
>   	main::commit('remotes/git-svn..mybranch2') called at /home/tokkee/projects/debian/backports/backports.org/git-core/git-core-1.4.4.2/t/../git-svn line 173
>   * FAIL 6: detect node change from directory to file #1
>   	git-svn commit --find-copies-harder --rmdir remotes/git-svn..mybranch2

Oh, *smacks head*  I'm only half-awake at the moment, but
it looks like 1.4.4.2 doesn't have commit
d25c26e771fdf771f264dc85be348719886d354f
(git-svn: exit with status 1 for test failures)

Junio:
can you please cherry-pick that commit (and also apply
"git-svn: correctly display fatal() error messages"
(Message-Id: <11659636263755-git-send-email-normalperson@yhbt.net>)
into maint?

Thanks.

-- 
