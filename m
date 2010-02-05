From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH 2/3] silence human readable info messages going to
 stderr from git push --porcelain
Date: Fri, 5 Feb 2010 15:30:45 -0500
Message-ID: <20100205203045.GA1937@cthulhu>
References: <20100205150638.GB14116@coredump.intra.peff.net>
 <1265398462-17316-2-git-send-email-larry@elder-gods.org>
 <7v1vgz5ta7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 21:31:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdUpR-0007ZQ-Rk
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 21:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757059Ab0BEUas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 15:30:48 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:54486 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772Ab0BEUap (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 15:30:45 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 1025A822180; Fri,  5 Feb 2010 15:30:45 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v1vgz5ta7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139080>

* Junio C Hamano (gitster@pobox.com) [100205 15:20]:
> > -		if (!quiet && !ret && !refs_pushed(remote_refs))
> > +		if (!quiet && !porcelain && !ret && !refs_pushed(remote_refs))
> >  			fprintf(stderr, "Everything up-to-date\n");
> 
> This is a borderline.  If you are truly up-to-date, the calling script
> won't get anything.  It may be easier for Porcelain scripts to see this
> message on the standard output as an explicit succeses report instead.

how about this?

if (!quiet && (!porcelain || verbose) && !ret && !refs_pushed(remote_refs))
   fprintf(stderr, "Everything up-to-date\n");     

   --larry



   
