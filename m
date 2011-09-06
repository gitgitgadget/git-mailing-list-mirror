From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 3/3] push: old receive-pack does not understand --quiet
Date: Tue, 6 Sep 2011 21:52:03 +0200
Message-ID: <20110906195203.GA30927@ecki>
References: <20110903105723.GA16304@tin.tmux.org>
 <1315067656-2846-1-git-send-email-drizzd@aon.at>
 <1315067656-2846-4-git-send-email-drizzd@aon.at>
 <7vty8p8s8n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tobiasu@tmux.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 21:54:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R11jP-0005Id-Tt
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 21:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab1IFTyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 15:54:47 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:62623 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752691Ab1IFTyq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 15:54:46 -0400
Received: from localhost (p5B22C347.dip.t-dialin.net [91.34.195.71])
	by bsmtp.bon.at (Postfix) with ESMTP id C323513004E;
	Tue,  6 Sep 2011 21:54:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vty8p8s8n.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180825>

On Tue, Sep 06, 2011 at 11:01:44AM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > Commit 90a6c7d4 (propagate --quiet to send-pack/receive-pack)
> > introduced the --quiet option to receive-pack and made send-pack
> > pass that option. Older versions of receive-pack do not recognize
> > the option, however, and terminate immediately.
> >
> > This change restores backwards compatibility by adding a 'quiet'
> > capability to receive-pack.
> 
> Wouldn't this mean that there is no point in adding --quiet command line
> option to the receive-pack command? IOW, shouldn't parts of 90a6c7d
> (propagate --quiet to send-pack/receive-pack, 2011-07-30) be reverted?
> 
> At this late stage in the release cycle, I would rather prefer to revert
> the whole commit and leave anything new for the next cycle.

Sure, we can do that. Only then 1.7.6.1 will be broken against all
versions except 1.7.6.1 on the server side. Right now it is only
broken against 1.7.6 and older versions.

But I am ok with it either way. I will have to check how much
resolving needs to be done after the revert.

Clemens
