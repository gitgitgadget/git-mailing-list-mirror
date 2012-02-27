From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 0/2] git-p4: fix submit regression with --use-client-spec
Date: Sun, 26 Feb 2012 19:25:14 -0500
Message-ID: <20120227002514.GA31028@padd.com>
References: <1330218385-22309-1-git-send-email-pw@padd.com>
 <7vhaydcenz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Laurent =?iso-8859-1?Q?Charri=E8re?= <lcharriere@promptu.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 01:25:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1oP8-0006se-3B
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 01:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109Ab2B0AZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 19:25:20 -0500
Received: from honk.padd.com ([74.3.171.149]:38561 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752381Ab2B0AZT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 19:25:19 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 96F9124A6;
	Sun, 26 Feb 2012 16:25:18 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 49E195A906; Sun, 26 Feb 2012 19:25:15 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vhaydcenz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191588>

gitster@pobox.com wrote on Sun, 26 Feb 2012 16:18 -0800:
> Pete Wyckoff <pw@padd.com> writes:
> 
> > This pair of patches fixes a regression that happened with ecb7cf9
> > (git-p4: rewrite view handling, 2012-01-02).  There are two factors that
> > affect where files go in the client when submitting:  the cilent spec,
> > and the depot path.  When the depot path was not exactly the root of
> > the client, submit fails.
> >
> > Fix this by always using the true client root.  And also notice that
> > somebody has to tell the submit path that it should be looking at the
> > cilent spec.  Save useClientSpec in a configuration variable if it
> > was specified as an option on the command line.
> >
> > Junio: can you put this on maint to go out with the next 1.9.x?
> 
> Surely and thanks.
> 
> Your "p4: submit with wildcards" seems to conflict with this change and
> may need to be rebased, though.

Ah, yes.  The conflicting chunks can be added in any order above
class P4Command.  I'll rebase and resend in a few days, after
waiting for review comments.

		-- Pete
