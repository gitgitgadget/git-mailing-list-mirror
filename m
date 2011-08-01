From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] notice error exit from pager
Date: Mon, 1 Aug 2011 22:35:44 +0200
Message-ID: <20110801203544.GA22431@toss>
References: <20110726210401.GA25207@toss.lan>
 <20110801175921.GA17092@toss>
 <7vd3goj38n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 22:35:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnzDN-0001mv-LX
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 22:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065Ab1HAUft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 16:35:49 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:39014 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753254Ab1HAUfr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 16:35:47 -0400
Received: from localhost (p5B22CD28.dip.t-dialin.net [91.34.205.40])
	by bsmtp.bon.at (Postfix) with ESMTP id C8C75A7EB0;
	Mon,  1 Aug 2011 22:35:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd3goj38n.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178408>

On Mon, Aug 01, 2011 at 01:17:28PM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > Since there is no reliable way to handle error reporting in the
> > parent, produce the output in the child instead.
> 
> Hmm, how does this interact with your earlier "error_routine: use parent's
> stderr if exec fails" patch?

The use case addressed in this patch (i.e., the pager) does not
strictly dependent on the previous patch. But Johannes noted that
in general, error output of the child could be redirected, hiding
the execve failure again. The error_routine patch avoids that by
writing to the parent's stderr stream.

Clemens
