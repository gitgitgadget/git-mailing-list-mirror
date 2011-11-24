From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] make git-svn resilient to log.abbrevcommit = true
Date: Thu, 24 Nov 2011 18:32:33 +0000
Message-ID: <20111124183233.GA22111@dcvr.yhbt.net>
References: <3A78B8F7-803C-4278-8B5F-4A1B02C9FF04@gmail.com>
 <201111241411.05655.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shahid Alam <shahid.alam@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Nov 24 19:32:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTe6C-0007yf-Pc
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 19:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705Ab1KXScf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Nov 2011 13:32:35 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:40365 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401Ab1KXSce (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2011 13:32:34 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3C3B21053;
	Thu, 24 Nov 2011 18:32:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <201111241411.05655.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185916>

Thomas Rast <trast@student.ethz.ch> wrote:
> Shahid Alam wrote:
> > Add --no-abbrev-commit arg to working_head_Info()'s invocation
> > of git log.
> [...]
> > @@ -1803,7 +1803,7 @@ sub cmt_sha2rev_batch {
> > sub working_head_info {
> > 	my ($head, $refs) = @_;
> > 	my @args = qw/log --no-color --no-decorate --first-parent
> > -	              --pretty=medium/;
> > +	              --no-abbrev-commit --pretty=medium/;
> 
> Undeniably a bug, but to prevent the same from happening again,
> wouldn't it be better to rewrite it using simply
> 
>   rev-list --first-parent --pretty=medium

Yes, I've never been happy with using "git log" for any internals since
it's a porcelain.  I'll gladly accept a tested patch which uses rev-list
instead.  Thanks!
