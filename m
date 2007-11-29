From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] cvsimport: miscellaneous packed-ref fixes
Date: Thu, 29 Nov 2007 09:19:38 -0500
Message-ID: <20071129141938.GB32670@coredump.intra.peff.net>
References: <20071128185504.GA11236@coredump.intra.peff.net> <20071128185628.GC11320@coredump.intra.peff.net> <7vsl2pzxdf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Emanuele Giaquinta <e.giaquinta@glauco.it>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 15:20:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxkFF-0007qF-5C
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 15:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761701AbXK2OTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 09:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761421AbXK2OTl
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 09:19:41 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4484 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761314AbXK2OTk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 09:19:40 -0500
Received: (qmail 19439 invoked by uid 111); 29 Nov 2007 14:19:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 29 Nov 2007 09:19:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2007 09:19:38 -0500
Content-Disposition: inline
In-Reply-To: <7vsl2pzxdf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66535>

On Wed, Nov 28, 2007 at 04:52:28PM -0800, Junio C Hamano wrote:

> > @@ -998,7 +996,7 @@ if ($orig_branch) {
> >  	$orig_branch = "master";
> >  	print "DONE; creating $orig_branch branch\n" if $opt_v;
> >  	system("git-update-ref", "refs/heads/master", "$remote/$opt_o")
> > -		unless -f "$git_dir/refs/heads/master";
> > +		defined get_headref('refs/heads/master');
> 
> Where did the unless go ;-)?

Bah, I even ran this through the test suite, but obviously forgot a
'make' in the middle.

> Thanks, queued.

Thanks. Sorry for all the mistakes; I think I made more work in catching
my errors than went into the original patch series. ;)

-Peff
