From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Re: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Wed, 16 Apr 2008 20:23:38 +0400
Message-ID: <20080416162338.GD3133@dpotapov.dyndns.org>
References: <200804161334.17748.brian.foster@innova-card.com> <a537dd660804160448w5ba28f13m8c081ebc2a71db91@mail.gmail.com> <20080416121424.GA3133@dpotapov.dyndns.org> <20080416145900.GA10777@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Foster <brian.foster@innova-card.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Apr 16 18:44:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmAR3-000517-Fp
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 18:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756716AbYDPQXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 12:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755556AbYDPQXs
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 12:23:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:9916 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbYDPQXr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 12:23:47 -0400
Received: by nf-out-0910.google.com with SMTP id g13so739645nfb.21
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 09:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=lY/k1J5VCGkl7FW+Cv8WiC6gg9SRAISFhyQE2qUHUYs=;
        b=I0r844U3AR5BJt2gVBVhTWvlC2MNegxvkamcPs0IzwTSYT3taB6XZQA00TkNXvz1yvyKEs5AGlIOrYYpXiW7p30sZ/NBecG6pWS3goTiKcpEWSAs6MSdgarT84FhYxPvnyNd9FA9qV6mG+zkvgoIU/FQrtaXafRTdhi4tF1RVSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=LFVk6KwOGaV/ziit+gWe6v5AKy2oAqUobsssVZ1UI+DM8dk2fVbHigCwrWL8ZHMeb59SMwxvevlN5EzT2DuNUJK3n3ee37ykkFgEnw2aalmMjM1DHe+Gzubs1V8njm1V5RKABwfk71SqPddZzNWqs4hgEDsETXNuaeAZ85qgX54=
Received: by 10.78.137.14 with SMTP id k14mr328820hud.103.1208363023230;
        Wed, 16 Apr 2008 09:23:43 -0700 (PDT)
Received: from localhost ( [85.141.188.158])
        by mx.google.com with ESMTPS id h4sm13901701nfh.8.2008.04.16.09.23.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Apr 2008 09:23:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080416145900.GA10777@machine.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79717>

On Wed, Apr 16, 2008 at 04:59:00PM +0200, Petr Baudis wrote:
> On Wed, Apr 16, 2008 at 04:14:24PM +0400, Dmitry Potapov wrote:
> > info/grafts should never be used during normal work.
> 
> I don't really agree with this advice in general. Grafts can be very
> useful especially when migrating to Git

I agree that they can be very useful in the process of migrating, but
I would not recommend to leave them _after_ the migration process is
complete.

> The _BAD_ grafts are those that replace list of commit's parents instead
> of just appending (typically to an empty one). I didn't actually have
> any idea people use grafts in such a twisted and perverse way... ;-)

They are used to replace _BAD_ commits imported from CVS. History in
CVS can be very strange and even with best conversation tools, you may
end up with something not exactly what you want. So, you want to replace
some commits with corrected versions of them. So, you add those commits
to Git repo, "fix" history, and then using gitk check that now you have
exactly what you want. If now the history is okay then you can use
git filter-branch to make those changes real.

Dmitry
