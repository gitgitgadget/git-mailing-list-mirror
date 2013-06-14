From: John Keeping <john@keeping.me.uk>
Subject: Re: git stash while pending merge should not be allowed
Date: Fri, 14 Jun 2013 09:30:19 +0100
Message-ID: <20130614083018.GD23890@serenity.lan>
References: <51B18331.6060302@coverity.com>
 <7v1u8du5as.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott McPeak <smcpeak@coverity.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 10:30:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnPP0-0003zG-Qv
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 10:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617Ab3FNIa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 04:30:29 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:60221 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab3FNIa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 04:30:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 5F84523240;
	Fri, 14 Jun 2013 09:30:26 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7W6wQAjOfxhs; Fri, 14 Jun 2013 09:30:25 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 5AF622320A;
	Fri, 14 Jun 2013 09:30:20 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7v1u8du5as.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227795>

On Fri, Jun 07, 2013 at 11:47:07AM -0700, Junio C Hamano wrote:
> Scott McPeak <smcpeak@coverity.com> writes:
> 
> > I suggest that this problem could easily have been avoided if "git
> > stash" refused to run with a pending merge (present MERGE_HEAD file),
> > since this is crucial repository state that it does not save.  This
> > seems similar to what "git cherry-pick" does.
> 
> Sounds senslbe.  What do we want to see happen in other states, in
> which Git gives control back to the user asking for help before
> moving forward (e.g. am, rebase, cherry-pick, revert)?

I don't think there's any need to prevent stash running in these cases
and I sometimes find it useful that I can stash during a rebase.

Having said that, I wonder what happens with "cherry-pick -x" if you do
stash changes while it is stopped.  I don't think that is as serious as
the merge case because it's easy to detect in the commit message.
