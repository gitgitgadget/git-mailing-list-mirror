From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] fixup! graph: output padding for merge subsequent parents
Date: Mon, 11 Feb 2013 19:06:29 +0000
Message-ID: <20130211190629.GC2270@serenity.lan>
References: <7vtxplt5u2.fsf@alter.siamese.dyndns.org>
 <20130210131647.GA2270@serenity.lan>
 <7vliawt19c.fsf@alter.siamese.dyndns.org>
 <20130210210229.GB2270@serenity.lan>
 <7vwqufrdzd.fsf@alter.siamese.dyndns.org>
 <20130211105433.GA3245@farnsworth.metanate.com>
 <7vehgmol8y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 20:07:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4yiU-0005RI-Jz
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 20:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758667Ab3BKTGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 14:06:39 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:46635 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758568Ab3BKTGj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 14:06:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 8DC47606518;
	Mon, 11 Feb 2013 19:06:38 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U9l3RwkKN+fQ; Mon, 11 Feb 2013 19:06:38 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 458DF606517;
	Mon, 11 Feb 2013 19:06:31 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vehgmol8y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216076>

On Mon, Feb 11, 2013 at 08:42:21AM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > Perhaps it's best to leave the patch as it originally was to guarantee
> > that we can't get stuck in graph_show_commit(), even when it's called at
> > an unexpected time, but I see you've already squashed this change in.
> >
> > Would you prefer me to resend the original patch or send an update with
> > this change and the above reasoning in the commit message?
> 
> Yes, please.  Let's have the original (I think I have it in my
> reflog so no need to resend it) and this update on top as a separate
> patch with an updated log message.

I was suggesting dropping the change to remove the
graph_is_commit_finished() check in the loop.  I'm not sure it buys us
much and there are still situations that could result in the state
changing to PADDING during the loop if the graph API is used in an
unexpected way.

Are others convinced that this change is always safe?


John
