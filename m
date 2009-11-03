From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Re: Gitk --all error when there are more than 797 refs
 in a repository
Date: Tue, 3 Nov 2009 20:40:17 +1100
Message-ID: <19183.64129.695745.269570@cargo.ozlabs.ibm.com>
References: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com>
	<878wgcbb52.fsf@users.sourceforge.net>
	<19124.8378.975976.347711@cargo.ozlabs.ibm.com>
	<6F87406399731F489FBACE5C5FFA0458518DE8@ex2k.bankofamerica.com>
	<4AB78910.7010402@viscovery.net>
	<6F87406399731F489FBACE5C5FFA0458518E11@ex2k.bankofamerica.com>
	<4AB7A2E7.5000601@viscovery.net>
	<874oqvc0n3.fsf@users.sourceforge.net>
	<19129.24056.422939.880134@cargo.ozlabs.ibm.com>
	<7vd45io7da.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"Murphy\, John" <john.murphy@bankofamerica.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 10:44:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Fvx-0005D4-L8
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 10:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150AbZKCJoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 04:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754153AbZKCJoB
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 04:44:01 -0500
Received: from ozlabs.org ([203.10.76.45]:48635 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766AbZKCJoA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 04:44:00 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id A82F1B7BFD; Tue,  3 Nov 2009 20:44:02 +1100 (EST)
In-Reply-To: <7vd45io7da.fsf@alter.siamese.dyndns.org>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131957>

Junio C Hamano writes:

> Paul Mackerras <paulus@samba.org> writes:
> 
> > If git log had an argument to tell it to mark those commits that were
> > a starting point or a finishing point, then I could simplify this
> > logic enormously, plus we wouldn't have to pass a long parameter list
> > to git log.  It may still turn out to be necessary to add a negative
> > argument for each previous starting point, though, when refreshing the
> > list.
> >
> > I think the simplest fix for now is to arrange to take the
> > non-optimized path on windows when the list of revs gets too long,
> > i.e., set $vcanopt($view) to 0 and take that path.  That means that
> > refreshing the view will be slow, but I think it's the best we can do
> > at this point.
> 
> Hmph.
> 
> The negative ones you can learn by giving --boundary, but I do not think
> the set of starting points are something you can get out of log output.
> 
> Even if you could, you would have the same issue giving them from the
> command line anyway.  The right solution would likely to be to give the
> same --stdin option as rev-list to "git log", I think.

A --stdin option to git log would be great, but it doesn't seem to be
implemented yet.  How hard would it be to add?

Paul.
