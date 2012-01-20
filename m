From: David Brown <davidb@codeaurora.org>
Subject: Re: [Q] Determing if a commit is reachable from the HEAD ?
Date: Fri, 20 Jan 2012 15:33:35 -0800
Message-ID: <20120120233335.GA20302@codeaurora.org>
References: <201201201433.30267.brian.foster@maxim-ic.com>
 <m2ehuu8nrt.fsf@igel.home>
 <20120120180620.GA8504@codeaurora.org>
 <7v7h0mfahx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Brian Foster <brian.foster@maxim-ic.com>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 21 00:33:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoNxm-0002Ny-6v
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 00:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063Ab2ATXdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 18:33:37 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:37393 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab2ATXdh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 18:33:37 -0500
X-IronPort-AV: E=McAfee;i="5400,1158,6595"; a="154489246"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 20 Jan 2012 15:33:36 -0800
Received: from codeaurora.org (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 6936010004DC;
	Fri, 20 Jan 2012 15:33:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v7h0mfahx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188907>

On Fri, Jan 20, 2012 at 11:18:50AM -0800, Junio C Hamano wrote:
> David Brown <davidb@codeaurora.org> writes:
> 
> > On Fri, Jan 20, 2012 at 03:13:58PM +0100, Andreas Schwab wrote:
> >> Brian Foster <brian.foster@maxim-ic.com> writes:
> >> 
> >> >  In a script, how can I determine commit Y is reachable
> >> >  from the current HEAD ?
> >> 
> >> test $(git merge-base HEAD Y) = $(git rev-parse Y)
> >
> > Almost.  It works as long as there is only one merge base.  You really
> > need to check if $(git rev-parse Y) is one of $(git merge-base --all
> > HEAD Y)
> 
> Can you give us an example of a topology to which "merge-base --all HEAD Y"
> gives more than one output and Y is still reachable from HEAD?
> 
> It is my understanding that merge-base computation will give only Y and
> nothing else when Y is reachable from HEAD. I also think this assumption
> is used by some of the internal code in Git, and that is why I care.

Hmm, I thought I'd convinced myself that this was possible.  Now, I
can't come up with a way of doing it that doesn't involve improper
commits with earlier timestamps than their parents.

Sorry about that,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
