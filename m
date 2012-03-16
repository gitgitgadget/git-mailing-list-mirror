From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for
 push.default
Date: Fri, 16 Mar 2012 22:48:32 +0100
Message-ID: <20120316214832.GB25092@ecki>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
 <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
 <20120316085152.GA22273@ecki>
 <vpq1uosswwz.fsf@bauges.imag.fr>
 <7vy5r0iwdb.fsf@alter.siamese.dyndns.org>
 <vpqhaxohg3n.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 16 22:49:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8f1T-0001O8-Gz
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 22:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758363Ab2CPVtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 17:49:14 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:15206 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758314Ab2CPVtO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 17:49:14 -0400
Received: from localhost (p5B22F52F.dip.t-dialin.net [91.34.245.47])
	by bsmtp.bon.at (Postfix) with ESMTP id 4F14D10013;
	Fri, 16 Mar 2012 22:45:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <vpqhaxohg3n.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193284>

On Fri, Mar 16, 2012 at 01:42:36PM +0100, Matthieu Moy wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> >
> >> I'd count "upstream is not set" as "current and upstream agree on
> >> 'current'". IOW, use "current", but error out if there's a configured
> >> upstream that is different.
> >
> > And if there is no configured upstream, should it error out, or should it
> > just push the current one to its own name?
> 
> I meant just push the current one to its own name.

Altough in a somewhat rarer case, this has the same problem as
"current":

git checkout -b master origin/master
git checkout -b topic master
git push

If a branch called topic already exists on origin, push will now try to
update it with the local branch topic. But they do not have any clear
connection, except for the name.

Clemens
