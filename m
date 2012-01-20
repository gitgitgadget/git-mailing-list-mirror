From: David Brown <davidb@codeaurora.org>
Subject: Re: [Q] Determing if a commit is reachable from the HEAD ?
Date: Fri, 20 Jan 2012 10:06:20 -0800
Message-ID: <20120120180620.GA8504@codeaurora.org>
References: <201201201433.30267.brian.foster@maxim-ic.com>
 <m2ehuu8nrt.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Foster <brian.foster@maxim-ic.com>,
	git mailing list <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Jan 20 19:06:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoIr5-0007jz-ME
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 19:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910Ab2ATSGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 13:06:23 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:47518 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236Ab2ATSGW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 13:06:22 -0500
X-IronPort-AV: E=McAfee;i="5400,1158,6595"; a="156700399"
Received: from pdmz-css-vrrp.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 20 Jan 2012 10:06:21 -0800
Received: from codeaurora.org (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id B5A5E10004DC;
	Fri, 20 Jan 2012 10:06:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m2ehuu8nrt.fsf@igel.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188888>

On Fri, Jan 20, 2012 at 03:13:58PM +0100, Andreas Schwab wrote:
> Brian Foster <brian.foster@maxim-ic.com> writes:
> 
> >  In a script, how can I determine commit Y is reachable
> >  from the current HEAD ?
> 
> test $(git merge-base HEAD Y) = $(git rev-parse Y)

Almost.  It works as long as there is only one merge base.  You really
need to check if $(git rev-parse Y) is one of $(git merge-base --all
HEAD Y)

if HEAD is a named branch, you can do

  git name-rev --refs=refs/heads/branchname Y

which will give you Y relative to branchname if it is contained within
it.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
